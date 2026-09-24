#' USe the REDCap API to load a raw export
#'
#' @param token API token to use
#'
#' @return A data frame of the raw export data
#'
#' @export
from_api <- function(token) {
  httr2::request("https://rc.bcchr.ca/redcap/api/") |>
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
}
