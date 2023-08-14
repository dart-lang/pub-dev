// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:pub_semver/pub_semver.dart';
import 'package:sanitize_html/sanitize_html.dart';

import 'urls.dart' show UriExt;

/// Resolves [reference] relative to a repository URL.
typedef UrlResolverFn = String Function(
  String reference, {
  String? relativeFrom,
  bool? isEmbeddedObject,
});

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
  'report-summary-icon',
];

/// Renders markdown [text] to HTML.
String markdownToHtml(
  String text, {
  UrlResolverFn? urlResolverFn,
  String? baseDir,
  bool isChangelog = false,
  bool disableHashIds = false,
}) {
  final sw = Stopwatch()..start();
  try {
    text = text.replaceAll('\r\n', '\n');
    var nodes = _parseMarkdownSource(text);
    nodes = _rewriteRelativeUrls(
      nodes,
      urlResolverFn: urlResolverFn,
      baseDir: baseDir,
    );
    if (isChangelog) {
      nodes = _groupChangelogNodes(nodes).toList();
    }
    return _renderSafeHtml(nodes, disableHashIds: disableHashIds);
  } finally {
    if (sw.elapsed.inSeconds >= 3) {
      _logger.shout('Markdown rendering taking too long: ${sw.elapsed}');
    }
  }
}

/// Parses markdown [source].
List<m.Node> _parseMarkdownSource(String source) {
  final document = m.Document(
      extensionSet: m.ExtensionSet.gitHubWeb,
      blockSyntaxes: m.ExtensionSet.gitHubWeb.blockSyntaxes);
  final lines = source.replaceAll('\r\n', '\n').split('\n');
  return document.parseLines(lines);
}

/// Rewrites relative URLs, re-basing them on the repository URL.
List<m.Node> _rewriteRelativeUrls(
  List<m.Node> nodes, {
  required UrlResolverFn? urlResolverFn,
  required String? baseDir,
}) {
  final urlRewriter = _RelativeUrlRewriter(urlResolverFn, baseDir);
  nodes.forEach((node) => node.accept(urlRewriter));
  return nodes;
}

/// Renders sanitized, safe HTML from markdown nodes.
/// Adds hash link HTML to header blocks.
String _renderSafeHtml(
  List<m.Node> nodes, {
  required bool disableHashIds,
}) {
  // Filter unsafe urls on some of the elements.
  nodes.forEach((node) => node.accept(_UnsafeUrlFilter()));

  if (!disableHashIds) {
    // add hash link HTML to header blocks
    final hashLink = _HashLink();
    nodes.forEach((node) => node.accept(hashLink));
  }

  final rawHtml = m.renderToHtml(nodes);

  // Renders the sanitized HTML.
  final html = sanitizeHtml(
    rawHtml,
    allowElementId: (String id) =>
        !disableHashIds, // TODO: Use a denylist for ids used by pub site
    allowClassName: (String cn) {
      if (cn.startsWith('language-')) return true;
      return _whitelistedClassNames.contains(cn);
    },
    addLinkRel: (String url) {
      final uri = Uri.tryParse(url);
      if (uri == null || uri.isInvalid) return ['nofollow'];
      return <String>[
        if (uri.shouldIndicateUgc) 'ugc',
      ];
    },
  );
  return '$html\n';
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
      _addHashLink(element, element.generatedId!);
    }
  }

  void _addHashLink(m.Element element, String id) {
    final currentClasses = element.attributes['class'] ?? '';
    element.attributes['class'] = '$currentClasses hash-header'.trim();
    element.children!.addAll([
      m.Text(' '),
      m.Element('a', [m.Text('#')])
        ..attributes['href'] = '#$id'
        ..attributes['class'] = 'hash-link',
    ]);
  }
}

/// Filters unsafe URLs from the generated HTML.
class _UnsafeUrlFilter implements m.NodeVisitor {
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
    if (uri == null || uri.isInvalid) {
      element.attributes.remove(attr);
      return true;
    }
    return false;
  }
}

/// Rewrites relative URLs with the provided repository URL resolver.
class _RelativeUrlRewriter implements m.NodeVisitor {
  final UrlResolverFn? urlResolverFn;
  final String? baseDir;
  final _elementsToRemove = <m.Element>{};
  _RelativeUrlRewriter(this.urlResolverFn, this.baseDir);

  @override
  void visitText(m.Text text) {}

  @override
  bool visitElementBefore(m.Element element) => true;

  @override
  void visitElementAfter(m.Element element) {
    // check current element
    if (element.tag == 'a') {
      _updateUrlAttributes(element, 'href');
    } else if (element.tag == 'img') {
      _updateUrlAttributes(element, 'src', raw: true);
    }
    // remove children that are marked to be removed
    if (element.children != null &&
        element.children!.isNotEmpty &&
        _elementsToRemove.isNotEmpty) {
      for (final r in _elementsToRemove.toList()) {
        final index = element.children!.indexOf(r);
        if (index == -1) continue;

        if (r.children != null && r.children!.isNotEmpty) {
          element.children!.insertAll(index, r.children!);
        }
        element.children!.remove(r);
        _elementsToRemove.remove(r);
      }
    }
  }

  void _updateUrlAttributes(m.Element element, String attrName,
      {bool raw = false}) {
    final newUrl = _rewriteUrl(element.attributes[attrName], raw: raw);
    if (newUrl != null) {
      element.attributes[attrName] = newUrl;
    } else {
      _elementsToRemove.add(element);
    }
  }

  String? _rewriteUrl(String? url, {bool raw = false}) {
    if (url == null || url.startsWith('#')) {
      return url;
    }
    if (Uri.tryParse(url) == null) {
      return null;
    }
    try {
      if (urlResolverFn != null) {
        return urlResolverFn!(
          url,
          relativeFrom: (baseDir == null || baseDir!.isEmpty)
              ? null
              : '$baseDir/README.md',
          isEmbeddedObject: raw,
        );
      }
    } catch (e, st) {
      _logger.warning('Link rewrite failed: $url', e, st);
    }
    return url;
  }
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
  m.Element? lastContentDiv;
  String? firstHeaderTag;
  for (final node in nodes) {
    final nodeTag = node is m.Element ? node.tag : null;
    final isNewHeaderTag = firstHeaderTag == null &&
        nodeTag != null &&
        _structuralHeaderTags.contains(nodeTag);
    final matchesFirstHeaderTag =
        firstHeaderTag != null && nodeTag == firstHeaderTag;
    final mayBeVersion = node is m.Element &&
        (isNewHeaderTag || matchesFirstHeaderTag) &&
        node.children!.isNotEmpty &&
        node.children!.first is m.Text;
    final versionText =
        mayBeVersion ? node.children!.first.textContent.trim() : null;
    final version = mayBeVersion ? _extractVersion(versionText) : null;
    if (version != null) {
      firstHeaderTag ??= nodeTag;
      final titleElem = m.Element('h2', [m.Text(versionText!)])
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
      lastContentDiv.children!.add(node);
    } else {
      yield node;
    }
  }
}

/// Returns the extracted version (if it is a specific version, not `any` or empty).
Version? _extractVersion(String? text) {
  if (text == null || text.isEmpty) return null;
  text = text.trim().split(' ').first;
  if (text.startsWith('[') && text.endsWith(']')) {
    text = text.substring(1, text.length - 1).trim();
  }
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
