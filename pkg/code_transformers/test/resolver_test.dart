// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
library code_transformers.test.resolver_test;

import 'dart:async';

import 'package:barback/barback.dart';
import 'package:code_transformers/resolver.dart';
import 'package:transformer_test/utils.dart';
import 'package:test/test.dart';

import 'package:code_transformers/src/dart_sdk.dart' show mockSdkSources;

main() {
  group('mock sdk', () {
    resolverTests(new Resolvers.fromMock(mockSdkSources));
  });

  group('real sdk', () {
    resolverTests(new Resolvers(testingDartSdkDirectory));
  });

  group('shared sources', () {
    resolverTests(new Resolvers.fromMock(mockSdkSources));
  });
}

resolverTests(Resolvers resolvers) {
  var entryPoint = new AssetId('a', 'web/main.dart');
  Future validateResolver(
      {Map<String, String> inputs,
      validator(Resolver),
      List<String> messages: const [],
      bool resolveAllLibraries: true}) {
    return applyTransformers([
      [
        new TestTransformer(
            resolvers, entryPoint, validator, resolveAllLibraries)
      ]
    ], inputs: inputs, messages: messages);
  }

  group('Resolver', () {
    test('should handle initial files', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': ' main() {}',
          },
          validator: (resolver) {
            var source = resolver.sources[entryPoint];
            expect(source.modificationStamp, 1);

            var lib = resolver.getLibrary(entryPoint);
            expect(lib, isNotNull);
          });
    });

    test('should update when sources change', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': ''' main() {
                } ''',
          },
          validator: (resolver) {
            var source = resolver.sources[entryPoint];
            expect(source.modificationStamp, 2);

            var lib = resolver.getLibrary(entryPoint);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
            expect(lib.importedLibraries.where((l) => l.name == 'b'), isEmpty);
          });
    });

    test('should fail on absolute URIs', () {
      var warningPrefix = 'warning: absolute paths not allowed';
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import '/b.dart';

              main() {
              } ''',
          },
          messages: [
            // First from the AST walker
            '$warningPrefix: "/b.dart" (web/main.dart 0 14)',
          ],
          validator: (resolver) {
            var lib = resolver.getLibrary(entryPoint);
            expect(lib.importedLibraries.length, 2);
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
          validator: (resolver) {
            var libs = resolver.libraries.where((l) => !l.isInSdk);
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

    test('should resolve types and library uris', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              import 'dart:core';
              import 'package:a/a.dart';
              import 'package:a/b.dart';
              import 'sub_dir/d.dart';
              class Foo {}
              ''',
            'a|lib/a.dart': 'library a.a;\n import "package:a/c.dart";',
            'a|lib/b.dart': 'library a.b;\n import "c.dart";',
            'a|lib/c.dart': '''
                library a.c;
                class Bar {}
                ''',
            'a|web/sub_dir/d.dart': '''
                library a.web.sub_dir.d;
                class Baz{}
                ''',
          },
          validator: (resolver) {
            var a = resolver.getLibraryByName('a.a');
            expect(a, isNotNull);
            expect(resolver.getImportUri(a).toString(), 'package:a/a.dart');
            expect(resolver.getLibraryByUri(Uri.parse('package:a/a.dart')), a);

            var main = resolver.getLibraryByName('');
            expect(main, isNotNull);
            expect(resolver.getImportUri(main), isNull);

            var fooType = resolver.getType('Foo');
            expect(fooType, isNotNull);
            expect(fooType.library, main);

            var barType = resolver.getType('a.c.Bar');
            expect(barType, isNotNull);
            expect(resolver.getImportUri(barType.library).toString(),
                'package:a/c.dart');
            expect(resolver.getSourceAssetId(barType),
                new AssetId('a', 'lib/c.dart'));

            var bazType = resolver.getType('a.web.sub_dir.d.Baz');
            expect(bazType, isNotNull);
            expect(resolver.getImportUri(bazType.library), isNull);
            expect(
                resolver
                    .getImportUri(bazType.library, from: entryPoint)
                    .toString(),
                'sub_dir/d.dart');

            var hashMap = resolver.getType('dart.collection.HashMap');
            expect(resolver.getImportUri(hashMap.library).toString(),
                'dart:collection');
            expect(resolver.getLibraryByUri(Uri.parse('dart:collection')),
                hashMap.library);
          });
    });

    test('should resolve constants in transitive imports by default', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''
              library web.main;

              import 'package:a/do_resolve.dart';
              export 'package:a/do_resolve.dart';

              class Foo extends Bar {}
              ''',
            'a|lib/do_resolve.dart': '''
              library a.do_resolve;

              const int annotation = 0;
              @annotation
              class Bar {}''',
          },
          validator: (resolver) {
            var main = resolver.getLibraryByName('web.main');
            // Navigate to the library via Element models
            var meta =
                main.unit.declarations[0].element.supertype.element.metadata[0];
            expect(meta, isNotNull);
            expect(meta.constantValue, isNotNull);

            // Get the library from the resolver directly
            var lib = resolver.getLibraryByName('a.do_resolve');
            meta = lib.unit.declarations[1].element.metadata[0];
            expect(meta, isNotNull);
            expect(meta.constantValue, isNotNull);
          });
    });

    test('can disable resolving of constants in transitive imports', () {
      return validateResolver(
          resolveAllLibraries: false,
          inputs: {
            'a|web/main.dart': '''
              library web.main;

              import 'package:a/dont_resolve.dart';
              export 'package:a/dont_resolve.dart';

              class Foo extends Bar {}
              ''',
            'a|lib/dont_resolve.dart': '''
              library a.dont_resolve;

              const int annotation = 0;
              @annotation
              class Bar {}''',
          },
          validator: (resolver) {
            var main = resolver.getLibraryByName('web.main');
            var meta =
                main.unit.declarations[0].element.supertype.element.metadata[0];
            expect(meta, isNotNull);
            expect(meta.constantValue, isNull);
          });
    });

    test('deleted files should be removed', () {
      return validateResolver(
          inputs: {
            'a|web/main.dart': '''import 'package:a/a.dart';''',
            'a|lib/a.dart': '''import 'package:a/b.dart';''',
            'a|lib/b.dart': '''class Engine{}''',
          },
          validator: (resolver) {
            var engine = resolver.getType('Engine');
            var uri = resolver.getImportUri(engine.library);
            expect(uri.toString(), 'package:a/b.dart');
          }).then((_) {
        return validateResolver(
            inputs: {
              'a|web/main.dart': '''import 'package:a/a.dart';''',
              'a|lib/a.dart': '''lib a;\n class Engine{}'''
            },
            validator: (resolver) {
              var engine = resolver.getType('Engine');
              var uri = resolver.getImportUri(engine.library);
              expect(uri.toString(), 'package:a/a.dart');

              // Make sure that we haven't leaked any sources.
              expect(resolver.sources.length, 2);
            });
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
          validator: (resolver) {
            var libs = resolver.libraries.map((lib) => lib.name);
            expect(libs.contains('a'), isTrue);
            expect(libs.contains('b'), isTrue);
          });
    });

    test('handles parallel resolves', () {
      return Future.wait([
        validateResolver(
            inputs: {
              'a|web/main.dart': '''
                library foo;'''
            },
            validator: (resolver) {
              expect(resolver.getLibrary(entryPoint).name, 'foo');
            }),
        validateResolver(
            inputs: {
              'a|web/main.dart': '''
                library bar;'''
            },
            validator: (resolver) {
              expect(resolver.getLibrary(entryPoint).name, 'bar');
            }),
      ]);
    });
  });
}

class TestTransformer extends Transformer with ResolverTransformer {
  final AssetId primary;
  final Function validator;
  final bool resolveAllLibraries;

  TestTransformer(Resolvers resolvers, this.primary, this.validator,
      this.resolveAllLibraries) {
    this.resolvers = resolvers;
  }

  // TODO(nweiz): This should just take an AssetId when barback <0.13.0 support
  // is dropped.
  Future<bool> isPrimary(idOrAsset) {
    var id = idOrAsset is AssetId ? idOrAsset : (idOrAsset as Asset).id;
    return new Future.value(id == primary);
  }

  applyResolver(Transform transform, Resolver resolver) => validator(resolver);
}
