// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:stream_channel/stream_channel.dart';

/// Constructs a [StreamChannel] wrapping `postMessage` communication with the
/// host page.
StreamChannel postMessageChannel() {
  var controller = new StreamChannelController(sync: true);

  window.onMessage.listen((message) {
    // A message on the Window can theoretically come from any website. It's
    // very unlikely that a malicious site would care about hacking someone's
    // unit tests, let alone be able to find the test server while it's
    // running, but it's good practice to check the origin anyway.
    if (message.origin != window.location.origin) return;
    message.stopPropagation();

    controller.local.sink.add(message.data);
  });

  controller.local.stream.listen((data) {
    // TODO(nweiz): Stop manually adding href here once issue 22554 is
    // fixed.
    window.parent.postMessage(
        {"href": window.location.href, "data": data}, window.location.origin);
  });

  // Send a ready message once we're listening so the host knows it's safe to
  // start sending events.
  window.parent.postMessage(
      {"href": window.location.href, "ready": true}, window.location.origin);

  return controller.foreign;
}
