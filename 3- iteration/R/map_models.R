library(zeallot)
library(caret)
library(tidyverse)

# Read in cohorts
grade_8 <- read_csv("data/grade_8.csv")

c(train_set, test_set) %<-% split(grade_8, grade_8$cohort)

# Preprocess train and test sets
predictors <- c("absences", "enrollments", "expulsions", "suspensions",
    "math", "read", "school_math", "school_read")

train_x <- train_set[predictors]
test_x <- test_set[predictors]

train_preprocess <- preProcess(train_x, method = c("center", "scale"))

train_x <- predict(train_preprocess, train_x)
test_x <- predict(train_preprocess, test_x)

train_y <- factor(train_set$ready_grad)
test_y <- factor(test_set$ready_grad)

train_controls <- trainControl(
    savePredictions = "final",
    classProbs = TRUE,
    search = "random"
)

# A few models
model_list <- list(
    "glm" = train(x = train_x, y = train_y, method = "glm", family = "binomial",
        metric = "ROC", trControl = train_controls),
    "rpart" = train(x = train_x, y = train_y, method = "rpart",
        metric = "ROC", trControl = train_controls),
    "nnet" = train(x = train_x, y = train_y, method = "nnet",
        metric = "ROC", trControl = train_controls),
    "xgb" = train(x = train_x, y = train_y, method = "xgbTree", tuneLength = 50,
        metric = "ROC", trControl = train_controls)
)

# Evaluate predictions
map(.x = model_list, .f = predict, test_x) %>%
    map(~ . == test_y) %>%
    map_dbl(mean)

# Export models
walk2(
    .x = model_list,
    .y = paste0("models/", names(model_list), "_8.rds"),
    .f = write_rds
)
