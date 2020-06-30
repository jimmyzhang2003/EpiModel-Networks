#### mgm: Calculating Predictability ####
#set working directory 
bdir = "~/EpiModel_Network_Predictability/predictability_analysis"
setwd(bdir)

library(EpiModel)
library(mgm)
library(ggplot2)
source("../basic_network_init.R")

outputdf <- sim[["stats"]][["nwstats"]][["sim1"]]
p <- ncol(outputdf)
#predictability
var_obj <- mvar(data = outputdf, type = rep("g", p), lev = rep(1, p), lambdaSel = "EBIC",
                lambdaGam = .25,
                lags = 1)
pred_obj <- predict(var_obj, outputdf, errorCon = c("RMSE", "R2"),
                    errorCat = c("CC", "nCC"))
mean(pred_obj$errors$RMSE)