// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';

import '../../shared/utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

void tScopedTest(String name, Future func()) {
  scopedTest(name, () {
    return func();
  });
}

void main() {
  final pageSize = 10;

  group('feeds', () {
    tScopedTest('/feed.atom', () async {
      final backend =
          new BackendMock(latestPackageVersionsFun: ({offset, limit}) {
        expect(offset, 0);
        expect(limit, pageSize);
        return [testPackageVersion];
      });
      registerBackend(backend);
      await expectAtomXmlResponse(await issueGet('/feed.atom'), regexp: '''
<\\?xml version="1.0" encoding="UTF-8"\\?>
<feed xmlns="http://www.w3.org/2005/Atom">
        <id>https://pub.dartlang.org/feed.atom</id>
        <title>Pub Packages for Dart</title>
        <updated>(.*)</updated>
        <author>
          <name>Dart Team</name>
        </author>
        <link href="https://pub.dartlang.org/" rel="alternate" />
        <link href="https://pub.dartlang.org/feed.atom" rel="self" />
        <generator version="0.1.0">Pub Feed Generator</generator>
        <subtitle>Last Updated Packages</subtitle>
(\\s*)
        <entry>
          <id>urn:uuid:d4fe7eb8-fc0e-5515-a5e5-5868b339d660</id>
          <title>v0.1.1\\+5 of foobar_pkg</title>
          <updated>${testPackageVersion.created.toIso8601String()}</updated>
          <author><name>Hans Juergen &lt;hans@juergen.com&gt;</name></author>
          <content type="html">&lt;h1&gt;Test Package&lt;&#47;h1&gt;
&lt;p&gt;This is a readme file.&lt;&#47;p&gt;
&lt;pre&gt;&lt;code class=&quot;language-dart&quot;&gt;void main\\(\\) {
}
&lt;&#47;code&gt;&lt;&#47;pre&gt;
</content>
          <link href="https://pub.dartlang.org/packages/foobar_pkg"
                rel="alternate"
                title="foobar_pkg" />
        </entry>
(\\s*)
</feed>
''');
    });
  });
}
