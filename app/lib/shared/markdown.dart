// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:pana/pana.dart' show getRepositoryUrl;
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:sanitize_html/sanitize_html.dart';

final Logger _logger = Logger('pub.markdown');

const _whitelistedClassNames = <String>[
  'changelog-entry',
  'changelog-version',
  'changelog-content',
  'hash-header',
  'hash-link',
];

/// Renders markdown [text] to HTML.
String markdownToHtml(
  String text,
  String baseUrl, {
  String baseDir,
  bool isChangelog = false,
}) {
  if (text == null) return null;
  final sanitizedBaseUrl = _pruneBaseUrl(baseUrl);

  final document = m.Document(
      extensionSet: m.ExtensionSet.gitHubWeb,
      blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes);

  final lines = text.replaceAll('\r\n', '\n').split('\n');
  var nodes = document.parseLines(lines);

  if (isChangelog) {
    nodes = _groupChangelogNodes(nodes).toList();
  }

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
      _addHashLink(element, element.generatedId);
    }
  }
}

void _addHashLink(m.Element element, String id) {
  final currentClasses = element.attributes['class'] ?? '';
  element.attributes['class'] = '$currentClasses hash-header'.trim();
  element.children.addAll([
    m.Text(' '),
    m.Element('a', [m.Text('#')])
      ..attributes['href'] = '#$id'
      ..attributes['class'] = 'hash-link',
  ]);
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

/// Group corresponding changelog nodes together, if it matches the following
/// pattern:
/// - version identifiers are the only content in a single line
/// - heading level or other style doesn't matter
/// - optional `v` prefix is accepted
/// - message logs between identifiers are copied to the version entry before the line
///
/// The output is in the following structure:
/// <div class="changelog-entry">
///   <h2 class="changelog-version">{{version - stripped from styles}}</h2>
///   <div class="changelog-content">
///     {{log entries in their original HTML format}}
///   </div>
/// </div>
Iterable<m.Node> _groupChangelogNodes(List<m.Node> nodes) sync* {
  m.Element lastContentDiv;
  for (final node in nodes) {
    final version = (node is m.Element &&
            node.children.isNotEmpty &&
            node.children.first is m.Text)
        ? _extractVersion(node.children.first.textContent)
        : null;
    if (version != null) {
      final titleElem = m.Element('h2', [m.Text(version)])
        ..attributes['class'] = 'changelog-version';
      final generatedId = (node as m.Element).generatedId;
      if (generatedId != null) {
        titleElem.attributes['id'] = generatedId;
        _addHashLink(titleElem, generatedId);
      }

      lastContentDiv = m.Element('div', [])
        ..attributes['class'] = 'changelog-content';

      yield m.Element('div', [
        titleElem,
        lastContentDiv,
      ])
        ..attributes['class'] = 'changelog-entry';
    } else if (lastContentDiv != null) {
      lastContentDiv.children.add(node);
    } else {
      yield node;
    }
  }
}

String _extractVersion(String text) {
  if (text == null || text.isEmpty) return null;
  text = text.trim();
  if (text.startsWith('v')) {
    text = text.substring(1).trim();
  }
  if (text.isEmpty) return null;
  try {
    final v = Version.parse(text);
    if (v.isEmpty || v.isAny) return null;
    return v.toString();
  } on FormatException catch (_) {
    return null;
  }
}
