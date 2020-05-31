ui <- fluidPage(
  h1("League of Legends Player Statistics"),
  
  textInput(
    inputId = "accountName",
    label = h3("Account Name:"),
    placeholder = "Account Name"
  ),
  
  selectInput("region", "Region:",
              c("NA" = "na1",
                "EUW" = "euw1",
                "KR" = "kr")),
  
  actionButton(
    inputId = "submit_loc",
    label = "Get stats"
  )
)