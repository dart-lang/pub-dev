// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/models.dart';
import '../../admin/models.dart';
import '../dom/dom.dart' as d;
import '../dom/material.dart' as material;
import 'layout.dart';

const _subjectKindLabels = {
  ModerationSubjectKind.package: 'Package: ',
  ModerationSubjectKind.packageVersion: 'Package version: ',
  ModerationSubjectKind.publisher: 'Publisher: ',
};

/// Renders the create publisher page.
String renderReportPage({
  SessionData? sessionData,
  ModerationSubject? subject,
}) {
  return renderLayoutPage(
    PageType.standalone,
    d.div(
      classes: ['report-main'],
      child: d.div(
        id: 'report-page-form',
        attributes: {
          'data-form-api-endpoint': '/api/report',
        },
        children: [
          d.h1(text: 'Report a problem'),
          if (!(sessionData?.isAuthenticated ?? false))
            d.fragment([
              d.p(text: 'Contact information:'),
              material.textField(
                id: 'report-email',
                name: 'email',
                label: 'Email',
              ),
            ]),
          if (subject != null)
            d.fragment([
              d.input(type: 'hidden', name: 'subject', value: subject.fqn),
              d.p(children: [
                d.text(_subjectKindLabels[subject.kind] ?? ''),
                d.code(text: subject.localName),
              ]),
            ]),
          d.p(text: 'Please describe the issue you want to report:'),
          material.textArea(
            id: 'report-message',
            name: 'message',
            label: 'Message',
            rows: 10,
            cols: 60,
            maxLength: 8192,
          ),
          material.raisedButton(
            label: 'Submit',
            id: 'report-submit',
            attributes: {
              'data-form-api-button': 'submit',
            },
          ),
        ],
      ),
    ),
    title: 'Report a problem',
    noIndex: true, // no need to index, may contain session-specific content
  );
}
