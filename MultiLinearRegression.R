library(carData)
library(car)
library(MASS)
library(ggplot2)

# clean the console
cat("\f")

# clean the environment
rm(list = ls())

# retrieve data from the scv file
all_data <- read.csv("communities.csv")

# remove all variables that 
all_data$state <- all_data$county <- all_data$community <- all_data$communityname <- all_data$fold <- 
    all_data$PolicPerPop <- all_data$RacialMatchCommPol <- all_data$PctPolicWhite <- all_data$PctPolicBlack <- 
    all_data$PctPolicHisp <- all_data$PctPolicAsian <- all_data$PctPolicMinor <- 
    all_data$OfficAssgnDrugUnits <- all_data$PolicAveOTWorked <- all_data$PolicCars <- all_data$PolicOperBudg <- 
    all_data$PolicBudgPerPop <- all_data$LemasSwornFT <- all_data$LemasSwFTPerPop <- all_data$LemasSwFTFieldOps <- 
    all_data$LemasSwFTFieldPerPop <- all_data$LemasTotalReq <- all_data$LemasTotReqPerPop <- all_data$ LemasPctPolicOnPatr <- 
    all_data$LemasGangUnitDeploy <- all_data$LemasPctOfficDrugUn <- OtherPerCap <- all_data$PolicReqPerOffic <- 
    all_data$numbUrban <- all_data$numUnderPov <- all_data$OtherPerCap <- all_data$NumIlleg <- all_data$NumUnderPov <- 
    all_data$NumIlleg <- all_data$NumImmig <- all_data$NumKindsDrugsSeiz<- NULL

# generate the linear model with all variables in communities.csv
model <- lm(ViolentCrimesPerPop ~ population + householdsize + racepctblack + racePctWhite + 
    racePctAsian + racePctHisp + agePct12t21 + agePct12t29 + agePct16t24 + agePct65up + pctUrban + 
    medIncome + pctWWage + pctWFarmSelf + pctWInvInc + pctWSocSec + pctWPubAsst + pctWRetire + medFamInc + 
    perCapInc + whitePerCap + blackPerCap + indianPerCap + AsianPerCap + HispPerCap + PctPopUnderPov + 
    PctLess9thGrade + PctNotHSGrad + PctBSorMore + PctUnemployed + PctEmploy + PctEmplManu + PctEmplProfServ + 
    PctOccupManu + PctOccupMgmtProf + MalePctDivorce + MalePctNevMarr + FemalePctDiv + TotalPctDiv + PersPerFam + 
    PctFam2Par + PctKids2Par + PctYoungKids2Par + PctTeen2Par + PctWorkMomYoungKids + PctWorkMom + PctIlleg + 
    PctImmigRecent + PctImmigRec5 + PctImmigRec8 + PctImmigRec10 + PctRecentImmig + PctRecImmig5 + PctRecImmig8 + 
    PctRecImmig10 + PctSpeakEnglOnly + PctNotSpeakEnglWell + PctLargHouseFam + PctLargHouseOccup + PersPerOccupHous + 
    PersPerOwnOccHous + PersPerRentOccHous + PctPersOwnOccup + PctPersDenseHous + PctHousLess3BR + MedNumBR + HousVacant + 
    PctHousOccup + PctHousOwnOcc + PctVacantBoarded + PctVacMore6Mos + MedYrHousBuilt + PctHousNoPhone + PctWOFullPlumb + 
    OwnOccLowQuart + OwnOccMedVal + OwnOccHiQuart + RentLowQ + RentMedian + RentHighQ + MedRent + MedRentPctHousInc + 
    MedOwnCostPctInc + MedOwnCostPctIncNoMtg + PctForeignBorn + PctBornSameState + PctSameHouse85 + PctSameCity85 + 
    PctSameState85 + LandArea + PopDens + PctUsePubTrans + NumStreet + NumInShelters, data = all_data)


# remove any variables with a VIF value greater than 5
# while there are still vif values greater than 5
# add the variable with the highest vif value to the list of bad variables
# generate a linear model with all the variables not in the list of bad variables
# calculate the vif values for the new model
badVars <- c("ViolentCrimesPerPop")
drop <- TRUE
while(drop == TRUE){
    f <- ""
    vfit <- vif(model)
    if (max(vfit) > 2){
        badVars <- c(badVars, names(which.max(vfit)))
        for(col in colnames(all_data)){
            add <- TRUE
            for(var in badVars){
                if(col == var){
                    add <- FALSE
                }
            }
            if(add == TRUE){
                if(f == ""){
                    f <- col;
                }
                else{
                    f <- paste(f, "+", col)
                }
            }
        }
        f <- paste("ViolentCrimesPerPop ~ ", f)
        model <- lm(as.formula(f), data = all_data)
    }
    else{
       drop = FALSE
    }
}

# perform stepwise linear regression on the model
# then find the vif values of the remaining variables
step_model <- stepAIC(model, direction = "both", trace = FALSE)
summary(model)
summary(step_model)
vfit <- vif(step_model)
print("VIF values")
print(vfit)

#create histogram of residuals
ggplot(data = all_data, aes(x = step_model$residuals)) +
    geom_histogram(fill = 'steelblue', color = 'black') +
    labs(title = 'Histogram of Residuals', x = 'Residuals', y = 'Frequency')