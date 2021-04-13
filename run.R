library(shiny)

port <- Sys.getenv('PORT')

shiny::rundApp(
  appDir = getwd(),
  host = 'localhost',
  port = as.numeric(port)
)