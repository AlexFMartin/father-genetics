# Create dummy data with patterns for testing regressions
n <- 7700

df.paper3 <- tibble::tibble(
  id = factor(1:n),
  # covariates
  sex = runif(n) >= .5,
  fathPRS = rnorm(n),
  mothPRS = scale(rnorm(n) + fathPRS * .1),  # assortative mating
  chiPRS = scale(rnorm(n, sd = .1) + fathPRS + mothPRS),
  # parenting 
  faWarmth = rnorm(n),
  moWarmth = scale(rnorm(n) + faWarmth * .1),  # assortative mating
  faControl = rnorm(n),
  moControl = scale(rnorm(n) + faControl * .1),  # assortative mating
  chaos = rnorm(n),
  # SDQ_4 is dependent on all the other stuff
  SDQ_4 = scale(
    sex * .3 +
      fathPRS * .03 +
      mothPRS * .03 +
      chiPRS * .1 +
      faWarmth * .07 +
      moWarmth * .07 +
      faControl * .07 +
      moControl * .07 +
      chaos * .07
  ) * 10 + 20
)
