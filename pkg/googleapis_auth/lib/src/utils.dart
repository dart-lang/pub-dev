// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.utils;

/// Due to differences of clock speed, network latency, etc. we
/// will shorten expiry dates by 20 seconds.
const MAX_EXPECTED_TIMEDIFF_IN_SECONDS = 20;

/// Constructs a [DateTime] which is [seconds] seconds from now with
/// an offset of [MAX_EXPECTED_TIMEDIFF_IN_SECONDS]. Result is UTC time.
DateTime expiryDate(int seconds) {
  return new DateTime.now()
      .toUtc()
      .add(new Duration(seconds: seconds - MAX_EXPECTED_TIMEDIFF_IN_SECONDS));
}

/// Constant for the 'application/x-www-form-urlencoded' content type
const CONTENT_TYPE_URLENCODED =
    'application/x-www-form-urlencoded; charset=utf-8';
