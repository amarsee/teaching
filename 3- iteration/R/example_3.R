library(caret)
library(tidyverse)

model_list <- list(
    "grade_6" = read_rds("models/nnet_6.rds"),
    "grade_7" = read_rds("models/nnet_7.rds"),
    "grade_8" = read_rds("models/nnet_8.rds")
)

test_list <- list(
    "test_6" = read_csv("data/grade_6.csv") %>% filter(cohort == 2012),
    "test_7" = read_csv("data/grade_7.csv") %>% filter(cohort == 2012),
    "test_8" = read_csv("data/grade_8.csv") %>% filter(cohort == 2012)
)

preprocess_test <- function(cohort) {

    predictors <- c("absences", "enrollments", "expulsions", "suspensions",
        "math", "read", "school_math", "school_read")

    x <- cohort[predictors]

    train_preprocess <- preProcess(x, method = c("center", "scale"))

    predict(train_preprocess, x)

}

test_x <- map(.x = test_list, .f = preprocess_test)
test_y <- map(.x = test_list, .f = "ready_grad")

map2(.x = model_list, .y = test_x, predict) %>%
    map2(.x = ., .y = test_y, .f = ~ .x == .y) %>%
    map_dbl(mean)
