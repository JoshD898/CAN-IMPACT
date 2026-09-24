# CAN-IMPACT Data Preprocessing

This R package organizes raw CAN-IMPACT REDCap exports into analysis-ready data tables and performs basic data quality control.

The package:

- Splits the raw REDCap export into separate data tables.
- Calculates participant ages and parses ETI start dates.
- Converts raw spirometry measurements to percent predicted.
- Performs data quality checks for missing or implausible values.
- Produces a QC log describing values that were flagged or modified.

## Installation

The package can be installed and updated directly from GitHub using `remotes`:

```r
install.packages("remotes")
remotes::install_github("joshd898/CANIMPACT")
```

## Example Usage

Once installed, the main function is `organize`:

```r
CANIMPACT::organize(
  export_path = "path/to/redcap_export.csv",
  output_dir = "path/to/output_directory"
)
```
This will create:

- `organized.xlsx` — the processed data, with each data table in a separate worksheet.
- `qc_log.csv` — a log of data quality issues identified during preprocessing.

The processed data are also returned as a named list:

```r
data <- CANIMPACT::organize(
  export_path = "path/to/redcap_export.csv",
  output_dir = "path/to/output"
)

data$demographics
data$visits
data$pex
```

## Contact Information

If you have any questions, comments or suggestions please reach out to me at josh.dyce@hli.ubc.ca.
