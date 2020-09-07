library(shiny)
library(ggplot2)
ui <- fluidPage(
  textInput("name", "What is your name?",'Santi'),
  # CODE BELOW: Display the text output, greeting
  # Make sure to add a comma after textInput()
  textOutput("greeting"),
  plotOutput('gr')
)

global <- dirname(rstudioapi::getActiveDocumentContext()$path)
dir_datos <- "/datos"

server <- function(input, output) {
  # CODE BELOW: Render a text output, greeting
  output$greeting <- renderText({
    paste("Hello", input$name)
  })
  
  output$gr <- renderPlot({
    ggplot()
  })
}

shinyApp(ui = ui, server = server)



# ui <- fluidPage(
#   
#   titlePanel("Baby Name Explorer"),
#   # CODE BELOW: Add a sidebarLayout, sidebarPanel, and mainPanel
#   sidebarLayout(
#     sidebarPanel(
#       textInput('name', 'Enter Name', 'David')),
#     mainPanel(
#       plotOutput('trend')
#     )
#   )
# )
# 
# server <- function(input, output, session) {
#   output$trend <- renderPlot({
#     ggplot()
#   })
# }
# shinyApp(ui = ui, server = server)



# ui <- fluidPage(
#   titlePanel("Baby Name Explorer"),
#   sidebarLayout(
#     sidebarPanel(textInput('name', 'Enter Name', 'David')),
#     mainPanel(plotOutput('trend'))
#   )
# )
# server <- function(input, output, session) {
#   output$trend <- renderPlot({
#     # CODE BELOW: Update to display a line plot of the input name
#     ggplot(subset(babynames, name == "David")) +
#       geom_line(aes(x = year, y = prop, color = sex))
#     
#   })
# }
# shinyApp(ui = ui, server = server)



ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # CODE BELOW: Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      # MODIFY CODE BELOW: Filter for the selected sex
      filter(sex == input$sex) %>% 
      filter(year == 1900) %>% 
      top_n(10, prop)
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)





ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # CODE BELOW: Add slider input named 'year' to select years (1900 - 2010)
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  # Add plot output to display top 10 most popular names
  plotOutput('plot_top_10_names')
)

server <- function(input, output, session){
  # Render plot of top 10 most popular names
  output$plot_top_10_names <- renderPlot({
    # Get top 10 names by sex and year
    top_10_names <- babynames %>% 
      filter(sex == input$sex) %>% 
      # MODIFY CODE BELOW: Filter for the selected year
      filter(year == input$year) %>% 
      top_n(10, prop)
    # Plot top 10 names by sex and year
    ggplot(top_10_names, aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
}

shinyApp(ui = ui, server = server)




ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("F", "M")),
  # Add slider input named "year" to select year between 1900 and 2010
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),# CODE BELOW: Add table output named "table_top_10_names"
  tableOutput("table_top_10_names")
)
server <- function(input, output, session){
  # Function to create a data frame of top 10 names by sex and year 
  top_10_names <- function(){
    top_10_names <- babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
  }
  # CODE BELOW: Render a table output named "table_top_10_names"
  output$table_top_10_names <-renderTable({
    top_10_names()
    
    
  })
  
}
shinyApp(ui = ui, server = server)




ui <- fluidPage(
  titlePanel("What's in a Name?"),
  # Add select input named "sex" to choose between "M" and "F"
  selectInput('sex', 'Select Sex', choices = c("M", "F")),
  # Add slider input named "year" to select year between 1900 and 2010
  sliderInput('year', 'Select Year', min = 1900, max = 2010, value = 1900),
  # MODIFY CODE BELOW: Add a DT output named "table_top_10_names"
  DT::DTOutput('table_top_10_names')
)
server <- function(input, output, session){
  top_10_names <- function(){
    babynames %>% 
      filter(sex == input$sex) %>% 
      filter(year == input$year) %>% 
      top_n(10, prop)
  }
  # MODIFY CODE BELOW: Render a DT output named "table_top_10_names"
  output$table_top_10_names <- DT::renderDT({
    top_10_names()
  })
}
shinyApp(ui = ui, server = server)




ui <- fluidPage(
  selectInput('name', 'Select Name', top_trendy_names$name),
  # CODE BELOW: Add a plotly output named 'plot_trendy_names'
  plotly::plotlyOutput('plot_trendy_names')
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  # CODE BELOW: Render a plotly output named 'plot_trendy_names'
  
  output$plot_trendy_names <- plotly::renderPlotly(
    plot_trends()
  )
  
}
shinyApp(ui = ui, server = server)




ui <- fluidPage(
  # MODIFY CODE BELOW: Wrap in a sidebarLayout
  # MODIFY CODE BELOW: Wrap in a sidebarPanel
  sidebarLayout(
    sidebarPanel(
      selectInput('name', 'Select Name', top_trendy_names$name)),
    # MODIFY CODE BELOW: Wrap in a mainPanel
    mainPanel(
      plotly::plotlyOutput('plot_trendy_names'),
      DT::DTOutput('table_trendy_names')
    )
  )
)
# DO NOT MODIFY
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  output$table_trendy_names <- DT::renderDT({
    babynames %>% 
      filter(name == input$name)
  })
}
shinyApp(ui = ui, server = server)





ui <- fluidPage(
  selectInput('greeting_type', 'Select greeting', c("Hello", "Bonjour")),
  textInput('name', 'Enter your name'),
  textOutput('greeting')
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste(input$greeting_type, input$name, sep = ", ")
  })
}

shinyApp(ui = ui, server = server)



ui <- fluidPage(
  titlePanel("Most Popular Names"),
  sidebarLayout(
    sidebarPanel(
      selectInput('sex', 'Select Sex', c("M", "F")),
      sliderInput('year', 'Select Year', 1880, 2013, 1900)
    ),
    mainPanel(
      plotOutput('plot')
    )
  )
)
server <- function(input, output, session) {
  output$plot <- renderPlot({
    top_names_by_sex_year <- get_top_names(input$year, input$sex) 
    ggplot(top_names_by_sex_year, aes(x = name, y = prop)) +
      geom_col()
  })
}
shinyApp(ui = ui, server = server)




ui <- fluidPage(
  titlePanel("Most Popular Names"),
  sidebarLayout(
    sidebarPanel(
      selectInput('sex', 'Select Sex', c("M", "F")),
      sliderInput('year', 'Select Year', 1880, 2013, 1900)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Plot', plotOutput('plot')),
        tabPanel('Table', tableOutput('table'))
      )
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    d <- get_top_names(input$year, input$sex) 
    qplot(name, prop, data = d, geom = 'col')
  })
  
  output$table <- renderTable({
    get_top_names(input$year, input$sex) 
  })
}
shinyApp(ui = ui, server = server)



ui <- fluidPage(
  # CODE BELOW: Add a titlePanel with an appropriate title
  titlePanel('Top Trendy Names'),
  # MODIFY CODE BELOW: Add theme = shinythemes::shinytheme() with appropriate theme
  theme = shinythemes::shinytheme("cerulean"),
  sidebarLayout(
    sidebarPanel(
      selectInput('name', 'Select Name', top_trendy_names$name)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel('Plot', plotly::plotlyOutput('plot_trendy_names')),
        tabPanel('Table', DT::DTOutput('table_trendy_names'))
      )
    )
  )
)
server <- function(input, output, session){
  # Function to plot trends in a name
  plot_trends <- function(){
    babynames %>% 
      filter(name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_col()
  }
  output$plot_trendy_names <- plotly::renderPlotly({
    plot_trends()
  })
  
  output$table_trendy_names <- DT::renderDT({
    babynames %>% 
      filter(name == input$name)
  })
}
shinyApp(ui = ui, server = server)


#antes

server <- function(input, output, session) {
  # CODE BELOW: Add a reactive expression rval_bmi to calculate BMI
  
  
  
  output$bmi <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    rval_bmi <- reactive({input$weight/(input$height^2)
      paste("Your BMI is", round(bmi, 1))
    }})
    output$bmi_range <- renderText({
      # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
      bmi <- input$weight/(input$height^2)
      bmi_status <- cut(bmi, 
                        breaks = c(0, 18.5, 24.9, 29.9, 40),
                        labels = c('underweight', 'healthy', 'overweight', 'obese')
      )
      paste("You are", bmi_status)
    })
}
ui <- fluidPage(
  titlePanel('BMI Calculator'),
  sidebarLayout(
    sidebarPanel(
      numericInput('height', 'Enter your height in meters', 1.5, 1, 2),
      numericInput('weight', 'Enter your weight in Kilograms', 60, 45, 120)
    ),
    mainPanel(
      textOutput("bmi"),
      textOutput("bmi_range")
    )
  )
)

shinyApp(ui = ui, server = server)






erver <- function(input, output, session) {
  # CODE BELOW: Add a reactive expression rval_bmi to calculate BMI
  rval_bmi <- reactive({
    input$weight/(input$height^2)
  })
  output$bmi <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    paste("Your BMI is", round(bmi, 1))
  })
  output$bmi_range <- renderText({
    # MODIFY CODE BELOW: Replace right-hand-side with reactive expression
    bmi <- rval_bmi()
    bmi_status <- cut(bmi, 
                      breaks = c(0, 18.5, 24.9, 29.9, 40),
                      labels = c('underweight', 'healthy', 'overweight', 'obese')
    )
    paste("You are", bmi_status)
  })
}
ui <- fluidPage(
  titlePanel('BMI Calculator'),
  sidebarLayout(
    sidebarPanel(
      numericInput('height', 'Enter your height in meters', 1.5, 1, 2),
      numericInput('weight', 'Enter your weight in Kilograms', 60, 45, 120)
    ),
    mainPanel(
      textOutput("bmi"),
      textOutput("bmi_range")
    )
  )
)


indice_s <- toString(indice)

shinyApp(ui = ui, server = server)















ui <- fluidPage(
  titlePanel("Bosquejo para Andres y Pablo"),
  theme = shinytheme("darkly"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Semana","Escoger semana",choices = unique(Base_Mapa)),
      # selectInput("index","Escoger zona del mapa ",choices = unique(Bucaramanga$index)),
      # selectInput("Year","Escoger epoca del KDE",choices = unique(Datos$Year)),
      # selectInput("DELITO","Ecoge seguimiento del Delito",choices = unique(Bucaramanga$DELITO)),
      # sliderInput("ANIO","Elegir para que año",min = min(Bucaramanga$ANIO),max = max(Bucaramanga$ANIO),value = 2016)),
      # selectInput("DELITO","Esocger tipo de delito",choices = unique(Bucaramanga$DELITO)),
      mainPanel(
        tabsetPanel(
          tabPanel("Mapa",mapview("Mapa")),
          # tabPanel("Mapa de calor",mapviewOutput("Mapa_calor")),
          # tabPanel("Mapa_kde",plotOutput("Mapa_KDES")),
          # tabPanel("Barras", plotly::plotlyOutput('Poligono_bar')),
          # tabPanel("Serie de tiempo",plotly::plotlyOutput("serie"))
        ))
    )
    
  )
  
  
  
  server <- function(output, input,session){
    
    Bucaramanga <-st_read(paste0(global,Insumos_gen,Bucaramanga_Dir,"/Bucaramanga_df.shp"))
    Bucaramanga <- Bucaramanga[order(as.Date(Bucaramanga$FECHA_HECH)),]
    Bucaramanga$ANIO <- as.numeric(Bucaramanga$ANIO)
    Datos <- read_excel(paste0(global,Insumos_gen,Bucaramanga_Dir,"/Datos.xlsx"))
    resultados <- read_csv(paste0(global,Insumos_otr,"/Resultados","/resultado.csv"))
    Base_resultados <- NULL
    
    # for(i in c(2:ncol(resultados))){
    #   
    #   
    #   Poligono_columna <- cbind(Poligono <- colnames(resultados)[i],resultados[,c(1,3)])
    #   names(Poligono_columna) <- c("indice","Semana","Delitos")
    #   Base_resultados <- rbind(Base_resultados,Poligono_columna)
    #   
    # }
    llaves <- read_csv(paste0(global,Insumos_otr,"/Resultados","/llaves.csv"))
    # Base_Mapa <- merge(Base_resultados,llaves,by = 'indice',all.x=T)
    Bucaramanga_window <- st_read("C:/Users/sngh9/Departamento Nacional de Planeacion/Unidad de Cientificos de Datos - Repositorio UCD/Proyectos UCD/2020/08_Prediccion_crimen/1_Insumos/Otros_insumos/shapefiles_bucaramanga/area_censal/area_censal_buc.shp")
    window <- maptools::as.owin.SpatialPolygons(as(Bucaramanga_window,'Spatial'))
    desdelito <- function(x){
      if (x=='hom'){
        x='Homicidios'
        return(x)
      }
      else if (x=='hper'){
        x= 'Hurtos'
        return(x)
      }
      else if(x=='les'){
        x='Lesiones'
        return(x)
      }
      else if(x=='vif'){
        x='Violencia intrafamiliar'
        return(x)
        
      }
    }
    Datos$DELITO <- sapply(Datos$DELITO,desdelito)
    
    #Filtrar por poligono
    poligono  <- function(){
      Bucaramanga %>% filter(index==input$index) %>% filter(ANIO==input$ANIO) %>% group_by(DELITO) %>% count() %>% mutate(Total = n) %>% 
        
        # Hacer gráfico de Barras 
        ggplot(aes(x = DELITO,y=Total))+
        geom_col(fill = "#263e63")
    }
    
    output$Poligono_bar <- plotly::renderPlotly(
      poligono()
    )
    
    serie <- function(){
      Bucaramanga%>% mutate(Mes_1 = format(as.Date(Bucaramanga$FECHA_HECH), "%Y %m")) %>% group_by(Mes_1) %>% filter(DELITO==input$DELITO) %>% count() %>% mutate(Total=n) %>% 
        ggplot(aes(x = Mes_1, y = Total,group=1))+
        geom_line(color="darkred")+
        theme(axis.text.x = element_text(angle=45))+
        xlab("")
      
      
    }
    
    output$serie <- plotly::renderPlotly(
      
      serie()
    )
    
    KDE <- function(){
      Base <- Datos %>% filter(Year==2017)
      B_ppp <- ppp(x = Base$LONGITUD,y = Base$LATITUD,window = window,check = T)
      jitter_bbb <- rjitter(B_ppp, retry=TRUE, nsim=1, drop=TRUE)
      mapa_densidad <- density.ppp(jitter_bbb, sigma = bw.diggle(jitter_bbb),edge=T)
      p <- plot(mapa_densidad)
    }
    output$Mapa_kde <- renderPlot({
      KDE()
    })
    
    
    mapa_calor_2 <- function(){
      
      Base_Mapa %>% filter(input$Semana) %>% st_as_sf() %>% mapview(zcol = "Delito")
    }
    
    output$Mapa <- renderMapview(
      mapa_calor_2()
    )
    mapa_calor <- function(){
      mapa <- Bucaramanga  %>% filter(ANIO==2016) %>% filter(DELITO== 'Hurtos') %>% group_by(index) %>% count() %>% mutate(Total = n) %>% st_as_sf() %>% 
        mapview(zcol = 'Total')
      
    } 
    output$Mapa_calor <- renderMapview(
      mapa_calor()
    )
    
    
    
    
  }
  
  
  
  
  
  shinyApp(ui = ui, server = server)
  
  
  
  
  server <- function(input, output, session) {
    rval_bmi <- reactive({
      input$weight/(input$height^2)
    })
    # CODE BELOW: Add a reactive expression rval_bmi_status to 
    # return health status as underweight etc. based on inputs
    rval_bmi_status <- reactive({
      cut(rval_bmi(), 
          breaks = c(0, 18.5, 24.9, 29.9, 40),
          labels = c('underweight', 'healthy', 'overweight', 'obese')
      )
    })
    output$bmi <- renderText({
      bmi <- rval_bmi()
      paste("Your BMI is", round(bmi, 1))
    })
    output$bmi_status <- renderText({
      # MODIFY CODE BELOW: Replace right-hand-side with 
      # reactive expression rval_bmi_status
      bmi_status <- rval_bmi_status()
      paste("You are", bmi_status)
    })
  }
  ui <- fluidPage(
    titlePanel('BMI Calculator'),
    sidebarLayout(
      sidebarPanel(
        numericInput('height', 'Enter your height in meters', 1.5, 1, 2),
        numericInput('weight', 'Enter your weight in Kilograms', 60, 45, 120)
      ),
      mainPanel(
        textOutput("bmi"),
        textOutput("bmi_status")
      )
    )
  )
  
  shinyApp(ui = ui, server = server)
  
  
  
  
  ui <- fluidPage(
    textInput('name', 'Enter your name')
  )
  
  server <- function(input, output, session) {
    # CODE BELOW: Add an observer to display a notification
    # 'You have entered the name xxxx' where xxxx is the name
    
    observe({
      
      showNotification(
        paste("You entered the name", input$name)
      )
    })
    
    
    
  }
  
  shinyApp(ui = ui, server = server)
  
  
  
  server <- function(output, input, session){
    resultados <- st_read(paste0(global,Insumos_otr,"/Resultados","/resultado.shp"))
    resultados$values <- as.numeric(resultados$values)
    
    mapa_calor <- function(){
      
      resultados %>% filter(semana==input$semana)  %>% ggplot() + geom_sf(aes(fill = values))
    }
    
    
    output$Mapa <- plotly::renderPlotly  (
      mapa_calor()
    )
    
    
  }
  
  
  
  
  
  server <- function(input, output, session) {
    rval_bmi <- reactive({
      input$weight/(input$height^2)
    })
    output$bmi <- renderText({
      bmi <- rval_bmi()
      # MODIFY CODE BELOW: 
      # Use isolate to stop output from updating when name changes.
      paste("Hi", isolate({input$name}), ". Your BMI is", round(bmi, 1))
    })
  }
  ui <- fluidPage(
    titlePanel('BMI Calculator'),
    sidebarLayout(
      sidebarPanel(
        textInput('name', 'Enter your name'),
        numericInput('height', 'Enter your height (in m)', 1.5, 1, 2, step = 0.1),
        numericInput('weight', 'Enter your weight (in Kg)', 60, 45, 120)
      ),
      mainPanel(
        textOutput("bmi")
      )
    )
  )
  
  shinyApp(ui = ui, server = server)
  
  
  
  server <- function(input, output, session) {
    # MODIFY CODE BELOW: Use eventReactive to delay the execution of the
    # calculation until the user clicks on the show_bmi button (Show BMI)
    rval_bmi <- eventReactive(input$show_bmi,{
      input$weight/(input$height^2)
    })
    output$bmi <- renderText({
      bmi <- rval_bmi()
      paste("Hi", input$name, ". Your BMI is", round(bmi, 1))
    })
  }
  ui <- fluidPage(
    titlePanel('BMI Calculator'),
    sidebarLayout(
      sidebarPanel(
        textInput('name', 'Enter your name'),
        numericInput('height', 'Enter height (in m)', 1.5, 1, 2, step = 0.1),
        numericInput('weight', 'Enter weight (in Kg)', 60, 45, 120),
        actionButton("show_bmi", "Show BMI")
      ),
      mainPanel(
        textOutput("bmi")
      )
    )
  )
  
  
  shinyApp(ui = ui, server = server)
  
  
  
  server <- function(input, output, session) {
    # MODIFY CODE BELOW: Wrap in observeEvent() so the help text 
    # is displayed when a user clicks on the Help button.
    
    # Display a modal dialog with bmi_help_text
    # MODIFY CODE BELOW: Uncomment code
    observeEvent(input$show_help,{
      showModal(modalDialog(bmi_help_text))} 
    )
    rv_bmi <- eventReactive(input$show_bmi, {
      input$weight/(input$height^2)
    })
    output$bmi <- renderText({
      bmi <- rv_bmi()
      paste("Hi", input$name, ". Your BMI is", round(bmi, 1))
    })
  }
  
  ui <- fluidPage(
    titlePanel('BMI Calculator'),
    sidebarLayout(
      sidebarPanel(
        textInput('name', 'Enter your name'),
        numericInput('height', 'Enter your height in meters', 1.5, 1, 2),
        numericInput('weight', 'Enter your weight in Kilograms', 60, 45, 120),
        actionButton("show_bmi", "Show BMI"),
        # CODE BELOW: Add an action button named "show_help"
        actionButton("show_help","Help")
      ),
      mainPanel(
        textOutput("bmi")
      )
    )
  )
  
  shinyApp(ui = ui, server = server)
  
  
  
  server <- function(input, output) {
    # CODE BELOW: Create a plot output name 'shapes', of sightings by shape,
    # For the selected inputs
    output$shapes <- renderPlot({
      usa_ufo_sightings %>%
        filter(state == input$state,
               date_sighted >= input$dates[1],
               date_sighted <= input$dates[2]) %>%
        ggplot(aes(shape)) +
        geom_bar() +
        labs(x = "Shape", y = "# Sighted")
    })
    # CODE BELOW: Create a table output named 'duration_table', by shape, 
    # of # sighted, plus mean, median, max, and min duration of sightings
    # for the selected inputs
    output$duration_table <- renderTable({
      usa_ufo_sightings %>%
        filter(
          state == input$state,
          date_sighted >= input$dates[1],
          date_sighted <= input$dates[2]
        ) %>%
        group_by(shape) %>%
        summarize(
          nb_sighted = n(),
          avg_duration = mean(duration_sec),
          median_duration = median(duration_sec),
          min_duration = min(duration_sec),
          max_duration = max(duration_sec)
        )
    })
  }
  
  ui <- fluidPage(
    titlePanel("UFO Sightings"),
    sidebarLayout(
      sidebarPanel(
        selectInput("state", "Choose a U.S. state:", choices = unique(usa_ufo_sightings$state)),
        dateRangeInput("dates", "Choose a date range:",
                       start = "1920-01-01",
                       end = "1950-01-01")
      ),
      mainPanel(
        # Add plot output named 'shapes'
        plotOutput("shapes"),
        # Add table output named 'duration_table'
        tableOutput("duration_table")
      )
    )
  )
  
  shinyApp(ui, server)
  
  
  
  
  ui <- fluidPage(
    titlePanel("UFO Sightings"),
    sidebarPanel(
      selectInput("state", "Choose a U.S. state:", choices = unique(usa_ufo_sightings$state)),
      dateRangeInput("dates", "Choose a date range:",
                     start = "1920-01-01",
                     end = "1950-01-01"
      )
    ),
    # MODIFY CODE BELOW: Create a tab layout for the dashboard
    mainPanel(
      tabsetPanel(
        tabPanel("Number sighted", plotOutput("shapes")),
        tabPanel("Duration table", tableOutput("duration_table"))
      )
    )
  )
  
  server <- function(input, output) {
    output$shapes <- renderPlot({
      usa_ufo_sightings %>%
        filter(
          state == input$state,
          date_sighted >= input$dates[1],
          date_sighted <= input$dates[2]
        ) %>%
        ggplot(aes(shape)) +
        geom_bar() +
        labs(
          x = "Shape",
          y = "# Sighted"
        )
    })
    
    output$duration_table <- renderTable({
      usa_ufo_sightings %>%
        filter(
          state == input$state,
          date_sighted >= input$dates[1],
          date_sighted <= input$dates[2]
        ) %>%
        group_by(shape) %>%
        summarize(
          nb_sighted = n(),
          avg_duration_min = mean(duration_sec) / 60,
          median_duration_min = median(duration_sec) / 60,
          min_duration_min = min(duration_sec) / 60,
          max_duration_min = max(duration_sec) / 60
        )
    })
  }
  
  shinyApp(ui, server)
  
  
  ui <- fluidPage(
    # CODE BELOW: Add an appropriate title
    titlePanel("2014 Mental Health in Tech Survey"),
    sidebarPanel(
      # CODE BELOW: Add a checkboxGroupInput
      checkboxGroupInput(
        inputId = "mental_health_consequence",
        label = "Do you think that discussing a mental health issue with your employer would have negative consequences?",
        choices = c("Maybe", "Yes", "No"),
        selected = "Maybe"
      ),
      # CODE BELOW: Add a pickerInput
      pickerInput(
        inputId = "mental_vs_physical",
        label = "Do you feel that your employer takes mental health as seriously as physical health?",
        choices = c("Don't Know", "No", "Yes"),
        multiple = TRUE
      )
    ),
    mainPanel(
      # CODE BELOW: Display the output
      plotOutput("age")
    )
  )
  
  server <- function(input, output, session) {
    # CODE BELOW: Build a histogram of the age of respondents
    # Filtered by the two inputs
    output$age <- renderPlot({
      mental_health_survey %>%
        filter(
          mental_health_consequence %in% input$mental_health_consequence,
          mental_vs_physical %in% input$mental_vs_physical
        ) %>%
        ggplot(aes(Age)) +
        geom_histogram()
    })
  }
  
  shinyApp(ui, server)
  
  
  server <- function(input, output, session) {
    output$age <- renderPlot({
      # MODIFY CODE BELOW: Add validation that user selected a 3rd input
      validate(
        need(
          input$mental_vs_physical != "", 
          "Make a selection for mental vs. physical health."
        )
      )
      
      mental_health_survey %>%
        filter(
          work_interfere == input$work_interfere,
          mental_health_consequence %in% input$mental_health_consequence,
          mental_vs_physical %in% input$mental_vs_physical
        ) %>%
        ggplot(aes(Age)) +
        geom_histogram()
    })
  }
  
  ui <- fluidPage(
    titlePanel("2014 Mental Health in Tech Survey"),
    sidebarPanel(
      sliderTextInput(
        inputId = "work_interfere",
        label = "If you have a mental health condition, do you feel that it interferes with your work?", 
        grid = TRUE,
        force_edges = TRUE,
        choices = c("Never", "Rarely", "Sometimes", "Often")
      ),
      checkboxGroupInput(
        inputId = "mental_health_consequence",
        label = "Do you think that discussing a mental health issue with your employer would have negative consequences?", 
        choices = c("Maybe", "Yes", "No"),
        selected = "Maybe"
      ),
      pickerInput(
        inputId = "mental_vs_physical",
        label = "Do you feel that your employer takes mental health as seriously as physical health?", 
        choices = c("Don't Know", "No", "Yes"),
        multiple = TRUE
      )
    ),
  mainPanel(
    plotOutput("age")  
  )
)

shinyApp(ui, server)



ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      # CODE BELOW: Add an input named "cuisine" to select a cuisine
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      # Code BELOW: Add an input named "nb_ingredients" to select #ingredients
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 20),
    ),
    mainPanel(
      # CODE BELOW: Add a DT output named "dt_top_ingredients"
      DT::DTOutput('dt_top_ingredients')
    )
  )
)
server <- function(input, output, session) {
  # CODE BELOW: Render the top ingredients in a chosen cuisine as 
  # an interactive data table and assign it to output object `dt_top_ingredients`
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui, server)


ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 10),
    ),
    mainPanel(
      tabsetPanel(
        # CODE BELOW: Add a plotly output named "plot_top_ingredients"
        tabPanel('Plot', plotly::plotlyOutput('plot_top_ingredients')),
        tabPanel('Table', DT::DTOutput('dt_top_ingredients'))
      )
    )
  )
)
server <- function(input, output, session) {
  # CODE BELOW: Add a reactive expression named `rval_top_ingredients` that
  # filters `recipes_enriched` for the selected cuisine and top ingredients
  # based on the tf_idf value.
  rval_top_ingredients <- reactive({
    recipes_enriched %>% 
      filter(cuisine == input$cuisine) %>% 
      arrange(desc(tf_idf)) %>% 
      head(input$nb_ingredients)
  })
  # CODE BELOW: Render a horizontal bar plot of top ingredients and 
  # the tf_idf of recipes they get used in, and assign it to an output named 
  # `plot_top_ingredients` 
  output$plot_top_ingredients <- plotly::renderPlotly({
    rval_top_ingredients() %>%
      ggplot(aes(x = ingredient, y = tf_idf)) +
      geom_col() +
      coord_flip()
  })
  
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui, server)
  

ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 10),
    ),
    mainPanel(
      tabsetPanel(
        # CODE BELOW: Add a plotly output named "plot_top_ingredients"
        tabPanel('Plot', plotly::plotlyOutput('plot_top_ingredients')),
        tabPanel('Table', DT::DTOutput('dt_top_ingredients'))
      )
    )
  )
)
server <- function(input, output, session) {
  # CODE BELOW: Add a reactive expression named `rval_top_ingredients` that
  # filters `recipes_enriched` for the selected cuisine and top ingredients
  # based on the tf_idf value.
  rval_top_ingredients <- reactive({
    recipes_enriched %>% 
      filter(cuisine == input$cuisine) %>% 
      arrange(desc(tf_idf)) %>% 
      head(input$nb_ingredients)
  })
  # CODE BELOW: Render a horizontal bar plot of top ingredients and 
  # the tf_idf of recipes they get used in, and assign it to an output named 
  # `plot_top_ingredients` 
  output$plot_top_ingredients <- plotly::renderPlotly({
    rval_top_ingredients() %>%
      ggplot(aes(x = ingredient, y = tf_idf)) +
      geom_col() +
      coord_flip()
  })
  
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui, server)



ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 20),
    ),
    mainPanel(
      tabsetPanel(
        # CODE BELOW: Add `d3wordcloudOutput` named `wc_ingredients` in a `tabPanel`
        tabPanel('Word Cloud', d3wordcloud::d3wordcloudOutput('wc_ingredients', height = '400')),
        tabPanel('Plot', plotly::plotlyOutput('plot_top_ingredients')),
        tabPanel('Table', DT::DTOutput('dt_top_ingredients'))
      )
    )
  )
)
server <- function(input, output, session){
  # CODE BELOW: Render an interactive wordcloud of top distinctive ingredients 
  # and the number of recipes they get used in, using 
  # `d3wordcloud::renderD3wordcloud`, and assign it to an output named
  # `wc_ingredients`.
  output$wc_ingredients <- d3wordcloud::renderD3wordcloud({
    ingredients_df <- rval_top_ingredients()
    d3wordcloud(ingredients_df$ingredient, ingredients_df$nb_recipes, tooltip = TRUE)
  })
  rval_top_ingredients <- reactive({
    recipes_enriched %>% 
      filter(cuisine == input$cuisine) %>% 
      arrange(desc(tf_idf)) %>% 
      head(input$nb_ingredients) %>% 
      mutate(ingredient = forcats::fct_reorder(ingredient, tf_idf))
  })
  output$plot_top_ingredients <- plotly::renderPlotly({
    rval_top_ingredients() %>%
      ggplot(aes(x = ingredient, y = tf_idf)) +
      geom_col() +
      coord_flip()
  })
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui = ui, server= server)


ui <- fluidPage(
  titlePanel('Explore Cuisines'),
  sidebarLayout(
    sidebarPanel(
      selectInput('cuisine', 'Select Cuisine', unique(recipes$cuisine)),
      sliderInput('nb_ingredients', 'Select No. of Ingredients', 5, 100, 20),
    ),
    mainPanel(
      tabsetPanel(
        # CODE BELOW: Add `d3wordcloudOutput` named `wc_ingredients` in a `tabPanel`
        tabPanel('Word Cloud', d3wordcloud::d3wordcloudOutput('wc_ingredients', height = '400')),
        tabPanel('Plot', plotly::plotlyOutput('plot_top_ingredients')),
        tabPanel('Table', DT::DTOutput('dt_top_ingredients'))
      )
    )
  )
)
server <- function(input, output, session){
  # CODE BELOW: Render an interactive wordcloud of top distinctive ingredients 
  # and the number of recipes they get used in, using 
  # `d3wordcloud::renderD3wordcloud`, and assign it to an output named
  # `wc_ingredients`.
  output$wc_ingredients <- d3wordcloud::renderD3wordcloud({
    ingredients_df <- rval_top_ingredients()
    d3wordcloud(ingredients_df$ingredient, ingredients_df$nb_recipes, tooltip = TRUE)
  })
  rval_top_ingredients <- reactive({
    recipes_enriched %>% 
      filter(cuisine == input$cuisine) %>% 
      arrange(desc(tf_idf)) %>% 
      head(input$nb_ingredients) %>% 
      mutate(ingredient = forcats::fct_reorder(ingredient, tf_idf))
  })
  output$plot_top_ingredients <- plotly::renderPlotly({
    rval_top_ingredients() %>%
      ggplot(aes(x = ingredient, y = tf_idf)) +
      geom_col() +
      coord_flip()
  })
  output$dt_top_ingredients <- DT::renderDT({
    recipes %>% 
      filter(cuisine == input$cuisine) %>% 
      count(ingredient, name = 'nb_recipes') %>% 
      arrange(desc(nb_recipes)) %>% 
      head(input$nb_ingredients)
  })
}
shinyApp(ui = ui, server= server)





ui <- bootstrapPage(
  theme = shinythemes::shinytheme('simplex'),
  leaflet::leafletOutput('map', height = '100%', width = '100%'),
  absolutePanel(top = 10, right = 10, id = 'controls',
                # CODE BELOW: Add slider input named nb_fatalities
                sliderInput('nb_fatalities', 'Minimum Fatalities', 1, 40, 10),
                # CODE BELOW: Add date range input named date_range
                dateRangeInput('date_range', 'Select Date', "2010-01-01", "2019-12-01")
  ),
  tags$style(type = "text/css", "
    html, body {width:100%;height:100%}     
    #controls{background-color:white;padding:20px;}
  ")
)
server <- function(input, output, session) {
  output$map <- leaflet::renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      setView( -98.58, 39.82, zoom = 5) %>% 
      addTiles()
  })
}

shinyApp(ui, server)




server <- function(input, output, session) {
  rval_mass_shootings <- reactive({
    # MODIFY CODE BELOW: Filter mass_shootings on nb_fatalities and 
    # selected date_range.
    mass_shootings %>% 
      filter(
        date >= input$date_range[1],
        date <= input$date_range[2],
        fatalities >= input$nb_fatalities
      )
  })
  output$map <- leaflet::renderLeaflet({
    rval_mass_shootings() %>%
      leaflet() %>% 
      addTiles() %>%
      setView( -98.58, 39.82, zoom = 5) %>% 
      addTiles() %>% 
      addCircleMarkers(
        # CODE BELOW: Add parameters popup and radius and map them
        # to the summary and fatalities columns
        popup = ~ summary, radius = ~ fatalities,
        fillColor = 'red', color = 'red', weight = 1
      )
  })
}
ui <- bootstrapPage(
  theme = shinythemes::shinytheme('simplex'),
  leaflet::leafletOutput('map', height = '100%', width = '100%'),
  absolutePanel(top = 10, right = 10, id = 'controls',
                sliderInput('nb_fatalities', 'Minimum Fatalities', 1, 40, 10),
                dateRangeInput('date_range', 'Select Date', "2010-01-01", "2019-12-01")
  ),
  tags$style(type = "text/css", "
    html, body {width:100%;height:100%}     
    #controls{background-color:white;padding:20px;}
  ")
)

shinyApp(ui, server)




ui <- bootstrapPage(
  theme = shinythemes::shinytheme('simplex'),
  leaflet::leafletOutput('map', width = '100%', height = '100%'),
  absolutePanel(top = 10, right = 10, id = 'controls',
                sliderInput('nb_fatalities', 'Minimum Fatalities', 1, 40, 10),
                dateRangeInput(
                  'date_range', 'Select Date', "2010-01-01", "2019-12-01"
                ),
                # CODE BELOW: Add an action button named show_about
                actionButton('show_about', 'About')
  ),
  tags$style(type = "text/css", "
    html, body {width:100%;height:100%}     
    #controls{background-color:white;padding:20px;}
  ")
)
server <- function(input, output, session) {
  # CODE BELOW: Use observeEvent to display a modal dialog
  # with the help text stored in text_about.
  observeEvent(input$show_about, {
    showModal(modalDialog(text_about, title = 'About'))
  })
  output$map <- leaflet::renderLeaflet({
    mass_shootings %>% 
      filter(
        date >= input$date_range[1],
        date <= input$date_range[2],
        fatalities >= input$nb_fatalities
      ) %>% 
      leaflet() %>% 
      setView( -98.58, 39.82, zoom = 5) %>% 
      addTiles() %>% 
      addCircleMarkers(
        popup = ~ summary, radius = ~ sqrt(fatalities)*3,
        fillColor = 'red', color = 'red', weight = 1
      )
  })
}

shinyApp(ui, server)


library(shinyWidgets)
shinyWidgetsGallery()
  # mapa_basico <- Bucaramanga %>% filter(DELITO=='Hurtos') %>% group_by(index) %>% count() %>% mutate(Total = n)
  # plot(mapa_basico)
  # 
  # mapview(map,zcol = 'Total')
  