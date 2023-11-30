# clean the console
cat("\f")

# clean the environment
rm(list = ls())

# retrieve data from the scv file
data <- read.csv("communities.csv")
