// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../service/topics/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

/// Renders the topics list node of /topics page.
d.Node renderTopicsList(Map<String, int> topics) {
  final sortedTopics = topics.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return d.div(classes: [
    'topics-page'
  ], children: [
    d.h1(text: 'Topics '),
    ...sortedTopics.map((e) => _topic(e.key, e.value)),
  ]);
}

d.Node _topic(String name, int count) {
  final ct = canonicalTopics.asMap[name];
  final description = ct?.description;
  return d.div(
    classes: ['topic-item'],
    children: [
      d.h3(
        classes: ['topic-title'],
        children: [
          d.a(
            text: '#$name',
            href: urls.searchUrl(q: 'topic:$name'),
            rel: 'nofollow',
          ),
          d.span(
              classes: ['topic-metadata'],
              text: '$count ${count == 1 ? 'package' : 'packages'}')
        ],
      ),
      if (description != null)
        d.p(classes: ['topic-description'], text: description),
    ],
  );
}
