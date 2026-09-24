# Add ETI start date and time from ETI to spirometry

Adds \`eti_start_date\` to \`demographics\` and
\`months_from_eti_to_spirometry\` to \`visits\`.

## Usage

``` r
add_eti_dates(split_data)
```

## Arguments

- split_data:

  A named list of data frames, one per REDCap tab.

## Value

\`split_data\` with the new columns added.

## How \`eti_start_date\` is determined

Each record gets one ETI start date:

1\. If the baseline characteristics list ETI as the current modulator
with a start date, that date is used. 2. Otherwise, the earliest
modulator change date on a visit where the modulator is ETI is used.

The baseline date always takes priority. Records with neither get
\`NA\`.
