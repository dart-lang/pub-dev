// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:pana/pana.dart' show getRepositoryUrl;
import 'package:path/path.dart' as p;
import 'package:sanitize_html/sanitize_html.dart';

final Logger _logger = Logger('pub.markdown');

const _whitelistedClassNames = <String>[
  'hash-header',
  'hash-link',
];

String markdownToHtml(String text, String baseUrl, {String baseDir}) {
  if (text == null) return null;
  final sanitizedBaseUrl = _pruneBaseUrl(baseUrl);

  final document = m.Document(
      extensionSet: m.ExtensionSet.gitHubWeb,
      blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes);

  final lines = text.replaceAll('\r\n', '\n').split('\n');
  final nodes = document.parseLines(lines);

  final urlRewriter = _RelativeUrlRewriter(sanitizedBaseUrl, baseDir);
  final hashLink = _HashLink();
  final unsafeUrlFilter = _UnsafeUrlFilter();
  for (final node in nodes) {
    node.accept(urlRewriter);
    node.accept(hashLink);
    node.accept(unsafeUrlFilter);
  }

  final html = sanitizeHtml(
    m.renderToHtml(nodes),
    allowElementId: (String id) => true, // TODO: blacklist ids used by pub site
    allowClassName: (String cn) {
      if (cn.startsWith('language-')) return true;
      return _whitelistedClassNames.contains(cn);
    },
  );
  return html + '\n';
}

final _headers = Set.from(<String>['h1', 'h2', 'h3', 'h4', 'h5', 'h6']);

/// Adds an extra <a href="#hash">#</a> element to all h1,h2,h3..h6 elements.
class _HashLink implements m.NodeVisitor {
  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) => true;

  @override
  void visitElementAfter(m.Element element) {
    final isHeaderWithHash = _headers.contains(element.tag) &&
        element.generatedId != null &&
        element.children.length == 1;

    if (isHeaderWithHash) {
      element.attributes['class'] = 'hash-header';
      element.children.addAll([
        m.Text(' '),
        m.Element('a', [m.Text('#')])
          ..attributes['href'] = '#${element.generatedId}'
          ..attributes['class'] = 'hash-link',
      ]);
    }
  }
}

/// Filters unsafe URLs from the generated HTML.
class _UnsafeUrlFilter implements m.NodeVisitor {
  static const _trustedSchemes = <String>['http', 'https', 'mailto'];

  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) {
    final isUnsafe =
        _isUnsafe(element, 'a', 'href') || _isUnsafe(element, 'img', 'src');
    return !isUnsafe;
  }

  @override
  void visitElementAfter(m.Element element) {
    // no-op
  }

  bool _isUnsafe(m.Element element, String tag, String attr) {
    if (element.tag != tag) {
      return false;
    }
    final url = element.attributes[attr];
    if (url == null || url.isEmpty) {
      return false;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      element.attributes.remove(attr);
      return true;
    }
    if (uri.hasScheme && !_trustedSchemes.contains(uri.scheme)) {
      element.attributes.remove(attr);
      return true;
    }
    return false;
  }
}

/// Rewrites relative URLs with the provided [baseUrl]
class _RelativeUrlRewriter implements m.NodeVisitor {
  final String baseUrl;
  final String baseDir;
  _RelativeUrlRewriter(this.baseUrl, this.baseDir);

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
        final newSegments = List<String>.from(segments);
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
      final adjustedLinkPath = p.normalize(p.join(baseDir ?? '.', linkPath));
      final repoUrl = getRepositoryUrl(baseUrl, adjustedLinkPath);
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
