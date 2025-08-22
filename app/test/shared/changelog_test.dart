// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/changelog.dart';
import 'package:test/test.dart';

Changelog _parse(String input) {
  return ChangelogParser().parseMarkdownText(input);
}

void main() {
  group('Changelog parsing', () {
    test('basic changelog with releases that specify title, date and sections',
        () {
      const markdown = '''
# Changelog

## [1.2.0] - 2025-07-10

### Added
- New feature A
- New feature B

### Fixed
- Bug fix 1

## [1.1.0] - 2025-06-15

### Added
- Previous feature
''';

      final changelog = _parse(markdown);

      expect(changelog.title, equals('Changelog'));
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));

      final firstRelease = changelog.releases[0];
      expect(firstRelease.version, equals('1.2.0'));
      expect(firstRelease.date, equals(DateTime(2025, 7, 10)));
      expect(firstRelease.content.asHtmlText, contains('New feature A'));
      expect(firstRelease.content.asHtmlText, contains('Bug fix 1'));
      expect(firstRelease.content.asMarkdownText, contains('Bug fix 1'));

      final secondRelease = changelog.releases[1];
      expect(secondRelease.version, equals('1.1.0'));
      expect(secondRelease.date, equals(DateTime(2025, 6, 15)));
      expect(secondRelease.content.asHtmlText, contains('Previous feature'));
    });

    test('parses changelog with description', () {
      const markdown = '''
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2025-01-01

### Added
- Initial release
''';

      final changelog = _parse(markdown);

      expect(changelog.title, equals('Changelog'));
      expect(changelog.description, isNotNull);
      expect(
          changelog.description!.asHtmlText, contains('All notable changes'));
      expect(changelog.description!.asHtmlText, contains('Keep a Changelog'));
      expect(changelog.releases, hasLength(1));
    });

    test('parses Unreleased section', () {
      const markdown = '''
# Changelog

## Unreleased

### Added
- Work in progress feature

## [1.0.0] - 2025-01-01

### Added
- Initial release
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(2));

      final unreleasedSection = changelog.releases[0];
      expect(unreleasedSection.version, equals('Unreleased'));
      expect(unreleasedSection.date, isNull);
      expect(
          unreleasedSection.content.asHtmlText, contains('Work in progress'));
    });

    test('handles different version formats', () {
      const markdown = '''
# Changelog

## v2.0.0 - 2025-08-01

### Added
- Version with v prefix

## 1.5.0

### Added
- Version without date

## [1.0.0-beta.1] - 2025-01-15

### Added
- Pre-release version
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(3));

      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[0].date, equals(DateTime(2025, 8, 1)));

      expect(changelog.releases[1].version, equals('1.5.0'));
      expect(changelog.releases[1].date, isNull);

      expect(changelog.releases[2].version, equals('1.0.0-beta.1'));
      expect(changelog.releases[2].date, equals(DateTime(2025, 1, 15)));
    });

    test('handles different date formats', () {
      const markdown = '''
# Changelog

## [1.3.0] - 2025-07-10

### Added
- ISO date format

## [1.2.0] - 2025/06/15

### Added
- Slash date format

## [1.1.0] - 07/10/2025

### Added
- MM/DD/YYYY format
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(3));

      expect(changelog.releases[0].date, equals(DateTime(2025, 7, 10)));
      expect(changelog.releases[1].date, equals(DateTime(2025, 6, 15)));
      expect(changelog.releases[2].date, isNull);
    });

    test('preserves formatting in text content', () {
      const markdown = '''
# Changelog

## [1.0.0] - 2025-01-01

### Added
- **Bold text** feature
- *Italic text* feature
- `Code snippet` feature

### Links
- [External link](https://example.com)
- Internal reference

### Code blocks
```dart
void main() {
  print('Hello, World!');
}
```
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(1));

      final release = changelog.releases[0];
      expect(
          release.content.asHtmlText, contains('<strong>Bold text</strong>'));
      expect(release.content.asHtmlText, contains('<em>Italic text</em>'));
      expect(release.content.asHtmlText, contains('<code>Code snippet</code>'));
    });

    test('handles changelog without title', () {
      const markdown = '''
## [1.0.0] - 2025-01-01

### Added
- Feature without title
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('1.0.0'));
    });

    test('handles mixed header levels', () {
      const markdown = '''
# Changelog

## [2.0.0] - 2025-08-01

### Added
- New feature

### [1.0.0] - 2025-01-01

#### Added
- Initial release
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[1].version, equals('1.0.0'));
    });

    test('handles embedded header levels', () {
      const markdown = '''
# Changelog

## 2.0.0

### Upgrade

#### 1.0.0

- Instruction.
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[0].content.asHtmlText, contains('1.0.0'));
    });

    test('handles repetition', () {
      const markdown = '''
# Changelog

## 2.0.0

- Feature A.

## 2.0.0

- Feature B.

## 1.0.0

- Feature C.
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[1].version, equals('1.0.0'));
      expect(changelog.releases[0].content.asHtmlText, contains('Feature B.'));
      expect(changelog.releases[1].content.asHtmlText, contains('Feature C.'));
    });

    test('handles empty changelog', () {
      const markdown = '''
# Changelog

No releases yet.
''';

      final changelog = _parse(markdown);

      expect(changelog.title, equals('Changelog'));
      expect(changelog.description!.asHtmlText, contains('No releases yet'));
      expect(changelog.releases, isEmpty);
    });

    test('handles invalid date formats gracefully', () {
      const markdown = '''
# Changelog

## [1.0.0] - Invalid Date

### Added
- Feature with invalid date
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('1.0.0'));
      expect(changelog.releases[0].date, isNull);
    });

    test('handles non-version headers', () {
      const markdown = '''
# Changelog

## About

This is about section.

## [1.0.0] - 2025-01-01

### Added
- Actual release
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('1.0.0'));
      expect(changelog.description!.asHtmlText, contains('About'));
      expect(
          changelog.description!.asHtmlText, contains('This is about section'));
    });

    test('handles complex version numbers', () {
      const markdown = '''
# Changelog

## [1.0.0-alpha.1+build.123] - 2025-01-01

### Added
- Complex version number

## [0.1.0] - 2025-01-01

### Added
- Zero major version
''';

      final changelog = _parse(markdown);

      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('1.0.0-alpha.1+build.123'));
      expect(changelog.releases[1].version, equals('0.1.0'));
    });

    test('handles changelog without title', () {
      const markdown = '''
## [1.0.0] - 2025-01-01

### Added
- Feature without title

## [0.9.0] - 2024-12-01

### Added
- Previous feature
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('1.0.0'));
      expect(changelog.releases[1].version, equals('0.9.0'));
    });

    test('handles changelog without description', () {
      const markdown = '''
# Changelog

## [1.0.0] - 2025-01-01

### Added
- Feature without description
''';

      final changelog = _parse(markdown);

      expect(changelog.title, equals('Changelog'));
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('1.0.0'));
    });

    test('handles version entries starting with # (h1)', () {
      const markdown = '''
# [2.0.0] - 2025-08-01

### Added
- Major version with h1

# [1.0.0] - 2025-01-01

### Added
- Initial release with h1
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[1].version, equals('1.0.0'));
    });

    test('handles version entries starting with ## (h2)', () {
      const markdown = '''
## [2.0.0] - 2025-08-01

### Added
- Major version with h2

## [1.0.0] - 2025-01-01

### Added
- Initial release with h2
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('2.0.0'));
      expect(changelog.releases[1].version, equals('1.0.0'));
    });

    test('handles mixed header levels for versions', () {
      const markdown = '''
# [3.0.0] - 2025-09-01

### Added
- Version with h1

## [2.0.0] - 2025-08-01

### Added
- Version with h2

### [1.0.0] - 2025-01-01

### Added
- Version with h3
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(3));
      expect(changelog.releases[0].version, equals('3.0.0'));
      expect(changelog.releases[1].version, equals('2.0.0'));
      expect(changelog.releases[2].version, equals('1.0.0'));
    });

    test('prioritizes version detection over title', () {
      const markdown = '''
# [1.0.0] - 2025-01-01

### Added
- Version that looks like title

## [0.9.0] - 2024-12-01

### Added
- Previous version
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('1.0.0'));
      expect(changelog.releases[1].version, equals('0.9.0'));
    });

    test('handles minimal changelog with just versions', () {
      const markdown = '''
# 1.0.0

Initial release

## 0.9.0

Beta release
''';

      final changelog = _parse(markdown);

      expect(changelog.title, isNull);
      expect(changelog.description, isNull);
      expect(changelog.releases, hasLength(2));
      expect(changelog.releases[0].version, equals('1.0.0'));
      expect(changelog.releases[0].content.asHtmlText,
          contains('Initial release'));
      expect(changelog.releases[1].version, equals('0.9.0'));
      expect(
          changelog.releases[1].content.asHtmlText, contains('Beta release'));
    });

    test('handles changelog with title and version headers at same level', () {
      const markdown = '''
# Project Changelog

This is the changelog for the project.

# [1.0.0] - 2025-01-01

### Added
- Initial release
''';

      final changelog = _parse(markdown);

      expect(changelog.title, equals('Project Changelog'));
      expect(
          changelog.description!.asHtmlText, contains('This is the changelog'));
      expect(changelog.releases, hasLength(1));
      expect(changelog.releases[0].version, equals('1.0.0'));
    });

    test('markdown rendering with different styles', () {
      const markdown = '''
# Changelog

## Header 2

Text 2 over
two lines.

Multiple paragraphs with [link](https://pub.dev), `code`, and *different* **emphasis**.

---

Also:
- unordered
  multiline
- list

And:
1. order
1. list

>With multiline quoted
> `code` and *text*.

### Header 3
#### Header 4
##### Header 5
###### Header 6
''';
      final changelog = _parse(markdown);
      expect(
          changelog.description?.asMarkdownText,
          '## Header 2\n'
          '\n'
          'Text 2 over two lines.\n'
          '\n'
          'Multiple paragraphs with [link](https://pub.dev), `code`, and *different* **emphasis**.\n'
          '\n'
          '---\n'
          'Also:\n'
          '\n'
          '- unordered multiline\n'
          '- list\n'
          '\n'
          'And:\n'
          '\n'
          '1. order\n'
          '1. list\n'
          '\n'
          '> With multiline quoted `code`and *text*.\n'
          '\n'
          '\n'
          '### Header 3\n'
          '\n'
          '#### Header 4\n'
          '\n'
          '##### Header 5\n'
          '\n'
          '###### Header 6');

      // check stability: another round of the markdown output yields the same result
      final changelog2 =
          _parse('# Changelog\n${changelog.description?.asMarkdownText}');
      expect(changelog2.description?.asMarkdownText,
          changelog.description?.asMarkdownText);
    });
  });
}
