library("shiny")

body <- dashboardBody(
  fluidRow(
    
    box(
      width = 12,
      title = "Regular Box, Row 1",
      "Star Wars"
    )
    ,
    
    box(
      width = 12,
      title = "Regular Box, Row 2",
      "Nothing but Star Wars"
      
    )
  )
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)

shinyApp(ui, server)
