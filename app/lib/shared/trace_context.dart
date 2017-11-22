// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

/// Wraps the call `handleRequest` from `package:shelf/shelf_io.dart` while also
/// checking for `X-Cloud-Trace-Context` as a request header and recording it
/// to the current service scope.
///
/// Allows later access within the same request via [getTraceContext].
Future handleTracedRequest(HttpRequest request, shelf.Handler handler) async {
  assert(getTraceContext() == null);
  final context = request.headers.value(cloudTraceContextHeader);
  if (context != null) {
    _registerTraceContext(context);
    Logger.root.info('$cloudTraceContextHeader : $context');
  }
  return shelf_io.handleRequest(request, handler);
}

/// The value `X-Cloud-Trace-Context`.
///
/// Standard trace header used by
/// [StackDriver](https://cloud.google.com/trace/docs/support) and supported by
/// Appengine.
const cloudTraceContextHeader = 'X-Cloud-Trace-Context';

void _registerTraceContext(String traceContext) =>
    ss.register(#_traceContext, traceContext);

/// Returns the `X-Cloud-Trace-Context` header present for the original request,
/// if any.
///
/// Otherwise, `null`.
String getTraceContext() => ss.lookup(#_traceContext);
