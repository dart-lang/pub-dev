// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

/// Render publisher contact invite content.
d.Node publisherContactInviteNode({
  required String invitingUserEmail,
  required String publisherId,
  required String contactEmail,
}) {
  return d.fragment([
    d.p(
      children: [
        d.code(text: invitingUserEmail),
        d.text(' has requested to use '),
        d.code(text: contactEmail),
        d.text(' as the contact email of the '),
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
    d.p(text: 'Accepting the use of the contact email means:'),
    d.ul(
      children: [
        d.li(
          children: [
            d.text('the email will be publicly listed on the '),
            d.a(
              href: urls.publisherUrl(publisherId),
              target: '_blank',
              rel: 'noopener noreferrer',
              text: 'publisher page',
            ),
            d.text('.'),
          ],
        ),
      ],
    ),
  ]);
}
