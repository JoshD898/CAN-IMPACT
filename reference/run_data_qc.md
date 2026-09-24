# Run data QC checks

Removes empty rows, sets impossible values to NA, and flags missing
data. All changes and flags are recorded in the logger.

## Usage

``` r
run_data_qc(split_data, logger)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

- logger:

  A \`qc_logger\` object.

## Value

\`split_data\` with the QC changes applied.
