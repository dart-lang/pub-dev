# Package scores & pub points

*NOTE: The Pub scoring model evolves over time, and is likely to be extended
with additional checks in the future.*

For each package, this site displays three scoring dimensions. These are
displayed in search results, in the sidebar on individual package pages, and in
full detail in the scoring report on the 'Scores' tag of an individual package.
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

## Download counts

Pub.dev tracks and stores how many times each version of each package gets downloaded. This is used to display package usage metrics.

The displayed download counts on pub.dev are aggregates based on raw server-side numbers counting the times a package archive has been downloaded.

This means that some numbers might be lower or higher than expected. The package can have a high usage that appears low because users may cache the package in their `PUB_CACHE`, which is a global cache. Hence, a particular package version will only be downloaded once per user, even if the user calls `pub get` many times across different projects.

On the other hand, for some packages the download count can be relatively high. For instance, the number can be high if the package is used as a dependency by other popular packages. The download counts can also be highly affected if the package is used by CI systems running tests, since these systems typically don't retain the `PUB_CACHE` between test runs.

The download count is by no means a perfect metric, and should be regarded as an indicator of popularity.

## Popularity

Popularity measures the number of apps that depend on a package over the past 60
days. We show this as a percentile from 100% (among the top 1% most used
packages) to 0% (the least used package). We are investigating if we can provide
absolute usage counts in a future version See
[this](https://github.com/dart-lang/pub-dev/issues/2714) issue.

Although this score is based on actual download counts, it compensates for
automated tools such as continuous builds that fetch the package on each change
request.

## Pub Points

Pub points is pub.dev's measure of quality. Pub points are awarded in six
categories:

### Follow Dart file conventions

Dart packages are expected to follow certain file conventions for how to
[organize a package](https://dart.dev/guides/libraries/create-library-packages#organizing-a-library-package).
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

### Platform support

Packages are encouraged to support multiple platforms, to enable app developers
to support a wide variety of platforms for their apps. This includes Dart's
[native and web](https://dart.dev/platforms) platforms, and Flutter's
[mobile](https://flutter.dev/docs), [web](https://flutter.dev/web), and
[desktop](https://flutter.dev/desktop) targets.

pub.dev knows about the following platforms:

* Windows
* Linux
* macOS
* Android
* iOS
* Web

And the two SDKs:

* Flutter
* Dart

The platform support will be detected by analyzing the transitive import graph
of the top-level libraries, and finding what core libraries are used. (e.g. a
package importing `dart:html` does not support the 'windows' platform).

If you need to import different libraries for specific platforms (e.g. on the
web vs on devices), you can use Dart's [**conditional
imports**](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files).

#### Declaring platforms:

For packages that make sense or only have implementation on a subset of 
platforms the detected platform support can be overridden with a platform 
declaration in the `pubspec.yaml` file:

* Flutter plugins declare their platforms by the  [`flutter.plugin.platform`
   key](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms).

* Packages using FFI or otherwise being platform-specific can declare their
  platform support using a top-level [`platforms`] declaration:

  ```yaml
  # This package works only on Windows and Linux.
  platforms: 
    windows:
    linux:
  ```
### Pass static analysis

Static analysis is used to determine of the package contains any errors,
warnings, and lints (code style issues).

To validate a package prior to publishing, run `dart analyze` (Dart SDK) /
`flutter analyze` (Flutter SDK), and fix the items it returns.

For code style, make sure to familiarize yourself with the [Dart style
guide](https://dart.dev/guides/language/effective-dart/style).

Your package will be analyzed against the lints in the standard
[lints](https://pub.dev/packages/lints) package. Look
[here](https://pub.dev/packages/lints#how-to-enable-these-lints) to learn how to
enable the same lints locally.

### Support up-to-date dependencies

This category measures if a package has up-to-date dependencies in three areas:

  - Works with the latest stable Dart SDK.
  - Works with the latest stable Flutter SDK (if applicable).
  - Works with the latest versions of all dependencies.

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

  1. Make sure you have the latest pana tool: `dart pub global activate pana` (`pana`
     changes frequently, so run this again frequently to update the pana tool)

  1. Run pana on the copy we made earlier: `dart pub global run pana ~/tmp/mypkg`


[analysis-options]: https://dart.dev/guides/language/analysis-options
[analysis-pedantic]: https://dart.dev/guides/language/analysis-options#default-google-rules-pedantic
[pana-url]: https://pub.dev/packages/pana
