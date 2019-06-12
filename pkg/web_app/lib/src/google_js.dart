// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Partial bindings for the Google JS APIs.
/// https://developers.google.com/identity/sign-in/web/reference
@JS('gapi')
library google_js;

import 'package:js/js.dart';

@JS()
external dynamic load(String name, Function onReady);
