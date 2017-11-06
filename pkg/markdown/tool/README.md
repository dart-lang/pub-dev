Developer Tools
===============

This directory contains tools for developers of the Dart markdown package.

dartdoc-compare.dart
--------------------

When you make a change to the package that might have subtle consequences on
how Markdown is parsed, it would be really great to see how your output compares
to the previous output, on a large collection of Markdown.

One such collection is the Dartdoc comments of any Dart package, which [dartdoc]
translates into HTML, with the help of this markdown package. You can use the
`dartdoc-compare.dart` script to compare what changes your code will make to
dartdoc's output. Here's how it works:

1. Clone the [dartdoc git repository].
2. Get a copy of some Dart code that you would like to use for the comparison.
3. Run the `dartdoc-compare.dart` script like so:

   ```
   $ dart tool/dartdoc-compare.dart \
         --dartdoc-dir=<dartdoc repo> \
         --before=<git SHA of "previous" code> \
         <directory of dart code for comparison>
   ```

4. The tool will then walk through the following steps:

   1. cd into the dartdoc directory, change `pubspec.yaml` to depend on your
      "before" version of markdown, and run `pub get`.
   2. cd into the directory of dart code, and run `pub get`.
   3. Run dartdoc.
   4. cd back into the dartdoc directory, change `pubspec.yaml` to depend on
      your "after" version of markdown (defaults to HEAD), and run `pub get`.
   5. Repeat steps 2 and 3.
   6. Diff the output of steps 3 and 5, and show you how to diff it yourself.

[dartdoc]: https://pub.dartlang.org/packages/dartdoc
[dartdoc git repository]: https://github.com/dart-lang/dartdoc

common_mark_stats.dart
----------------------

In an effort to make this package CommonMark-compliant, we have a script that
runs the package through the CommonMark specs. To run it, simply run:

```bash
$ dart tool/stats.dart
```
