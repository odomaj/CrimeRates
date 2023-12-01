library(car)

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

# calculate VIF Values
vif_values <- vif(fit_mlr)
print("VIF Values")
print(vif_values)

# generate graphs
plot(all_data$PopDens, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. PopDens", xlab = "Normalized Population Density", ylab = "Normalized Violent Crimes per 100k People", pch = 20)
plot(all_data$medIncome, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. medIncome", xlab = "Normalized Median Income", ylab = "Normalized Violent Crimes per 100k People", pch = 20)
plot(all_data$PctUnemployed, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. PctUnemployed", xlab = "Normalized Unemployment Rate", ylab = "Normalized Violent Crimes per 100k People", pch = 20)