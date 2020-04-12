install.packages("shiny")
install.packages("shinydashboard")
library(shiny)
library(shinydashboard)
header <- dashboardHeader(
  dropdownMenu(
    type = "message",
    messageItem(
      from = "Santiago",
      message = "Hola como estas",
      href = "https://spotthestation.nasa.gov/sightings/"
    ),
    messageItem(
      from = "Lau",
      message = "Hola que tal la fiesta",
      href = "https://spotthestation.nasa.gov/sightings/"
    )
  ),
  dropdownMenu(
        type = "tasks",
         taskItem(
           text="Mission Learn Shiny Dashboard",
           value = 10
         )
      ),
  dropdownMenu(
    type = "notifications",
    notificationItem(
      text = "Debo acostarme mas temprano"
    )
  )
  
)
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Datos",
             tabName = "datos"
      
    ),
    menuItem( "Dashboard",
              tabName = "dashboard"),
    menuItem("Inputs",
             tabName = "inputs"
      
    )
  )
)
body <- dashboardBody(
  tabItem( tabName = "Datos"),
  tabItem(tabName = "inputs")
)


ui <- dashboardPage(header,sidebar,body)



server <- function(input, output, session) {
  
}

shinyApp(ui, server)



# header <- dashboardHeader(
#   # Create a tasks drop down menu
#   dropdownMenu(
#     type = "tasks",
#     taskItem(
#       text="Mission Learn Shiny Dashboard",
#       value = 10
#     )
#   )
