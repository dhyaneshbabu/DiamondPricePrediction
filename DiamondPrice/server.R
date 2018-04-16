#
# This is the server logic of a Shiny web application.
#

library(shiny)
library(ggplot2)
library(dplyr)
# select columns to be used in the analysis
filtered_diamond <- diamonds[,c(1:3,7)]
# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # select diamonds depending of user input
    filtered_diamond <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color) 
                   )
    # build linear regression model
    fit <- lm( price~carat, filtered_diamond)
    # predicts the price 
    predicted_value <- predict(fit, newdata = data.frame(carat = input$car,
                                              cut = input$cut,
                                              color = input$col
                                              ))
    # Drow the plot using ggplot2
    plot <- ggplot(data=filtered_diamond, aes(x=carat, y = price))+
      geom_point(aes(color = cut), alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$car, color = "red")+
      geom_hline(yintercept = predicted_value, color = "green")
    plot
  })
  output$result <- renderText({
    # renders the text for the prediction below the graph
    filtered_diamond <- filter(diamonds, grepl(input$cut, cut), grepl(input$col, color))
    fit <- lm( price~carat, filtered_diamond)
    predicted_value <- predict(fit, newdata = data.frame(carat = input$car,
                                              cut = input$cut,
                                              color = input$col
                                              ))
    result <- paste(round(predicted_value, digits = 2), "$")
    result
  })
  
})