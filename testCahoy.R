# testCahoy: bootstrap test for homogeneity of variances in K+1 groups

# Cahoy, D. O. (2010). A bootstrap test for equality of variances.
# Computational Statistics & Data Analysis, 54(10), 2306–2316.
# https://doi.org/10.1016/j.csda.2010.04.012

# Arguments:
# data - a list of vectors (each vector contains the observations for one group)
# B - number of bootstrap iterations (default is 500)
# alpha - significance level of the test (default is 0.05)
# seed - optional random number generator seed (default is NULL)

# Returns: a list with the following elements
# t_vec - vector of observed test statistics t_i
# c_star - critical value c* determined by the bootstrap
# reject - TRUE/FALSE: whether to reject H0 (if any |t_i| > c_star)
# alpha - returned α
# B - returned B


testCahoy <- function(data, B = 500, alpha = 0.05, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  Kplus1 <- length(data)
  n_vec <- lengths(data)
  
  # step 1
  s2_vec <- sapply(data, var)
  geom_mean_s2 <- prod(s2_vec)^(1/Kplus1)
  eta_hat_vec <- log(s2_vec / geom_mean_s2)
  
  m4_vec <- sapply(data, function(x) mean((x - mean(x))^4))
  var_log_s2_vec <- (m4_vec / s2_vec^2 - (n_vec - 3)/(n_vec - 1)) / n_vec
  lambda_hat_vec <- sqrt((1 - 2 / Kplus1) * var_log_s2_vec + 1 / Kplus1^2 * sum(var_log_s2_vec))
  
  t_vec <- eta_hat_vec / lambda_hat_vec
  
  # bootstrap - step 2, 3 and 4
  t_boot <- replicate(B, {
    boot_n <- lapply(data, sample, replace = TRUE)
    
    s2_boot <- sapply(boot_n, var)
    geom_mean_s2 <- prod(s2_boot)^(1/Kplus1)
    eta_hat_boot <- log(s2_boot / geom_mean_s2)
    
    m4_boot <- sapply(boot_n, function(x) mean((x - mean(x))^4))
    var_log_s2_boot <- (m4_boot / s2_boot^2 - (n_vec - 3)/(n_vec - 1)) / n_vec
    lambda_hat_boot <- sqrt((1 - 2 / Kplus1) * var_log_s2_boot + 1 / Kplus1^2 * sum(var_log_s2_boot))
    
    eta_hat_boot / lambda_hat_boot
  })
  
  # step 5
  t_centered <- t_boot - rowMeans(t_boot)
  t_abs <- abs(t_centered)
  
  # step 6
  cand <- sort(c(t_abs), decreasing = FALSE)
  
  # step 7
  c_star <- NA
  for (c in cand) {
    prop_in_box <- mean(apply(t_abs, 2, function(col) all(col <= c)))
    if (prop_in_box >= 1 - alpha) {
      c_star <- c
      break
    }
  }

  reject <- any(abs(t_vec) > c_star)
  
  # results
  list(
    t_vec = t_vec,
    c_star = c_star,
    reject = reject,
    alpha = alpha,
    B = B
  )
}
