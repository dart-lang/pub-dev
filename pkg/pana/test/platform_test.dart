import 'package:pana/src/platform.dart';
import 'package:test/test.dart';

import 'pubspec_test.dart';

void main() {
  group('Platform', () {
    test('no libraries', () {
      var p = classifyLibPlatform([]);
      expect(p.worksEverywhere, isTrue);
      expect(p.restrictedTo, isNull);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isTrue);
      expect(p.worksOnFlutter, isTrue);
      expect(p.description, 'everywhere');
    });

    test('unknown library', () {
      var p = classifyLibPlatform(['package:_unknown/_unknown.dart']);
      expect(p.worksEverywhere, isTrue);
      expect(p.restrictedTo, isNull);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isTrue);
      expect(p.worksOnFlutter, isTrue);
      expect(p.description, 'everywhere');
    });

    test('dart:io', () {
      var p = classifyLibPlatform(['dart:io']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['flutter', 'server']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isTrue);
      expect(p.worksOnFlutter, isTrue);
      expect(p.description, 'flutter,server');
    });

    test('dart:html', () {
      var p = classifyLibPlatform(['dart:html']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['web']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'web');

      p = classifyLibPlatform(['dart:svg']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['web']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'web');
    });

    test('dart:ui', () {
      var p = classifyLibPlatform(['dart:ui']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['flutter']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isTrue);
      expect(p.description, 'flutter');
    });

    test('dart:mirrors', () {
      var p = classifyLibPlatform(['dart:mirrors']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['server', 'web']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isTrue);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'server,web');
    });

    test('http package: both html and io', () {
      var p = classifyLibPlatform(['dart:html', 'dart:io']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['web']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isTrue);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'web');
    });

    test('detect native', () {
      var p = classifyLibPlatform(['dart:io', 'dart-ext:some-extension']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, ['server']);
      expect(p.hasConflict, isFalse);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isTrue);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'server');
    });
  });

  group('Conflicting Platform', () {
    test('dart:html + dart:ui', () {
      var p = classifyLibPlatform(['dart:html', 'dart:ui']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, isNull);
      expect(p.hasConflict, isTrue);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'undefined');
    });

    test('dart:mirrors + dart:ui', () {
      var p = classifyLibPlatform(['dart:mirrors', 'dart:ui']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, isNull);
      expect(p.hasConflict, isTrue);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'undefined');
    });

    test('native + dart:ui', () {
      var p = classifyLibPlatform(['dart:ui', 'dart-ext:some-extension']);
      expect(p.worksEverywhere, isFalse);
      expect(p.restrictedTo, isNull);
      expect(p.hasConflict, isTrue);
      expect(p.worksOnWeb, isFalse);
      expect(p.worksOnServer, isFalse);
      expect(p.worksOnFlutter, isFalse);
      expect(p.description, 'undefined');
    });
  });

  group('PkgPlatform', () {
    test('handles multiple libraries', () {
      var sum = classifyPkgPlatform(emptyPubspec, {
        'package:_example/a.dart': ['dart:html'],
        'package:_example/b.dart': ['dart:io'],
      });
      expect(sum.worksEverywhere, isFalse);
      expect(sum.restrictedTo, ['flutter', 'server', 'web']);
      expect(sum.descriptionAndReason, 'flutter,server,web: all of the above');
    });

    test('detects flutter in pubspec', () {
      var sum = classifyPkgPlatform(flutterPluginPubspec, {});
      expect(sum.worksEverywhere, isFalse);
      expect(sum.restrictedTo, ['flutter']);
      expect(sum.descriptionAndReason,
          'flutter: pubspec reference with no conflicts');
    });

    test('detects flutter package in dependencies', () {
      var sum = classifyPkgPlatform(flutterDependencyPubspec, {});
      expect(sum.worksEverywhere, isFalse);
      expect(sum.restrictedTo, ['flutter']);
      expect(sum.descriptionAndReason,
          'flutter: pubspec reference with no conflicts');
    });

    test('detects flutter sdk in dependencies', () {
      var sum = classifyPkgPlatform(flutterSdkPubspec, {});
      expect(sum.worksEverywhere, isFalse);
      expect(sum.restrictedTo, ['flutter']);
      expect(sum.descriptionAndReason,
          'flutter: pubspec reference with no conflicts');
    });
  });

  group('Conflicting PkgPlatform', () {
    test('Flutter package with mirrors', () {
      var sum = classifyPkgPlatform(flutterPluginPubspec, {
        'package:_example/lib.dart': ['dart:mirrors'],
      });
      expect(sum.worksEverywhere, isFalse);
      expect(sum.restrictedTo, isNull);
      expect(sum.descriptionAndReason,
          'undefined: flutter reference with library conflicts');
    });
  });
}
