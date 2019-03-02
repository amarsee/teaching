library(tidyverse)

districts <- read_csv("data/districts.csv")

## Exercise 1
# Use filter() to find the number of districts with a 100% Algebra I proficiency rate.



## Exercise 2
# Create a new column called `math_achievement` with a value of:
#     * `"High"` if a district's Math proficiency is 75% or higher;
#     * `"Medium"` if a district's Math proficiency is between 50% and 75%;
#     * `"Low"` if a district's Math proficiency is below 50%.



## Exercise 3
# Filter down to district 792 (Shelby County), then pipe the result to `View()`.



## Exercise 4
# Do the following in one sequence of function calls, piped together:
# 1. Read in the `data/tvaas.csv` file.
# 2. Rename columns as follows:
#     * `District Number` to `system`.
#     * `Composite` to `TVAAS Composite`.
#     * `Literacy` to `TVAAS Literacy`.
#     * `Numeracy` to `TVAAS Numeracy`.
# 3. Drop the `District Name` column.



## Exercise 5
# Sort alphabetically by region, then by Algebra I proficiency in descending order.
# Then, keep just the district name, Algebra I proficiency, and region columns.



## Exercise 6
# Use `summarise()` to find the mean, minimum, and maximum district grad rate.
# Assign column names to the resulting data frame.



## Exercise 7
# Identify districts with a higher Percent ED than the median district, and a
# higher Math proficiency than the median district.



# Exercise 8
# Identify districts with a higher dropout rate than the average of districts
# in the same region.



## Exercise 9
# Create three columns:
#    * A district's average proficiency in math subjects (Math, Algebra I-II)
#    * A district's average proficiency in English subjects (ELA, English I-III)
#    * A district's average proficiency in science subjects (Science, Biology, Chemistry)
# Then, reorder columns such that:
#    * The math average is next to the individual math columns.
#    * The English average is next to the individual English columns.
#    * The science average is next to the individual science columns.



## Exercise 10
# Create a data frame with the number of districts at each TVAAS level, by region.



## Exercise 11
# Reshape the `tvaas` data frame long by subject, then arrange by system.


