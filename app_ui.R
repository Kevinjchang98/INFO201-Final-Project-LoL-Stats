ui <- navbarPage("LoL Stats", fluid = TRUE,
   tabPanel("Player Stats",
      fluidRow(
        column(
          3,
          h1("Account Info"),
          textInput(
            inputId = "accountName",
            label = "Account Name:",
            placeholder = "Account Name"
          ),
          
          selectInput("region", "Region:",
                      c("NA" = "na1",
                        "EUW" = "euw1",
                        "KR" = "kr")),
          
          sliderInput("numGames", "Number of Matches:",
                      min = 1,
                      max = 100,
                      value = 100,
                      step =1),
          
          actionButton(
            inputId = "submit_loc",
            label = "Get stats"
          )
        ),
        column(
          9,
          h1("Recent Match Stats"),
          textOutput(outputId = "basicInfo"),
          
          column(
            6, align = "center",
            league <- textOutput(outputId = "league"),
            uiOutput(outputId = "leagueImage"),
          ),
          column(
            6, align = "center",
            plotOutput(outputId = "graphWinratePie")
            
          )
          
          

          
          
        )
      )
   ),
   
   tabPanel("Player Statistics",
     fluidPage(
       plotOutput(outputId = "graphChampion"),
       
       plotOutput(outputId = "graphTime")
     )    
            
            
   )
)
  
  
  
  
  
  
