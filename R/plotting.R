#' Generate an interactive or static heatmap
#' @import ComplexHeatmap
#' @export
plot_expression_heatmap <- function(se) {
  mat <- SummarizedExperiment::assay(se)
  clusters <- SummarizedExperiment::rowData(se)$Cluster

  ComplexHeatmap::Heatmap(mat,
                          split = clusters,
                          name = "Exp",
                          show_row_names = FALSE,
                          column_title = "Samples")
}

#' Samples plot PCA
#' @export
plot_pca <- function(se) {
  pca_res <- prcomp(t(SummarizedExperiment::assay(se)))
  df <- as.data.frame(pca_res$x)


  plot(df$PC1, df$PC2, main = "Samples PCA", pch = 19, col = "blue")
  text(df$PC1, df$PC2, labels = rownames(df), pos = 3)
}
