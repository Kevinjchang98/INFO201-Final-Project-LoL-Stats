library(ggplot2)

source("./scripts/summary.R")

graph_champion_freq <- ggplot(data = champion_summary) +
  geom_col(mapping = aes(x = name, y = freq)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Champion", y = "Number of Games Played") +
  ggtitle("Recent Champions Played")
