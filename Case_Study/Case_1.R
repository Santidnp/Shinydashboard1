# Load the shiny package
library(shiny)

# Define UI for the application
ui <- fluidPage(
  # "DataCamp" as a primary header
  h1("DataCamp"),
  # "Shiny use cases course" as a secondary header
  h2("Shiny use cases course"),
  # "Shiny" in italics
  em("Shiny"),
  # "is fun" as bold text
  strong("is fun")
)

# Define the server logic
server <- function(input, output) {}

# Run the application
shinyApp(ui = ui, server = server)