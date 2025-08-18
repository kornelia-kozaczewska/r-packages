# R Packages

This repository stores my R packages and implementations of statistical methods.  
The first project here is an implementation of the **bootstrap test for equality of variances** proposed by Cahoy (2010).

## Bootstrap Test for Equality of Variances

Unlike classical tests such as Bartlett’s or Levene’s, this method uses **bootstrap resampling**,  
making it more robust under non-normality and small sample sizes.  
The function returns the test statistics, a bootstrap-based critical value, and the decision on rejecting the null hypothesis.

Described in: Cahoy, D. O. (2010). *A bootstrap test for equality of variances.* Computational Statistics & Data Analysis, 54(10), 2306–2316. [DOI link](https://doi.org/10.1016/j.csda.2010.04.012)


### File
- **testCahoy.R** – R implementation of the bootstrap test.

