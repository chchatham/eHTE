# eHTE R Package

## Description

This package provides functions for assessing treatment effect heterogeneity, as described by Siegel et al 2024 (https://www.medrxiv.org/content/10.1101/2024.04.23.24306211v1) 

## Installation

You can install the development version from GitHub using R or R Studio, as follows:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install the package from GitHub
devtools::install_github("chchatham/eHTE")


## Basic Usage

You can view the documentation for the package and functions within it, as follows:

```r
# Check help for eHTE package
?eHTE

# Compute the eHTE estimator of Siegel et al 2024 on the approximated (manually-digitized) data of Loebel et al 2013, with Quetiapine: 
result <- estimateHTE(loebel_data[loebel_data$arm=="placebo","PANSSchg"],loebel_data[loebel_data$arm=="quetiapine","PANSSchg"])

# Plot the result (approximating Figure 3A, bottom panel, of Siegel et al 2024)
plot(result)
