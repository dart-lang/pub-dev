// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.api.remote_api;

import 'dart:async';
import 'dart:io';

@deprecated
abstract class RemoteApi {
  // TODO: We might want to change this to (maybe with more information about
  // request):
  // Future<List<int>> handleRemoteApiRequest(List<int> data);

  /**
   * Handles the RemoteApi [request].
   *
   * The user is responsible for ensuring that [request] is either a GET or a
   * POST request. If an error occurs during the processing of [request] the
   * returned future will complete with an error.
   */
  Future handleRemoteApiRequest(HttpRequest request);
}
