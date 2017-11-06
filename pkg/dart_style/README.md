The dart_style package defines an automatic, opinionated formatter for Dart
code. It replaces the whitespace in your program with what it deems to be the
best formatting for it. Resulting code should follow the [Dart style guide][]
but, moreso, should look nice to most human readers, most of the time.

[dart style guide]: https://www.dartlang.org/guides/language/effective-dart/style

The formatter handles indentation, inline whitespace and
(by far the most difficult), intelligent line wrapping.
It has no problems with nested collections, function
expressions, long argument lists, or otherwise tricky code.

The formatter turns code like this:

```
// BEFORE formatting
if (tag=='style'||tag=='script'&&(type==null||type == TYPE_JS
      ||type==TYPE_DART)||
  tag=='link'&&(rel=='stylesheet'||rel=='import')) {}
```

into:

```
  // AFTER formatting
  if (tag == 'style' ||
      tag == 'script' &&
          (type == null || type == TYPE_JS || type == TYPE_DART) ||
      tag == 'link' && (rel == 'stylesheet' || rel == 'import')) {}
```

The formatter will never break your code&mdash;you can safely invoke it
automatically from build and presubmit scripts.

## Getting dartfmt

Dartfmt is included in the Dart SDK, so you might want to add the SDK's bin
directory to your system path.

If you want to make sure you are running the latest version of dartfmt,
you can [globally activate][] the package from the dart_style package
on pub.dartlang.org, and let pub put its executable on your path:

    $ pub global activate dart_style
    $ dartfmt ...

[globally activate]: https://www.dartlang.org/tools/pub/cmd/pub-global.html

If you don't want `dartfmt` on your path, you can run it explicitly:

    $ pub global activate dart_style --no-executables
    $ pub global run dart_style:format ...

## Using dartfmt

IDEs and editors that support Dart usually provide easy ways to run the
formatter. For example, in WebStorm you can right-click a .dart file
and then choose **Reformat with Dart Style**.

Here's a simple example of using dartfmt on the command line:

```
dartfmt test.dart
```

This command formats the `test.dart` file and writes the result to
standard output.

Dartfmt takes a list of paths, which can point to directories or files.
If the path is a directory, it processes every `.dart` file in that directory
or any of its subdirectories.
If no file or directory is specified, dartfmt reads from standard input.

By default, it formats each file and just prints the resulting code to stdout.
If you pass `-w`, it overwrites your existing files with the
formatted results.

You may pass a `-l` option to control the width of the page that it
wraps lines to fit within, but you're strongly encouraged to keep the default
line length of 80 columns.

### Validating files

If you want to use the formatter in something like a [presubmit script][] or
[commit hook][], you can use the `-n` dry run option. If you specify `-n`, the
formatter prints the paths of the files whose contents would change if the
formatter were run normally. If it prints no output, then everything is already
correctly formatted.

[presubmit script]: http://www.chromium.org/developers/how-tos/depottools/presubmit-scripts
[commit hook]: http://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks

## Using the dart_style API

The package also exposes a single dart_style library containing a programmatic
API for formatting code. Simple usage looks like this:

    import 'package:dart_style/dart_style.dart';

    main() {
      var formatter = new DartFormatter();

      try {
        print(formatter.format("""
        library an_entire_compilation_unit;

        class SomeClass {}
        """));

        print(formatter.formatStatement("aSingle(statement);"));
      } on FormatterException catch (ex) {
        print(ex);
      }
    }

## Other resources

* Before sending an email, see if you are asking a
  [frequently asked question][faq].

* Before filing a bug, or if you want to understand how work on the
  formatter is managed, see how we [track issues][].

[faq]: https://github.com/dart-lang/dart_style/wiki/FAQ
[track issues]: https://github.com/dart-lang/dart_style/wiki/Tracking-issues
