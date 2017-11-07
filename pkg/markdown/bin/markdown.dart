import 'dart:async';
import 'dart:io';

import 'package:markdown/markdown.dart';

Future main(List<String> args) async {
  if (args.length > 1) {
    print('Usage: markdown.dart [file]');
    exit(1);
  }

  if (args.length == 1) {
    var arg = args.first;
    if (arg == '--help') usage();
    if (arg == '--version') {
      print(version);
      exit(0);
    }
    // Read argument as a file path.
    print(markdownToHtml(new File(args[0]).readAsStringSync()));
    exit(0);
  }

  // Read from stdin.
  var buffer = new StringBuffer();
  var line;
  while ((line = stdin.readLineSync()) != null) buffer.writeln(line);
  print(markdownToHtml(buffer.toString()));
}

void usage() {
  print('''Usage:
    markdown [markdown file]
        Convert [markdown-file] from Markdown to HTML. If no file is passed on
        the commandline, then the Markdown source is read from STDIN.

    markdown --version
        Print the markdown package version.

    markdown --help
        Print this help text.
  ''');
  exit(0);
}
