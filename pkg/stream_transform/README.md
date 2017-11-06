Utility methods to create `StreamTransfomer` instances to manipulate Streams.

# asyncMapBuffer

Like `asyncMap` but events are buffered until previous events have been
processed.

# asyncWhere

Like `where` but allows an asynchronous predicate.

# audit

Audit waits for a period of time after receiving a value and then only emits
the most recent value.

# buffer

Collects values from a source stream until a `trigger` stream fires and the
collected values are emitted.

# concat

Appends the values of a stream after another stream finishes.

# debounce, debounceBuffer

Prevents a source stream from emitting too frequently by dropping or collecting
values that occur within a given duration.

# merge, mergeAll

Interleaves events from multiple streams into a single stream.

# scan

Scan is like fold, but instead of producing a single value it yields each
intermediate accumulation.

# startWith, startWithMany, startWithStream

Prepend a value, an iterable, or a stream to the beginning of another stream.

# switchMap, switchLatest

Flatten a Stream of Streams into a Stream which forwards values from the most
recent Stream

# takeUntil

Let values through until a Future fires.

# tap

Taps into a single-subscriber stream to react to values as they pass, without
being a real subscriber.

# throttle

Blocks events for a duration after an event is successfully emitted.
