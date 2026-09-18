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
