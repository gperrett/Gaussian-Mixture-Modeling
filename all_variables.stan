data {
int<lower=1> K; // number of mixture components
int<lower=1> N; // number of individual profiles
int<lower=1> D; // dimensions of parameter vector
vector<lower=0>[D] y[N]; // parameter vectors for each individual profile
}


transformed data {
  real<upper=0> neg_log_K;
  neg_log_K = -log(K);
}

parameters {
simplex[K] theta; // mixture component proportions
ordered[D] mu[K]; // order parameter values 
cholesky_factor_corr[D] L[K]; // mixture component Cholesky factor correlation matrices
}


transformed parameters {
  real<upper=0> soft_z[N, K]; // log unnormalized clusters
  for (n in 1:N)
    for (k in 1:K)
      soft_z[n, k] = neg_log_K - 0.5 * dot_self(mu[k] - y[n]);
}


model {
 real ps[K];
 
 for(k in 1:K){
 L[k] ~ lkj_corr_cholesky(4);
 mu[k] ~ normal(0,5);
 }
 
 theta ~ beta(5,5);

 for (n in 1:N){
 for (k in 1:K){
 ps[k] = log(theta[k])+multi_normal_cholesky_lpdf(y[n] | mu[k], L[k]); //increment log probability of the gaussian
 }
 target += log_sum_exp(ps);
 }

}
