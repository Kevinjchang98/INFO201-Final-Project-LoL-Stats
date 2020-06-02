ui <- navbarPage("LoL Stats", fluid = TRUE,
  tabPanel("Account",
    column(
      3, align = "center",
      fluidRow(
        h1("Account Info"),
        textInput(
          inputId = "accountName",
          label = "Account Name:",
          placeholder = "Account Name"),
        
        selectInput("region", "Region:",
                    c("NA" = "na1",
                      "EUW" = "euw1",
                      "KR" = "kr")
        ),
        
        sliderInput("numGames", "Number of Matches to Query:",
                    min = 1,
                    max = 100,
                    value = 50,
                    step =1),
        
        actionButton(
          inputId = "submit_loc",
          label = "Get stats")
      )
    ),
    
    column(
      9, align = "center",
      fluidRow(
        column(
          12, align = "center",
          h1("Player Profile"),
          fluidRow(
            league <- textOutput(outputId = "league"),
            uiOutput(outputId = "leagueImage"),
            textOutput(outputId = "basicInfo")
          )
        ),
      ),
      fluidRow(
        column(4,
               plotlyOutput(outputId = "graphRolePie")
        ),
        column(4,
               plotlyOutput(outputId = "graphWinratePie")
        ),
        column(4,
               plotlyOutput(outputId = "graphKDAPie")
        ),
        
      ),
    )
  ),
  
  tabPanel("Detailed Statistics",
           
           fluidRow(
             column(4,
                    selectInput("championSelect",
                                "Champion:",
                                c("All",
                                  unique(as.character(champion_constants$name))))
             ),
             column(4,
                    selectInput("winLossSelect",
                                "Win/Loss:",
                                c("All",
                                  "Win",
                                  "Loss"))
             )
           ),
           DT::dataTableOutput("tableChampion")
  ),

  tabPanel("Champions",
    fluidPage(
      plotlyOutput(outputId = "graphChampion")
    )    
  ),
  
  tabPanel("Time",
    fluidPage(
      plotlyOutput(outputId = "graphTime")
    )    
  )
)
