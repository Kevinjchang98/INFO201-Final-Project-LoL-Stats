library(httr)
library(jsonlite)
library(dplyr)

shinyServer(
  function(input, output){
    observeEvent(
      eventExpr = input[["submit_loc"]],
      handlerExpr = {
        accountName = input$nameInput
        region = input$region
        
         
        output$basicInfo <- renderText({
          printRankedData(accountName, region, apiKey)
        })
      }
    )
  }
)

getRankedData <- function(accountName, region, apiKey) {
  url = paste("https://", region, ".api.riotgames.com/lol/summoner/v4/summoners/by-name/", accountName, "?api_key=", apiKey, sep = "")
  accountInfo = GET(url)
  accountInfo = fromJSON(rawToChar(accountInfo$content))
  
  url = paste("https://", region, ".api.riotgames.com/lol/league/v4/entries/by-summoner/", accountInfo$id, "?api_key=", apiKey, sep = "")
  rankedData = GET(url)
  rankedData = fromJSON(rawToChar(rankedData$content))
  
  soloQRank <- rankedData %>%
    filter(queueType == "RANKED_SOLO_5x5") %>% 
    select(tier, rank)
  
  soloQRank <- paste(tolower(soloQRank$tier), soloQRank$rank, sep = " ")
  
  summonerName <- rankedData %>%
    filter(queueType == "RANKED_SOLO_5x5") %>% 
    select(summonerName) %>% 
    pull()
  
  currentLP <- rankedData %>%
    filter(queueType == "RANKED_SOLO_5x5") %>% 
    select(leaguePoints) %>% 
    pull()
  
  return(paste(summonerName, " is currently ranked ", soloQRank, " in solo queue with ", currentLP, " LP", sep = ""))
}

printRankedData <- function(accountName, region, apiKey) {
  tryCatch({
    getRankedData(accountName, region, apiKey)
  }, error = function(e) {
    "Could not get ranked data."
  })
}

getMatchData <- function(accountName, region, apiKey) {
  url = paste("https://", region, ".api.riotgames.com/lol/summoner/v4/summoners/by-name/", accountName, "?api_key=", apiKey, sep = "")
  accountInfo = GET(url)
  accountInfo = fromJSON(rawToChar(accountInfo$content))
  
  url = paste("https://", region, ".api.riotgames.com/lol/match/v4/matchlists/by-account/", accountInfo$accountId, "?api_key=", apiKey, sep = "")
  matchData = GET(url)
  matchData = fromJSON(rawToChar(matchData$content))
  
  return(matchData$matches)
}

# TODO: finish graphCommonChamps
graphCommonChamps <- function(matchData) {
  # TODO: learn how to graph lol
  # TODO: map roles properly https://riot-api-libraries.readthedocs.io/en/latest/roleid.html
  # TODO: map names to keys; check py
  
  champFreq <- matchData %>%
    select(champion, lane) %>% 
    group_by(lane, champion) %>% 
    count()
}