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

  - `topic:topic-name`: Searches for packages that have specified the
    `topic-name` [topic](/topics).

## Filters

The search UI also supports filters.
On a wide screen, 
the filter options will appear to the left of the search results.
On a non-wide screen, to open the filter options,
click the filter icon to the right of the search bar.

  - To filter by Dart or Flutter support, 
    expand the **SDKs** section,
    then select the SDK you are developing with.

  - To filter by platform, under the **Platforms** section,
    select all platforms you intend to support.

  - To filter for only packages with [OSI approved licenses][],
    expand the **License** section,
    then select **OSI approved**.

  - For other filters, such as including unlisted packages,
    expand the **Advanced** section.

[OSI approved licenses]: https://opensource.org/licenses

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
