// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

/// Render package uploader invite content.
d.Node packageUploaderInviteNode({
  required String invitingUserEmail,
  required String packageName,
  required String? currentUserEmail,
}) {
  return d.fragment([
    d.p(children: [
      d.code(text: invitingUserEmail),
      d.text(' has invited you to be an uploader of the package '),
      d.a(
        href: urls.pkgPageUrl(packageName),
        target: '_blank',
        rel: 'noopener noreferrer',
        child: d.code(text: packageName),
      ),
      d.text('.'),
    ]),
    d.p(text: 'Accepting a package uploader invitation means:'),
    d.ul(
      children: [
        d.li(children: [
          d.text('you will be able to publish new versions of package '),
          d.code(text: packageName),
          d.text(', and,'),
        ]),
        d.li(children: [
          d.text('perform administrative actions for package '),
          d.code(text: packageName),
          d.text('.'),
        ]),
      ],
    ),
  ]);
}
