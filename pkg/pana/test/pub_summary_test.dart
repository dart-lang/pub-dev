// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/src/pkg_resolution.dart';
import 'package:pana/src/pubspec.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('PkgResolution.create', () {
    final pubspec = new Pubspec({});

    test('pub parse', () {
      var summary = PkgResolution.create(pubspec, _pubUpgradeOutput);

      expect(summary.dependencies, hasLength(61));
      final args =
          summary.dependencies.firstWhere((pd) => pd.package == 'args');
      expect(args.resolved, new Version.parse('0.13.7'));
      expect(args.available, isNull);
      expect(args.isLatest, isTrue);

      final analyzer =
          summary.dependencies.firstWhere((pd) => pd.package == 'analyzer');
      expect(analyzer.resolved, new Version.parse('0.29.8'));
      expect(analyzer.available, new Version.parse('0.30.0-alpha.1'));
      expect(analyzer.isOutdated, isTrue);

      expect(summary.outdated, hasLength(7));
      expect(summary.outdated, contains(analyzer));
    });

    test('upgrade', () {
      var summary = PkgResolution.create(pubspec, _upgradeOutput);

      expect(summary.dependencies, hasLength(47));
    });

    test('downgrade', () {
      var summary = PkgResolution.create(pubspec, _downgradeOutput);
      expect(summary.dependencies, hasLength(47));
    });
  });

  group('entries', () {
    test("stderr", () {
      var entries = PubEntry.parse(_pubErrorOutput).toList();

      expect(entries, hasLength(9));

      expect(entries.first.header, 'SLVR');
      expect(entries.first.content, hasLength(2));
    });

    test("stdout", () {
      var entries = PubEntry.parse(_pubUpgradeOutput).toList();
      expect(entries, hasLength(10));
    });
  });
}

final _upgradeOutput =
    r'''SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select http_parser 3.1.1 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select mime 0.9.3 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select shelf 0.6.7+2 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select barback 0.15.2+11 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select meta 1.0.5 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select source_maps 0.10.4 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select csslib 0.14.0 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select http 0.11.3+13 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select stack_trace 1.7.3 from hosted
SLVR: | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | * select args 0.13.7 from hosted
SLVR: BacktrackingSolver took 0:00:04.003996 seconds.
    | - Tried 1 solutions
    | - Requested 47 version lists
    | - Looked up 47 cached version lists
    |
FINE: Resolving dependencies finished (4.024s).
MSG :   analyzer 0.30.0+2
    |   args 0.13.7
    |   async 1.13.3
    |   barback 0.15.2+11
    |   boolean_selector 1.0.2
    |   charcode 1.1.1
    |   cli_util 0.1.1
    |   collection 1.14.1
    |   convert 2.0.1
    |   crypto 2.0.1
    |   csslib 0.14.0
    |   front_end 0.1.0-alpha.4
    |   glob 1.1.3
    |   html 0.13.2
    |   http 0.11.3+13
    |   http_multi_server 2.0.3
    |   http_parser 3.1.1
    |   isolate 1.0.0
    |   kernel 0.3.0-alpha.1
    |   logging 0.11.3+1
    |   matcher 0.12.1+1
    |   meta 1.0.5
    |   mime 0.9.3
    |   package_config 1.0.1
    |   package_resolver 1.0.2
    | > path 1.4.1 (was 1.4.0)
    |   plugin 0.2.0
    |   pool 1.3.1
    |   pub_semver 1.3.2
    |   quiver 0.25.0
    |   shelf 0.6.7+2
    |   shelf_packages_handler 1.0.0
    |   shelf_static 0.2.4
    |   shelf_web_socket 0.2.1
    |   source_map_stack_trace 1.1.4
    |   source_maps 0.10.4
    |   source_span 1.4.0
    |   stack_trace 1.7.3
    |   stream_channel 1.6.1
    |   string_scanner 1.0.2
    |   term_glyph 1.0.0
    |   test 0.12.21
    |   typed_data 1.1.3
    |   utf 0.9.0+3
    |   watcher 0.9.7+3
    |   web_socket_channel 1.0.4
    |   yaml 2.1.12
IO  : Writing 6285 characters to text file ./pubspec.lock.''';

final _downgradeOutput = r'''FINE: Resolving dependencies finished (3.869s).
MSG :   analyzer 0.30.0+2
    |   args 0.13.7
    |   async 1.13.3
    |   barback 0.15.2+11
    |   boolean_selector 1.0.2
    |   charcode 1.1.1
    |   cli_util 0.1.1
    |   collection 1.14.1
    |   convert 2.0.1
    |   crypto 2.0.1
    |   csslib 0.14.0
    |   front_end 0.1.0-alpha.4
    |   glob 1.1.3
    |   html 0.13.2
    |   http 0.11.3+13
    |   http_multi_server 2.0.3
    |   http_parser 3.1.1
    |   isolate 1.0.0
    |   kernel 0.3.0-alpha.1
    |   logging 0.11.3+1
    |   matcher 0.12.1+1
    |   meta 1.0.5
    |   mime 0.9.3
    |   package_config 1.0.1
    |   package_resolver 1.0.2
    | < path 1.4.0 (was 1.4.1) (1.4.1 available)
    |   plugin 0.2.0
    |   pool 1.3.1
    |   pub_semver 1.3.2
    |   quiver 0.25.0
    |   shelf 0.6.7+2
    |   shelf_packages_handler 1.0.0
    |   shelf_static 0.2.4
    |   shelf_web_socket 0.2.1
    |   source_map_stack_trace 1.1.4
    |   source_maps 0.10.4
    |   source_span 1.4.0
    |   stack_trace 1.7.3
    |   stream_channel 1.6.1
    |   string_scanner 1.0.2
    |   term_glyph 1.0.0
    |   test 0.12.21
    |   typed_data 1.1.3
    |   utf 0.9.0+3
    |   watcher 0.9.7+3
    |   web_socket_channel 1.0.4
    |   yaml 2.1.12
IO  : Get package from https://pub.dartlang.org/packages/path/versions/1.4.0.tar.gz.''';

final _pubErrorOutput =
    r'''SLVR: | version 0.12.0-beta.5 of test doesn't match >=0.12.4 <0.12.5:
    | |   unittest 0.12.4+1 (root) -> test >=0.12.4 <0.12.5 from hosted (test)
SLVR: | version 0.12.0-beta.4 of test doesn't match >=0.12.4 <0.12.5:
    | |   unittest 0.12.4+1 (root) -> test >=0.12.4 <0.12.5 from hosted (test)
SLVR: | version 0.12.0-beta.3 of test doesn't match >=0.12.4 <0.12.5:
    | |   unittest 0.12.4+1 (root) -> test >=0.12.4 <0.12.5 from hosted (test)
SLVR: | version 0.12.0-beta.2 of test doesn't match >=0.12.4 <0.12.5:
    | |   unittest 0.12.4+1 (root) -> test >=0.12.4 <0.12.5 from hosted (test)
SLVR: BacktrackingSolver took 0:00:00.355302 seconds.
    | - Tried 1 solutions
    | - Requested 1 version lists
    | - Looked up 1 cached version lists
    |
FINE: Resolving dependencies finished (0.381s).
ERR : Package test has no versions that match >=0.12.4 <0.12.5 derived from:
    | - unittest depends on version >=0.12.4 <0.12.5
FINE: Exception type: NoVersionException
FINE: package:pub/src/entrypoint.dart 194                                           Entrypoint.acquireDependencies
    | package:pub/src/command/upgrade.dart 41                                       UpgradeCommand.run
    | package:args/command_runner.dart 194                                          CommandRunner.runCommand
    | package:pub/src/command_runner.dart 168                                       PubCommandRunner.runCommand.<fn>
    | dart:async                                                                    new Future.sync
    | package:pub/src/utils.dart 99                                                 captureErrors.<fn>
    | package:stack_trace                                                           Chain.capture
    | package:pub/src/utils.dart 114                                                captureErrors
    | package:pub/src/command_runner.dart 168                                       PubCommandRunner.runCommand
    | package:pub/src/command_runner.dart 117                                       PubCommandRunner.run
    | /b/build/slave/dart-sdk-mac-dev/build/sdk/third_party/pkg/pub/bin/pub.dart 8  main
    | ===== asynchronous gap ===========================
    | dart:async                                                                    _Completer.completeError
    | package:pub/src/entrypoint.dart 242                                           Entrypoint.acquireDependencies
    | ===== asynchronous gap ===========================
    | dart:async                                                                    _asyncThenWrapperHelper
    | package:pub/src/entrypoint.dart 191                                           Entrypoint.acquireDependencies
    | package:pub/src/command/upgrade.dart 41                                       UpgradeCommand.run
    | ===== asynchronous gap ===========================
    | dart:async                                                                    new Future.microtask
    | package:pub/src/command/upgrade.dart 40                                       UpgradeCommand.run
    | package:args/command_runner.dart 194                                          CommandRunner.runCommand
    | ===== asynchronous gap ===========================
    | dart:async                                                                    new Future.microtask
    | package:args/command_runner.dart 142                                          CommandRunner.runCommand
    | package:pub/src/command_runner.dart 168                                       PubCommandRunner.runCommand.<fn>
    | dart:async                                                                    new Future.sync
    | package:pub/src/utils.dart 99                                                 captureErrors.<fn>
    | package:stack_trace                                                           Chain.capture
    | package:pub/src/utils.dart 114                                                captureErrors
    | package:pub/src/command_runner.dart 168                                       PubCommandRunner.runCommand''';

final _pubUpgradeOutput =
    r'''IO  : Finished /Users/kevmoo/homebrew/Cellar/dart/1.23.0-dev.5.0/libexec/bin/dart. Exit code 0.
    | Nothing output on stdout.
    | Nothing output on stderr.
FINE: Precompiling executables finished (2.071s).

MSG : Resolving dependencies...
MSG : + analyzer 0.29.8 (0.30.0-alpha.1 available)
    | + args 0.13.7
    | + async 1.13.2
    | + barback 0.15.2+9
    | + boolean_selector 1.0.2
    | + build 0.5.0 (0.7.2 available)
    | + build_test 0.2.0+1 (0.4.1 available)
    | + charcode 1.1.1
    | + cli_util 0.0.1+2
    | + code_builder 1.0.0-alpha+5 (1.0.0-beta+5 available)
    | + code_transformers 0.5.1
    | + collection 1.13.0
    | + convert 2.0.1
    | + crypto 2.0.1
    | + csslib 0.13.4
    | + dart_style 0.2.16
    | + fixnum 0.10.5
    | + func 0.1.1
    | + glob 1.1.3
    | + html 0.13.1
    | + http 0.11.3+12
    | + http_multi_server 2.0.3
    | + http_parser 3.1.1
    | + intl 0.14.0
    | + isolate 1.0.0
    | + js 0.6.1
    | + logging 0.11.3+1
    | + matcher 0.12.0+2
    | + meta 1.0.4
    | + mime 0.9.3
    | + mockito 1.0.1 (2.0.2 available)
    | + observable 0.14.0+1 (0.20.4 available)
    | + package_config 1.0.0
    | + package_resolver 1.0.2
    | + path 1.4.1
    | + plugin 0.2.0
    | + pool 1.3.0
    | + protobuf 0.5.3
    | + pub_semver 1.3.2
    | + quiver 0.24.0
    | + shelf 0.6.7+2
    | + shelf_packages_handler 1.0.0
    | + shelf_static 0.2.4
    | + shelf_web_socket 0.2.1
    | + source_gen 0.5.3+2 (0.5.4+2 available)
    | + source_map_stack_trace 1.1.4
    | + source_maps 0.10.3
    | + source_span 1.3.1
    | + stack_trace 1.7.3
    | + stream_channel 1.6.1
    | + string_scanner 1.0.1
    | + term_glyph 1.0.0
    | + test 0.12.20+3
    | + transformer_test 0.2.1+1
    | + typed_data 1.1.3
    | + utf 0.9.0+3
    | + watcher 0.9.7+3
    | + web_socket_channel 1.0.4
    | + when 0.2.0
    | + which 0.1.3
    | + yaml 2.1.12
MSG : Downloading code_builder 1.0.0-alpha+5...
MSG : Downloading build_test 0.2.0+1...
MSG : Changed 61 dependencies!
MSG : Precompiling dependencies...
MSG : Loading source assets...
MSG : Precompiled dart_style and intl.''';
