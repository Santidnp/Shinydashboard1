library(shiny)

# Define UI for the application
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # Create a text input with an ID of "name"
      textInput("name", "What is your name?", "Dean"),
      numericInput("num", "Number of flowers to show data for",
                   10, 1, nrow(iris))
    ),
    mainPanel(
      # Add a placeholder for a text output with ID "greeting"
      textOutput(outputId = "greeting"),
      # Add a placeholder for a plot with ID "cars_plot"
      plotOutput("cars_plot"),
      # Add a placeholder for a table with ID "iris_table"
      tableOutput("iris_table")
    )
  )
)

# Define the server logic
server <- function(input, output) {}

# Run the application
shinyApp(ui = ui, server = server)