// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';

class FakeClientContext implements ClientContext {
  @override
  AppEngineContext get applicationContext => throw UnimplementedError();

  @override
  bool get isDevelopmentEnvironment => true;

  @override
  bool get isProductionEnvironment => false;

  @override
  Services get services => throw UnimplementedError();

  @override
  String? get traceId => null;
}
