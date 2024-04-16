# Resubmission

This is a resubmission. In this version, we addressed the requested changes in the manual CRAN check:

### If there are references describing the methods in your package, please add these in the description field...

There is no need of any references describing the package methods.

### Please add \value to .Rd files regarding exported methods and explain the functions results in the documentation...
      
Included in ipea_pal.RD: \value{
A list object to be added to a ggplot object to change color pallete.
}

### \dontrun{} should only be used if the example really cannot be executed...

\dontrun replaced by \donttest

### Please ensure that your functions do not write by default or in your examples/vignettes/tests in the user's home filespace...

save_eps.Rd path changed to: save_eps(fig_raw,file.name = paste0(tempdir(),"/figura.eps"))

### Please always make sure to reset to user's options(), working directory or par() after you changed...

We included these lines in intro_ipeaplot.R:

oldpar <- par()

par(mfrow = c(3, 1), mar = c(1, 0, 2, 0))

...

par(oldpar)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
