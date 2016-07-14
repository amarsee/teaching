library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

ach_profile <- read_csv("achievement_profile_data.csv") %>%
    select(one_of(c("system_name", "Enrollment", "Per_Pupil_Expenditures",
                    "Pct_BHN", "Pct_ED", "Pct_SWD", "Pct_EL",
                    "ELA", "Math", "Science", "AlgI", "AlgII", "BioI", "Chemistry", "EngI", "EngII", "EngIII"))) %>%
    rename("District" = system_name) %>%
    filter(complete.cases(.))

state_profile <- read_csv("achievement_profile_data.csv") %>%
    select(one_of(c("system_name", "Enrollment", "Per_Pupil_Expenditures",
                    "Pct_BHN", "Pct_ED", "Pct_SWD", "Pct_EL",
                    "ELA", "Math", "Science", "AlgI", "AlgII", "BioI", "Chemistry", "EngI", "EngII", "EngIII"))) %>%
    rename("District" = system_name) %>%
    filter(District == "State of Tennessee") %>%
    bind_rows(ach_profile)

state_profile[state_profile$District == "State of Tennessee", ]$District <- "State"

districts_list <- unique(ach_profile$District)

for (d in districts_list) {

    district_data <- filter(state_profile, District == "State" | District == d)

    rmarkdown::render("document_loop_example.Rmd",
                      output_file = paste(d, "District Performance Report.docx"),
                      output_dir = "output")

}
