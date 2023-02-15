// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

class DartdocCustomizerConfig {
  final String packageName;
  final String packageVersion;
  final bool isLatestStable;
  final String docRootUrl;
  final String latestStableDocumentationUrl;
  final String pubPackagePageUrl;
  final String dartLogoSvgUrl;
  final String githubMarkdownCssUrl;
  final String gtmJsUrl;
  final List<String> trustedTargetHosts;
  final List<String> trustedUrlSchemes;

  DartdocCustomizerConfig({
    required this.packageName,
    required this.packageVersion,
    required this.isLatestStable,
    required this.docRootUrl,
    required this.latestStableDocumentationUrl,
    required this.pubPackagePageUrl,
    required this.dartLogoSvgUrl,
    required this.githubMarkdownCssUrl,
    required this.gtmJsUrl,
    required this.trustedTargetHosts,
    required this.trustedUrlSchemes,
  });
}

class DartdocCustomizer {
  final DartdocCustomizerConfig config;
  DartdocCustomizer(this.config);

  Future<bool> customizeDir(String path) async {
    bool changed = false;
    final dir = Directory(path);
    await for (var fse in dir.list(recursive: true)) {
      if (fse is File && fse.path.endsWith('.html')) {
        final c = await customizeFile(fse);
        changed = changed || c;
      }
    }
    return changed;
  }

  Future<bool> customizeFile(File file) async {
    final String oldContent = await file.readAsString();
    final newContent = customizeHtml(oldContent);
    if (oldContent != newContent) {
      await file.writeAsString(newContent);
      return true;
    } else {
      return false;
    }
  }

  String customizeHtml(String html) {
    final doc = html_parser.parse(html);
    final head = doc.head!;
    final body = doc.body!;
    final canonical = head
        .getElementsByTagName('link')
        .firstWhereOrNull((elem) => elem.attributes['rel'] == 'canonical');
    _stripCanonicalUrl(canonical);
    _addAlternateUrl(head, canonical);
    _addAnalyticsTracker(head, body);
    _addCookieNotice(head);
    _addGithubMarkdownStyle(head, body);
    final breadcrumbs = body.querySelector('.breadcrumbs');
    final breadcrumbsDepth = breadcrumbs?.children.length ?? 0;
    if (breadcrumbs != null) {
      _addPubSiteLogo(breadcrumbs);
      _addPubPackageLink(breadcrumbs);
      _updateIndexLinkToCanonicalRoot(breadcrumbs);
    }
    final sidebarBreadcrumbs = body.querySelector('.sidebar .breadcrumbs');
    if (sidebarBreadcrumbs != null) {
      _addPubPackageLink(sidebarBreadcrumbs, level: 2);
      _updateIndexLinkToCanonicalRoot(sidebarBreadcrumbs);
    }
    if (!config.isLatestStable || breadcrumbsDepth > 3) {
      _addMetaNoIndex(head);
    }
    _updateLinks(body);
    return doc.outerHtml;
  }

  void _stripCanonicalUrl(Element? elem) {
    if (elem == null) return;
    var href = elem.attributes['href'];
    if (href != null && href.endsWith('/index.html')) {
      href = href.substring(0, href.length - 'index.html'.length);
      elem.attributes['href'] = href;
    }
  }

  void _addAlternateUrl(Element head, Element? canonical) {
    if (config.isLatestStable) return;

    final link = Element.tag('link');
    link.attributes['rel'] = 'alternate';
    link.attributes['href'] = config.latestStableDocumentationUrl;

    if (canonical == null) {
      head.append(link);
      return;
    }

    head.insertBefore(link, canonical);
  }

  void _addMetaNoIndex(Element head) {
    final meta = Element.tag('meta');
    meta.attributes['name'] = 'robots';
    meta.attributes['content'] = 'noindex';

    head.insertBefore(meta, head.firstChild);
  }

  // Check <a> elements and update their rel="ugc" attribute if needed.
  void _updateLinks(Element body) {
    for (final a in body.querySelectorAll('a')) {
      final href = a.attributes['href'];
      final uri = href == null ? null : Uri.tryParse(href);
      if (uri == null ||
          (uri.hasScheme && !config.trustedUrlSchemes.contains(uri.scheme))) {
        // Unable to parse the uri, better to remove the `href` attribute.
        a.attributes.remove('href');
      } else if (uri.host.isNotEmpty &&
          !config.trustedTargetHosts.contains(uri.host)) {
        a.attributes['rel'] = 'ugc';
      }
    }
  }

  void _addGithubMarkdownStyle(Element head, Element body) {
    // adding markdown-body style
    body.querySelectorAll('.markdown').forEach((elem) {
      if (!elem.classes.contains('markdown-body')) {
        elem.classes.add('markdown-body');
      }
    });

    final hasMarkdownBodyClass = body.querySelector('.markdown-body') != null;
    if (hasMarkdownBodyClass) {
      // adding CSS link
      final firstLink = head.children.firstWhere((elem) =>
          elem.localName == 'link' && elem.attributes['rel'] == 'stylesheet');
      final linkElement = Element.tag('link')
        ..attributes['rel'] = 'stylesheet'
        ..attributes['type'] = 'text/css'
        ..attributes['href'] = config.githubMarkdownCssUrl;
      head.insertBefore(linkElement, firstLink);
    }
  }

  void _addAnalyticsTracker(Element head, Element body) {
    // Insert right after HEAD:
    // <script async="async" src="https://www.googletagmanager.com/gtm.js?id=GTM-MX6DBN9"></script>
    // <script src="${staticUrls.gtmJs}"></script>
    final firstHeadChild = head.firstChild;
    head.insertBefore(
      Element.tag('script')
        ..attributes['async'] = 'async'
        ..attributes['src'] =
            'https://www.googletagmanager.com/gtm.js?id=GTM-MX6DBN9'
        ..text = '',
      firstHeadChild,
    );
    head.insertBefore(
      Element.tag('script')
        ..attributes['src'] = config.gtmJsUrl
        ..text = '',
      firstHeadChild,
    );

    // Insert right after BODY:
    // <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MX6DBN9"
    // height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    body.insertBefore(
      Element.tag('noscript')
        ..append(
          Element.tag('iframe')
            ..attributes['src'] =
                'https://www.googletagmanager.com/ns.html?id=GTM-MX6DBN9'
            ..attributes['height'] = '0'
            ..attributes['width'] = '0'
            ..attributes['style'] = 'display:none;visibility:hidden'
            ..text = '',
        ),
      body.firstChild,
    );
  }

  void _addCookieNotice(Element head) {
    head.append(Element.tag('link')
      ..attributes['rel'] = 'stylesheet'
      ..attributes['type'] = 'text/css'
      ..attributes['href'] = 'https://www.gstatic.com/glue/v25_0/ccb.min.css');

    head.append(
      Element.tag('script')
        ..attributes['defer'] = 'defer'
        ..attributes['src'] =
            'https://www.gstatic.com/brandstudio/kato/cookie_choice_component/cookie_consent_bar.v3.js'
        ..attributes['data-autoload-cookie-consent-bar'] = 'true'
        ..text = '',
    );
  }

  void _addPubSiteLogo(Element breadcrumbs) {
    final parent = breadcrumbs.parent;
    final logoLink = Element.tag('a')
      ..className = 'hidden-xs'
      ..attributes['href'] = '/';
    final imgRef = Element.tag('img')
      ..attributes['src'] = config.dartLogoSvgUrl
      ..attributes['style'] = 'height: 30px; margin-right: 1em;';
    logoLink.append(imgRef);
    parent!.insertBefore(logoLink, breadcrumbs);
  }

  void _addPubPackageLink(Element breadcrumbs, {int level = 1}) {
    final pubPackageText = '${config.packageName} package';
    if (breadcrumbs.children.length == 1) {
      // we are on the index page
      final newItem = Element.tag('li');
      newItem.append(Element.tag('a')
        ..attributes['href'] = config.pubPackagePageUrl
        ..text = pubPackageText);
      breadcrumbs.children.first.replaceWith(newItem);

      final docitem = Element.tag('li')
        ..className = 'self-crumb'
        ..text = 'documentation';
      breadcrumbs.append(docitem);
    } else if (breadcrumbs.children.isNotEmpty) {
      // we are inside
      final firstLink = breadcrumbs.querySelector('a');
      firstLink!.text = 'documentation';

      final lead = Element.tag('li');
      final leadLink = Element.tag('a');
      leadLink.attributes['href'] = config.pubPackagePageUrl;
      leadLink.text = pubPackageText;
      lead.append(leadLink);

      breadcrumbs.insertBefore(lead, breadcrumbs.firstChild);
    }
  }

  void _updateIndexLinkToCanonicalRoot(Element breadcrumbs) {
    breadcrumbs
        .querySelectorAll('a')
        .where((e) => e.attributes['href'] == 'index.html')
        .forEach((e) => e.attributes['href'] = config.docRootUrl);
  }
}
