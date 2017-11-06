import 'dart:convert';

/// Replaces `<`, `&`, and `>`, with their HTML entity equivalents.
@Deprecated('Use `const HtmlEscape(HtmlEscapeMode.ELEMENT).convert` from '
    '`dart:convert` instead.')
String escapeHtml(String html) => escapeHtmlImpl(html);

String escapeHtmlImpl(String html) =>
    const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(html);
