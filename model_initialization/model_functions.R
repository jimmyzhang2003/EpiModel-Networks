#### Functions for Model Fitting and Simulation ####
#fit model 
fit_model = function(n, groups) {
  ##initialize network and heterogeneous attributes
  nw = network.initialize(n = n, bipartite = n/2, directed = FALSE) #bipartite based on sex
  nw = set.vertex.attribute(nw, "race", sample(1:groups, n, TRUE))
  nw = set.vertex.attribute(nw, "age.group", sample(1:groups, n, TRUE))
  
  ##define partnership formation formula and parameterize model
  formation = ~edges + b1degree(0:1) + b2degree(0:1) + nodefactor("race") + 
    nodematch("race") + nodematch("age.group") + concurrent
  
  #randomize nodefactor for race
  race_nodefactor = runif(groups, 0, 1)
  race_nodefactor = race_nodefactor/sum(race_nodefactor)
  
  target.stats = c(0.25*n,  #initial number of edges = 1/4th of population
                   c(0.40*n, 0.55*n), #degree distribution for females
                   c(0.48*n, 0.41*n), #for males
                   race_nodefactor[1:groups-1], #random factor for each race
                   0.25*0.9*n,  #90% of edges are same-race           
                   0.25*0.98*n,  #98% of edges are same age group
                   0.1*n)   #10% of nodes have concurrent degree 
                  
  
  #dissolution coefficients
  coef.diss <- dissolution_coefs(dissolution = ~offset(edges), duration = 25)
                                  
  
  #model estimation
  est = netest(nw, formation, target.stats, coef.diss, edapprox = TRUE)
  return(est) #return estimated model
}


#simulate model 
simulate_model = function(est_model) {
  #dynamic diagnostics
  dx <- netdx(est_model, nsims = 1, nsteps = 500,
              nwstats.formula = ~edges + b1degree(0:1) + b2degree(0:1) + 
              nodefactor("race") + nodematch("race") + nodematch("age.group") +
              concurrent)
  param <- param.net(inf.prob = 0.2, act.rate = 5, rec.rate = 0.03)
  init <- init.net(i.num = 20)
  control <- control.net(type = "SIS", nsteps = 500, nsims = 1, verbose = FALSE)
  sim <- netsim(est, param, init, control)

  return(list(dx, sim)) #return simulated model (sim) and dx for plotting/analysis
}