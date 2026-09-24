#' Create a QC logger
#'
#' @return A list with `add()` to record a QC entry and `save_log()` to
#'   save the log to file.
qc_logger <- function() {
  entries <- list()

  #' @param tab Table name.
  #' @param record_id Record ID.
  #' @param redcap_repeat_instance Repeat instance number.
  #' @param description Description of the QC issue.
  #' @param action Action taken.
  add <- function(tab, record_id, redcap_repeat_instance, visit_number, description, action) {
    entries[[length(entries) + 1]] <<- data.frame(
      tab = tab,
      record_id = record_id,
      redcap_repeat_instance = redcap_repeat_instance,
      visit_number = visit_number,
      description = description,
      action = action
    )
  }

  #' @param output_dir Directory to save the QC log to
  save_log <- function(output_dir) {
    log <- dplyr::bind_rows(entries)
    write.csv(log, file.path(output_dir, "qc_log.csv"), row.names = FALSE)
  }

  list(add = add, save_log = save_log)
}
