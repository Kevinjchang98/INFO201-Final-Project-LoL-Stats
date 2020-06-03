# ui <- navbarPage("LoL Stats", fluid = TRUE,
#   tabPanel("Account",
#     column(
#       3, align = "center",
#       fluidRow(
#         h1("Account Info"),
#         textInput(
#           inputId = "accountName",
#           label = "Account Name:",
#           placeholder = "Account Name"),
#         
#         selectInput("region", "Region:",
#                     c("NA" = "na1",
#                       "EUW" = "euw1",
#                       "KR" = "kr")
#         ),
#         
#         sliderInput("numGames", "Number of Matches to Query:",
#                     min = 1,
#                     max = 100,
#                     value = 50,
#                     step =1),
#         
#         actionButton(
#           inputId = "submit_loc",
#           label = "Get stats")
#       )
#     ),
#     
#     column(
#       9, align = "center",
#       fluidRow(
#         column(
#           12, align = "center",
#           h1("Player Profile"),
#           fluidRow(
#             league <- textOutput(outputId = "league"),
#             uiOutput(outputId = "leagueImage"),
#             textOutput(outputId = "basicInfo")
#           )
#         ),
#       ),
#       fluidRow(
#         column(4,
#                plotlyOutput(outputId = "graphRolePie")
#         ),
#         column(4,
#                plotlyOutput(outputId = "graphWinratePie")
#         ),
#         column(4,
#                plotlyOutput(outputId = "graphKDAPie")
#         ),
#         
#       ),
#     )
#   ),
#   
#   tabPanel("Detailed Statistics",
#            
#            fluidRow(
#              column(4,
#                     selectInput("championSelect",
#                                 "Champion:",
#                                 c("All",
#                                   unique(as.character(champion_constants$name))))
#              ),
#              column(4,
#                     selectInput("winLossSelect",
#                                 "Win/Loss:",
#                                 c("All",
#                                   "Win",
#                                   "Loss"))
#              )
#            ),
#            DT::dataTableOutput("tableChampion")
#   ),
# 
#   tabPanel("Champions",
#     fluidPage(
#       plotlyOutput(outputId = "graphChampion")
#     )    
#   ),
#   
#   tabPanel("Time",
#     fluidPage(
#       plotlyOutput(outputId = "graphTime")
#     )    
#   )
# )




ui <- material_page(title = "LoL Stats", fluid = TRUE,
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
              "Win/Loss" = "winLossGraph")
   ),
   material_tab_content(tab_id = "account",
            column(
              4, align = "center",
              fluidRow(
                h4("Account Info"),
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
              8, align = "center",
              fluidRow(
                column(
                  12, align = "center",
                  h4("Player Profile"),
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
   
   material_tab_content(tab_id = "tableStats",
            
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
   
   material_tab_content(tab_id = "champGraph",
            fluidPage(
              plotlyOutput(outputId = "graphChampion")
            )    
   ),
   
   material_tab_content(tab_id = "timeGraph",
            fluidPage(
              plotlyOutput(outputId = "graphTime")
            )    
   ),
   
   material_tab_content(tab_id = "winLossGraph",
      fluidPage(
         column(
            3, align = "center",
            plotlyOutput(outputId = "graphWinKDA")
         ),
         column(
            3, align = "center",
            plotlyOutput(outputId = "graphWinDmg")
         ),
         column(
            3, align = "center",
            plotlyOutput(outputId = "graphWinGold")
         ),
         column(
            3, align = "center",
            plotlyOutput(outputId = "graphWinCS")
         ),
      )    
   )
)

