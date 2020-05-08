shinyServer(
  pageWithSidebar(
    headerPanel("Test Header"),
    
    sidebarPanel("Username",
      textInput("nameInput", "Name", ""),
      
      selectInput("region", "Region:",
                  c("NA" = "na1",
                    "EUW" = "euw1",
                    "KR" = "kr")),
      
      actionButton(
        inputId = "submit_loc",
        label = "Get stats"
      )
    ),
    mainPanel(
     # verbatimTextOutput("url1"),
     # verbatimTextOutput("url2"),
      verbatimTextOutput("main")
    )
  )
)

