# R Packages

This repository contains my R packages and implementations of statistical methods.  
The first project is an implementation of the **bootstrap test for equality of variances** proposed by Cahoy (2010).

## Bootstrap Test for Equality of Variances

Unlike classical tests such as Bartlett’s or Levene’s, this method uses **bootstrap resampling**,  
making it more robust for non-normal data and small sample sizes.  
The function returns the test statistics, a bootstrap-based critical value, and the decision on rejecting the null hypothesis.

Reference:  
Cahoy, D. O. (2010). *A bootstrap test for equality of variances.*  
Computational Statistics & Data Analysis, 54(10), 2306–2316. [DOI](https://doi.org/10.1016/j.csda.2010.04.012)

### File
- **testCahoy.R** – R implementation of the bootstrap test.
