#library(ggplot2)
theme_set(theme_minimal())

#source("./scripts/summary.R")

graph_winrate <- function(win_summary) {
  graph_kda <- ggplot(data = win_summary) +
    geom_col(mapping = aes(x = win, y = avgKDA, fill = win)) +
    geom_errorbar(aes(ymin = avgKDA - sigmaKDA,
                      ymax = avgKDA + sigmaKDA,
                      y = avgKDA,
                      x = win),
                  width = 0.2) +
    labs(x = "Win/Loss", y = "KDA")  +
    ggtitle("KDA") +
    theme(legend.position = "none")
  
  graph_dmg <- ggplot(data = win_summary) +
    geom_col(mapping = aes(x = win, y = avgTotDmg, fill = win)) +
    geom_errorbar(aes(ymin = avgTotDmg - sigmaTotDmg,
                      ymax = avgTotDmg + sigmaTotDmg,
                      y = avgTotDmg,
                      x = win),
                  width = 0.2) +
    labs(x = "Win/Loss", y = "Average Total Damage")  +
    ggtitle("Damage") +
    scale_y_continuous(labels = comma) +
    theme(legend.position = "none")
  
  graph_gold <- ggplot(data = win_summary) +
    geom_col(mapping = aes(x = win, y = avgGoldEarned, fill = win)) +
    geom_errorbar(aes(ymin = avgGoldEarned - sigmaGoldEarned,
                      ymax = avgGoldEarned + sigmaGoldEarned,
                      y = avgGoldEarned,
                      x = win),
                  width = 0.2) +
    labs(x = "Win/Loss", y = "Average Gold Earned")  +
    ggtitle("Gold Earned") +
    scale_y_continuous(labels = comma) +
    theme(legend.position = "none")
  
  graph_cs <- ggplot(data = win_summary) +
    geom_col(mapping = aes(x = win, y = avgCS, fill = win)) +
    geom_errorbar(aes(ymin = avgCS - sigmaCS,
                      ymax = avgCS + sigmaCS,
                      y = avgCS,
                      x = win),
                  width = 0.2) +
    labs(x = "Win/Loss", y = "Average CS")  +
    ggtitle("Creep Score") +
    scale_y_continuous(labels = comma) +
    theme(legend.position = "none")
  
  return(grid.arrange(graph_kda, graph_dmg, graph_gold, graph_cs,
                      nrow = 1))
}
