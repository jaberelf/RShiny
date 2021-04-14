packages <- c("shiny", "tidyverse")

install_missing = function(p) {
  if(p %in% rownames(installed.packages()) == F)
  {
    install.packages(p)
  }
}  

invisible(sapply(packages, install_missing))