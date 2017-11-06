## 0.4.0+1

* Made a number of strong-mode improvements.

* Updated dependency on `googleapis` and `googleapis_beta`.

## 0.4.0

* Remove support for `FilterRelation.In` and "propertyname IN" for queries:
  This is not supported by the newer APIs and was originally part of fat-client
  libraries which performed multiple queries for each iten in the list.

* Adds optional `forComparision` named argument to `Property.encodeValue` which
  will be set to `true` when encoding a value for comparison in queries.

* Upgrade to newer versions of `package:googleapis` and `package:googleapis_beta`

## 0.3.0

* Upgrade to use stable `package:googleapis/datastore/v1.dart`.

* The internal [DatastoreImpl] class takes now a project name without the `s~`
  prefix.

## 0.2.0+14

* Fix analyzer warning.

## 0.2.0+13

* Remove crypto dependency and upgrade dart dependency to >=1.13 since
  this dart version provides the Base64 codec.

## 0.2.0+11

* Throw a [StateError] in case a query returned a kind for which there was no
  model registered.

## 0.2.0+10

* Address analyzer warnings.

## 0.2.0+9

* Support value transformation in `db.query().filter()`.
* Widen constraint on `googleapis` and `googleapis_beta`.

## 0.2.0+8

* Widen constraint on `googleapis` and `googleapis_beta`.

## 0.2.0+4

* `Storage.read` now honors `offset` and `length` arguments.

## 0.2.0+2

* Widen constraint on `googleapis/googleapis_beta`

## 0.2.0+1

* Fix broken import of package:googleapis/common/common.dart.

## 0.2.0

* Add support for Cloud Pub/Sub.
* Require Dart version 1.9.

## 0.1.4+2

* Enforce fully populated entity keys in a number of places.

## 0.1.4+1

* Deduce the query partition automatically from query ancestor key.

## 0.1.4

* Added optional `defaultPartition` parameter to the constructor of
  `DatastoreDB`.

## 0.1.3+2

* Widened googleapis/googleapis_beta constraints in pubspec.yaml.

## 0.1.3+1

* Change the service scope keys keys to non-private symbols.

## 0.1.3

* Widen package:googleapis dependency constraint in pubspec.yaml.
* Bugfix in `package:appengine/db.dart`: Correctly handle ListProperties
of length 1.

## 0.1.2

* Introduced `package:gcloud/service_scope.dart` library.
* Added global getters for getting gcloud services from the current service
scope.
* Added an `package:gcloud/http.dart` library using service scopes.

## 0.1.1

* Increased version constraint on googleapis{,_auth,_beta}.

* Removed unused imports.

## 0.1.0

* First release.
