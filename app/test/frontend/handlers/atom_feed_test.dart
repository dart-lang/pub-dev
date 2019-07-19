// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('feeds', () {
    testWithServices('/feed.atom', () async {
      await expectAtomXmlResponse(await issueGet('/feed.atom'), regexp: '''
<\\?xml version="1.0" encoding="UTF-8"\\?>
<feed xmlns="http://www.w3.org/2005/Atom">
        <id>https://pub.dev/feed.atom</id>
        <title>Pub Packages for Dart</title>
        <updated>(.*)</updated>
        <author>
          <name>Dart Team</name>
        </author>
        <link href="https://pub.dev/" rel="alternate" />
        <link href="https://pub.dev/feed.atom" rel="self" />
        <generator version="0.1.0">Pub Feed Generator</generator>
        <subtitle>Last Updated Packages</subtitle>
(\\s*)
        <entry>
          <id>urn:uuid:ebaa25c2-6b0c-5829-a686-dc55c2bbd8e4</id>
          <title>v0.1.1\\+5 of foobar_pkg</title>
          <updated>${testPackageVersion.created.toIso8601String()}</updated>
          <author><name>Hans Juergen &lt;hans@juergen.com&gt;</name></author>
          <content type="html">&lt;h1&gt;Test Package&lt;&#47;h1&gt;
&lt;p&gt;This is a readme file.&lt;&#47;p&gt;
&lt;pre&gt;&lt;code class=&quot;language-dart&quot;&gt;void main\\(\\) {
}
&lt;&#47;code&gt;&lt;&#47;pre&gt;
</content>
          <link href="https://pub.dev/packages/foobar_pkg"
                rel="alternate"
                title="foobar_pkg" />
        </entry>
(\\s*)
</feed>
''');
    });
  });
}
