library(shiny)
library(gapminder)
library(tidyverse)
ui <- fluidPage(
  h1("Gapminder"),
  # Create a container for tab panels
  tabsetPanel(
    # Create an "Inputs" tab
    tabPanel(
      title = "Inputs",
      sliderInput(inputId = "life", label = "Life expectancy",
                  min = 0, max = 120,
                  value = c(30, 50)),
      selectInput("continent", "Continent",
                  choices = c("All", levels(gapminder$continent))),
      downloadButton("download_data")
    ),
    # Create a "Plot" tab
    tabPanel(
      title = "Plot",
      plotOutput("plot")
    ),
    # Create "Table" tab
    tabPanel(
      title = "Table",
      DT::dataTableOutput("table")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    data <- gapminder
    data <- subset(
      data,
      lifeExp >= input$life[1] & lifeExp <= input$life[2]
    )
    if (input$continent != "All") {
      data <- subset(
        data,
        continent == input$continent
      )
    }
    data
  })
  
  output$table <- DT::renderDataTable({
    data <- filtered_data()
    data
  })
  
  output$download_data <- downloadHandler(
    filename = "gapminder_data.csv",
    content = function(file) {
      data <- filtered_data()
      write.csv(data, file, row.names = FALSE)
    }
  )
  
  output$plot <- renderPlot({
    data <- filtered_data()
    ggplot(data, aes(gdpPercap, lifeExp)) +
      geom_point() +
      scale_x_log10()
  })
}

shinyApp(ui, server)