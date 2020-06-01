source("./scripts/apikey.R")
source("./scripts/get.R")

server <- function(input, output){
  source("app_initialData.R")
  start_time <- Sys.time()
  message(paste0("Initial Data Retrieved at ", start_time))
  
  observeEvent(
    eventExpr = input[["submit_loc"]],
    handlerExpr = {
      request_time <- Sys.time()
      name <<- input$accountName
      region <<- input$region
      
      output$basicInfo <- renderText({
        print_ranked_data(name, region, apiKey)
      })

      debugWaitTime <- 5
      
      if((request_time - start_time) > debugWaitTime) {
        source("app_data.R")
      } else {
        withProgress(message = "Rate limit", value = 0, {
          wait_time <- as.numeric(round((debugWaitTime - (request_time - start_time)), digits = 0))
          for(n in 1:wait_time) {
            incProgress(amount = 1/wait_time, detail = paste0("Waiting for ", wait_time - n, " more seconds"))
            Sys.sleep(1)
          }
        })
        source("app_data.R")
      }
      
      output$graphChampion <- renderPlot(graph_champion_freq(champion_summary))
      
      output$graphTime <- renderPlot(graph_time(time_summary))
      
      output$graphWinratePie <- renderPlot(graph_winrate_pie(winrate_data))
      
    }
  )
}