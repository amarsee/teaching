## Shiny App Example
# server.R

shinyServer(function(input, output, session) {

    # Adjust color, opacity of highlighted district
    df_highlight <- reactive({

        # Assign State different color, opacity
        df <- df %>%
            mutate(Region = ifelse(system_name == "State of Tennessee", "State", Region),
                opacity = ifelse(system_name == "State of Tennessee", 1, 0.4))

        # Highlight selected district, fade all other points
        if (input$highlight != "State of Tennessee") {
            df[df$system_name == input$highlight, ]$opacity <- 1
            df[df$system_name != input$highlight & df$system_name != "State of Tennessee", ]$opacity <- 0.2
        }

        # Filter for missing data based on inputted outcome
        df[!is.na(df[names(df) == input$outcome]), ]

    })

    # Create tooltip with district name, selected x and y variables
    tooltip_scatter <- function(x) {
        if (is.null(x)) return(NULL)

        row <- df[df$system_name == x$system_name, ]

        paste0("<b>", row$system_name, "</b><br>",
            row$Region, "<br>",
            names(district_char)[district_char == input$char], ": ", row[names(row) == input$char], "<br>",
            names(district_out)[district_out == input$outcome], ": ", row[names(row) == input$outcome])
    }

    # Update highlighted district on point click
    click_district <- function(data, ...) {
        updateSelectInput(session, "highlight", selected = as.character(data$system_name))
    }

    # Scatterplot of district characteristic X outcome
    plot <- reactive({

        # Axis Labels
        xvar_name <- names(district_char)[district_char == input$char]
        yvar_name <- names(district_out)[district_out == input$outcome]

        # Convert input (string) to variable name
        xvar <- prop("x", as.symbol(input$char))
        yvar <- prop("y", as.symbol(input$outcome))

        # Scale vertical axis to [0, 100] if outcome is a %P/A, otherwise, scale to min/max of variable
        if (grepl("Percent Proficient or Advanced", yvar_name)) {
            y_scale <- c(0, 100)
        } else {
            y_scale <- c(min(df_highlight()[names(df_highlight()) == input$outcome]), 
                ceiling(max(df_highlight()[names(df_highlight()) == input$outcome])))
        }

        df_highlight() %>%
            ggvis(xvar, yvar, key := ~system_name) %>%
            layer_points(fill = ~Region, size := 125, size.hover := 300,
                opacity = ~opacity, opacity.hover := 0.8) %>%
            add_axis("x", title = xvar_name, grid = FALSE) %>%
            add_axis("y", title = yvar_name, grid = FALSE) %>%
            scale_numeric("y", domain = y_scale) %>%
            add_tooltip(tooltip_scatter, on = "hover") %>%
            scale_numeric("opacity", range = c(min(df_highlight()$opacity), 1)) %>%
            scale_nominal("fill", range = c('#000000', '#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', '#ffff33', '#a65628', '#f781bf')) %>%
            set_options(width = 'auto', height = 700) %>%
            handle_click(click_district)

    })

    plot %>% bind_shiny("plot")

    }
)