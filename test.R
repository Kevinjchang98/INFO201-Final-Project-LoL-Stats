library(httr)
library(jsonlite)
library(dplyr)

region = "na1"
accountName = "dyrus"
apiKey = "RGAPI-bf6d40f1-7678-474c-b4eb-e3f64fd0464a"

url = paste("https://", region, ".api.riotgames.com/lol/summoner/v4/summoners/by-name/", accountName, "?api_key=", apiKey, sep = "")
accountInfo = GET(url)
accountInfo = fromJSON(rawToChar(accountInfo$content))

url = paste("https://", region, ".api.riotgames.com/lol/match/v4/matchlists/by-account/", accountInfo$accountId, "?api_key=", apiKey, sep = "")
print(url)
matchData = GET(url)
matchData = fromJSON(rawToChar(matchData$content))

matchData <- matchData$matches

