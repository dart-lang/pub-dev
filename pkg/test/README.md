`test` provides a standard way of writing and running tests in Dart.

* [Writing Tests](#writing-tests)
* [Running Tests](#running-tests)
  * [Restricting Tests to Certain Platforms](#restricting-tests-to-certain-platforms)
  * [Platform Selectors](#platform-selectors)
  * [Running Tests on Dartium](#running-tests-on-dartium)
  * [Running Tests on Node.js](#running-tests-on-nodejs)
* [Asynchronous Tests](#asynchronous-tests)
  * [Stream Matchers](#stream-matchers)
* [Running Tests With Custom HTML](#running-tests-with-custom-html)
* [Configuring Tests](#configuring-tests)
  * [Skipping Tests](#skipping-tests)
  * [Timeouts](#timeouts)
  * [Platform-Specific Configuration](#platform-specific-configuration)
  * [Whole-Package Configuration](#whole-package-configuration)
* [Tagging Tests](#tagging-tests)
* [Debugging](#debugging)
* [Browser/VM Hybrid Tests](#browservm-hybrid-tests)
* [Support for Other Packages](#support-for-other-packages)
  * [`term_glyph`](#term_glyph)
  * [`barback`](#barback)
* [Further Reading](#further-reading)

## Writing Tests

Tests are specified using the top-level [`test()`][test] function, and test
assertions are made using [`expect()`][expect]:

[test]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_test
[expect]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_expect

```dart
import "package:test/test.dart";

void main() {
  test("String.split() splits the string on the delimiter", () {
    var string = "foo,bar,baz";
    expect(string.split(","), equals(["foo", "bar", "baz"]));
  });

  test("String.trim() removes surrounding whitespace", () {
    var string = "  foo ";
    expect(string.trim(), equals("foo"));
  });
}
```

Tests can be grouped together using the [`group()`][group] function. Each
group's description is added to the beginning of its test's descriptions.

[group]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_group

```dart
import "package:test/test.dart";

void main() {
  group("String", () {
    test(".split() splits the string on the delimiter", () {
      var string = "foo,bar,baz";
      expect(string.split(","), equals(["foo", "bar", "baz"]));
    });

    test(".trim() removes surrounding whitespace", () {
      var string = "  foo ";
      expect(string.trim(), equals("foo"));
    });
  });

  group("int", () {
    test(".remainder() returns the remainder of division", () {
      expect(11.remainder(3), equals(2));
    });

    test(".toRadixString() returns a hex string", () {
      expect(11.toRadixString(16), equals("b"));
    });
  });
}
```

Any matchers from the [`matcher`][matcher] package can be used with `expect()`
to do complex validations:

[matcher]: http://www.dartdocs.org/documentation/matcher/latest/index.html#matcher/matcher

```dart
import "package:test/test.dart";

void main() {
  test(".split() splits the string on the delimiter", () {
    expect("foo,bar,baz", allOf([
      contains("foo"),
      isNot(startsWith("bar")),
      endsWith("baz")
    ]));
  });
}
```

You can use the [`setUp()`][setUp] and [`tearDown()`][tearDown] functions to
share code between tests. The `setUp()` callback will run before every test in a
group or test suite, and `tearDown()` will run after. `tearDown()` will run even
if a test fails, to ensure that it has a chance to clean up after itself.

```dart
import "package:test/test.dart";

void main() {
  var server;
  var url;
  setUp(() async {
    server = await HttpServer.bind('localhost', 0);
    url = Uri.parse("http://${server.address.host}:${server.port}");
  });

  tearDown(() async {
    await server.close(force: true);
    server = null;
    url = null;
  });

  // ...
}
```

[setUp]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_setUp
[tearDown]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_tearDown

## Running Tests

A single test file can be run just using `pub run test path/to/test.dart`.

![Single file being run via "pub run"](https://raw.githubusercontent.com/dart-lang/test/master/image/test1.gif)

Many tests can be run at a time using `pub run test path/to/dir`.

![Directory being run via "pub run".](https://raw.githubusercontent.com/dart-lang/test/master/image/test2.gif)

It's also possible to run a test on the Dart VM only by invoking it using `dart
path/to/test.dart`, but this doesn't load the full test runner and will be
missing some features.

The test runner considers any file that ends with `_test.dart` to be a test
file. If you don't pass any paths, it will run all the test files in your
`test/` directory, making it easy to test your entire application at once.

You can select specific tests cases to run by name using `pub run test -n "test
name"`. The string is interpreted as a regular expression, and only tests whose
description (including any group descriptions) match that regular expression
will be run. You can also use the `-N` flag to run tests whose names contain a
plain-text string.

By default, tests are run in the Dart VM, but you can run them in the browser as
well by passing `pub run test -p chrome path/to/test.dart`. `test` will take
care of starting the browser and loading the tests, and all the results will be
reported on the command line just like for VM tests. In fact, you can even run
tests on both platforms with a single command: `pub run test -p "chrome,vm"
path/to/test.dart`.

### Restricting Tests to Certain Platforms

Some test files only make sense to run on particular platforms. They may use
`dart:html` or `dart:io`, they might test Windows' particular filesystem
behavior, or they might use a feature that's only available in Chrome. The
[`@TestOn`][TestOn] annotation makes it easy to declare exactly which platforms
a test file should run on. Just put it at the top of your file, before any
`library` or `import` declarations:

```dart
@TestOn("vm")

import "dart:io";

import "package:test/test.dart";

void main() {
  // ...
}
```

[TestOn]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test.TestOn

The string you pass to `@TestOn` is what's called a "platform selector", and it
specifies exactly which platforms a test can run on. It can be as simple as the
name of a platform, or a more complex Dart-like boolean expression involving
these platform names.

You can also declare that your entire package only works on certain platforms by
adding a [`test_on` field][test_on] to your package config file.

[test_on]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#test_on

### Platform Selectors

Platform selectors use the [boolean selector syntax][] defined in the
[`boolean_selector` package][boolean_selector], which is a subset of Dart's
expression syntax that only supports boolean operations. The following
identifiers are defined:

[boolean selector syntax]: https://github.com/dart-lang/boolean_selector/blob/master/README.md

[boolean_selector]: https://pub.dartlang.org/packages/boolean_selector

* `vm`: Whether the test is running on the command-line Dart VM.

* `dartium`: Whether the test is running on Dartium.

* `content-shell`: Whether the test is running on the headless Dartium content
  shell.

* `chrome`: Whether the test is running on Google Chrome.

* `phantomjs`: Whether the test is running on
  [PhantomJS](http://phantomjs.org/).

* `firefox`: Whether the test is running on Mozilla Firefox.

* `safari`: Whether the test is running on Apple Safari.

* `ie`: Whether the test is running on Microsoft Internet Explorer.

* `node`: Whether the test is running on Node.js.

* `dart-vm`: Whether the test is running on the Dart VM in any context,
  including Dartium. It's identical to `!js`.

* `browser`: Whether the test is running in any browser.

* `js`: Whether the test has been compiled to JS. This is identical to
  `!dart-vm`.

* `blink`: Whether the test is running in a browser that uses the Blink
  rendering engine.

* `windows`: Whether the test is running on Windows. If `vm` is false, this will
  be `false` as well.

* `mac-os`: Whether the test is running on Mac OS. If `vm` is false, this will
  be `false` as well.

* `linux`: Whether the test is running on Linux. If `vm` is false, this will be
  `false` as well.

* `android`: Whether the test is running on Android. If `vm` is false, this will
  be `false` as well, which means that this *won't* be true if the test is
  running on an Android browser.

* `ios`: Whether the test is running on iOS. If `vm` is false, this will be
  `false` as well, which means that this *won't* be true if the test is running
  on an iOS browser.

* `posix`: Whether the test is running on a POSIX operating system. This is
  equivalent to `!windows`.

For example, if you wanted to run a test on every browser but Chrome, you would
write `@TestOn("browser && !chrome")`.

### Running Tests on Dartium

Tests can be run on [Dartium][] by passing the `-p dartium` flag. If you're
using Mac OS, you can [install Dartium using Homebrew][homebrew]. Otherwise,
make sure there's an executable called `dartium` (on Mac OS or Linux) or
`dartium.exe` (on Windows) on your system path.

[Dartium]: https://www.dartlang.org/tools/dartium/
[homebrew]: https://github.com/dart-lang/homebrew-dart

Similarly, tests can be run on the headless Dartium content shell by passing `-p
content-shell`. The content shell is installed along with Dartium when using
Homebrew. Otherwise, you can downloaded it manually [from this
page][content_shell]; if you do, make sure the executable named `content_shell`
(on Mac OS or Linux) or `content_shell.exe` (on Windows) is on your system path.
Note content_shell on linux requires the font packages ttf-kochi-mincho and ttf-kochi-gothic.

[content_shell]: http://gsdview.appspot.com/dart-archive/channels/stable/release/latest/dartium/

[In the future][issue 63], there will be a more explicit way to configure the
location of both the Dartium and content shell executables.

[issue 63]: https://github.com/dart-lang/test/issues/63

### Running Tests on Node.js

The test runner also supports compiling tests to JavaScript and running them on
[Node.js][] by passing `--platform node`. Note that Node has access to *neither*
`dart:html` nor `dart:io`, so any platform-specific APIs will have to be invoked
using [the `js` package][js]. However, it may be useful when testing APIs
that are meant to be used by JavaScript code.

[Node.js]: https://nodejs.org/en/
[js]: https://pub.dartlang.org/packages/js

The test runner looks for an executable named `node` (on Mac OS or Linux) or
`node.exe` (on Windows) on your system path. When compiling Node.js tests, it
passes `-Dnode=true`, so tests can determine whether they're running on Node
using [`const bool.fromEnvironment("node")`][bool.fromEnvironment].

[bool.fromEnvironment]: https://api.dartlang.org/stable/1.24.2/dart-core/bool/bool.fromEnvironment.html

## Asynchronous Tests

Tests written with `async`/`await` will work automatically. The test runner
won't consider the test finished until the returned `Future` completes.

```dart
import "dart:async";

import "package:test/test.dart";

void main() {
  test("new Future.value() returns the value", () async {
    var value = await new Future.value(10);
    expect(value, equals(10));
  });
}
```

There are also a number of useful functions and matchers for more advanced
asynchrony. The [`completion()`][completion] matcher can be used to test
`Futures`; it ensures that the test doesn't finish until the `Future` completes,
and runs a matcher against that `Future`'s value.

[completion]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_completion

```dart
import "dart:async";

import "package:test/test.dart";

void main() {
  test("new Future.value() returns the value", () {
    expect(new Future.value(10), completion(equals(10)));
  });
}
```

The [`throwsA()`][throwsA] matcher and the various `throwsExceptionType`
matchers work with both synchronous callbacks and asynchronous `Future`s. They
ensure that a particular type of exception is thrown:

[throwsA]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_throwsA

```dart
import "dart:async";

import "package:test/test.dart";

void main() {
  test("new Future.error() throws the error", () {
    expect(new Future.error("oh no"), throwsA(equals("oh no")));
    expect(new Future.error(new StateError("bad state")), throwsStateError);
  });
}
```

The [`expectAsync()`][expectAsync] function wraps another function and has two
jobs. First, it asserts that the wrapped function is called a certain number of
times, and will cause the test to fail if it's called too often; second, it
keeps the test from finishing until the function is called the requisite number
of times.

```dart
import "dart:async";

import "package:test/test.dart";

void main() {
  test("Stream.fromIterable() emits the values in the iterable", () {
    var stream = new Stream.fromIterable([1, 2, 3]);

    stream.listen(expectAsync1((number) {
      expect(number, inInclusiveRange(1, 3));
    }, count: 3));
  });
}
```

[expectAsync]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_expectAsync

### Stream Matchers

The `test` package provides a suite of powerful matchers for dealing with
[asynchronous streams][Stream]. They're expressive and composable, and make it
easy to write complex expectations about the values emitted by a stream. For
example:

[Stream]: https://api.dartlang.org/stable/dart-async/Stream-class.html

```dart
import "dart:async";

import "package:test/test.dart";

void main() {
  test("process emits status messages", () {
    // Dummy data to mimic something that might be emitted by a process.
    var stdoutLines = new Stream.fromIterable([
      "Ready.",
      "Loading took 150ms.",
      "Succeeded!"
    ]);

    expect(stdoutLines, emitsInOrder([
      // Values match individual events.
      "Ready.",

      // Matchers also run against individual events.
      startsWith("Loading took"),

      // Stream matchers can be nested. This asserts that one of two events are
      // emitted after the "Loading took" line.
      emitsAnyOf(["Succeeded!", "Failed!"]),

      // By default, more events are allowed after the matcher finishes
      // matching. This asserts instead that the stream emits a done event and
      // nothing else.
      emitsDone
    ]));
  });
}
```

A stream matcher can also match the [`async`][async] package's
[`StreamQueue`][StreamQueue] class, which allows events to be requested from a
stream rather than pushed to the consumer. The matcher will consume the matched
events, but leave the rest of the queue alone so that it can still be used by
the test, unlike a normal `Stream` which can only have one subscriber. For
example:

[async]: https://pub.dartlang.org/packages/async
[StreamQueue]: https://www.dartdocs.org/documentation/async/latest/async/StreamQueue-class.html

```dart
import "dart:async";

import "package:async/async.dart";
import "package:test/test.dart";

void main() {
  test("process emits a WebSocket URL", () async {
    // Wrap the Stream in a StreamQueue so that we can request events.
    var stdout = new StreamQueue(new Stream.fromIterable([
      "WebSocket URL:",
      "ws://localhost:1234/",
      "Waiting for connection..."
    ]));

    // Ignore lines from the process until it's about to emit the URL.
    await expect(stdout, emitsThrough("WebSocket URL:"));

    // Parse the next line as a URL.
    var url = Uri.parse(await stdout.next);
    expect(url.host, equals('localhost'));

    // You can match against the same StreamQueue multiple times.
    await expect(stdout, emits("Waiting for connection..."));
  });
}
```

The following built-in stream matchers are available:

* [`emits()`][emits] matches a single data event.
* [`emitsError()`][emitsError] matches a single error event.
* [`emitsDone`][emitsDone] matches a single done event.
* [`mayEmit()`][mayEmit] consumes events if they match an inner matcher, without
  requiring them to match.
* [`mayEmitMultiple()`][mayEmitMultiple] works like `mayEmit()`, but it matches
  events against the matcher as many times as possible.
* [`emitsAnyOf()`][emitsAnyOf] consumes events matching one (or more) of several
  possible matchers.
* [`emitsInOrder()`][emitsInOrder] consumes events matching multiple matchers in
  a row.
* [`emitsInAnyOrder()`][emitsInAnyOrder] works like `emitsInOrder()`, but it
  allows the matchers to match in any order.
* [`neverEmits()`][neverEmits] matches a stream that finishes *without* matching
  an inner matcher.

You can also define your own custom stream matchers by calling
[`new StreamMatcher()`][new StreamMatcher].

[emits]: https://www.dartdocs.org/documentation/test/latest/test/emits.html
[emitsError]: https://www.dartdocs.org/documentation/test/latest/test/emitsError.html
[emitsDone]: https://www.dartdocs.org/documentation/test/latest/test/emitsDone.html
[mayEmit]: https://www.dartdocs.org/documentation/test/latest/test/mayEmit.html
[mayEmitMultiple]: https://www.dartdocs.org/documentation/test/latest/test/mayEmitMultiple.html
[emitsAnyOf]: https://www.dartdocs.org/documentation/test/latest/test/emitsAnyOf.html
[emitsInOrder]: https://www.dartdocs.org/documentation/test/latest/test/emitsInOrder.html
[emitsInAnyOrder]: https://www.dartdocs.org/documentation/test/latest/test/emitsInAnyOrder.html
[neverEmits]: https://www.dartdocs.org/documentation/test/latest/test/neverEmits.html
[new StreamMatcher]: https://www.dartdocs.org/documentation/test/latest/test/StreamMatcher/StreamMatcher.html

## Running Tests With Custom HTML

By default, the test runner will generate its own empty HTML file for browser
tests. However, tests that need custom HTML can create their own files. These
files have three requirements:

* They must have the same name as the test, with `.dart` replaced by `.html`.

* They must contain a `link` tag with `rel="x-dart-test"` and an `href`
  attribute pointing to the test script.

* They must contain `<script src="packages/test/dart.js"></script>`.

For example, if you had a test called `custom_html_test.dart`, you might write
the following HTML file:

```html
<!doctype html>
<!-- custom_html_test.html -->
<html>
  <head>
    <title>Custom HTML Test</title>
    <link rel="x-dart-test" href="custom_html_test.dart">
    <script src="packages/test/dart.js"></script>
  </head>
  <body>
    // ...
  </body>
</html>
```

## Configuring Tests

### Skipping Tests

If a test, group, or entire suite isn't working yet and you just want it to stop
complaining, you can mark it as "skipped". The test or tests won't be run, and,
if you supply a reason why, that reason will be printed. In general, skipping
tests indicates that they should run but is temporarily not working. If they're
is fundamentally incompatible with a platform, [`@TestOn`/`testOn`][TestOn]
should be used instead.

[TestOn]: #restricting-tests-to-certain-platforms

To skip a test suite, put a `@Skip` annotation at the top of the file:

```dart
@Skip("currently failing (see issue 1234)")

import "package:test/test.dart";

void main() {
  // ...
}
```

The string you pass should describe why the test is skipped. You don't have to
include it, but it's a good idea to document why the test isn't running.

Groups and individual tests can be skipped by passing the `skip` parameter. This
can be either `true` or a String describing why the test is skipped. For example:

```dart
import "package:test/test.dart";

void main() {
  group("complicated algorithm tests", () {
    // ...
  }, skip: "the algorithm isn't quite right");

  test("error-checking test", () {
    // ...
  }, skip: "TODO: add error-checking.");
}
```

### Timeouts

By default, tests will time out after 30 seconds of inactivity. However, this
can be configured on a per-test, -group, or -suite basis. To change the timeout
for a test suite, put a `@Timeout` annotation at the top of the file:

```dart
@Timeout(const Duration(seconds: 45))

import "package:test/test.dart";

void main() {
  // ...
}
```

In addition to setting an absolute timeout, you can set the timeout relative to
the default using `@Timeout.factor`. For example, `@Timeout.factor(1.5)` will
set the timeout to one and a half times as long as the default—45 seconds.

Timeouts can be set for tests and groups using the `timeout` parameter. This
parameter takes a `Timeout` object just like the annotation. For example:

```dart
import "package:test/test.dart";

void main() {
  group("slow tests", () {
    // ...

    test("even slower test", () {
      // ...
    }, timeout: new Timeout.factor(2))
  }, timeout: new Timeout(new Duration(minutes: 1)));
}
```

Nested timeouts apply in order from outermost to innermost. That means that
"even slower test" will take two minutes to time out, since it multiplies the
group's timeout by 2.

### Platform-Specific Configuration

Sometimes a test may need to be configured differently for different platforms.
Windows might run your code slower than other platforms, or your DOM
manipulation might not work right on Safari yet. For these cases, you can use
the `@OnPlatform` annotation and the `onPlatform` named parameter to `test()`
and `group()`. For example:

```dart
@OnPlatform(const {
  // Give Windows some extra wiggle-room before timing out.
  "windows": const Timeout.factor(2)
})

import "package:test/test.dart";

void main() {
  test("do a thing", () {
    // ...
  }, onPlatform: {
    "safari": new Skip("Safari is currently broken (see #1234)")
  });
}
```

Both the annotation and the parameter take a map. The map's keys are [platform
selectors](#platform-selector-syntax) which describe the platforms for which the
specialized configuration applies. Its values are instances of some of the same
annotation classes that can be used for a suite: `Skip` and `Timeout`. A value
can also be a list of these values.

If multiple platforms match, the configuration is applied in order from first to
last, just as they would in nested groups. This means that for configuration
like duration-based timeouts, the last matching value wins.

You can also set up global platform-specific configuration using the
[package configuration file][configuring platforms].

[configuring platforms]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#configuring-platforms

### Tagging Tests

Tags are short strings that you can associate with tests, groups, and suites.
They don't have any built-in meaning, but they're very useful nonetheless: you
can associate your own custom configuration with them, or you can use them to
easily filter tests so you only run the ones you need to.

Tags are defined using the `@Tags` annotation for suites and the `tags` named
parameter to `test()` and `group()`. For example:

```dart
@Tags(const ["browser"])

import "package:test/test.dart";

void main() {
  test("successfully launches Chrome", () {
    // ...
  }, tags: "chrome");

  test("launches two browsers at once", () {
    // ...
  }, tags: ["chrome", "firefox"]);
}
```

If the test runner encounters a tag that wasn't declared in the
[package configuration file][configuring tags], it'll print a warning, so be
sure to include all your tags there. You can also use the file to provide
default configuration for tags, like giving all `browser` tests twice as much
time before they time out.

[configuring tags]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#configuring-tags

Tests can be filtered based on their tags by passing command line flags. The
`--tags` or `-t` flag will cause the test runner to only run tests with the
given tags, and the `--exclude-tags` or `-x` flag will cause it to only run
tests *without* the given tags. These flags also support
[boolean selector syntax][]. For example, you can pass `--tags "(chrome ||
firefox) && !slow"` to select quick Chrome or Firefox tests.

Note that tags must be valid Dart identifiers, although they may also contain
hyphens.

### Whole-Package Configuration

For configuration that applies across multiple files, or even the entire
package, `test` supports a configuration file called `dart_test.yaml`. At its
simplest, this file can contain the same sort of configuration that can be
passed as command-line arguments:

```yaml
# This package's tests are very slow. Double the default timeout.
timeout: 2x

# This is a browser-only package, so test on content shell by default.
platforms: [content-shell]
```

The configuration file sets new defaults. These defaults can still be overridden
by command-line arguments, just like the built-in defaults. In the example
above, you could pass `--platform chrome` to run on Chrome instead of the
Dartium content shell.

A configuration file can do much more than just set global defaults. See
[the full documentation][package config] for more details.

[package config]: https://github.com/dart-lang/test/blob/master/doc/configuration.md

## Debugging

Tests can be debugged interactively using browsers' built-in development tools,
including Observatory when you're using Dartium. Currently there's no support
for interactively debugging command-line VM tests, but it will be added
[in the future][issue 50].

[issue 50]: https://github.com/dart-lang/test/issues/50

The first step when debugging is to pass the `--pause-after-load` flag to the
test runner. This pauses the browser after each test suite has loaded, so that
you have time to open the development tools and set breakpoints. For Dartium,
the test runner will print the Observatory URL for you. For PhantomJS, it will
print the remote debugger URL. For content shell, it'll print both!

Once you've set breakpoints, either click the big arrow in the middle of the web
page or press Enter in your terminal to start the tests running. When you hit a
breakpoint, the runner will open its own debugging console in the terminal that
controls how tests are run. You can type "restart" there to re-run your test as
many times as you need to figure out what's going on.

Normally, browser tests are run in hidden iframes. However, when debugging, the
iframe for the current test suite is expanded to fill the browser window so you
can see and interact with any HTML it renders. Note that the Dart animation may
still be visible behind the iframe; to hide it, just add a `background-color` to
the page's HTML.

## Browser/VM Hybrid Tests

Code that's written for the browser often needs to talk to some kind of server.
Maybe you're testing the HTML served by your app, or maybe you're writing a
library that communicates over WebSockets. We call tests that run code on both
the browser and the VM **hybrid tests**.

Hybrid tests use one of two functions: [`spawnHybridCode()`][spawnHybridCode] and
[`spawnHybridUri()`][spawnHybridUri]. Both of these spawn Dart VM
[isolates][dart:isolate] that can import `dart:io` and other VM-only libraries.
The only difference is where the code from the isolate comes from:
`spawnHybridCode()` takes a chunk of actual Dart code, whereas
`spawnHybridUri()` takes a URL. They both return a
[`StreamChannel`][StreamChannel] that communicates with the hybrid isolate. For
example:

[spawnHybridCode]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_spawnHybridCode
[spawnHybridUri]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_spawnHybridUri
[dart:isolate]: https://api.dartlang.org/stable/dart-isolate/dart-isolate-library.html
[StreamChannel]: https://pub.dartlang.org/packages/stream_channel

```dart
// ## test/web_socket_server.dart

// The library loaded by spawnHybridUri() can import any packages that your
// package depends on, including those that only work on the VM.
import "package:shelf/shelf_io.dart" as io;
import "package:shelf_web_socket/shelf_web_socket.dart";
import "package:stream_channel/stream_channel.dart";

// Once the hybrid isolate starts, it will call the special function
// hybridMain() with a StreamChannel that's connected to the channel
// returned spawnHybridCode().
hybridMain(StreamChannel channel) async {
  // Start a WebSocket server that just sends "hello!" to its clients.
  var server = await io.serve(webSocketHandler((webSocket) {
    webSocket.sink.add("hello!");
  }), 'localhost', 0);

  // Send the port number of the WebSocket server to the browser test, so
  // it knows what to connect to.
  channel.sink.add(server.port);
}


// ## test/web_socket_test.dart

@TestOn("browser")

import "dart:html";

import "package:test/test.dart";

void main() {
  test("connects to a server-side WebSocket", () async {
    // Each spawnHybrid function returns a StreamChannel that communicates with
    // the hybrid isolate. You can close this channel to kill the isolate.
    var channel = spawnHybridUri("web_socket_server.dart");

    // Get the port for the WebSocket server from the hybrid isolate.
    var port = await channel.stream.first;

    var socket = new WebSocket('ws://localhost:$port');
    var message = await socket.onMessage.first;
    expect(message.data, equals("hello!"));
  });
}
```

![A diagram showing a test in a browser communicating with a Dart VM isolate outside the browser.](https://raw.githubusercontent.com/dart-lang/test/master/image/hybrid.png)

**Note**: If you write hybrid tests, be sure to add a dependency on the
`stream_channel` package, since you're using its API!

## Support for Other Packages

### `term_glyph`

The [`term_glyph`][term_glyph] package provides getters for Unicode glyphs with
ASCII alternatives. `test` ensures that it's configured to produce ASCII when
the user is running on Windows, where Unicode isn't supported. This ensures that
testing libraries can use Unicode on POSIX operating systems without breaking
Windows users.

[term_glyph]: https://pub.dartlang.org/packages/term_glyph

### `barback`

Packages using the `barback` transformer system may need to test code that's
created or modified using transformers. The test runner handles this using the
`--pub-serve` option, which tells it to load the test code from a `pub serve`
instance rather than from the filesystem.

Before using the `--pub-serve` option, add the `test/pub_serve` transformer to
your `pubspec.yaml`. This transformer adds the necessary bootstrapping code that
allows the test runner to load your tests properly:

```yaml
transformers:
- test/pub_serve:
    $include: test/**_test{.*,}.dart
```

Note that if you're using the test runner along with [`polymer`][polymer], you
have to make sure that the `test/pub_serve` transformer comes *after* the
`polymer` transformer:

[polymer]: https://www.dartlang.org/polymer/

```yaml
transformers:
- polymer
- test/pub_serve:
    $include: test/**_test{.*,}.dart
```

Then, start up `pub serve`. Make sure to pay attention to which port it's using
to serve your `test/` directory:

```shell
$ pub serve
Loading source assets...
Loading test/pub_serve transformers...
Serving my_app web on http://localhost:8080
Serving my_app test on http://localhost:8081
Build completed successfully
```

In this case, the port is `8081`. In another terminal, pass this port to
`--pub-serve` and otherwise invoke `pub run test` as normal:

```shell
$ pub run test --pub-serve=8081 -p chrome
"pub serve" is compiling test/my_app_test.dart...
"pub serve" is compiling test/utils_test.dart...
00:00 +42: All tests passed!
```

## Further Reading

Check out the [API docs][api] for detailed information about all the functions
available to tests.

[api]: http://www.dartdocs.org/documentation/test/latest/index.html

The test runner also supports a machine-readable JSON-based reporter. This
reporter allows the test runner to be wrapped and its progress presented in
custom ways (for example, in an IDE). See [the protocol documentation][json] for
more details.

[json]: https://github.com/dart-lang/test/blob/master/doc/json_reporter.md
