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

  DartdocCustomizer(this.packageName, this.packageVersion);

  Future<bool> customizeDir(String path) async {
    bool changed = false;
    final dir = new Directory(path);
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
    _addAnalyticsTracker(doc.head);
    final breadcrumbs = doc.body.querySelector('.breadcrumbs');
    if (breadcrumbs != null) {
      _addPubSiteLogo(breadcrumbs);
      _addPubPackageLink(breadcrumbs);
    }
    return doc.outerHtml;
  }

  void _addAnalyticsTracker(Element head) {
    final firstChild = head.firstChild;
    head.insertBefore(new Text('\n  '), firstChild);
    final gtagScript = new Element.tag('script')
      ..attributes['async'] = 'async'
      ..attributes['src'] =
          'https://www.googletagmanager.com/gtag/js?id=UA-26406144-13'
      ..text = '';
    head.insertBefore(gtagScript, firstChild);
    head.insertBefore(new Text('\n  '), firstChild);
    final gtagInit = new Element.tag('script');
    gtagInit
        .append(new Text('''\n\n    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'UA-26406144-13');
  '''));
    head.insertBefore(gtagInit, firstChild);
  }

  void _addPubSiteLogo(Element breadcrumbs) {
    final parent = breadcrumbs.parent;
    final logoLink = new Element.tag('a');
    logoLink.attributes['href'] = '$siteRoot/';
    final imgRef = new Element.tag('img');
    imgRef.attributes['src'] = '$siteRoot${staticUrls.dartLogoSvg}';
    imgRef.attributes['style'] = 'height: 30px; margin-right: 1em;';
    logoLink.append(imgRef);
    parent.insertBefore(logoLink, breadcrumbs);
    parent.insertBefore(new Text('\n  '), breadcrumbs);
  }

  void _addPubPackageLink(Element breadcrumbs) {
    final pubPackageLink =
        pkgPageUrl(packageName, version: packageVersion, includeHost: true);
    final pubPackageText = '$packageName package';
    if (breadcrumbs.children.length == 1) {
      // we are on the index page
      final firstLink = breadcrumbs.querySelector('a');
      firstLink.attributes['href'] = pubPackageLink;
      firstLink.text = pubPackageText;

      final docitem = new Element.tag('li')
        ..className = 'self-crumb'
        ..text = 'documentation';
      breadcrumbs.append(new Text('  '));
      breadcrumbs.append(docitem);
      breadcrumbs.append(new Text('\n  '));
    } else if (breadcrumbs.children.isNotEmpty) {
      // we are inside
      final firstLink = breadcrumbs.querySelector('a');
      firstLink.text = 'documentation';

      final lead = new Element.tag('li');
      final leadLink = new Element.tag('a');
      leadLink.attributes['href'] = pubPackageLink;
      leadLink.text = pubPackageText;
      lead.append(leadLink);

      breadcrumbs.insertBefore(lead, breadcrumbs.firstChild);
      breadcrumbs.insertBefore(new Text('\n    '), breadcrumbs.firstChild);
    }
  }
}
