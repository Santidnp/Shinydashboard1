server <- function(input, output) {
  output$task_menu <- renderMenu({
    tasks <- apply(task_data, 1, function(row) {
      taskItem(text = row[["text"]],
               value = row[["value"]])
    })
    
    dropdownMenu(type = "tasks", .list = tasks)
  })
}

header <- dashboardHeader(dropdownMenuOutput("task_menu"))

ui <- dashboardPage(header = header,
                    sidebar = dashboardSidebar(),
                    body = dashboardBody()
)
shinyApp(ui, server)


# 
# # Print the nasa_fireball data frame
# print(nasa_fireball)
# 
# # Examine the types of variables present
# sapply(nasa_fireball,class)
# 
# # Observe the number of observations in this data frame
# 
# nrow(nasa_fireball)
# 
# # Check for missing data
# sapply(nasa_fireball,anyNA)