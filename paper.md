---
title: 'epiDeaths: a R package for calculating mortality indicators'
tags:
  - R
  - epidemiology
  - mortality
  - health statistics
  - indicators
authors:
  - name: Edson Zangiacomi Martinez
    orcid: 0000-0002-0949-3222
    equal-contrib: true
    affiliation: 1
  - name: Jackeline Suzan Gentil Garcia dos Anjos
    orcid: 0000-0003-0426-8787
    equal-contrib: true
    affiliation: 1
affiliations:
 - name: Ribeirão Preto Medical School, University of São Paulo, Brazil
   index: 1
   ror: 036rp1748
date: 23 May 2026
bibliography: paper.bib
link-citations: true

# Journal of Open Source Software

# Optional fields if submitting to a AAS journal too, see this blog post:
# https://blog.joss.theoj.org/2018/12/a-new-collaboration-with-aas-publishing
aas-doi: 10.3847/xxxxx <- update this with the DOI from AAS once you know it.
aas-journal: Journal of Open Source Software.
---

# Summary

The epiDeaths package is an open-source R package designed for calculating mortality indicators. The package enables tr

# Statement of need

Studies of mortality are essential for public health. They enable us to identify the leading causes of death in different regions and age groups, helping governments to prioritise investment in areas such as sanitation and infrastructure, and evaluate the effectiveness of public policies established to ensure integral health care within a given population. Different type of mortality indicators are used to understand mortality trend in an population, as the standardized mortality ratio, the age-adjusted mortality rate, the years of potential life lost, and the age‐standardized years of potential life lost. `epiDeaths` is an R package that provides functions designed to make it easier to obtain these mortality indicators. 

`epiDeaths` is available both on GitHub (repo; docs) and CRAN, and was designed to be used by epidemiological researchers, professionals working in public health surveillance, and by students in courses on epidemiology or public health. It can significantly reduce the time spent calculating indicators, which are often produced using spreadsheets, such as Microsoft Excel.

# Usage

## Age-adjusted mortality rates

Age-adjusted rates were developed in 1841 for the analysis of mortality data (3). It are used to compare relative mortality risks among groups and over time. The age-adjusted mortality rate (AAMR) enables mortality rates to be compared between different populations by taking into account the differences in their age structures. It is calculated using a standard population as a reference to help eliminate the effect of age when making comparisons. According to @Curtin, there are two main types of reference population: internal and external. Internal reference populations are created using the data to be analysed. For example, the authors mention the average age distribution of all populations to be compared. One disadvantage of using an internal reference population is that the results cannot be compared with those obtained in other studies that used a different reference population. External reference populations are those that are not used in the data analysis. @Curtin note, for example, that many studies typically use US population data provided by the National Center for Health Statistics (NCHS) for this purpose.

The `AAMR()` function of the `epiDeaths` package calculates the age-adjusted mortality rate using direct standardisation [@Bruce:2018]. For example,

```r
d    <- c(15,31,78)
pop  <- c(4100,3000,2900)
Nref <- c(5000,3500,1500)
AAMR(d,pop,Nref,ages=c(65,75,85,100),fac=1000)
```
returns
```r
$crude
[1] 12.4

$adj
[1] 9.480418

$tabm
         deaths population pop reference expected
65 to 74     15       4100          5000 18.29268
75 to 84     31       3000          3500 36.16667
85 to 99     78       2900          1500 40.34483
```

Among the arguments of the `AAMR()` function, `d` is a vector containing the number of deaths in each age group in the study population, `pop` is a vector containing the population size for each age group within the study population, `Nref` is a vector containing the population size for each age group within the reference population, `ages` is a vector containing the lower limit of each age group, and `fac` is a factor used to represent the mortality rate as "deaths per fac population" (the default is 1e4). The age-adjusted mortality rate (AAMR) is given by the quotient of the sum of the expected number of deaths at each age group and the total number of people in the standard population, or say,

$$AAMR = fac \times \dfrac{\sum_{i=1}^{I} CDR_i \times N_{P,i}}{N_P},$$

where $CDR_i$ is the crude death rate in the $i$-th age group ($i=1,...,I$), $N_{P,i}$ is the number of people in the $i$-th age group in the standard population, and $N_P$ is the total number of people in the standard population. In the example above, the crude death rates are $CDR_1 = 15/4100$, $CDR_2 = 31/3000$ and $CDR_3 = 78/2900$. Thus, considering $fac = 1000$, we have

$$AAMR = 1000 \times \dfrac{\dfrac{15}{4100} \times 5000 + \dfrac{31}{3000} \times 3500 + \dfrac{78}{2900} \times 1500}{5000 + 3500 + 1500}=9.480418.$$

The `AAMR()` function returns a list with three components: `crude` (the crude mortality rate), `adj` (the age-adjusted mortality rate), and `tabm`, a matrix containing `d`, `pop`, `Nref` and `expected` (the expected number of deaths at each age group).

The `SMR()` function calculates the standardized mortality ratio (SMR), a measure obtained by the indirect method of standardisation. It compares the actual deaths in a study population to the deaths that would be expected if that population had the same age/sex-specific mortality rates as a standard population. SMR is calculated as

$$SMR = \dfrac{observed\ number\ of\ deaths}{expected\ number\ of\ deaths}$$

An SMR of 1.0 means that the number of observed deaths is equal to the number of expected deaths. An SMR higher than 1.0 indicates higher-than-expected mortality, while an SMR lower than 1.0 indicates lower-than-expected mortality.

For example,

```r
d    <- c(1,14,102,259,381,420,328,297)
pop  <- c(670858,1530547,1591913,1551481,1355325,1068705,604175,332148)
Nref <- c(7058427,15541422,16281290,15382114,12733791,9626735,5432779,2828223)
dref <- c(2,136,1185,2826,4188,4311,3384,3071)
SMR(d,pop,dref,Nref,ages=c(15,20,30,40,50,60,70,80,100))
```

returns

```r
$obs
[1] 1802

$exp
[1] 2075.811

$smr
[1] 0.8680944

$ci
[1] 0.8284762 0.9086380

$isr
[1] 1.953614

$tabm
         deaths population deaths pop reference pop reference    expected
15 to 19      1     670858                    2       7058427   0.1900871
20 to 29     14    1530547                  136      15541422  13.3935229
30 to 39    102    1591913                 1185      16281290 115.8640934
40 to 49    259    1551481                 2826      15382114 285.0378892
50 to 59    381    1355325                 4188      12733791 445.7510807
60 to 69    420    1068705                 4311       9626735 478.5825366
70 to 79    328     604175                 3384       5432779 376.3319288
80 to 99    297     332148                 3071       2828223 360.6598589
```

The arguments of the `SMR()` function are similar to those of the `AAMR()` function described above, with the addition of the argument `dref`, that refers to a vector containing the number of deaths in each age group in the reference population. The observed number of deaths is simply given by the sum of the elements of the vector ´d´. In this example, it amounts to 1,802 deaths. The expected number of deaths is

$$expected = \sum_{i=1}^{I} \dfrac{N_{S,i} \times d_{P,i}}{N_{P,i}},$$

where $N_{S,i}$ is the population size for the $i$-th age group within the study population ($i=1,...,I$), $d_{P,i}$ is the number of deaths in the $i$-th age group in the reference population, and $N_{P,i}$ is the number of people in the $i$-th age group in the standard population. In this example, it amounts to 2,075.811 deaths. Thus, the SMR is given by $1,802/2,075.811 = 0.8680944$.

The `AAMR()` function returns a list with six components: `obs` (the observed number of deaths in each age group), `exp` (the expected number of death), `smr` (the standardized mortality ratio), `ci` (an approximate 95\% confidence interval for the SMR by using the method proposed by Vandenbroucke (1982)), `isr` (the indirectly standardised mortality rate per 10,000 inhabitants, given by 10,000 $\times$ SMR $\times$ crude death rate for the standard population [@Bruce:2018], and `tabm` (a matrix containing `d`, `pop`, `dref`, `Nref` and the expected number of deaths at each age group).

## Population interpolation and extrapolation

Population interpolation and extrapolation are techniques used to estimate population sizes for years where official census data is unavailable. Temporal interpolation estimates population values for years between two official demographic census periods. This is essential for calculating mortality indicators between census years. The `interpol()` function uses geometric interpolation to calculate intermediate values between a starting value and an ending value. The growth rate by sex (s) and age group (x) is given by

$$r_{sx} = \left(\dfrac{pop_{1sx}}{pop_{2sx}}\right)^{1/\Delta t} - 1$$

where $pop_{1sx}$ and $pop_{2sx}$ are the populations for the initial and final data points, respectively, and $\Delta t$ is the time elapsed between the two dates. As a first example, let us consider the 1970 and 1980 Brazilian Population Censuses. According to the 1970 census, the Brazilian population was 93,215,300, whereas according to the 1980 census, it was 119,098,992 (Laurenti et al. (1985), page 34). Thus, the function

```r
interpol(93215300, 119098992, 1970, 1980)
```
returns
```r
$rsx
[1] 0.02480701

$interpdata
         1970     1971     1972      1973      1974      1975      1976
[1,] 93215300 95527693 97897450 100325993 102814781 105365309 107979107
          1977      1978      1979      1980
[1,] 110657746 113402834 116216020 119098992
```
The `interpol()` function returns a list with two components, `rsx` (the growth rates) and `interpdata` (a matrix of the intermediate values).

Consider another example given by

```r
pop1 <- c(2126148L, 775746L, 884602L, 957100L, 911673L, 812483L, 747361L, 688740L,
           614103L, 501228L, 386337L, 274949L, 216546L)
pop2 <- c(1787296L, 648467L, 752059L, 783322L, 808350L, 881275L, 892896L, 771218L,
           713233L, 649157L, 581323L, 472760L, 356725L)
out  <- interpol(pop1,pop2,from=2010,to=2022)
```

In this case, `pop1` and `pop2` are vectors of the same size, representing population counts in different areas or different age groups. The function thus returns the following:

```r
$rsx
 [1] -0.014363187 -0.014823536 -0.013435843 -0.016558380 -0.009973782  0.006795882  0.014937277  0.009470164
 [9]  0.012548538  0.021785029  0.034636035  0.046202407  0.042474119

$interpdata
         2010    2011    2012    2013    2014    2015    2016    2017    2018    2019    2020    2021    2022
 [1,] 2126148 2095610 2065510 2035843 2006602 1977780 1949373 1921374 1893777 1866576 1839766 1813341 1787296
 [2,]  775746  764247  752918  741757  730761  719929  709257  698743  688386  678181  668128  658224  648467
 [3,]  884602  872717  860991  849423  838010  826751  815643  804684  793872  783206  772683  762301  752059
 [4,]  957100  941252  925666  910339  895265  880441  865862  851525  837425  823559  809922  796511  783322
 [5,]  911673  902580  893578  884666  875842  867107  858458  849896  841420  833028  824719  816494  808350
 [6,]  812483  818005  823564  829160  834795  840468  846180  851931  857720  863549  869418  875326  881275
 [7,]  747361  758525  769855  781354  793026  804871  816894  829096  841481  854050  866807  879755  892896
 [8,]  688740  695262  701847  708493  715203  721976  728813  735715  742683  749716  756816  763983  771218
 [9,]  614103  621809  629612  637513  645512  653613  661815  670119  678528  687043  695664  704394  713233
[10,]  501228  512147  523304  534705  546353  558255  570417  582844  595541  608515  621771  635317  649157
[11,]  386337  399718  413563  427887  442707  458041  473906  490320  507303  524874  543053  561862  581323
[12,]  274949  287652  300943  314847  329393  344612  360534  377192  394619  412851  431926  451882  472760
[13,]  216546  225744  235332  245327  255747  266610  277934  289739  302046  314875  328249  342191  356725
```

Population extrapolation projects a population size for a time beyond the available data points. The `project()` function estimate values for a given year denoted by `x` based on growth rates calculated by geometric interpolation between `from` and `to`. For example, 

```r
project(100, 200, from=2010, to=2020, x=2025)
```

returns $283$. 

## Years of potential life lost

The concept of years of potential life lost (YPLL) involves estimating the average time a person would have lived had he or she not died prematurely [@Gardner]. Let $d_i$ represent the number of deaths due to a given cause within the $i$-th age group. The YPLL for this cause of death can be estimated using the following equation:

$$YPLL = \sum_{i=1}^{K^*} a_i d_i$$

where $K^*$ is the number of age groups between 0 and $K$, $a_i$ is the difference between $K$ and the midpoint of age in each age group, assuming a uniform distribution of deaths in each group, and $K$ is the standard age of death. The midpoint of an age group is estimated as (lowest age + highest age + 1)/2.

Different authors use different values for $K$. According to Bruce et al. (2018), historically, WHO has used life expectancy from Japan, this being the highest in the world. Other authors uses 75 years as the reference age because it approximates US life expectancy [@Ma].

The `YPLL()` function has three arguments, `d` (a vector containing the number of deaths in each age group), `ages` (a vector containing the lower limit of each age group), and `K` (the standard life expectancy age, the default is 75 years). For example,

```r
d    <- c(1,12,60,100,137,200,225,236,237,258,226)
ages <- seq(20,70,5)
YPLL(d,ages,K=75)
```

returns a list with two components:

```r
$out
           d  mid    a     ad
20 to 24   1 22.5 52.5   52.5
25 to 29  12 27.5 47.5  570.0
30 to 34  60 32.5 42.5 2550.0
35 to 39 100 37.5 37.5 3750.0
40 to 44 137 42.5 32.5 4452.5
45 to 49 200 47.5 27.5 5500.0
50 to 54 225 52.5 22.5 5062.5
55 to 59 236 57.5 17.5 4130.0
60 to 64 237 62.5 12.5 2962.5
65 to 69 258 67.5  7.5 1935.0
70 to 74 226 72.5  2.5  565.0

$estimate
[1] 31530
```

The first component (`out`) is a matrix containing the number of deaths in each age group, the correspondent midpoint of age, the difference between the midpoint of age and $K$, and the product $a_i d_i$. The second component (`estimate`) refers to the years of potential life lost for this specific cause of death. The YPLL rate per 100,000 population is typically calculated as

$$ YPLL rate = 100,000 \times \dfrac{YPLL}{Population\ younger\ than\ K\ years}.$$ 

Age-standardized years of potential life lost (ASYPLL) involves adjusting the YPLL rate of a specific population to a standard population structure to allow for fair comparisons across different regions or time periods. This measure is given by

$$ ASYPLL = \sum\limits_{i=1}^{K^*} \dfrac{a_i d_i}{p_i} N_i,$$

where $K^*$ is the number of age groups between 0 and $K$, $a_i$ is the difference between $K$ and the midpoint of age in each age group, assuming a uniform distribution of deaths in each group, $d_i$ is the number of deaths in the $i$-th age group (`d`), $p_i$ is the population size for each age group within the study population (`pop`), and $N_i$ the population size for each age group within the reference population (`Nref`) [@Silva].

The `stdYPLL()` function of the `epiDeaths` package calculates the ASYPLL for a specific cause of death. 


# State of the field                                                                                                                  

Several tools exist for galactic dynamics computations:                                                     
`galpy` [@Bovy:2015] is a Python package with similar goals,
providing orbit integration and potential classes for galactic dynamics.                                                              
`NEMO` [@Teuben:1995] is a well-established, comprehensive stellar dynamics                                                           
toolbox written primarily in C, offering extensive functionality but with a                                                           
steeper learning curve and less integration with modern Python workflows.                                                             
Other tools like `GalPot` provide specific Milky Way potential models but lack                                                        
the broader dynamical analysis capabilities.                                                                                          
                                                                                                                                        
`Gala` was built rather than contributing to existing projects for several                                                            
reasons. First, `Gala` was designed from the ground up to integrate seamlessly                                                        
with the Astropy ecosystem, using `astropy.units` and `astropy.coordinates`                                                           
as core dependencies rather than optional features. This tight integration                                                            
enables natural workflows for astronomers already using Astropy. Second,                                                              
`Gala`'s object-oriented API with consistent interfaces across subpackages                                                            
(potentials, integrators, dynamics) provides a more modular and extensible                                                            
design than alternatives available at the time. Third, `Gala` fills a specific                                                        
niche between simple demonstration codes and full N-body simulation packages                                                          
like `Gadget` [@Springel:2005] – it focuses on the common tasks in galactic                                                             
dynamics research (orbit integration, potential evaluation, coordinate                                                                
transformations) while maintaining both performance through C implementations                                                         
and usability through its Python interface.  

# Software design

`Gala`'s design philosophy is based on three core principles: (1) to provide a
user-friendly, modular, object-oriented API, (2) to use community tools and
standards (e.g., Astropy for coordinates and units handling), and (3) to use
low-level code (C/C++/Cython) for performance while keeping the user interface
in Python. Within each of the main subpackages in `gala` (`gala.potential`,
`gala.dynamics`, `gala.integrate`, etc.), we try to maintain a consistent API
for classes and functions. For example, all potential classes share a common
base class and implement methods for computing the potential, forces, density,
and other derived quantities at given positions. This also works for
compositions of potentials (i.e., multi-component potential models), which
share the potential base class but also act as a dictionary-like container for
different potential components. As another example, all integrators implement a
common interface for numerically integrating orbits. The integrators and core
potential functions are all implemented in C without support for units, but the
Python layer handles unit conversions and prepares data to dispatch to the C
layer appropriately.Within the coordinates subpackage, we extend Astropy's
coordinate classes to add more specialized coordinate frames and
transformations that are relevant for Galactic dynamics and Milky Way research.

# Research impact statement

`Gala` has demonstrated significant research impact and grown both its user base
and contributor community since its initial release. The package has evolved
through contributions from over 18 developers beyond the original core developer
(@adrn), with community members adding new features, reporting bugs, and
suggesting new features.

While `Gala` started as a tool primarily to support the core developer's
research, it has expanded organically to support a range of applications across
domains in astrophysics related to Milky Way and galactic dynamics. The package
has been used in over 400 publications (according to Google Scholar) spanning
topics in galactic dynamics such as modeling stellar streams [@Pearson:2017],
Milky Way mass modeling, and interpreting kinematic and stellar population
trends in the Galaxy. `Gala` is integrated within the Astropy ecosystem as an
affiliated package and has built functionality that extends the widely-used
`astropy.units` and `astropy.coordinates` subpackages. `Gala`'s impact extends
beyond citations in research: Because of its focus on usability and user
interface design, `Gala` has also been incorporated into graduate-level galactic
dynamics curricula at multiple institutions.

`Gala` has been downloaded over 100,000 times from PyPI and conda-forge yearly
(or ~2,000 downloads per week) over the past few years, demonstrating a broad
and active user community. Users span career stages from graduate students to
faculty and other established researchers and represent institutions around the
world. This broad adoption and active participation validate `Gala`'s role as
core community infrastructure for galactic dynamics research.

# Mathematics

Single dollars ($) are required for inline mathematics e.g. $f(x) = e^{\pi/x}$

Double dollars make self-standing equations:

$$\Theta(x) = \left{\begin{array}{l}
0\textrm{ if } x < 0\cr
1\textrm{ else}
\end{array}\right.$$

You can also use plain \LaTeX for equations
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
and refer to \autoref{eq:fourier} from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Figures

Figures can be included like this:
![Caption for example figure.\label{fig:example}](figure.png)
and referenced from text using \autoref{fig:example}.

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png){ width=20% }

# AI usage disclosure

No generative AI tools were used in the development of this software, the writing
of this manuscript, or the preparation of supporting materials.

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and Semyeong
Oh, and support from Kathryn Johnston during the genesis of this project.

# References
