// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:xml/xml.dart';

import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('feeds', () {
    testWithProfile('/feed.atom', fn: () async {
      final content = await expectAtomXmlResponse(await issueGet('/feed.atom'));

      // check if content is valid XML
      final root = XmlDocument.parse(content);
      final feed = root.rootElement;

      final entries = feed.findElements('entry').toList();
      expect(entries.length, 3);
      expect(entries.map((e) => e.findElements('title').first.text).toList(), [
        'v1.2.0 of oxygen',
        'v1.10.0 of flutter_titanium',
        'v1.0.0 of neon',
      ]);

      final oxygenExpr = RegExp('<entry>\n'
          '          <id>urn:uuid:a6a43bff-e1ef-4633-b5ee-e0516b655be9</id>\n'
          '          <title>v1.2.0 of oxygen</title>\n'
          '          <updated>(.*)</updated>\n'
          '          \n'
          '          <content type="html">&lt;h1>oxygen&lt;/h1>\n'
          '&lt;p>Awesome package.&lt;/p>\n'
          '</content>\n'
          '          <link href="https://pub.dev/packages/oxygen" rel="alternate" title="oxygen"/>\n'
          '        </entry>');
      expect(oxygenExpr.hasMatch(entries[0].toXmlString(indent: '  ')), isTrue);

      final neonExpr = RegExp('<entry>\n'
          '          <id>urn:uuid:5f920595-c067-404a-bb19-2b0918372eb6</id>\n'
          '          <title>v1.0.0 of neon</title>\n'
          '          <updated>(.*)</updated>\n'
          '          \n'
          '          <content type="html">&lt;h1>neon&lt;/h1>\n'
          '&lt;p>Awesome package.&lt;/p>\n'
          '</content>\n'
          '          <link href="https://pub.dev/packages/neon" rel="alternate" title="neon"/>\n'
          '        </entry>');
      expect(neonExpr.hasMatch(entries[2].toXmlString(indent: '  ')), isTrue);

      entries.forEach((e) => e.parent!.children.remove(e));

      final restExp = RegExp('<feed xmlns="http://www.w3.org/2005/Atom">\n'
          '        <id>https://pub.dev/feed.atom</id>\n'
          '        <title>Pub Packages for Dart</title>\n'
          '        <updated>(.*)</updated>\n'
          '        <author>\n'
          '          <name>Dart Team</name>\n'
          '        </author>\n'
          '        <link href="https://pub.dev/" rel="alternate"/>\n'
          '        <link href="https://pub.dev/feed.atom" rel="self"/>\n'
          '        <generator version="0.1.0">Pub Feed Generator</generator>\n'
          '        <subtitle>Last Updated Packages</subtitle>\n'
          '(\\s*)'
          '</feed>');
      expect(restExp.hasMatch(feed.toXmlString(indent: '  ')), isTrue);
    });
  });
}
