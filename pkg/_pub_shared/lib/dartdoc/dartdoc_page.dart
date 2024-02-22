// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:html/dom.dart' show Element;
import 'package:html/parser.dart' as html_parser;
import 'package:json_annotation/json_annotation.dart';
import 'package:sanitize_html/sanitize_html.dart';

part 'dartdoc_page.g.dart';

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
  late final titleWithoutDotDart =
      title.endsWith('.dart') ? title.substring(0, title.length - 5) : title;
}

/// A dartdoc sidebar content.
@JsonSerializable()
class DartDocSidebar {
  /// Sanitized HTML content of the sidebar.
  final String content;

  DartDocSidebar({
    required this.content,
  });

  static DartDocSidebar parse(
    String rawHtml, {
    required bool removeLeadingHrefParent,
  }) {
    final updatedHtml = removeLeadingHrefParent
        ? rawHtml.replaceAll(' href="../', ' href="')
        : rawHtml;
    return DartDocSidebar(content: DartDocPage._sanitize(updatedHtml));
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
  });

  factory DartDocPage.fromJson(Map<String, dynamic> json) =>
      _$DartDocPageFromJson(json);

  Map<String, dynamic> toJson() => _$DartDocPageToJson(this);

  // TODO: Create a variant of sanitizeHtml that consumes nodes from
  //       package:html, so that we don't have re-parse everything :/
  static String _sanitize(String? html) => sanitizeHtml(
        html ?? '',
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
    final breadcrumbs = document
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
          return Breadcrumb(
            title: crumb.text,
            href: href,
          );
        }).toList() ??
        <Breadcrumb>[];

    final rawLeft = document.querySelector('#dartdoc-sidebar-left');
    rawLeft?.querySelector('header')?.remove();
    rawLeft?.querySelector('.breadcrumbs')?.remove();
    final left = rawLeft?.innerHtml;

    final rawRight = document.querySelector('#dartdoc-sidebar-right');
    final right = rawRight?.innerHtml;

    final rawContent = document.querySelector('#dartdoc-main-content');
    // HACK: Replace <section> with <div> to make sanitizeHtml happy
    for (final section
        in rawContent?.querySelectorAll('section') ?? <Element>[]) {
      final div = Element.tag('div');
      div.attributes = section.attributes;
      section.reparentChildren(div);
      section.replaceWith(div);
    }
    final content = rawContent?.innerHtml;

    return DartDocPage(
      title: document.querySelector('head > title')?.text ?? '',
      description: document
              .querySelector('head > meta[name=description]')
              ?.attributes['content'] ??
          '',
      breadcrumbs: breadcrumbs,
      left: _sanitize(left),
      right: _sanitize(right),
      content: _sanitize(content),
      baseHref: body?.attributes['data-base-href'],
      usingBaseHref: body?.attributes['data-using-base-href'],
      aboveSidebarUrl: rawContent?.attributes['data-above-sidebar'],
      belowSidebarUrl: rawContent?.attributes['data-below-sidebar'],
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
