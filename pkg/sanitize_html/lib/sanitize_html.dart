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

import 'src/sane_html_validator.dart' show SaneHtmlValidator;

/// Sanitize [htmlString] to prevent XSS exploits and limit interference with
/// other markup on the page.
///
/// This function uses the HTML5 parser to build-up an in-memory DOM tree and
/// filter elements and attributes, in-line with [rules employed by Github][1]
/// when sanitizing GFM (Github Flavored Markdown).
///
/// This removes all inline Javascript, CSS, `<form>`, and other elements that
/// could be used for XSS. This sanitizer is more strict than necessary to
/// guard against XSS as this sanitizer also attempts to prevent the sanitized
/// HTML from interfering with the page it is injected into.
///
/// The optional [allowElements] callback will be called with uppercase tag names.
///
/// For example, while it is possible to allow many CSS properties, this
/// sanitizer does not allow any CSS. This creates a sanitizer that is easy to
/// validate and is usually fine when sanitizing HTML from rendered markdown.
/// The `allowElementId` and `allowClassName` options can be used to allow
/// specific element ids and class names through, otherwise `id` and `class`
/// attributes will be removed.
///
/// **Example**
/// ```dart
/// import 'package:sanitize_html/sanitize_html.dart' show sanitizeHtml;
///
/// void main() {
///   print(sanitizeHtml('<a href="javascript:alert();">evil link</a>'));
///   // Prints: <a>evil link</a>
///   // Which is a lot less evil :)
/// }
/// ```
///
/// It is furthermore possible to use the [addLinkRel] to attach a `rel="..."`
/// property to links (`<a href="..."`). When hosting user-generated content it
/// can be useful to [qualify outbound links][2] with `rel="ugc"`, as this lets
/// search engines know that the content is user-generated.
///
/// **Example**
/// ```dart
/// import 'package:sanitize_html/sanitize_html.dart' show sanitizeHtml;
///
/// void main() {
///   print(sanitizeHtml(
///     '<a href="https://spam.com/free-stuff">free stuff</a>',
///     addLinkRel: (href) => ['ugc', 'nofollow'],
///   ));
///   // Prints: <a href="https://spam.com/free-stuff" rel="ugc nofollow">free stuff</a>
///   // Might mitigate negative impact of hosting spam links with search engines.
/// }
/// ```
///
/// For more information on why to qualify outbound links,
/// see also [Ways to Prevent Comment Spam][3].
///
/// [1]: https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb
/// [2]: https://support.google.com/webmasters/answer/96569
/// [3]: https://support.google.com/webmasters/answer/81749
String sanitizeHtml(
  String htmlString, {
  bool Function(String)? allowElements,
  bool Function(String)? allowElementId,
  bool Function(String)? allowClassName,
  Iterable<String>? Function(String)? addLinkRel,
}) {
  return SaneHtmlValidator(
    allowElements: allowElements,
    allowElementId: allowElementId,
    allowClassName: allowClassName,
    addLinkRel: addLinkRel,
  ).sanitize(htmlString);
}
