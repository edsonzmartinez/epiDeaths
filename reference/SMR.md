# SMR: Standardized mortality ratio

Calculates the Standardized Mortality Ratio (SMR), a measure comparing
the observed number of deaths in a study population to the expected
deaths based on a standard population, adjusted for age and sex.

## Usage

``` r
SMR(d, pop, dref, Nref, ages = c())
```

## Arguments

- d:

  a vector containing the number of deaths in each age group in the
  study population.

- pop:

  a vector containing the population size for each age group within the
  study population.

- dref:

  a vector containing the number of deaths in each age group in the
  reference population.

- Nref:

  a vector containing the population size for each age group within the
  reference population.

- ages:

  a vector containing the lower limit of each age group.

## Value

Returns a list with six components:

- `obs`: The observed number of deaths.

- `exp`: The expected number of death.

- `smr`: The standardized mortality ratio (SMR).

- `ci`: An approximate 95% confidence interval (CI) for the SMR by using
  the method proposed by Vandenbroucke (1982).

- `isr`: The indirectly standardised mortality rate per 10,000
  inhabitants, given by 10,000 x SMR x crude death rate for the standard
  population (see Bruce et al., 2018, p. 110).

- `tabm`: A matrix containing `"d"`, `"pop"`, `"dref"`, `"Nref"` and the
  expected number of deaths at each age group.

## Details

An SMR is calculated by the indirect method of standardisation. It
compares the actual deaths in a study population to the deaths that
would be expected if that population had the same age/sex-specific
mortality rates as a standard population. SMR is calculated as \$\$SMR =
\dfrac{observed\\ number\\ of\\ deaths}{expected\\ number\\ of\\
deaths}\$\$ It is commonly used in epidemiology for age-standardized
mortality comparisons. An SMR of 1.0 means that the number of observed
deaths is equal to the number of expected deaths. An SMR higher than 1.0
indicates higher-than-expected mortality, while an SMR lower than 1.0
indicates lower-than-expected mortality.

## References

Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for
Health Research: A Practical Interactive Guide to Epidemiology and
Statistics. Second Edition. John Wiley & Sons Ltd. ISBN: 9781118665411.

Ulm, K. (1990). Simple method to calculate the confidence interval of a
standardized mortality ratio (SMR). American Journal of Epidemiology,
131:373–37, doi:10.1093/oxfordjournals.aje.a115507

Vandenbroucke, J.P. (1982). A shortcut method for calculating the 95
percent confidence interval of the standardized mortality ratio.
(Letter). American Journal of Epidemiology, 115:303-4,
doi:10.1093/oxfordjournals.aje.a113306

## Examples

``` r
## Example
d    <- c(1,14,102,259,381,420,328,297)
pop  <- c(670858,1530547,1591913,1551481,1355325,1068705,604175,332148)
Nref <- c(7058427,15541422,16281290,15382114,12733791,9626735,5432779,2828223)
dref <- c(2,136,1185,2826,4188,4311,3384,3071)
SMR(d,pop,dref,Nref,ages=c(15,20,30,40,50,60,70,80,100))
#> $obs
#> [1] 1802
#> 
#> $exp
#> [1] 2075.811
#> 
#> $smr
#> [1] 0.8680944
#> 
#> $ci
#> [1] 0.8284762 0.9086380
#> 
#> $isr
#> [1] 1.953614
#> 
#> $tabm
#>          deaths population deaths pop reference pop reference    expected
#> 15 to 19      1     670858                    2       7058427   0.1900871
#> 20 to 29     14    1530547                  136      15541422  13.3935229
#> 30 to 39    102    1591913                 1185      16281290 115.8640934
#> 40 to 49    259    1551481                 2826      15382114 285.0378892
#> 50 to 59    381    1355325                 4188      12733791 445.7510807
#> 60 to 69    420    1068705                 4311       9626735 478.5825366
#> 70 to 79    328     604175                 3384       5432779 376.3319288
#> 80 to 99    297     332148                 3071       2828223 360.6598589
#> 
```
