library(tidyverse)
library(shiny)
data(iris)
iris <- iris %>% select(-Species)

km <- kmeans(iris, 3)

irisclusters <- cbind(iris, km$cluster)

#yesno <- selectInput(inputId = "yesno", label = "Let the algo choose")

#put in conditional panel
nclust <- sliderInput(inputId = "nclust", min = 2, max = 20, value = 2, label = "Choose")

scatter <- plotOutput(outputId = "scatter")



ui <- fluidPage(
  scatter, nclust, text
  
)


server <- function(input, output) {
  
  
  
  output$scatter <- renderPlot({
    km <- kmeans(iris, input$nclust)
    ggplot(irisclusters, aes(x=Sepal.Length, y = Sepal.Width, color = factor(km$cluster))) + geom_point(size = 5) 
  })
  
  
}


shinyApp(ui, server)