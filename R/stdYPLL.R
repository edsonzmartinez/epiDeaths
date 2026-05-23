#' stdYPLL: Age‐standardized years of potential life lost
#' @description Calculates the age‐standardized YPLL, a measure of the amount of life lost due to premature mortality.
#' @param d a vector containing the number of deaths in each age group in the study population.
#' @param pop a vector containing the population size for each age group within the study population.
#' @param Nref a vector containing the population size for each age group within the reference population.
#' @param ages a vector containing the lower limit of each age group.
#' @param K the standard life expectancy age. The default is 75 years.
#' @param fac a factor used to represent the mortality rate as "deaths per \code{fac} population". The default is 1e4.
#' @details
#' Age-Standardized Years of Potential Life Lost (ASYPLL) involves adjusting the YPLL rate of a specific population to a standard population structure to allow for fair comparisons across different regions or time periods. This measure is given by
#' \deqn{ASYPLL = \sum\limits_{i=1}^{K^*} \dfrac{a_i d_i}{p_i} N_i}
#' where \eqn{K^*} is the number of age groups between 0 and K, \eqn{a_i} is the difference between K and the midpoint of age in each age group, assuming a uniform distribution of deaths in each group, \eqn{d_i} is the number of deaths in the \eqn{i}-th age group (\code{d}), \eqn{p_i} is the population size for each age group within the study population (\code{pop}), and \eqn{N_i} the population size for each age group within the reference population (\code{Nref}) (Silva Filho et al., 2024).
#'
#' The age‐standardized YPLL rate is given by
#' \deqn{ASYPLL\ rate = \dfrac{ASYPLL}{\sum_{i=1}^{K^*} N_i} \times C}
#' These measure is interpreted in years per \eqn{C} people, where \eqn{C} is specified by the argument \code{fac}.
#' @references
#' Silva Filho, A.M.D., Araújo, E.M.D., Souza, I.M.D., Luiz, O.D.C., Máximo, G., Queiroz, F.D.A., Cavalcante, L., Nisida, V. (2024). Years of potential life lost due to COVID-19 according to race/color and gender in Brazil between 2020 and 2021. Ciência & Saúde Coletiva, 29, e04702023. doi: 10.1590/1413-81232024293.04702023EN
#' @examples
#' # Example 1
#' d    <- c(0,0,1,12,60,100,137,200,225,236,237,258,226)
#' pop  <- c(1787296,648467,752059,783322,808350,881275,892896,
#'           771218,713233,649157,581323,472760,356725)
#' Nref <- c(3906682,1396816,1584091,1655473,1730527,1873165,1902856,
#'           1639164,1534930,1433780,1294948,1054437,795497)
#' ages <- c(0,15,20,25,30,35,40,45,50,55,60,65,70)
#' stdYPLL(d,pop,Nref,ages)
#'
#' # Example 2
#' d <- c(10,50,20)
#' pop  <- c(50000,40000,10000)
#' Nref <- c(20000,20000,10000)
#' ages <- c(0,35,65)
#' stdYPLL(d,pop,Nref,ages)
#' @returns Returns a list with five components:
#' \itemize{
#'   \item \code{out}: A matrix containing in its columns the number of deaths in each age group (\eqn{d_i}), the correspondent midpoint of age, the difference between the midpoint of age and K (\eqn{a_i}), the product \eqn{a_i d_i}, the population size for each age group within the reference population, the age‑specific YPLL rates (YPLL per person), and the age‑specific YPLL, respectively.
#'   \item \code{ypll}: The crude estimate of YPLL.
#'   \item \code{ypllrate}: The YPLL rate in years per \code{fac} people.
#'   \item \code{stdypll}: The age‐standardized YPLL.
#'   \item \code{stdypllrate}: The age‐standardized YPLL rate in years per \code{fac} people.
#' }
#' @export
stdYPLL <- function(d,pop,Nref,ages=ages,K=75,fac=1e4) {
  ages  <- c(ages,K)
  n     <- sum(ages<K)
  typll <- matrix(rep(NA,8*n),ncol=8)
  typll[,1] <- d[1:n]
  typll[,2] <- (ages[1:n]+ages[2:(n+1)])/2
  typll[,3] <- K-typll[,2]
  typll[,4] <- typll[,1]*typll[,3]
  typll[,5] <- pop[1:n]
  typll[,6] <- typll[,4]/typll[,5] # Age‑specific YPLL rates (YPLL per person)
  typll[,7] <- Nref[1:n]
  typll[,8] <- typll[,6]*typll[,7]
  sumN0K <- sum(Nref)
  labx <- paste(ages[1:n],"to",ages[2:(n+1)]-1)
  rownames(typll) <- labx
  colnames(typll) <- c("d","mid","a","ad","P","asYPLLrates","Nref","asYPLL")
  ypll        <- sum(typll[,4])
  ypllrate    <- fac*ypll/sum(typll[,5])
  stdypll     <- sum(typll[,8])
  stdypllrate <- fac*stdypll/sum(typll[,7])
return(list(out=typll,ypll=ypll,ypllrate=ypllrate,stdypll=stdypll,stdypllrate=stdypllrate))
}
