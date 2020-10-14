// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../src/pub_http_client.dart';

/// A single object to execute integration script and verification tests querying
/// public pages on the pub.dev site (or on a test site).
class PublicPagesScript {
  final String pubHostedUrl;
  final bool expectLiveSite;
  PubHttpClient _pubClient;

  PublicPagesScript(
    this.pubHostedUrl, {
    @required this.expectLiveSite,
  });

  /// Verify public pages.
  Future<void> verify() async {
    assert(_pubClient == null);
    _pubClient = PubHttpClient(pubHostedUrl);
    try {
      await _landingPage();
      await _helpPages();
      await _securityPage();
      await _atomFeed();
      await _searchPage();
      await _sitemaps();
      await _badRequest();
    } finally {
      await _pubClient.close();
      _pubClient = null;
    }
  }

  Future<void> _landingPage() async {
    final html = await _pubClient.getContent('/');
    _contains(html, 'Find and use packages');
    if (expectLiveSite) {
      _contains(html, 'Top packages');
      _contains(html, 'View all');
    }
  }

  Future<void> _helpPages() async {
    _contains(await _pubClient.getContent('/help'),
        'following help pages are available');

    _contains(await _pubClient.getContent('/help/scoring'),
        'additional checks in the future');

    _contains(await _pubClient.getContent('/help/search'),
        'supports the following search expressions');

    _contains(await _pubClient.getContent('/help/publishing'),
        'It also allows you to share your packages with the world.');
  }

  Future<void> _securityPage() async {
    final html = await _pubClient.getContent('/security');
    _contains(html, 'vulnerabilities you may find');
  }

  Future<void> _atomFeed() async {
    final content = await _pubClient.getContent('/feed.atom');
    _contains(content, 'Pub Feed Generator');
  }

  Future<void> _searchPage() async {
    final content = await _pubClient.getContent('/packages?q=retry');
    _contains(content, 'search query <code>retry</code>');
  }

  Future<void> _sitemaps() async {
    await _pubClient.getContent('/sitemap.txt');
    await _pubClient.getContent('/sitemap-2.txt');
  }

  Future<void> _badRequest() async {
    _contains(
        await _pubClient.getContent(
          '/%D0%C2%BD%A8%CE%C4%BC%FE%BC%D0.zip',
          expectedStatusCode: 400,
        ),
        'Bad Request');
    _contains(
        await _pubClient.getContent(
          '/packages?q=%D0%C2%BD%A8%CE%C4%BC%FE%BC%D0',
          expectedStatusCode: 400,
        ),
        'Bad Request');
    _contains(
        await _pubClient.getContent(
          '/documentation/dart_amqp/latest//..%25c0%25af..%25c0%25af..%25c0%25af..%25c0%25af..%25c0%25af..%25c0%25af..%25c0%25af..%25c0%25af/etc/passwd',
          expectedStatusCode: 400,
        ),
        'Bad Request');
  }

  void _contains(String content, String matched) {
    if (content.contains(matched)) return;
    throw Exception('Content does not contain `$matched`.');
  }
}
