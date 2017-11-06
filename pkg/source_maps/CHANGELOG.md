## 0.10.4
* Implement `highlight` in `SourceMapFileSpan`.
* Require version `^1.3.0` of `source_span`.

## 0.10.3
 * Add `addMapping` and `containsMapping` members to `MappingBundle`.

## 0.10.2
 * Support for extended source map format.
 * Polish `MappingBundle.spanFor` handling of URIs that have a suffix that
   exactly match a source map in the MappingBundle.

## 0.10.1+5
 * Fix strong mode warning in test.

## 0.10.1+4

* Extend `MappingBundle.spanFor` to accept requests for output files that
  don't have source maps.

## 0.10.1+3

* Add `MappingBundle` class that handles extended source map format that
  supports source maps for multiple output files in a single mapper.
  Extend `Mapping.spanFor` API to accept a uri parameter that is optional
  for normal source maps but required for MappingBundle source maps.

## 0.10.1+2

* Fix more strong mode warnings.

## 0.10.1+1

* Fix all strong mode warnings.

## 0.10.1

* Add a `mapUrl` named argument to `parse` and `parseJson`. This argument is
  used to resolve source URLs for source spans.

## 0.10.0+2

* Fix analyzer error (FileSpan has a new field since `source_span` 1.1.1)

## 0.10.0+1

* Remove an unnecessary warning printed when the "file" field is missing from a
  Json formatted source map. This field is optional and its absence is not
  unusual.

## 0.10.0

* Remove the `Span`, `Location` and `SourceFile` classes. Use the
  corresponding `source_span` classes instead.

## 0.9.4

* Update `SpanFormatException` with `source` and `offset`.

* All methods that take `Span`s, `Location`s, and `SourceFile`s as inputs now
  also accept the corresponding `source_span` classes as well. Using the old
  classes is now deprecated and will be unsupported in version 0.10.0.

## 0.9.3

* Support writing SingleMapping objects to source map version 3 format.
* Support the `sourceRoot` field in the SingleMapping class.
* Support updating the `targetUrl` field in the SingleMapping class.

## 0.9.2+2

* Fix a bug in `FixedSpan.getLocationMessage`.

## 0.9.2+1

* Minor readability improvements to `FixedSpan.getLocationMessage` and
  `SpanException.toString`.

## 0.9.2

* Add `SpanException` and `SpanFormatException` classes.

## 0.9.1

* Support unmapped areas in source maps.

* Increase the readability of location messages.
