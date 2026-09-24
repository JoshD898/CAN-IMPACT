run_data_qc <- function(split_data, logger) {
  split_data |>
    remove_empty_rows(logger) |>
    remove_impossible_values(logger) |>
    flag_missing_data(logger)
}

#' This must be run AFTER spirometry fields have been added
run_spirometry_qc <- function(split_data, logger) {
  fields <- list(
    visits = c("fev1_pctpred", "fvc_pctpred"),
    baseline_characteristics = "best_fev1_pctpred"
  )

  for (tab in names(fields)) {
    df <- split_data[[tab]]
    repeat_instances <- get_repeat_instances(df)
    visit_numbers <- get_visit_numbers(df)

    for (fld in fields[[tab]]) {
      value <- suppressWarnings(as.numeric(df[[fld]]))
      high  <- !is.na(value) & value >= 150

      if (!any(high)) next

      logger$add(
        tab = tab,
        record_id = df$record_id[high],
        redcap_repeat_instance = repeat_instances[high],
        visit_number = visit_numbers[high],
        description = paste0(fld, " >= 150: ", value[high]),
        action = "No change"
      )
    }
  }

  split_data
}


remove_empty_rows <- function(split_data, logger) {
  is_empty <- function(row) all(row == "" | row == "0" | is.na(row))

  for (tab in names(split_data)) {
    df <- split_data[[tab]]
    check_cols <- setdiff(names(df), c("record_id", "redcap_repeat_instance", "visit_number"))
    repeat_instances <- get_repeat_instances(df)
    visit_numbers <- get_visit_numbers(df)

    empty_rows <- apply(df[check_cols], 1, is_empty)

    if (any(empty_rows)) {
      logger$add(
        tab = tab,
        record_id = df$record_id[empty_rows],
        redcap_repeat_instance = repeat_instances[empty_rows],
        visit_number = visit_numbers[empty_rows],
        description = "Row contained only blanks and/or 0s",
        action = "Dropped row"
      )
    }

    split_data[[tab]] <- dplyr::filter(df, !empty_rows)
  }

  split_data
}




flag_missing_data <- function(split_data, logger) {
  for (tab in names(qc_completion_fields)) {
    df <- split_data[[tab]]
    repeat_instances <- get_repeat_instances(df)
    visit_numbers <- get_visit_numbers(df)

    for (fld in qc_completion_fields[[tab]]) {
      missing_rows <- is.na(df[[fld]]) | df[[fld]] %in% c("", "0")

      if (!any(missing_rows)) next

      logger$add(
        tab = tab,
        record_id = df$record_id[missing_rows],
        redcap_repeat_instance = repeat_instances[missing_rows],
        visit_number = visit_numbers[missing_rows],
        description = paste0("Missing '", fld, "' field"),
        action = "No change"
      )
    }
  }

  split_data
}

remove_impossible_values <- function(split_data, logger) {
  rules <- tibble::tribble(
    ~tab_name,                  ~field,              ~min, ~max,
    "visits",                   "age_at_spirometry",    0,  120,
    "baseline_characteristics", "age_at_best_fev1",     0,  120,
    "baseline_characteristics", "best_fev1_height",    30,  250,
    "visits",                   "spirometry_height",   30,  250,
    "visits",                   "fev1_l",               0,   15,
    "visits",                   "fvc_l",                0,   15,
    "baseline_characteristics", "best_fev1_l",          0,   15
  )

  for (i in seq_len(nrow(rules))) {
    tab <- rules$tab_name[i]
    fld <- rules$field[i]
    lo <- rules$min[i]
    hi <- rules$max[i]

    df <- split_data[[tab]]
    value <- suppressWarnings(as.numeric(df[[fld]]))
    bad <- !is.na(value) & (value < lo | value > hi)

    if (!any(bad)) next

    logger$add(
      tab = tab,
      record_id = df$record_id[bad],
      redcap_repeat_instance = get_repeat_instances(df)[bad],
      visit_number = get_visit_numbers(df)[bad],
      description = paste0(
        fld, " was outside the valid range [", lo, ", ", hi, "]: ", value[bad]
      ),
      action = "Set to NA"
    )

    df[[fld]][bad] <- NA
    split_data[[tab]] <- df
  }

  split_data
}














































get_repeat_instances <- function(df) {
  if ("redcap_repeat_instance" %in% names(df)) {
    df$redcap_repeat_instance
  } else {
    rep(NA, nrow(df))
  }
}

get_visit_numbers <- function(df) {
  if ("visit_number" %in% names(df)) {
    df$visit_number
  } else {
    rep(NA, nrow(df))
  }
}
