library(tidyverse)

districts <- read_csv("data/districts.csv")

## Exercise 1
# Use filter() to find the number of districts with a 100% Algebra I proficiency rate.

filter(districts, alg_1 == 100)

## Exercise 2
# Create a new column called `math_achievement` with a value of:
#     * `"High"` if a district's Math proficiency is 75% or higher;
#     * `"Medium"` if a district's Math proficiency is between 50% and 75%;
#     * `"Low"` if a district's Math proficiency is below 50%.

mutate(districts,
    math_achievement = if_else(math >= 75, "High", NA_character_),
    math_achievement = if_else(math >= 50 & math < 75, "Medium", math_achievement),
    math_achievement = if_else(math < 50, "Low", math_achievement))

## Exercise 3
# Filter down to district 792 (Shelby County), then pipe the result to `View()`.

districts %>%
    filter(system == 792) %>%
    View()

## Exercise 4
# Do the following in one sequence of function calls, piped together:
# 1. Read in the `data/tvaas.csv` file.
# 2. Rename columns as follows:
#    * `District Number` to `system`.
#    * `Composite` to `TVAAS Composite`.
#    * `Literacy` to `TVAAS Literacy`.
#    * `Numeracy` to `TVAAS Numeracy`.
# 3. Drop the `District Name` column.

tvaas <- read_csv("data/tvaas.csv") %>%
    rename(system = `District Number`,
        `TVAAS Composite` = `Composite`,
        `TVAAS Literacy` = `Literacy`,
        `TVAAS Numeracy` = `Numeracy`) %>%
    select(-`District Name`)

## Exercise 5
# Sort alphabetically by region, then by Algebra I proficiency in descending order.
# Then, keep just the district name, Algebra I proficiency, and region columns.

districts %>%
    arrange(region, desc(alg_1)) %>%
    select(system_name, alg_1, region)

## Exercise 6
# Use `summarise()` to find the mean, minimum, and maximum district grad rate.
# Assign column names to the resulting data frame.

districts %>%
    filter(system_name != "State of Tennessee") %>%
    summarise(
        mean_grad = mean(grad, na.rm = TRUE),
        min_grad = min(grad, na.rm = TRUE),
        max_grad = max(grad, na.rm = TRUE)
    )

## Exercise 7
# Identify districts with a higher Percent ED than the median district, and a
# higher Math proficiency than the median district.

districts %>%
    filter(system_name != "State of Tennessee") %>%
    mutate(
        median_ed = median(ed, na.rm = TRUE),
        median_math = median(math, na.rm = TRUE)) %>%
    filter(ed > median_ed & math > median_math) %>%
    select(system, system_name, math, median_math)

# Exercise 8
# Identify districts with a higher dropout rate than the average of districts
# in the same region.

districts %>%
    group_by(region) %>%
    mutate(dropout_mean = mean(dropout, na.rm = TRUE)) %>%
    ungroup() %>%
    filter(dropout > dropout_mean) %>%
    select(system_name, region, dropout, dropout_mean)

## Exercise 9
# Create three columns:
#    * A district's average proficiency in math subjects (Math, Algebra I-II)
#    * A district's average proficiency in English subjects (ELA, English I-III)
#    * A district's average proficiency in science subjects (Science, Biology, Chemistry)
# Then, reorder columns such that:
#    * The math average is next to the individual math columns.
#    * The English average is next to the individual English columns.
#    * The science average is next to the individual science columns.

districts %>%
    rowwise() %>%
    mutate(
        math_avg = mean(c(math, alg_1, alg_2), na.rm = TRUE),
        eng_avg = mean(c(ela, eng_1, eng_2, eng_3), na.rm = TRUE),
        sci_avg = mean(c(science, bio, chem), na.rm = TRUE)) %>%
    select(system, system_name, math, alg_1, alg_2, math_avg,
        ela, eng_1, eng_2, eng_3, eng_avg, science, bio, chem, sci_avg)

## Exercise 10
# Create a data frame with the number of districts at each TVAAS level, by region.

districts %>%
    inner_join(tvaas, by = "system") %>%
    mutate(Level1 = if_else(`TVAAS Composite` == 1, 1, 0),
        Level2 = if_else(`TVAAS Composite` == 2, 1, 0),
        Level3 = if_else(`TVAAS Composite` == 3, 1, 0),
        Level4 = if_else(`TVAAS Composite` == 4, 1, 0),
        Level5 = if_else(`TVAAS Composite` == 5, 1, 0)) %>%
    group_by(region) %>%
    summarise(Level1 = sum(Level1, na.rm = TRUE),
        Level2 = sum(Level2, na.rm = TRUE),
        Level3 = sum(Level3, na.rm = TRUE),
        Level4 = sum(Level4, na.rm = TRUE),
        Level5 = sum(Level5, na.rm = TRUE)) %>%
    ungroup()

# More succinctly:

districts %>%
    inner_join(tvaas, by = "system") %>%
    group_by(region, `TVAAS Composite`) %>%
    count() %>%
    ungroup()

# If you want it wide by TVAAS level as before

districts %>%
    inner_join(tvaas, by = "system") %>%
    group_by(region, `TVAAS Composite`) %>%
    count() %>%
    ungroup() %>%
    spread(`TVAAS Composite`, n)

## Exercise 11
# Reshape the tvaas data frame long by subject.

tvaas %>%
    gather(subject, score, `TVAAS Composite`:`TVAAS Numeracy`) %>%
    arrange(system)
