
library(shiny)


shinyUI(fluidPage(

    # Application title
    titlePanel("Validate Central Limit Theorem using Simulation"),

    # Sidebar with text, select box, slider and check box
    sidebarLayout(
        sidebarPanel(
            helpText("Please decide your original distribution, the sample size 
                     and the number of simulation you want to perform."),
            
            selectInput("fx", h3("Distribution:"), 
                        choices = list("Normal Distribution" = 1, 
                                       "Poisson Distribution" = 2,
                                       "Uniform Distribution" = 3,
                                       "Binomial Distribution" = 4), selected = 1),
            
            sliderInput("n",
                        "Sample size (n):",
                        min = 5, max = 50, value = 20),
            
            sliderInput("B",
                        "Number of Simulation (B):",
                        min = 5, max = 1000, value = 500),
            
            checkboxInput("showod", "Show/Hide the (average of) the sample mean", value = TRUE),
            
            checkboxInput("shownorm", "Show/Hide the density plot of a normal distribution", value = TRUE),
            
            submitButton("Submit")
        ),

        # Show two plots with the generated distribution
        mainPanel(
            fluidRow(
                splitLayout(cellWidths = c("50%", "50%"), 
                            plotOutput("Plot1"), 
                            plotOutput("Plot2"))
            )
        )
    )
))
