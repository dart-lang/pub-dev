// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

/// Render publisher member invite content.
d.Node publisherMemberInviteNode({
  required String invitingUserEmail,
  required String publisherId,
}) {
  return d.fragment([
    d.p(
      children: [
        d.code(text: invitingUserEmail),
        d.text(' has invited you to be a member of the '),
        d.a(
          href: 'https://dart.dev/tools/pub/verified-publishers',
          target: '_blank',
          rel: 'noopener noreferrer',
          text: 'verified publisher',
        ),
        d.text(' '),
        d.a(
          href: urls.publisherUrl(publisherId),
          target: '_blank',
          rel: 'noopener noreferrer',
          child: d.code(text: publisherId),
        ),
        d.text('.'),
      ],
    ),
    d.p(text: 'Accepting a publisher membership invitation means:'),
    d.ul(
      children: [
        d.li(
          children: [
            d.text('other members of the publisher '),
            d.code(text: publisherId),
            d.text(' will be able to see your email address,'),
          ],
        ),
        d.li(
          children: [
            d.text(
              'you will be able to publish new versions of packages owned by the publisher ',
            ),
            d.code(text: publisherId),
            d.text(','),
          ],
        ),
        d.li(
          children: [
            d.text(
              'you will be able to transfer packages to be owned by the publisher ',
            ),
            d.code(text: publisherId),
            d.text(','),
          ],
        ),
        d.li(
          children: [
            d.text(
              'you will be able to perform administrative actions for publisher ',
            ),
            d.code(text: publisherId),
            d.text('.'),
          ],
        ),
      ],
    ),
  ]);
}
