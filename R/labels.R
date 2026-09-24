baseline_char_labels <- list(
  pancreatic_status = list(
    fields = "pancreatic_status",
    values = c(
      `1` = "Sufficient",
      `2` = "Insufficient"
    )
  ),
  cf_diabetes = list(
    fields = "cf_diabetes",
    values = c(
      `1` = "Yes",
      `0` = "No"
    )
  ),
  cf_liver_disease = list(
    fields = "cf_liver_disease",
    values = c(
      `1` = "Yes",
      `0` = "No"
    )
  )
)

demographics_labels <- list(
  sex = list(
    fields = "sex",
    values = c(
      `1` = "Male",
      `2` = "Female",
      `0` = "Other"
    )
  ),
  ethnicity = list(
    fields = "ethnicity",
    values = c(
      `1` = "Caucasian",
      `2` = "First Nations",
      `3` = "Black",
      `4` = "Asian",
      `5` = "South Asian",
      `0` = "Other"
    )
  ),
  enrol_type = list(
    fields = "enrol_type",
    values = c(
      `1` = "Pre-therapy participant",
      `2` = "Late entry participant",
      `3` = "No modulator control"
    )
  ),
  site = list(
    fields = "redcap_data_access_group",
    values = c(
      "stpauls_hospital" = "St. Paul’s Hospital",
      "bc_childrens_hospi" = "BC Children’s Hospital",
      "the_hospital_for_s" = "SickKids",
      "stmicheals_hospita" = "St. Michael’s Hospital",
      "mcgill_universityb" = "MUHC",
      "mcgill_university" = "MUHC",
      "foothills_hospital" = "Foothills Hospital",
      "institut_universit" = "IUCPQ",
      "jim_pattison_child" = "Jim Pattison Children’s Hospital",
      "hoteldieu_de_montr" = "Hôtel-Dieu de Montréal",
      "qe_ii_health_scien" = "QEII Health Sciences Centre",
      "stollery_childrens" = "Stollery Children’s Hospital",
      "university_of_albe" = "University of Alberta Hospital"
    )
  )
)

medications_labels <- list(
  indication = list(
    fields = "indication",
    values = c(
      `1` = "Pulmonary",
      `2` = "Gastrointestinal/Nutrition",
      `3` = "ENT",
      `4` = "Endocrine",
      `5` = "Hepatic",
      `0` = "Other"
    )
  ),
  route = list(
    fields = "route",
    values = c(
      `1` = "Oral",
      `2` = "IV",
      `3` = "Inhaled",
      `4` = "Subcutaneous",
      `5` = "Intraocular",
      `6` = "Intranasal",
      `7` = "Intramuscular",
      `8` = "Rectal"
    )
  )
)

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

pregnancy_labels <- list(
  preg_result = list(
    fields = "preg_result",
    values = c(
      `1` = "spontaneous abortion",
      `2` = "therapeutic abortion",
      `3` = "live birth"
    )
  )
)

side_effects_labels <- list(
  se = list(
    fields = "se",
    values = c(
      `1` = "Rash (please specify)",
      `2` = "Headache",
      `3` = "Testicular pain",
      `4` = "MSK pain",
      `5` = "Nausea/vomiting",
      `6` = "Diarrhea",
      `7` = "Constipation",
      `8` = "DIOS/Bowel obstruction",
      `9` = "Abdominal pain",
      `10` = "Hypertension",
      `11` = "Hemoptysis",
      `12` = "Cognition concerns (brain fog)",
      `13` = "Sleep disturbance",
      `14` = "Liver enzyme derangement (ALT/AST >3x ULN)",
      `15` = "Liver enzyme derangement (ALT/AST >5x ULN)",
      `16` = "Psychiatric concerns (please specify)",
      `0` = "Other"
    )
  ),
  se_status = list(
    fields = "se_status",
    values = c(
      `1` = "Ongoing",
      `2` = "Resolved"
    )
  ),
  se_modulator = list(
    fields = "se_modulator",
    values = c(
      `1` = "ivacaftor",
      `2` = "lumacaftor/ivacaftor",
      `3` = "tezacaftor/ivacaftor",
      `4` = "elexacaftor/tezacaftor/ivacaftor"
    )
  ),
  dose_change = list(
    fields = unlist(
      lapply(
        1:5,
        function(i) paste0("se_", c("iva", "lum", "tez", "elx"), "_change_", i)
      )
    ),
    values = c(
      `1` = "Dose decreased",
      `2` = "Dose increased",
      `3` = "Medication held",
      `4` = "Medication restarted"
    )
  ),
  frequency = list(
    fields = unlist(
      lapply(
        1:5,
        function(i) paste0("se_", c("iva", "lum", "tez", "elx"), "_freq_", i)
      )
    ),
    values = c(
      `1` = "once daily",
      `2` = "twice daily",
      `0` = "other"
    )
  )
)

visit_labels <- list(
  visit_number = list(
    fields = "visit_number",
    values = c(
      `1` = "1 Month Visit",
      `2` = "3 Month Visit",
      `3` = "6 Month Visit",
      `4` = "Year 1 Visit",
      `5` = "Year 2 Visit",
      `6` = "Year 3 Visit",
      `7` = "Year 4 Visit",
      `8` = "Year 5 Visit",
      `9` = "Drug Termination",
      `10` = "Extra Visit"
    )
  )
)
