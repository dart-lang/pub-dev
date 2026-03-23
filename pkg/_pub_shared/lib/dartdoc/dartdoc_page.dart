// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart' as html_parser;
import 'package:json_annotation/json_annotation.dart';
import 'package:sanitize_html/sanitize_html.dart';

part 'dartdoc_page.g.dart';

/// Generates a random nonce used for image proxying markers.
///
/// This makes it practically impossible for an attacker to guess the imageProxyNonce
/// and inject malicious image markers into the documentation content.
String _generateNonce() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(256));
  return values.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
}

@JsonSerializable()
final class Breadcrumb {
  final String title;

  /// Link to the breadcrumb, `null` if this the current page
  final String? href;

  Breadcrumb({required this.title, required this.href});

  factory Breadcrumb.fromJson(Map<String, dynamic> json) =>
      _$BreadcrumbFromJson(json);

  Map<String, dynamic> toJson() => _$BreadcrumbToJson(this);

  /// dartdoc outputs library names with `.dart` in the main breadcrumbs location,
  /// but without it for the sidebar breadcrumbs location.
  late final titleWithoutDotDart = title.endsWith('.dart')
      ? title.substring(0, title.length - 5)
      : title;
}

/// A dartdoc sidebar content.
@JsonSerializable()
class DartDocSidebar {
  /// Sanitized HTML content of the sidebar.
  final String content;

  /// The nonce used for image proxying markers.
  final String imageProxyNonce;

  DartDocSidebar({required this.content, required this.imageProxyNonce});

  static DartDocSidebar parse(String rawHtml) {
    final imageProxyNonce = _generateNonce();
    final fragment = html_parser.parseFragment(rawHtml);
    return DartDocSidebar(
      content: DartDocPage._sanitizeAndMarkImages(fragment, imageProxyNonce),
      imageProxyNonce: imageProxyNonce,
    );
  }

  factory DartDocSidebar.fromJson(Map<String, dynamic> json) =>
      _$DartDocSidebarFromJson(json);

  Map<String, dynamic> toJson() => _$DartDocSidebarToJson(this);
}

/// A dartdoc page parsed as sanitized html.
///
///
/// This assumes a page layout along the lines of:
/// ```
///           [header]
/// ------------------------------
///        |           |
/// [left] | [content] | [right]
///        |           |
/// ------------------------------
///           [footer]
/// ```
@JsonSerializable()
final class DartDocPage {
  final String title;
  final String description;
  final List<Breadcrumb> breadcrumbs;

  /// Sanitized HTML for the [left] pane.
  final String left;

  /// Sanitized HTML for the [right] pane.
  final String right;

  /// Sanitized HTML for the [content] pane.
  final String content;

  /// The base href of the current page relative to the root `index.html`.
  final String? baseHref;

  /// Flag for dartdoc, whether to use the [baseHref] in dynamic sidebar loading.
  final String? usingBaseHref;

  /// The left/above sidebar URL that dartdoc will load dynamically.
  final String? aboveSidebarUrl;

  /// The right/below sidebar URL that dartdoc will load dynamically.
  final String? belowSidebarUrl;

  /// The path URL this page redirects to.
  final String? redirectPath;

  /// The nonce used for marking image urls for image proxying.
  final String imageProxyNonce;

  DartDocPage({
    required this.title,
    required this.description,
    required this.breadcrumbs,
    required this.left,
    required this.right,
    required this.content,
    required this.baseHref,
    required this.usingBaseHref,
    required this.aboveSidebarUrl,
    required this.belowSidebarUrl,
    required this.redirectPath,
    required this.imageProxyNonce,
  });

  factory DartDocPage.fromJson(Map<String, dynamic> json) =>
      _$DartDocPageFromJson(json);

  Map<String, dynamic> toJson() => _$DartDocPageToJson(this);

  // TODO: Create a variant of sanitizeHtml that consumes nodes from
  //       package:html, so that we don't have re-parse everything :/
  /// Sanitizes the given [node] and marks images for proxying with [imageProxyNonce].
  static String _sanitizeAndMarkImages(
    html_dom.Node? node,
    String imageProxyNonce,
  ) {
    if (node == null) return '';
    _markImages(node, imageProxyNonce);
    final String html;
    if (node is html_dom.Element) {
      html = node.innerHtml;
    } else if (node is html_dom.DocumentFragment) {
      final div = html_dom.Element.tag('div');
      for (final n in node.nodes) {
        div.append(n.clone(true));
      }
      html = div.innerHtml;
    } else {
      html = '';
    }
    final sanitized = sanitizeHtml(
      html,
      allowClassName: (_) => true,
      allowElementId: (_) => true,
      addLinkRel: (href) {
        final u = Uri.tryParse(href);
        if (u != null && !u.shouldIndicateUgc) {
          // TODO: Determine if there is a better way to do this.
          //       It's probably reasonable that internal links don't
          //       required ugc + nofollow.
          return [];
        }
        // Add ugc and nofollow if the host isn't one of ours.
        return ['ugc', 'nofollow'];
      },
    );
    return sanitized;
  }

  /// Marks images for proxying by replacing the src attribute with a marker.
  ///
  /// Uses the [imageProxyNonce] to create a unique marker for each page.
  static void _markImages(html_dom.Node root, String imageProxyNonce) {
    final elements = root is html_dom.Element
        ? root.querySelectorAll('img')
        : root is html_dom.DocumentFragment
        ? root.querySelectorAll('img')
        : <html_dom.Element>[];
    for (final img in elements) {
      final src = img.attributes['src'];
      if (src != null && src.isNotEmpty) {
        final uri = Uri.tryParse(src);
        if (uri != null &&
            (uri.scheme == 'http' || uri.scheme == 'https') &&
            !uri.isTrustedHost) {
          img.attributes['src'] =
              '{$imageProxyNonce}:{${Uri.encodeComponent(src)}}';
        }
      }
    }
  }

  /// Indicates that the [DartDocPage] was could not parse any displayable
  /// content from the dartdoc output. Such page is a redirect page that was
  /// introduced in `dartdoc 8.3.0`.
  bool isEmpty() {
    return title.isEmpty &&
        description.isEmpty &&
        breadcrumbs.isEmpty &&
        left.isEmpty &&
        right.isEmpty &&
        (baseHref == null || baseHref!.isEmpty) &&
        (usingBaseHref == null || usingBaseHref!.isEmpty) &&
        (aboveSidebarUrl == null || aboveSidebarUrl!.isEmpty) &&
        (belowSidebarUrl == null || belowSidebarUrl!.isEmpty);
  }

  static DartDocPage parse(String rawHtml) {
    final document = html_parser.parse(rawHtml);

    // HACK: Adding markdown-body style
    final body = document.body;
    if (body != null) {
      // TODO: Modify our CSS to accomodate the styles output from dartdoc
      body.querySelectorAll('.markdown').forEach((elem) {
        if (!elem.classes.contains('markdown-body')) {
          elem.classes.add('markdown-body');
        }
      });
    }

    // Extract breadcrumbs, because we need to tweak these on pub.dev
    final breadcrumbs =
        document
            .querySelector('header#title')
            ?.querySelector('ol.breadcrumbs')
            ?.children
            .map((crumb) {
              var href = crumb.querySelector('a')?.attributes['href'];
              if (href != null && !_validLink(href)) {
                href = null;
              }
              if (href != null) {
                final u = Uri.tryParse(href);
                if (u == null || u.shouldIndicateUgc) {
                  href = null; // breadcrumbs should never link externally!
                }
              }
              return Breadcrumb(title: crumb.text, href: href);
            })
            .toList() ??
        <Breadcrumb>[];

    final rawLeft = document.querySelector('#dartdoc-sidebar-left');
    rawLeft?.querySelector('header')?.remove();
    rawLeft?.querySelector('.breadcrumbs')?.remove();

    final rawRight = document.querySelector('#dartdoc-sidebar-right');

    final rawContent = document.querySelector('#dartdoc-main-content');
    // HACK: Replace <section> with <div> to make sanitizeHtml happy
    for (final section
        in rawContent?.querySelectorAll('section') ?? <html_dom.Element>[]) {
      final div = html_dom.Element.tag('div');
      div.attributes = section.attributes;
      section.reparentChildren(div);
      section.replaceWith(div);
    }

    final httpEquivRefresh = document.head
        ?.querySelectorAll('meta')
        .where((e) => e.attributes['http-equiv'] == 'refresh')
        .firstOrNull;
    final redirectPath = httpEquivRefresh?.attributes['content']
        ?.split(';')
        .map((p) => p.trim())
        .where((p) => p.startsWith('url='))
        .firstOrNull
        ?.substring(4);

    final imageProxyNonce = _generateNonce();
    return DartDocPage(
      title: document.querySelector('head > title')?.text ?? '',
      description:
          document
              .querySelector('head > meta[name=description]')
              ?.attributes['content'] ??
          '',
      breadcrumbs: breadcrumbs,
      left: _sanitizeAndMarkImages(rawLeft, imageProxyNonce),
      right: _sanitizeAndMarkImages(rawRight, imageProxyNonce),
      content: _sanitizeAndMarkImages(rawContent, imageProxyNonce),
      baseHref: body?.attributes['data-base-href'],
      usingBaseHref: body?.attributes['data-using-base-href'],
      aboveSidebarUrl: rawContent?.attributes['data-above-sidebar'],
      belowSidebarUrl: rawContent?.attributes['data-below-sidebar'],
      redirectPath: redirectPath,
      imageProxyNonce: imageProxyNonce,
    );
  }
}

// Copy/pasted from sanitize_html
bool _validLink(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.isScheme('https') ||
        uri.isScheme('http') ||
        uri.isScheme('mailto') ||
        !uri.hasScheme;
  } on FormatException {
    return false;
  }
}

/// Hostnames that are trusted in user-generated content (and don't get rel="ugc").
const trustedTargetHost = [
  'api.dart.dev',
  'api.flutter.dev',
  'dart.dev',
  'flutter.dev',
  'pub.dev',
];

/// URI schemes that are trusted and can be rendered. Other URI schemes must be
/// rejected and the URL mustn't be displayed.
const trustedUrlSchemes = <String>['http', 'https', 'mailto'];

extension UriExt on Uri {
  /// The [scheme] of the [Uri] is trusted, it may be displayed.
  bool get isTrustedScheme => trustedUrlSchemes.contains(scheme);

  /// Whether the [Uri] has an untrusted or incompatible structure.
  bool get isInvalid => hasScheme && !isTrustedScheme;

  /// The host of the link is trusted, it is unlikely to be a spam.
  bool get isTrustedHost => trustedTargetHost.contains(host);

  /// Whether on rendering we should emit rel="ugc".
  bool get shouldIndicateUgc => host.isNotEmpty && !isTrustedHost;
}
