// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;

import 'package:path/path.dart' as p;

import '../../account/models.dart';
import '../dom/dom.dart' as d;
import '../static_files.dart' as static_files;

import 'layout.dart';
import 'views/account/unauthenticated.dart';
import 'views/account/unauthorized.dart';
import 'views/page/error.dart';
import 'views/page/standalone.dart';

/// The content of `/doc/api.md`
final _apiMarkdown = _readDocContent('api.md');

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

late final _sideImage = d.Image(
  src: static_files.staticUrls.packagesSideImage,
  alt: 'cover image decorating the page',
  width: 400,
  height: 400,
);

/// Renders the response where the real content is only provided for logged-in users.
String renderUnauthenticatedPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    unauthenticatedNode,
    title: 'Authentication required',
    noIndex: true,
    sessionData: sessionData,
  );
}

/// Renders the response where the real content is only provided for authorized users.
String renderUnauthorizedPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    unauthorizedNode,
    title: 'Authorization required',
    noIndex: true,
    sessionData: sessionData,
  );
}

/// Renders the `doc/api.md`.
String renderHelpApiPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      _apiMarkdown,
      sideImage: _sideImage,
    ),
    title: 'pub.dev API',
    canonicalUrl: '/help/api',
    sessionData: sessionData,
  );
}

/// Renders the `doc/help.md`.
String renderHelpPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      _helpMarkdown,
      sideImage: _sideImage,
    ),
    title: 'Help | Dart packages',
    canonicalUrl: '/help',
    sessionData: sessionData,
  );
}

/// Renders the `doc/help-scoring.md`.
String renderHelpScoringPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      _helpScoringMarkdown,
      sideImage: _sideImage,
    ),
    title: 'Scoring | Dart packages',
    canonicalUrl: '/help/scoring',
    sessionData: sessionData,
  );
}

/// Renders the `doc/help-search.md`.
String renderHelpSearchPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      _helpSearchMarkdown,
      sideImage: _sideImage,
    ),
    title: 'Search | Dart packages',
    canonicalUrl: '/help/search',
    sessionData: sessionData,
  );
}

/// Renders the `doc/help-publishing.md`.
String renderHelpPublishingPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      _helpPublishingMarkdown,
      sideImage: _sideImage,
    ),
    title: 'Publishing | Dart packages',
    canonicalUrl: '/help/publishing',
    sessionData: sessionData,
  );
}

/// Loads the markdown content from `/doc`.
d.Node _readDocContent(String path) {
  final fullPath = p.join(static_files.resolveDocDirPath(), path);
  return d.markdown(io.File(fullPath).readAsStringSync());
}

/// Renders the `/doc/policy.md` document.
String renderPolicyPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(_policyMarkdown),
    title: 'Policy | Pub site',
    canonicalUrl: '/policy',
    sessionData: sessionData,
  );
}

/// Renders the `doc/security.md` template.
String renderSecurityPage({
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(_securityMarkdown),
    title: 'Security | Pub site',
    canonicalUrl: '/security',
    sessionData: sessionData,
  );
}

/// Renders the error page template.
String renderErrorPage(
  String title,
  String message, {
  required SessionData? sessionData,
}) {
  return renderLayoutPage(
    PageType.error,
    errorPageNode(title: title, content: d.markdown(message)),
    title: title,
    noIndex: true,
    sessionData: sessionData,
  );
}
