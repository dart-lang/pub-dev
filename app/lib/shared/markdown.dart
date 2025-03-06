// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:html/dom.dart' as html;
import 'package:html/dom_parsing.dart' as html_parsing;
import 'package:html/parser.dart' as html_parser;
import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:pub_dev/frontend/static_files.dart';
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
  'markdown-alert',
  'report-summary-icon',
];

/// Renders markdown [text] to HTML.
String markdownToHtml(
  String text, {
  UrlResolverFn? urlResolverFn,
  String? relativeFrom,
  bool isChangelog = false,
  bool disableHashIds = false,
}) {
  final sw = Stopwatch()..start();
  try {
    text = text.replaceAll('\r\n', '\n');
    final nodes = _parseMarkdownSource(text);
    final rawHtml = m.renderToHtml(nodes);
    final processedHtml = _postProcessHtml(
      rawHtml,
      urlResolverFn: urlResolverFn,
      relativeFrom: relativeFrom,
      isChangelog: isChangelog,
      disableHashIds: disableHashIds,
    );
    return _renderSafeHtml(
      processedHtml,
      isChangelog: isChangelog,
      disableHashIds: disableHashIds,
    );
  } catch (e, st) {
    _logger.shout('Error rendering markdown.', e, st);
    // safe content inside the <pre> element
    final safeText = text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll("'", '&#39;')
        .replaceAll('"', '&quot;');
    return sanitizeHtml(
        '<p>Error rendering markdown.</p>\n<pre><code>\n$safeText\n</code></pre>\n');
  } finally {
    if (sw.elapsed.inSeconds >= 3) {
      _logger.shout('Markdown rendering taking too long: ${sw.elapsed}');
    }
  }
}

/// Parses markdown [source].
List<m.Node> _parseMarkdownSource(String source) {
  final document = m.Document(extensionSet: m.ExtensionSet.gitHubWeb);
  final lines = source.replaceAll('\r\n', '\n').split('\n');
  return document.parseLines(lines);
}

/// Renders sanitized, safe HTML from markdown nodes.
/// Adds hash link HTML to header blocks.
String _renderSafeHtml(
  String processedHtml, {
  required bool isChangelog,
  required bool disableHashIds,
}) {
  // Renders the sanitized HTML.
  final html = sanitizeHtml(
    processedHtml,
    allowElementId: (String id) =>
        !disableHashIds, // TODO: Use a denylist for ids used by pub site
    allowClassName: (String cn) {
      if (cn.startsWith('language-')) return true;
      if (cn.startsWith('markdown-alert-')) return true;
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

String _postProcessHtml(
  String rawHtml, {
  required UrlResolverFn? urlResolverFn,
  required String? relativeFrom,
  required bool isChangelog,
  required bool disableHashIds,
}) {
  var root = html_parser.parseFragment(rawHtml);

  _RelativeUrlRewriter(urlResolverFn, relativeFrom).visit(root);

  if (isChangelog) {
    final oldNodes = [...root.nodes];
    root = html.DocumentFragment();
    _groupChangelogNodes(oldNodes).forEach(root.append);
  }

  // Filter unsafe urls on some of the elements.
  _UnsafeUrlFilter().visit(root);

  // Transform GitHub task lists.
  _TaskListRewriteTreeVisitor().visit(root);

  if (!disableHashIds) {
    // add hash link HTML to header blocks
    _HashLink().visit(root);
  }

  return root.outerHtml;
}

/// Adds an extra <a href="#hash">#</a> element to h1, h2 and h3 elements.
class _HashLink extends html_parsing.TreeVisitor {
  @override
  void visitElement(html.Element element) {
    super.visitElement(element);

    final isHeaderWithHash = element.attributes.containsKey('id') &&
        _structuralHeaderTags.contains(element.localName!);

    if (isHeaderWithHash) {
      _addHashLink(element, element.attributes['id']!);
    }
  }

  void _addHashLink(html.Element element, String id) {
    final currentClasses = element.attributes['class'] ?? '';
    element.attributes['class'] = '$currentClasses hash-header'.trim();
    element.append(html.Text(' '));
    element.append(
      html.Element.tag('a')
        ..text = '#'
        ..attributes['href'] = '#$id'
        ..attributes['class'] = 'hash-link',
    );
  }
}

/// Filters unsafe URLs from the generated HTML.
class _UnsafeUrlFilter extends html_parsing.TreeVisitor {
  @override
  void visitElement(html.Element element) {
    super.visitElement(element);

    final isUnsafe =
        _isUnsafe(element, 'a', 'href') || _isUnsafe(element, 'img', 'src');
    if (isUnsafe) {
      element.replaceWith(html.Text(element.text));
    }
  }

  bool _isUnsafe(html.Element element, String tag, String attr) {
    if (element.localName != tag) {
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

/// Rewrites relative URLs with the provided [urlResolverFn].
class _RelativeUrlRewriter extends html_parsing.TreeVisitor {
  final UrlResolverFn? urlResolverFn;
  final String? relativeFrom;
  final _elementsToRemove = <html.Element>[];
  _RelativeUrlRewriter(this.urlResolverFn, this.relativeFrom);

  @override
  void visitDocumentFragment(html.DocumentFragment root) {
    super.visitDocumentFragment(root);
    _removeChildren(root);
  }

  @override
  void visitElement(html.Element element) {
    super.visitElement(element);

    // check current element
    if (element.localName == 'a') {
      _updateUrlAttributes(element, 'href');
    } else if (element.localName == 'img') {
      _updateUrlAttributes(element, 'src', raw: true);
    }
    _removeChildren(element);
  }

  void _removeChildren(html.Node parent) {
    for (var i = _elementsToRemove.length - 1; i >= 0; i--) {
      final r = _elementsToRemove[i];
      if (r.parentNode != parent) continue;
      _elementsToRemove.removeAt(i);

      if (r.localName == 'img') {
        final alt = r.attributes['alt']?.trim();
        final src = r.attributes['src']?.trim();
        final text = alt ?? src ?? r.text.trim();
        r.replaceWith(html.Text('[$text]'));
        continue;
      }

      final index = parent.nodes.indexOf(r);
      parent.nodes.removeAt(index);

      for (var j = r.nodes.length - 1; j >= 0; j--) {
        final c = r.nodes.removeLast();
        parent.nodes.insert(index, c);
      }
    }
  }

  void _updateUrlAttributes(html.Element element, String attrName,
      {bool raw = false}) {
    final oldUrl = element.attributes[attrName];
    final newUrl = _rewriteUrl(oldUrl, raw: raw);
    if (newUrl == null) {
      _elementsToRemove.add(element);
    } else if (newUrl != oldUrl) {
      element.attributes[attrName] = newUrl;
    }
  }

  /// Returns a new URL based on [url] and [urlResolverFn].
  ///
  /// When the returned value is `null`, the containing DOM node will be pruned
  /// from the output, otherwise this method may return the same or an updated URL.
  String? _rewriteUrl(String? url, {bool raw = false}) {
    // pass-through for simple cases
    if (url == null || url.startsWith('#')) {
      return url;
    }

    // pass-through for score tab
    // TODO: consider alternative template generation for score tab
    if (url == staticUrls.reportOKIconGreen ||
        url == staticUrls.reportMissingIconYellow ||
        url == staticUrls.reportMissingIconRed) {
      return url;
    }

    // reject unparseable URLs
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }
    if (urlResolverFn == null) {
      // When we have no URL resolver, we may allow absolute URLs (with scheme) or
      // in-page URLs (only fragments without any path reference).
      if (uri.hasScheme || (uri.path.isEmpty && uri.hasFragment)) {
        return url;
      }
      // Otherwise we should not display the URL and remove the DOM node.
      return null;
    }
    try {
      // Trying to resolve the URL using the given resolver function.
      return urlResolverFn!(
        url,
        relativeFrom: relativeFrom,
        isEmbeddedObject: raw,
      );
    } catch (e, st) {
      _logger.warning('Link rewrite failed: $url', e, st);
    }
    // Safe URL fallback: removing the node containing the URL that we were not able to resolve.
    return null;
  }
}

/// HTML sanitization will remove the rendered `<input type="checkbox">` elements,
/// we are replacing them with icons.
class _TaskListRewriteTreeVisitor extends html_parsing.TreeVisitor {
  @override
  void visitElement(html.Element element) {
    super.visitElement(element);

    if (element.localName != 'li') {
      return;
    }
    if (!(element.attributes['class']?.contains('task-list-item') ?? false)) {
      return;
    }
    final children = element.nodes;
    if (children.isEmpty) {
      return;
    }
    final first = children.first;
    if (first is html.Element &&
        first.localName == 'input' &&
        first.attributes['type'] == 'checkbox') {
      final checked = first.attributes['checked'] == 'true';
      children.removeAt(0);
      children.insert(0, html.Text(checked ? '✅ ' : '❌ '));
    }
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
Iterable<html.Node> _groupChangelogNodes(List<html.Node> nodes) sync* {
  html.Element? lastContentDiv;
  String? firstHeaderTag;
  for (final node in nodes) {
    final nodeTag = node is html.Element ? node.localName : null;
    final isNewHeaderTag = firstHeaderTag == null &&
        nodeTag != null &&
        _structuralHeaderTags.contains(nodeTag);
    final matchesFirstHeaderTag =
        firstHeaderTag != null && nodeTag == firstHeaderTag;
    final mayBeVersion = node is html.Element &&
        (isNewHeaderTag || matchesFirstHeaderTag) &&
        node.nodes.isNotEmpty &&
        node.nodes.first is html.Text;
    final versionText = mayBeVersion ? node.nodes.first.text?.trim() : null;
    final version = mayBeVersion ? _extractVersion(versionText) : null;
    if (version != null) {
      firstHeaderTag ??= nodeTag;
      final titleElem = html.Element.tag('h2')
        ..attributes['class'] = 'changelog-version'
        ..attributes['id'] = node.attributes['id']!
        ..append(html.Text(versionText!));

      lastContentDiv = html.Element.tag('div')
        ..attributes['class'] = 'changelog-content';

      yield html.Element.tag('div')
        ..attributes['class'] = 'changelog-entry'
        ..append(html.Text('\n'))
        ..append(titleElem)
        ..append(html.Text('\n'))
        ..append(lastContentDiv);
    } else if (lastContentDiv != null) {
      final lastChild = lastContentDiv.nodes.lastOrNull;
      if (lastChild is html.Element && lastChild.localName == 'div') {
        lastContentDiv.append(html.Text('\n'));
      }
      lastContentDiv.append(node);
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
