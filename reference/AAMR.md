# AAMR: Age-adjusted mortality rate

Calculates the age-adjusted mortality rate (direct standardisation).

## Usage

``` r
AAMR(d, pop, Nref, ages = c(), fac = 10000)
```

## Arguments

- d:

  a vector containing the number of deaths in each age group in the
  study population.

- pop:

  a vector containing the population size for each age group within the
  study population.

- Nref:

  a vector containing the population size for each age group within the
  reference population.

- ages:

  a vector containing the lower limit of each age group.

- fac:

  a factor used to represent the mortality rate as "deaths per `fac`
  population". The default is 1e4.

## Value

Returns a list with three components:

- `crude`: The crude mortality rate.

- `adj`: The age-adjusted mortality rate.

- `tabm`: A matrix containing `"d"`, `"pop"`, `"Nref"` and the expected
  number of deaths at each age group.

## References

Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for
Health Research: A Practical Interactive Guide to Epidemiology and
Statistics. Second Edition. John Wiley & Sons Ltd.

## Examples

``` r
## Example 1
d    <- c(1,14,102,259,381,420,328,297)
pop  <- c(670858,1530547,1591913,1551481,1355325,1068705,604175,332148)
Nref <- c(7058427,15541422,16281290,15382114,12733791,9626735,5432779,2828223)
AAMR(d,pop,Nref,ages=c(15,20,30,40,50,60,70,80,100))
#> $crude
#> [1] 2.070039
#> 
#> $adj
#> [1] 1.956182
#> 
#> $tabm
#>          deaths population pop reference   expected
#> 15 to 19      1     670858       7058427   10.52149
#> 20 to 29     14    1530547      15541422  142.15827
#> 30 to 39    102    1591913      16281290 1043.20499
#> 40 to 49    259    1551481      15382114 2567.84809
#> 50 to 59    381    1355325      12733791 3579.63911
#> 60 to 69    420    1068705       9626735 3783.29726
#> 70 to 79    328     604175       5432779 2949.39630
#> 80 to 99    297     332148       2828223 2528.93960
#> 

## Example 2
# Bruce et al. (2018), Exercise 3.3.1, p. 111.
d    <- c(15,31,78)
pop  <- c(4100,3000,2900)
Nref <- c(5000,3500,1500)
AAMR(d,pop,Nref,ages=c(65,75,85,100),fac=1000)
#> $crude
#> [1] 12.4
#> 
#> $adj
#> [1] 9.480418
#> 
#> $tabm
#>          deaths population pop reference expected
#> 65 to 74     15       4100          5000 18.29268
#> 75 to 84     31       3000          3500 36.16667
#> 85 to 99     78       2900          1500 40.34483
#> 
```
