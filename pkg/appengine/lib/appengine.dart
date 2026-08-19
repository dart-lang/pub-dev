// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;

import 'src/appengine_internal.dart' as appengine_internal;
import 'src/client_context.dart';

export 'package:gcloud/http.dart';

export 'src/appengine_context.dart';
export 'src/client_context.dart';
export 'src/errors.dart';
export 'src/logging.dart';

const Symbol _APPENGINE_CONTEXT = #appengine.context;

/// Starts serving requests coming to this AppEngine application.
///
/// This function will start an HTTP server and will forward new HTTP requests
/// to [handler].
///
/// The [handler] will be executed inside a new request handler zone for every
/// new request. This will isolate different requests from each other.
/// Each [handler] has access to a [ClientContext] using the [context] getter
/// in this library. It can be used to access appengine services, e.g.
/// datastore.
///
/// In case an uncaught error occurs inside the request handler, the request
/// will be closed with an "500 Internal Server Error", if possible, and the
/// given [onError] handler will be called.
///
/// The [onError] function can take either the error object, or the error object
/// and a stack as an argument. If [onError] was not provided, errors will get
/// printed out to the stdout of this process.
///
/// You can provide a [port] if you want to run the HTTP server on a different
/// port than the `8080` default.
///
/// The optional [shared] argument specifies whether additional AppEngine
/// servers can bind to the same `port`. If `shared` is `true` and more
/// AppEngine servers from this isolate or other isolates are bound to the
/// port, then the incoming connections will be distributed among all the bound
/// servers. Connections can be distributed over multiple isolates this way.
///
/// The optional [onAcceptingConnections] callback, if provided, will be
/// notified when the server is accepting connections on [port]. The `address`
/// and `port` arguments that are passed to the callback specify the address
/// and port that the server is listening on.
///
/// The returned `Future` will complete when the HTTP server has been shutdown
/// and is no longer serving requests.
Future runAppEngine(
  void Function(HttpRequest request) handler, {
  Function? onError,
  int port = 8080,
  bool shared = false,
  void Function(InternetAddress address, int port)? onAcceptingConnections,
}) {
  void Function(Object, StackTrace)? errorHandler;
  if (onError != null) {
    if (onError is ZoneUnaryCallback) {
      errorHandler = (error, stack) => onError(error);
    } else if (onError is ZoneBinaryCallback) {
      errorHandler = onError;
    } else {
      throw ArgumentError(
          'The [onError] argument must take either one or two arguments.');
    }
  }

  return appengine_internal.runAppEngine(
      (HttpRequest request, ClientContext context) {
    ss.register(_APPENGINE_CONTEXT, context);
    handler(request);
  }, errorHandler,
      port: port,
      shared: shared,
      onAcceptingConnections: onAcceptingConnections);
}

/// Returns `true`, if the incoming request is an AppEngine cron job request.
///
/// To schedule cron jobs for your application, you must create a `cron.yaml`
/// file in the project root alongside your `app.yaml`. The following is an
/// example of such a `cron.yaml` file:
/// ```yaml
/// cron:
/// - description: 'daily database cleanup job'
///   url: '/tasks/database-cleanup'
///   schedule: 'every 24 hours'
///   target: 'default'
/// ```
///
/// When the cronjob from the example above is triggered AppEngine will send
/// an HTTP request to the `default` service for the resource
/// `/tasks/database-cleanup`. In practice anyone can instigate such a request,
/// but AppEngine will send the request from `'10.0.0.1'` and include a special
/// header. This function will validate the origin of the [request] to
/// ensure that it does indeed originate from
/// [AppEngine's cron job scheduler][1].
///
/// [1]: https://cloud.google.com/appengine/docs/flexible/python/scheduling-jobs-with-cron-yaml#validating_cron_requests
bool isCronJobRequest(HttpRequest request) {
  return request.headers['X-Appengine-Cron']?.contains('true') == true;
}

/// Runs [callback] inside a new service scope with appengine services added.
///
/// The services available to `callback` are all non-request specific appengine
/// services e.g. `dbService`.
///
/// See `package:gcloud/service_scope.dart` for more information on service
/// scopes.
///
/// Here is an example on how this can be used:
///
///     import 'dart:async';
///     import 'dart:io';
///     import 'package:appengine/appengine.dart';
///
///     Future backgroundWork() {
///       return dbService.query(Person).run().toList().then((persons) {
///         // Do something with `persons`.
///       });
///     }
///
///     void mainHandler(HttpRequest request) {
///       dbService.query(Greeting).run().toList().then((greetings) {
///         request.response
///             ..write('Number of greetings: ${greetings.length}')
///             ..close();
///       });
///     }
///
///     main() {
///       withAppEngineServices(() {
///         return Future.wait([
///            runAppEngine(mainHandler),
///            backgroundWork(),
///         ]);
///       });
///     }
Future withAppEngineServices(Future Function() callback) {
  return appengine_internal.withAppEngineServices(callback);
}

/// Returns the [ClientContext] of the current request.
///
/// This getter can only be called inside a request handler which was passed to
/// [runAppEngine].
ClientContext get context => ss.lookup(_APPENGINE_CONTEXT) as ClientContext;

/// Will register for log events produced by `package:logging` and forwards
/// log records to the AppEngine logging service.
///
/// Errors and exceptions logged with a stacktrace and severity `severe` or
/// higher will also be reported to [Stackdriver Error Reporting][1] when
/// running on AppEngine.
///
/// [1]: https://cloud.google.com/error-reporting/
void useLoggingPackageAdaptor() {
  appengine_internal.useLoggingPackageAdaptor();
}
