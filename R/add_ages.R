add_ages <- function(split_data) {
  split_data |>
    add_age_at_best_fev1() |>
    add_age_at_spirometry()
}

add_age_at_best_fev1 <- function(split_data) {
  baseline_char <- split_data[["baseline_characteristics"]]
  demographics <- split_data[["demographics"]] |>
    dplyr::select(c("record_id", "partial_dob"))

  baseline_char <- baseline_char |>
    dplyr::left_join(demographics, by = "record_id") |>
    dplyr::mutate(
      age_at_best_fev1 = lubridate::time_length(
        lubridate::interval(
          lubridate::ymd(partial_dob),
          lubridate::ymd(best_fev1_date)
        ),
        unit = "years"
      )
    ) |>
    dplyr::select(-partial_dob)

  split_data[["baseline_characteristics"]] <- baseline_char

  split_data
}


add_age_at_spirometry <- function(split_data) {
  visits <- split_data[["visits"]]
  demographics <- split_data[["demographics"]] |>
    dplyr::select(c("record_id", "partial_dob"))

  visits <- visits |>
    dplyr::left_join(demographics, by = "record_id") |>
    dplyr::mutate(
      age_at_spirometry = lubridate::time_length(
        lubridate::interval(
          lubridate::ymd(partial_dob),
          lubridate::ymd(date_of_spirometry)
        ),
        unit = "years"
      )
    ) |>
    dplyr::select(-partial_dob)

  split_data[["visits"]] <- visits

  split_data
}
