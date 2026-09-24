#' Create a QC logger
#'
#' @return A list with `add()` to record a QC entry and `save_log()` to
#'   save the log to file.
qc_logger <- function() {
  entries <- list()

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

  save_log <- function(output_dir) {
    log <- dplyr::bind_rows(entries)
    write.csv(log, file.path(output_dir, "qc_log.csv"), row.names = FALSE)
  }

  list(add = add, save_log = save_log)
}
