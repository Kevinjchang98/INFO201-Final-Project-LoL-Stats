ui <- navbarPage("LoL Stats", fluid = TRUE,
   tabPanel("Basic Player Stats",
     fluidPage(
       sidebarLayout(
         sidebarPanel(
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
           
           actionButton(
             inputId = "submit_loc",
             label = "Get stats"
           )
         ),
         
         mainPanel(
           h1("Recent Match Stats"),
           
           textOutput(outputId = "basicInfo"),
           
           plotOutput(outputId = "graphWinratePie")
           
         )
       )
     ),
   ),
   
   tabPanel("Player Statistics",
     fluidPage(
       plotOutput(outputId = "graphChampion"),
       
       plotOutput(outputId = "graphTime")
     )    
            
            
   )
                 
                 
                 
)
  
  
  
  
  
  
