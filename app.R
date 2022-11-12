#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)
boston_cocktails <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv') %>%
  mutate(ingredient = str_remove(ingredient, ",.*$"))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          helpText("Recipes to create drinks based on ingredients"),
          
          selectInput("ingredients", 
                      label = "Choose ingredient:",
                      choices = unique(boston_cocktails$ingredient),
                      selected = "Light Rum"),
        ),
        mainPanel(
           dataTableOutput("recipes")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$recipes <- renderDataTable({
        x<-filter(boston_cocktails, ingredient==input$ingredients)
        #y<-x$name
        print(x)
        #print(y)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)