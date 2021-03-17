// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;

import 'package:path/path.dart' as p;

import '../../shared/markdown.dart';
import '../static_files.dart' as static_files;

import '_cache.dart';
import 'layout.dart';

/// The content of `/doc/policy.md`
final _policyMarkdown = _readDocContent('policy.md');

/// The content of `/doc/security.md`
final _securityMarkdown = _readDocContent('security.md');

/// The content of `/doc/help.md`
final _helpMarkdown = _readDocContent('help.md');

/// The content of `/doc/help-*.md`
final _helpScoringMarkdown = _readDocContent('help-scoring.md');
final _helpSearchMarkdown = _readDocContent('help-search.md');
final _helpPublishingMarkdown = _readDocContent('help-publishing.md');

/// Renders the `views/account/unauthenticated.mustache` template for the pages
/// where the real content is only provided for logged-in users.
String renderUnauthenticatedPage({String messageMarkdown}) {
  messageMarkdown ??= 'You need to be logged in to view this page.';
  final content = templateCache.renderTemplate('account/unauthenticated', {
    'message_html': markdownToHtml(messageMarkdown),
  });
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Authentication required',
    noIndex: true,
  );
}

/// Renders the `views/account/unauthorized.mustache` template for the pages
/// where the real content is only provided for authorized users.
String renderUnauthorizedPage({String messageMarkdown}) {
  messageMarkdown ??= 'You have insufficient permissions to view this page.';
  final content = templateCache.renderTemplate('account/unauthorized', {
    'message_html': markdownToHtml(messageMarkdown),
  });
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Authorization required',
    noIndex: true,
  );
}

/// Renders the `doc/help.md`.
String renderHelpPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Help | Dart packages',
    canonicalUrl: '/help',
  );
}

/// Renders the `doc/help-scoring.md`.
String renderHelpScoringPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpScoringMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Scoring | Dart packages',
    canonicalUrl: '/help/scoring',
  );
}

/// Renders the `doc/help-search.md`.
String renderHelpSearchPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpSearchMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Search | Dart packages',
    canonicalUrl: '/help/search',
  );
}

/// Renders the `doc/help-publishing.md`.
String renderHelpPublishingPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(
      contentMarkdown: _helpPublishingMarkdown,
      sideImageUrl: static_files.staticUrls.packagesSideImage,
    ),
    title: 'Publishing | Dart packages',
    canonicalUrl: '/help/publishing',
  );
}

/// Loads the markdown content from `/doc`.
String _readDocContent(String path) {
  final fullPath = p.join(static_files.resolveDocDirPath(), path);
  return io.File(fullPath).readAsStringSync();
}

/// Renders the `/doc/policy.md` document.
String renderPolicyPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(contentMarkdown: _policyMarkdown),
    title: 'Policy | Pub site',
    canonicalUrl: '/policy',
  );
}

/// Renders the `views/page/security.mustache` template.
String renderSecurityPage() {
  return renderLayoutPage(
    PageType.standalone,
    _renderStandalonePageContent(contentMarkdown: _securityMarkdown),
    title: 'Security | Pub site',
    canonicalUrl: '/security',
  );
}

/// Renders the `views/page/standalone.mustache` template.
String _renderStandalonePageContent({
  String contentHtml,
  String contentMarkdown,
  String sideImageUrl,
}) {
  ArgumentError.checkNotNull(contentHtml ?? contentMarkdown);
  if (contentHtml != null && contentMarkdown != null) {
    throw ArgumentError(
        'Only one of `contentHtml` and `contentMarkdown` must be specified.');
  }

  contentHtml ??= markdownToHtml(contentMarkdown);
  return templateCache.renderTemplate('page/standalone', {
    'content_html': contentHtml,
    'has_side_image': sideImageUrl != null,
    'side_image_url': sideImageUrl,
  });
}

/// Renders the `views/page/error.mustache` template.
String renderErrorPage(String title, String message) {
  final values = {
    'title': title,
    'message_html': markdownToHtml(message),
  };
  final String content = templateCache.renderTemplate('page/error', values);
  return renderLayoutPage(
    PageType.error,
    content,
    title: title,
    noIndex: true,
  );
}
