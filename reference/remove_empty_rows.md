# Remove empty rows

Drops rows in every tab where all fields other than the identifiers are
blank, 0, or NA. Dropped rows are logged.

## Usage

``` r
remove_empty_rows(split_data, logger)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

- logger:

  A \`qc_logger\` object.

## Value

\`split_data\` with empty rows removed.
