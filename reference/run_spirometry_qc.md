# Flag high spirometry percent predicted values

Logs any percent predicted value \>= 150. Data are not changed. This
must be run AFTER spirometry fields have been added.

## Usage

``` r
run_spirometry_qc(split_data, logger)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

- logger:

  A \`qc_logger\` object.

## Value

\`split_data\`, unchanged.
