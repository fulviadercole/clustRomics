
# clustRomics

<!-- badges: start -->
<!-- badges: end -->


clustRomics is an R package developed for analyzing and clustering gene expression data. The package uses standard Bioconductor classes (`SummarizedExperiment`) for interoperability and provides tools ranging from preprocessing to Gene Set Enrichment Analysis (GSEA).

## Installation

## Installation
Since this package depends on Bioconductor resources, please ensure `BiocManager` is installed first:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# To ensure all Bioconductor dependencies are caught:
BiocManager::install(c("preprocessCore", "org.Hs.eg.db", "AnnotationDbi", 
                       "clusterProfiler", "ComplexHeatmap", "SummarizedExperiment"))
```

You can install the development version from GitHub using **devtools**:

```
# install.packages("devtools")
devtools::install_github("fulviadercole/clustRomics", build_vignettes = TRUE)
```

## How to use it

``` r
library(clustRomics)
library(SummarizedExperiment)
library(org.Hs.eg.db)
```

# 1. Loading data 
## The package automatically creates a SummerizedExperiment object


# To use the example file included in the package:

``` r
example_path <- system.file("extdata", "test_genes.csv", package = "clustRomics")
se <- read_expression(example_path)
``` 

# Or load your own data:

``` r
se <- read_expression("path/to/your/data.csv")
```

# 2. Normalization: You can choose between different normalization strategies depending on your downstream analysis needs

```r
#Methods available: "log" (log-transformation) or "quantile"
se <- normalize_data(se, method = "log")
```

# 3. Genes cluster: group genes with similar expression profiles using various algorithms:

```r
#Methods available: "kmeans", "hclust" (hierarchical)
se <- cluster_genes(se, method = "kmeans", k = 5)
```

# 4. Analysis and visualization
## Detecting Outlier: Identify and remove genes with anomalous distributions:

```r
se <- detect_outliers(se, threshold = 2)
```

# Heatmap
## View gene clusters across different conditions:

```r
plot_expression_heatmap(se)
```

# PCA Plot 
## Explore the distribution of samples in principal component space:

```r
plot_pca(se)
```

# Biological Enrichment (GSEA) 
## Identify biological pathways (GOs) enriched in a specific cluster:

```r
enrich_res <- run_cluster_enrichment(se, cluster_id = 1)
```

# Vignette
## for detailed usage and example see the vignette:

```r
browseVignettes("clustRomics")
```

# License:
## GPL-3 

# Contact:
## Fulvia D'Ercole - fulvia.dercole@studenti.unimi.it


