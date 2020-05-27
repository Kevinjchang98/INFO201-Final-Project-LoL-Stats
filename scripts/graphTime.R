graph_time <- function(time_summary) {
  return_plot <- ggplot(time_summary,
         aes(x = hour,
             y = freq,
             group = factor(winInt))) +
    geom_col(aes(fill = factor(winInt, labels = c("Loss", "Win"))),
             width = 0.7) +
    scale_x_continuous(breaks = seq(0, 24, by = 1),
                       limits = c(0, 24)) +
    labs(x = "Hour of Game Start",
         y = "Number of Games",
         fill = "Game outcome"
         ) +
    ggtitle("Games by Time Started")

  return(return_plot)
}
