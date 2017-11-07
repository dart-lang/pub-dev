## 1.6.2

* Declare support for `async` 2.0.0.

## 1.6.1

* Fix the type of `StreamChannel.transform()`. This previously inverted the
  generic parameters, so it only really worked with transformers where both
  generic types were identical.

## 1.6.0

* `Disconnector.disconnect()` now returns a future that completes when all the
  inner `StreamSink.close()` futures have completed.

## 1.5.0

* Add `new StreamChannel.withCloseGuarantee()` to provide the specific guarantee
  that closing the sink causes the stream to close before it emits any more
  events. This is the only guarantee that isn't automatically preserved when
  transforming a channel.

* `StreamChannelTransformer`s provided by the `stream_channel` package now
  properly provide the guarantee that closing the sink causes the stream to
  close before it emits any more events

## 1.4.0

* Add `StreamChannel.cast()`, which soundly coerces the generic type of a
  channel.

* Add `StreamChannelTransformer.typed()`, which soundly coerces the generic type
  of a transformer.

## 1.3.2

* Fix all strong-mode errors and warnings.

## 1.3.1

* Make `IsolateChannel` slightly more efficient.

* Make `MultiChannel` follow the stream channel rules.

## 1.3.0

* Add `Disconnector`, a transformer that allows the caller to disconnect the
  transformed channel.

## 1.2.0

* Add `new StreamChannel.withGuarantees()`, which creates a channel with extra
  wrapping to ensure that it obeys the stream channel guarantees.

* Add `StreamChannelController`, which can be used to create custom
  `StreamChannel` objects.

## 1.1.1

* Fix the type annotation for `StreamChannel.transform()`'s parameter.

## 1.1.0

* Add `StreamChannel.transformStream()`, `StreamChannel.transformSink()`,
  `StreamChannel.changeStream()`, and `StreamChannel.changeSink()` to support
  changing only the stream or only the sink of a channel.

* Be more explicit about `JsonDocumentTransformer`'s error-handling behavior.

## 1.0.1

* Fix `MultiChannel`'s constructor to take a `StreamChannel`. This is
  technically a breaking change, but since 1.0.0 was only released an hour ago,
  we're treating it as a bug fix.

## 1.0.0

* Initial version
