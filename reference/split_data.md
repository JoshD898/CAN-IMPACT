# Split REDCap export into organized data frames

Splits a raw REDCap export into a named list of data frames, one per
domain (demographics, baseline characteristics, visits, pulmonary
exacerbations, medications, side effects, and pregnancy).

## Usage

``` r
split_data(export)
```

## Arguments

- export:

  A data frame containing the raw REDCap export.

## Value

A named list of data frames: \`demographics\`,
\`baseline_characteristsics\`, \`visits\`, \`pex\`, \`medications\`,
\`side_effects\`, and \`pregnancy\`.
