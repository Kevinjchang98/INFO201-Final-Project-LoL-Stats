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
      numGames <<- input$numGames
      rankedInfoString <- print_ranked_data(name, region, apiKey)

      
      output$basicInfo <- renderText({
        rankedInfoString
      })
      
      if(rankedInfoString != "Could not get ranked data.") {
        
        leagueString <- strsplit(rankedInfoString, " ")[[1]][5]
        leagueString <- paste(toupper(substring(leagueString, 1,1)),
                              substring(leagueString, 2),
                              sep="", collapse=" ")
        leagueString <- paste0("Emblem_",
                               leagueString,
                               ".png")
        
        message(leagueString)
        
        pathToImage <- reactive({
          leagueString
        })
        
        output$leagueImage <- renderUI({
          tags$img(src = pathToImage(),
                   style = "width: 100%")
        })
      }
      
      

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