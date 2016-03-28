library(shiny)

shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Asset Allocation Returns"),

  # Sidebar with a slider input for number of observations
  sidebarPanel(
    h3('Use slider to change equities vs. fixed income allocation'),
    sliderInput("eq", 
                "Percent Allocated in Equities:", 
                min = 0,
                max = 100, 
                value = 50)
  ),

  # Show a plot of the returns
  mainPanel(
    plotOutput("returnPlot")
  )
))