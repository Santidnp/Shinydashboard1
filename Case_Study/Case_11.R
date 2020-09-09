library(shiny)
library(gapminder)

ui <- fluidPage(
  h1("Gapminder"),
  # Add a placeholder for a table output
  tableOutput("table")
)

server <- function(input, output) {
  # Call the appropriate render function 
  output$table <- renderTable({
    # Show the gapminder object in the table
    gapminder
  })
}

shinyApp(ui, server)