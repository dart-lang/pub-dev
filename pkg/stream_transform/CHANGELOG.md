## 0.0.9

- Add `asyncMapBuffer`.

## 0.0.8

- Add `takeUntil`.

## 0.0.7

- Bug Fix: Streams produced with `scan` and `switchMap` now correctly report
  `isBroadcast`.
- Add `startWith`, `startWithMany`, and `startWithStream`.

## 0.0.6

- Bug Fix: Some transformers did not correctly add data to all listeners on
  broadcast streams. Fixed for `throttle`, `debounce`, `asyncWhere` and `audit`.
- Bug Fix: Only call the `tap` data callback once per event rather than once per
  listener.
- Bug Fix: Allow canceling and re-listening to broadcast streams after a
  `merge` transform.
- Bug Fix: Broadcast streams which are buffered using a single-subscription
  trigger can be canceled and re-listened.
- Bug Fix: Buffer outputs one more value if there is a pending trigger before
  the trigger closes.
- Bug Fix: Single-subscription streams concatted after broadcast streams are
  handled correctly.
- Use sync `StreamControllers` for forwarding where possible.

## 0.0.5

- Bug Fix: Allow compiling switchLatest with Dart2Js.
- Add `asyncWhere`: Like `where` but allows an asynchronous predicate.

## 0.0.4
- Add `scan`: fold which returns intermediate values
- Add `throttle`: block events for a duration after emitting a value
- Add `audit`: emits the last event received after a duration

## 0.0.3

- Add `tap`: React to values as they pass without being a subscriber on a stream
- Add `switchMap` and `switchLatest`: Flatten a Stream of Streams into a Stream
  which forwards values from the most recent Stream

## 0.0.2

- Add `concat`: Appends streams in series
- Add `merge` and `mergeAll`: Interleaves streams

## 0.0.1

- Initial release with the following utilities:
  - `buffer`: Collects events in a `List` until a `trigger` stream fires.
  - `debounce`, `debounceBuffer`: Collect or drop events which occur closer in
    time than a given duration.
