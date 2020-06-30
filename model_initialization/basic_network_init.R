#### EpiModel: Basic Network Model Simulation ####
#set working directory 
bdir = "~/EpiModel_Network_Predictability/model_initialization"
setwd(bdir)

#load dependencies
library(EpiModel)
library(mgm)
library(ggplot2)
source("model_functions.R")

##initialize 10 networks with 10 varying degrees of host heterogeneity
model_1 = fit_model(n = 1000, groups = 1)  #0 host heterogeneity
model_2 = fit_model(n = 1000, groups = 2)
model_3 = fit_model(n = 1000, groups = 3)
model_4 = fit_model(n = 1000, groups = 4)
model_5 = fit_model(n = 1000, groups = 5)
model_6 = fit_model(n = 1000, groups = 6)
model_7 = fit_model(n = 1000, groups = 7)
model_8 = fit_model(n = 1000, groups = 8)
model_9 = fit_model(n = 1000, groups = 9)
model_10 = fit_model(n = 1000, groups = 10) 


sim_1 = simulate_model(model_1)
sim_2 = simulate_model(model_2)
sim_3 = simulate_model(model_3)
sim_4 = simulate_model(model_4)
sim_5 = simulate_model(model_5)
sim_6 = simulate_model(model_6)
sim_7 = simulate_model(model_7)
sim_8 = simulate_model(model_8)
sim_9 = simulate_model(model_9)
sim_10 = simulate_model(model_10)