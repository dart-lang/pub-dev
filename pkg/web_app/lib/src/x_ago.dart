import 'dart:html';

import 'package:_pub_shared/format/x_ago_format.dart';

void setupXAgo() {
  document.querySelectorAll('a.-x-ago').forEach((e) {
    final DateTime actual = DateTime.parse(e.getAttribute('data-timestamp')!);
    e.text = formatXAgo(DateTime.now().toUtc().difference(actual));
    e.onClick.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      final text = e.text;
      e.text = e.getAttribute('title');
      e.setAttribute('title', text!);
    });
  });
}
