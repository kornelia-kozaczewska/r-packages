# R Packages

This repository contains my R implementations of statistical methods.  
The first project is an implementation of the **bootstrap test for equality of variances** proposed by Cahoy (2010).

## Bootstrap Test for Equality of Variances

Unlike classical tests such as Bartlett’s or Levene’s, this method uses **bootstrap resampling**,  
making it more robust for non-normal data and small sample sizes.  
The function returns the test statistics, a bootstrap-based critical value, and the decision on rejecting the null hypothesis.

### Usage

```r
source("testCahoy.R")

groups <- list(rnorm(30), rnorm(30), rnorm(30, sd = 3))
testCahoy(groups, B = 500, seed = 42)
```

```
Equal variances:    reject = FALSE | max |t| = 2.99 | c* = 3.07
Unequal variances:  reject = TRUE  | max |t| = 8.08 | c* = 3.40
```

### Why not Bartlett's test?

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

### Files
- **testCahoy.R** – R implementation of the bootstrap test.
- **example.R** – usage example and the type I error simulation.
