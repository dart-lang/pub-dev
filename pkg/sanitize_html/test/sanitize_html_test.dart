// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:test/test.dart';
import 'package:sanitize_html/sanitize_html.dart' show sanitizeHtml;

void main() {
  // Calls sanitizeHtml with two different configurations.
  //  * When `withOptionalConfiguration` is `true`: `allowElementId`, `allowClassName`
  // and `addLinkRel` overrides are passed to the sanitizeHtml call of `template`.
  // (This is the default behavior for the [testContains]/[testNotContains] methods.)
  //  * When `withOptionalConfiguration` is false: only `template` is passed.
  String doSanitizeHtml(String template,
      {required bool withOptionalConfiguration}) {
    if (!withOptionalConfiguration) {
      return sanitizeHtml(template);
    }

    return sanitizeHtml(
      template,
      allowElements: (tagName) => tagName == 'ONLY-ALLOWED-TAG',
      allowElementId: (id) => id == 'only-allowed-id',
      allowClassName: (className) => className == 'only-allowed-class',
      addLinkRel: (href) => href == 'bad-link' ? ['ugc', 'nofollow'] : null,
    );
  }

  void testContains(String template, String needle,
      {bool withOptionalConfiguration = true}) {
    test('"$template" does contain "$needle"', () {
      final sanitizedHtml = doSanitizeHtml(
        template,
        withOptionalConfiguration: withOptionalConfiguration,
      );
      expect(sanitizedHtml, contains(needle));
    });
  }

  void testNotContains(String template, String needle,
      {bool withOptionalConfiguration = true}) {
    test('"$template" does not contain "$needle"', () {
      final sanitizedHtml = doSanitizeHtml(
        template,
        withOptionalConfiguration: withOptionalConfiguration,
      );
      expect(sanitizedHtml, isNot(contains(needle)));
    });
  }

  testNotContains('test', '<br>');
  testContains('test', 'test');
  testContains('a < b', '&lt;');
  testContains('a < b > c', '&gt;');
  testContains('<p>hello', 'hello');
  testContains('<p>hello', '</p>');
  testContains('<p>hello', '<p>');

  // test tag name filtering
  testContains(
      '<only-allowed-tag>hello</only-allowed-tag>', '<only-allowed-tag>');
  testContains('<only-allowed-tag>hello</only-allowed-tag>', 'hello');
  testNotContains('<disallowed-tag>hello</disallowed-tag>', 'disallowed-tag');
  testNotContains('<disallowed-tag>hello</disallowed-tag>', 'hello');

  // test id filtering..
  testContains('<span id="only-allowed-id">hello</span>', 'id');
  testContains('<span id="only-allowed-id">hello</span>', 'only-allowed-id');
  testNotContains('<span id="disallowed-id">hello</span>', 'id');
  testNotContains('<span id="disallowed-id">hello</span>', 'only-allowed-id');

  // test class filtering
  testContains('<span class="only-allowed-class">hello</span>', 'class');
  testContains(
      '<span class="only-allowed-class">hello</span>', 'only-allowed-class');
  testContains('<span class="only-allowed-class disallowed-class">hello</span>',
      'class="only-allowed-class"');
  testNotContains('<span class="disallowed-class">hello</span>', 'class');
  testNotContains(
      '<span class="disallowed-class">hello</span>', 'only-allowed-class');

  testContains('<a href="test.html">hello', 'href');
  testContains('<a href="test.html">hello', 'test.html');
  testContains(
      '<a href="//example.com/test.html">hello', '//example.com/test.html');
  testContains('<a href="/test.html">hello', '/test.html');
  testContains('<a href="https://example.com/test.html">hello',
      'https://example.com/test.html');
  testContains('<a href="http://example.com/test.html">hello',
      'http://example.com/test.html');
  testContains(
      '<a href="mailto:test@example.com">hello', 'mailto:test@example.com');

  testContains('<img src="test.jpg"/>', '<img');
  testContains('<img src="test.jpg" alt="say hi"/>', 'say hi');
  testContains('<img src="test.jpg" alt="say hi"/>', 'alt=');
  testContains('<img src="test.jpg" ALt="say hi"/>', 'say hi');
  testContains('<img src="test.jpg" ALT="say hi"/>', 'alt=');
  testContains('<img src="test.jpg"/>', 'src=');
  testContains('<img src="test.jpg"/>', 'test.jpg');
  testContains('<img src="//test.jpg"/>', '//test.jpg');
  testContains('<img src="/test.jpg"/>', '/test.jpg');
  testContains('<img src="https://example.com/test.jpg"/>',
      'https://example.com/test.jpg');
  testContains('<img src="http://example.com/test.jpg"/>',
      'http://example.com/test.jpg');

  testNotContains('<img src="javascript:test.jpg"/>', 'src=');
  testNotContains('<img src="javascript:test.jpg"/>', 'javascript');
  testContains('<img src="javascript:test.jpg"/>', 'img');

  // <picture> and <source> survive sanitization, including the fallback <img>.
  // A bad URL in srcset drops only the attribute, not the element.
  testContains('<picture><img src="banner.webp"/></picture>', '<picture>');
  testContains('<picture><img src="banner.webp"/></picture>', '<img');
  testContains(
      '<picture><source srcset="dark.webp"><img src="light.webp"/></picture>',
      '<source');
  testContains('<source srcset="banner.webp">', 'srcset');
  testContains('<source srcset="banner.webp">', 'banner.webp');
  testContains(
      '<source media="(prefers-color-scheme: dark)" srcset="dark.webp">',
      'media=');
  testContains('<source srcset="a.webp 1x, b.webp 2x">', 'b.webp 2x');
  testContains('<source srcset="/img/banner.webp">', '/img/banner.webp');
  testContains('<source srcset="https://example.com/b.webp">',
      'https://example.com/b.webp');
  testNotContains('<source srcset="javascript:alert()">', 'srcset');
  testNotContains('<source srcset="javascript:alert()">', 'javascript');
  testContains('<source srcset="javascript:alert()">', '<source');
  testNotContains('<source srcset="ok.webp, javascript:alert()">', 'srcset');
  testNotContains(
      '<source srcset="ok.webp, javascript:alert()">', 'javascript');

  // A descriptor must be a width (`640w`) or density (`1.5x`); nothing else.
  testContains('<source srcset="a.webp 640w">', '640w');
  testContains('<source srcset="a.webp 1.5x">', '1.5x');
  testNotContains('<source srcset="a.webp totally-bogus">', 'srcset');
  testNotContains('<source srcset="a.webp totally-bogus">', 'totally-bogus');
  testContains('<source srcset="a.webp totally-bogus">', '<source');
  testNotContains('<source srcset="a.webp 1x 2x">', 'srcset');
  testNotContains('<source srcset="a.webp 1x, b.webp bogus">', 'srcset');

  testNotContains('<script/>', 'script');
  testNotContains('<script src="example.js"/>', 'script');
  testNotContains('<script src="example.js"/>', 'src');
  testContains('<script>alert("bad")</script> hello world', 'hello world');
  testNotContains('<script>alert("bad")</script> hello world', 'bad');
  testContains('<a href="javascript:alert()">evil link</a>', '<a');
  testNotContains('<a href="javascript:alert()">evil link</a>', 'href');
  testNotContains('<a href="javascript:alert()">evil link</a>', 'alert');
  testNotContains('<a href="javascript:alert()">evil link</a>', 'javascript');

  testNotContains('<form><input type="submit"/></form> click here', 'form');
  testNotContains('<form><input type="submit"/></form> click here', 'submit');
  testNotContains('<form><input type="submit"/></form> click here', 'input');
  testContains('<form><input type="submit"/></form> click here', 'click here');

  testContains('<br>', '<br>');
  testNotContains('<br>', '</br>');
  testNotContains('<br>', '</ br>');
  testContains('><', '&gt;&lt;');
  testContains('<div><div id="x">a</div></div>', '<div><div>a</div></div>');
  testContains('<a href="a.html">a</a><a href="b.html">b</a>',
      '<a href="a.html">a</a><a href="b.html">b</a>');

  // test void elements
  testContains('<strong></strong> hello', '<strong>');
  testContains('<strong></strong> hello', '</strong>');
  testNotContains('<strong></strong> hello', '<strong />');
  testContains('<br>hello</br>', '<br>');
  testNotContains('<br>hello</br>', '</br>');
  testNotContains('<br>hello</br>', '</ br>');

  // test addLinkRel
  testContains('<a href="bad-link">hello', 'bad-link');
  testContains('<a href="bad-link">hello', 'rel="ugc nofollow"');
  testNotContains('<a href="good-link">hello', 'rel="ugc nofollow"');

  group('Optional parameters stay optional:', () {
    // If any of these fail, it probably means a major version bump is required.
    testContains('<a href="any-href">hey', 'href=',
        withOptionalConfiguration: false);
    testNotContains('<a href="any-href">hey', 'rel=',
        withOptionalConfiguration: false);
    testNotContains('<any-tag>hello</any-tag>', 'hello',
        withOptionalConfiguration: false);
    testNotContains('<span id="any-id">hello</span>', 'id=',
        withOptionalConfiguration: false);
    testNotContains('<span class="any-class">hello</span>', 'class=',
        withOptionalConfiguration: false);
  });
}
