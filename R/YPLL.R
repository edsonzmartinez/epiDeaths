#' YPLL: Years of potential life lost
#' @description Calculates the YPLL, a measure of the amount of life lost due to premature mortality.
#' @param d a vector containing the number of deaths in each age group.
#' @param ages a vector containing the lower limit of each age group.
#' @param K the standard life expectancy age. The default is 75 years.
#' @details
#' The concept of years of potential life lost (YPLL) involves estimating the average time a person would have lived had he or she not died prematurely (Gardner and Sanborn, 1990).
#' Denoting the number of deaths in the \eqn{i}-th age group by \eqn{d_i}, the YPLL can be estimated by
#' \deqn{YPLL = \sum_{i=1}^{K^*} a_i d_i}
#' where \eqn{K^*} is the number of age groups between 0 and K, \eqn{a_i} is the difference between K and the midpoint of age in each age group, assuming a uniform distribution of deaths in each group, and K is the standard age of death.
#' The midpoint of an age group is estimated as (lowest age + highest age + 1)/2.
#'
#' Different authors use different values for K. According to Bruce et al. (2018), historically, WHO has used life expectancy from Japan, this being the highest in the world.
#' Other authors uses 75 years as the reference age because it approximates US life expectancy (Ma et al., 2015).
#' @references
#' Bruce, N., Pope, D., Stanistreet, D. (2018). Quantitative Methods for Health Research: A Practical Interactive Guide to Epidemiology and Statistics. Second Edition. John Wiley & Sons Ltd.
#'
#' Gardner, J.W., Sanborn, J.S. (1990). Years of potential life lost (YPLL) - what does it measure? Epidemiology, 1(4):322-9. doi: 10.1097/00001648-199007000-00012.
#'
#' Ma, J., Ward, E.M., Siegel, R.L., Jemal, A. (2015). Temporal trends in mortality in the United States, 1969-2013. Jama, 314(16), 1731-1739. doi: 10.1001/jama.2015.12319.
#' @examples
#' # Example
#' d    <- c(1,12,60,100,137,200,225,236,237,258,226)
#' ages <- seq(20,70,5)
#' YPLL(d,ages,75)
#' @returns Returns a list with two components:
#' \itemize{
#'   \item \code{out}: A matrix containing the number of deaths in each age group (\eqn{d_i}), the correspondent midpoint of age, the difference between the midpoint of age and K (\eqn{a_i}), and the product \eqn{a_i d_i}.
#'   \item \code{estimate}: The years of potential life lost.
#' }
#' @export
YPLL <- function(d,ages=ages,K=75) {
  ages  <- c(ages,K)
  n     <- sum(ages<K)
  typll <- matrix(rep(NA,4*n),ncol=4)
  typll[,1] <- d[1:n]
  typll[,2] <- (ages[1:n]+ages[2:(n+1)])/2
  typll[,3] <- K-typll[,2]
  typll[,4] <- typll[,1]*typll[,3]
  labx <- paste(ages[1:n],"to",ages[2:(n+1)]-1)
  rownames(typll) <- labx
  colnames(typll) <- c("d","mid","a","ad")
  estimate <- sum(typll[,4])
  return(list(out=typll,estimate=estimate))
}

