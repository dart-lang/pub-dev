// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:charcode/ascii.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group("encoder", () {
    test("doesn't percent-encode unreserved characters", () {
      expect(percent.encode([
        $a, $b, $c, $d, $e, $f, $g, $h, $i, $j, $k, $l, $m, $n, $o, $p, $q, $r,
        $s, $t, $u, $v, $w, $x, $y, $z, $A, $B, $C, $D, $E, $F, $G, $H, $I, $J,
        $K, $L, $M, $N, $O, $P, $Q, $R, $S, $T, $U, $V, $W, $X, $Y, $Z, $0, $1,
        $2, $3, $4, $5, $6, $7, $8, $9, $dash, $dot, $underscore, $tilde
      ]), equals("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~"));
    });

    test("percent-encodes reserved ASCII characters", () {
      expect(percent.encode([
        $space, $backquote, $open_brace, $at, $open_bracket, $comma,
        $division, $caret, $close_brace, $del, $nul, $percent
      ]), equals("%20%60%7B%40%5B%2C%2F%5E%7D%7F%00%25"));
    });

    test("percent-encodes non-ASCII characters", () {
      expect(percent.encode([0x80, 0xFF]), equals("%80%FF"));
    });

    test("mixes encoded and unencoded characters", () {
      expect(percent.encode([$a, $plus, $b, $equal, 0x80]),
          equals("a%2Bb%3D%80"));
    });

    group("with chunked conversion", () {
      test("percent-encodes byte arrays", () {
        var results = <String>[];
        var controller = new StreamController<String>(sync: true);
        controller.stream.listen(results.add);
        var sink = percent.encoder.startChunkedConversion(controller.sink);

        sink.add([$a, $plus, $b, $equal, 0x80]);
        expect(results, equals(["a%2Bb%3D%80"]));

        sink.add([0x00, 0x01, 0xfe, 0xff]);
        expect(results, equals(["a%2Bb%3D%80", "%00%01%FE%FF"]));
      });

      test("handles empty and single-byte lists", () {
        var results = <String>[];
        var controller = new StreamController<String>(sync: true);
        controller.stream.listen(results.add);
        var sink = percent.encoder.startChunkedConversion(controller.sink);

        sink.add([]);
        expect(results, equals([""]));

        sink.add([0x00]);
        expect(results, equals(["", "%00"]));

        sink.add([]);
        expect(results, equals(["", "%00", ""]));
      });
    });

    test("rejects non-bytes", () {
      expect(() => percent.encode([0x100]), throwsFormatException);

      var sink = percent.encoder.startChunkedConversion(
          new StreamController(sync: true));
      expect(() => sink.add([0x100]), throwsFormatException);
    });
  });

  group("decoder", () {
    test("converts percent-encoded strings to byte arrays", () {
      expect(percent.decode("a%2Bb%3D%801"),
          equals([$a, $plus, $b, $equal, 0x80, $1]));
    });

    test("supports lowercase letters", () {
      expect(percent.decode("a%2bb%3d%80"),
          equals([$a, $plus, $b, $equal, 0x80]));
    });

    test("supports more aggressive encoding", () {
      expect(percent.decode("%61%2E%5A"), equals([$a, $dot, $Z]));
    });

    test("supports less aggressive encoding", () {
      expect(percent.decode(" `{@[,/^}\x7F\x00"), equals([
        $space, $backquote, $open_brace, $at, $open_bracket, $comma,
        $division, $caret, $close_brace, $del, $nul
      ]));
    });

    group("with chunked conversion", () {
      List<List<int>> results;
      var sink;
      setUp(() {
        results = [];
        var controller = new StreamController<List<int>>(sync: true);
        controller.stream.listen(results.add);
        sink = percent.decoder.startChunkedConversion(controller.sink);
      });

      test("converts percent to byte arrays", () {
        sink.add("a%2Bb%3D%801");
        expect(results, equals([[$a, $plus, $b, $equal, 0x80, $1]]));

        sink.add("%00%01%FE%FF");
        expect(results,
            equals([[$a, $plus, $b, $equal, 0x80, $1], [0x00, 0x01, 0xfe, 0xff]]));
      });

      test("supports trailing percents and digits split across chunks", () {
        sink.add("ab%");
        expect(results, equals([[$a, $b]]));

        sink.add("2");
        expect(results, equals([[$a, $b]]));

        sink.add("0cd%2");
        expect(results, equals([[$a, $b], [$space, $c, $d]]));

        sink.add("0");
        expect(results, equals(([[$a, $b], [$space, $c, $d], [$space]])));
      });

      test("supports empty strings", () {
        sink.add("");
        expect(results, isEmpty);

        sink.add("%");
        expect(results, equals([[]]));

        sink.add("");
        expect(results, equals([[]]));

        sink.add("2");
        expect(results, equals([[]]));

        sink.add("");
        expect(results, equals([[]]));

        sink.add("0");
        expect(results, equals([[], [0x20]]));
      });

      test("rejects dangling % detected in close()", () {
        sink.add("ab%");
        expect(results, equals([[$a, $b]]));
        expect(() => sink.close(), throwsFormatException);
      });

      test("rejects dangling digit detected in close()", () {
        sink.add("ab%2");
        expect(results, equals([[$a, $b]]));
        expect(() => sink.close(), throwsFormatException);
      });

      test("rejects danging % detected in addSlice()", () {
        sink.addSlice("ab%", 0, 3, false);
        expect(results, equals([[$a, $b]]));

        expect(() => sink.addSlice("ab%", 0, 3, true),
            throwsFormatException);
      });

      test("rejects danging digit detected in addSlice()", () {
        sink.addSlice("ab%2", 0, 3, false);
        expect(results, equals([[$a, $b]]));

        expect(() => sink.addSlice("ab%2", 0, 3, true),
            throwsFormatException);
      });
    });

    group("rejects non-ASCII character", () {
      for (var char in ["\u0141", "\u{10041}"]) {
        test('"$char"', () {
          expect(() => percent.decode("a$char"), throwsFormatException);
          expect(() => percent.decode("${char}a"), throwsFormatException);

          var sink = percent.decoder.startChunkedConversion(
              new StreamController(sync: true));
          expect(() => sink.add(char), throwsFormatException);
        });
      }
    });

    test("rejects % followed by non-hex", () {
      expect(() => percent.decode("%z2"), throwsFormatException);
      expect(() => percent.decode("%2z"), throwsFormatException);
    });

    test("rejects dangling % detected in convert()", () {
      expect(() => percent.decode("ab%"), throwsFormatException);
    });

    test("rejects dangling digit detected in convert()", () {
      expect(() => percent.decode("ab%2"), throwsFormatException);
    });
  });
}
