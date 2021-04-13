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
titlepanel <- titlePanel("KMeans CLust")
hist <- plotOutput(outputId = "hist")
update <- actionButton(inputId = "update", label = "Update" )
normal <- actionButton(inputId = "normal", label = "Normal")
uniform <- actionButton(inputId = "uniform", label = "Uniform")



######### UI ##########"
ui <- fluidPage(
  titlepanel, nclust, update, scatter, normal,uniform ,hist
  
)


######## SERVER #########
server <- function(input, output) {
  
  data <- reactive(
    {
      input$nclust
    }
  )
  
  data_update <- eventReactive(input$update,
    {
      input$nclust
    }
  )
  
  reactive_values <- reactiveValues(data = rnorm(100))
  
  #Build scatter plot
  output$scatter <- renderPlot(
    {
    km <- kmeans(iris, data_update())
    ggplot(irisclusters, aes(x=Sepal.Length, y = Sepal.Width, color = factor(km$cluster))) + geom_point(size = 5) 
  }
  )
  
  #update hist
  observeEvent(input$normal, reactive_values$data <- rnorm(100))
  observeEvent(input$uniform, reactive_values$data <- runif(100))
  
  #histogram
  output$hist <- renderPlot(
    {
      hist(reactive_values$data , main = "Histogram", xlab = "Num")
    }
  )
  #End server  
}


########### APP ############
shinyApp(ui, server)