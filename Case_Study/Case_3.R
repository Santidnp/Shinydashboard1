library(shiny)

# Define UI for the application
ui <- fluidPage(
  # Create a numeric input with ID "age" and label of
  # "How old are you?"
  numericInput("age","How old are you?", value = 20),
  
  # Create a text input with ID "name" and label of 
  # "What is your name?"
  textInput("name", "What is your name?")
)

# Define the server logic
server <- function(input, output) {}

# Run the application
shinyApp(ui = ui, server = server)