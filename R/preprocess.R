#' Normalize data and remove low-variance genes
#' @param se SummarizedExperiment object
#' @param method Normalization method ("log" or "quantile")
#' @export
normalize_data <- function(se, method = "log") {
  mat <- SummarizedExperiment::assay(se)

  if (method == "log") {
    mat_norm <- log2(mat + 1)
  } else if (method == "quantile") {
    #Requires preprocessCore
    mat_norm <- preprocessCore::normalize.quantiles(mat)
    rownames(mat_norm) <- rownames(mat)
    colnames(mat_norm) <- colnames(mat)
  }

  SummarizedExperiment::assay(se) <- mat_norm
  return(se)
}

#' Identify outlier genes based on variance Z-score
#' @export
detect_outliers <- function(se, threshold = 3) {
  vars <- apply(SummarizedExperiment::assay(se), 1, var)
  z_scores <- abs((vars - mean(vars)) / sd(vars))
  keep <- z_scores < threshold
  message(paste("Removed", sum(!keep), "outlier genes"))
  return(se[keep, ])
}
