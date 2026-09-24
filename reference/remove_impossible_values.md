# Remove impossible values

Sets numeric values outside a valid range to NA and logs each change.
Ranges are defined in the \`rules\` table inside the function.

## Usage

``` r
remove_impossible_values(split_data, logger)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

- logger:

  A \`qc_logger\` object.

## Value

\`split_data\` with out-of-range values set to NA.
