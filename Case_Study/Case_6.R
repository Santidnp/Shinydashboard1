ui <- fluidPage(
  numericInput("num1", "Number 1", 5),
  numericInput("num2", "Number 2", 10),
  textOutput("result")
)

server <- function(input, output) {
  # Calculate the sum of the inputs
  my_sum <- reactive({
    input$num1 + input$num2
  })
  
  # Calculate the average of the inputs
  my_average <- reactive({
    my_sum() / 2
  })
  
  output$result <- renderText({
    paste(
      # Print the calculated sum
      "The sum is", my_sum(),
      # Print the calculated average
      "and the average is", my_average()
    )
  })
}

shinyApp(ui, server)