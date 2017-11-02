# How does search work?

## Search scores

We collect the following scores prior to building the search index:
- health
- maintenance
- popularity

### Health score

The health score should reflect the general code health of the package,
and it is calculated for each package version separately.

The health score is calculated from the `pana` analysis results, via
`AnalysisView.health`. The score is normalized to the `[0.0 .. 1.0]`
range using the package's `fitness` values from `pana`, which includes
the *magnitude* of the package (approximates code size and complexity),
and its *shortcomings* (a combination of single-line issues and errors
which are measured in proportion to the *magnitude*). 

### Maintenance score

The maintenance score should reflect the effort and attention the authors
put into the package, and it is calculated for the package using mostly the
latest version. 

The maintenance score is calculated in `SearchBackend._calculateMaintenance`.
The score is `1.0`, with the following penalties decreasing it (by multiplication):

- If the latest version is older than two years, this score is `0.0`.
- If the latest version is between one and two years old, the score is linear interpolation of the age (over the one year mark, decreasing to zero as it reaches two years old).
- If there is no changelog or it is only a few words, the score gets large penalty (- 20%).
- If there is no readme or it is only a few words, the score gets a medium penalty (- 5%).
- If the latest version starts with `0.0.` or `0.`, the score gets a medium or small penalty (- 5%, -1%).

### Popularity score

The popularity score should reflect the package's use, and it is calculated
using the download log entries for the past 30 days from the storage backend.

The popularity score is calculated in several steps:

- The raw data is processed and exported to a bucket (`dartlang-pub--popularity`).
- The individual package-level entries are summed with a weighting defined by `VoteData._score`.
- These values are normalized to `[0.0 .. 1.0]` using Bezier-interpolation in
  `PopularityStorage._updateLatest`. This step needs to know all of the scores
  in one place to do that calculation.

## Search ranking

During search, the service may use the following rankings:

- numerical ordering
- text match ranking
- platform-specific ranking
- combined ranking

### Numerical ordering

Numerical ordering is used on search request that does not specify text query, but
would like to order the results by `updated`, or `created` time, and also by
`popularity`, `health`, or `maintenance`. 

These work on the raw values, without any weights or transformation.

### Text match ranking

The indexing process prepares the package documents and parses the following fields:

- package name
- package description (first 500 characters)
- readme (first 1000 characters)

When a text query is specified, we'll try to match the query against all of these
separately, and select the best score. (TODO: document the scoring)

The text match score will then be either used directly (`SearchOrder.text`) or it
will be combined with other scores (see: combined ranking).

### Platform-specific ranking

TBD.

### Combined ranking

When combining multiple scores (e.g. popularity + health + maintenance \[+ text match score]),
we multiply the values. To protect against low values (e.g. new package not having any popularity
score), we do the following linear transformations:

- `popularity`: `[0.0 .. 1.0] -> [0.5 .. 1.0]`
- `health`: `[0.0 .. 1.0] -> [0.75 .. 1.0]`
- `maintenance`: `[0.0 .. 1.0] -> [0.9 .. 1.0]`

For example, a result with the following scores is calculated the following way:

| Name | Raw Value | Transformed | 
| --- | --- | --- | 
| Text match | 0.7 | 0.7 | 
| Popularity | 0.86 | 0.93 | 
| Health | 0.92 | 0.98 | 
| Maintenance | 1.0 | 1.0 | 
| Overall |  | 0.63798 | 
