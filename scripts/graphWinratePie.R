theme_set(theme_minimal())

graph_winrate_pie <- function(winrate) {
  
  return_plot <- ggplot(winrate,
      aes(x = "",
          y = freq,
          fill = winInt)) +
    geom_bar(width = 1,
             stat = "identity") +
    coord_polar("y", start = 0) +
    geom_text(aes(label = freq),
              position = position_stack(vjust = 0.5),
              color = "white",
              size = 10) +
    theme(panel.grid = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          legend.position = "none")
  
  return(return_plot)
}



