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
          // Note: pretty format + indenting converts the newlines into spaces.
          '  <content>oxygen is awesome Changelog excerpt: - updated</content>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/packages/oxygen" rel="alternate" title="oxygen"/>\n'
          '</entry>');
      expect(
        oxygenExpr.hasMatch(entries[1].toXmlString(pretty: true, indent: '  ')),
        isTrue,
        reason: entries[1].toXmlString(pretty: true, indent: '  '),
      );

      final neonExpr = RegExp('<entry>\n'
          '  <id>urn:uuid:5f920595-c067-404a-bb19-2b0918372eb6</id>\n'
          '  <title>v1.0.0 of neon</title>\n'
          '  <updated>(.*)</updated>\n'
          // Note: pretty format + indenting converts the newlines into spaces.
          '  <content>neon is awesome Changelog excerpt: - updated</content>\n'
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
          '  <title>Recently published packages on pub.dev</title>\n'
          '  <updated>(.*)</updated>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/" rel="alternate"/>\n'
          '  <link href="${activeConfiguration.primarySiteUri}/feed.atom" rel="self"/>\n'
          '  <generator version="0.1.0">Pub Feed Generator</generator>\n'
          '(\\s*)'
          '</feed>');
      expect(
        restExp.hasMatch(feed.toXmlString(pretty: true, indent: '  ')),
        isTrue,
        reason: feed.toXmlString(),
      );
    });
  });

  testWithProfile('/api/packages/<package>/feed.atom', fn: () async {
    final content = await expectAtomXmlResponse(
        await issueGet('/api/packages/oxygen/feed.atom'));
    // check if content is valid XML
    final root = XmlDocument.parse(content);
    final feed = root.rootElement;

    final entries = feed.findElements('entry').toList();
    expect(entries.length, 3);
    expect(
        entries.map((e) => e.findElements('title').first.innerText).toList(), [
      'v2.0.0-dev of oxygen',
      'v1.2.0 of oxygen',
      'v1.0.0 of oxygen',
    ]);

    final oxygenExpr = RegExp('<entry>\n'
        '  <id>urn:uuid:3f5765a8-8fb3-4b6c-83fe-774a73dce135</id>\n'
        '  <title>v2.0.0-dev of oxygen</title>\n'
        '  <updated>(.*)</updated>\n'
        '  <content>2.0.0-dev was published on (.*)</content>\n'
        '  <link href="${activeConfiguration.primarySiteUri}/packages/oxygen/versions/2.0.0-dev" rel="alternate" title="2.0.0-dev"/>\n'
        '</entry>');
    expect(
      oxygenExpr
          .hasMatch(entries.first.toXmlString(pretty: true, indent: '  ')),
      isTrue,
      reason: entries.first.toXmlString(),
    );

    entries.forEach((e) => e.parent!.children.remove(e));

    final restExp = RegExp('<feed xmlns="http://www.w3.org/2005/Atom">\n'
        '  <id>${activeConfiguration.primarySiteUri}/api/packages/oxygen/feed.atom</id>\n'
        '  <title>Recently published versions of package oxygen on pub.dev</title>\n'
        '  <updated>(.*)</updated>\n'
        '  <link href="${activeConfiguration.primarySiteUri}/packages/oxygen" rel="alternate"/>\n'
        '  <link href="${activeConfiguration.primarySiteUri}/api/packages/oxygen/feed.atom" rel="self"/>\n'
        '  <generator version="0.1.0">Pub Feed Generator</generator>\n'
        '  <subtitle>oxygen is awesome</subtitle>\n'
        '(\\s*)'
        '</feed>');
    expect(
      restExp.hasMatch(feed.toXmlString(pretty: true, indent: '  ')),
      isTrue,
      reason: feed.toXmlString(),
    );
  });
}
