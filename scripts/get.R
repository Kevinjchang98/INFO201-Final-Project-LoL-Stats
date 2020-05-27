source("./scripts/apikey.R")

get_ranked_data <- function(accountName, region, apiKey) {
  url <- paste("https://", region,
              ".api.riotgames.com/lol/summoner/v4/summoners/by-name/",
              accountName,
              "?api_key=",
              apiKey,
              sep = "")
  accountInfo <- GET(url)
  accountInfo <- fromJSON(rawToChar(accountInfo$content))

  url <- paste("https://", region,
              ".api.riotgames.com/lol/league/v4/entries/by-summoner/",
              accountInfo$id,
              "?api_key=",
              apiKey,
              sep = "")
  rankedData <- GET(url)
  rankedData <- fromJSON(rawToChar(rankedData$content))

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

  return(c(name = summonerName,
           rank = soloQRank,
           LP = currentLP))
}

print_ranked_data <- function(accountName, region, apiKey) {
  tryCatch({
    getRankedData(accountName, region, apiKey)
  }, error = function(e) {
    "Could not get ranked data."
  })
}

get_match_data <- function(accountName, region, apiKey) {
  url <- paste("https://", region,
              ".api.riotgames.com/lol/summoner/v4/summoners/by-name/",
              accountName,
              "?api_key=",
              apiKey,
              sep = "")
  accountInfo <- GET(url)
  accountInfo <- fromJSON(rawToChar(accountInfo$content))

  url <- paste("https://",
              region,
              ".api.riotgames.com/lol/match/v4/matchlists/by-account/",
              accountInfo$accountId,
              "?api_key=",
              apiKey,
              sep = "")
  matchData <- GET(url)
  matchData <- fromJSON(rawToChar(matchData$content))

  return(matchData$matches)
}

get_champion_constants <- function() {
  url <-
    "http://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion.json"
  championConstants <- GET(url)
  championConstants <- fromJSON(content(championConstants, "text"))
  championConstants <- championConstants$data

  return(championConstants)
}

get_single_match_data <- function(matchID, champID, region, apiKey) {
  url <- paste("https://", region,
               ".api.riotgames.com/lol/match/v4/matches/",
               matchID,
               "?api_key=",
               apiKey,
               sep = "")
  singleMatchData <- GET(url)
  singleMatchData <- fromJSON(rawToChar(singleMatchData$content))
  participants <- singleMatchData$participants

  player_stats <- participants %>%
    filter(championId == champID)

  return(player_stats)
}

get_single_match_data_gameChampId <- function(gameChampId, apiKey) {

  gameChampId <- strsplit(gameChampId, " ")[[1]]
  matchId <- gameChampId[[1]]
  champId <- gameChampId[[2]]

  matchData <- get_single_match_data(matchId, champId, "na1", apiKey)

  playerMatchStats <- matchData$stats

  return(playerMatchStats)
}

get_recent_match_data <- function(gameChampId, apiKey) {
  n <- 0
  return_df <- data.frame()
  # For debugging use gameChampId <- head(gameChampId, n = 20)
  for (game in gameChampId) {
    Sys.sleep(0.2)
    n <- n + 1
    if ((n - 1) %% 10 == 0 && n > 5) {
      message("Waiting 2 seconds for rate limit.")
      Sys.sleep(2)
    }

    message(paste0("Getting stats for match ", game, "; match no ", n))

    new_match_data <- get_single_match_data_gameChampId(game, apikey)
    if (n == 1) {
      return_df <- rbind(return_df, new_match_data)
    }
    else {
      common_cols <- intersect(colnames(return_df), colnames(new_match_data))

      return_df <- rbind(
        subset(return_df, select = common_cols),
        subset(new_match_data, select = common_cols)
      )
    }
  }

  return_df$gameChampId <- gameChampId

  return(return_df)
}