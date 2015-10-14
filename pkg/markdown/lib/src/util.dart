library markdown.src.util;

/// Replaces `<`, `&`, and `>`, with their HTML entity equivalents.
String escapeHtml(String html) {
  return html
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}
