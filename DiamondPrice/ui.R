#
# This is the user-interface definition of a Shiny web application.
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diamond price - prediction"),
  
  # Sidebar with options selectors 
  sidebarLayout(
    sidebarPanel(
      helpText("Based on the selected diamond characteristics,it predicts the price"),
      h3(helpText("Select characteristics:")),
      numericInput("car", label = h4("Carats"), step = 0.01, value = 2),
      selectInput("cut", label = h4("Cut"), 
                  choices = list("Unknown" = "*", "Fair" = "Fair", "Good" = "^Good",
                                 "Very Good" = "Very Good", "Premium" = "Premium",
                                 "Ideal" = "Ideal")),
      selectInput("col", label = h4("Color"), 
                  choices = list("Unknown" = "*", "D" = "D", "E" = "E",
                                 "F" = "F", "G" ="G",
                                 "H" = "H", "I" = "I",
                                 "J" = "J"))
      
    ),
    
    # Show a plot with diamonds and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Predicted price of diamond:"),
      h3(textOutput("result"))
    )
  )
))