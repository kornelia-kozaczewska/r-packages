# R Packages

This repository is intended for storing my R packages and implementations of statistical methods.  
The first package included here is an implementation of the **bootstrap test for equality of variances** proposed by Cahoy (2010).

## Bootstrap Test for Equality of Variances

The function implements the test described in:  
Cahoy, D. O. (2010). *A bootstrap test for equality of variances.* Computational Statistics & Data Analysis, 54(10), 2306–2316. [DOI link](https://doi.org/10.1016/j.csda.2010.04.012)

### Description
- Unlike classical tests such as Bartlett’s or Levene’s, this approach uses **bootstrap resampling**,  
  which makes it more robust under non-normality and small sample sizes.  
- The function estimates a bootstrap-based critical value and checks whether group variances differ significantly.  
- It outputs the observed test statistics, the threshold, and the decision on rejecting the null hypothesis.  

### File
- **testCahoy.R** – R implementation of the bootstrap test.  

---

This is the first package in this repository. More R functions and statistical implementations will be added over time.
