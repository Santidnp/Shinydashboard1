library(shiny)
library(gapminder)

ui <- fluidPage(
  h1("Gapminder"),
  sliderInput(inputId = "life", label = "Life expectancy",
              min = 0, max = 120,
              value = c(30, 50)),
  selectInput("continent", "Continent",
              choices = c("All", levels(gapminder$continent))),
  # Add a plot output
  plotOutput("plot"),
  tableOutput("table")
)

server <- function(input, output) {
  output$table <- renderTable({
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
  
  # Create the plot render function  
  output$plot <- renderPlot({
    # Use the same filtered data that the table uses
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
    ggplot(data, aes(gdpPercap, lifeExp)) +
      geom_point() +
      scale_x_log10()
  })
}

shinyApp(ui, server)