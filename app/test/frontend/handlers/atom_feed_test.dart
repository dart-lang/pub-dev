// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/configuration.dart';
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
      expect(entries.length, 6);
      expect(
          entries.map((e) => e.findElements('title').first.innerText).toList(),
          [
            'v2.0.0-dev of oxygen',
            'v1.2.0 of oxygen',
            'v1.0.0 of oxygen',
            'v1.10.0 of flutter_titanium',
            'v1.0.0 of neon',
            'v1.9.0 of flutter_titanium',
          ]);

      final oxygenExpr = RegExp('<entry>\n'
          '  <id>urn:uuid:a6a43bff-e1ef-4633-b5ee-e0516b655be9</id>\n'
          '  <title>v1.2.0 of oxygen</title>\n'
          '  <updated>(.*)</updated>\n'
          '  <content>oxygen is awesome</content>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/packages/oxygen" rel="alternate" title="oxygen"/>\n'
          '</entry>');
      expect(
        oxygenExpr.hasMatch(entries[1].toXmlString(pretty: true, indent: '  ')),
        isTrue,
        reason: entries[1].toXmlString(),
      );

      final neonExpr = RegExp('<entry>\n'
          '  <id>urn:uuid:5f920595-c067-404a-bb19-2b0918372eb6</id>\n'
          '  <title>v1.0.0 of neon</title>\n'
          '  <updated>(.*)</updated>\n'
          '  <content>neon is awesome</content>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/packages/neon" rel="alternate" title="neon"/>\n'
          '</entry>');
      expect(
        neonExpr.hasMatch(entries[4].toXmlString(pretty: true, indent: '  ')),
        isTrue,
        reason: entries[4].toXmlString(),
      );

      entries.forEach((e) => e.parent!.children.remove(e));

      final restExp = RegExp('<feed xmlns="http://www.w3.org/2005/Atom">\n'
          '  <id>${activeConfiguration.primarySiteUri}/feed.atom</id>\n'
          '  <title>Pub Packages for Dart</title>\n'
          '  <updated>(.*)</updated>\n'
          '  <author>\n'
          '    <name>Dart Team</name>\n'
          '  </author>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/" rel="alternate"/>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/feed.atom" rel="self"/>\n'
          '  <generator version="0.1.0">Pub Feed Generator</generator>\n'
          '  <subtitle>Last Updated Packages</subtitle>\n'
          '(\\s*)'
          '</feed>');
      expect(
        restExp.hasMatch(feed.toXmlString(pretty: true, indent: '  ')),
        isTrue,
        reason: feed.toXmlString(),
      );
    });
  });
}
