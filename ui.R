library(shiny)
source("dataFile.R")
# Define UI for application that plots random distributions 
shinyUI(fluidPage(
  theme = "bootstrap.css",
  
  # Application title
  headerPanel("Playing with Picture Compressions"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    # 
    br(),
    h4("Singular Value Decomposition (SVD) For Image Compressions"),
    br(),
    p("svd makes 'lossy' compression for image and recovers the image using the components from the decomposition."),
    p("To check the quality of compression via SVD, please choose a picture and the number of components. Both the original and recovered pictures are shown on the right"),
    
    selectInput("picture", "Choose a picture: ",
                choices = c("Taylor Swift", "Bruno Mars", "Warriors")),
    
    helpText("Note: it may take a few seconds to half minute to plot pictures, depending on the size"),
    
    sliderInput("components", 
                "Number of components:", 
                min = 1,
                max = 400, 
                value = 1),
    # add instructions as help text
    helpText("Note: the number of components is strictly between 1 and the dimension of original pictures. More components will lead to higher definition but poorer compression capability")
    
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    h4("Original Black/While Picture"),
    plotOutput("original"),
    h4("Compressed Black/While Picture"),
    plotOutput("compressedPlt")
  )
))
