source("./scripts/apikey.R")
source("./scripts/get.R")

server <- function(input, output){
  observeEvent(
    eventExpr = input[["submit_loc"]],
    handlerExpr = {
      accountName = input$nameInput
      region = input$region
      
      output$basicInfo <- renderText({
        get_ranked_data(accountName, region, apiKey)
      })
    }
  )
}