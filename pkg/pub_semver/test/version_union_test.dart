// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart';

main() {
  group('factory', () {
    test('ignores empty constraints', () {
      expect(new VersionConstraint.unionOf([
        VersionConstraint.empty,
        VersionConstraint.empty,
        v123,
        VersionConstraint.empty
      ]), equals(v123));

      expect(new VersionConstraint.unionOf([
        VersionConstraint.empty,
        VersionConstraint.empty
      ]), isEmpty);
    });

    test('returns an empty constraint for an empty list', () {
      expect(new VersionConstraint.unionOf([]), isEmpty);
    });

    test('any constraints override everything', () {
      expect(new VersionConstraint.unionOf([
        v123,
        VersionConstraint.any,
        v200,
        new VersionRange(min: v234, max: v250)
      ]), equals(VersionConstraint.any));
    });

    test('flattens other unions', () {
      expect(new VersionConstraint.unionOf([
        v072,
        new VersionConstraint.unionOf([v123, v124]),
        v250
      ]), equals(new VersionConstraint.unionOf([v072, v123, v124, v250])));
    });

    test('returns a single merged range as-is', () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v080, max: v140),
        new VersionRange(min: v123, max: v200)
      ]), equals(new VersionRange(min: v080, max: v200)));
    });
  });

  group('equality', () {
    test("doesn't depend on original order", () {
      expect(new VersionConstraint.unionOf([
        v250,
        new VersionRange(min: v201, max: v234),
        v124,
        v072,
        new VersionRange(min: v080, max: v114),
        v123
      ]), equals(new VersionConstraint.unionOf([
        v072,
        new VersionRange(min: v080, max: v114),
        v123,
        v124,
        new VersionRange(min: v201, max: v234),
        v250
      ])));
    });

    test("merges overlapping ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v114, max: v124),
        new VersionRange(min: v123, max: v130)
      ]), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v114, max: v130)
      ])));
    });

    test("merges adjacent ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072, includeMax: true),
        new VersionRange(min: v072, max: v080),
        new VersionRange(min: v114, max: v124),
        new VersionRange(min: v124, max: v130, includeMin: true)
      ]), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v114, max: v130)
      ])));
    });

    test("doesn't merge not-quite-adjacent ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        new VersionRange(min: v072, max: v080)
      ]), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        new VersionRange(min: v072, max: v080)
      ])));
    });
 
    test("merges version numbers into ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        v010,
        new VersionRange(min: v114, max: v124),
        v123
      ]), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        new VersionRange(min: v114, max: v124)
      ])));
    });
 
    test("merges adjacent version numbers into ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        v072,
        v114,
        new VersionRange(min: v114, max: v124)
      ]), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072, includeMax: true),
        new VersionRange(min: v114, max: v124, includeMin: true)
      ])));
    });
  });

  test('isEmpty returns false', () {
    expect(new VersionConstraint.unionOf([
      new VersionRange(min: v003, max: v080),
      new VersionRange(min: v123, max: v130),
    ]), isNot(isEmpty));
  });

  test('isAny returns false', () {
    expect(new VersionConstraint.unionOf([
      new VersionRange(min: v003, max: v080),
      new VersionRange(min: v123, max: v130),
    ]).isAny, isFalse);
  });

  test('allows() allows anything the components allow', () {
    var union = new VersionConstraint.unionOf([
      new VersionRange(min: v003, max: v080),
      new VersionRange(min: v123, max: v130),
      v200
    ]);

    expect(union, allows(v010));
    expect(union, doesNotAllow(v080));
    expect(union, allows(v124));
    expect(union, doesNotAllow(v140));
    expect(union, allows(v200));
  });

  group('allowsAll()', () {
    test('for a version, returns true if any component allows the version', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v123, max: v130),
        v200
      ]);

      expect(union.allowsAll(v010), isTrue);
      expect(union.allowsAll(v080), isFalse);
      expect(union.allowsAll(v124), isTrue);
      expect(union.allowsAll(v140), isFalse);
      expect(union.allowsAll(v200), isTrue);
    });

    test('for a version range, returns true if any component allows the whole '
        'range', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v123, max: v130)
      ]);

      expect(union.allowsAll(new VersionRange(min: v003, max: v080)), isTrue);
      expect(union.allowsAll(new VersionRange(min: v010, max: v072)), isTrue);
      expect(union.allowsAll(new VersionRange(min: v010, max: v124)), isFalse);
    });

    group('for a union,', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v123, max: v130)
      ]);

      test('returns true if every constraint matches a different constraint',
          () {
        expect(union.allowsAll(new VersionConstraint.unionOf([
          new VersionRange(min: v010, max: v072),
          new VersionRange(min: v124, max: v130)
        ])), isTrue);
      });

      test('returns true if every constraint matches the same constraint', () {
        expect(union.allowsAll(new VersionConstraint.unionOf([
          new VersionRange(min: v003, max: v010),
          new VersionRange(min: v072, max: v080)
        ])), isTrue);
      });
 
      test("returns false if there's an unmatched constraint", () {
        expect(union.allowsAll(new VersionConstraint.unionOf([
          new VersionRange(min: v010, max: v072),
          new VersionRange(min: v124, max: v130),
          new VersionRange(min: v140, max: v200)
        ])), isFalse);
      });

      test("returns false if a constraint isn't fully matched", () {
        expect(union.allowsAll(new VersionConstraint.unionOf([
          new VersionRange(min: v010, max: v114),
          new VersionRange(min: v124, max: v130)
        ])), isFalse);
      });
    });
  });

  group('allowsAny()', () {
    test('for a version, returns true if any component allows the version', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v123, max: v130),
        v200
      ]);

      expect(union.allowsAny(v010), isTrue);
      expect(union.allowsAny(v080), isFalse);
      expect(union.allowsAny(v124), isTrue);
      expect(union.allowsAny(v140), isFalse);
      expect(union.allowsAny(v200), isTrue);
    });

    test('for a version range, returns true if any component allows part of '
        'the range', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        v123
      ]);

      expect(union.allowsAny(new VersionRange(min: v010, max: v114)), isTrue);
      expect(union.allowsAny(new VersionRange(min: v114, max: v124)), isTrue);
      expect(union.allowsAny(new VersionRange(min: v124, max: v130)), isFalse);
    });

    group('for a union,', () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v130)
      ]);

      test('returns true if any constraint matches', () {
        expect(union.allowsAny(new VersionConstraint.unionOf([
          v072,
          new VersionRange(min: v200, max: v300)
        ])), isTrue);

        expect(union.allowsAny(new VersionConstraint.unionOf([
          v003,
          new VersionRange(min: v124, max: v300)
        ])), isTrue);
      });
 
      test("returns false if no constraint matches", () {
        expect(union.allowsAny(new VersionConstraint.unionOf([
          v003,
          new VersionRange(min: v130, max: v140),
          new VersionRange(min: v140, max: v200)
        ])), isFalse);
      });
    });
  });

  group("intersect()", () {
    test("with an overlapping version, returns that version", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v140)
      ]).intersect(v072), equals(v072));
    });

    test("with a non-overlapping version, returns an empty constraint", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v140)
      ]).intersect(v300), isEmpty);
    });

    test("with an overlapping range, returns that range", () {
      var range = new VersionRange(min: v072, max: v080);
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v140)
      ]).intersect(range), equals(range));
    });

    test("with a non-overlapping range, returns an empty constraint", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v140)
      ]).intersect(new VersionRange(min: v080, max: v123)), isEmpty);
    });

    test("with a parially-overlapping range, returns the overlapping parts",
        () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v140)
      ]).intersect(new VersionRange(min: v072, max: v130)),
          equals(new VersionConstraint.unionOf([
        new VersionRange(min: v072, max: v080),
        new VersionRange(min: v123, max: v130)
      ])));
    });

    group("for a union,", () {
      var union = new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v080),
        new VersionRange(min: v123, max: v130)
      ]);

      test("returns the overlapping parts", () {
        expect(union.intersect(new VersionConstraint.unionOf([
          v010,
          new VersionRange(min: v072, max: v124),
          new VersionRange(min: v124, max: v130)
        ])), equals(new VersionConstraint.unionOf([
          v010,
          new VersionRange(min: v072, max: v080),
          new VersionRange(min: v123, max: v124),
          new VersionRange(min: v124, max: v130)
        ])));
      });

      test("drops parts that don't match", () {
        expect(union.intersect(new VersionConstraint.unionOf([
          v003,
          new VersionRange(min: v072, max: v080),
          new VersionRange(min: v080, max: v123)
        ])), equals(new VersionRange(min: v072, max: v080)));
      });
    });
  });

  group("difference()", () {
    test("ignores ranges that don't intersect", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v072, max: v080),
        new VersionRange(min: v123, max: v130)
      ]).difference(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v010),
        new VersionRange(min: v080, max: v123),
        new VersionRange(min: v140)
      ])), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v072, max: v080),
        new VersionRange(min: v123, max: v130)
      ])));
    });

    test("removes overlapping portions", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v080),
        new VersionRange(min: v123, max: v130)
      ]).difference(new VersionConstraint.unionOf([
        new VersionRange(min: v003, max: v072),
        new VersionRange(min: v124)
      ])), equals(new VersionConstraint.unionOf([
        new VersionRange(min: v072, max: v080, includeMin: true),
        new VersionRange(min: v123, max: v124, includeMax: true)
      ])));
    });

    test("removes multiple portions from the same range", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v114),
        new VersionRange(min: v130, max: v200)
      ]).difference(new VersionConstraint.unionOf([v072, v080])),
          equals(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v072),
        new VersionRange(min: v072, max: v080),
        new VersionRange(min: v080, max: v114),
        new VersionRange(min: v130, max: v200)
      ])));
    });

    test("removes the same range from multiple ranges", () {
      expect(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v072),
        new VersionRange(min: v080, max: v123),
        new VersionRange(min: v124, max: v130),
        new VersionRange(min: v200, max: v234),
        new VersionRange(min: v250, max: v300)
      ]).difference(new VersionRange(min: v114, max: v201)),
          equals(new VersionConstraint.unionOf([
        new VersionRange(min: v010, max: v072),
        new VersionRange(min: v080, max: v114, includeMax: true),
        new VersionRange(min: v201, max: v234, includeMin: true),
        new VersionRange(min: v250, max: v300)
      ])));
    });
  });
}