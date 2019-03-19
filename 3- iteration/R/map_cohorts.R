library(caret)
library(tidyverse)

# Read in cohorts
grades <- dir("data", pattern = "grade_", full.names = TRUE) %>%
    map(read_csv)

# Split cohorts into training and test sets
train_sets <- grades %>%
    map(.f = ~ filter(., cohort == 2011))

test_sets <- grades %>%
    map(.f = ~ filter(., cohort == 2012))

preprocess_features <- function(cohort) {

    predictors <- c("absences", "enrollments", "expulsions", "suspensions",
        "math", "read", "school_math", "school_read")

    train_x <- cohort[predictors]

    center_scale <- preProcess(train_x, method = c("center", "scale"))

    train_x <- predict(center_scale, train_x)
}

train_nnet <- function(x, y) {

    train(x = x, y = y, method = "nnet", metric = "ROC",
        trControl = trainControl(classProbs = TRUE)
    )

}

# Fit a neural net on each training set
model_list <- map(.x = train_sets, .f = preprocess_features) %>%
    map2(.x = ., .y = map(train_sets, "ready_grad"), .f = train_nnet)

# Evaluate predictions
test_sets %>%
    map(preprocess_features) %>%
    map2(.x = model_list, .y = ., .f = predict) %>%
    map2(.x = ., .y = map(test_sets, "ready_grad"), .f = ~ .x == .y) %>%
    map_dbl(mean)

# Export models
walk2(
    .x = model_list,
    .y = paste0("models/", names(model_list), "_8.rds"),
    .f = write_rds
)
