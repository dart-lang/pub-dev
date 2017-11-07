## 0.5.5

* Use real generic syntax instead of comment-based.
* Support v2 dev SDKs.

## 0.5.4

* Unknown enum values are ignored when parsing JSON, instead of throwing an
  exception.

## 0.5.3+2

* Resolved a strong-mode error.

## 0.5.3+1

* Performance: Avoid excessive cloning in merge.
* Performance: Use code patterns that dart2js handles better.

## 0.5.3

* fix zigzag function so all coded buffer reader tests work on dart2js.

## 0.5.2

* make PbMixin constructor public for use within protoc plugin.

## 0.5.1+5

* Revert previous change because it causes strong mode type error
in the generated code. We will revisit this in a new version of
mixin support.

## 0.5.1+4

* Use a more refined implementation of `Map` in `PbMapMixin`

## 0.5.1+3

* Performance: eliminate some dynamic calls.

## 0.5.1+2

* Bugfix: remove dependency on `pkg/crypto` for real.

## 0.5.1+1

* Require at least Dart SDK 1.13.

* Removed dependency on `pkg/crypto`.

## 0.5.1

* Experimental support for strong mode.
* Fixed an issue with GeneratedMessage operator== and Map mixins
* Added declaration of GeneratedMessage clone method

## 0.5.0+1

* Support the latest version of package `fixnum`.

## 0.5.0
 * Reorganized internals to improve performance. We now store
   field values in a list instead of a map. Private properties
   and methods are all moved to the \_FieldSet class. There
   are new entry points for generated getters, hazzers, and
   setters. Improved JSON decoding performance.
 * Dropped compatibility with .pb.dart files before 0.4.2
   by removing internal constants from GeneratedMessage. Also,
   protoc plugins before 0.5.0 won't work.

## 0.4.2
 * Renamed FieldType to PbFieldType.

## 0.4.1 - DO NOT USE
 * added FieldType class. It turned out that FieldType is a
   commonly used name, even in .proto files. This is renamed to
   PbFieldType in 0.4.2.
 * Added support for observing field changes.
   For now, this can only be enabled by using a mixin to override
   the eventPlugin getter.
 * Removed optional third parameter from setField().
   It was only intended for internal use, and could be used to
   defeat type checks on fields.
 * clearExtension() removes the value and extension in all cases.
   (Before, the extension would be kept and the list cleared
   for repeated fields.)
 * Upcoming: clearField() will require its argument to be a known
   tag number (which could be an extension). For now, this is only
   enforced when a mixin provides an eventPlugin.

## 0.4.0
 * Add ReadonlyMessageMixin. The generated message classes use this to
   for the default values of message fields.

## 0.3.11
 * Add meta.dart which declares reserved names for the plugin.

## 0.3.10
 * Add GeneratedService and ProtobufClient interfaces.

## 0.3.9
 * Add experimental mixins_meta library
 * Add experimental PbMapMixin class (in a separate library).
 * Fix bug where ExtensionRegistry would not be used for nested messages.

## 0.3.7
 * More docs.

## 0.3.6
 * Added mergeFromMap() and writeToJsonMap()
 * Fixed an analyzer warning.

## 0.3.5+3
 * Bugfix for `setRange()`: Do not assume Iterable has a `sublist()` method.

## 0.3.5+2
 * Simplify some types used in is checks and correct PbList to match the
 * signature of the List setRange method.

## 0.3.5+1

 * Bugfix for incorrect decoding of protobuf messages: Uint8List views with
   non-zero offsets were handled incorrectly.

## 0.3.5

 * Allow constants as field initial values as well as creation thunks to reduce
   generated code size.

 * Improve the performance of reading a protobuf buffer.

 * Fixed truncation error in least significant bits with large Int64 constants.
