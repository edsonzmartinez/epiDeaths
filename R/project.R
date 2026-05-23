#' project: Geometric population projection
#' @description Geometric population projection is a forecasting method assuming a constant percentage growth rate over time.
#' @param pop1 a vector of the initial values.
#' @param pop2 a vector of the ending values.
#' @param from initial year or data point.
#' @param to ending year or data point.
#' @param x the year for which the extrapolation is to be made.
#' @returns This function returns a vector containing the extrapolated values.
#' @details
#' This function estimate values for a given year (\code{x}) based on growth rates calculated by geometric interpolation between \code{from} and \code{to}.
#' @references Laurenti, R., Mello Jorge, M.H.P., Lebrão, M.L., Gotlieb, S.L.D. (2005). Estatísticas de Saúde. 2nd edition. São Paulo: EPU. ISBN: 9788512408309.
#' @examples
#' ## Example 1
#' project(100, 200, from=2010, to=2020, x=2025)
#'
#' ## Example 2
#' pop1 <- c(2126148L, 775746L, 884602L, 957100L, 911673L, 812483L, 747361L, 688740L,
#'           614103L, 501228L, 386337L, 274949L, 216546L)
#' pop2 <- c(1787296L, 648467L, 752059L, 783322L, 808350L, 881275L, 892896L, 771218L,
#'           713233L, 649157L, 581323L, 472760L, 356725L)
#' project(pop1, pop2, from=2010, to=2022, x=2025)
#' @export
project <- function(pop1, pop2, from=2010, to=2022, x=2025) {
  if (length(pop1)!=length(pop2)) { stop("Vectors pop1 and pop2 must be the same size") }
  rsx    <- (pop2/pop1)^(1/(to-from)) - 1
  estim  <- round(pop1*(1+rsx)^(x-from),0)
  return(estim)
}
