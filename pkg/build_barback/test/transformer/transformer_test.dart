// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:async';

import 'package:build/build.dart';
import 'package:build_barback/build_barback.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:transformer_test/utils.dart';

void main() {
  var singleCopyTransformer = new BuilderTransformer(new CopyBuilder());
  var multiCopyTransformer =
      new BuilderTransformer(new CopyBuilder(numCopies: 2));
  var singleAndMultiCopyTransformer = new BuilderTransformer(
      new MultiplexingBuilder(
          [new CopyBuilder(), new CopyBuilder(numCopies: 2)]));

  testPhases('single builder, single output', [
    [singleCopyTransformer],
  ], {
    'a|web/a.txt': 'hello',
  }, {
    'a|web/a.txt.copy': 'hello',
  });

  testPhases('single builder, multiple outputs', [
    [multiCopyTransformer],
  ], {
    'a|web/a.txt': 'hello',
  }, {
    'a|web/a.txt.copy.0': 'hello',
    'a|web/a.txt.copy.1': 'hello',
  });

  testPhases('multiple builders, different outputs', [
    [singleAndMultiCopyTransformer],
  ], {
    'a|web/a.txt': 'hello',
  }, {
    'a|web/a.txt.copy': 'hello',
    'a|web/a.txt.copy.0': 'hello',
    'a|web/a.txt.copy.1': 'hello',
  });

  testPhases('multiple builders, same outputs', [
    [
      new BuilderTransformer(
          new MultiplexingBuilder([new CopyBuilder(), new CopyBuilder()]))
    ],
  ], {
    'a|web/a.txt': 'hello',
  }, {}, messages: [
    _fileExistsError(
        '${[new CopyBuilder(), new CopyBuilder()]}', ['a|web/a.txt.copy']),
  ]);

  testPhases('multiple phases', [
    [singleCopyTransformer],
    [multiCopyTransformer],
  ], {
    'a|web/a.txt': 'hello',
  }, {
    'a|web/a.txt.copy': 'hello',
    'a|web/a.txt.copy.0': 'hello',
    'a|web/a.txt.copy.1': 'hello',
    'a|web/a.txt.copy.copy.0': 'hello',
    'a|web/a.txt.copy.copy.1': 'hello',
  });

  testPhases('multiple transformers in the same phase', [
    [singleCopyTransformer, multiCopyTransformer],
  ], {
    'a|web/a.txt': 'hello',
  }, {
    'a|web/a.txt.copy': 'hello',
    'a|web/a.txt.copy.0': 'hello',
    'a|web/a.txt.copy.1': 'hello',
  });

  testPhases(
      'cant overwrite files',
      [
        [singleCopyTransformer]
      ],
      {'a|web/a.txt': 'hello', 'a|web/a.txt.copy': 'hello'},
      {},
      messages: [
        _fileExistsError('${new CopyBuilder()}', ['a|web/a.txt.copy']),
      ],
      expectBarbackErrors: true);

  // Gives a barback error only, we can't detect this situation.
  testPhases(
      'builders in the same phase can\'t output the same file',
      [
        [singleCopyTransformer, new BuilderTransformer(new CopyBuilder())]
      ],
      {
        'a|web/a.txt': 'hello',
      },
      {'a|web/a.txt.copy': 'hello'},
      expectBarbackErrors: true);

  testPhases(
      'builders in separate phases can\'t output the same file',
      [
        [singleCopyTransformer],
        [singleCopyTransformer],
      ],
      {'a|web/a.txt': 'hello'},
      {},
      messages: [
        _fileExistsError('${new CopyBuilder()}', ['a|web/a.txt.copy']),
      ],
      expectBarbackErrors: true);

  testPhases('loggers log errors', [
    [new BuilderTransformer(new LoggingCopyBuilder())],
  ], {
    'a|web/a.txt': 'a',
    'a|web/b.txt': 'b',
  }, {}, messages: [
    allOf(startsWith('warning: Warning!'), contains('Error: SomeError'),
        contains('LoggingCopyBuilder.build')),
    allOf(startsWith('error: Error!'), contains('Error: SomeError'),
        contains('LoggingCopyBuilder.build')),
    allOf(startsWith('warning: Warning!'), contains('SomeError'),
        contains('LoggingCopyBuilder.build')),
    allOf(startsWith('error: Error!'), contains('SomeError'),
        contains('LoggingCopyBuilder.build')),
  ]);

  testPhases('can resolve a library', [
    [new BuilderTransformer(new ResolvingBuilder())]
  ], {
    'a|lib/a.dart': 'library a;'
  }, {
    'a|lib/a.libraryName': 'a'
  });

  testPhases('can resolve a library with package deps', [
    [new BuilderTransformer(new ResolvingBuilder())]
  ], {
    'a|lib/a.dart': 'library a;',
    'b|lib/b.dart': 'library b; import "package:a/a.dart";',
  }, {
    'a|lib/a.libraryName': 'a',
    'b|lib/b.libraryName': 'b',
  });

  testPhases('can resolve a library with package deps when ran out of order', [
    [new BuilderTransformer(new ResolvingBuilder())]
  ], {
    'b|lib/b.dart': 'library b; import "package:a/a.dart";',
    'a|lib/a.dart': 'library a;',
  }, {
    'a|lib/a.libraryName': 'a',
    'b|lib/b.libraryName': 'b',
  });

  testPhases('can resolve a library with missing package deps', [
    [new BuilderTransformer(new ResolvingBuilder())]
  ], {
    'a|lib/a.dart': 'library a; import "b.dart";',
  }, {
    'a|lib/a.libraryName': 'a',
  });
}

class ResolvingBuilder extends Builder {
  @override
  Future build(BuildStep buildStep) async {
    var library = await buildStep.inputLibrary;
    await buildStep.writeAsString(
        buildStep.inputId.changeExtension('.libraryName'), library.name);
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['.libraryName']
      };
}

class LoggingCopyBuilder extends CopyBuilder {
  LoggingCopyBuilder() : super();

  @override
  Future build(BuildStep buildStep) async {
    await super.build(buildStep);
    try {
      throw 'SomeError';
    } catch (e, s) {
      log.warning('Warning!', e, s);
      log.severe('Error!', e, s);
    }
  }
}

String _fileExistsError(String builder, List<String> files) {
  return "error: Builder `$builder` declared outputs "
      "`$files` but those files already exist. This build step has been "
      "skipped.";
}
