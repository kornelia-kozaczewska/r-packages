# testCahoy

An independent educational R implementation of the **bootstrap test for equality of variances** proposed by Cahoy (2010).

Unlike classical tests such as Bartlett’s or Levene’s, this method uses **bootstrap resampling**,  
making it more robust for non-normal data and small sample sizes.  
The function returns the test statistics, a bootstrap-based critical value, and the decision on rejecting the null hypothesis.

## Installation

```r
# install.packages("remotes")
remotes::install_github("kornelia-kozaczewska/r-packages")
```

## Usage

```r
library(testCahoy)

groups <- list(rnorm(30), rnorm(30), rnorm(30, sd = 3))
testCahoy(groups, B = 500, seed = 42)
```

```
Equal variances:    reject = FALSE | max |t| = 2.99 | c* = 3.07
Unequal variances:  reject = TRUE  | max |t| = 8.08 | c* = 3.40
```

## Why not Bartlett's test?

Simulation in `example.R`: 500 runs, three groups of n = 25 with **equal population variances**,
drawn from a skewed (lognormal) distribution. A test with correct size should reject in about 5% of runs.

| Test | Empirical type I error (nominal 0.05) |
|---|---|
| Cahoy bootstrap | 0.078 |
| Bartlett | 0.696 |

Bartlett's test rejects a true null hypothesis in ~70% of runs under skewness,
while the bootstrap test stays close to the nominal level.

Reference:  
Cahoy, D. O. (2010). *A bootstrap test for equality of variances.*  
Computational Statistics & Data Analysis, 54(10), 2306–2316. [DOI](https://doi.org/10.1016/j.csda.2010.04.012)

## Related work

Dexter Cahoy maintains the original CRAN package [`testequavar`](https://CRAN.R-project.org/package=testequavar), which implements bootstrap tests for equality of 2, 3, or 4 population variances.

This repository is an independent educational implementation of the method described in Cahoy (2010). It is not affiliated with, endorsed by, or maintained by Dexter Cahoy.

## Package structure

- `R/testCahoy.R` – implementation with roxygen2 documentation (`?testCahoy`)
- `tests/testthat/` – unit tests (structure, size, power, reproducibility)
- `example.R` – usage example and the type I error simulation

Passes `R CMD check` with no errors, warnings or notes.
