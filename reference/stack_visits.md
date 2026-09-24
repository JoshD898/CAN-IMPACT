# Stack baseline and follow-up visit data into a single data frame

Combines baseline visit records with subsequent follow-up visit records
into a single "stacked" data frame with one row per visit. Because
baseline and follow-up visits use different field names for equivalent
clinical review and clinical test values (\`clin_rev_fields\` /
\`clin_test_fields\` at baseline vs. their follow-up equivalents), this
function renames the baseline fields to match the follow-up field names
before combining, so that each clinical variable ends up in a single,
consistently named column across all visits.

## Usage

``` r
stack_visits(export)
```

## Arguments

- export:

  A data frame containing the raw REDCap export.

## Value

A data frame combining baseline and follow-up visits into a single set
of rows, with clinical review and clinical test fields unified under
common column names
