// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_config.parse_write_test;

import "package:package_config/packages_file.dart";
import "package:test/test.dart";

main() {
  testBase(baseDirString) {
    var baseDir = Uri.parse(baseDirString);
    group("${baseDir.scheme} base", () {
      Uri packagesFile = baseDir.resolve(".packages");

      roundTripTest(String name, Map<String, Uri> map) {
        group(name, () {
          test("write with no baseUri", () {
            var content = writeToString(map).codeUnits;
            var resultMap = parse(content, packagesFile);
            expect(resultMap, map);
          });

          test("write with base directory", () {
            var content = writeToString(map, baseUri: baseDir).codeUnits;
            var resultMap = parse(content, packagesFile);
            expect(resultMap, map);
          });

          test("write with base .packages file", () {
            var content = writeToString(map, baseUri: packagesFile).codeUnits;
            var resultMap = parse(content, packagesFile);
            expect(resultMap, map);
          });
        });
      }

      var lowerDir = baseDir.resolve("path3/path4/");
      var higherDir = baseDir.resolve("../");
      var parallelDir = baseDir.resolve("../path3/");
      var rootDir = baseDir.resolve("/");
      var fileDir = Uri.parse("file:///path1/part2/");
      var httpDir = Uri.parse("http://example.com/path1/path2/");
      var otherDir = Uri.parse("other:/path1/path2/");

      roundTripTest("empty", {});
      roundTripTest("lower directory", {"foo": lowerDir});
      roundTripTest("higher directory", {"foo": higherDir});
      roundTripTest("parallel directory", {"foo": parallelDir});
      roundTripTest("same directory", {"foo": baseDir});
      roundTripTest("root directory", {"foo": rootDir});
      roundTripTest("file directory", {"foo": fileDir});
      roundTripTest("http directory", {"foo": httpDir});
      roundTripTest("other scheme directory", {"foo": otherDir});
      roundTripTest("multiple same-type directories",
          {"foo": lowerDir, "bar": higherDir, "baz": parallelDir});
      roundTripTest("multiple scheme directories",
          {"foo": fileDir, "bar": httpDir, "baz": otherDir});
      roundTripTest("multiple scheme directories and mutliple same type", {
        "foo": fileDir,
        "bar": httpDir,
        "baz": otherDir,
        "qux": lowerDir,
        "hip": higherDir,
        "dep": parallelDir
      });
    });
  }

  testBase("file:///base1/base2/");
  testBase("http://example.com/base1/base2/");
  testBase("other:/base1/base2/");

  // Check that writing adds the comment.
  test("write preserves comment", () {
    var comment = "comment line 1\ncomment line 2\ncomment line 3";
    var result = writeToString({}, comment: comment);
    // Comment with "# " before each line and "\n" after last.
    var expectedComment =
        "# comment line 1\n# comment line 2\n# comment line 3\n";
    expect(result, startsWith(expectedComment));
  });
}

String writeToString(Map<String, Uri> map, {Uri baseUri, String comment}) {
  var buffer = new StringBuffer();
  write(buffer, map, baseUri: baseUri, comment: comment);
  return buffer.toString();
}
