// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';

// TODO: Test that messages contains some substring.
void main() {
  group('package name validation', () {
    test('reject unknown mixed-case', () {
      expect(validateNewPackageName('myNewPackage'), isNotEmpty);
    });

    test('accept only lower-case babylon (original author continues it)', () {
      expect(validateNewPackageName('Babylon'), isNotEmpty);
      expect(validateNewPackageName('babylon'), isEmpty);
    });

    test('accept only upper-case Pong (no contact with author)', () {
      expect(validateNewPackageName('pong'), isNotEmpty);
      expect(validateNewPackageName('Pong'), isEmpty);
    });

    test('reject unknown mixed-case', () {
      expect(validateNewPackageName('pong'), isNotEmpty);
    });

    test('accept lower-case', () {
      expect(validatePackageName('my_package'), isEmpty);
    });

    test('reject reserved words', () {
      expect(validateNewPackageName('do'), isNotEmpty);
      expect(validateNewPackageName('d_o'), isNotEmpty);
    });

    test('check the length of the name', () {
      expect(validatePackageName('a234567890' * 6 + '1234'), isEmpty);
      expect(validatePackageName('a234567890' * 6 + '12345'), isNotEmpty);
    });
  });

  group('package version validation', () {
    test('valid versions', () {
      expect(validatePackageVersion(Version.parse('1.0.0')), isEmpty);
      expect(validatePackageVersion(Version.parse('0.0.0-dev1.0')), isEmpty);
    });

    test('check the length of the version', () {
      expect(
          validatePackageVersion(Version.parse(
              '1.0.0-longandboringprereleasestringthatnobodywantstoread'
              'longandboringprereleasestringthatnobodywantstoread')),
          isNotEmpty);
    });
  });

  group('publish_to', () {
    test('OK', () {
      expect(validatePublishTo(null), isEmpty);
    });

    test('recognized, but instead they should be `null`', () {
      expect(validatePublishTo('https://pub.dev'), isNotEmpty);
      expect(validatePublishTo('https://pub.dev/'), isNotEmpty);
      expect(validatePublishTo('https://pub.dartlang.org'), isNotEmpty);
      expect(validatePublishTo('https://pub.dartlang.org/'), isNotEmpty);
    });

    test('bad value', () {
      expect(validatePublishTo(''), isNotEmpty);
      expect(validatePublishTo('example.com'), isNotEmpty);
    });
  });

  group('description', () {
    test('missing', () {
      expect(validateDescription(null), isNotEmpty);
    });

    test('empty', () {
      expect(validateDescription(''), isNotEmpty);
    });

    test('only spaces', () {
      expect(validateDescription('  '), isNotEmpty);
    });

    test('too long overall', () {
      expect(validateDescription('a ' * 500), isNotEmpty);
    });

    test('too long words', () {
      expect(validateDescription('a' * 100), isNotEmpty);
    });

    test('emoji', () {
      expect(validateDescription('A fancy description with emoji character 📁'),
          isNotEmpty);
    });

    test('valid text', () {
      expect(
          validateDescription(
              'Evaluate the health and quality of a Dart package'),
          isEmpty);
    });
  });

  group('Zalgo text', () {
    test('allows CJK', () {
      expect(
          validateZalgo('field',
              '文字 Chinese (Hanzi), 漢字 Japanese (Kanji), 漢字 Korean (Hanja)'),
          isEmpty);
    });

    test('blocks Zalgo', () {
      expect(validateZalgo('field', 'z͎͗ͣḁ̵̑l̉̃ͦg̐̓̒o͓̔ͥ'), isNotEmpty);
    });
  });

  group('sdk version range', () {
    test('accepted ranges', () {
      void isAccepted(String range) {
        expect(
          checkSdkVersionRange(Pubspec.fromJson({
            'name': 'x',
            'environment': {'sdk': range},
          })),
          isEmpty,
          reason: range,
        );
      }

      isAccepted('>=1.0.0 <2.0.0');
      isAccepted('>=1.0.0 <2.0.0-0');
      isAccepted('>=1.0.0 <3.0.0');
      isAccepted('>=1.0.0 <3.0.0-0');
      isAccepted('>=2.0.0 <3.0.0');
      isAccepted('>=2.0.0 <3.0.0-0');
      isAccepted('>=2.2.0 <2.11.0');
      isAccepted('>=2.12.0 <4.0.0');
      isAccepted('>=3.0.0 <4.0.0');
    });

    test('rejected ranges', () {
      void isRejected(String? range) {
        expect(
          checkSdkVersionRange(Pubspec.fromJson({
            'name': 'x',
            if (range != null) 'environment': {'sdk': range},
          })),
          isNotEmpty,
          reason: range,
        );
      }

      isRejected(null);
      isRejected('any');
      isRejected('>=0.0.0');
      isRejected('>=1.0.0');
      isRejected('>=2.0.0');
      isRejected('<4.0.0');
      isRejected('<4.0.0-0');
      isRejected('>=2.11.0 <4.0.0');
      isRejected('>=2.12.0 <4.0.1');
      isRejected('>=3.0.0 <4.0.1');
      isRejected('>=4.0.0');
      isRejected('>=4.0.0-0');
      isRejected('>=4.0.0 <5.0.0');
      isRejected('>=5.0.0');
      isRejected('>=5.0.0 <6.0.0');
    });
  });

  group('homepage syntax check', () {
    test('no url is accepted', () {
      expect(syntaxCheckUrl(null, 'homepage'), isEmpty);
    });

    test('bad url is reported', () {
      expect(syntaxCheckUrl('://::::/::/', 'homepage').single.message,
          'Unable to parse homepage URL: ://::::/::/');
    });

    test('example urls that are accepted', () {
      expect(
          syntaxCheckUrl('http://github.com/user/repo/', 'homepage'), isEmpty);
      expect(
          syntaxCheckUrl('https://github.com/user/repo/', 'homepage'), isEmpty);
      expect(syntaxCheckUrl('http://some.domain.com', 'homepage'), isEmpty);
    });

    test('urls without valid scheme are not accepted', () {
      expect(syntaxCheckUrl('github.com/x/y', 'homepage'), isNotEmpty);
      expect(syntaxCheckUrl('httpx://github.com/x/y', 'homepage'), isNotEmpty);
      expect(syntaxCheckUrl('ftp://github.com/x/y', 'homepage'), isNotEmpty);
    });

    test('urls without valid host are not accepted', () {
      expect(syntaxCheckUrl('http://none/x/', 'homepage'), isNotEmpty);
      expect(syntaxCheckUrl('http://example.com/x/', 'homepage'), isNotEmpty);
      expect(syntaxCheckUrl('http://localhost/x/', 'homepage'), isNotEmpty);
      expect(syntaxCheckUrl('http://.../x/', 'homepage'), isNotEmpty);
    });
  });

  group('environment keys', () {
    test('no keys', () {
      final pubspec = Pubspec.parse('name: pkg');
      expect(validateEnvironmentKeys(pubspec), isEmpty);
    });

    test('valid keys', () {
      final pubspec = Pubspec.parse('''name: pkg
environment:
  sdk:
  flutter:
  fuchsia:
''');
      expect(validateEnvironmentKeys(pubspec), isEmpty);
    });

    test('unknown key', () {
      final pubspec = Pubspec.parse('''name: pkg
environment:
  flutter_sdk:
''');
      expect(validateEnvironmentKeys(pubspec), isNotEmpty);
    });
  });

  group('author vs. authors', () {
    test('author is allowed', () {
      expect(checkAuthors('author: x'), isEmpty);
    });

    test('authors is allowed', () {
      expect(checkAuthors('authors: x'), isEmpty);
    });

    test('both author and authors is not allowed', () {
      expect(checkAuthors('author: x\nauthors: x'), isNotEmpty);
    });
  });

  group('too many dependencies', () {
    test('allow the limit', () {
      final dependencies =
          List.generate(100, (i) => '  dep$i: ^1.0.$i').join('\n');
      final pubspec = Pubspec.parse('''
name: test_pkg
version: 1.0.0-dev.1
dependencies:
$dependencies
''');
      expect(validateDependencies(pubspec), isEmpty);
    });

    test('forbid too many dependencies', () {
      final dependencies =
          List.generate(101, (i) => '  dep$i: ^1.0.$i').join('\n');
      final pubspec = Pubspec.parse('''
name: test_pkg
version: 1.0.0-dev.1
dependencies:
$dependencies
''');
      expect(validateDependencies(pubspec), isNotEmpty);
    });
  });

  group('forbid invalid dependency names', () {
    final names = [
      'a.',
      'a-b',
      'a/',
      '0a',
    ];

    test('normal dependencies are restricted', () {
      for (final name in names) {
        final pubspec = Pubspec.parse('''
name: test_pkg
version: 1.0.0
dependencies:
  $name: any
''');
        expect(validateDependencies(pubspec), isNotEmpty);
      }
    });

    test('dev dependencies are allowed', () {
      for (final name in names) {
        final pubspec = Pubspec.parse('''
name: test_pkg
version: 1.0.0
dev_dependencies:
  $name: any
''');
        expect(validateDependencies(pubspec), isEmpty);
      }
    });
  });

  group('forbid git dependencies', () {
    test('normal dependencies are fine', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        test: ^1.0.0
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isEmpty);
    });

    test('flutter dependencies are fine', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        flutter:
          sdk: flutter
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isEmpty);
    });

    test('Unknown SDK', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        kittens:
          sdk: kittens
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isEmpty);
    });

    test('compact git dependency is forbidden', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        kittens:
          git: git://github.com/munificent/kittens.git
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isNotEmpty);
    });

    test('git dependency with url and path is forbidden', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        kittens:
          git:
            url: git://github.com/munificent/kittens.git
            path: some/directory/inside/the/repo
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isNotEmpty);
    });

    test('custom hosted dependencies are forbidden', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        kittens:
          hosted:
            name: kittens
            url: 'https://not-the-right-pub.dev'
          version: ^1.0.0
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isNotEmpty);
    });

    test('renaming hosted dependencies is forbidden', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dependencies:
        kittens:
          hosted:
            name: cats
          version: ^1.0.0
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isNotEmpty);
    });

    test('git dev_dependencies are fine', () {
      final pubspec = Pubspec.parse('''
      name: hack
      version: 1.0.1
      dev_dependencies:
        kittens:
          git: git://github.com/munificent/kittens.git
      ''');
      expect(forbidGitDependencies(pubspec).toList(), isEmpty);
    });
  });

  group('real-world pubspec files', () {
    test('package:provider', () {
      final pubspec = Pubspec.parse('''
      name: provider
      description: A mixture between dependency injection and state management, built with widgets for widgets.
      version: 3.1.0
      homepage: https://github.com/rrousselGit/provider
      authors:
        - Remi Rousselet <darky12s@gmail.com>
        - Flutter Team <flutter-dev@googlegroups.com>
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
      
      dependencies:
        flutter:
          sdk: flutter
      
      dev_dependencies:
        pedantic: ^1.4.0
        mockito: ^4.0.0
        flutter_test:
          sdk: flutter
      ''');
      expect(forbidGitDependencies(pubspec), isEmpty);
    });

    test('package:camera', () {
      final pubspec = Pubspec.parse('''
      name: camera
      description: A Flutter plugin for getting information about and controlling the
        camera on Android and iOS. Supports previewing the camera feed, capturing images, capturing video,
        and streaming image buffers to dart.
      version: 0.5.2+1
      authors:
        - Flutter Team <flutter-dev@googlegroups.com>
        - Luigi Agosti <luigi@tengio.com>
        - Quentin Le Guennec <quentin@tengio.com>
        - Koushik Ravikumar <koushik@tengio.com>
        - Nissim Dsilva <nissim@tengio.com>
      
      homepage: https://github.com/flutter/plugins/tree/master/packages/camera
      
      dependencies:
        flutter:
          sdk: flutter
      
      dev_dependencies:
        path_provider: ^0.5.0
        video_player: ^0.10.0
      
      flutter:
        plugin:
          androidPackage: io.flutter.plugins.camera
          pluginClass: CameraPlugin
      
      environment:
        sdk: ">=2.0.0-dev.28.0 <3.0.0"
        flutter: ">=1.2.0 <2.0.0"
      ''');
      expect(forbidGitDependencies(pubspec), isEmpty);
    });
  });

  group('forbid conflicting flutter plugin schemes', () {
    test('simple_plugin old scheme', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.2.0 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          androidPackage: 'io.flutter.plugins.myplugin'
          iosPrefix: 'FLT'
          pluginClass: 'MyPlugin'
      ''');
      expect(forbidConflictingFlutterPluginSchemes(pubspec), isEmpty);
    });

    test('simple_plugin new scheme', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.12.0 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          platforms:
            ios:
              classPrefix: 'FLT'
              pluginClass: 'SamplePlugin'
      ''');
      expect(forbidConflictingFlutterPluginSchemes(pubspec), isEmpty);
    });

    test('simple_plugin old + new scheme', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.12.0 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          androidPackage: 'io.flutter.plugins.myplugin'
          iosPrefix: 'FLT'
          pluginClass: 'MyPlugin'
          platforms:
            ios:
              classPrefix: 'FLT'
              pluginClass: 'SamplePlugin'
      ''');
      expect(forbidConflictingFlutterPluginSchemes(pubspec), isNotEmpty);
    });

    test('simple_plugin new scheme, old sdk constraint', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.9.0 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          platforms:
            ios:
              classPrefix: 'FLT'
              pluginClass: 'SamplePlugin'
      ''');
      expect(forbidConflictingFlutterPluginSchemes(pubspec), isNotEmpty);
    });
  });

  group('require ios/ folder or flutter 1.20.0', () {
    test('old sdk constraint', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.19.9 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          platforms:
            android:
      ''');
      expect(requireIosFolderOrFlutter2_20(pubspec, []), isNotEmpty);
      expect(requireIosFolderOrFlutter2_20(pubspec, ['ios/']), isEmpty);
    });

    test('new sdk constraint', () {
      final pubspec = Pubspec.parse('''
      name: simple_plugin
      description: A simple_plugin
      version: 1.0.0
      homepage: https://example.com
      
      environment:
        sdk: ">=2.0.0 <3.0.0"
        flutter: ">=1.20.0 <2.0.0"

      dependencies:
        flutter:
          sdk: flutter
      
      flutter:
        plugin:
          platforms:
            android:
      ''');
      expect(requireIosFolderOrFlutter2_20(pubspec, []), isEmpty);
      expect(requireIosFolderOrFlutter2_20(pubspec, ['ios/']), isEmpty);
    });
  });

  group('require license content', () {
    test('no license file', () {
      expect(requireNonEmptyLicense(null, null), isNotEmpty);
    });

    test('non-default license', () {
      expect(requireNonEmptyLicense('LICENSE.txt', 'BSD license'), isNotEmpty);
    });

    test('empty file', () {
      expect(requireNonEmptyLicense('LICENSE', ''), isNotEmpty);
      expect(requireNonEmptyLicense('LICENSE', '\n  \n'), isNotEmpty);
    });

    test('generic TODO', () {
      expect(
          requireNonEmptyLicense('LICENSE', 'TODO: Add your license here.\n'),
          isNotEmpty);
    });

    test('valid-looking license', () {
      expect(requireNonEmptyLicense('LICENSE', 'BSD license'), isEmpty);
    });
  });

  group('pubspec.yaml to json conversion', () {
    test('pubspec.yaml to json conversion valid', () {
      final pubspec = '''
      name: provider     
      environment:
        sdk: ">=2.0.0 <3.0.0"
      dependencies:
        flutter:
          sdk: flutter
      ''';
      expect(checkValidJson(pubspec), isEmpty);
    });
    test('pubspec.yaml to json conversion invalid', () {
      final pubspec = '''
      name: provider    
      environment:
        sdk: ">=2.0.0 <3.0.0"
      dependencies:
        flutter:
          sdk: flutter
      mykey:
        [1,2,3,4,5]: 'value of a composite key'
      ''';
      expect(checkValidJson(pubspec), isNotEmpty);
    });
  });

  group('screenshots', () {
    test('not normalized path', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: a/../b.jpg
          description: abcd efgh ijkl
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']).single.message,
        contains('normalized'),
      );
    });

    test('missing file', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: abcd efgh ijkl
      ''');
      expect(
        checkScreenshots(pubspec, ['a.jpg']).single.message,
        contains('missing'),
      );
    });

    test('duplicate file', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: abcd efgh ijkl
        - path: b.jpg
          description: efgh ijkl abcd
      ''');
      // both files will emit 1 issue about being a duplicate
      expect(
        checkScreenshots(pubspec, ['b.jpg'])
            .map((e) => e.message)
            .every((e) => e.contains('only once')),
        isTrue,
      );
    });

    test('no description', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: ''
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']).single.message,
        contains('too short'),
      );
    });

    test('short description', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: none
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']).single.message,
        contains('too short'),
      );
    });

    test('long description', () {
      final description = 'abcdefg' * 100;
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: $description
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']).single.message,
        contains('too long'),
      );
    });

    test('Zalgo in description', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: z͎͗ͣḁ̵̑l̉̃ͦg̐̓̒o͓̔ͥ
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']),
        isNotEmpty,
      );
    });

    test('OK', () {
      final pubspec = Pubspec.parse('''
      name: package
      screenshots:
        - path: b.jpg
          description: reasonable description
      ''');
      expect(
        checkScreenshots(pubspec, ['b.jpg']),
        isEmpty,
      );
    });
  });

  group('funding', () {
    test('bad top-level value', () {
      expect(checkFunding('funding: null'), isNotEmpty);
      expect(checkFunding('funding: 1'), isNotEmpty);
      expect(checkFunding('funding: {}'), isNotEmpty);
      expect(checkFunding('funding: true'), isNotEmpty);
      expect(checkFunding('funding: []'), isNotEmpty);
      expect(checkFunding('funding: https://example.com/fund-me'), isNotEmpty);
    });

    test('bad url value', () {
      expect(checkFunding('funding: [1]'), isNotEmpty);
      expect(checkFunding('funding: [" "]'), isNotEmpty);
      expect(
          checkFunding('funding: ["http://example.com/fund-me"]'), isNotEmpty);
    });

    test('too long url value', () {
      final url = 'https://github.com/${'a' * 255}';
      expect(checkFunding('funding: ["${url.substring(0, 255)}"]'), isEmpty);
      expect(checkFunding('funding: ["${url.substring(0, 256)}"]'), isNotEmpty);
    });

    test('OK', () {
      expect(checkFunding('funding: ["https://example.com/fund-me"]'), isEmpty);
      expect(checkFunding('funding:\n - https://example.com/fund-me'), isEmpty);
    });
  });

  group('topics', () {
    test('not a list', () {
      final pubspec = '''
      name: package
      topics:
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('only a list')),
        isTrue,
      );
    });

    test('too many topic names', () {
      final pubspec = '''
      name: package
      topics:
        - button
        - widget
        - network
        - server
        - reliablity
        - client
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('at most 5')),
        isTrue,
      );
    });

    test('not a string', () {
      final pubspec = '''
      name: package
      topics:
        - a: button
        - b: widget
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('only strings')),
        isTrue,
      );
    });

    test('name too short', () {
      final pubspec = '''
      name: package
      topics:
        - button
        - widget
        - bu
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('too short')),
        isTrue,
      );
    });

    test('name too long', () {
      final pubspec = '''
      name: package
      topics:
        - button
        - widget
        - thisisindeedaverylongnamefortopic
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('too long')),
        isTrue,
      );
    });

    test('duplicate name', () {
      final pubspec = '''
      name: package
      topics:
        - button
        - widget
        - button
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('present once')),
        isTrue,
      );
    });

    test('invalid name: starts with dash', () {
      final pubspec = '''
      name: package
      topics:
        - -button
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('must consist')),
        isTrue,
      );
    });

    test('invalid name: starts with number', () {
      final pubspec = '''
      name: package
      topics:
        - 1button
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('must consist')),
        isTrue,
      );
    });

    test('invalid name: ends with dash', () {
      final pubspec = '''
      name: package
      topics:
        - button-
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('must consist')),
        isTrue,
      );
    });

    test('invalid name: contains double dash', () {
      final pubspec = '''
      name: package
      topics:
        - but--ton
      ''';
      expect(
        checkTopics(pubspec)
            .map((e) => e.message)
            .every((e) => e.contains('must consist')),
        isTrue,
      );
    });

    test('OK', () {
      final pubspec = '''
      name: package
      topics:
        - but-ton
        - widget
      ''';
      expect(
        checkTopics(pubspec),
        isEmpty,
      );
    });
  });
}
