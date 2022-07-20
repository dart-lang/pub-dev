// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

class SimpleTag {
  final String status;
  final String text;
  final String title;
  final String? href;

  bool get hasHref => href != null;

  SimpleTag({
    required this.status,
    required this.text,
    required this.title,
    this.href,
  });

  factory SimpleTag.discontinued() {
    return SimpleTag(
      status: 'discontinued',
      text: 'discontinued',
      title: 'Package was discontinued.',
    );
  }

  factory SimpleTag.retracted() {
    return SimpleTag(
      status: 'retracted',
      text: 'retracted',
      title: 'This version was retracted.',
    );
  }

  factory SimpleTag.unlisted() {
    return SimpleTag(
      status: 'unlisted',
      text: 'unlisted',
      title: 'Package is unlisted, this means that while the package is still '
          'publicly available the author has decided that it should not appear '
          'in search results with default search filters. This is typically '
          'done because this package is meant to support another package, '
          'rather than being consumed directly.',
    );
  }

  factory SimpleTag.obsolete() {
    return SimpleTag(
      status: 'missing',
      text: 'outdated',
      title: 'Package version too old, check latest stable.',
    );
  }

  factory SimpleTag.legacy() {
    return SimpleTag(
      status: 'legacy',
      text: 'Dart 2 incompatible',
      title: 'Package does not support Dart 2.',
    );
  }

  factory SimpleTag.pending() {
    return SimpleTag(
      status: 'missing',
      text: '[pending analysis]',
      title:
          "This version was scheduled for analysis, but it hasn't completed yet.",
    );
  }

  factory SimpleTag.unidentified({String? href}) {
    return SimpleTag(
      status: 'unidentified',
      text: '[unknown platforms]',
      title: 'Check the Platforms section of the scores tab for details.',
      href: href,
    );
  }
}

class BadgeTag {
  final String text;
  final String? title;
  final String? href;
  final List<BadgeSubTag> subTags;

  BadgeTag({
    required this.text,
    this.title,
    this.href,
    required this.subTags,
  });
}

class BadgeSubTag {
  final String text;
  final String title;
  final String href;

  BadgeSubTag({
    required this.text,
    required this.title,
    required this.href,
  });
}

d.Node tagsNode({
  required List<SimpleTag> simpleTags,
  required List<BadgeTag> badgeTags,
}) {
  return d.fragment([
    ...badgeTags.map(
      (t) => d.div(
        classes: ['-pub-tag-badge'],
        children: [
          if (t.href == null)
            d.span(classes: ['tag-badge-main'], text: t.text)
          else
            d.a(
              classes: ['tag-badge-main'],
              title: t.title,
              href: t.href,
              text: t.text,
            ),
          ...t.subTags.map(
            (s) => d.a(
              classes: ['tag-badge-sub'],
              title: s.title,
              href: s.href,
              text: s.text,
            ),
          ),
        ],
      ),
    ),
    ...simpleTags.map(
      (t) => t.hasHref
          ? d.a(
              classes: ['package-tag', t.status],
              href: t.href!,
              title: t.title,
              text: t.text,
            )
          : d.span(
              classes: ['package-tag', t.status],
              attributes: {'title': t.title},
              text: t.text,
            ),
    ),
  ]);
}
