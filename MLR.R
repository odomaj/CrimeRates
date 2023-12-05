library(car)

# clean the console
cat("\f")

# clean the environment
rm(list = ls())


# retrieve data from the scv file
all_data <- read.csv("communities.csv")

fit_mlr <- lm(ViolentCrimesPerPop ~ population + racepctblack + 
    racePctHisp + agePct12t29 + pctUrban + medIncome + pctWWage + 
    pctWFarmSelf + pctWInvInc + pctWRetire + medFamInc + whitePerCap + 
    indianPerCap + HispPerCap + PctPopUnderPov + PctLess9thGrade +  
    PctNotHSGrad + PctBSorMore + PctEmploy + PctEmplManu + MalePctDivorce + 
    MalePctNevMarr + TotalPctDiv + PctKids2Par + PctWorkMom + 
    PctIlleg + PctNotSpeakEnglWell + PctLargHouseOccup + PersPerOccupHous + 
    PersPerOwnOccHous + PersPerRentOccHous + PctPersOwnOccup + 
    PctPersDenseHous + HousVacant + PctVacantBoarded + PctVacMore6Mos + 
    OwnOccLowQuart + OwnOccMedVal + RentLowQ + MedRent + MedOwnCostPctInc + 
    MedOwnCostPctIncNoMtg + PctForeignBorn + PolicReqPerOffic + 
    PctUsePubTrans, data = all_data)

summary(fit_mlr)

# generate graphs
plot(all_data$PopDens, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. PopDens", xlab = "Normalized Population Density", ylab = "Normalized Violent Crimes per 100k People", pch = 20)
plot(all_data$medIncome, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. medIncome", xlab = "Normalized Median Income", ylab = "Normalized Violent Crimes per 100k People", pch = 20)
plot(all_data$PctUnemployed, all_data$ViolentCrimesPerPop, main = "ViolentCrimesPerPop v. PctUnemployed", xlab = "Normalized Unemployment Rate", ylab = "Normalized Violent Crimes per 100k People", pch = 20)
