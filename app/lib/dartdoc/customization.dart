// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

import '../frontend/static_files.dart';
import '../shared/urls.dart';

class DartdocCustomizer {
  final String packageName;
  final String packageVersion;
  final bool isLatestStable;

  DartdocCustomizer(this.packageName, this.packageVersion, this.isLatestStable);

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
    final String newContent = customizeHtml(oldContent);
    if (newContent != null && oldContent != newContent) {
      await file.writeAsString(newContent);
      return true;
    } else {
      return false;
    }
  }

  String customizeHtml(String html) {
    final doc = html_parser.parse(html);
    final canonical = doc.head.getElementsByTagName('link').firstWhere(
          (elem) => elem.attributes['rel'] == 'canonical',
          orElse: () => null,
        );
    _stripCanonicalUrl(canonical);
    _addAlternateUrl(doc.head, canonical);
    _addAnalyticsTracker(doc.head);
    _addGithubMarkdownStyle(doc.head, doc.body);
    final docRoot = isLatestStable
        ? pkgDocUrl(packageName, isLatest: true)
        : pkgDocUrl(packageName, version: packageVersion);
    final breadcrumbs = doc.body.querySelector('.breadcrumbs');
    final breadcrumbsDepth = breadcrumbs?.children?.length ?? 0;
    if (breadcrumbs != null) {
      _addPubSiteLogo(breadcrumbs);
      _addPubPackageLink(breadcrumbs);
      _updateIndexLinkToCanonicalRoot(breadcrumbs, docRoot);
    }
    final sidebarBreadcrumbs = doc.body.querySelector('.sidebar .breadcrumbs');
    if (sidebarBreadcrumbs != null) {
      _addPubPackageLink(sidebarBreadcrumbs, level: 2);
      _updateIndexLinkToCanonicalRoot(sidebarBreadcrumbs, docRoot);
    }
    if (!isLatestStable || breadcrumbsDepth > 3) {
      _addMetaNoIndex(doc.head);
    }
    return doc.outerHtml;
  }

  void _stripCanonicalUrl(Element elem) {
    if (elem == null) return;
    String href = elem.attributes['href'];
    if (href != null && href.endsWith('/index.html')) {
      href = href.substring(0, href.length - 'index.html'.length);
    }
    if (href != null) {
      // Since the <base /> tag removal, dartdoc calculates the canonical URL
      // with extra `../../` segments. Removing them as a temporary fix.
      // https://github.com/dart-lang/dartdoc/issues/2122
      // TODO: Remove this after the dartdoc issue is fixed
      href = href.replaceAll('../', '');

      elem.attributes['href'] = href;
    }
  }

  void _addAlternateUrl(Element head, Element canonical) {
    if (isLatestStable) return;

    final link = Element.tag('link');
    link.attributes['rel'] = 'alternate';
    link.attributes['href'] = pkgDocUrl(packageName, isLatest: true);

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
        ..attributes['href'] = staticUrls.githubMarkdownCss;
      head.insertBefore(linkElement, firstLink);
    }
  }

  void _addAnalyticsTracker(Element head) {
    final firstChild = head.firstChild;
    final gtagScript = Element.tag('script')
      ..attributes['async'] = 'async'
      ..attributes['src'] =
          'https://www.googletagmanager.com/gtag/js?id=UA-26406144-13'
      ..text = '';
    head.insertBefore(gtagScript, firstChild);
    final gtagInit = Element.tag('script')
      ..attributes['src'] = '/static/js/gtag.js';
    head.insertBefore(gtagInit, firstChild);
  }

  void _addPubSiteLogo(Element breadcrumbs) {
    final parent = breadcrumbs.parent;
    final logoLink = Element.tag('a')
      ..className = 'hidden-xs'
      ..attributes['href'] = '/';
    final imgRef = Element.tag('img')
      ..attributes['src'] = staticUrls.dartLogoSvg
      ..attributes['style'] = 'height: 30px; margin-right: 1em;';
    logoLink.append(imgRef);
    parent.insertBefore(logoLink, breadcrumbs);
  }

  void _addPubPackageLink(Element breadcrumbs, {int level = 1}) {
    final pubPackageLink = pkgPageUrl(packageName,
        version: isLatestStable ? null : packageVersion);
    final pubPackageText = '$packageName package';
    if (breadcrumbs.children.length == 1) {
      // we are on the index page
      final firstLink = breadcrumbs.querySelector('a');
      firstLink.attributes['href'] = pubPackageLink;
      firstLink.text = pubPackageText;

      final docitem = Element.tag('li')
        ..className = 'self-crumb'
        ..text = 'documentation';
      breadcrumbs.append(docitem);
    } else if (breadcrumbs.children.isNotEmpty) {
      // we are inside
      final firstLink = breadcrumbs.querySelector('a');
      firstLink.text = 'documentation';

      final lead = Element.tag('li');
      final leadLink = Element.tag('a');
      leadLink.attributes['href'] = pubPackageLink;
      leadLink.text = pubPackageText;
      lead.append(leadLink);

      breadcrumbs.insertBefore(lead, breadcrumbs.firstChild);
    }
  }

  void _updateIndexLinkToCanonicalRoot(Element breadcrumbs, String docRoot) {
    breadcrumbs
        .querySelectorAll('a')
        .where((e) => e.attributes['href'] == 'index.html')
        .forEach((e) => e.attributes['href'] = docRoot);
  }
}
