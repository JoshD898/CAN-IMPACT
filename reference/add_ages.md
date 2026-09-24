# Add age columns

Adds \`age_at_best_fev1\` to \`baseline_characteristics\` and
\`age_at_spirometry\` to \`visits\`, in years since \`partial_dob\`.

## Usage

``` r
add_ages(split_data)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

## Value

\`split_data\` with the age columns added.
