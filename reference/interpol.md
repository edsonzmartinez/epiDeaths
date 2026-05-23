# interpol: Geometric interpolation between two years

Calculates intermediate values between a starting value and an ending
value by finding an average annual growth rate.

## Usage

``` r
interpol(pop1, pop2, from = 2010, to = 2022)
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

## Value

The function returns a list containing two components:

- `rsx`: The growth rates.

- `interpdata`: A matrix of the intermediate values.

## Details

This function uses geometric interpolation to calculate intermediate
values between a starting value and an ending value. The growth rate by
sex (s) and age group (x) is given by \$\$r\_{sx} =
\left(\dfrac{pop\_{1sx}}{pop\_{2sx}}\right)^{1/\Delta t} - 1\$\$ where
\\pop\_{1sx}\\ and \\pop\_{2sx}\\ are the populations for the initial
and final data points, respectively, and \\\Delta t\\ is the time
elapsed between the two dates.

## References

Laurenti, R., Mello Jorge, M.H.P., Lebrão, M.L., Gotlieb, S.L.D. (2005).
Estatísticas de Saúde. 2nd edition. São Paulo: EPU. ISBN: 9788512408309.

## Examples

``` r
# Example 1
# Laurenti et al. (1985), page 34
# Brazilian population in 1970:  93,215,300
# Brazilian population in 1980: 119,098,992
interpol(93215300, 119098992, 1970, 1980)
#> $rsx
#> [1] 0.02480701
#> 
#> $interpdata
#>          1970     1971     1972      1973      1974      1975      1976
#> [1,] 93215300 95527693 97897450 100325993 102814781 105365309 107979107
#>           1977      1978      1979      1980
#> [1,] 110657746 113402834 116216020 119098992
#> 

# Example 2
pop1 <- c(2126148L, 775746L, 884602L, 957100L, 911673L, 812483L, 747361L, 688740L,
          614103L, 501228L, 386337L, 274949L, 216546L)
pop2 <- c(1787296L, 648467L, 752059L, 783322L, 808350L, 881275L, 892896L, 771218L,
          713233L, 649157L, 581323L, 472760L, 356725L)
out  <- interpol(pop1,pop2,from=2010,to=2022)
out$rsx        # the annual growth rate
#>  [1] -0.014363187 -0.014823536 -0.013435843 -0.016558380 -0.009973782
#>  [6]  0.006795882  0.014937277  0.009470164  0.012548538  0.021785029
#> [11]  0.034636035  0.046202407  0.042474119
out$interpdata # a matrix of the intermediate values
#>          2010    2011    2012    2013    2014    2015    2016    2017    2018
#>  [1,] 2126148 2095610 2065510 2035843 2006602 1977780 1949373 1921374 1893777
#>  [2,]  775746  764247  752918  741757  730761  719929  709257  698743  688386
#>  [3,]  884602  872717  860991  849423  838010  826751  815643  804684  793872
#>  [4,]  957100  941252  925666  910339  895265  880441  865862  851525  837425
#>  [5,]  911673  902580  893578  884666  875842  867107  858458  849896  841420
#>  [6,]  812483  818005  823564  829160  834795  840468  846180  851931  857720
#>  [7,]  747361  758525  769855  781354  793026  804871  816894  829096  841481
#>  [8,]  688740  695262  701847  708493  715203  721976  728813  735715  742683
#>  [9,]  614103  621809  629612  637513  645512  653613  661815  670119  678528
#> [10,]  501228  512147  523304  534705  546353  558255  570417  582844  595541
#> [11,]  386337  399718  413563  427887  442707  458041  473906  490320  507303
#> [12,]  274949  287652  300943  314847  329393  344612  360534  377192  394619
#> [13,]  216546  225744  235332  245327  255747  266610  277934  289739  302046
#>          2019    2020    2021    2022
#>  [1,] 1866576 1839766 1813341 1787296
#>  [2,]  678181  668128  658224  648467
#>  [3,]  783206  772683  762301  752059
#>  [4,]  823559  809922  796511  783322
#>  [5,]  833028  824719  816494  808350
#>  [6,]  863549  869418  875326  881275
#>  [7,]  854050  866807  879755  892896
#>  [8,]  749716  756816  763983  771218
#>  [9,]  687043  695664  704394  713233
#> [10,]  608515  621771  635317  649157
#> [11,]  524874  543053  561862  581323
#> [12,]  412851  431926  451882  472760
#> [13,]  314875  328249  342191  356725
```
