// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:xml/xml.dart';

import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('feeds', () {
    testWithServices('/feed.atom', () async {
      final content = await expectAtomXmlResponse(await issueGet('/feed.atom'));

      // check if content is valid XML
      final root = parse(content);
      final feed = root.rootElement;

      final entries = feed.findElements('entry').toList();
      expect(entries.length, 4);
      expect(entries.map((e) => e.findElements('title').first.text).toList(), [
        'v0.1.1+5 of foobar_pkg',
        'v5.8.6 of lithium',
        'v2.0.5 of helium',
        'v2.0.8 of hydrogen',
      ]);

      expect(
          entries[0].toXmlString(indent: '  '),
          '<entry>\n'
          '          <id>urn:uuid:12c30db4-f5d7-4757-939d-02c81b9e299e</id>\n'
          '          <title>v0.1.1+5 of foobar_pkg</title>\n'
          '          <updated>2014-01-01T00:00:00.000Z</updated>\n'
          '          \n'
          '          <content type="html">&lt;h1>Test Package&lt;/h1>\n'
          '&lt;p>This is a readme file.&lt;/p>\n'
          '&lt;pre>&lt;code class="language-dart">void main() {\n'
          '}\n'
          '&lt;/code>&lt;/pre>\n'
          '</content>\n'
          '          <link href="https://pub.dev/packages/foobar_pkg" rel="alternate" title="foobar_pkg"/>\n'
          '        </entry>');

      expect(
          entries[3].toXmlString(indent: '  '),
          '<entry>\n'
          '          <id>urn:uuid:41c3131f-9d96-445e-9a55-756a6dd33d79</id>\n'
          '          <title>v2.0.8 of hydrogen</title>\n'
          '          <updated>2014-02-08T17:30:00.000</updated>\n'
          '          \n'
          '          <content type="html">&lt;h1>hydrogen&lt;/h1>\n'
          '&lt;p>hydrogen is a Dart package&lt;/p>\n'
          '</content>\n'
          '          <link href="https://pub.dev/packages/hydrogen" rel="alternate" title="hydrogen"/>\n'
          '        </entry>');

      entries.forEach((e) => e.parent.children.remove(e));

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
