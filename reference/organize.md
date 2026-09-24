# Organize and quality-control REDCap export data

The pipeline:

- Splits the raw export into separate data tabs.

- Converts raw spirometry measurements to percent predicted.

- Parses the ETI start date and calculates the time from ETI start to
  each visit, rather than relying solely on visit labels.

- Performs data quality checks for missing or impossible values, with
  detailed logging of everything flagged.

## Usage

``` r
organize(export_path, output_dir = ".")
```

## Arguments

- export_path:

  Character string giving the path to the REDCap CSV export.

- output_dir:

  Character string giving the directory where the organized Excel
  workbook and QC log should be saved. Defaults to the current
  directory. Set to \`NULL\` to skip writing output files.

## Value

A named list of organized data frames.
