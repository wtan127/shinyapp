library(shiny)
library(dplyr)

##Data processing
aggspx <- read.csv("U:/shinyapp/aggspx.csv")
agg <- aggspx[ ,1:2]
spx <- aggspx[ ,3:4]
agg$Agg_Date <- as.Date(agg$Agg_Date, "%m/%d/%Y")
spx$SPX_Date <- as.Date(spx$SPX_Date, "%m/%d/%Y")
alldates <- merge(agg, spx, by.x="Agg_Date", by.y="SPX_Date")
agganchor <- alldates$Agg[1]
alldates$aggreturn <- (alldates$Agg - agganchor)/agganchor
spxanchor <- alldates$SPX[1]
alldates$spxreturn <- (alldates$SPX - spxanchor)/spxanchor

shinyServer(function(input, output) {

  return <- reactive({
    alldates$aggreturn * (1- (input$eq / 100)) + alldates$spxreturn * (input$eq / 100)
  })
  
  output$returnPlot <- renderPlot({

        plot(alldates$Agg_Date, return(), 
    type="l", 
    main="Weighted Returns", 
    xlab="Date", 
    ylab="Returns as of Jan 2000", 
    col="green")
  })
})