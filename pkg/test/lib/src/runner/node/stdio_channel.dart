// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS()
library _;

import 'package:js/js.dart';
import 'package:stream_channel/stream_channel.dart';

import '../../utils.dart';

@JS("require")
external _Process _require(String module);

@JS()
class _Process {
  external _Stdin get stdin;
  external _Stdout get stdout;
}

@JS()
class _Stdin {
  external setEncoding(String encoding);
  external on(String event, void callback(String chunk));
}

@JS()
class _Stdout {
  external setDefaultEncoding(String encoding);
  external write(String chunk);
}

/// Returns a [StreamChannel] of JSON-encodable objects that communicates over
/// the current process's stdout and stdin streams.
StreamChannel stdioChannel() {
  var controller = new StreamChannelController<String>(
      allowForeignErrors: false, sync: true);
  var process = _require("process");
  process.stdin.setEncoding("utf8");
  process.stdout.setDefaultEncoding("utf8");

  controller.local.stream.listen((chunk) => process.stdout.write(chunk));
  process.stdin.on("data", allowInterop(controller.local.sink.add));

  return controller.foreign.transform(chunksToLines).transform(jsonDocument);
}
