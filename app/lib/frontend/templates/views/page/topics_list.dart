// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;

import '../../../dom/dom.dart' as d;

d.Node renderTopicsList(Map<String, int> topics) {
  return d.div(children: [
    d.h1(text: 'Topics '),
    topicsListNode(topics),
  ]);
}

/// Renders the package list node of /topics page.
d.Node topicsListNode(Map<String, int> topics) {
  final sortedTopics = topics.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return d.div(
      classes: ['packages', '-compact'],
      children: sortedTopics.map((e) => d.div(
            classes: ['packages-item'],
            children: [
              d.h3(
                classes: ['packages-title'],
                children: [
                  d.a(
                      text: '#${e.key}',
                      href: urls.searchUrl(q: 'topic:${e.key}')),
                  d.span(
                      classes: ['topics-metadata'],
                      text:
                          '${e.value} ${e.value == 1 ? 'package' : 'packages'}')
                ],
              )
            ],
          )));
}
