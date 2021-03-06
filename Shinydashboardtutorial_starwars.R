install.packages("shiny")
install.packages("shinydashboard")
library(shiny)
library(shinydashboard)


body <- dashboardBody(
  tableOutput("table")
)
ui <- dashboardPage(header = dashboardHeader(),
                    sidebar = dashboardSidebar(),
                    body = body
)

server <- function(input, output, session) {

  reactive_starwars_data <- reactiveFileReader(
    intervalMillis = 1000,
    session = session,
    filePath = "starwars.csv",
    readFunc = function(filePath){
        read.csv(filePath,sep = ";")
    }
  )
  output$table(
    {reactive_starwars_data()
      
    })
  
}

shinyApp(ui, server)


