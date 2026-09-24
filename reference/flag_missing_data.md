# Flag missing data

Logs blank, 0, or NA values in the required fields listed in
\`qc_completion_fields\`. Data are not changed.

## Usage

``` r
flag_missing_data(split_data, logger)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

- logger:

  A \`qc_logger\` object.

## Value

\`split_data\`, unchanged.
