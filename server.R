# library(httr)
# library(jsonlite)
library(dplyr)

shinyServer(
  function(input, output){
    observeEvent(
      eventExpr = input[["submit_loc"]],
      handlerExpr = {
        
        
        accountName = input$nameInput
        region = input$region
        
        apiKey = "RGAPI-bf6d40f1-7678-474c-b4eb-e3f64fd0464a"
        
        url = paste("https://", region, ".api.riotgames.com/lol/summoner/v4/summoners/by-name/", accountName, "?api_key=", apiKey, sep = "")
        output$url1 = renderText({url})
        accountInfo = GET(url)
        accountInfo = fromJSON(rawToChar(accountInfo$content))
        
        url = paste("https://", region, ".api.riotgames.com/lol/league/v4/entries/by-summoner/", accountInfo$id, "?api_key=", apiKey, sep = "")
        output$url2 = renderText({url})
        rankedData = GET(url)
        rankedData = fromJSON(rawToChar(rankedData$content))
        
        soloQRank <- rankedData %>%
          filter(queueType == "RANKED_SOLO_5x5") %>% 
          select(tier, rank)
        
        soloQRank <- paste(tolower(soloQRank$tier), soloQRank$rank, sep = " ")
        
        output$main <- renderText({
          paste(accountName, " is currently ranked ", soloQRank, " in solo queue.", sep = "")
        }) #TODO: Fix crash when no ranked soloq data. Caused by line 28
      }
    )
  }
)
