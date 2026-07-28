HTML Sanitizer for Dart
=======================

When embedding HTML from untrusted source in a website it is important to
sanitize the HTML to prevent injection of untrusted JavaScript (XSS exploits).
This package provides a simple function sanitizing HTML to prevent XSS exploits
and limit interference with other elements on the page.

**Disclaimer:** This is not an officially supported Google product.

This package uses an HTML5 parser to build-up an in-memory DOM tree and
filter elements and attributes, in-line with [rules employed by GitHub][1]
when sanitizing GFM (GitHub Flavored Markdown).

This removes all inline JavaScript, CSS, `<form>`, and other elements that
could be used for XSS. This sanitizer is more strict than necessary to
guard against XSS as this sanitizer also attempts to prevent the sanitized
HTML from interfering with the page it is injected into.

For example, while it is possible to allow many CSS properties, this
sanitizer does not allow any CSS. This creates a sanitizer that is easy to
validate. These limitations are usually fine when sanitizing HTML from rendered
markdown.

[1]: https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/sanitization_filter.rb

## Example

```dart
import 'package:sanitize_html/sanitize_html.dart' show sanitizeHtml;

void main() {
  print(sanitizeHtml('<a href="javascript:alert();">evil link</a>'));
  // Prints: <a>evil link</a>
  // Which is a lot less evil :)
}
```


