// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/request_context.dart';

import '../../../../account/models.dart';
import '../../../../package/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;

/// Creates the package admin page content.
d.Node packageAdminPageNode({
  required Package package,
  required List<String> userPublishers,
  required List<User> uploaderUsers,
  required List<String> retractableVersions,
  required List<String> retractedVersions,
}) {
  final pkgHasPublisher = package.publisherId != null;
  return d.fragment([
    d.h2(text: 'Package ownership'),
    d.div(children: [
      if (!pkgHasPublisher) ...[
        d.markdown(
            'You can transfer this package to a verified publisher if you are a member of the publisher. '
            'Transferring the package removes the current uploaders, so that only the members of the publisher can upload new versions.'),
        d.markdown(
            '**Upgrading to verified publishers is an irreversible operation.** '
            'Packages can be transferred between publishers, but they can\'t be converted back to legacy uploader ownership.'),
      ],
      if (pkgHasPublisher)
        d.markdown(
            'You can transfer your package to a **different publisher** if you’re also a member of the publisher.'),
      if (userPublishers.isNotEmpty) ...[
        material.dropdown(
          id: '-admin-set-publisher-input',
          label: 'Select a publisher',
          classes: ['-admin-dropdown'],
          options: [
            if (!pkgHasPublisher)
              material.option(
                  value: '', text: '', disabled: true, selected: true),
            ...userPublishers.map(
              (p) => material.option(
                  value: p, text: p, selected: p == package.publisherId),
            ),
          ],
        ),
        d.p(
          child: material.button(
            id: '-admin-set-publisher-button',
            classes: ['pub-button-danger'],
            raised: true,
            label: 'Transfer to publisher',
          ),
        ),
      ],
      if (userPublishers.isEmpty)
        d.markdown('You have no verified publisher. '
            'Use the [create publisher](${urls.createPublisherUrl()}) page to create one.'),
      if (!pkgHasPublisher) ...[
        d.h3(text: 'Uploaders'),
        material.dataTable<User>(
          ariaLabel: 'Uploaders of package',
          columns: [
            material.DataTableColumn<User>(
              headerContent: d.text('Email'),
              headerClasses: ['email-header'],
              renderCell: (u) => d.text(u.email!),
            ),
            material.DataTableColumn<User>(
              headerContent: d.text(''),
              headerClasses: ['icons-header'],
              renderCell: (u) => d.a(
                classes: ['-pub-remove-uploader-button'],
                title: 'Remove uploader',
                attributes: {'data-email': u.email!},
                text: '×',
              ),
            ),
          ],
          entries: uploaderUsers,
        ),
        d.p(
          child: material.button(
            id: '-pkg-admin-invite-uploader-button',
            label: 'Invite uploader',
            raised: true,
          ),
        ),
        d.div(
          id: '-pkg-admin-invite-uploader-content',
          classes: ['modal-content-hidden'],
          children: [
            d.p(
                text: 'You can invite new uploader to this package. '
                    'Once new uploaders accept the invitation, they have full administrative rights, '
                    'with the following abilities:'),
            d.ul(children: [
              d.li(text: 'Transfer this package to a publisher'),
              d.li(text: 'Upload new versions of this package'),
              d.li(text: 'Invite and remove uploaders of this package'),
            ]),
            d.div(
              classes: ['-pub-form-textfield-row'],
              child: material.textField(
                id: '-pkg-admin-invite-uploader-input',
                label: 'Email address',
              ),
            ),
          ],
        ),
      ],
    ]),
    d.h2(text: 'Package Options'),
    d.h3(text: 'Discontinued'),
    d.markdown(
        'A package can be marked as [discontinued](https://dart.dev/tools/pub/publishing#discontinue) '
        'to inform users that the package is no longer maintained. '
        '*Discontinued packages* remain available to package users, but they don\'t appear '
        'in search results on pub.dev unless the user specifies advanced search options.'),
    d.div(
      classes: ['-pub-form-checkbox-row'],
      child: material.checkbox(
        id: '-admin-is-discontinued-checkbox',
        label: 'Mark "discontinued"',
        checked: package.isDiscontinued,
      ),
    ),
    if (package.isDiscontinued) ...[
      d.h3(text: 'Suggested replacement'),
      d.markdown('When a package is *discontinued* the author may designate a '
          '*suggested replacement package*. Package users will be suggested '
          'to consider using the designated replacement package.'),
      d.p(
          text: 'Designating a replacement package is optional, '
              'and only serves to guide existing package users.'),
      d.div(
        classes: ['-pub-form-textfield-row'],
        children: [
          material.textField(
            id: '-package-replaced-by',
            label: null,
            value: package.replacedBy,
          ),
          material.button(
            id: '-package-replaced-by-button',
            label: 'Update "suggested replacement"',
            raised: true,
          )
        ],
      ),
    ],
    if (!package.isDiscontinued) ...[
      d.h3(text: 'Unlisted'),
      d.markdown(
          'A package that\'s marked as *unlisted* doesn\'t normally appear in search results on pub.dev. '
          'Unlisted packages remain publicly available, and users can search for them using advanced search options.'),
      d.div(
        classes: ['-pub-form-checkbox-row'],
        child: material.checkbox(
          id: '-admin-is-unlisted-checkbox',
          label: 'Mark "unlisted"',
          checked: package.isUnlisted,
        ),
      ),
    ],
    if (requestContext.showAdminUIForAutomatedPublishing)
      _automatedPublishing(package),
    d.h2(text: 'Package Version Retraction'),
    d.div(children: [
      d.markdown(
          'You can [retract](https://dart.dev/go/package-retraction) a package version up to 7 days after publication.'),
      d.markdown(
          'This will not remove the package version, but warn developers using'
          ' it and stop new applications from taking dependency on it without a dependency override.'),
      d.markdown(
          'You can restore a retracted package version if the version was retracted within the last 7 days.'),
      d.h3(text: 'Retract Package Version'),
      if (retractableVersions.isNotEmpty) ...[
        material.dropdown(
          id: '-admin-retract-package-version-input',
          label: 'Select a version',
          classes: ['-admin-dropdown'],
          options: [
            ...retractableVersions.map(
              (v) => material.option(value: v, text: v),
            ),
          ],
        ),
        d.p(
          child: material.button(
            id: '-admin-retract-package-version-button',
            classes: ['pub-button-danger'],
            raised: true,
            label: 'Retract Package Version',
          ),
        )
      ],
      if (retractableVersions.isEmpty)
        d.markdown('This package has no retractable versions.'),
    ]),
    d.h3(text: 'Restore Retracted Package Version'),
    d.div(children: [
      if (retractedVersions.isNotEmpty) ...[
        material.dropdown(
          id: '-admin-restore-retract-package-version-input',
          label: 'Select a version',
          classes: ['-admin-dropdown'],
          options: [
            ...retractedVersions.map(
              (v) => material.option(value: v, text: v),
            ),
          ],
        ),
        d.p(
          child: material.button(
            id: '-admin-restore-retract-package-version-button',
            classes: ['pub-button-danger'],
            raised: true,
            label: 'Restore Retraced Package Version',
          ),
        ),
      ],
      if (retractedVersions.isEmpty)
        d.markdown(
            'This package has no retracted versions that can be restored.'),
    ]),
  ]);
}

d.Node _automatedPublishing(Package package) {
  final github = package.automatedPublishing.github;
  final gcp = package.automatedPublishing.gcp;
  return d.fragment([
    d.h2(text: 'Automated publishing'),
    d.h3(text: 'Publishing from GitHub Actions'),
    d.div(
      classes: [
        '-pub-form-checkbox-row',
        '-pub-form-checkbox-toggle-next-sibling',
      ],
      child: material.checkbox(
        id: '-pkg-admin-automated-github-enabled',
        label: 'Enable publishing from GitHub Actions',
        checked: github?.isEnabled ?? false,
      ),
    ),
    d.div(
      classes: [
        '-pub-form-checkbox-indent',
        if (!(github?.isEnabled ?? false)) '-pub-form-block-hidden',
      ],
      children: [
        d.div(
          classes: ['-pub-form-textfield-row'],
          child: material.textField(
            id: '-pkg-admin-automated-github-repository',
            label: 'Repository',
            value: github?.repository,
          ),
        ),
        d.div(
          classes: ['-pub-form-textfield-row'],
          children: [
            material.textField(
              id: '-pkg-admin-automated-github-tagpattern',
              label: 'Tag pattern',
              value: github?.tagPattern ?? '{{version}}',
            ),
            d.markdown(
                '`{{version}}` will be substituted for the version number of the package. '
                'For example, for tags like `v1.2.3` use `v{{version}}`, '
                'and for `mypackage-1.2.3` use `mypackage-{{version}}`.'),
          ],
        ),
        d.div(
          classes: [
            '-pub-form-checkbox-row',
            '-pub-form-checkbox-toggle-next-sibling',
          ],
          child: material.checkbox(
            id: '-pkg-admin-automated-github-requireenv',
            label: 'Require GitHub Actions environment',
            checked: github?.requireEnvironment ?? false,
          ),
        ),
        d.div(
          classes: [
            '-pub-form-checkbox-indent',
            '-pub-form-textfield-row',
            if (!(github?.requireEnvironment ?? false))
              '-pub-form-block-hidden',
          ],
          child: material.textField(
            id: '-pkg-admin-automated-github-environment',
            label: 'Environment',
            value: github?.environment,
          ),
        ),
      ],
    ),
    d.h3(text: 'Publishing with Google Cloud Service account'),
    d.markdown(
        'When publishing with a GCP _service account_ is enabled, the service account configured here '
        'will be able to create temporary tokens that allows publishing of this package. '
        'To learn more about publishing using a _service account_, see '
        '[dart.dev/go/automated-publishing](https://dart.dev/go/automated-publishing)'),
    d.div(
      classes: [
        '-pub-form-checkbox-row',
        '-pub-form-checkbox-toggle-next-sibling',
      ],
      child: material.checkbox(
        id: '-pkg-admin-automated-gcp-enabled',
        label: 'Enable publishing with Google Cloud Service account',
        checked: gcp?.isEnabled ?? false,
      ),
    ),
    d.div(
      classes: [
        '-pub-form-checkbox-indent',
        if (!(gcp?.isEnabled ?? false)) '-pub-form-block-hidden',
      ],
      children: [
        d.div(
          classes: ['-pub-form-textfield-row'],
          child: material.textField(
            id: '-pkg-admin-automated-gcp-serviceaccountemail',
            label: 'Service account email',
            value: gcp?.serviceAccountEmail,
          ),
        ),
      ],
    ),
    d.p(
      child: material.button(
        id: '-pkg-admin-automated-button',
        label: 'Update',
        raised: true,
      ),
    ),
  ]);
}
