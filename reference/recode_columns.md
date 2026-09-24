# Recode coded values in a data frame

Recode coded values in a data frame

## Usage

``` r
recode_columns(df, labels)
```

## Arguments

- df:

  A data frame containing the fields to recode.

- labels:

  A named list, where each element has a \`fields\` component (a
  character vector of column names) and a \`values\` component (a named
  character vector mapping codes to labels).

## Value

The input data frame with the specified fields recoded.
