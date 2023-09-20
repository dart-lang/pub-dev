// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:path/path.dart' as p;
import 'package:pub_dev/dartdoc/dartdoc_page.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  group('DartDocPage rendering', () {
    final tempDir = Directory.systemTemp.createTempSync();
    final pkgDir = p.join(tempDir.path, 'pkg');
    final docDir = p.join(tempDir.path, 'doc');

    setUpAll(() async {
      for (final f in _sources.entries) {
        final file = File(p.join(pkgDir, f.key));
        await file.parent.create(recursive: true);
        await file.writeAsString(f.value);
      }
      await Process.run(
        'dart',
        ['pub', 'get'],
        workingDirectory: pkgDir,
      );
    });

    tearDownAll(() async {
      await tempDir.delete(recursive: true);
    });

    test(
      'run dartdoc',
      () async {
        final pr = await Process.run(
          'dart',
          [
            'bin/pub_dartdoc.dart',
            '--no-validate-links',
            '--sanitize-html',
            '--input',
            pkgDir,
            '--output',
            docDir,
          ],
          workingDirectory: resolvePubDartdocDirPath(),
        );
        expect(pr.exitCode, 0);

        final processedFiles = <String>{};
        final files = await Directory(docDir)
            .list(recursive: true)
            .whereType<File>()
            .toList();
        for (final file in files) {
          if (file.path.endsWith('-sidebar.html')) {
            continue;
          }
          if (file.path.endsWith('/search.html')) {
            continue;
          }
          if (file.path.endsWith('.html')) {
            final relativePath = p.relative(file.path, from: docDir);
            processedFiles.add(relativePath);

            var fileContent = (await file.readAsString());
            // remove comments early on
            fileContent = fileContent.replaceAll(RegExp(r'\<!--.*?-->'), '');
            final fileXmlRoot =
                _toXml(html_parser.parse(fileContent).documentElement!);

            // rewrite static asset scripts
            for (final script in fileXmlRoot.findAllElements('script')) {
              final src = script.getAttribute('src');
              if (src != null && src.contains('static-assets/')) {
                final lastPart =
                    src.split('static-assets/')[1].split('?').first;
                script.setAttribute(
                    'src',
                    staticUrls.getAssetUrl(
                        p.join('/static/dartdoc/resources', lastPart)));
              }
            }
            // rewrite static asset links
            for (final link in fileXmlRoot.findAllElements('link')) {
              final href = link.getAttribute('href');
              if (href != null && href.contains('static-assets/')) {
                final lastPart =
                    href.split('static-assets/')[1].split('?').first;
                link.setAttribute(
                    'href',
                    staticUrls.getAssetUrl(
                        p.join('/static/dartdoc/resources', lastPart)));
                if (lastPart.endsWith('.css')) {
                  link.setAttribute('type', 'text/css');
                }
              }
            }

            final page = DartDocPage.parse(fileContent);
            final renderedNode = page.render(
              DartDocPageOptions(
                package: 'oxygen',
                version: '1.0.0',
                urlSegment: '1.0.0',
                isLatestStable: true,
                path: relativePath,
              ),
            );
            final renderedXmlDoc = XmlDocument.parse(
              renderedNode.toString(),
              entityMapping: XmlDefaultEntityMapping.html5(),
            );

            // remove nodes that are the same in both XML
            _removeSharedXmlNodes(fileXmlRoot, renderedXmlDoc);

            // cleanup <head> differences
            for (final link in ['/styles.css', '/favicon.png']) {
              fileXmlRoot.descendantElements
                  .firstWhere((e) =>
                      e.localName == 'link' &&
                      e.getAttribute('href')!.endsWith(link))
                  .remove();
            }
            fileXmlRoot.descendantElements
                .firstWhereOrNull((e) => e.getAttribute('name') == 'generator')
                ?.remove();
            final renderedHead = renderedXmlDoc.descendantElements
                .firstWhere((e) => e.localName == 'head');
            renderedHead.childElements
                .firstWhereOrNull((e) => e.getAttribute('content') == 'noindex')
                ?.remove();
            expect(renderedHead.children, hasLength(7));
            for (final c in [...renderedHead.childElements]) {
              c.remove();
            }

            // removing extra <noscript>
            final firstNoScript = renderedXmlDoc.descendantElements
                .firstWhere((e) => e.localName == 'noscript');
            expect(firstNoScript.toXmlString(),
                contains('https://www.googletagmanager.com/'));
            firstNoScript.remove();

            // removing extra logo
            final firstLogo = renderedXmlDoc.descendantElements.firstWhere(
                (e) =>
                    e.localName == 'img' &&
                    (e.getAttribute('src') ?? '').endsWith('/dart-logo.svg'));
            (firstLogo.parent as XmlElement).remove();

            // removing .self-name
            final fileFirstName = fileXmlRoot.descendantElements
                .firstWhereOrNull((e) =>
                    e.localName == 'div' &&
                    e.getAttribute('class') == 'self-name');
            if (fileFirstName != null) {
              fileFirstName.remove();
              renderedXmlDoc.descendantElements
                  .firstWhere((e) =>
                      e.localName == 'div' &&
                      e.getAttribute('class') == 'self-name')
                  .remove();
            }

            // removing breadcrumbs two times
            for (var i = 0; i < 2; i++) {
              final fileFirstBreadcrumbs = fileXmlRoot.descendantElements
                  .firstWhere((e) =>
                      e.localName == 'ol' &&
                      (e.getAttribute('class') ?? '')
                          .startsWith('breadcrumbs '));
              expect(fileFirstBreadcrumbs.childElements, hasLength(1));
              final renderedFirstBreadcrumbs = renderedXmlDoc.descendantElements
                  .firstWhere((e) =>
                      e.localName == 'ol' &&
                      (e.getAttribute('class') ?? '')
                          .startsWith('breadcrumbs '));
              expect(renderedFirstBreadcrumbs.childElements, hasLength(2));
              fileFirstBreadcrumbs.remove();
              renderedFirstBreadcrumbs.remove();
            }

            // removing unconditional placeholder
            renderedXmlDoc.descendantElements
                .firstWhere((e) =>
                    e.localName == 'div' &&
                    e.getAttribute('id') == 'dartdoc-sidebar-left-content')
                .remove();

            // main content section -> div
            final fileMainContentDiv = fileXmlRoot.descendantElements
                .firstWhere(
                    (e) => e.getAttribute('id') == 'dartdoc-main-content');
            for (final c in [...fileMainContentDiv.childElements]) {
              // add extra class
              if (c.getAttribute('class') == 'desc markdown') {
                c.setAttribute('class', 'desc markdown markdown-body');
              }
              // remove search form
              c.descendantElements
                  .firstWhereOrNull((e) => e.localName == 'form')
                  ?.remove();
              // replace node with <div> clone
              c.replace(c.renameAndClone('div'));
            }

            // final cleanup
            _removeSharedXmlNodes(fileXmlRoot, renderedXmlDoc);

            expect(
              renderedXmlDoc.rootElement
                  .toXmlString(pretty: true, indent: '  ')
                  .replaceFirst('<html lang="en"/>', '<html lang="en"></html>'),
              fileXmlRoot.toXmlString(pretty: true, indent: '  '),
            );
          }
        }
        expect(processedFiles, {
          'oxygen/Oxygen-class.html',
          'oxygen/oxygen-library.html',
          'oxygen/multiply.html',
          'oxygen/Oxygen/x.html',
          'oxygen/Oxygen/Oxygen.html',
          'index.html',
          '__404error.html',
        });
      },
      timeout: Timeout.factor(4),
    );
  });
}

final _sources = {
  'pubspec.yaml': '''name: oxygen
version: 1.0.0
environment:
  sdk: ^3.1.0
''',
  'lib/oxygen.dart': '''
class Oxygen {
  /// awesome x
  void x() {}
}

int multiply(int a, int b) => a*b;
''',
};

XmlElement _toXml(Element node) {
  final xn = XmlElement(XmlName(node.localName!));
  node.attributes.forEach((k, v) {
    xn.attributes.add(XmlAttribute(XmlName(k.toString()), v));
  });
  node.nodes.forEach((child) {
    if (child is Element) {
      xn.children.add(_toXml(child));
    } else if (child is Text) {
      xn.children.add(XmlText(child.text));
    } else if (child is Comment) {
      xn.children.add(XmlComment(child.text!));
    } else {
      throw Exception('Unhandled HTML node: $child');
    }
  });
  return xn;
}

void _removeSharedXmlNodes(XmlElement a, XmlDocument b) {
  void visitA(XmlElement ae) {
    for (final child in [...ae.childElements]) {
      visitA(child);
    }

    if (!ae.hasParent) {
      return;
    }
    final apath = ae.path();
    final firstMatch = b
        .findAllElements(ae.name.local)
        .where((be) => be.path() == apath)
        .firstWhereOrNull(
            (be) => ae.equalsAsSimpleElement(be) || ae.equalsAsString(be));
    if (firstMatch != null) {
      ae.remove();
      firstMatch.remove();
      return;
    }
  }

  visitA(a);
}

extension on XmlElement {
  String path() {
    final idValue = getAttribute('id');
    final localSegment = idValue == null ? localName : '#$idValue';
    return [
      if (parent is XmlElement) (parent as XmlElement).path(),
      localSegment,
    ].join('/');
  }

  bool equalsAsSimpleElement(XmlElement other) {
    if (localName != other.localName) {
      return false;
    }
    if (childElements.isNotEmpty || other.childElements.isNotEmpty) {
      return false;
    }
    if (innerText.trim() != other.innerText.trim()) {
      return false;
    }
    final attributeKeys = {
      ...attributes.map((a) => a.localName),
      ...other.attributes.map((a) => a.localName),
    };
    for (final key in attributeKeys) {
      if ((getAttribute(key) ?? '') != (other.getAttribute(key) ?? '')) {
        return false;
      }
    }
    return true;
  }

  bool equalsAsString(XmlElement other) =>
      toXmlString(pretty: true, indent: '  ') ==
      other.toXmlString(pretty: true, indent: '  ');

  XmlElement renameAndClone(String newName) {
    return XmlElement(
      XmlName(newName),
      attributes.map((n) => n.copy()),
      children.map((n) => n.copy()),
      isSelfClosing,
    );
  }
}
