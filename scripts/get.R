source("./scripts/apikey.R")

get_ranked_data <- function(account_name, region, api_key) {
  url <- paste("https://", region,
              ".api.riotgames.com/lol/summoner/v4/summoners/by-name/",
              account_name,
              "?api_key=",
              api_key,
              sep = "")
  account_info <- GET(url)
  account_info <- fromJSON(rawToChar(account_info$content))

  url <- paste("https://", region,
              ".api.riotgames.com/lol/league/v4/entries/by-summoner/",
              account_info$id,
              "?api_key=",
              api_key,
              sep = "")
  ranked_data <- GET(url)
  ranked_data <- fromJSON(rawToChar(ranked_data$content))

  solo_q_rank <- ranked_data %>%
    filter(queueType == "RANKED_SOLO_5x5") %>%
    select(tier, rank)

  solo_q_rank <- paste(tolower(solo_q_rank$tier), solo_q_rank$rank, sep = " ")

  summoner_name <- ranked_data %>%
    filter(queueType == "RANKED_SOLO_5x5") %>%
    select(summonerName) %>%
    pull()

  current_lp <- ranked_data %>%
    filter(queueType == "RANKED_SOLO_5x5") %>%
    select(leaguePoints) %>%
    pull()

  return(c(name = summoner_name,
           rank = solo_q_rank,
           LP = current_lp))
}


get_match_data <- function(account_name, region, api_key) {
  url <- paste("https://", region,
              ".api.riotgames.com/lol/summoner/v4/summoners/by-name/",
              account_name,
              "?api_key=",
              api_key,
              sep = "")
  account_info <- GET(url)
  account_info <- fromJSON(rawToChar(account_info$content))

  url <- paste("https://",
              region,
              ".api.riotgames.com/lol/match/v4/matchlists/by-account/",
              account_info$accountId,
              "?api_key=",
              api_key,
              sep = "")
  match_data <- GET(url)
  match_data <- fromJSON(rawToChar(match_data$content))

  return(match_data$matches)
}

get_champion_constants <- function() {
  url <-
    "http://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion.json"
  champion_constants <- GET(url)
  champion_constants <- fromJSON(content(champion_constants, "text"))
  champion_constants <- champion_constants$data

  return(champion_constants)
}

get_single_match_data <- function(match_id, champ_id, region, api_key) {
  url <- paste("https://", region,
               ".api.riotgames.com/lol/match/v4/matches/",
               match_id,
               "?api_key=",
               api_key,
               sep = "")
  single_match_data <- GET(url)
  single_match_data <- fromJSON(rawToChar(single_match_data$content))
  participants <- single_match_data$participants

  player_stats <- participants %>%
    filter(championId == champ_id)

  return(player_stats)
}

get_single_match_data_gcid <- function(game_champ_id, api_key) {

  game_champ_id <- strsplit(game_champ_id, " ")[[1]]
  match_id <- game_champ_id[[1]]
  champ_id <- game_champ_id[[2]]

  match_data <- get_single_match_data(match_id, champ_id, "na1", api_key)

  player_match_stats <- match_data$stats

  return(player_match_stats)
}

get_recent_match_data <- function(game_champ_id, api_key) {
  n <- 0
  return_df <- data.frame()
  game_champ_id <- head(game_champ_id, n = 20)
  for (game in game_champ_id) {
    Sys.sleep(0.2)
    n <- n + 1
    if ((n - 1) %% 10 == 0 && n > 5) {
      message("Waiting 2 seconds for rate limit.")
      Sys.sleep(2)
    }

    message(paste0("Getting stats for match ", game, "; match no ", n))

    new_match_data <- get_single_match_data_gcid(game, apikey)
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

  return_df$game_champ_id <- game_champ_id

  return(return_df)
}
