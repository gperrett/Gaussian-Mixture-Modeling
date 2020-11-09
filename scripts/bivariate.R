library(tidyverse)
library(rstan)
options(mc.cores = parallel::detectCores())

pengunins <- read_csv("data/cleaned_penguins.csv")
pengunins <- pengunins %>% select(-X1)


# Prepare data for stan  --------------------------------------------------


fit <- stan(file = "scripts/bivariate.stan", 
     data = list(N=nrow(pengunins),
                 D = 1, 
                 K = 3, 
                 y = scale(pengunins$body_mass_g)), 
     chains = 4)

plot(fit)


lookup(scale)
