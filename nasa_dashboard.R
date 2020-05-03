library("shiny")
max_vel <- max(nasa_fireball$vel, na.rm = TRUE)
max_impact_e <- max(nasa_fireball$energy)
body <- dashboardBody(
  fluidRow(
    # Add a value box for maximum impact
    valueBox(
      value = max_impact_e, 
      subtitle = "Maximum impact energy (kilotons of TNT)",
      icon = icon("star")
    ),
    valueBox(
      value = max_vel,
      subtitle = "Maximum pre-impact velocity", 
      icon = icon("fire")
    )
  )
)


ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)
shinyApp(ui, server)