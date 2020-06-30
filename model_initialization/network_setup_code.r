library(EpiModel)
library(mgm)
#networksetup
nw <- network.initialize(n = 100, directed = FALSE)
nw <- set.vertex.attribute(nw, "race", rbinom(100, 1, 0.5))
nw <- set.vertex.attribute(nw, "age", sample(18:50, 100, TRUE))
nw <- set.vertex.attribute(nw, "sex", rep(0:1, each = 50))
formation <- ~edges + nodefactor("race") + nodematch("race") + nodefactor("sex") + nodematch("sex") + absdiff("age") + concurrent
target.stats <- c(25, 37.5, 22.5, 33, 5, 100, 10)
coef.diss <- dissolution_coefs(dissolution = ~offset(edges), duration = 25)
est <- netest(nw, formation, target.stats, coef.diss, edapprox = TRUE)
dx <- netdx(est, nsims = 1, nsteps = 100,
nwstats.formula = ~edges + nodefactor("race", base = 0) +
nodematch("race") + nodefactor("sex", base = 0) + nodematch("sex") + absdiff("age") + concurrent)
#parameters
param <- param.net(inf.prob = 0.2, act.rate = 5, rec.rate = 0.03)
init <- init.net(i.num = 5)
control <- control.net(type = "SIS", nsteps = 100, nsims = 1, verbose = FALSE)
sim <- netsim(est, param, init, control)
#output
outputdf <- sim[["stats"]][["nwstats"]][["sim1"]]
p <- ncol(outputdf)
#predictability
var_obj <- mvar(data = outputdf, type = rep("g", p), lev = rep(1, p), lambdaSel = "EBIC",
lambdaGam = .25,
lags = 1)
pred_obj <- predict(var_obj, outputdf, errorCon = c("RMSE", "R2"),
errorCat = c("CC", "nCC"))
mean(pred_obj$errors$RMSE)
