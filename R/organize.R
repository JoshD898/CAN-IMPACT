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
