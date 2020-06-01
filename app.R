library(shiny)
library(plyr)
library(dplyr)
library(httr)
library(jsonlite)
library(ggplot2)
library(knitr)
library(scales)
library(gridExtra)
library(anytime)

source("app_ui.R")
source("app_server.R")
source("./scripts/apikey.R")
source("./scripts/graphChampion.R")
source("./scripts/graphTime.R")
source("./scripts/graphWinratePie.R")

numGames <- 20

shinyApp(ui = ui, server = server)