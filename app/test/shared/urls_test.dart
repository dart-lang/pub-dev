// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/urls.dart';

void main() {
  group('package page', () {
    test('without host', () {
      expect(pkgPageUrl('foo_bar'), '/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0'),
          '/packages/foo_bar/versions/1.0.0');
    });

    test('with host', () {
      expect(pkgPageUrl('foo_bar', includeHost: true),
          'https://pub.dartlang.org/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dartlang.org/packages/foo_bar/versions/1.0.0');
    });
  });

  group('documentation page', () {
    test('without host', () {
      expect(pkgDocUrl('foo_bar'), '/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0'),
          '/documentation/foo_bar/1.0.0/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', omitTrailingSlash: true),
          '/documentation/foo_bar/1.0.0');
    });

    test('with host', () {
      expect(pkgDocUrl('foo_bar', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/1.0.0/');
      expect(
          pkgDocUrl('foo_bar',
              version: '1.0.0', includeHost: true, omitTrailingSlash: true),
          'https://pub.dartlang.org/documentation/foo_bar/1.0.0');
    });
  });

  group('homepage syntax check', () {
    test('no url is not accepted', () {
      expect(() => syntaxCheckHomepageUrl(null), throwsException);
    });

    test('example urls that are accepted', () {
      syntaxCheckHomepageUrl('http://github.com/user/repo/');
      syntaxCheckHomepageUrl('https://github.com/user/repo/');
      syntaxCheckHomepageUrl('http://some.domain.com');
    });

    test('urls without valid scheme are not accepted', () {
      expect(() => syntaxCheckHomepageUrl('github.com/x/y'), throwsException);
      expect(() => syntaxCheckHomepageUrl('ftp://github.com/x/y'),
          throwsException);
    });

    test('urls without valid host are not accepted', () {
      expect(() => syntaxCheckHomepageUrl('http://none/x/'), throwsException);
      expect(() => syntaxCheckHomepageUrl('http://example.com/x/'),
          throwsException);
      expect(
          () => syntaxCheckHomepageUrl('http://localhost/x/'), throwsException);
      expect(() => syntaxCheckHomepageUrl('http://.../x/'), throwsException);
    });
  });

  group('SDK urls', () {
    test('dev', () {
      expect(dartSdkMainUrl('2.1.0-dev.3.1'),
          'https://api.dartlang.org/dev/2.1.0-dev.3.1/');
    });

    test('stable', () {
      expect(dartSdkMainUrl('2.0.0'), 'https://api.dartlang.org/stable/2.0.0/');
    });
  });

  group('Infer repository URL', () {
    test('empty or bad input', () {
      expect(inferRepositoryUrl(null), isNull);
      expect(inferRepositoryUrl(''), isNull);
      expect(inferRepositoryUrl('abc 123'), isNull);
      expect(inferRepositoryUrl('ftp://github.com/a/b/c'), isNull);
    });

    test('unknown domain', () {
      expect(inferRepositoryUrl('https://example.com/'), isNull);
      expect(inferRepositoryUrl('https://example.com/a'), isNull);
      expect(inferRepositoryUrl('https://example.com/a/b'), isNull);
    });

    test('github', () {
      final repo = 'https://github.com/user/repo';
      expect(inferRepositoryUrl(repo), repo);
      expect(inferRepositoryUrl('$repo/'), repo);
      expect(inferRepositoryUrl('$repo/a'), repo);
      expect(inferRepositoryUrl('$repo/a/b/c'), repo);
    });

    test('gitlab', () {
      final repo = 'https://gitlab.com/user/repo';
      expect(inferRepositoryUrl(repo), repo);
      expect(inferRepositoryUrl('$repo/'), repo);
      expect(inferRepositoryUrl('$repo/a'), repo);
      expect(inferRepositoryUrl('$repo/a/b/c'), repo);
    });
  });

  group('Infer issue tracker URL', () {
    test('empty or bad input', () {
      expect(inferIssueTrackerUrl(null), isNull);
      expect(inferIssueTrackerUrl(''), isNull);
      expect(inferIssueTrackerUrl('abc 123'), isNull);
      expect(inferIssueTrackerUrl('ftp://github.com/a/b/c'), isNull);
    });

    test('unknown domain', () {
      expect(inferIssueTrackerUrl('https://example.com/'), isNull);
      expect(inferIssueTrackerUrl('https://example.com/a'), isNull);
      expect(inferIssueTrackerUrl('https://example.com/a/b'), isNull);
    });

    test('github', () {
      final repo = 'https://github.com/user/repo';
      final tracker = '$repo/issues';
      expect(inferIssueTrackerUrl(repo), tracker);
      expect(inferIssueTrackerUrl('$repo/'), tracker);
      expect(inferIssueTrackerUrl('$repo/a'), tracker);
      expect(inferIssueTrackerUrl('$repo/a/b/c'), tracker);
    });

    test('gitlab', () {
      final repo = 'https://gitlab.com/user/repo';
      final tracker = '$repo/issues';
      expect(inferIssueTrackerUrl(repo), tracker);
      expect(inferIssueTrackerUrl('$repo/'), tracker);
      expect(inferIssueTrackerUrl('$repo/a'), tracker);
      expect(inferIssueTrackerUrl('$repo/a/b/c'), tracker);
    });
  });
}
