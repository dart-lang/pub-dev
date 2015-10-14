**TODO: Add more examples to cover all of the syntax.**

# Regressions

Bad backtracking in the HR parser:

-------------------------- | -------------------------------------------------

# Real-world sample

This input was taken from the test package's README to get a representative
sample of real-world markdown:

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

Tests can be grouped together using the [`group()`] function. Each group's
description is added to the beginning of its test's descriptions.

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

## Running Tests

A single test file can be run just using `pub run test:test path/to/test.dart`
(on Dart 1.10, this can be shortened to `pub run test path/to/test.dart`).

![Single file being run via pub run"](https://raw.githubusercontent.com/dart-lang/test/master/image/test1.gif)

Many tests can be run at a time using `pub run test:test path/to/dir`.

![Directory being run via "pub run".](https://raw.githubusercontent.com/dart-lang/test/master/image/test2.gif)

It's also possible to run a test on the Dart VM only by invoking it using `dart
path/to/test.dart`, but this doesn't load the full test runner and will be
missing some features.

The test runner considers any file that ends with `_test.dart` to be a test
file. If you don't pass any paths, it will run all the test files in your
`test/` directory, making it easy to test your entire application at once.

By default, tests are run in the Dart VM, but you can run them in the browser as
well by passing `pub run test:test -p chrome path/to/test.dart`.
`test` will take care of starting the browser and loading the tests, and all
the results will be reported on the command line just like for VM tests. In
fact, you can even run tests on both platforms with a single command: `pub run
test:test -p "chrome,vm" path/to/test.dart`.

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

### Platform Selector Syntax

Platform selectors can contain identifiers, parentheses, and operators. When
loading a test, each identifier is set to `true` or `false` based on the current
platform, and the test is only loaded if the platform selector returns `true`.
The operators `||`, `&&`, `!`, and `? :` all work just like they do in Dart. The
valid identifiers are:

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

* `posix`: Whether the test is running on a POSIX operating system. This is
  equivalent to `!windows`.

For example, if you wanted to run a test on every browser but Chrome, you would
write `@TestOn("browser && !chrome")`.

### Running Tests on Dartium

Tests can be run on [Dartium][] by passing the `-p dartium` flag. If you're
using the Dart Editor, the test runner will be able to find Dartium
automatically. On Mac OS, you can also [install it using Homebrew][homebrew].
Otherwise, make sure there's an executable called `dartium` (on Mac OS or Linux)
or `dartium.exe` (on Windows) on your system path.

[Dartium]: https://www.dartlang.org/tools/dartium/
[homebrew]: https://github.com/dart-lang/homebrew-dart

Similarly, tests can be run on the headless Dartium content shell by passing `-p
content-shell`. The content shell is installed along with Dartium when using
Homebrew. Otherwise, you can downloaded it manually [from this
page][content_shell]; if you do, make sure the executable named `content_shell`
(on Mac OS or Linux) or `content_shell.exe` (on Windows) is on your system path.

[content_shell]: http://gsdview.appspot.com/dart-archive/channels/stable/release/latest/dartium/

[In the future][issue 63], there will be a more explicit way to configure the
location of both the Dartium and content shell executables.

[issue 63]: https://github.com/dart-lang/test/issues/63

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

    stream.listen(expectAsync((number) {
      expect(number, inInclusiveRange(1, 3));
    }, count: 3));
  });
}
```

[expectAsync]: http://www.dartdocs.org/documentation/test/latest/index.html#test/test@id_expectAsync

## Running Tests with Custom HTML

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

## Testing With `barback`

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
`--pub-serve` and otherwise invoke `pub run test:test` as normal:

```shell
$ pub run test:test --pub-serve=8081 -p chrome
"pub serve" is compiling test/my_app_test.dart...
"pub serve" is compiling test/utils_test.dart...
00:00 +42: All tests passed!
```
