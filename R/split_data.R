#' Split REDCap export into organized data frames
#'
#' Splits a raw REDCap export into a named list of data frames, one per
#' domain (demographics, baseline characteristics, visits, pulmonary
#' exacerbations, medications, side effects, and pregnancy).
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A named list of data frames: `demographics`,
#'   `baseline_characteristsics`, `visits`, `pex`, `medications`,
#'   `side_effects`, and `pregnancy`.
#'
#' @export
split_data <- function(export) {
  list(
    demographics = get_demographics(export),
    baseline_characteristics = get_baseline_char(export),
    visits = get_visits(export),
    pex = get_pex(export),
    medications = get_medications(export),
    side_effects = get_side_effects(export),
    pregnancy = get_pregnancy(export)
  )
}

#' Recode coded values in a data frame
#'
#' @param df A data frame containing the fields to recode.
#' @param labels A named list, where each element has a `fields` component
#'   (a character vector of column names) and a `values` component (a named
#'   character vector mapping codes to labels).
#'
#' @return The input data frame with the specified fields recoded.
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

#' Extract demographics data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of demographics data.
get_demographics <- function(export) {
  export |>
    dplyr::filter(redcap_event_name == "visit_1_baseline_arm_1") |>
    dplyr::select(dplyr::all_of(demographics_fields)) |>
    recode_columns(demographics_labels)
}

#' Extract baseline characteristics data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of baseline characteristics data (everything not included in follow up visits)
get_baseline_char <- function(export) {
  export |>
    dplyr::filter(redcap_event_name == "visit_1_baseline_arm_1") |>
    dplyr::select(dplyr::all_of(c(
      "record_id",
      "baseline_modulator",
      "start_date_of_current_modu",
      "baseline_modulator_name",
      setdiff(
        c(base_clin_rev_fields, base_clin_test_fields),
        c(names(clin_test_mapping), names(clin_rev_mapping))
      )
    ))) |>
    recode_columns(baseline_char_labels)
}

#' Extract visit data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of visit data.
#'
#' @seealso [stack_visits()]
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

#' Extract pulmonary exacerbation data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of pulmonary exacerbation data.
get_pex <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "pulmonary_exacerbation_form") |>
    dplyr::select(dplyr::all_of(pex_fields)) |>
    recode_columns(pex_labels)
}

#' Extract medication data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of medication data.
get_medications <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "concomitant_medications_and_therapies") |>
    dplyr::select(dplyr::all_of(medications_fields)) |>
    recode_columns(medications_labels)
}

#' Extract side effect data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of side effect data.
get_side_effects <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "sideeffect_form") |>
    dplyr::select(dplyr::all_of(side_effects_fields)) |>
    recode_columns(side_effects_labels)
}

#' Extract pregnancy data
#'
#' @param export A data frame containing the raw REDCap export.
#'
#' @return A data frame of pregnancy data.
get_pregnancy <- function(export) {
  export |>
    dplyr::filter(redcap_repeat_instrument == "pregnancy_form") |>
    dplyr::select(dplyr::all_of(pregnancy_fields)) |>
    recode_columns(pregnancy_labels)
}


