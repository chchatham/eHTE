#' Loebel et al 2013 Example Dataset
#'
#' This is the patient-level change data originally reported in \href{https://jamanetwork.com/journals/jama/article-abstract/2808950}{Raison et al 2023 }.
#'
#' @docType data
#' @name raison_data
#' @usage data(raison_data)
#' @format A dataframe with 94 rows (each a distinct patient) and 5 columns:
#' \itemize{
#'   \item \strong{SUBJID}: Subject ID (e.g., Sub1, Sub2, etc.)
#'   \item \strong{arm}: Arm of the study (e.g., Placebo or Psilocybin)
#'   \item \strong{Baseline}: Baseline on the MADRS
#'   \item \strong{Week 6}: Week 6 on the MADRS
#'   \item \strong{MADRSchg}: Change from Baseline at Week 6 on the MADRS
#' }
#'  @section Source:
#'  This data was retrieved from \href{https://gitlab.com/siegelandthebrain1/ehte/-/tree/main/eHTE_matlab_package?ref_type=heads}{Joshua Siegel's Gitlab Page for his eHTE package}.
NULL
