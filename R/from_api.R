#' USe the REDCap API to load a raw export
#'
#' @param token API token to use
#' @param save_path Path to save the export to (must end in .csv). Default is `NULL`.
#'
#' @return A data frame of the raw export data
#'
#' @export
from_api <- function(token, save_path = NULL) {
  df <- httr2::request("https://rc.bcchr.ca/redcap/api/") |>
    httr2::req_body_form(
      token = token,
      content = "report",
      format = "csv",
      report_id = "29387",
      csvDelimiter = "",
      rawOrLabel = "raw",
      rawOrLabelHeaders = "raw",
      exportCheckboxLabel = "false",
      returnFormat = "json"
    ) |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    textConnection() |>
    read.csv(colClasses = "character")

  if (!is.null(save_path)) {
    write.csv(df, save_path, row.names = FALSE)
  }

  df
}
