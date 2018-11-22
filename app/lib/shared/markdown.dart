// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:pana/pana.dart' show getRepositoryUrl;

final Logger _logger = new Logger('pub.markdown');

final List<m.InlineSyntax> _inlineSyntaxes = m
    .ExtensionSet.gitHubWeb.inlineSyntaxes
    .where((s) => s is! m.InlineHtmlSyntax)
    .toList();

String markdownToHtml(String text, String baseUrl) {
  if (text == null) return null;
  final sanitizedBaseUrl = _pruneBaseUrl(baseUrl);

  final document = new m.Document(
      extensionSet: m.ExtensionSet.none,
      blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes,
      inlineSyntaxes: _inlineSyntaxes);

  final lines = text.replaceAll('\r\n', '\n').split('\n');
  final nodes = document.parseLines(lines);

  final visitor = new _UrlRewriter(sanitizedBaseUrl);
  for (final node in nodes) {
    node.accept(visitor);
  }

  return m.renderToHtml(nodes) + '\n';
}

class _UrlRewriter implements m.NodeVisitor {
  final String baseUrl;
  _UrlRewriter(this.baseUrl);

  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) => true;

  @override
  void visitElementAfter(m.Element element) {
    if (element.tag == 'a') {
      element.attributes['href'] = _rewriteUrl(element.attributes['href']);
    } else if (element.tag == 'img') {
      element.attributes['src'] =
          _rewriteUrl(element.attributes['src'], raw: true);
    }
  }

  String _rewriteUrl(String url, {bool raw = false}) {
    if (url == null || url.startsWith('#')) {
      return url;
    }
    try {
      String newUrl = url;
      if (baseUrl != null && !_isAbsolute(newUrl)) {
        newUrl = _rewriteRelativeUrl(newUrl);
      }
      if (raw && _isAbsolute(newUrl)) {
        newUrl = _rewriteAbsoluteUrl(newUrl);
      }
      return newUrl;
    } catch (e, st) {
      _logger.warning('Link rewrite failed: $url', e, st);
    }
    return url;
  }

  bool _isAbsolute(String url) => url.contains(':');

  String _rewriteAbsoluteUrl(String url) {
    final uri = Uri.parse(url);
    if (uri.host == 'github.com') {
      final segments = uri.pathSegments;
      if (segments.length > 3 && segments[2] == 'blob') {
        final newSegments = new List<String>.from(segments);
        newSegments[2] = 'raw';
        return uri.replace(pathSegments: newSegments).toString();
      }
    }
    return url;
  }

  String _rewriteRelativeUrl(String url) {
    final uri = Uri.parse(url);
    final linkPath = uri.path;
    final linkFragment = uri.fragment;
    if (linkPath == null || linkPath.isEmpty) {
      return url;
    }
    String newUrl;
    if (linkPath.startsWith('/')) {
      newUrl = Uri.parse(baseUrl).replace(path: linkPath).toString();
    } else {
      final repoUrl = getRepositoryUrl(baseUrl, linkPath);
      if (repoUrl == null) {
        return url;
      }
      newUrl = repoUrl;
    }
    if (linkFragment != null && linkFragment.isNotEmpty) {
      newUrl = '$newUrl#$linkFragment';
    }
    return newUrl;
  }
}

/// Returns null if the [url] looks invalid.
String _pruneBaseUrl(String url) {
  if (url == null) return null;
  try {
    final Uri uri = Uri.parse(url);
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return null;
    }
    if (uri.host == null || uri.host.isEmpty || !uri.host.contains('.')) {
      return null;
    }
    return uri.toString();
  } catch (e) {
    // url is user-provided, may be malicious, ignoring errors.
  }
  return null;
}
