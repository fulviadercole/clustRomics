#' Gene Set Enrichment Analysis (GSEA) with ID conversion
#' @param se SummarizedExperiment
#' @param cluster_id The number of the cluster to be analyzed
#' @param org_db The organism's database (default "org.Hs.eg.db" for human)
#' @import clusterProfiler
#' @import AnnotationDbi
#' @export
run_cluster_enrichment <- function(se, cluster_id, org_db = "org.Hs.eg.db") {

  # 1. Extract the cluster genes
  all_genes <- rownames(se)
  cluster_genes <- all_genes[SummarizedExperiment::rowData(se)$Cluster == cluster_id]

  # 2. ID conversion (Example: from SYMBOL to ENTREZID, more stable for GSEA)
  #Enrichment often works best with Entrez ID
  gene_conv <- AnnotationDbi::select(get(org_db),
                                     keys = cluster_genes,
                                     columns = "ENTREZID",
                                     keytype = "SYMBOL") # Change to 'ENSEMBL' if your data is Ensembl

  # 3. Perform enrichment GO
  ego <- clusterProfiler::enrichGO(gene          = gene_conv$ENTREZID,
                                   OrgDb         = org_db,
                                   ont           = "BP",
                                   pAdjustMethod = "BH",
                                   pvalueCutoff  = 0.05,
                                   readable      = TRUE)

  return(ego)
}
