# YPLL: Years of potential life lost

Calculates the YPLL, a measure of the amount of life lost due to
premature mortality.

## Usage

``` r
YPLL(d, ages = ages, K = 75)
```

## Arguments

- d:

  a vector containing the number of deaths in each age group.

- ages:

  a vector containing the lower limit of each age group.

- K:

  the standard life expectancy age. The default is 75 years.

## Value

Returns a list with two components:

- `out`: A matrix containing the number of deaths in each age group
  (\\d_i\\), the correspondent midpoint of age, the difference between
  the midpoint of age and K (\\a_i\\), and the product \\a_i d_i\\.

- `estimate`: The years of potential life lost.

## Details

The concept of years of potential life lost (YPLL) involves estimating
the average time a person would have lived had he or she not died
prematurely (Gardner and Sanborn, 1990). Denoting the number of deaths
in the \\i\\-th age group by \\d_i\\, the YPLL can be estimated by
\$\$YPLL = \sum\_{i=1}^{K^\*} a_i d_i\$\$ where \\K^\*\\ is the number
of age groups between 0 and K, \\a_i\\ is the difference between K and
the midpoint of age in each age group, assuming a uniform distribution
of deaths in each group, and K is the standard age of death. The
midpoint of an age group is estimated as (lowest age + highest age +
1)/2.

Different authors use different values for K. According to Bruce et al.
(2018), historically, WHO has used life expectancy from Japan, this
being the highest in the world. Other authors uses 75 years as the
reference age because it approximates US life expectancy (Ma et al.,
2015).

## References

Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for
Health Research: A Practical Interactive Guide to Epidemiology and
Statistics. Second Edition. John Wiley & Sons Ltd.

Gardner, J.W., Sanborn, J.S. (1990). Years of potential life lost
(YPLL) - what does it measure? Epidemiology, 1(4):322-9. doi:
10.1097/00001648-199007000-00012.

Ma, J., Ward, E.M., Siegel, R.L., Jemal, A. (2015). Temporal trends in
mortality in the United States, 1969-2013. Jama, 314(16), 1731-1739.
doi: 10.1001/jama.2015.12319.

## Examples

``` r
# Example
d    <- c(1,12,60,100,137,200,225,236,237,258,226)
ages <- seq(20,70,5)
YPLL(d,ages,75)
#> $out
#>            d  mid    a     ad
#> 20 to 24   1 22.5 52.5   52.5
#> 25 to 29  12 27.5 47.5  570.0
#> 30 to 34  60 32.5 42.5 2550.0
#> 35 to 39 100 37.5 37.5 3750.0
#> 40 to 44 137 42.5 32.5 4452.5
#> 45 to 49 200 47.5 27.5 5500.0
#> 50 to 54 225 52.5 22.5 5062.5
#> 55 to 59 236 57.5 17.5 4130.0
#> 60 to 64 237 62.5 12.5 2962.5
#> 65 to 69 258 67.5  7.5 1935.0
#> 70 to 74 226 72.5  2.5  565.0
#> 
#> $estimate
#> [1] 31530
#> 
```
