## Shiny App Example
# ui.R

shinyUI(navbarPage("Data Explorer", position = "fixed-top",

    tabPanel("District",
        fluidPage(
            fluidRow(
                br(),
                br(),
                br(),
                column(8, offset = 2,
                    ggvisOutput("plot")
                )
            ),
            fluidRow(
                column(8, offset = 2,
                    hr()
                )
            ),
            fluidRow(
                column(4, offset = 2,
                    selectInput("char", label = "Select a District Characteristic:", 
                                choices = district_char, selected = "Pct_ED", width = 500),
                    selectInput("highlight", label = "Optional: Highlight a District", 
                                choices = district_list, selected = NULL, width = 500)
                ),
                column(4,
                    selectInput("outcome", label = "Select an Outcome:", 
                                choices = district_out, selected = "Math", width = 500)
                )
            )
        ) 
    )
))