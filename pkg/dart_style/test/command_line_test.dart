// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dart_style.test.command_line;

import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:scheduled_test/descriptor.dart' as d;
import 'package:scheduled_test/scheduled_test.dart';
import 'package:scheduled_test/scheduled_stream.dart';

import 'utils.dart';

void main() {
  setUpTestSuite();

  test("exits with 0 on success", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatterOnDir();
    process.shouldExit(0);
  });

  test("exits with 64 on a command line argument error", () {
    var process = runFormatterOnDir(["-wat"]);
    process.shouldExit(64);
  });

  test("exits with 65 on a parse error", () {
    d.dir("code", [d.file("a.dart", "herp derp i are a dart")]).create();

    var process = runFormatterOnDir();
    process.shouldExit(65);
  });

  test("errors if --dry-run and --overwrite are both passed", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatterOnDir(["--dry-run", "--overwrite"]);
    process.shouldExit(64);
  });

  test("errors if --dry-run and --machine are both passed", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatterOnDir(["--dry-run", "--machine"]);
    process.shouldExit(64);
  });

  test("errors if --machine and --overwrite are both passed", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatterOnDir(["--machine", "--overwrite"]);
    process.shouldExit(64);
  });

  test("errors if --dry-run and --machine are both passed", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatter(["--dry-run", "--machine"]);
    process.shouldExit(64);
  });

  test("errors if --machine and --overwrite are both passed", () {
    d.dir("code", [d.file("a.dart", unformattedSource)]).create();

    var process = runFormatter(["--machine", "--overwrite"]);
    process.shouldExit(64);
  });

  test("--version prints the version number", () {
    var process = runFormatter(["--version"]);

    // Match something roughly semver-like.
    process.stdout.expect(matches(r"\d+\.\d+\.\d+.*"));
    process.shouldExit(0);
  });

  test("only prints a hidden directory once", () {
    d.dir('code', [
      d.dir('.skip', [
        d.file('a.dart', unformattedSource),
        d.file('b.dart', unformattedSource)
      ])
    ]).create();

    var process = runFormatterOnDir();

    process.stdout.expect(startsWith("Formatting directory"));
    process.stdout.expect("Skipping hidden path ${p.join("code", ".skip")}");
    process.shouldExit();
  });

  group("--dry-run", () {
    test("prints names of files that would change", () {
      d.dir("code", [
        d.file("a_bad.dart", unformattedSource),
        d.file("b_good.dart", formattedSource),
        d.file("c_bad.dart", unformattedSource),
        d.file("d_good.dart", formattedSource)
      ]).create();

      var aBad = p.join("code", "a_bad.dart");
      var cBad = p.join("code", "c_bad.dart");

      var process = runFormatterOnDir(["--dry-run"]);

      // The order isn't specified.
      process.stdout.expect(either(aBad, cBad));
      process.stdout.expect(either(aBad, cBad));
      process.shouldExit();
    });

    test("does not modify files", () {
      d.dir("code", [d.file("a.dart", unformattedSource)]).create();

      var process = runFormatterOnDir(["--dry-run"]);
      process.stdout.expect(p.join("code", "a.dart"));
      process.shouldExit();

      d.dir('code', [d.file('a.dart', unformattedSource)]).validate();
    });
  });

  group("--machine", () {
    test("writes each output as json", () {
      d.dir("code", [
        d.file("a.dart", unformattedSource),
        d.file("b.dart", unformattedSource)
      ]).create();

      var jsonA = JSON.encode({
        "path": p.join("code", "a.dart"),
        "source": formattedSource,
        "selection": {"offset": -1, "length": -1}
      });

      var jsonB = JSON.encode({
        "path": p.join("code", "b.dart"),
        "source": formattedSource,
        "selection": {"offset": -1, "length": -1}
      });

      var process = runFormatterOnDir(["--machine"]);

      // The order isn't specified.
      process.stdout.expect(either(jsonA, jsonB));
      process.stdout.expect(either(jsonA, jsonB));
      process.shouldExit();
    });
  });

  group("--preserve", () {
    test("errors if given paths", () {
      var process = runFormatter(["--preserve", "path", "another"]);
      process.shouldExit(64);
    });

    test("errors on wrong number of components", () {
      var process = runFormatter(["--preserve", "1"]);
      process.shouldExit(64);

      process = runFormatter(["--preserve", "1:2:3"]);
      process.shouldExit(64);
    });

    test("errors on non-integer component", () {
      var process = runFormatter(["--preserve", "1:2.3"]);
      process.shouldExit(64);
    });

    test("updates selection", () {
      var process = runFormatter(["--preserve", "6:10", "-m"]);
      process.writeLine(unformattedSource);
      process.closeStdin();

      var json = JSON.encode({
        "path": "<stdin>",
        "source": formattedSource,
        "selection": {"offset": 5, "length": 9}
      });

      process.stdout.expect(json);
      process.shouldExit();
    });
  });

  group("--indent", () {
    test("sets the leading indentation of the output", () {
      var process = runFormatter(["--indent", "3"]);
      process.writeLine("main() {'''");
      process.writeLine("a flush left multi-line string''';}");
      process.closeStdin();

      process.stdout.expect("   main() {");
      process.stdout.expect("     '''");
      process.stdout.expect("a flush left multi-line string''';");
      process.stdout.expect("   }");
      process.shouldExit(0);
    });

    test("errors if the indent is not a non-negative number", () {
      var process = runFormatter(["--indent", "notanum"]);
      process.shouldExit(64);

      process = runFormatter(["--preserve", "-4"]);
      process.shouldExit(64);
    });
  });

  group("--set-exit-if-changed", () {
    test("gives exit code 0 if there are no changes", () {
      d.dir("code", [d.file("a.dart", formattedSource)]).create();

      var process = runFormatterOnDir(["--set-exit-if-changed"]);
      process.shouldExit(0);
    });

    test("gives exit code 1 if there are changes", () {
      d.dir("code", [d.file("a.dart", unformattedSource)]).create();

      var process = runFormatterOnDir(["--set-exit-if-changed"]);
      process.shouldExit(1);
    });

    test("gives exit code 1 if there are changes even in dry run", () {
      d.dir("code", [d.file("a.dart", unformattedSource)]).create();

      var process = runFormatterOnDir(["--set-exit-if-changed", "--dry-run"]);
      process.shouldExit(1);
    });
  });

  group("with no paths", () {
    test("errors on --overwrite", () {
      var process = runFormatter(["--overwrite"]);
      process.shouldExit(64);
    });

    test("exits with 65 on parse error", () {
      var process = runFormatter();
      process.writeLine("herp derp i are a dart");
      process.closeStdin();
      process.shouldExit(65);
    });

    test("reads from stdin", () {
      var process = runFormatter();
      process.writeLine(unformattedSource);
      process.closeStdin();

      // No trailing newline at the end.
      process.stdout.expect(formattedSource.trimRight());
      process.shouldExit(0);
    });
  });
}
