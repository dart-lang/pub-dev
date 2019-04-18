// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

void setupIssues() {
  _guardReportIssue();
  window.onHashChange.listen((_) {
    _fixIssueLinks();
  });
  _fixIssueLinks();
}

void _guardReportIssue() {
  for (AnchorElement bugLink in document.querySelectorAll('a.github_issue')) {
    bugLink.onClick.listen((event) {
      if (!window.confirm('This link is for reporting issues for the pub site. '
          'If you would like to report a problem with a package, please visit '
          'its homepage or contact its developers.')) {
        event.preventDefault();
      }
    });
  }
}

void _fixIssueLinks() {
  for (AnchorElement bugLink in document.querySelectorAll('a.github_issue')) {
    var url = Uri.parse(bugLink.href);
    final lines = <String>[
      'URL: ${window.location.href}',
      '',
      '<Describe your issue or suggestion here>'
    ];

    final issueLabels = ['Area: site feedback'];

    var bugTitle = '<Summarize your issues here>';
    final bugTag = bugLink.dataset['bugTag'];
    if (bugTag != null) {
      bugTitle = '[$bugTag] $bugTitle';
      if (bugTag == 'analysis') {
        issueLabels.add('Area: package analysis');
      }
    }

    final queryParams = {
      'body': lines.join('\n'),
      'title': bugTitle,
      'labels': issueLabels.join(',')
    };

    url = url.replace(queryParameters: queryParams);
    bugLink.href = url.toString();
  }
}
