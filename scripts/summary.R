source("./scripts/get.R")
library(plyr)

# Take in input from index
summary <- function(name, region) {
  
  # Get updated information about champions
  champion_constants <<- get_champion_constants() %>% 
    ldply(data.frame)
  
  champion_constants[,'key'] <- as.numeric(as.character(champion_constants[,'key']))
  
  champion_constants <<- champion_constants[!duplicated(champion_constants$key), ]
  
  ## Player specific data
  # Basic sentence getting current solo queue status
  ranked_summary <<- get_ranked_data(name, region, apikey)
  
  # Get most recent matches and its data
  match_summary <<- get_match_data(name, region, apikey) %>%
    mutate(gameChampId = paste(gameId, champion))
  
  # This asks for 100 requests, which can easily hit the 100 requests per 2 min
  # rate limit so there's a Sys.sleep(120) before this to reset the timer
  #
  # get_win_boolean_list() function has a Sys.sleep(0.06) to prevent hitting the
  # 20 requests per 1 second rate limit
  Sys.sleep(120)
  
  match_summary <- match_summary %>% 
    mutate(win = get_win_boolean_list(gameChampId, apikey),
           winInt = as.integer(as.logical(win)))
  
  # Data per champion played
  champion_summary <<- match_summary %>% 
    group_by(champion) %>% 
    count('champion') %>% 
    dplyr::rename(key = champion) %>% 
    left_join(champion_constants)
  
  # Winrate
  winrate <- mean(match_summary$winInt)
}

name <- "boxbox"
region <- "na1"
