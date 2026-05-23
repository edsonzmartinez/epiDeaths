# stdYPLL: Age‐standardized years of potential life lost

Calculates the age‐standardized YPLL, a measure of the amount of life
lost due to premature mortality.

## Usage

``` r
stdYPLL(d, pop, Nref, ages = ages, K = 75, fac = 10000)
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

- K:

  the standard life expectancy age. The default is 75 years.

- fac:

  a factor used to represent the mortality rate as "deaths per `fac`
  population". The default is 1e4.

## Value

Returns a list with five components:

- `out`: A matrix containing in its columns the number of deaths in each
  age group (\\d_i\\), the correspondent midpoint of age, the difference
  between the midpoint of age and K (\\a_i\\), the product \\a_i d_i\\,
  the population size for each age group within the reference
  population, the age‑specific YPLL rates (YPLL per person), and the
  age‑specific YPLL, respectively.

- `ypll`: The crude estimate of YPLL.

- `ypllrate`: The YPLL rate in years per `fac` people.

- `stdypll`: The age‐standardized YPLL.

- `stdypllrate`: The age‐standardized YPLL rate in years per `fac`
  people.

## Details

Age-Standardized Years of Potential Life Lost (ASYPLL) involves
adjusting the YPLL rate of a specific population to a standard
population structure to allow for fair comparisons across different
regions or time periods. This measure is given by \$\$ASYPLL =
\sum\limits\_{i=1}^{K^\*} \dfrac{a_i d_i}{p_i} N_i\$\$ where \\K^\*\\ is
the number of age groups between 0 and K, \\a_i\\ is the difference
between K and the midpoint of age in each age group, assuming a uniform
distribution of deaths in each group, \\d_i\\ is the number of deaths in
the \\i\\-th age group (`d`), \\p_i\\ is the population size for each
age group within the study population (`pop`), and \\N_i\\ the
population size for each age group within the reference population
(`Nref`) (Silva Filho et al., 2024).

The age‐standardized YPLL rate is given by \$\$ASYPLL\\ rate =
\dfrac{ASYPLL}{\sum\_{i=1}^{K^\*} N_i} \times C\$\$ These measure is
interpreted in years per \\C\\ people, where \\C\\ is specified by the
argument `fac`.

## References

Silva Filho, A.M.D., Araújo, E.M.D., Souza, I.M.D., Luiz, O.D.C.,
Máximo, G., Queiroz, F.D.A., Cavalcante, L., Nisida, V. (2024). Years of
potential life lost due to COVID-19 according to race/color and gender
in Brazil between 2020 and 2021. Ciência & Saúde Coletiva, 29,
e04702023. doi: 10.1590/1413-81232024293.04702023EN

## Examples

``` r
# Example 1
d    <- c(0,0,1,12,60,100,137,200,225,236,237,258,226)
pop  <- c(1787296,648467,752059,783322,808350,881275,892896,
          771218,713233,649157,581323,472760,356725)
Nref <- c(3906682,1396816,1584091,1655473,1730527,1873165,1902856,
          1639164,1534930,1433780,1294948,1054437,795497)
ages <- c(0,15,20,25,30,35,40,45,50,55,60,65,70)
stdYPLL(d,pop,Nref,ages)
#> $out
#>            d  mid    a     ad       P  asYPLLrates    Nref     asYPLL
#> 0 to 14    0  7.5 67.5    0.0 1787296 0.000000e+00 3906682     0.0000
#> 15 to 19   0 17.5 57.5    0.0  648467 0.000000e+00 1396816     0.0000
#> 20 to 24   1 22.5 52.5   52.5  752059 6.980835e-05 1584091   110.5828
#> 25 to 29  12 27.5 47.5  570.0  783322 7.276701e-04 1655473  1204.6382
#> 30 to 34  60 32.5 42.5 2550.0  808350 3.154574e-03 1730527  5459.0757
#> 35 to 39 100 37.5 37.5 3750.0  881275 4.255198e-03 1873165  7970.6888
#> 40 to 44 137 42.5 32.5 4452.5  892896 4.986583e-03 1902856  9488.7494
#> 45 to 49 200 47.5 27.5 5500.0  771218 7.131576e-03 1639164 11689.8231
#> 50 to 54 225 52.5 22.5 5062.5  713233 7.097961e-03 1534930 10894.8732
#> 55 to 59 236 57.5 17.5 4130.0  649157 6.362097e-03 1433780  9121.8479
#> 60 to 64 237 62.5 12.5 2962.5  581323 5.096134e-03 1294948  6599.2287
#> 65 to 69 258 67.5  7.5 1935.0  472760 4.092986e-03 1054437  4315.7957
#> 70 to 74 226 72.5  2.5  565.0  356725 1.583853e-03  795497  1259.9504
#> 
#> $ypll
#> [1] 31530
#> 
#> $ypllrate
#> [1] 31.22375
#> 
#> $stdypll
#> [1] 68115.25
#> 
#> $stdypllrate
#> [1] 31.24214
#> 

# Example 2
d <- c(10,50,20)
pop  <- c(50000,40000,10000)
Nref <- c(20000,20000,10000)
ages <- c(0,35,65)
stdYPLL(d,pop,Nref,ages)
#> $out
#>           d  mid    a   ad     P asYPLLrates  Nref asYPLL
#> 0 to 34  10 17.5 57.5  575 50000     0.01150 20000    230
#> 35 to 64 50 50.0 25.0 1250 40000     0.03125 20000    625
#> 65 to 74 20 70.0  5.0  100 10000     0.01000 10000    100
#> 
#> $ypll
#> [1] 1925
#> 
#> $ypllrate
#> [1] 192.5
#> 
#> $stdypll
#> [1] 955
#> 
#> $stdypllrate
#> [1] 191
#> 
```
