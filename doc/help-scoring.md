# Package scores & pub points

*NOTE: The Pub scoring model evolves over time, and is likely to be extended
with additional checks in the future.*

For each package, this site displays three scoring dimensions. These are
displayed in search results, in the sidebar on individual package pages, and in
full detail in the scoring report on the 'Scores' tag of an individiual package.
The three dimensions are:

  - **Likes**: A measure of how many developers have liked a package. This
    provides a raw measure of the overall sentiment of a package from peer
    developers.
  - **Pub Points**: A new measure of quality. This includes several dimensions
    of quality such as code style, platform support, and maintainability. More
    about this below.
  - **Popularity**: A measure of how many developers use a package, providing
    insight into what other developers are using.

## Likes

Likes offer a measure of how many developers have liked a package. To like a
package, locate the **thumbs up button** located in the upper-right corner of a
package page.

To view packages you have liked, use the **My pub.dev > My liked packages** menu
option.

## Popularity

Popularity measures the number of apps that depend on a package over the past 60
days. We show this on a normalized scale from 100% (the most used package) to 0%
(the least used package), but are investigating if we can provide absolute usage
counts in a future version.

Although this score is based on actual download counts, it compensates for
automated tools such as continuous builds that fetch the package on each change
request.

## Pub Points

Pub points is pub.dev's measure of quality. Pub points are awarded in five categories:

### Follow Dart file conventions

Dart packages are expected to follow certain file conventions for how to
[organize a package](https://dart.dev/guides/libraries/create-library-packages#organizing-a-library-package.
Most importantly make sure to:

  - Provide a [`pubspec.yaml` file](https://dart.dev/tools/pub/pubspec). Ensure
    all Urls are valid and use a secure `https:` scheme.

  - Provide a [`LICENSE`](https://dart.dev/tools/pub/package-layout#license)
    file, preferably using an an [OSI-approved
    license](https://opensource.org/licenses).

  - Provide a [`README.md file`](https://dart.dev/tools/pub/package-layout#readmemd)
    describing the changes in each version of the package. 

  - Provide a [`CHANGELOG.md file`](https://dart.dev/tools/pub/package-layout#changelogmd)
    describing the changes in each version of the package. Make sure to follow
    [the guidelines](https://dart.dev/tools/pub/package-layout#changelogmd) for
    how to format headings and versions so that these can be rendered correctly
    on pub.dev.

### Provide documentation

This category measures if a package has documentation in two areas:

  - The package has an illustrative code example. See the [layout
    documentation](https://dart.dev/tools/pub/package-layout#examples) for
    details about where to place this example.

  - At least 20% of the public API members contain [API
    documentation](https://dart.dev/guides/libraries/create-library-packages#documenting-a-library).

### Support multiple platforms

Packages are encouraged to support multiple platforms, to enable app developers
to support a wide vieratity of platforms for their apps. This includes Dart's
[native and web](https://dart.dev/platforms) platforms, and Flutter's
[mobile](https://flutter.dev/docs), [web](https://flutter.dev/web), and
[desktop](https://flutter.dev/desktop) targets.

Pub.dev uses two different algorithms for determining which platforms are supported:

 - **Flutter packages**: For packages that depend on the Flutter SDK, platform
   support is determined by looking at the [`platforms`
   tag](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms)
   in the `pubspec.yaml` file.

 - **Dart packages**: For packages that depend on just the Dart SDK, platform
   support is inferred by looking at the imports of [Dart core
   libraries](https://dart.dev/guides/libraries); the majority of these are
   multiplatform, but [as listed](https://dart.dev/guides/libraries) a few
   support just the Dart native or Dart web platforms.

If you need to import different libraries for specific platforms (e.g. on the
web vs on devices), you can use Dart's [**conditional
imports**](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files).

### Pass static analysis

Static analysis is used to determine of the package contains any errors,
warnings, and lints (code style issues).

To validate a package prior to publishing, run `dart analyze` (Dart SDK) /
`flutter analyze` (Flutter SDK), and fix the items it returns.

For code style, make sure to familarize yourself with the [Dart style
guide](https://dart.dev/guides/language/effective-dart/style).

Use [`analysis_options.yaml`][analysis-options] to specify further linter rules,
[enable default rules Google uses][analysis-pedantic], and make sure you fix all
warnings and errors before publishing. Here's an example
`analysis_options.yaml`:

````yaml
# Defines a default set of lint rules enforced for
# projects at Google. For details and rationale,
# see https://github.com/dart-lang/pedantic#enabled-lints.
include: package:pedantic/analysis_options.yaml

# For lint rules and documentation, see http://dart-lang.github.io/linter/lints.
# Uncomment to specify additional rules.
# linter:
#   rules:
#     - camel_case_types

# analyzer:
#   exclude:
#     - path/to/excluded/files/**
````

### Support up-to-date dependencies

This category measures if a package has up-to-date dependencies in three areas:

  - Works with the latest stable Dart SDK.
  - Works with the latest stable Flutter SDK (if applicable).
  - Works with the latest versions of all pendendencies.

To determine if your package supports the latest versions of dependencies prior
to publishing, run the `pub outdated` command (Dart SDK) or `flutter pub
outdated` command (Flutter SDK).

## Calculating pub points prior to publishing

The pub.dev site uses the analysis tool [pana][pana-url] to calculate pub
points. This is run automatically on the pub.dev site whenever you publish a new
package, or a new version of an existing package.

You can view your *pub points report* to get suggestions before publishing, by
running `pana` locally:

  1. When run `pana` will make modifications to the package, so start by making
     a copy of the directory holding your package: `cp ~/dev/mypkg ~/tmp/mypkg`

  1. Make sure you have the latest pana tool: `pub global activate pana` (`pana`
     changes frequently, so run this again frequently to update the pana tool)

  1. Run pana on the copy we made earlier: `pub global run pana ~/tmp/mypkg`


[analysis-options]: https://dart.dev/guides/language/analysis-options
[analysis-pedantic]: https://dart.dev/guides/language/analysis-options#default-google-rules-pedantic
[pana-url]: https://pub.dev/packages/pana
