add_spirometry <- function(split_data) {
  split_data |>
    add_visit_spirometry() |>
    add_baseline_best_fev1()
}


add_visit_spirometry <- function(split_data) {
  demographics <- split_data[["demographics"]] |>
    dplyr::select(c("record_id", "sex"))

  visits <- split_data[["visits"]] |>
    dplyr::left_join(demographics, by = "record_id")


  complete <- !is.na(visits$age_at_spirometry) &
    !is.na(visits$spirometry_height) &
    !is.na(visits$sex)

  visits$fev1_pctpred <- NA_real_
  visits$fvc_pctpred <- NA_real_

  pctpred <- rspiro::pctpred_GLIgl(
    age = as.numeric(visits$age_at_spirometry[complete]),
    height = as.numeric(visits$spirometry_height[complete]) / 100,
    gender = factor(visits$sex[complete], levels = c("Male", "Female")),
    FEV1 = as.numeric(visits$fev1_l[complete]),
    FVC = as.numeric(visits$fvc_l[complete]),
    FEV1FVC = NULL
  )

  visits$fev1_pctpred[complete] <- pctpred$pctpred.FEV1
  visits$fvc_pctpred[complete] <- pctpred$pctpred.FVC

  visits <- dplyr::select(visits, -sex)

  split_data[["visits"]] <- visits

  split_data
}



add_baseline_best_fev1 <- function(split_data) {
  demographics <- split_data[["demographics"]] |>
    dplyr::select(c("record_id", "sex"))

  baseline_char <- split_data[["baseline_characteristics"]] |>
    dplyr::left_join(demographics, by = "record_id")


  complete <- !is.na(baseline_char$age_at_best_fev1) &
    !is.na(baseline_char$best_fev1_height) &
    !is.na(baseline_char$sex)

  baseline_char$best_fev1_pctpred <- NA_real_

  baseline_char$best_fev1_pctpred[complete] <- rspiro::pctpred_GLIgl(
    age = as.numeric(baseline_char$age_at_best_fev1[complete]),
    height = as.numeric(baseline_char$best_fev1_height[complete]) / 100,
    gender = factor(baseline_char$sex[complete], levels = c("Male", "Female")),
    FEV1 = as.numeric(baseline_char$best_fev1_l[complete]),
    FVC = NULL,
    FEV1FVC = NULL
  )

  baseline_char <- dplyr::select(baseline_char, -sex)

  split_data[["baseline_characteristics"]] <- baseline_char

  split_data
 }
