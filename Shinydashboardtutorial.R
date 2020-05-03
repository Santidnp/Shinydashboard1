install.packages("shiny")
install.packages("shinydashboard")
library(shiny)
library(shinydashboard)
library(dplyr)
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
      text = "Debo acostarme mas temprano",
      icon = icon("rocket")
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
  ),
  sliderInput(
    inputId = "height",
    label = "Height",
    min=66,
    max=264,
    value = 264
  ),
  selectInput(
    inputId = "name",
    label = "Name",
    choices = starwars$name
  ),
  actionButton("click","Update click box")
)
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            tabBox(
              title = "International Space Station Fun Facts",
              tabPanel("Fun fact1"),
              tabPanel("Fun fact2")
            )),
    tabItem(tabName = "inputs")
  ),
  textOutput("name"),
  valueBoxOutput("click_box")
)


ui <- dashboardPage(skin = "purple",header,sidebar,body)



server <- function(input, output, session) {
  starwars <- dplyr::starwars
  output$click_box <- renderValueBox({
    valueBox(
      input$click, 
      "Click Box"
    )
  })
  
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
