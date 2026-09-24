# Add spirometry percent predicted values

Adds percent predicted values using the race-neutral GLI global (2022)
equations, as implemented by \[rspiro::pctpred_GLIgl()\]:
\`fev1_pctpred\` and \`fvc_pctpred\` on \`visits\`, and
\`best_fev1_pctpred\` on \`baseline_characteristics\`. Requires the age
columns from \`add_ages()\`.

## Usage

``` r
add_spirometry(split_data)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

## Value

\`split_data\` with the percent predicted columns added.

## References

<https://cran.r-project.org/web/packages/rspiro/refman/rspiro.html>
