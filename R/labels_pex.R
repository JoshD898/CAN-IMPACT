pex_labels<- list(
  indication = list(
    fields = paste0("indication_", 1:4),
    values = c(
      `1` = "Pulmonary exacerbation",
      `2` = "Bacterial eradication (pulmonary)",
      `3` = "Sinusitis",
      `4` = "Urinary tract infection",
      `5` = "Cellulitis",
      `6` = "GI infection",
      `0` = "Other"
    )
  ),

  route = list(
    fields = paste0("route_", 1:4),
    values = c(
      `1` = "Oral",
      `2` = "Inhaled",
      `3` = "IV"
    )
  ),

  location = list(
    fields = paste0("location_", 1:4),
    values = c(
      `1` = "Inpatient",
      `2` = "Ambulatory"
    )
  ),

  binary = list(
    fields = c(
      "decrease_fev1",
      "oxygen_saturation",
      "chest_x_ray",
      "haemoptysis",
      "increased_breathing",
      "adventitial_sounds",
      "weight_loss",
      "increased_cough",
      "exercise_tolerance",
      "congestion_sputum",
      "antibiotic_pe_met"
    ),
    values = c(
      `1` = "Yes",
      `0` = "No",
      `99` = "Not Assessed"
    )
  )
)
