// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:web/web.dart';
import 'package:web_app/src/web_util.dart';

void setupIssues() {
  _guardReportIssue();
  window.addEventListener(
    'hashchange',
    (HashChangeEvent _) {
      _fixIssueLinks();
    }.toJS,
  );
  _fixIssueLinks();
}

void _guardReportIssue() {
  for (final bugLink
      in document.querySelectorAll('a.github_issue').toElementList()) {
    bugLink.onClick.listen((event) {
      if (!window.confirm(
        'This link is for reporting issues for the pub site. '
        'If you would like to report a problem with a package, please visit '
        'its homepage or contact its developers.',
      )) {
        event.preventDefault();
      }
    });
  }
}

void _fixIssueLinks() {
  for (final bugLink
      in document
          .querySelectorAll('a.github_issue')
          .toElementList()
          .cast<HTMLAnchorElement>()) {
    var url = Uri.parse(bugLink.href);
    final lines = <String>[
      'URL: ${window.location.href}',
      '',
      '<Describe your issue or suggestion here>',
    ];

    final issueLabels = ['Area: site feedback'];
    final bugTitle = '<Summarize your issues here>';

    final queryParams = {
      'body': lines.join('\n'),
      'title': bugTitle,
      'labels': issueLabels.join(','),
    };

    url = url.replace(queryParameters: queryParams);
    bugLink.href = url.toString();
  }
}
