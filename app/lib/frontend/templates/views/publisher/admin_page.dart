// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/publisher_api.dart' as api;

import '../../../../publisher/models.dart';
import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;

/// Creates the publisher admin page content.
d.Node publisherAdminPageNode({
  required Publisher publisher,
  required List<api.PublisherMember> members,
}) {
  return d.fragment([
    d.h2(text: 'Publisher information'),
    d.div(
      classes: ['-pub-form-textfield-row'],
      child: material.textArea(
        id: '-publisher-description',
        label: 'Description',
        rows: 5,
        cols: 60,
        value: publisher.description,
      ),
    ),
    d.div(
      classes: ['-pub-form-textfield-row'],
      child: material.textField(
        id: '-publisher-website-url',
        label: 'Website',
        value: publisher.websiteUrl,
      ),
    ),
    d.div(
      classes: ['-pub-form-textfield-row'],
      child: material.textField(
        id: '-publisher-contact-email',
        label: 'Contact email',
        value: publisher.contactEmail,
      ),
    ),
    d.div(
      classes: ['-pub-form-right-aligned'],
      child: material.button(
        id: '-publisher-update-button',
        label: 'Update',
        raised: true,
      ),
    ),
    d.h2(text: 'Members'),
    if (members.length == 1)
      d.p(
        text: 'This publisher only has a single member. '
            'Consider adding more members to protect against losing control of the publisher.',
        classes: ['warning'],
      ),
    material.dataTable<api.PublisherMember>(
      id: '-pub-publisher-admin-members-table',
      ariaLabel: 'Members of publisher',
      columns: [
        material.DataTableColumn<api.PublisherMember>(
          headerContent: d.text('Email'),
          headerClasses: ['email-header'],
          renderCell: (api.PublisherMember m) => d.text(m.email),
        ),
        material.DataTableColumn<api.PublisherMember>(
          headerContent: d.text('Role'),
          headerClasses: ['role-header'],
          renderCell: (api.PublisherMember m) => d.text(m.role),
        ),
        material.DataTableColumn<api.PublisherMember>(
          headerContent: d.text(''),
          headerClasses: ['icons-header'],
          renderCell: (api.PublisherMember m) => d.a(
            classes: ['-pub-remove-user-button'],
            attributes: {
              'data-user-id': m.userId,
              'data-email': m.email,
            },
            title: 'Remove member',
            text: '×',
          ),
        ),
      ],
      entries: members,
    ),
    d.div(
      classes: ['-pub-form-right-aligned'],
      child: material.button(
        id: '-admin-add-member-button',
        label: 'Add member',
        raised: true,
      ),
    ),
    d.div(
      id: '-admin-add-member-content',
      classes: ['modal-content-hidden'],
      children: [
        d.p(
          text: 'You can invite new members to this verified publisher. '
              'Once new members accept the invitation, they have full administrative rights, with the following abilities:',
        ),
        d.ul(
          children: [
            d.li(text: 'Transfer packages to and from this publisher'),
            d.li(
                text:
                    'Upload new versions of packages owned by this publisher'),
            d.li(text: 'Add and remove members of this publisher'),
          ],
        ),
        d.div(
          classes: ['-pub-form-textfield-row'],
          child: material.textField(
            id: '-admin-invite-member-input',
            label: 'Email address',
          ),
        ),
      ],
    ),
  ]);
}
