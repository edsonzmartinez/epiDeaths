#' AAMR: Age-adjusted mortality rate
#' @description Calculates the age-adjusted mortality rate (direct standardisation).
#' @param d a vector containing the number of deaths in each age group in the study population.
#' @param pop a vector containing the population size for each age group within the study population.
#' @param Nref a vector containing the population size for each age group within the reference population.
#' @param ages a vector containing the lower limit of each age group.
#' @param fac a factor used to represent the mortality rate as "deaths per \code{fac} population". The default is 1e4.
#' @references
#' Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for Health Research: A Practical Interactive Guide to Epidemiology and Statistics. Second Edition. John Wiley & Sons Ltd.
#' @examples
#' ## Example 1
#' d    <- c(1,14,102,259,381,420,328,297)
#' pop  <- c(670858,1530547,1591913,1551481,1355325,1068705,604175,332148)
#' Nref <- c(7058427,15541422,16281290,15382114,12733791,9626735,5432779,2828223)
#' AAMR(d,pop,Nref,ages=c(15,20,30,40,50,60,70,80,100))
#'
#' ## Example 2
#' # Bruce et al. (2018), Exercise 3.3.1, p. 111.
#' d    <- c(15,31,78)
#' pop  <- c(4100,3000,2900)
#' Nref <- c(5000,3500,1500)
#' AAMR(d,pop,Nref,ages=c(65,75,85,100),fac=1000)
#' @returns Returns a list with three components:
#' \itemize{
#'   \item \code{crude}: The crude mortality rate.
#'   \item \code{adj}: The age-adjusted mortality rate.
#'   \item \code{tabm}: A matrix containing \code{"d"}, \code{"pop"}, \code{"Nref"} and the expected number of deaths at each age group.
#' }
#' @export
AAMR <- function(d,pop,Nref,ages=c(),fac=1e4) {
  if (!all(sum(length(d))==c(sum(length(pop)),sum(length(Nref))))) stop("The vectors d, pop and Nref must all be the same length.")
  tabm <- matrix(rep(NA,4*length(d)),ncol=4)
  tabm[,1] <- d
  tabm[,2] <- pop
  tabm[,3] <- Nref
  tabm[,4] <- Nref*d/pop
  n <- length(d)
  if (is.null(ages)) labx <- paste("Age",1:n) else labx <- paste(ages[1:n],"to",ages[2:(n+1)]-1)
  rownames(tabm) <- labx
  colnames(tabm) <- c("deaths","population","pop reference","expected")
  crude <- fac*sum(d)/sum(pop)
  adj   <- fac*sum(tabm[,4])/sum(tabm[,3])
  return(list(crude=crude, adj=adj, tabm=tabm))
}
