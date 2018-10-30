# How does search work?

## Search scores

We collect the following scores prior to building the search index:
- health
- maintenance
- popularity

### Platform specificity score

When a platform filter is specified, we both check whether the predicate
matches the platforms of the package, and also calculate how closely it
matches them (`platform_specificity.dart`).

For example, if the platform filter is `flutter`, we'll have the following scores:

- `<missing or empty platform>`: no match, doesn't show up in the results
- `['server', 'web']`: no match, doesn't show up in the results
- `['flutter']`: `1.0` (specific platform match)
- `['flutter', 'server']`: `0.9` (1 extra platform, close platform match)
- `['flutter', 'server', 'web']`: `0.8` (2+ extra platforms, distant platform match)

## Search ranking

During search, the service may use the following rankings:

- numerical ordering
- text match ranking
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
- readme (first 5000 characters)

When a text query is specified, we'll try to match the query against all of these
separately, with the lower weights on description (0.95) and readme (0.90), and
the maximum of these will be accepted as the text score.

Internal to each field, we tokenize both the original text and the query text,
and accumulate a score based on the following calculation:

- For each token, we'll have a token weight:
  - 1.0 if it is the original word
  - less than 1.0 if it is a derived world
    (e.g. `CamelCase -> {'camelcase': 1.0, 'camel': 0.57, 'case': 0.43}`)
- We remove tokens from the query where their weight is less than 0.3.
- We accumulate the individual token scores for each document
  (by multiplying their stored weight with the query weight).
- Final score is:
  - `query weight = the token weights in the query`
  - `doc.size = the size of the document`,
    calculated as `1 + math.log(1 + tokens.length) / 100`.
  - `score(doc) = (matched token weights) / (query weight * doc.size)`

The query text could contain exact phrases (text between quotation marks:
`"exact phrase""`). When present, the result list is filtered by matching
those phrases against the original text content, removing packages that doesn't
have those.

The text match score will then be either used directly (`SearchOrder.text`) or it
will be combined with other scores (see: combined ranking).

### API/dartdoc match

The `pkg/pub_dartdoc` package is an extended `dartdoc` tool that extracts additional
information about the source code:
- The public API symbols (libraries, methods, classes, fields) and their locations.
- The documentation for such symbols.

The symbols are grouped into libraries (top-level methods) and classes (and
their fields and methods). Each group has a unique URL pointing to the generated
documentation page.

There is a sub-index for such pages and their documentation content. On text
matching, the index will collect the pages independently from their packages,
and they will be aggregated: 3 pages per package, keeping the maximum score
for each package.

These results will then be merged with the results of name, description and
readme indexes.

### Combined ranking

When combining multiple scores (e.g. overall \[+ text match score]),
we multiply the values. To protect against low values (e.g. new package not having any popularity
score), we do the following linear transformation:

- `overall`: `[0.0 .. 1.0] -> [0.3 .. 1.0]`

Platform specificity is already protected against low values, there is no
transformation required for it.

For example, a result with the following scores is calculated the following way:

| Name | Value |
| --- | --- |
| Popularity | 0.86 |
| Health | 0.92 |
| Maintenance | 1.0 |
| Overall | **0.906** |

| Name | Raw Value | Transformed | 
| --- | --- | --- | 
| Text match | 0.7 | 0.7 | 
| Package's overall | 0.906 | 0.9342 | 
| Platform specificity | 0.9 | 0.9 |
| Result |  | 0.588546 | 

### SDK results

The `dartdoc` service also provides the extracted data for the SDK, and these
are grouped and stored by the top-level libraries (e.g. `dart:collection`).

On text search operations both the package and the sdk index will get queried,
and their results will be merged before displaying them to the users.

## Process for search tuning

When a weird search result is reported:

1. Create a test with multiple packages that represent the failure case.
   If needed, this should use the description and readme of the given packages.

2. Adjust the search index and/or scoring to satisfy the new test.

3. Before committing, check the changes in the other test, whether they
   could cause any regression (e.g. if they hide or re-surface another package). 
   This is not always bad, but if that happens, take extra precaution whether
   it is aligned with the expected behaviour or within quality threshold.
