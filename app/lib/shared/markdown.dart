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

/// Element tags that are treated as structural headers.
/// h4, h5 and h6 are considered formatting-only headers
const _structuralHeaderTags = <String>{'h1', 'h2', 'h3'};

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
  var nodes = _parseMarkdownSource(text);
  nodes = _rewriteRelativeUrls(nodes, baseUrl: baseUrl, baseDir: baseDir);
  if (isChangelog) {
    nodes = _groupChangelogNodes(nodes).toList();
  }
  return _renderSafeHtml(nodes);
}

/// Parses markdown [source].
List<m.Node> _parseMarkdownSource(String source) {
  if (source == null) return null;
  final document = m.Document(
      extensionSet: m.ExtensionSet.gitHubWeb,
      blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes);
  final lines = source.replaceAll('\r\n', '\n').split('\n');
  return document.parseLines(lines);
}

/// Rewrites relative URLs, re-basing them on [baseUrl].
List<m.Node> _rewriteRelativeUrls(
  List<m.Node> nodes, {
  String baseUrl,
  String baseDir,
}) {
  final sanitizedBaseUrl = _pruneBaseUrl(baseUrl);
  final urlRewriter = _RelativeUrlRewriter(sanitizedBaseUrl, baseDir);
  nodes.forEach((node) => node.accept(urlRewriter));
  return nodes;
}

/// Renders sanitized, safe HTML from markdown nodes.
/// Adds hash link HTML to header blocks.
String _renderSafeHtml(List<m.Node> nodes) {
  // Filter unsafe urls on some of the elements.
  final unsafeUrlFilter = _UnsafeUrlFilter();
  nodes.forEach((node) => node.accept(unsafeUrlFilter));

  // add hash link HTML to header blocks
  final hashLink = _HashLink();
  nodes.forEach((node) => node.accept(hashLink));

  // Renders the sanitized HTML.
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

/// Adds an extra <a href="#hash">#</a> element to h1, h2 and h3 elements.
class _HashLink implements m.NodeVisitor {
  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) => true;

  @override
  void visitElementAfter(m.Element element) {
    final isHeaderWithHash = element.generatedId != null &&
        _structuralHeaderTags.contains(element.tag);
    if (isHeaderWithHash) {
      _addHashLink(element, element.generatedId);
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
/// - only structural headers (h1, h2, h3) are accepted (the first occurrence
///   determines which one we expect to match in the rest of the file)
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
  String firstHeaderTag;
  for (final node in nodes) {
    final nodeTag = node is m.Element ? node.tag : null;
    final isNewHeaderTag = firstHeaderTag == null &&
        nodeTag != null &&
        _structuralHeaderTags.contains(nodeTag);
    final matchesFirstHeaderTag =
        firstHeaderTag != null && nodeTag == firstHeaderTag;
    final version = (node is m.Element &&
            (isNewHeaderTag || matchesFirstHeaderTag) &&
            node.children.isNotEmpty &&
            node.children.first is m.Text)
        ? _extractVersion(node.children.first.textContent)
        : null;
    if (version != null) {
      firstHeaderTag ??= nodeTag;
      final titleElem = m.Element('h2', [m.Text(version.toString())])
        ..attributes['class'] = 'changelog-version'
        ..generatedId = (node as m.Element).generatedId;

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

/// Returns the extracted version (if it is a specific version, not `any` or empty).
Version _extractVersion(String text) {
  if (text == null || text.isEmpty) return null;
  text = text.trim();
  if (text.startsWith('v')) {
    text = text.substring(1).trim();
  }
  if (text.isEmpty) return null;
  try {
    final v = Version.parse(text);
    if (v.isEmpty || v.isAny) return null;
    return v;
  } on FormatException catch (_) {
    return null;
  }
}
