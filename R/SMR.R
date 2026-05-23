#' SMR: Standardized mortality ratio
#' @description Calculates the Standardized Mortality Ratio (SMR), a measure comparing the observed number of deaths in a study population to the expected deaths based on a standard population, adjusted for age and sex.
#' @param d a vector containing the number of deaths in each age group in the study population.
#' @param pop a vector containing the population size for each age group within the study population.
#' @param dref a vector containing the number of deaths in each age group in the reference population.
#' @param Nref a vector containing the population size for each age group within the reference population.
#' @param ages a vector containing the lower limit of each age group.
#' @importFrom stats qnorm
#' @details
#' An SMR is calculated by the indirect method of standardisation. It compares the actual deaths in a study population to the deaths that would be expected if that population had the same age/sex-specific mortality rates as a standard population. SMR is calculated as
#' \deqn{SMR = \dfrac{observed\ number\ of\ deaths}{expected\ number\ of\ deaths}}
#' It is commonly used in epidemiology for age-standardized mortality comparisons. An SMR of 1.0 means that the number of observed deaths is equal to the number of expected deaths. An SMR higher than 1.0 indicates higher-than-expected mortality, while an SMR lower than 1.0 indicates lower-than-expected mortality.
#' @references
#' Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for Health Research: A Practical Interactive Guide to Epidemiology and Statistics. Second Edition. John Wiley & Sons Ltd. ISBN: 9781118665411.
#'
#' Ulm, K. (1990). Simple method to calculate the confidence interval of a standardized mortality ratio (SMR). American Journal of Epidemiology, 131:373–37, doi:10.1093/oxfordjournals.aje.a115507
#'
#' Vandenbroucke, J.P. (1982). A shortcut method for calculating the 95 percent confidence interval of the standardized mortality ratio. (Letter). American Journal of Epidemiology, 115:303-4, doi:10.1093/oxfordjournals.aje.a113306
#' @examples
#' ## Example
#' d    <- c(1,14,102,259,381,420,328,297)
#' pop  <- c(670858,1530547,1591913,1551481,1355325,1068705,604175,332148)
#' Nref <- c(7058427,15541422,16281290,15382114,12733791,9626735,5432779,2828223)
#' dref <- c(2,136,1185,2826,4188,4311,3384,3071)
#' SMR(d,pop,dref,Nref,ages=c(15,20,30,40,50,60,70,80,100))
#' @returns Returns a list with six components:
#' \itemize{
#'   \item \code{obs}: The observed number of deaths.
#'   \item \code{exp}: The expected number of death.
#'   \item \code{smr}: The standardized mortality ratio (SMR).
#'   \item \code{ci}:  An approximate 95\% confidence interval (CI) for the SMR by using the method proposed by Vandenbroucke (1982).
#'   \item \code{isr}: The indirectly standardised mortality rate per 10,000 inhabitants, given by 10,000 x SMR x crude death rate for the standard population (see Bruce et al., 2018, p. 110).
#'   \item \code{tabm}: A matrix containing \code{"d"}, \code{"pop"}, \code{"dref"}, \code{"Nref"} and the expected number of deaths at each age group.
#' }
#' @export
SMR <- function(d,pop,dref,Nref,ages=c()) {
  if (!all(sum(length(d))==c(sum(length(pop)),sum(length(dref)),sum(length(Nref)))))  stop("The vectors d, pop, dref and Nref must all be the same length.")
  tabm <- matrix(rep(NA,5*length(d)),ncol=5)
  tabm[,1] <- d
  tabm[,2] <- pop
  tabm[,3] <- dref
  tabm[,4] <- Nref
  tabm[,5] <- pop*dref/Nref
  n <- length(d)
  if (is.null(ages)) labx <- paste("Age",1:n) else labx <- paste(ages[1:n],"to",ages[2:(n+1)]-1)
  rownames(tabm) <- labx
  colnames(tabm) <- c("deaths","population","deaths pop reference","pop reference","expected")
  smr   <- sum(d)/sum(tabm[,5])
  cilower   <- ((sqrt(sum(d)) - qnorm(1-0.05/2)*0.5)^2)/ sum(tabm[,5])
  ciupper   <- ((sqrt(sum(d)) + qnorm(1-0.05/2)*0.5)^2)/ sum(tabm[,5])
  crdstdpop <- sum(dref)/sum(Nref)
  isr       <- 10000*smr*crdstdpop
  return(list(obs=sum(d), exp=sum(tabm[,5]), smr=smr, ci=c(cilower,ciupper), isr=isr, tabm=tabm))
}
