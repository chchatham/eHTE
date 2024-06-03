#' estimateHTE
#'
#' Estimates the eHTE test statistic for two samples of possibly uneven length.
#'
#' @param placebo_arm A vector of patient-level treatment effects from the control condition (e.g., placebo).
#' @param drug_arm A vector of patient-level treatment effects from the active condition (e.g., active drug).
#' @param pctiles A vector of percentiles at which to evaluate the drug/placebo difference. Default is a vector of percentiles between the 3rd and 97th at increments of 2 (as in Siegel et al 2024).
#' @return A custom object of class 'eHTE_class', which accepts methods summary(), plot(), and print(). P-value will be null until testHTE() is run on the result.
#' @export
estimateHTE <- function(placebo_arm,drug_arm,pctiles=seq(from=3,to=97,by=2)/100){
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
                 pctiles=pctiles,
                 D_xi=D_xi,
                 pval=NULL)
  class(result) <- "eHTE_class"
  return(result)
}

#' testHTE
#'
#' Compute a p-value of an obtained eHTE estimate, using non-parametric permutation of the individuals in the placebo/control and drug/active arms. This p-value represents the proportion of observations from the permuted null distribution which are equally or more extreme than the value estimated using estimateHTE(). As such, this is a one-sided p-value for testing whether there is greater evidence for treatment effect heterogeneity in the active than in the control condition.
#'
#' @param estimateHTE_result An object of class eHTE_class - for example, the result of estimateHTE()
#' @param n_perm The number of permutations desired. Default = 100.
#' @return A custom object of class 'eHTE_class', which accepts methods summary(), plot(), and print().
#' @export
testHTE <- function(estimateHTE_result,n_perm=100){
  perm_arm_ur <- c(estimateHTE_result$placebo_arm,estimateHTE_result$drug_arm)
  pb = txtProgressBar(min = 0, max = n_perm, initial = 0,style = 3)
  null_eHTE <- rep(NA,n_perm)
  for(n in 1:n_perm){
    perm_arm <- sample(perm_arm_ur)
    placebo_arm <- perm_arm[1:estimateHTE_result$n_pbo]
    drug_arm <- perm_arm[(estimateHTE_result$n_pbo+1):length(perm_arm)]
    placebo_sd <- sd(placebo_arm)
    quantiles_placebo <- quantile(placebo_arm,probs=estimateHTE_result$pctiles)
    quantiles_drug <- quantile(drug_arm,probs=estimateHTE_result$pctiles)
    D_xi <- quantiles_drug - quantiles_placebo
    null_eHTE[n] <- sd(D_xi) / placebo_sd
    setTxtProgressBar(pb,n)
  }
  close(pb)
  result <- list(eHTE = estimateHTE_result$eHTE,
                 n_pbo = estimateHTE_result$n_pbo,
                 n_act = estimateHTE_result$n_act,
                 placebo_arm=estimateHTE_result$placebo_arm,
                 drug_arm=estimateHTE_result$drug_arm,
                 pctiles=estimateHTE_result$pctiles,
                 D_xi=estimateHTE_result$D_xi,
                 pval=length(which(null_eHTE>=estimateHTE_result$eHTE))/length(null_eHTE))
  class(result) <- "eHTE_class"
  return(result)
}

# Custom print method for class eHTE_class
#' @export
print.eHTE_class <- function(x){
  print(x)
}

# Custom plot method for class eHTE_class
#' @export
plot.eHTE_class <- function(x){
  ecdf_drug <- ecdf(x$drug_arm)
  ecdf_pbo <- ecdf(x$placebo_arm)
  layout(matrix(c(1, 1, 2), nrow = 1, byrow = TRUE))
  plot(ecdf_drug, main = "Empirical Cumulative Distribution Functions", xlab="Sx Score", ylab="Cumulative Percentile", col="red")
  lines(ecdf_pbo, col="blue")
  legend("bottomright", legend = c("Placebo (control)", "Drug (active)"),
         col = c("blue", "red"), lwd = 2)
  plot(y=(1:length(x$D_xi))/length(x$D_xi),x=ecdf_drug-ecdf_pbo,col="red",pch=19,xlab="Sz Score Diff from PCB",ylab="",yaxt="n")
  layout(1)
}

# Custom summary method for class eHTE_class
#' @export
summary.eHTE_class <- function(x){
  cat("Summary of eHTE estimate (package eHTE)\n\n")
  cat("Input Parameters:\n")
  cat(paste0("Number of Percentiles: ",length(x$pctiles),"\n",sep=""))
  cat(paste0("Range of Percentiles Used: ",min(x$pctiles)," to ",max(x$pctiles),"\n",sep=""))
  cat(paste0("Number of Observations, Control Condition (e.g., placebo): ",x$n_pbo,"\n",sep=""))
  cat(paste0("Number of Observations, Active Condition (e.g., drug): ",x$n_act,"\n\n",sep=""))
  cat("Output:\n")
  cat(paste0("eHTE estimate: ",x$eHTE,"\n",sep=""))
  if(!is.null(x$pval)){
    cat(paste0("eHTE p-value (one-sided, for greater HTE in drug than placebo): ",x$pval,"\n",sep=""))
  } else {
    warning("To compute a p-value, you must first call testHTE() on the result of estimateHTE()")
  }
}