import 'package:pana/src/pubspec.dart';
import 'package:test/test.dart';

void main() {
  test('empty', () {
    expect(emptyPubspec.hasFlutterKey, isFalse);
    expect(emptyPubspec.hasFlutterPluginKey, isFalse);
    expect(emptyPubspec.dependsOnFlutterSdk, isFalse);
    expect(emptyPubspec.unconstrainedDependencies, isEmpty);
  });

  test('flutter', () {
    expect(flutterPluginPubspec.hasFlutterKey, isTrue);
    expect(flutterPluginPubspec.hasFlutterPluginKey, isTrue);
    expect(flutterPluginPubspec.dependsOnFlutterSdk, isFalse);
    expect(flutterPluginPubspec.unconstrainedDependencies, isEmpty);
    expect(flutterSdkPubspec.hasFlutterKey, isFalse);
    expect(flutterSdkPubspec.hasFlutterPluginKey, isFalse);
    expect(flutterSdkPubspec.dependsOnFlutterSdk, isTrue);
    expect(flutterSdkPubspec.unconstrainedDependencies, isEmpty);
    expect(flutterSdkDevPubspec.dependentSdks.toList(), ['flutter']);
    expect(flutterSdkDevPubspec.hasFlutterKey, isFalse);
    expect(flutterSdkDevPubspec.hasFlutterPluginKey, isFalse);
    expect(flutterSdkDevPubspec.dependsOnFlutterSdk, isTrue);
    expect(flutterSdkDevPubspec.unconstrainedDependencies, isEmpty);
    expect(flutterSdkDevPubspec.dependentSdks.toList(), ['flutter']);
  });

  test('unknown sdk', () {
    expect(unknownSdkPubspec.dependentSdks.toList(), ['unknown']);
  });

  test('detect any', () {
    expect(broadDependenciesPubspec.unconstrainedDependencies,
        ['async', 'http', 'markdown', 'mustache', 'pana']);
  });
}

final Pubspec emptyPubspec = new Pubspec({});

final Pubspec flutterPluginPubspec = new Pubspec({
  'flutter': {
    'plugin': {},
  },
});

final Pubspec flutterDependencyPubspec = new Pubspec({
  'dependencies': {
    'flutter': 'any',
  },
});

final Pubspec flutterSdkPubspec = new Pubspec({
  'dependencies': {
    'example': {
      'sdk': 'flutter',
    },
  },
});

final Pubspec flutterSdkDevPubspec = new Pubspec({
  'dev_dependencies': {
    'example': {
      'sdk': 'flutter',
    },
  },
});

final Pubspec unknownSdkPubspec = new Pubspec({
  'dependencies': {
    'example': {
      'sdk': 'unknown',
    },
  },
});

final Pubspec broadDependenciesPubspec = new Pubspec.parseYaml('''
dependencies:
  args: ">=1.2.3 <2.0.0"
  async:
  html: ^5.0.0
  http: "any"
  markdown:
    version:
  mustache:
    version: any
dev_dependencies:
  pana: ">=0.0.0"
''');
