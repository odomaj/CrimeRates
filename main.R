# clean the console
cat("\f")

# clean the environment
rm(list = ls())

# retrieve data from the scv file
all_data <- read.csv("communities.csv")

# perform multilinear regression
fit_mlr <- lm(ViolentCrimesPerPop ~ PopDens + medIncome + PctUnemployed, data = all_data)

# print the summary of regression model
print(summary(fit_mlr))