organize <- function(export_path, output_dir) {
  result <- read.csv(export_path, colClasses = "character") |>
    split_data() |>
    openxlsx::write.xlsx(file = file.path(output_dir, "organized.xlsx"))
}
