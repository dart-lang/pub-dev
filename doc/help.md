# Help

## Publishing a package

[Pub][pub-tool] isn't just for using other people's packages.
It also allows you to share your packages with the world.
If you have a useful project and you want others to be able to use it,
use the [`pub publish`][pub-publish] command.

## Search

`pub.dev` supports the following search expressions:
  - `"exact phrase"`: By default, when you perform a search, the results
    include packages with similar phrases. When a phrase is inside quotes,
    you'll see only those packages that contain exactly the specified
    phrase.
  - `package:prefix`: Searches for packages that begin with `prefix`.
    Use this feature to find packages in the same framework.
  - `dependency:package_name`: Searches for packages that reference
    `package_name` in their `pubspec.yaml`.
  - `dependency*:package_name`: Searches for packages that depend on
    `package_name` (as direct, dev, or transitive dependencies).
  - `email:user@example.com`: Search for packages where either the
    author or the uploader has the specified email address.

## Scoring

*NOTE: The Pub scoring model is under development, and is subject to change.*

For each package, this site displays an **overall score**, calculated
from scores for the package's [popularity](#popularity), [health](#health),
and [maintenance](#maintenance).

### Popularity

The popularity score—representing how often a package is used—is derived
from download statistics. Although this score is based on actual download
counts, it compensates for automated tools such as continuous builds that
fetch the package on each change request.

*How can you improve your popularity score?*

Create useful packages that others need and love to use.

### Health

The health score is based on static analysis of the package with `dartanalyzer`:
  - Each *error* reduces the health score by 25% <sup>(*)</sup>.
  - Each *warning* reduces the health score by 5% <sup>(*)</sup>.
  - Each *hint* reduces the health score by 0.5% <sup>(*)</sup>.
  - Each *platform conflict* reduces the health score by 25 points.


<sup>(*)</sup> Percents are applied with cumulative multiplication.
For example: 2 errors and 1 warning will get a score of 53, because:
`(0.75^2 * 0.95 = 0.534375)`.

*How can you improve your health score?*

Run `dartanalyzer` (or `flutter analyze` in case of Flutter), and fix
the items it returns (especially errors and warnings, hints barely
decrease the health score).

Use [`analysis_options.yaml`][analysis-options] to specify further
linter rules, [enable default rules Google uses][analysis-pedantic],
and make sure you fix all warnings and errors before publishing.
Here's an example `analysis_options.yaml`:

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
  </code></pre>
````

### Maintenance

The maintenance score reflects how tidy and up-to-date a package is. A package
starts with 100 points, which is then then subtracted deductions based on
[a long list of detailed checks][pana-maintenance]. In summary, the main
components that influence this score are:
  - Last publish date: Best if the package has been published within one year.
  - Up-to-date dependencies: Best if all of the package's dependencies are on the latest version.
  - `README.md`, `CHANGELOG.md`, and example files: Best if all are present. For
    information on how to provide these files, see the [pub package layout conventions][pub-layout].
  - `analysis_options.yaml`: Best if this file is present. For more information, see
    [Customize Static Analysis][analysis-options].

*How can you improve your maintenance score?*

Click your package's overall score to see the Analysis page, which has
suggestions for improving the package's score. Fix them, and release
at least one new version every year to keep your maintenance score up.

Pub site uses [pana][pana-url] to create maintenance suggestions.
To get suggestions before publishing, run `pana` locally
(using `--source path`), or validate your package against the
[list of checks][pana-maintenance] manually.

### Overall score

The overall score is a weighted average of the individual scores:
  - 50% popularity,
  - 30% code health,
  - 20% maintenance.

You can find the overall score either near the top of the package's page
or to the right of your package in any listing on this site.

## Ranking

Default listings use composite scoring to sort packages. The score is
based on the overall score, and if applicable, the platform specificity
and the text match score is also factored in.

Each package's overall score is visible at the side of the results,
regardless of the sort order.

[pub-tool]: https://dart.dev/tools/pub
[pub-publish]: https://dart.dev/tools/pub/publishing
[pub-layout]: https://dart.dev/tools/pub/package-layout
[analysis-options]: https://dart.dev/guides/language/analysis-options
[analysis-pedantic]: https://dart.dev/guides/language/analysis-options#default-google-rules-pedantic
[pana-maintenance]: https://pub.dev/documentation/pana/latest/#maintenance-score
[pana-url]: https://pub.dev/packages/pana
