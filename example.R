# Example usage of testCahoy and a small simulation comparing its
# type I error with Bartlett's test under non-normal data.

source("R/testCahoy.R")

# --- Basic usage -----------------------------------------------------------

set.seed(42)

# H0 true: three groups with equal variances
groups_h0 <- replicate(3, rnorm(30), simplify = FALSE)
res_h0 <- testCahoy(groups_h0, B = 500, seed = 42)
cat("Equal variances:    reject =", res_h0$reject,
    "| max |t| =", round(max(abs(res_h0$t_vec)), 2),
    "| c* =", round(res_h0$c_star, 2), "\n")

# H0 false: one group with sd = 3
groups_h1 <- list(rnorm(30), rnorm(30), rnorm(30, sd = 3))
res_h1 <- testCahoy(groups_h1, B = 500, seed = 42)
cat("Unequal variances:  reject =", res_h1$reject,
    "| max |t| =", round(max(abs(res_h1$t_vec)), 2),
    "| c* =", round(res_h1$c_star, 2), "\n")

# --- Type I error under non-normality --------------------------------------
# Three groups with EQUAL population variances drawn from a skewed
# distribution: lognormal rescaled by its theoretical standard deviation
# sqrt((e - 1) * e). A test with correct size should reject in about 5%
# of runs. Bartlett's test is known to over-reject for skewed data.

sd_lnorm <- sqrt((exp(1) - 1) * exp(1))
n_sim <- 500
n_obs <- 25

rejections <- t(replicate(n_sim, {
  data <- replicate(3, rlnorm(n_obs) / sd_lnorm, simplify = FALSE)
  c(
    cahoy    = testCahoy(data, B = 200)$reject,
    bartlett = bartlett.test(data)$p.value < 0.05
  )
}))

cat("\nEmpirical type I error (nominal 0.05):\n")
print(colMeans(rejections))
