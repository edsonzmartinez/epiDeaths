# project: Geometric population projection

Geometric population projection is a forecasting method assuming a
constant percentage growth rate over time.

## Usage

``` r
project(pop1, pop2, from = 2010, to = 2022, x = 2025)
```

## Arguments

- pop1:

  a vector of the initial values.

- pop2:

  a vector of the ending values.

- from:

  initial year or data point.

- to:

  ending year or data point.

- x:

  the year for which the extrapolation is to be made.

## Value

This function returns a vector containing the extrapolated values.

## Details

This function estimate values for a given year (`x`) based on growth
rates calculated by geometric interpolation between `from` and `to`.

## References

Laurenti, R., Mello Jorge, M.H.P., Lebrão, M.L., Gotlieb, S.L.D. (2005).
Estatísticas de Saúde. 2nd edition. São Paulo: EPU. ISBN: 9788512408309.

## Examples

``` r
## Example 1
project(100, 200, from=2010, to=2020, x=2025)
#> [1] 283

## Example 2
pop1 <- c(2126148L, 775746L, 884602L, 957100L, 911673L, 812483L, 747361L, 688740L,
          614103L, 501228L, 386337L, 274949L, 216546L)
pop2 <- c(1787296L, 648467L, 752059L, 783322L, 808350L, 881275L, 892896L, 771218L,
          713233L, 649157L, 581323L, 472760L, 356725L)
project(pop1, pop2, from=2010, to=2022, x=2025)
#>  [1] 1711383  620055  722151  745051  784404  899365  933509  793337  740421
#> [10]  692514  643843  541362  404138
```
