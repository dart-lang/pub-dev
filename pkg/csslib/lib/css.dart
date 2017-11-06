// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Deprecated('Will be removed in v0.15.0')
library css;

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:source_span/source_span.dart';

import 'parser.dart';
import 'src/messages.dart';
import 'visitor.dart';

void main(List<String> arguments) {
  // TODO(jmesserly): fix this to return a proper exit code
  var options = _parseOptions(arguments);
  if (options == null) return;

  messages = new Messages(options: options);

  _time('Total time spent on ${options.inputFile}', () {
    _compile(options.inputFile, options.verbose);
  }, true);
}

void _compile(String inputPath, bool verbose) {
  var ext = path.extension(inputPath);
  if (ext != '.css' && ext != '.scss') {
    messages.error("Please provide a CSS/Sass file", null);
    return;
  }
  try {
    // Read the file.
    var filename = path.basename(inputPath);
    var contents = new File(inputPath).readAsStringSync();
    var file = new SourceFile.fromString(contents, url: path.toUri(inputPath));

    // Parse the CSS.
    StyleSheet tree = _time(
        'Parse $filename', () => new Parser(file, contents).parse(), verbose);

    _time('Analyzer $filename', () => new Analyzer([tree], messages), verbose)
        .run();

    // Emit the processed CSS.
    var emitter = new CssPrinter();
    _time('Codegen $filename', () => emitter.visitTree(tree, pretty: true),
        verbose);

    // Write the contents to a file.
    var outPath = path.join(path.dirname(inputPath), '_$filename');
    new File(outPath).writeAsStringSync(emitter.toString());
  } catch (e) {
    messages.error('error processing $inputPath. Original message:\n $e', null);
  }
}

_time(String message, callback(), bool printTime) {
  if (!printTime) return callback();
  final watch = new Stopwatch();
  watch.start();
  var result = callback();
  watch.stop();
  final duration = watch.elapsedMilliseconds;
  _printMessage(message, duration);
  return result;
}

void _printMessage(String message, int duration) {
  var buf = new StringBuffer();
  buf.write(message);
  for (int i = message.length; i < 60; i++) buf.write(' ');
  buf.write(' -- ');
  if (duration < 10) buf.write(' ');
  if (duration < 100) buf.write(' ');
  buf..write(duration)..write(' ms');
  print(buf.toString());
}

PreprocessorOptions _fromArgs(ArgResults args) => new PreprocessorOptions(
    warningsAsErrors: args['warnings_as_errors'],
    throwOnWarnings: args['throw_on_warnings'],
    throwOnErrors: args['throw_on_errors'],
    verbose: args['verbose'],
    checked: args['checked'],
    lessSupport: args['less'],
    useColors: args['colors'],
    polyfill: args['polyfill'],
    inputFile: args.rest.length > 0 ? args.rest[0] : null);

// tool.dart [options...] <css file>
PreprocessorOptions _parseOptions(List<String> arguments) {
  var parser = new ArgParser()
    ..addFlag('verbose',
        abbr: 'v',
        defaultsTo: false,
        negatable: false,
        help: 'Display detail info')
    ..addFlag('checked',
        defaultsTo: false,
        negatable: false,
        help: 'Validate CSS values invalid value display a warning message')
    ..addFlag('less',
        defaultsTo: true,
        negatable: true,
        help: 'Supports subset of Less syntax')
    ..addFlag('suppress_warnings',
        defaultsTo: true, help: 'Warnings not displayed')
    ..addFlag('warnings_as_errors',
        defaultsTo: false, help: 'Warning handled as errors')
    ..addFlag('throw_on_errors',
        defaultsTo: false, help: 'Throw on errors encountered')
    ..addFlag('throw_on_warnings',
        defaultsTo: false, help: 'Throw on warnings encountered')
    ..addFlag('colors',
        defaultsTo: true, help: 'Display errors/warnings in colored text')
    ..addFlag('polyfill',
        defaultsTo: false, help: 'Generate polyfill for new CSS features')
    ..addFlag('help',
        abbr: 'h',
        defaultsTo: false,
        negatable: false,
        help: 'Displays this help message');

  try {
    var results = parser.parse(arguments);
    if (results['help'] || results.rest.length == 0) {
      _showUsage(parser);
      return null;
    }
    return _fromArgs(results);
  } on FormatException catch (e) {
    print(e.message);
    _showUsage(parser);
    return null;
  }
}

void _showUsage(ArgParser parser) {
  print('Usage: css [options...] input.css');
  print(parser.usage);
}
