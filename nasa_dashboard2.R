n_us <- n_us <- sum(
  ifelse(
    nasa_fireball$lat < 64.9 & nasa_fireball$lat > 19.5
    & nasa_fireball$lon < -68.0 & nasa_fireball$lon > -161.8,
    1, 0),
  na.rm = TRUE)

server <- function(input, output) {
  output$us_box <- renderValueBox({
    valueBox(
      value = n_us,
      subtitle = "Number of Fireballs in the US",
      icon = icon("globe"),
      color = if (n_us < input$threshold) {
        "blue"
      } else {
        "fuchsia"
      }
    )
  })
}


body <- dashboardBody(
  fluidRow(
    valueBoxOutput("us_box")
  )
)

sidebar <- dashboardSidebar(
  
  sliderInput(
    
    inputId = "threshold",
    label = "Color Threshold",
    min = 0,
    max = 100,
    value = 10
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = sidebar,
                    body = body
)
shinyApp(ui, server)