library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(googleVis)
library(leaflet)

ach_profile <- read_csv("achievement_profile_data_with_CORE.csv") %>%
    select(one_of(c("system_name", "Enrollment", "Per_Pupil_Expenditures", "Pct_BHN", "Pct_ED", "Pct_SWD", "Pct_EL",
                    "ELA", "Math", "Science", "AlgI", "AlgII", "BioI", "Chemistry", "EngI", "EngII", "EngIII"))) %>%
    rename("District" = system_name) %>%
    filter(complete.cases(.)) %>%
    mutate(District = ifelse(District == "State of Tennessee", "State", District))

geocode <- read_csv("district_location_geocode.csv")

districts_list <- unique(ach_profile$District)[-1]

for (d in districts_list) {

    district_data <- filter(ach_profile, District == "State" | District == d)

    rmarkdown::render("presentations_loop_example.Rmd",
                      output_file = paste(d, "District Performance Presentation.html"),
                      output_dir = "output")

}
