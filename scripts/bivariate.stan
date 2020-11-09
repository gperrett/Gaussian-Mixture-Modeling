data {
  int<lower = 0> N;     // number of observations
  int<lower =0> D;
  int<lower =1> K;     // number of gaussians
  vector[D] y[N];       //data
}


parameters {
  simplex[K] theta;    // mixing proportions
  ordered[K] mu;
  real<lower=0> sigma[K];
}


model{
  real ps[K];
  //Priors 
  for(k in 1:K){
    mu[k] ~ normal(0,5);
    sigma[k] ~ normal(0,2);
  }

 theta ~ beta(5, 5);

for (n in 1:N){
  //Likelihood 
 for (k in 1:K){
 ps[k] = log(theta[k])+ normal_lpdf(y[n] | mu[k], sigma[k]); 

 }
 target += log_sum_exp(ps);
 }

}
