library(shiny)
library(png)
source("dataFile.R")

showPic <- function(pic){
  # rotate the picture because image function in R has weild angle for veiwing
  # cat(dim(pic),file=stderr())
  rotated_pic <- t(pic[nrow(pic):1,])
  image(rotated_pic,col = gray((0:32)/32),asp=1,xlim=c(0,1),ylim=c(0,1) )
}

compressedPic <- function(pic,n){
  p.svd <- svd(pic)
  p.svd$u[,1:n] %*% diag(p.svd$d[1:n],nrow=n,ncol=n) %*% t(p.svd$v[,1:n])
}

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output,session) {
  picChoice <- reactive({
    switch(input$picture,
           "Taylor Swift" = swift,
           "Warriors" = warriors,
           "Bruno Mars" = mars)
  })
  
  observe({
    # update sliderInput max value
    updateSliderInput(session, "components", max= min(dim(picChoice())), value = 1  )
  })
  
  
  output$compressedPlt <- renderPlot({    
    n <- input$components
    compressed <- compressedPic(picChoice(),n)
    showPic(compressed)
  })
  
  output$original <- renderPlot({
    showPic(picChoice())
  })
  
})
