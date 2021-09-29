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

  - On the right of the search bar, click the platform filter buttons to filter
    results to packages supporting the platforms you need support for.

  - To use platform filters for alpha platforms (e.g. Flutter Desktop), use
    the Advanced option on the far right of the search bar.

## Ranking

When you search for a package, the search algorithm first applies [filters](#filters),
and then considers only the packages that aren’t filtered out and that match
the search query. Because packages contain a lot of text (including documentation
comments and identifiers from source code), common words can match many packages.

To find the most relevant search results, the algorithm ranks packages using a
combination of the following parameters, listed in order of relative importance:

- Search query relevance of the following:
  - Package name
  - Description
  - README
  - Documentation comments and identifiers

- Package popularity and like count

- [Pub points](/help/scoring#pub-points), which are based on factors such as these:
  - Adherence to Dart file conventions
  - Presence of documentation
  - Up-to-date dependencies
  - Language feature support

- Search filter specificity, a measure of how relevant a package is to the
  current filtering.

These parameters are normalized, weighted for relative importance, and combined
to form an overall score for each search result; this score determines the
default order of the displayed search results.

The code for normalizing and weighting parameters changes occasionally. You can find
it at [github.com/dart-lang/pub-dev](https://github.com/dart-lang/pub-dev/).

## Legacy packages

`pub.dev` does not expose packages that support only Dart SDK 1.x in search results
or in listing pages. However, one can access these packages through their package
page (`/packages/<pkg>`) and `pub` client can download them.

To search for such packages, include `is:legacy` in the search query.
