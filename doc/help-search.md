# Search

## Query expressions

`pub.dev` supports the following search query expressions:

  - `"exact phrase"`: By default, when you perform a search, the results include
    packages with similar phrases. When a phrase is inside quotes, you'll see
    only those packages that contain exactly the specified phrase.

  - `package:prefix`: Searches for packages that begin with `prefix`. Use this
    feature to find packages in the same framework.

  - `dependency:package_name`: Searches for packages that reference
    `package_name` in their `pubspec.yaml`.

  - `dependency*:package_name`: Searches for packages that depend on
    `package_name` (as direct, dev, or transitive dependencies).

## Filters

The search UI also supports filters:

  - On the left of the search bar, select 'Dart' or 'Flutter' depending on the
    SDK you are developing with.

  - When an SDK filter is selected, on the right of the search bar, click the
    platform filter buttons to filter results to packages supporting the platforms
    you need support for.

## Ranking

Package listings (with or without text search, filters or scopes) build on
a ranking score computed from multiple scores. If applicable, this score is
adjusted with the text query match score or the scope specificity score
of the search query.

### Base composite score

The base composite score consist of the following:

  - 50% from pub score (calculated from `pana`)
  - 50% from usage metrics from likes and popularity

The usage metrics use a non-linear scoring model, where the package above the N-th
percentile gets N/100 points (e.g. if a package has more likes than the 90% of the
packages, it will get 0.90 points for likes).

### Scope specificity score

When a platform filter is specified, we both check whether the predicate
matches the platforms of the package, and also calculate how closely it
matches them ([`scope_specificity.dart`](https://github.com/dart-lang/pub-dev/blob/master/app/lib/search/scope_specificity.dart)).

For example, if the platform filter is `platform:web`, we'll have the following scores:

- `<missing or empty platform>`: no match, doesn't show up in the results
- `['platform:android', 'platform:ios']`: no match, doesn't show up in the results
- `['platform:web']`: `1.0` (specific platform match)
- `['platform:android', 'platform:web']`: `0.9` (1 extra platform, close platform match)
- `['platform:android', 'platform:ios', 'platform:web']`: `0.8` (2+ extra platforms, distant platform match)

### Numerical ordering

Numerical ordering is used on search requests that dp not specify text query, but
would like to order the results by `updated`, or `created` time, and also by
`likes`, `popularity`, or `pub points`. 

These work on the raw values, without any weights or transformation.

### Text match ranking

The indexing process prepares the package documents and parses the following fields:

- package name
- package description (first 500 characters)
- readme (first 5000 characters)

When a text query is specified, we'll try to match the query against all of these
separately, with the lower weights on description (0.90) and readme (0.75), and
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

- `overall`: `[0.0 .. 1.0] -> [0.5 .. 1.0]`

Scope specificity is already protected against low values, there is no
transformation required for it.

For example, a result with the following scores is calculated the following way:

| Name | Value |
| --- | --- |
| pub score | 0.84 |
| usage metrics | 0.92 |
| overall | **0.88** |

| Name | Raw Value | Transformed |
| --- | --- | --- |
| text match | 0.7 | 0.7 |
| package's overall | 0.88 | 0.94 |
| scope specificity | 0.9 | 0.9 |
| result |  | 0.5922 |

### SDK results

On text search operations both the package and the SDK indexes will get queried,
and we display up to 3 SDK results on the first page of the results.

### Process for tuning the search ranking

Please report weird search results! When reported, the following process should
be able to fix the issues:

1. We'll create a test with multiple packages that represent the failure case.
   If needed, this should use the description and readme of the given packages.

2. We'll adjust the search index and/or scoring to satisfy the new test.

3. Before committing, we'll check the changes in the other test, whether they
   could cause any regression (e.g. if they hide or re-surface another package). 
   This is not always a bad thing, but if that happens, we'll take extra precaution
   whether it is aligned with the expected behaviour or within quality threshold.

## Legacy packages

`pub.dev` does not expose packages that support only Dart SDK 1.x in search results
or in listing pages. However, one can access these packages through their package
page (`/packages/<pkg>`) and `pub` client can download them.

To search for such packages, include `is:legacy` in the search query.
