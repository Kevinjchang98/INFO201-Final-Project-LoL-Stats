theme_set(theme_minimal())

graph_champion_freq <- function(champion_summary) {
  return_plot <- ggplot(champion_summary,
                              aes(x = name,
                                  y = freq,
                                  group = factor(winInt))) +
  geom_col(aes(fill = factor(winInt, labels = c("Loss", "Win"))),
           width = 0.7) +
    labs(x = "Champion",
         y = "Number of Games Played",
         fill = "Game outcome") +
    ggtitle("Recent Champions Played") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  
  return(return_plot)
}