#' eHTE: A Package for Estimating Heterogeneous Treatment Effects
#'
#' The eHTE package provides tools for estimating heterogeneous treatment effects.
#' This work is based on Siegel et al, 2024: https://www.medrxiv.org/content/10.1101/2024.04.23.24306211v1
#'
#' @section Functions:
#' The main functions in this package are:
#' \itemize{
#'   \item \code{\link{estimateHTE}}: Estimates the eHTE metric of Siegel et al.
#'   \item \code{\link{testHTE}}: Tests the eHTE metric using the non-parameteric permutation method described by Siegel et al.  
#' }
#' @section Example data:
#' Example data is included in this package, as well:
#' \itemize{
#'   \item \code{\link{loebel_data}}: Example dataset from Loebel et al 2013, digitized from Siegel et al 2024 Fig 3A.
#' }
#' @docType package
#' @name eHTE
#' @aliases eHTE-package
#' @keywords package
#' @author
#' Chris Chatham \email{chathach@gmail.com}
"_PACKAGE"