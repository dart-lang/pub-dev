// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../shared/handlers.dart';

/// Handles /api/account/v1/info
Future<shelf.Response> accountInfoHandler(shelf.Request request) async {
  return jsonResponse({'email': authenticatedUser?.email ?? '-'});
}
