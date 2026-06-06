# Summary

The epiDeaths package is an open-source R package designed for
calculating mortality indicators. The package enables tr

# Statement of need

Studies of mortality are essential for public health. These
epidemiological studies enable us to identify the leading causes of
death in different regions and age groups, helping governments to
prioritise investment in areas such as sanitation and infrastructure,
and evaluate the effectiveness of public policies established to ensure
integral health care within a given population. Different type of
mortality indicators are used to understand mortality trend in an
population, as the standardized mortality ratio, the age-adjusted
mortality rate, the years of potential life lost, and the
age‐standardized years of potential life lost. `epiDeaths` is an R
package that provides functions designed to make it easier to obtain
these mortality indicators.

`epiDeaths` is available both on GitHub (repo; docs) and CRAN, and was
designed to be used by epidemiological researchers, professionals
working in public health surveillance, and by students in courses on
epidemiology or public health. It can significantly reduce the time
spent calculating indicators, which are often produced using
spreadsheets.

# Usage

Age-adjusted rates were developed in 1841 for the analysis of mortality
data (3). The function
[`AAMR()`](https://edsonzmartinez.github.io/epiDeaths/reference/AAMR.md)
calculates the age-adjusted mortality rate based on direct
standardisation \[@Bruce:2018\].

# State of the field

Several tools exist for galactic dynamics computations:  
`galpy` \[@Bovy:2015\] is a Python package with similar goals, providing
orbit integration and potential classes for galactic dynamics.  
`NEMO` \[@Teuben:1995\] is a well-established, comprehensive stellar
dynamics  
toolbox written primarily in C, offering extensive functionality but
with a  
steeper learning curve and less integration with modern Python
workflows.  
Other tools like `GalPot` provide specific Milky Way potential models
but lack  
the broader dynamical analysis capabilities.

`Gala` was built rather than contributing to existing projects for
several  
reasons. First, `Gala` was designed from the ground up to integrate
seamlessly  
with the Astropy ecosystem, using `astropy.units` and
`astropy.coordinates`  
as core dependencies rather than optional features. This tight
integration  
enables natural workflows for astronomers already using Astropy.
Second,  
`Gala`’s object-oriented API with consistent interfaces across
subpackages  
(potentials, integrators, dynamics) provides a more modular and
extensible  
design than alternatives available at the time. Third, `Gala` fills a
specific  
niche between simple demonstration codes and full N-body simulation
packages  
like `Gadget` \[@Springel:2005\] – it focuses on the common tasks in
galactic  
dynamics research (orbit integration, potential evaluation, coordinate  
transformations) while maintaining both performance through C
implementations  
and usability through its Python interface.

# Software design

`Gala`’s design philosophy is based on three core principles: (1) to
provide a user-friendly, modular, object-oriented API, (2) to use
community tools and standards (e.g., Astropy for coordinates and units
handling), and (3) to use low-level code (C/C++/Cython) for performance
while keeping the user interface in Python. Within each of the main
subpackages in `gala` (`gala.potential`, `gala.dynamics`,
`gala.integrate`, etc.), we try to maintain a consistent API for classes
and functions. For example, all potential classes share a common base
class and implement methods for computing the potential, forces,
density, and other derived quantities at given positions. This also
works for compositions of potentials (i.e., multi-component potential
models), which share the potential base class but also act as a
dictionary-like container for different potential components. As another
example, all integrators implement a common interface for numerically
integrating orbits. The integrators and core potential functions are all
implemented in C without support for units, but the Python layer handles
unit conversions and prepares data to dispatch to the C layer
appropriately.Within the coordinates subpackage, we extend Astropy’s
coordinate classes to add more specialized coordinate frames and
transformations that are relevant for Galactic dynamics and Milky Way
research.

# Research impact statement

`Gala` has demonstrated significant research impact and grown both its
user base and contributor community since its initial release. The
package has evolved through contributions from over 18 developers beyond
the original core developer (@adrn), with community members adding new
features, reporting bugs, and suggesting new features.

While `Gala` started as a tool primarily to support the core developer’s
research, it has expanded organically to support a range of applications
across domains in astrophysics related to Milky Way and galactic
dynamics. The package has been used in over 400 publications (according
to Google Scholar) spanning topics in galactic dynamics such as modeling
stellar streams \[@Pearson:2017\], Milky Way mass modeling, and
interpreting kinematic and stellar population trends in the Galaxy.
`Gala` is integrated within the Astropy ecosystem as an affiliated
package and has built functionality that extends the widely-used
`astropy.units` and `astropy.coordinates` subpackages. `Gala`’s impact
extends beyond citations in research: Because of its focus on usability
and user interface design, `Gala` has also been incorporated into
graduate-level galactic dynamics curricula at multiple institutions.

`Gala` has been downloaded over 100,000 times from PyPI and conda-forge
yearly (or ~2,000 downloads per week) over the past few years,
demonstrating a broad and active user community. Users span career
stages from graduate students to faculty and other established
researchers and represent institutions around the world. This broad
adoption and active participation validate `Gala`’s role as core
community infrastructure for galactic dynamics research.

# Mathematics

Single dollars (\$) are required for inline mathematics
e.g. $`f(x) = e^{\pi/x}`$

Double dollars make self-standing equations:

\$\$\Theta(x) = \left\\\begin{array}{l} 0\textrm{ if } x \< 0\cr
1\textrm{ else} \end{array}\right.\$\$

You can also use plain for equations
``` math
\begin{equation}\label{eq:fourier}
\hat f(\omega) = \int_{-\infty}^{\infty} f(x) e^{i\omega x} dx
\end{equation}
```
and refer to from text.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.md)
format.

If you want to cite a software repository URL (e.g. something on GitHub
without a preferred citation) then you can do it with the example BibTeX
entry below for @fidgit.

For a quick reference, the following citation commands can be used: -
`@author:2001` -\> “Author et al. (2001)” - `[@author:2001]` -\>
“(Author et al., 2001)” - `[@author1:2001; @author2:2001]` -\> “(Author1
et al., 2001; Author2 et al., 2002)”

# Figures

Figures can be included like this: ![Caption for example
figure.](figure.png) and referenced from text using .

Figure sizes can be customized by adding an optional second parameter:
![Caption for example figure.](figure.png)

# AI usage disclosure

No generative AI tools were used in the development of this software,
the writing of this manuscript, or the preparation of supporting
materials.

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and
Semyeong Oh, and support from Kathryn Johnston during the genesis of
this project.

# References
