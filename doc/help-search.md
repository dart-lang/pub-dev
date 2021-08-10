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

Default listings use a composite of the three scores to sort packages. The
ranking is based on the composite score, and if applicable, the platform
specificity and the text match score of the search team.

## Legacy packages

`pub.dev` does not expose packages that support only Dart SDK 1.x in search results
or in listing pages. However, one can access these packages through their package
page (`/packages/<pkg>`) and `pub` client can download them.

To search for such packages, include `is:legacy` in the search query.
