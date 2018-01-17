// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;

import 'package:pana/src/download_utils.dart' show getRepositoryUrl;

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

  if (sanitizedBaseUrl != null) {
    final visitor = new _RelativeUrlRewriter(sanitizedBaseUrl);
    for (final node in nodes) {
      node.accept(visitor);
    }
  }

  return m.renderToHtml(nodes) + '\n';
}

class _RelativeUrlRewriter implements m.NodeVisitor {
  final String url;
  _RelativeUrlRewriter(this.url);

  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) => true;

  @override
  void visitElementAfter(m.Element element) {
    if (element.tag == 'a') {
      element.attributes['href'] =
          _rewriteLink(element.attributes['href'], true);
    } else if (element.tag == 'img') {
      element.attributes['src'] =
          _rewriteLink(element.attributes['src'], false);
    }
  }

  String _rewriteLink(String link, bool includeFragments) {
    if (link == null || link.startsWith('#') || link.contains(':')) {
      return link;
    }
    try {
      final linkUri = Uri.parse(link);
      final linkPath = linkUri.path;
      final linkFragment = linkUri.fragment;
      if (linkPath == null || linkPath.isEmpty) {
        return link;
      }
      String newUrl;
      if (linkPath.startsWith('/')) {
        newUrl = Uri.parse(url).replace(path: linkPath).toString();
      } else {
        newUrl = getRepositoryUrl(url, linkPath);
      }
      if (linkFragment != null && linkFragment.isNotEmpty) {
        newUrl = '$newUrl#$linkFragment';
      }
      return newUrl;
    } catch (e, st) {
      _logger.warning('Relative link rewrite failed: $link', e, st);
    }
    return link;
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
