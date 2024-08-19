#' eHTE: A Package for Estimating Heterogeneous Treatment Effects
#'
#' The eHTE package provides tools for estimating heterogeneous treatment effects.
#' This work is based on \href{https://www.medrxiv.org/content/10.1101/2024.04.23.24306211v1}{Siegel et al, 2024}.
#'
#' @section Functions:
#' The main functions in this package are:
#' \itemize{
#'   \item \code{\link{estimateHTE}}: Estimates the eHTE metric of  \href{https://www.medrxiv.org/content/10.1101/2024.04.23.24306211v1}{Siegel et al, 2024}.
#'   \item \code{\link{testHTE}}: Tests the eHTE metric using the non-parameteric permutation method described by  \href{https://www.medrxiv.org/content/10.1101/2024.04.23.24306211v1}{Siegel et al, 2024}.
#' }
#' @section Datasets:
#' The example dataset provided with this package is:
#' \itemize{
#'   \item \code{\link{loebel_data}}: An approximation of the Loebel et al 2013 data analyzed by Siegel et al 2024 for evidence of HTE.
#'   \item \code{\link{raison_data}}: The Raison et al 2023 data analyzed by Siegel et al 2024 for evidence of HTE.
#' }
#' @docType package
#' @name eHTE
#' @aliases eHTE-package
#' @keywords package
#' @author
#' Chris Chatham \email{chathach@gmail.com}
"_PACKAGE"
