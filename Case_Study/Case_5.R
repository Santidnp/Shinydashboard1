# Load the shiny package
library(shiny)

# Define UI for the application
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("name", "What is your name?", "Dean"),
      numericInput("num", "Number of flowers to show data for",
                   10, 1, nrow(iris))
    ),
    mainPanel(
      textOutput("greeting"),
      plotOutput("cars_plot"),
      tableOutput("iris_table")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  cars <- datasets::cars
  iris <- datasets::iris
  # Create a plot of the "cars" dataset 
  output$cars_plot <- renderPlot({
    plot(cars)
  })
  
  # Render a text greeting as "Hello <name>"
  output$greeting <- renderText({
    paste("Hello", input$name)
  })
  
  # Show a table of the first n rows of the "iris" data
  output$iris_table <- renderTable({
    data <- iris[1:input$num, ]
    data
  })
}

# Run the application
shinyApp(ui = ui, server = server)