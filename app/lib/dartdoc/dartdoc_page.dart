// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:html/dom.dart' show Element;
import 'package:html/parser.dart' as html_parser;
import 'package:pub_dev/frontend/dom/dom.dart' as d;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:sanitize_html/sanitize_html.dart';

import '../shared/urls.dart';

class DartDocPageOptions {
  final String package;
  final String version;
  final bool isLatestStable;

  /// Path of the current file relative to the documentation root.
  final String path;

  DartDocPageOptions({
    required this.package,
    required this.version,
    required this.isLatestStable,
    required this.path,
  });

  String get latestStableDocumentationUrl => pkgDocUrl(package, isLatest: true);

  String get pubPackagePageUrl =>
      pkgPageUrl(package, version: isLatestStable ? null : version);

  String get canonicalUrl {
    var p = path;
    // Strip /index.html
    if (p.endsWith('/index.html')) {
      p = p.substring(0, p.length - 'index.html'.length);
    }
    return isLatestStable
        ? pkgDocUrl(package, isLatest: true, relativePath: p)
        : pkgDocUrl(package, version: version, relativePath: p);
  }
}

class Breadcrumb {
  final String title;

  /// Link to the breadcrumb, `null` if this the current page
  final String? href;

  Breadcrumb({required this.title, required this.href});
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
class DartDocPage {
  final String title;
  final String description;
  final List<Breadcrumb> breadcrumbs;
  final String left;
  final String right;
  final String content;

  DartDocPage({
    required this.title,
    required this.description,
    required this.breadcrumbs,
    required this.left,
    required this.right,
    required this.content,
  });

  static DartDocPage parse(String rawHtml) {
    final document = html_parser.parse(rawHtml);

    // TODO: Create a variant of sanitizeHtml that consumes nodes from
    //       package:html, so that we don't have re-parse everything :/
    String sanitize(String? html) => sanitizeHtml(
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

    final L = document.querySelector('#dartdoc-sidebar-left');
    L?.querySelector('header')?.remove();
    L?.querySelector('.breadcrumbs')?.remove();
    final left = L?.innerHtml;

    final R = document.querySelector('#dartdoc-sidebar-right');
    final right = R?.innerHtml;

    final C = document.querySelector('#dartdoc-main-content');
    // HACK: Replace <section> with <div> to make sanitizeHtml happy
    for (final section in C?.querySelectorAll('section') ?? <Element>[]) {
      final div = Element.tag('div');
      div.attributes = section.attributes;
      section.reparentChildren(div);
      section.replaceWith(div);
    }
    final content = C?.innerHtml;

    return DartDocPage(
      title: document.querySelector('head > title')?.text ?? '',
      description: document
              .querySelector('head > meta[name=description]')
              ?.attributes['content'] ??
          '',
      breadcrumbs: breadcrumbs,
      left: sanitize(left),
      right: sanitize(right),
      content: sanitize(content),
    );
  }

  d.Node get _left => d.unsafeRawHtml(left);
  d.Node get _right => d.unsafeRawHtml(right);
  d.Node get _content => d.unsafeRawHtml(content);

  d.Node _renderHead(DartDocPageOptions options) =>
      d.element('head', children: [
        // HACK: noindex logic is pub.dev specific
        if (!options.isLatestStable || breadcrumbs.length > 3)
          d.meta(name: 'robots', content: 'noindex'),
        d.script(
            type: 'text/javascript',
            async: true,
            src: 'https://www.googletagmanager.com/gtm.js?id=GTM-MX6DBN9'),
        d.script(type: 'text/javascript', src: staticUrls.gtmJs),
        d.meta(charset: 'utf-8'),
        d.meta(httpEquiv: 'X-UA-Compatible', content: 'IE=edge'),
        d.meta(
            name: 'viewport',
            content:
                'width=device-width, height=device-height, initial-scale=1, user-scalable=no'),
        d.meta(name: 'generator', content: 'made with love by dartdoc'),
        d.meta(name: 'description', content: description),
        d.element('title', text: title),
        // HACK: Inject a customized canonical url
        d.meta(rel: 'canonical', href: options.canonicalUrl),
        // HACK: Inject alternate link, if not is latest stable version
        if (!options.isLatestStable)
          d.meta(rel: 'alternate', href: options.latestStableDocumentationUrl),
        d.link(rel: 'preconnect', href: 'https://fonts.gstatic.com'),
        // HACK: This is not part of dartdoc
        d.link(
            rel: 'stylesheet',
            type: 'text/css',
            href: staticUrls.githubMarkdownCss),
        // TODO: Consider using same github.css we use on pub.dev
        d.link(
            rel: 'stylesheet',
            type: 'text/css',
            href: staticUrls.dartdocGithubCss),
        d.link(
          rel: 'stylesheet',
          href:
              'https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,300;0,400;0,500;0,700;1,400&amp;display=swap',
        ),
        d.link(
          rel: 'stylesheet',
          href:
              'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0',
        ),

        d.link(rel: 'stylesheet', href: staticUrls.dartdocStylesCss),
        d.link(rel: 'icon', href: staticUrls.smallDartFavicon),
      ]);

  // HACK: Breadcrumbs are different from what dartdoc produces!
  List<Breadcrumb> _breadcrumbs(DartDocPageOptions options) => [
        // Prepend a '<name> package' breadcrumb leading back to pub.dev
        Breadcrumb(
          title: '${options.package} package',
          href: options.pubPackagePageUrl,
        ),
        // Change the title of the first breadcrumb to be 'documentation'
        if (breadcrumbs.firstOrNull != null)
          Breadcrumb(
            title: 'documentation',
            href: breadcrumbs.first.href,
          ),
        ...breadcrumbs.skip(1),
      ];

  d.Node _renderHeader(DartDocPageOptions options) =>
      d.element('header', id: 'title', children: [
        d.span(
          id: 'sidenav-left-toggle',
          classes: ['material-symbols-outlined'],
          attributes: {'role': 'button', 'tabindex': '0'},
          text: 'menu',
        ),
        d.a(
          href: '/',
          classes: ['hidden-xs'],
          child: d.img(
            // TODO: Move this into a class
            attributes: {'style': 'height: 30px; margin-right: 1em;'},
            image: d.Image(
              src: staticUrls.dartLogoSvg,
              alt: 'Dart',
              height: 30,
              width: 30,
            ),
          ),
        ),
        d.element(
          'ol',
          classes: ['breadcrumbs', 'gt-separated', 'dark', 'hidden-xs'],
          children: [
            ..._breadcrumbs(options).map((crumb) => crumb.href != null
                ? d.li(child: d.a(text: crumb.title, href: crumb.href))
                : d.li(text: crumb.title, classes: ['self-crumb']))
          ],
        ),
        d.div(
          classes: ['self-name'],
          text: breadcrumbs.lastOrNull?.title ?? '',
        ),
        d.form(
          classes: ['search', 'navbar-right'],
          attributes: {'role': 'search'},
          child: d.input(
            type: 'text',
            id: 'search-box',
            autocomplete: 'off',
            disabled: false,
            classes: ['form-control typeahead'],
            placeholder: 'Loading search...',
          ),
        ),
        d.div(
          id: 'theme-button',
          classes: ['toggle'],
          child: d.label(
            attributes: {'for': 'theme'},
            children: [
              d.input(id: 'theme', type: 'checkbox', value: 'light-theme'),
              d.span(
                  classes: ['material-symbols-outlined'], text: 'brightness_4'),
            ],
          ),
        ),
      ]);

  d.Node _renderMainContent(DartDocPageOptions options) => d.div(
        id: 'dartdoc-main-content',
        classes: ['main-content'],
        child: _content,
      );

  d.Node _renderLeftSideBar(DartDocPageOptions options) => d.div(
        id: 'dartdoc-sidebar-left',
        classes: ['sidebar', 'sidebar-offcanvas-left'],
        children: [
          d.element(
            'header',
            id: 'header-search-sidebar',
            classes: ['hidden-l'],
            child: d.form(
              classes: ['search-sidebar'],
              attributes: {'role': 'search'},
              child: d.input(
                id: 'search-sidebar',
                type: 'text',
                autocomplete: 'off',
                disabled: false,
                classes: ['form-control', 'typeahead'],
                placeholder: 'Loading search...',
              ),
            ),
          ),
          d.element(
            'ol',
            id: 'sidebar-nav',
            classes: ['breadcrumbs', 'gt-separated', 'dark', 'hidden-l'],
            children: [
              ..._breadcrumbs(options).map((crumb) => crumb.href != null
                  ? d.li(child: d.a(text: crumb.title, href: crumb.href))
                  : d.li(text: crumb.title, classes: ['self-crumb']))
            ],
          ),
          _left,
        ],
      );

  d.Node _renderRightSideBar(DartDocPageOptions options) => d.div(
        id: 'dartdoc-sidebar-right',
        classes: ['sidebar', 'sidebar-offcanvas-right'],
        child: _right,
      );

  d.Node _renderMain(DartDocPageOptions options) =>
      d.element('main', children: [
        _renderMainContent(options),
        _renderLeftSideBar(options),
        _renderRightSideBar(options),
      ]);

  d.Node _renderFooter(DartDocPageOptions options) =>
      d.element('footer', children: [
        d.span(
          classes: ['no-break'],
          text: '${options.package} ${options.version}',
        ),
      ]);

  d.Node _renderBody(DartDocPageOptions options) =>
      d.element('body', attributes: {
        'data-base-href': '../',
        'data-using-base-href': 'false',
        'class': 'light-theme',
      }, children: [
        d.element('noscript',
            child: d.element('iframe', attributes: {
              'src': 'https://www.googletagmanager.com/ns.html?id=GTM-MX6DBN9',
              'height': '0',
              'width': '0',
              'style': 'display:none;visibility:hidden',
            })),
        d.div(id: 'overlay-under-drawer'),
        _renderHeader(options),
        _renderMain(options),
        _renderFooter(options),
        // TODO: Consider using highlightjs we also use on pub.dev
        d.script(src: staticUrls.dartdochighlightJs),
        d.script(src: staticUrls.dartdocScriptJs),
      ]);

  d.Node render(DartDocPageOptions options) => d.fragment([
        d.unsafeRawHtml('<!DOCTYPE html>\n'),
        d.element('html', attributes: {
          'lang': 'en'
        }, children: [
          _renderHead(options),
          _renderBody(options),
        ]),
      ]);
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
