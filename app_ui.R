ui <- material_page(title = "LoL Stats",
                    fluid = TRUE,
                    primary_theme_color = "rgba(56, 119, 175, 1)",
                    secondary_theme_color = "rgba(56, 119, 175, 1)",
   material_side_nav(
     fixed = FALSE,
     fluidRow(
       column(
         12, align = "center",
         h4("UW INFO 201 Final")
       )
     ),
     fluidRow(
       column(1),
       column(
         10,
         p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam nec justo fringilla, dictum lacus eu, mattis urna. Phasellus varius hendrerit enim ac luctus. Integer eget nibh odio. Phasellus sit amet hendrerit arcu, non mollis enim. Nulla a neque mi. Integer quis libero vel odio maximus commodo. Cras gravida aliquam diam ullamcorper molestie. Vestibulum sodales metus enim, et ullamcorper sem aliquet et. Nulla auctor metus vel nisl tempor venenatis. Vivamus vel euismod velit, aliquet venenatis purus. Aliquam porta pellentesque lobortis. In laoreet nulla nec nisl sagittis pellentesque. Ut dignissim nec massa id ultricies. In placerat scelerisque massa, sed dapibus metus tempus at.
           
           Mauris malesuada volutpat nibh, eu vulputate tellus semper ut. Morbi facilisis leo vitae mattis luctus. Suspendisse faucibus, eros in vestibulum fringilla, mauris magna porta mi, nec condimentum urna velit et ante. In at congue dui. Nunc eu erat ut purus finibus luctus non eu metus. Maecenas quis maximus quam. Sed luctus tortor mattis libero accumsan cursus. Quisque eu magna eu ex ullamcorper mollis. Vestibulum efficitur diam vitae aliquam faucibus. Nulla nibh sapien, molestie in blandit et, eleifend sed turpis. Phasellus a consectetur urna, a tincidunt erat. Praesent sagittis commodo fermentum.")

       ),
       column(1)
     )
   ), 
   material_tabs(
     tabs = c("Account" = "account",
              "Detailed Statistics" = "tableStats",
              "Champions" = "champGraph",
              "Time" = "timeGraph",
              "Win/Loss" = "winLossGraph",
              "Trends" = "timeStatsGraph")
   ),
   
   material_tab_content(tab_id = "account",
            column(1),
            
            column(
              3, align = "center", div(style = "height:20px"),
              fluidRow(
                h5("Account Info"),
                material_text_box(
                  input_id = "accountName",
                  label = "Account Name"),
              ),
              
              fluidRow(
                material_dropdown("region",
                                  "Region",
                                  choices =
                                     c("NA" = "na1",
                                       "EUW" = "euw1",
                                       "KR" = "kr")
                ),
              ),
                
             fluidRow(
                material_slider(
                   input_id = "numGames",
                   label = "Number of Matches to Query:",
                   min_value = 1,
                   max_value = 100,
                   initial_value = 50,
                   step_size = 1
                ),
             ),
             
             fluidRow(
                actionButton(
                  inputId = "submit_loc",
                  label = "Get stats")
             )
              
            ),
            
            column(
              7, align = "center", div(style = "height:20px"),
              fluidRow(
                column(
                  12, align = "center",
                  h5("Basic Stats"),
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
            ),
            column(1),
            
   ),
   
   material_tab_content(tab_id = "tableStats",
            fluidRow(
              column(6, align = "center", div(style = "height:20px"),
                     selectInput("championSelect",
                                 "Champion:",
                                 c("All",
                                   unique(as.character(champion_constants$name))))
              ),
              column(6, align = "center", div(style = "height:20px"),
                     selectInput("winLossSelect",
                                 "Win/Loss:",
                                 c("All",
                                   "Win",
                                   "Loss"))
              )
            ),
            fluidRow(
               column(1),
               column(10, align = "center", div(style = "height:20px"),
                      DT::dataTableOutput("tableChampion")
                      ),
               column(1)
            )
   ),
   
   material_tab_content(tab_id = "champGraph",
            column(12, div(style = "height:20px"),
                   plotlyOutput(outputId = "graphChampion")
            )
   ),
   
   material_tab_content(tab_id = "timeGraph",
            column(12, div(style = "height:20px"),
                   plotlyOutput(outputId = "graphTime")
            )
   ),
   
   material_tab_content(tab_id = "winLossGraph",
      fluidPage(
         column(
            3, align = "center", div(style = "height:20px"),
            plotlyOutput(outputId = "graphWinKDA")
         ),
         column(
            3, align = "center", div(style = "height:20px"),
            plotlyOutput(outputId = "graphWinDmg")
         ),
         column(
            3, align = "center", div(style = "height:20px"),
            plotlyOutput(outputId = "graphWinGold")
         ),
         column(
            3, align = "center", div(style = "height:20px"),
            plotlyOutput(outputId = "graphWinCS")
         ),
      )    
   ),
   
   material_tab_content(tab_id = "timeStatsGraph",
      fluidPage(
         fluidRow(
            column(6, align = "center", div(style = "height:20px"),
                   selectInput(
                      "timeGraphXData", "Choose an x variable",
                      choices = c(
                         "Game Number" = "gameNum",
                         "Date" = "date"
                      )    
                   ),
                   
            ),
            column(6, align = "center", div(style = "height:20px"),
                   selectInput(
                      "timeGraphYData", "Choose a variable",
                      choices = c(
                         "Kills" = "kills",
                         "Deaths" = "deaths",
                         "Assists" = "assists",
                         "Total Damage" = "totalDamageDealt",
                         "Magic Damage" = "magicDamageDealt",
                         "Physical Damage" = "physicalDamageDealt",
                         "True Damage" = "trueDamageDealt",
                         "Champion Damage" = "totalDamageDealtToChampions",
                         "Objective Damage" = "damageDealtToObjectives",
                         "Tower Damage" = "damageDealtToTurrets",
                         "Damage Taken" = "totalDamageTaken",
                         "Gold Earned" = "goldEarned",
                         "Tower Kills" = "turretKills",
                         "CS" = "totalCreepScore",
                         "Vision Score" = "visionScore"
                      )    
                   ),
                   
            ),
         ),
         
         fluidRow(
            column(1),
            column(10,  div(style = "height:90%"),
                   plotlyOutput(outputId = "graphTimeStats")
            ),
            column(1)
         )
      )    
   )
)

