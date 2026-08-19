## 0.13.12

* Upgrade dependency `package:gcloud` to `^0.9.0`.

## 0.13.11

* Update dependency on `googleapis_auth` and `http`.

## 0.13.10

* Upgrade `package:grpc` to `^4.0.1`.

## 0.13.9

* Update the pubspec repository field to reflect the new repo location.

## 0.13.8

* Require `package:protobuf` ^3.1.0.

## 0.13.7

* Widen dependency constraint on `package:http`.

## 0.13.6

* Require Dart 2.19.
* Setup `dbService` to do retries for failed requests.

## 0.13.5

* Added topics to `pubspec.yaml`.

## 0.13.4

* Implement `onConnectionStateChanged` to sync `grpc: 3.1.0`

## 0.13.3

* Populate the pubspec `repository` field.
* Update the readme to add experimental verbiage.

## 0.13.2
 * Gracefully handle cases where logging fails.

## 0.13.1
 * Fix dependency on `package:gcloud` to version `0.8.0`.

## 0.13.0
**WARNING**: Version `0.13.0` is broken, use `0.13.1`.

 * Migrated to _null-safety_ and `package:gcloud` version `0.8.0`.

## 0.12.1
 * Setup default `authClient` in `package:gcloud`, fixing regression from
   introduction of _Application Default Credentials_ in `0.12.0`.

## 0.12.0
 * **Breaking**, now using the environment variable `GOOGLE_CLOUD_PROJECT`
    instead of `GCLOUD_PROJECT` for project name.
 * **Breaking**, now using
   [Application Default Credentials](https://cloud.google.com/docs/authentication/production)
   instead of using the environment variable `GCLOUD_KEY`.
   This allows authentication by specifying an _exported service account key_
   in `GOOGLE_APPLICATION_CREDENTIALS`, or running
   `gcloud auth application-default login` on your local machine.

## 0.11.0

 * Upgrade `gcloud` to `0.7.0` with breaking changes in datastore keys.

## 0.10.5

 * Handle duplicate `user-agent` headers.

## 0.10.4

 * Added `Logging.reportError` to the `logging interface, for reporting errors
   to [Stackdriver Error Reporting](https://cloud.google.com/error-reporting/)
   when running in AppEngine.
 * Report errors logged through the `package:logging` adapter to
   `Logging.reportError` (for reporting to Stackdriver Error Reporting).
 * Updated protobuf source files.
 * Reduced number of unnecessarily generated protos.

## 0.10.3

 * Update Protobuf to v1.0.0
 * Add client library identification header
 * Fix `grpc/datastore` tests

## 0.10.2

 * Update gRPC version dependency

## 0.10.1

 * Update gRPC API protos

## 0.10.0

 * Revert `0.9.0`

## 0.9.0

 * Instantiate new `DatastoreDB` instances for each request.

## 0.8.1

 * Detect dev mode when running behind a proxy.

## 0.8.0

 * Add `applicationContext` getter to `ClientContext`

## 0.7.3

 * Add `onAcceptingConnections` callback to `runAppEngine()`

## 0.7.2

 * Update the generated protobufs.

## 0.7.1

 * Update to use `package:grpc` version 2.0

## 0.7.0

 * Refactored to use `package:grpc` to talk to Logging and Datastore backends.

## 0.6.1

 * Added `isCronJonRequest` as a helper method for determining if a request
   originates from the AppEngine cronjob scheduler.

## 0.6.0

**Breaking changes:**
 * Removed poorly documented assets support with broken tests.
 * Removed memcache as the service was never made it past alpha.

Users of memcache should consider using
[Cloud Memorystore](https://cloud.google.com/memorystore/) instead. This comes
with a redis interface for which there are multiple packages available on pub.
Serving assets is just a matter of sending a file from disk. This is easy to do
without the logic that this package used to contain.

## 0.5.1+1

* Support latest `pkg:http` and `pkg:http2`.

## 0.5.1

* Correct root path for serving assets.

## 0.5.0

* Support for Dart 2.0 constants and updated gcloud.

## 0.4.4+2

* Fix race condition in gRPC client between `http2Connection.isOpen` and
  `http2Connection.makeRequest`.

## 0.4.4+1

* Delay http/2 connection dialer by 20 ms to give client enough time to receive
  server settings.

## 0.4.4

* Improve output logging when memcache connections fail.
* Fix Dart 2 runtime issues.

## 0.4.3+1

* When logging requests, the `appengine.googleapis.com/trace_id` label
  is populated.

## 0.4.3

* When logging, the following `protoPayload` values are now populated:
  * `instanceId`
  * `referrer`
  * `traceId` via the `X-Cloud-Trace-Context` request header.

* The `appengine.googleapis.com/instance_name` label is also populated for
  all log entries.

* `traceId` was also added to the `ClientContext` class.

## 0.4.2

* Add support for connecting to memcache instance defined by environment
  variables `GAE_MEMCACHE_HOST` and `GAE_MEMCACHE_PORT`.

## 0.4.1

* Add `shared` option to `runAppEngine` to enable multi-threaded operation
  with isolates.

## 0.4.0+3

* Fix an issue where models with un-indexed list properties could not be
  committed.

## 0.4.0+2

* Be less verbose in request logs printed during local development

## 0.4.0

Switch from Managed VMs to Flexible environment:

* Removed `UsersService` api.
* Removed `ModulesService` api.
* Removed `RemoteApi` api (was already deprecated).
* Introduce new GCLOUD\_PROJECT and GCLOUD\_KEY environment variables.
* Remove STORAGE\_SERVICE\_ACCOUNT\_FILE environment variable.
* To prevent duplicate logging of errors, `runAppEngine` will no longer log
  request-specific errors on stdout if they got already logged via the
  request-specific log.

## 0.3.3+1

* Support `gcloud` package version `0.3.0`.

## 0.3.3

* Work around dev\_appserver.py issue (it doesn't drain stdout we therefore avoid
  printing anything).

## 0.3.2

* Require `protobuf` package `^0.5.0`
* Support the lastest release of `fixnum` package.

## 0.3.1+1

* Improved output of `Logger.root` with `useLoggingPackageAdaptor`.

## 0.3.1

* Added optional `port` argument to `runAppEngine`.
* Removed the call to `/bin/hostname`.

## 0.3.0+1

* Widen dependency constraint on `package:logging`.

## 0.3.0

* Pass the memcache expiration time to the memcache service. Before the
  expiration argument to Memcache.set and Memcache.setAll was ignored.

* Removed the expiration argument to Memcache.clear. It is not supported by
  the App Engine memcache API.

## 0.2.6+3

* Update dependencies to allow gcloud 0.2.0 with Cloud Pub/Sub support.

## 0.2.6+2

* Do not close `authClient`, since `registerStorageService` does it
  automatically.

## 0.2.6+1

* Correctly handling `x-appengine-https` header.
* Turn logging of for Level.OFF

## 0.2.6

* Added adaptor for `package:logging` via `useLoggingPackageAdaptor()`.
* Added workaround for incorrect `requestedUri` comming from 'dart:io'.

## 0.2.5

* Added withAppEngineServices() function which allows running arbitrary code
  using AppEngine services via a service scope.

## 0.2.4+1

* Change the service scope keys keys to non-private symbols.

## 0.2.4

* Run request handlers inside a service scope
(see `package:gcloud/service_scope.dart`).
* Insert an authenticated HTTP client into the service scope.
* Insert a `memcacheService` into the service scope.
* Added `isDevelopmentServer` and `isProductionEnvironment` getter to client
context.
* Make hostnames returned from modules service use -dot- naming to support
HTTPS.
* Mark `package:appengine/remote_api.dart` as deprecated.

## 0.2.3

* Small bugfix in the lowlevel memcache API implementation.

## 0.2.2

* Updated `README.md`
* Widen googleapis_auth constraint to include version 0.2.0

## 0.2.1

* Small bugfix in storage API implementation
* respect DART_PUB_SERVE url only in developer mode
* sync db/datastore tests to the ones used in gcloud

## 0.2.0

* Use datastore/db APIs from package:gcloud
    * simplified annotation system
    * paging-based query API
* Added module service
* Some bugfixes

## 0.1.0

* Alpha release
