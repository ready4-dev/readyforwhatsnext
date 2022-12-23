## This app is adapted from the app distributed with the DependenciesGraphs package
dashboardPage(
  dashboardHeader(title = "Explore ready4"),
  dashboardSidebar(sidebarMenu(id = "Tabsetpan",
                               menuItem("Pathway 1", tabName = "Libraries", icon = icon("dashboard")),
                               conditionalPanel(condition = "input.Tabsetpan === 'Libraries'",
                                                selectInput('packages', "Step 1 - Select libraries to map :", choices = c(make_framework_pkgs_chr(), make_modules_pks_chr()),#installed.packages()[, 1], 
                                                            multiple = T, width = "100%"),
                                                div(actionButton("GOPackage", "Go !",icon = icon("line-chart")), align = "center")
                               ),
                               menuItem("Function profile", tabName = "Functions"#, icon = icon("th")
                                        ),
                               conditionalPanel(condition = "input.Tabsetpan === 'Functions'",
                                                selectInput('package', "Step 4(b) - Update library : ", choices = c(make_framework_pkgs_chr(), make_modules_pks_chr()),#installed.packages()[, 1],
                                                            multiple = FALSE, width = "100%"),
                                                div(actionButton("GOFunc2", "Update library",icon = icon("line-chart")), align = "center")
                               ),
                               menuItem("Pathway 2", tabName = "Custom", icon = icon("dashboard"))
                               
  )),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    tags$head(tags$link(rel='stylesheet', type='text/css', href='style.css')),
    tabItems(
      # First tab content
      tabItem(tabName = "Libraries",
              # fluidRow(
              #   column(3, div(h3('Package(s) selection :'), align = "center")),
              #   column(6, br(), selectInput('packages', NULL, choices = installed.packages()[,1], multiple = T, width = "100%")),
              #   column(3, br(), div(actionButton("GOPackage", "Launch",icon = icon("line-chart")), align = "center"))
              # ),
              # hr(),
              
              fluidRow(
                box(
                  solidHeader = TRUE, collapsible = TRUE, title = "Step 2 - Select library to profile (use the first drop-down menu or else click on a graph node)",
                  status = "primary",
                  visNetworkOutput("main_plot", width = "100%",height = "750px"),
                  br()
                  ,width = 12
                ),
                box(
                  solidHeader = TRUE, collapsible = TRUE, title = "Overview",
                  status = "primary",
                  div(
                    dataTableOutput("tabledep"),
                    uiOutput("Groupebutton"),
                    align="center"
                  ), 
                  width=12)
              )
              
      ),
      tabItem(tabName = "Functions",
              fluidRow(
                box(
                  solidHeader = TRUE, collapsible = TRUE, title = "Step 4 (a) - Select a function to profile",
                  status = "primary",
                  div(h4(textOutput("zoomin")), align = "center"),
                  visNetworkOutput("main_plot1", width = "100%",height = "750px"),
                  br()
                  ,width = 12
                ),
                box(
                  solidHeader = TRUE, collapsible = TRUE, title = "Contents",
                  status = "primary",
                  div(
                    # h4(textOutput("info")),
                    dataTableOutput("datatable2")
                    ,align="center"
                  ),
                  width=12)
              ),
              
              fluidRow(
                box(
                  uiOutput("help"),width = 12
                )
              )
      ),
                      # tabPanel("Script",
                      # 
                      # 
                      #          fluidRow(
                      #            box(
                      #              fileInput('file1', 'Choose R File',
                      #                        accept=NULL),
                      #              visNetworkOutput("plotscript", width = "100%",height = "700px")
                      #              ,width = 12)
                      #          )
                      # ),
      
      tabItem(tabName = "Custom",
              
              
              fluidRow(
                box(
                  fluidRow(
                    column(width=4,
                           selectizeInput(inputId = "packageslist" , "Step 1 - Add libraries :", 
                                          choices = c(make_framework_pkgs_chr(), make_modules_pks_chr()),#installed.packages()[, 1],
                                          multiple = TRUE)
                    ),
                    column(width=2, 
                           br(), div(actionButton("chargedf", "Step 2 - Find functions", style = "padding: 8px 20px 8px 20px;"),align="center")
                    ),
                    column(width=4,
                           selectizeInput(inputId = "functionlist" , "Step 3 - Select function(s) :", choices = NULL, multiple = TRUE)
                    ),
                    column(width=2, 
                           br(), div(actionButton("makegraph", "Step 4 - Make graph", style = "padding: 8px 20px 8px 20px;"),align = "center")
                    )
                  ),
                  
                  hr(),
                  visNetworkOutput("chossefunctionplot", width = "100%",height = "750px"),
                  br(),
                  width = 12)
              )
      )
      
      
    )
  )
)



