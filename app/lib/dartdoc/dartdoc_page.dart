// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/frontend/dom/dom.dart' as d;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/configuration.dart';

import '../shared/urls.dart';

export 'package:_pub_shared/dartdoc/dartdoc_page.dart';

final class DartDocPageOptions {
  final String package;
  final String version;

  /// The URL segment the version is served under (e.g. `/1.2.5/` or `/latest/`)
  final String urlSegment;
  final bool isLatestStable;

  /// Path of the current file relative to the documentation root.
  final String path;

  /// The value of the `q=<query>` parameter when the request is on `search.html`,
  /// `null` otherwise.
  final String? searchQueryParameter;

  DartDocPageOptions({
    required this.package,
    required this.version,
    required this.urlSegment,
    required this.isLatestStable,
    required this.path,
    this.searchQueryParameter,
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
    return pkgDocUrl(
      package,
      includeHost: true,
      // keeps the [version] or the "latest" string of the requested URI
      version: urlSegment,
      relativePath: p,
    );
  }
}

extension DartDocPageRender on DartDocPage {
  d.Node get _left => d.unsafeRawHtml(left);
  d.Node get _right => d.unsafeRawHtml(right);
  d.Node get _content => d.unsafeRawHtml(content);

  String _pageTitle(DartDocPageOptions options) {
    if (options.searchQueryParameter == null) {
      return title;
    } else {
      return '$title - search results for ${options.searchQueryParameter}';
    }
  }

  bool _allowsRobotsIndexing(DartDocPageOptions options) {
    // non-latest stables should not be indexed
    if (!options.isLatestStable) {
      return false;
    }
    // too deep pages should not be indexed
    if (breadcrumbs.length > 3) {
      return false;
    }
    // search.html page should not be indexed
    if (options.searchQueryParameter != null) {
      return false;
    }
    return true;
  }

  d.Node _renderHead(DartDocPageOptions options) =>
      d.element('head', children: [
        // HACK: noindex logic is pub.dev specific
        if (!_allowsRobotsIndexing(options))
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
        d.element('title', text: _pageTitle(options)),
        d.link(rel: 'canonical', href: options.canonicalUrl),
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
        if (activeConfiguration.isStaging)
          d.link(
              rel: 'stylesheet',
              type: 'text/css',
              href: staticUrls.getAssetUrl('/static/css/staging-ribbon.css')),
        d.link(
          rel: 'stylesheet',
          href:
              'https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,300;0,400;0,500;0,700;1,400&display=swap',
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
            image: d.Image.decorative(
              src: staticUrls.dartLogoSvg,
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
                  id: 'dark-theme-button',
                  classes: ['material-symbols-outlined'],
                  text: 'brightness_4'),
              d.span(
                  id: 'light-theme-button',
                  classes: ['material-symbols-outlined'],
                  text: 'brightness_5'),
            ],
          ),
        ),
      ]);

  d.Node _renderMainContent(DartDocPageOptions options) => d.div(
        id: 'dartdoc-main-content',
        classes: ['main-content'],
        attributes: {
          if (aboveSidebarUrl != null) 'data-above-sidebar': aboveSidebarUrl!,
          if (belowSidebarUrl != null) 'data-below-sidebar': belowSidebarUrl!,
        },
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
                  ? d.li(
                      child: d.a(
                      text: crumb.titleWithoutDotDart,
                      href: crumb.href,
                    ))
                  : d.li(text: crumb.title, classes: ['self-crumb']))
            ],
          ),
          _left,
          // TODO: remove this after all runtimes are rendered with dartdoc >=8.0.0
          if (!left.contains('dartdoc-sidebar-left-content'))
            d.div(id: 'dartdoc-sidebar-left-content', text: ''),
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

  d.Node _renderBody(DartDocPageOptions options) {
    final dataBaseHref = p.relative('', from: p.dirname(options.path));
    return d.element('body', classes: [
      'light-theme',
      if (activeConfiguration.isStaging) 'staging-banner',
    ], attributes: {
      'data-base-href':
          baseHref ?? (dataBaseHref == '.' ? '' : '$dataBaseHref/'),
      'data-using-base-href': usingBaseHref ?? 'false',
    }, children: [
      if (activeConfiguration.isStaging)
        d.div(classes: ['staging-ribbon'], text: 'staging'),
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
  }

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
