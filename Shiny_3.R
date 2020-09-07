library(sf)
library(sp)
library(tidyverse)
library(maptools)
library(data.table)
library(spdep)
library(readr)
library(leaflet)
library(mapview)
library(raster)
library(shiny)
library(shinythemes)
library(readxl)
library(rgdal)
library(htmltools)
library(reticulate)
library(data.table)
library(shinydashboard)


## Directorios
global <- "C:/Users/sngh9/Departamento Nacional de Planeacion/Unidad de Cientificos de Datos - Repositorio UCD/Proyectos UCD/2020/08_Prediccion_crimen"
#global <- "D/Departamento Nacional de Planeacion/Unidad de Cientificos de Datos - Repositorio UCD/Proyectos UCD/2020/08_Prediccion_crimen"
Insumos_gen <- "/1_Insumos/Bases_de_datos"
Insumos_otr <- "/1_Insumos/Otros_insumos"
Bucaramanga_Dir <- "/Bucaramanga"
Source <- "/2_Codigo/1_Source"
appdir <- "/2_Codigo/2_Aplicacion_final"

# Cargar Base de datos de Pronosticos
resultados <- st_read("C:/Users/sngh9/Departamento Nacional de Planeacion/Unidad de Cientificos de Datos - Repositorio UCD/Proyectos UCD/2020/08_Prediccion_crimen/2_Codigo/2_Aplicacion_final/datos/base.shp")
resultados$values <- as.numeric(resultados$values)
resultados$semana <- as.numeric(resultados$semana)
max(resultados$semana)*7
## Crear Fechas 
FECHA_HECHO <- seq(as.Date("2016-01-01"), as.Date("2020-01-31"), by="days")

# llaves <- st_read(paste0(global,dir_datos,"/llaves.shp"))
# llaves <- data.table(llaves)



# Funcion para convertir dias en semanas  
dia_semana <- function(Date){
  ## Convertir a tipo fecha en caso de que no lo este
  Date <- as.Date(Date)
  ## Calcular la distancia en dias desde la menor fecha
  distancia_dias <- as.numeric(Date-min(FECHA_HECHO))
  ## Con la distancia dividir en 7 para tener la semana
  semana_aproximanda <- ceiling(distancia_dias/7)
  return(semana_aproximanda)
}



# 1.Interfaz==
ui <- bootstrapPage(
  
  # Titulo
  title = "Prediccion Delito Bucaramanga",
  ttheme = shinythemes::shinytheme('simplex'),
  leafletOutput("Mapa",width = "100%",height = '100%'),
  absolutePanel(top = 10 , right = 10,
                selectInput("nueva_fecha","Escoger rango de semanas",choices = resultados$nueva_fecha),
                
                
                
                
  ),
  tags$style(type = "text/css", "
    html, body {width:100%;height:100%}     
    #controls{background-color:white;padding:20px;}
  ")
)





# 2. Servidor==
server <- function(output, input, session){
  
  Nueva_Fecha <- function(x){
    
    semana_base <- "2016-01-01 a 2016-01-08"
    Fecha_base <- as.Date("2016-01-01 ")
    
    if(x==0){
      return(semana_base)
      
    }
    else{
      distancia <- x*7
      nueva_Fecha_base <- Fecha_base+distancia
      nueva_Fecha_final <- nueva_Fecha_base + 7
      return(paste0(nueva_Fecha_base," a ",nueva_Fecha_final))
      
      
    }
  }
  # resultados$semana <- as.numeric(resultados$semana)
  resultados$nueva_fecha <- sapply(resultados$semana,Nueva_Fecha)
  
  ## Filtrar por semanas dado una fecha Dada 
  mapa_calor <- reactive({
    
    resultados %>% filter(nueva_fecha==input$nueva_fecha)                   
  })
  
  
  ## Mapa con semana filtrada 
  output$Mapa <- leaflet::renderLeaflet ({
    
    #qpal = colorFactor(palette = c("blue","red"),levels = c("0","1"))
    qpal = colorBin("Reds",mapa_calor()$values, bins=4)
    
    
    popup <- paste0("<strong> Seccion DANE: </strong>", 
                          mapa_calor()$seccion, 
                          "<br><strong> Delitos : </strong>", 
                          mapa_calor()$values,
                    "<br><strong> Homicidios : ",
                    "<br><strong> Lesiones : ",
                    "<br><strong> Hurtos : ")
    
    
    leaflet(mapa_calor()) %>% 
      addProviderTiles("CartoDB") %>% 
      addPolygons(weight = 1,fillColor = ~qpal(values),stroke = T,popup = popup,
                  highlight = highlightOptions(weight = 5, color = "white",
                                               bringToFront = TRUE)) %>% 
      addLegend(values=~values,pal=qpal,title="Delitos",position = "bottomleft") %>% 
      setView(lng =  -73.1198000, lat = 7.1253900, zoom = 12)
    
    
    
  })
  
  
}

shinyApp(ui = ui, server = server)


