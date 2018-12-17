Retry for dart
==============

This package provides an easy way to retry asynchronous functions. This is
often useful to avoid crashing on intermittent errors such as broken
connections or temporarily overloaded servers.


## Using `retry`
For simple retry logic with exponential back-off use the `retry` function
provided by this package.

```dart
import 'package:retry/retry.dart';

final response = await retry(
  // Make a GET request
  () => http.get('https://google.com').timeout(Duration(seconds: 5)),
  // Retry on SocketException or TimeoutException
  retryIf: (e) => e is SocketException || e is TimeoutException,
);
print(response.body);
```

Defaults to 8 attempts, sleeping as following after 1st, 2nd, 3rd, ...,
7th attempt:
 1. 400 ms +/- 25%
 2. 800 ms +/- 25%
 3. 1600 ms +/- 25%
 4. 3200 ms +/- 25%
 5. 6400 ms +/- 25%
 6. 12800 ms +/- 25%
 7. 25600 ms +/- 25%


## Using `RetryOptions`
This package provides `RetryOptions` which defined how many times to retry
an function and how long to sleep between retries.

```dart
final r = RetryOptions(attempts: 8);
final response = await r.retry(
  // Make a GET request
  () => http.get('https://google.com').timeout(Duration(seconds: 5)),
  // Retry on SocketException or TimeoutException
  retryIf: (e) => e is SocketException || e is TimeoutException,
);
print(response.body);
```
