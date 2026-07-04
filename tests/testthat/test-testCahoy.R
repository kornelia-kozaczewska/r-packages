test_that("returns the expected structure", {
  set.seed(1)
  d <- replicate(3, rnorm(30), simplify = FALSE)
  res <- testCahoy(d, B = 100, seed = 1)

  expect_named(res, c("t_vec", "c_star", "reject", "alpha", "B"))
  expect_length(res$t_vec, 3)
  expect_true(is.numeric(res$c_star))
  expect_true(is.logical(res$reject))
})

test_that("does not reject H0 when variances are equal", {
  set.seed(2)
  d <- replicate(3, rnorm(50), simplify = FALSE)
  expect_false(testCahoy(d, B = 200, seed = 2)$reject)
})

test_that("rejects H0 when one variance is clearly inflated", {
  set.seed(3)
  d <- list(rnorm(50), rnorm(50), rnorm(50, sd = 4))
  expect_true(testCahoy(d, B = 200, seed = 3)$reject)
})

test_that("seed makes the result reproducible", {
  set.seed(4)
  d <- replicate(3, rnorm(30), simplify = FALSE)
  r1 <- testCahoy(d, B = 100, seed = 42)
  r2 <- testCahoy(d, B = 100, seed = 42)
  expect_identical(r1, r2)
})

test_that("decision is consistent with the reported statistics", {
  set.seed(5)
  d <- list(rnorm(40), rnorm(40, sd = 2), rnorm(40))
  res <- testCahoy(d, B = 200, seed = 5)
  expect_identical(res$reject, any(abs(res$t_vec) > res$c_star))
})
