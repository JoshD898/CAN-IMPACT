#' Organize and quality-control REDCap export data
#'
#' The pipeline:
#' \itemize{
#'   \item Splits the raw export into separate data tabs.
#'   \item Converts raw spirometry measurements to percent predicted.
#'   \item Parses the ETI start date and calculates the time from ETI start
#'     to each visit, rather than relying solely on visit labels.
#'   \item Performs data quality checks for missing or impossible values,
#'     with detailed logging of everything flagged.
#' }
#'
#' @param export_path Character string giving the path to the REDCap CSV export.
#' @param output_dir Character string giving the directory where the organized
#'   Excel workbook and QC log should be saved. Defaults to the current
#'   directory. Set to `NULL` to skip writing output files.
#'
#' @return A named list of organized data frames.
#'
#' @export
organize <- function(export_path, output_dir = ".") {
  logger <- qc_logger()

  result <- read.csv(export_path, colClasses = "character") |>
    split_data() |>
    add_ages() |>
    add_eti_dates() |>
    run_data_qc(logger) |>
    add_spirometry() |>
    run_spirometry_qc(logger)

  if (!is.null(output_dir)) {
    openxlsx::write.xlsx(result, file = file.path(output_dir, "organized.xlsx"))
    logger$save_log(output_dir)
  }

  result
}
