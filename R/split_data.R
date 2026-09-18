split_data <- function(export) {
  list(
    demographics = get_demographics(export),
    baseline_characteristsics = get_baseline_char(export),
    visits = get_visits(export),
    pex = get_pex(export),
    medications = get_medications(export),
    side_effects = get_side_effects(export),
    pregnancy = get_pregnancy(export)
  )
}

recode_columns <- function(df, labels) {
  for (label in labels) {
    fields <- label$fields
    values <- label$values

    for (field in fields) {
      df[[field]] <- dplyr::recode(
        df[[field]],
        !!!values
      )
    }
  }
  df
}

get_demographics <- function(export) {
  export |>
    dplyr::filter(redcap_event_name == "visit_1_baseline_arm_1") |>
    dplyr::select(dplyr::all_of(demographics_fields)) |>
    recode_columns(demographics_labels)
}

get_baseline_char <- function(export) {
  export |>
    dplyr::filter(redcap_event_name == "visit_1_baseline_arm_1") |>
    dplyr::select(dplyr::all_of(baseline_char_fields)) |>
    recode_columns(baseline_char_labels)
}

get_visits <- function(export) {
  export |>
    stack_visits() |>
    dplyr::select(dplyr::all_of(c(
      "record_id",
      clin_rev_fields,
      clin_test_fields,
      study_inv_fields
    ))) |>
    recode_columns(visit_labels)
}

get_pex <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "pulmonary_exacerbation_form") |>
    dplyr::select(dplyr::all_of(pex_fields)) |>
    recode_columns(pex_labels)
}

get_medications <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "concomitant_medications_and_therapies") |>
    dplyr::select(dplyr::all_of(medications_fields)) |>
    recode_columns(medications_labels)
}

get_side_effects <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "sideeffect_form") |>
    dplyr::select(dplyr::all_of(side_effects_fields)) |>
    recode_columns(side_effects_labels)
}

get_pregnancy <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "pregnancy_form") |>
    dplyr::select(dplyr::all_of(pregnancy_fields)) |>
    recode_columns(pregnancy_labels)
}


