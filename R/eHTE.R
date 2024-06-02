#' eHTE
#'
#' Estimates the eHTE test statistic for two samples of possibly uneven length.
#'
#' @param placebo_arm A vector of patient-level treatment effects from the control condition (e.g., placebo).
#' @param drug_arm A vector of patient-level treatment effects from the active condition (e.g., active drug).
#' @param pctiles A vector of percentiles at which to evaluate the drug/placebo difference. Default is a vector of percentiles between the 3rd and 97th at increments of 2 (as in Siegel et al 2024).
#' @return An custom object of class 'eHTE_class', which accepts methods summary(), plot(), and print().
#' @export
eHTE <- function(placebo_arm,drug_arm,pctiles=seq(from=3,to=97,by=2)/100){
  n_pbo <- length(placebo_arm)
  n_act <- length(drug_arm)
  quantiles_placebo <- quantile(placebo_arm,probs=pctiles)
  quantiles_drug <- quantile(drug_arm,probs=pctiles)
  D_xi <- quantiles_drug - quantiles_placebo
  eHTE <- sd(D_xi) / sd(placebo_arm)
  result <- list(eHTE = eHTE,
                 n_pbo = n_pbo,
                 n_act = n_act,
                 placebo_arm=placebo_arm,
                 drug_arm=drug_arm,
                 pctiles=pctiles)
  class(result) <- "eHTE_class"
  return(result)
}

# Custom print method for class eHTE_class
#' @export
print.eHTE_class <- function(x){
  print(x[1:3])
}

# Custom plot method for class eHTE_class
#' @export
plot.eHTE_class <- function(x){
  plot(x[4])
}

# Custom summary method for class eHTE_class
#' @export
summary.eHTE_class <- function(x){
  cat("Summary of eHTE estimate (package eHTE)\n\n")
  cat("Input Parameters:\n")
  cat(paste0("Number of Percentiles: ",length(x[6]),"\n",sep=""))
  cat(paste0("Range of Percentiles Used: ",min(x[6])," to ",max(x[6]),"\n",sep=""))
  cat(paste0("Number of Observations, Control Condition (e.g., placebo): ",x[2],"\n",sep=""))
  cat(paste0("Number of Observations, Active Condition (e.g., drug): ",x[3],"\n",sep=""))
  cat("Output:\n")
  cat(paste0("eHTE estimate: ",x[1],sep=""))
}