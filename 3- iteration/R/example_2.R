library(caret)
library(tidyverse)

# Pre-trained models
glm <- read_rds("models/glm_8.rds")
nnet <- read_rds("models/nnet_8.rds")
rpart <- read_rds("models/rpart_8.rds")
xgb <- read_rds("models/xgb_8.rds")

# Test set to make predictions
test <- read_csv("data/grade_8.csv") %>%
    filter(cohort == 2012)

predictors <- c("absences", "enrollments", "expulsions", "suspensions",
    "math", "read", "school_math", "school_read")

test_x <- test[predictors]
test_y <- factor(test$ready_grad)

# Models were trained on centered/scaled data
# Center and scale test predictors
test_preprocess <- preProcess(test_x, method = c("center", "scale"))

test_x <- predict(test_preprocess, test_x)

model_list <- list(
    "glm" = glm,
    "nnet" = nnet,
    "rpart" = rpart,
    "xgb" = xgb
)

# Accuracy
model_list %>%
    map(.f = predict, test_x) %>%
    map(.f = ~ . == test_y) %>%
    map_dbl(mean)

# AUC
model_list %>%
    map(.f = predict, test_x, type = "prob") %>%
    map("ready") %>%
    map_dbl(.f = ~ yardstick::roc_auc_vec(truth = test_y, estimate = .))
