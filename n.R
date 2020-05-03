n_us <- n_us <- sum(
  ifelse(
    nasa_fireball$lat < 64.9 & nasa_fireball$lat > 19.5
    & nasa_fireball$lon < -68.0 & nasa_fireball$lon > -161.8,
    1, 0),
  na.rm = TRUE)

server <- function(input, output) {
  output$us_box <- renderValueBox(
    
    value = n_us,
    subtitle = "Number of Fireballs in the US",
    icon = icon("globe"),
    color = if (n_us < 10) {
      "blue"
    } else {
      "fuchsia"
    }
  )
}

body <- dashboardBody(
  fluidRow(
    valueBoxOutput("us_box")
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)