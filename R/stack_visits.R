stack_visits <- function(visits) {
  # Rename these because dplyr::rename needs them in opposite order
  clin_rev_mapping_rename <- setNames(names(clin_rev_mapping), clin_rev_mapping)
  clin_test_mapping_rename <- setNames(names(clin_test_mapping), clin_test_mapping)

  base_df <- visits |>
    dplyr::filter(redcap_event_name == "visit_1_baseline_arm_1") |>
    dplyr::select(-clin_test_fields, -clin_rev_fields) |>
    dplyr::rename(!!!clin_rev_mapping_rename, !!!clin_test_mapping_rename) |>
    dplyr::mutate(visit_number = "Baseline")

  fu_df <- visits |>
    dplyr::filter(redcap_event_name == "subsequent_visits_arm_1")

  dplyr::bind_rows(base_df, fu_df)
}

