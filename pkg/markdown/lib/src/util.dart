library markdown.util;

/// Replaces `<`, `&`, and `>`, with their HTML entity equivalents.
String escapeHtml(String html) {
  if (html == '' || html == null) return null;
  return html
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}

/// Removes null or empty values from [map].
void cleanMap(Map map) {
  map.keys.where((e) => isNullOrEmpty(map[e])).toList().forEach(map.remove);
}

/// Returns true if an object is null or an empty string.
bool isNullOrEmpty(object) {
  return object == null || object == '';
}
