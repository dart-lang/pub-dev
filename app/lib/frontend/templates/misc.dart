// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:pub_dev/frontend/templates/views/page/topics_list.dart';

import '../dom/dom.dart' as d;
import '../static_files.dart' as static_files;

import 'layout.dart';
import 'views/account/unauthenticated.dart';
import 'views/account/unauthorized.dart';
import 'views/page/error.dart';
import 'views/page/standalone.dart';

/// The content of `/doc/policy.md`
final _policyMarkdown = _readDocContent('policy.md');

/// The content of `/doc/security.md`
final _securityMarkdown = _readDocContent('security.md');

/// Loads help articles and stores them as a map with their
/// basename as a key, e.g.:
/// - `help.md` -> (title: 'Help', content: ...)
/// - `help-search.md` -> (title: 'Search', content: ...)
late final _helpArticles = () {
  final docDir = io.Directory(static_files.resolveDocDirPath());
  final files = docDir
      .listSync()
      .whereType<io.File>()
      .where((f) => f.path.endsWith('.md'));
  final results = <String, ({String? title, d.Node content})>{};
  for (final file in files) {
    final basename = p.basename(file.path);
    if (basename == 'help.md' || basename.startsWith('help-')) {
      final content = file.readAsStringSync();
      final firstLine = content.split('\n').first.trim();
      final title = firstLine.startsWith('# ')
          ? firstLine.substring(2).trim().replaceAll('`', '')
          : null;
      results[basename] = (title: title, content: _readDocContent(basename));
    }
  }
  return results;
}();

late final _sideImage = d.Image.decorative(
  src: static_files.staticUrls.packagesSideImage,
  width: 400,
  height: 400,
);

/// Renders the response where the real content is only provided for logged-in users.
String renderUnauthenticatedPage() {
  return renderLayoutPage(
    PageType.standalone,
    unauthenticatedNode,
    title: 'Authentication required',
    noIndex: true,
  );
}

/// Renders the response where the real content is only provided for authorized users.
String renderUnauthorizedPage() {
  return renderLayoutPage(
    PageType.standalone,
    unauthorizedNode,
    title: 'Authorization required',
    noIndex: true,
  );
}

/// Renders the `doc/help[<-article>].md`.
String? renderHelpPage({String? article}) {
  final basename = article == null ? 'help.md' : 'help-$article.md';
  final page = _helpArticles[basename];
  if (page == null) {
    return null;
  }
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      page.content,
      sideImage: _sideImage,
    ),
    title: [page.title, 'Help', 'Dart packages'].nonNulls.toSet().join(' | '),
    canonicalUrl: article == null ? '/help' : '/help/$article',
  );
}

String renderTopicsPage(Map<String, int> topics) {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(
      renderTopicsList(topics),
      sideImage: _sideImage,
    ),
    title: 'Topics',
    canonicalUrl: '/topics',
  );
}

/// Loads the markdown content from `/doc`.
d.Node _readDocContent(String path) {
  final fullPath = p.join(static_files.resolveDocDirPath(), path);
  return d.markdown(io.File(fullPath).readAsStringSync());
}

/// Renders the `/doc/policy.md` document.
String renderPolicyPage() {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(_policyMarkdown),
    title: 'Policy | Pub site',
    canonicalUrl: '/policy',
  );
}

/// Renders the `doc/security.md` template.
String renderSecurityPage() {
  return renderLayoutPage(
    PageType.standalone,
    standalonePageNode(_securityMarkdown),
    title: 'Security | Pub site',
    canonicalUrl: '/security',
  );
}

/// Renders the error page template.
String renderErrorPage(String title, String message) {
  return renderLayoutPage(
    PageType.error,
    errorPageNode(title: title, content: d.markdown(message)),
    title: title,
    noIndex: true,
  );
}

d.Node renderFatalError({
  required String title,
  required Uri requestedUri,
  required String? traceId,
}) {
  final issueUrl = 'https://github.com/dart-lang/pub-dev/issues/new';
  final message = d.fragment([
    d.h1(text: title),
    d.p(child: d.b(text: 'Fatal package site error.')),
    d.p(children: [
      d.text('Please open an issue: '),
      d.a(href: issueUrl, text: issueUrl),
      d.p(text: 'Add these details to help us fix the issue:'),
      d.codeSnippet(
        language: 'text',
        text: 'Requested URL: $requestedUri\nRequest ID: $traceId',
      ),
    ]),
  ]);
  return message;
}
