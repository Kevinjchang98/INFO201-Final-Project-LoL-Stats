library(httr)
library(jsonlite)
library(dplyr)

source("./scripts/apikey.R")

get_ranked_data <- function(accountName, region, apiKey) {
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
  
  return(paste(summonerName, " is currently ranked ", soloQRank, " in solo queue with ", currentLP, " LP.", sep = ""))
}

print_ranked_data <- function(accountName, region, apiKey) {
  tryCatch({
    getRankedData(accountName, region, apiKey)
  }, error = function(e) {
    "Could not get ranked data."
  })
}

get_match_data <- function(accountName, region, apiKey) {
  url = paste("https://", region, ".api.riotgames.com/lol/summoner/v4/summoners/by-name/", accountName, "?api_key=", apiKey, sep = "")
  accountInfo = GET(url)
  accountInfo = fromJSON(rawToChar(accountInfo$content))
  
  url = paste("https://", region, ".api.riotgames.com/lol/match/v4/matchlists/by-account/", accountInfo$accountId, "?api_key=", apiKey, sep = "")
  matchData = GET(url)
  matchData = fromJSON(rawToChar(matchData$content))
  
  return(matchData$matches)
}

get_champion_constants <- function() {
  url = "http://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion.json"
  championConstants = GET(url)
  championConstants = fromJSON(content(championConstants, "text"))
  championConstants = championConstants$data
  
  return(championConstants)
}

get_single_match_data <- function(matchID, champID, region, apiKey) {
  url = paste("https://", region, ".api.riotgames.com/lol/match/v4/matches/", matchID, "?api_key=", apiKey, sep = "")
  singleMatchData = GET(url)
  singleMatchData = fromJSON(rawToChar(singleMatchData$content))
  participants = singleMatchData$participants
  
  player_stats <- participants %>% 
    filter(championId == champID)
  
  return(player_stats)
}

get_win_boolean <- function(gameChampId, apiKey) {
  
  gameChampId <- strsplit(gameChampId, " ")[[1]]
  matchId <- gameChampId[[1]]
  champId <- gameChampId[[2]]
  
  matchData <- get_single_match_data(matchId, champId, "na1", apiKey)
  
  playerMatchStats <- matchData$stats
  
  return(playerMatchStats$win)
}

# Note: Rate limit 20 req per 1 sec, and 100 req per 2 min
get_win_boolean_list <- function(gameChampId, apiKey) {
  return_list <- list()
  for(game in gameChampId) {
    Sys.sleep(0.06)
    print(paste0("Getting win/loss stat for match ", game))
    return_list <- c(return_list, get_win_boolean(game, apikey))
  }
  return(return_list)
}

