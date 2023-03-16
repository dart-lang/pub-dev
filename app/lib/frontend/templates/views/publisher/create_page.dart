// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;

/// Creates the page for registering a new publisher.
d.Node createPublisherPageNode({
  required String? domain,
}) {
  return d.fragment([
    d.h2(text: 'Create a verified publisher'),
    d.p(children: [
      d.text('A '),
      d.i(text: 'verified publisher'),
      d.text(' is one or more users who own a set of packages. '),
      d.text('Each publisher is identified by a verified domain name. '),
      d.text(
          'This domain lends credibility to packages owned by the publisher. '),
      d.text('For example, the Dart team at Google uses the '),
      d.a(
        href: urls.publisherUrl('dart.dev'),
        target: '_blank',
        rel: 'noopener noreferrer',
        text: 'dart.dev',
      ),
      d.text(
          ' domain as the verified publisher of the packages that the team supported.'),
    ]),
    d.p(children: [
      d.text('To create a verified publisher, you must be a '),
      d.i(text: 'verified domain property'),
      d.text(' owner in '),
      d.a(
        href: 'https://search.google.com/search-console/welcome',
        target: '_blank',
        rel: 'noopener noreferrer',
        text: 'Google Search Console',
      ),
      d.text('. For help see '),
      d.a(
        href: 'https://support.google.com/webmasters/answer/34592?hl=en',
        target: '_blank',
        rel: 'noopener noreferrer',
        text: 'Add a website property',
      ),
      d.text('.'),
    ]),
    d.p(children: [
      d.text(
          'The user account creating a publisher must be the verifier of the '),
      d.i(text: 'domain property'),
      d.text(' – not just a verifier of a '),
      d.i(text: 'URL prefix property'),
      d.text(
          ' – or a collaborator on a property that someone else has verified.'),
    ]),
    d.p(children: [
      d.text('After you create a verified publisher, you will be the '
          'only member, and your email will be listed as the '),
      d.i(text: 'public contact email'),
      d.text(' of the publisher (you can change this later).'),
    ]),
    d.p(text: 'As a member of the publisher you can:'),
    d.ul(children: [
      d.li(children: [
        d.text('Use the '),
        d.i(text: 'publisher Admin page'),
        d.text(' to: '),
        d.ul(children: [
          d.li(children: [
            d.text('change the '),
            d.i(text: 'public contact email'),
            d.text(' of the publisher,'),
          ]),
          d.li(text: 'edit the description of the publisher,'),
          d.li(
              text:
                  'invite other users to become members of the publisher, and,'),
          d.li(text: 'remove users who are members of the publisher.'),
        ]),
      ]),
      d.li(children: [
        d.text('Use the '),
        d.i(text: 'package Admin page'),
        d.text(' to: '),
        d.ul(children: [
          d.li(text: 'update the options of the package, and'),
          d.li(text: 'transfer a package to a publisher.'),
        ]),
      ]),
    ]),
    d.div(
      classes: ['-pub-form-textfield-row'],
      children: [
        material.textField(
          id: '-publisher-id',
          label: 'Domain Name',
          value: domain,
        ),
        material.raisedButton(
          id: '-admin-create-publisher',
          label: 'Create publisher',
        ),
      ],
    ),
    d.p(children: [
      d.text(
          'For more information on publishing and administering packages, see the '),
      d.a(
        href: 'https://dart.dev/tools/pub/publishing',
        target: '_blank',
        rel: 'noopener noreferrer',
        text: 'documentation on publishing packages',
      ),
      d.text('.'),
    ]),
  ]);
}
