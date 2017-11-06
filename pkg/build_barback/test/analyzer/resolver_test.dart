// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:async';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:code_transformers/resolver.dart' as code_transformers
    show Resolver, Resolvers, dartSdkDirectory;
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'package:build_barback/build_barback.dart';
import 'package:build_barback/src/util/barback.dart';

class ResolversSpy implements BarbackResolvers {
  code_transformers.Resolver lastResolved;
  static final code_transformers.Resolvers _resolvers =
      new code_transformers.Resolvers(code_transformers.dartSdkDirectory);

  @override
  Future<ReleasableResolver> get(BuildStep buildStep) async {
    lastResolved = await _resolvers.get(toBarbackTransform(buildStep),
        [toBarbackAssetId(buildStep.inputId)], false);
    return new BarbackResolver(lastResolved);
  }
}

// Ported from
// https://github.com/dart-lang/code_transformers/blob/master/test/resolver_test.dart
void main() {
  var entryPoint = makeAssetId('a|web/main.dart');

  ResolversSpy _resolvers;

  setUp(() {
    _resolvers = new ResolversSpy();
  });

  Future validateResolver(
      {Map<String, String> inputs,
      Future validator(Resolver resolver),
      List messages: const []}) async {
    var writer = new InMemoryAssetWriter();
    var reader = new InMemoryAssetReader(sourceAssets: writer.assets);
    var actualInputs = <AssetId, String>{};
    inputs.forEach((k, v) => actualInputs[makeAssetId(k)] = v);
    addAssets(actualInputs, writer);

    var builder = new TestBuilder(validator);
    var logger = new Logger('test');
    var logs = <LogRecord>[];
    if (messages != null) {
      logger.onRecord.listen(logs.add);
    }
    await runBuilder(builder, [entryPoint], reader, writer, _resolvers,
        logger: logger);
    if (messages != null) {
      expect(logs.map((l) => l.toString()), messages);
    }
  }

  group('Resolver', () {
    test('should handle initial files', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': ' main() {}',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);

            var source = (_resolvers.lastResolved as dynamic)
                .sources[toBarbackAssetId(entryPoint)];
            expect(source.modificationStamp, 1);

            expect(lib, isNotNull);
          });
    });

    test('should update when sources change', () async {
      return validateResolver(
          inputs: {
            'a|web/main.dart': ''' main() {
                } ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);

            var source = (_resolvers.lastResolved as dynamic)
                .sources[toBarbackAssetId(entryPoint)];
            expect(source.modificationStamp, 2);

            expect(lib, isNotNull);
            expect(lib.entryPoint, isNotNull);
          });
    });

    test('should follow imports', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'a.dart';

              main() {
              } ''',
            'a|web/a.dart': '''
              library a;
              ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
            var libA = lib.importedLibraries.where((l) => l.name == 'a').single;
            expect(libA.getType('Foo'), isNull);
          });
    });

    test('should update changed imports', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'a.dart';

              main() {
              } ''',
            'a|web/a.dart': '''
              library a;
              class Foo {}
              ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
            var libA = lib.importedLibraries.where((l) => l.name == 'a').single;
            expect(libA.getType('Foo'), isNotNull);
          });
    });

    test('should follow package imports', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'package:b/b.dart';

              main() {
              } ''',
            'b|lib/b.dart': '''
              library b;
              ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
            var libB = lib.importedLibraries.where((l) => l.name == 'b').single;
            expect(libB.getType('Foo'), isNull);
          });
    });

    test('handles missing files', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'package:b/missing.dart';

              main() {
              } ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
          });
    });

    test('should update on changed package imports', () {
      // TODO(sigmund): remove modification below, see dartbug.com/22638
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'package:b/missing.dart';

              main() {
              } // modified, but we shouldn't need to! ''',
            'b|lib/missing.dart': '''
              library b;
              class Bar {}
              ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
            var libB = lib.importedLibraries.where((l) => l.name == 'b').single;
            expect(libB.getType('Bar'), isNotNull);
          });
    });

    test('should handle deleted files', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'package:b/missing.dart';

              main() {
              } ''',
          },
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
          });
    });

    test('should fail on absolute URIs', () {
      var warningMessage = 'absolute paths not allowed:';
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import '/b.dart';

              main() {
              } ''',
          },
          messages: [
            '[WARNING] test: $warningMessage "/b.dart"',
          ],
          validator: (resolver) async {
            var lib = await resolver.libraryFor(entryPoint);
            expect(lib.importedLibraries, hasLength(2));
          });
    });

    test('should list all libraries', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              library a.main;
              import 'package:a/a.dart';
              import 'package:a/b.dart';
              export 'package:a/d.dart';
              ''',
            'a|lib/a.dart': 'library a.a;\n import "package:a/c.dart";',
            'a|lib/b.dart': 'library a.b;\n import "c.dart";',
            'a|lib/c.dart': 'library a.c;',
            'a|lib/d.dart': 'library a.d;'
          },
          validator: (resolver) async {
            var libs =
                await resolver.libraries.where((l) => !l.isInSdk).toList();
            expect(
                libs.map((l) => l.name),
                unorderedEquals([
                  'a.main',
                  'a.a',
                  'a.b',
                  'a.c',
                  'a.d',
                ]));
          });
    });

    test('handles circular imports', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
                library main;
                import 'package:a/a.dart'; ''',
            'a|lib/a.dart': '''
                library a;
                import 'package:a/b.dart'; ''',
            'a|lib/b.dart': '''
                library b;
                import 'package:a/a.dart'; ''',
          },
          validator: (resolver) async {
            var libs = await resolver.libraries.map((lib) => lib.name).toList();
            expect(libs.contains('a'), isTrue);
            expect(libs.contains('b'), isTrue);
          });
    });

    test('handles parallel resolves', () async {
      return Future.wait([
        validateResolver(
            inputs: {
              'a|web/main.dart': '''
                library foo;'''
            },
            validator: (resolver) async {
              expect((await resolver.libraryFor(entryPoint)).name, 'foo');
            }),
        validateResolver(
            inputs: {
              'a|web/main.dart': '''
                library bar;'''
            },
            validator: (resolver) async {
              expect((await resolver.libraryFor(entryPoint)).name, 'bar');
            }),
      ]);
    });
  });
}

class TestBuilder extends Builder {
  final Future Function(Resolver) validator;

  TestBuilder(this.validator);

  @override
  final buildExtensions = const {
    '': const ['.unused']
  };

  @override
  Future build(BuildStep buildStep) async {
    await validator(buildStep.resolver);
  }
}
