// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/urls.dart';

void main() {
  group('package page', () {
    test('without host', () {
      expect(pkgPageUrl('foo_bar'), '/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0'),
          '/packages/foo_bar/versions/1.0.0');
    });

    test('with host', () {
      expect(pkgPageUrl('foo_bar', includeHost: true),
          'https://pub.dev/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dev/packages/foo_bar/versions/1.0.0');
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
          'https://pub.dev/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dev/documentation/foo_bar/1.0.0/');
      expect(
          pkgDocUrl('foo_bar',
              version: '1.0.0', includeHost: true, omitTrailingSlash: true),
          'https://pub.dev/documentation/foo_bar/1.0.0');
    });
  });

  group('SDK urls', () {
    test('dev', () {
      expect(dartSdkMainUrl('2.1.0-dev.3.1'),
          'https://api.dart.dev/dev/2.1.0-dev.3.1/');
    });

    test('stable', () {
      expect(dartSdkMainUrl('2.0.0'), 'https://api.dart.dev/stable/2.0.0/');
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
      expect(inferIssueTrackerUrl('package:foo/foo.dart'), isNull);
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

  group('Infer base URL', () {
    final repo = 'https://gitlab.com/user/repo';

    test('only homepage is set', () {
      expect(inferBaseUrl(homepageUrl: repo), repo);
      expect(
        inferBaseUrl(homepageUrl: '$repo/tree/master/dir'),
        '$repo/tree/master/dir',
      );
    });

    test('only repository is set', () {
      expect(inferBaseUrl(repositoryUrl: repo), repo);
      expect(
        inferBaseUrl(repositoryUrl: '$repo/tree/master/dir'),
        '$repo/tree/master/dir',
      );
    });

    test('deep homepage, inferred repository', () {
      final homepage = '$repo/tree/master/dir';
      expect(
        inferBaseUrl(
          homepageUrl: homepage,
          repositoryUrl: inferRepositoryUrl(homepage),
        ),
        '$repo/tree/master/dir',
      );
    });

    test('unrelated homepage, simple repository', () {
      final homepage = 'https://example.com/';
      expect(
        inferBaseUrl(
          homepageUrl: homepage,
          repositoryUrl: repo,
        ),
        repo,
      );
    });

    test('URL cleanup', () {
      expect(
          inferBaseUrl(
            homepageUrl: 'http://gitlab.com/user/repo.git',
          ),
          repo);
      expect(
          inferBaseUrl(
            homepageUrl: 'http://www.gitlab.com/user/repo.git',
          ),
          repo);
      expect(
          inferBaseUrl(
            homepageUrl: 'https://www.gitlab.com/user/repo.git',
          ),
          repo);
    });
  });

  group('search urls', () {
    test('sdk:*', () {
      expect(searchUrl(), '/packages');
      expect(searchUrl(q: 'abc'), '/packages?q=abc');
    });

    test('sdk:dart', () {
      expect(searchUrl(sdk: 'dart'), '/dart/packages');
      expect(searchUrl(sdk: 'dart', q: 'abc'), '/dart/packages?q=abc');
    });

    test('sdk:dart runtime:native', () {
      expect(searchUrl(sdk: 'dart', runtimes: ['native']),
          '/dart/packages?runtime=native');
    });

    test('sdk:flutter', () {
      expect(searchUrl(sdk: 'flutter'), '/flutter/packages');
      expect(searchUrl(sdk: 'flutter', q: 'abc'), '/flutter/packages?q=abc');
    });

    test('sdk:flutter platform:android+ios', () {
      expect(searchUrl(sdk: 'flutter', platforms: ['android', 'ios']),
          '/flutter/packages?platform=android+ios');
    });
  });

  group('archive url', () {
    test('without base uri', () {
      expect(pkgArchiveDownloadUrl('foo', '1.0.0+1'),
          '/packages/foo/versions/1.0.0%2B1.tar.gz');
    });

    test('with base uri', () {
      expect(
        pkgArchiveDownloadUrl('foo', '1.0.0+1',
            baseUri: Uri.parse('https://pub.dev/')),
        'https://pub.dev/packages/foo/versions/1.0.0%2B1.tar.gz',
      );
    });
  });
}
