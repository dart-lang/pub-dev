// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

// TODO: Test that messages contains some substring.
void main() {
  group('package name validation', () {
    test('reject unknown mixed-case', () {
      expect(validatePackageName('myNewPackage'), isNotEmpty);
    });

    test('accept only lower-case babylon (original author continues it)', () {
      expect(validatePackageName('Babylon'), isNotEmpty);
      expect(validatePackageName('babylon'), isEmpty);
    });

    test('accept only upper-case Pong (no contact with author)', () {
      expect(validatePackageName('pong'), isNotEmpty);
      expect(validatePackageName('Pong'), isEmpty);
    });

    test('reject unknown mixed-case', () {
      expect(validatePackageName('pong'), isNotEmpty);
    });

    test('accept lower-case', () {
      expect(validatePackageName('my_package'), isEmpty);
    });

    test('reject reserved words', () {
      expect(validatePackageName('do'), isNotEmpty);
      expect(validatePackageName('d_o'), isNotEmpty);
    });

    test('check the length of the name', () {
      expect(validatePackageName('a234567890' * 6 + '1234'), isEmpty);
      expect(validatePackageName('a234567890' * 6 + '12345'), isNotEmpty);
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
}
