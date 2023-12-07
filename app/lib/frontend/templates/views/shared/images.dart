// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

/// Returns the image object for the verified publisher icon.
d.Image verifiedPublisherIconImage() {
  return d.Image(
    src: staticUrls.getAssetUrl('/static/img/material-icon-verified.svg'),
    alt: 'verified publisher',
    width: 14,
    height: 14,
  );
}

/// Returns the image object for license icon.
d.Image licenseIconImage() {
  return d.Image.decorative(
    src: staticUrls.getAssetUrl('/static/img/material-icon-balance.svg'),
    width: 14,
    height: 14,
  );
}
