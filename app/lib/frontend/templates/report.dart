// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/static_files.dart';

import '../../account/models.dart';
import '../../admin/models.dart';
import '../dom/dom.dart' as d;
import '../dom/material.dart' as material;
import 'layout.dart';

const _subjectKindLabels = {
  ModerationSubjectKind.package: 'package',
  ModerationSubjectKind.packageVersion: 'package version',
  ModerationSubjectKind.publisher: 'publisher',
};

/// Renders the feedback page with a simple paragraph of [message].
String renderReportFeedback({
  required String title,
  required String message,
}) {
  return renderLayoutPage(
    PageType.standalone,
    d.fragment([
      d.h1(text: title),
      d.p(text: message),
    ]),
    title: title,
    noIndex: true,
  );
}

/// Renders the create publisher page.
String renderReportPage({
  SessionData? sessionData,
  required ModerationSubject subject,
  required String? url,
  required String? caseId,
  required String onSuccessGotoUrl,
}) {
  final isAppeal = caseId != null;
  final title = isAppeal ? 'Appeal a resolution' : 'Report a problem';
  return renderLayoutPage(
    PageType.standalone,
    d.div(
      classes: ['report-main'],
      child: d.div(
        id: 'report-page-form',
        attributes: {
          'data-form-api-endpoint': '/api/report',
          'data-form-success-goto': onSuccessGotoUrl,
        },
        children: [
          d.input(type: 'hidden', name: 'subject', value: subject.fqn),
          if (url != null) d.input(type: 'hidden', name: 'url', value: url),
          if (caseId != null)
            d.input(type: 'hidden', name: 'caseId', value: caseId),
          d.h1(text: title),
          if (isAppeal)
            ..._appeal(sessionData, caseId, subject)
          else
            ..._report(sessionData, subject, url: url),
        ],
      ),
    ),
    title: title,
    noIndex: true, // no need to index, may contain session-specific content
  );
}

Iterable<d.Node> _report(
  SessionData? sessionData,
  ModerationSubject subject, {
  required String? url,
}) {
  final kindLabel = _subjectKindLabels[subject.kind] ?? 'about';
  final lcpsDeepLink =
      Uri.parse('https://reportcontent.google.com/troubleshooter').replace(
    queryParameters: {
      'product': 'dart_pub',
      'content_id': subject.canonicalUrl,
      if (url != null) 'url': url,
    },
  );
  return [
    d.p(children: [
      d.text('Why do you wish to report $kindLabel '),
      d.code(text: subject.localName),
      d.text('?'),
    ]),
    d.p(text: ''),
    // illegal content
    if (subject.isPackage)
      _foldableSection(
        title: d.text('I believe the package contains illegal content.'),
        children: [
          d.markdown('Please report illegal content through the '
              '[illegal content reporting form here]($lcpsDeepLink).')
        ],
      )
    else if (subject.isPublisher)
      _foldableSection(
        title: d.text('I believe the publisher contains illegal content.'),
        children: [
          d.markdown('Please report illegal content through the '
              '[illegal content reporting form here]($lcpsDeepLink).')
        ],
      ),

    // contact
    if (subject.isPackage)
      _foldableSection(
        title: d.text(
            'I have found a bug in the package / I need help using the package.'),
        children: [
          d.markdown('Please consult the package page: '
              '[`pub.dev/packages/${subject.package}`](https://pub.dev/packages/${subject.package})'),
          d.p(
              text:
                  'Many packages have issue trackers, support discussion boards or chat rooms. '
                  'Often these are discoverable from the package source code repository.'),
          d.p(
              text: 'Many packages are freely available and package authors '
                  'are not required to provide support.'),
          d.markdown(
              'And the Dart team cannot provide support for all packages on pub.dev, '
              'but it is often possible to get help and talk to other Dart developers through '
              '[community channels](https://dart.dev/community).')
        ],
      )
    else if (subject.isPublisher)
      _foldableSection(
        title: d.text('I want to contact the publisher.'),
        children: [
          d.markdown('Please consult the publisher page: '
              '[`pub.dev/publishers/${subject.publisherId}`](https://pub.dev/publishers/${subject.publisherId})'),
          d.p(
              text: 'All publishers have a contact email. '
                  'Publishers do not have to provide support and may not respond to your inquiries.'),
        ],
      ),

    // direct report
    _foldableSection(
      buttonDivClasses: ['report-page-direct-report'],
      title: d.text('I believe the $kindLabel violates pub.dev/policy.'),
      children: [
        if (!(sessionData?.isAuthenticated ?? false))
          d.fragment([
            d.p(text: 'Contact information:'),
            material.textField(
              id: 'report-email',
              name: 'email',
              label: 'Email',
            ),
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

    // problem with pub.dev
    _foldableSection(
      title: d.text('I have a problem with the pub.dev website.'),
      children: [
        d.markdown('Security vulnerabilities may be reported through '
            '[goo.gl/vulnz](https://goo.gl/vulnz)'),
        d.markdown('Bugs on the pub.dev website may be reported at '
            '[github.com/dart-lang/pub-dev/issues](https://github.com/dart-lang/pub-dev/issues)'),
        d.markdown(
            'Issues with specific accounts may be directed to `support@pub.dev`.'),
      ],
    ),
  ];
}

Iterable<d.Node> _appeal(
  SessionData? sessionData,
  String caseId,
  ModerationSubject subject,
) {
  return [
    d.p(children: [
      d.text('If wish you to file an appeal for '),
      d.code(text: caseId),
      d.text(' on '),
      d.code(text: subject.localName),
      d.text(', please explain why the resolution should be reconsidered.'),
    ]),
    d.p(
      text: 'If you have additional relevant documentation '
          '(source repositories, screenshots, logs, bug tracker entries, etc) '
          'consider uploading these and sharing a link.',
    ),
    d.p(
      child: d.b(text: 'You can appeal at most once per case.'),
    ),
    if (!(sessionData?.isAuthenticated ?? false))
      d.fragment([
        d.p(text: 'Contact information:'),
        material.textField(
          id: 'report-email',
          name: 'email',
          label: 'Email',
        ),
      ]),
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
  ];
}

d.Node _foldableSection({
  required d.Node title,
  required Iterable<d.Node> children,
  Iterable<String>? buttonDivClasses,
}) {
  return d.div(
    classes: ['foldable-section', 'foldable'],
    children: [
      d.div(
        classes: ['foldable-button', ...?buttonDivClasses],
        children: [
          d.img(
            classes: ['foldable-icon'],
            image: d.Image(
              src: staticUrls
                  .getAssetUrl('/static/img/foldable-section-icon.svg'),
              alt: 'trigger folding of the section',
              width: 13,
              height: 6,
            ),
          ),
          title,
        ],
      ),
      d.div(
        classes: ['foldable-content'],
        children: children,
      ),
    ],
  );
}
