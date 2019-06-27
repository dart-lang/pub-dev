// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'pub_client.dart';

/// A single object to execute integration script and verification tests querying
/// public pages on the pub.dev site (or on a test site).
class PublicPagesScript {
  final String pubHostedUrl;
  PubClient _pubClient;

  PublicPagesScript(this.pubHostedUrl);

  /// Verify public pages.
  Future verify() async {
    assert(_pubClient == null);
    _pubClient = PubClient(pubHostedUrl);
    try {
      await _landingPage();
      await _flutterLandingPage();
      await _helpPage();
      await _atomFeed();
      await _searchPage();
    } finally {
      _pubClient.close();
      _pubClient = null;
    }
  }

  Future _landingPage() async {
    final html = await _pubClient.getContent('/');
    _contains(html, 'Top Dart packages');
    _contains(html, 'More Dart packages...');
  }

  Future _flutterLandingPage() async {
    final html = await _pubClient.getContent('/flutter');
    _contains(html, 'makes it easy and fast to build beautiful mobile apps');
  }

  Future _helpPage() async {
    final html = await _pubClient.getContent('/help');
    _contains(html,
        'The overall score is a weighted average of the individual scores');
  }

  Future _atomFeed() async {
    final content = await _pubClient.getContent('/feed.atom');
    _contains(content, 'Pub Feed Generator');
  }

  Future _searchPage() async {
    final content = await _pubClient.getContent('/packages?q=retry');
    _contains(content, 'results for <code>retry</code>');
  }

  void _contains(String content, String matched) {
    if (content.contains(matched)) return;
    throw Exception('Content does not contain `$matched`.');
  }
}
