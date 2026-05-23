#' interpol: Geometric interpolation between two years
#' @description Calculates intermediate values between a starting value and an ending value by finding an average annual growth rate.
#' @param pop1 a vector of the initial values.
#' @param pop2 a vector of the ending values.
#' @param from initial year or data point.
#' @param to ending year or data point.
#' @returns The function returns a list containing two components:
#' \itemize{
#'   \item \code{rsx}: The growth rates.
#'   \item \code{interpdata}: A matrix of the intermediate values.
#' }
#' @details
#' This function uses geometric interpolation to calculate intermediate values between a starting value and an ending value. The growth rate by sex (s) and age group (x) is given by
#' \deqn{r_{sx} = \left(\dfrac{pop_{1sx}}{pop_{2sx}}\right)^{1/\Delta t} - 1}
#' where \eqn{pop_{1sx}} and \eqn{pop_{2sx}} are the populations for the initial and final data points, respectively, and \eqn{\Delta t} is the time elapsed between the two dates.
#' @references Laurenti, R., Mello Jorge, M.H.P., Lebrão, M.L., Gotlieb, S.L.D. (2005). Estatísticas de Saúde. 2nd edition. São Paulo: EPU. ISBN: 9788512408309.
#' @examples
#' # Example 1
#' # Laurenti et al. (1985), page 34
#' # Brazilian population in 1970:  93,215,300
#' # Brazilian population in 1980: 119,098,992
#' interpol(93215300, 119098992, 1970, 1980)
#'
#' # Example 2
#' pop1 <- c(2126148L, 775746L, 884602L, 957100L, 911673L, 812483L, 747361L, 688740L,
#'           614103L, 501228L, 386337L, 274949L, 216546L)
#' pop2 <- c(1787296L, 648467L, 752059L, 783322L, 808350L, 881275L, 892896L, 771218L,
#'           713233L, 649157L, 581323L, 472760L, 356725L)
#' out  <- interpol(pop1,pop2,from=2010,to=2022)
#' out$rsx        # the annual growth rate
#' out$interpdata # a matrix of the intermediate values
#' @export
interpol <- function(pop1,pop2,from=2010, to=2022) {
  if (length(pop1)!=length(pop2)) { stop("Vectors pop1 and pop2 must be the same size") }
  rsx    <- (pop2/pop1)^(1/(to-from)) - 1
  ano    <- from:to
  nyears <- to-from
  nagegr <- length(pop1)
  interpdata <- matrix(rep(NA,(nyears+1)*nagegr),nrow=nagegr)
  colnames(interpdata) <- ano
  interpdata[,1] <- pop1
  interpdata[,nyears+1] <- pop2
  for (j in 2:nyears) {
    for (fet in 1:nagegr) {
      interpdata[fet,j]  <- round(interpdata[fet,1]*(1+rsx[fet])^(ano[j]-from),0)
    }}
  return(list(rsx=rsx,interpdata=interpdata))
}
