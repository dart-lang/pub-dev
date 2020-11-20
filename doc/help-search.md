# Search

`pub.dev` supports the following search expressions:

  - `"exact phrase"`: By default, when you perform a search, the results include
    packages with similar phrases. When a phrase is inside quotes, you'll see
    only those packages that contain exactly the specified phrase.

  - `package:prefix`: Searches for packages that begin with `prefix`. Use this
    feature to find packages in the same framework.

  - `dependency:package_name`: Searches for packages that reference
    `package_name` in their `pubspec.yaml`.

  - `dependency*:package_name`: Searches for packages that depend on
    `package_name` (as direct, dev, or transitive dependencies).

  - `email:user@example.com`: Search for packages where either the author or the
    uploader has the specified email address.

## Search filters

The search UI also supports filters:

  - On the left of the search bar, select 'Dart' or 'Flutter' depending on the
    SDK you are developing with.

  - On the right of the search bar, click the platform filter buttons to filter
    results to packages supporting the platforms you need support for.

  - To use platform filters for alpha platforms (e.g. Flutter Desktop), use
    the Advanced option on the far right of the search bar.

## Search ranking

Default listings use a composite of the three scores to sort packages. The
ranking is based on the composite score, and if applicable, the platform
specificity and the text match score of the search team.

## Legacy packages

`pub.dev` does not expose packages that support only Dart SDK 1.x in search results
or in listing pages. One can access these packages through their package page
(`/packages/<pkg>`) and `pub` client can download them.

You can use the following options to search for these packages:
- Add `legacy=1` query parameter to the URL ([example](https://pub.dev/packages?legacy=1)).
  This will include legacy packages in your search listing.
- Add `legacy=1` query parameter and also add `is:legacy` to your search query
  ([example](https://pub.dev/packages?q=is%3Alegacy&legacy=1)). This will list
  only the packages that are marked as legacy.
