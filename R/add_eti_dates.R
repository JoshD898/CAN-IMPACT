add_eti_dates <- function(split_data) {
  split_data |>
    add_eti_start_date() |>
    add_time_from_eti()
}



add_eti_start_date <- function(split_data) {
  demographics <- split_data[["demographics"]]
  baseline_char <- split_data[["baseline_characteristics"]]
  visits <- split_data[["visits"]]

  baseline_eti <- baseline_char |>
    dplyr::filter(
      baseline_modulator_name == 4,
      !is.na(start_date_of_current_modu)
    ) |>
    dplyr::transmute(
      record_id,
      eti_start_date_baseline = start_date_of_current_modu
    )

  change_eti <- visits |>
    dplyr::mutate(
      modulator_change_date = dplyr::na_if(modulator_change_date, "")
    ) |>
    dplyr::filter(
      modulator_name == 4,
      !is.na(modulator_change_date)
    ) |>
    dplyr::group_by(record_id) |>
    dplyr::summarise(
      eti_start_date_change = min(modulator_change_date),
      .groups = "drop"
    )

  demographics <- demographics |>
    dplyr::left_join(baseline_eti, by = "record_id") |>
    dplyr::left_join(change_eti, by = "record_id") |>
    dplyr::mutate(
      eti_start_date = dplyr::coalesce(
        eti_start_date_baseline,
        eti_start_date_change
      )
    ) |>
    dplyr::select(
      -eti_start_date_baseline,
      -eti_start_date_change
    )

  split_data[["demographics"]] <- demographics

  split_data
}

# Add `time_from_eti_to_spirometry` column to the visit tab
add_time_from_eti <- function(split_data) {
  visits <- split_data[["visits"]]
  demographics <- split_data[["demographics"]] |>
    dplyr::select(c("record_id", "eti_start_date"))

  visits <- visits |>
    dplyr::left_join(demographics, by = "record_id") |>
    dplyr::mutate(
      months_from_eti_to_spirometry = lubridate::time_length(
        lubridate::interval(
          lubridate::ymd(eti_start_date),
          lubridate::ymd(date_of_spirometry)
        ),
        unit = "months"
      )
    ) |>
    dplyr::select(-eti_start_date)

  split_data[["visits"]] <- visits

  split_data
}
