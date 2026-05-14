#' Performs gene clustering
#' @param se SummarizedExperiment
#' @param method "kmeans" o "hclust"
#' @param k clusters number
#' @export
cluster_genes <- function(se, method = "kmeans", k = 3) {
  mat <- SummarizedExperiment::assay(se)

  if (method == "kmeans") {
    set.seed(123)
    cl <- kmeans(mat, centers = k)$cluster
  } else {
    dist_mat <- dist(mat)
    hc <- hclust(dist_mat)
    cl <- cutree(hc, k = k)
  }

  # We save the result in the row metadata
  SummarizedExperiment::rowData(se)$Cluster <- as.factor(cl)
  return(se)
}
