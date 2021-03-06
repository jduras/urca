\name{ca.jo}
\alias{ca.jo}
\encoding{latin1}
\title{Johansen Procedure for VAR}
\description{
  Conducts the Johansen procedure on a given data set. The
  \code{"trace"} or \code{"eigen"} statistics are reported and the
  matrix of eigenvectors as well as the loading matrix.
}
\usage{
ca.jo(x, type = c("eigen", "trace"), ecdet = c("none", "const", "trend"), K = 2,
spec=c("longrun", "transitory"), season = NULL, dumvar = NULL)
}
\arguments{
  \item{x}{Data matrix to be investigated for cointegration.}
  \item{type}{The test to be conducted, either \sQuote{\code{eigen}} or
    \sQuote{\code{trace}}.}
  \item{ecdet}{Character, \sQuote{\code{none}} for no intercept in cointegration,
    \sQuote{\code{const}} for constant term in cointegration and
    \sQuote{\code{trend}} for trend variable in cointegration.}
  \item{K}{The lag order of the series (levels) in the VAR.}
  \item{spec}{Determines the specification of the VECM, see details below.}
  \item{season}{If seasonal dummies should be included, the data
    frequency must be set accordingly, \emph{i.e} \sQuote{4} for quarterly
    data.}
  \item{dumvar}{If dummy variables should be included, a matrix with
    row dimension equal to \code{x} can be provided.}
}

\details{

  Given a general VAR of the form:

  \deqn{\bold{X}_t = \bold{\Pi}_1 \bold{X}_{t-1} + \dots + \bold{\Pi}_k
    \bold{X}_{t-k} + \bold{\mu} + \bold{\Phi D}_t + \bold{\varepsilon}_t
    , \quad (t = 1, \dots, T),}

  the following two specifications of a VECM exist:

  \deqn{\Delta \bold{X}_t = \bold{\Gamma}_1 \Delta \bold{X}_{t-1} +
    \dots + \bold{\Gamma}_{k-1} \Delta \bold{X}_{t-k+1} + \bold{\Pi
    X}_{t-k} + \bold{\mu} + \bold{\Phi D}_t + \bold{\varepsilon}_t}

  where

  \deqn{\bold{\Gamma}_i = - (\bold{I} - \bold{\Pi}_1 - \dots -
    \bold{\Pi}_i), \quad (i = 1, \dots , k-1),}

  and

  \deqn{\bold{\Pi} = -(\bold{I} - \bold{\Pi}_1 - \dots - \bold{\Pi}_k)}

  The \eqn{\bold{\Gamma}_i} matrices contain the cumulative long-run
  impacts, hence if \code{spec="longrun"} is choosen, the above VECM is
  estimated.

  The other VECM specification is of the form:

  \deqn{\Delta \bold{X}_t = \bold{\Gamma}_1 \Delta \bold{X}_{t-1} +
    \dots + \bold{\Gamma}_{k-1} \Delta \bold{X}_{t-k+1} + \bold{\Pi
    X}_{t-1} + \bold{\mu} + \bold{\Phi D}_t + \bold{\varepsilon}_t}

  where

  \deqn{\bold{\Gamma}_i = - (\bold{\Pi}_{i+1} + \dots + \bold{\Pi}_k),
    \quad(i = 1, \dots , k-1),}

  and

  \deqn{\bold{\Pi} = -(\bold{I} - \bold{\Pi}_1 - \dots - \bold{\Pi}_k).}

  The \eqn{\bold{\Pi}} matrix is the same as in the first specification.
  However, the \eqn{\bold{\Gamma}_i} matrices now differ, in the sense
  that they measure transitory effects, hence by setting
  \code{spec="transitory"} the second VECM form is estimated. Please note
  that inferences drawn on \eqn{\bold{\Pi}} will be the same, regardless
  which specification is choosen and that the explanatory power is the
  same, too.

  If \code{"season"} is not NULL, centered seasonal dummy variables are
  included.

  If \code{"dumvar"} is not NULL, a matrix of dummy variables is included
  in the VECM. Please note, that the number of rows of the matrix
  containing the dummy variables must be equal to the row number of
  \code{x}.

  Critical values are only reported for systems with less than
  11 variables and are taken from Osterwald-Lenum.

}

\value{
  An object of class \code{ca.jo}.
}

\references{

  Johansen, S. (1988), Statistical Analysis of Cointegration Vectors,
  \emph{Journal of Economic Dynamics and Control}, \bold{12}, 231--254.

  Johansen, S. and Juselius, K. (1990), Maximum Likelihood Estimation and
  Inference on Cointegration -- with Applications to the Demand for
  Money, \emph{Oxford Bulletin of Economics and Statistics}, \bold{52,
    2}, 169--210.

  Johansen, S. (1991), Estimation and Hypothesis Testing of
  Cointegration Vectors in Gaussian Vector Autoregressive Models,
  \emph{Econometrica}, \bold{Vol. 59, No. 6}, 1551--1580.

  Osterwald-Lenum, M. (1992), A Note with Quantiles of the Asymptotic
  Distribution of the Maximum Likelihood Cointegration Rank Test
  Statistics, \emph{Oxford Bulletin of Economics and Statistics},
  \bold{55, 3}, 461--472.

}

\seealso{

  \code{\link{plotres}}, \code{\link{alrtest}}, \code{\link{ablrtest}},
  \code{\link{blrtest}}, \code{\link{cajolst}}, \code{\link{cajools}},
  \code{\link{lttest}}, \code{\link{ca.jo-class}} and \code{\link{urca-class}}.
}
\examples{
data(denmark)
sjd <- denmark[, c("LRM", "LRY", "IBO", "IDE")]
sjd.vecm <- ca.jo(sjd, ecdet = "const", type="eigen", K=2, spec="longrun",
season=4)
summary(sjd.vecm)
#
data(finland)
sjf <- finland
sjf.vecm <- ca.jo(sjf, ecdet = "none", type="eigen", K=2,
spec="longrun", season=4)
summary(sjf.vecm)
}
\author{Bernhard Pfaff}
\keyword{regression}
