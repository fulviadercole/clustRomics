#' Read Gene Expression Data
#'
#' @param path Path to the csv file.
#' @return A SummarizedExperiment object.
#' @importFrom SummarizedExperiment SummarizedExperiment
#' @importFrom utils read.csv
#' @export
read_expression <- function(path) {
  # 1. Reading CSV file
  # row.names = 1 indicates that the first column (the genes) should be used for the row names
  # check.names = FALSE prevents R from transforming "S1" into "X1" or similar
  df <- utils::read.csv(path, row.names = 1, check.names = FALSE)

  # 2. Transform the dataframe into a numeric matrix

  expression_matrix <- as.matrix(df)

  # 3. Creating SummarizedExperiment object
  se <- SummarizedExperiment::SummarizedExperiment(
    assays = list(counts = expression_matrix)
  )

  return(se)
}
