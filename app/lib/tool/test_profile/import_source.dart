// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';

import '../../fake/backend/fake_pana_runner.dart';
import '../../shared/urls.dart' as urls;

import 'models.dart';
import 'resolver.dart' as resolver;

/// Utility class for resolving and getting data for profiles.
class ImportSource {
  final _client = Client();

  /// Cached archive bytes for generated packages (keys in `<package>/<version>` format).
  final _archives = <String, List<int>>{};

  late final String pubDevArchiveCachePath;

  ImportSource({
    String? pubDevArchiveCachePath,
  }) {
    this.pubDevArchiveCachePath = pubDevArchiveCachePath ??
        p.join('.dart_tool', 'pub-test-profile', 'archives');
  }

  /// Close resources that were opened during the sourcing of data.
  Future<void> close() async {
    _client.close();
  }

  /// Resolve all the package-version required for the [profile].
  Future<List<ResolvedVersion>> resolveImportedVersions(
      TestProfile profile) async {
    return await resolver.resolveVersions(_client, profile);
  }

  Future<List<ResolvedVersion>> resolveGeneratedVersions(
      TestProfile profile) async {
    final versions = <ResolvedVersion>[];
    profile.generatedPackages.forEach((p) {
      final vs = <String>[
        ...?p.versions?.map((v) => v.version),
      ];
      if (vs.isEmpty) {
        final r = Random(p.name.hashCode.abs());
        vs.add('1.${r.nextInt(5)}.${r.nextInt(10)}');
      }
      // consistent published date is calculated in reverse order
      var lastCreated = clock.now().toUtc();
      for (final v in vs.reversed) {
        final r = Random('${p.name}-$v'.hashCode.abs());
        final diff = Duration(
          days: r.nextInt(10),
          hours: r.nextInt(24),
          minutes: 1 + r.nextInt(59),
        );
        final created =
            p.versions?.firstWhereOrNull((x) => x.version == v)?.created ??
                lastCreated.subtract(diff);
        versions.add(ResolvedVersion(
          package: p.name,
          version: v,
          created: created,
        ));
        lastCreated = created;
      }
    });
    return versions;
  }

  Future<List<int>> getPubDevArchiveBytes(
      String package, String version) async {
    final archiveName = '$package-$version.tar.gz';
    final file = File(p.join(pubDevArchiveCachePath, archiveName));
    // download package archive if not already in the cache
    if (!await file.exists()) {
      // TODO: Use archive_url from version-listing, that is stable!
      final rs = await _client.get(Uri.parse(
        '${urls.siteRoot}/packages/$package/versions/$version.tar.gz',
      ));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(rs.bodyBytes);
    }
    return await file.readAsBytes();
  }

  Future<List<int>> getGeneratedArchiveBytes(
      String package, String version) async {
    final key = '$package/$version';
    final hasher = createHasher(key);
    if (_archives.containsKey(key)) {
      return _archives[key]!;
    }
    final archive = ArchiveBuilder();
    final hasHomepage = !version.contains('nohomepage');
    final hasRepository = hasher('hasRepository', max: 20) > 0;
    final isLegacy = version.contains('legacy');

    final sdkConstraint = isLegacy ? '>=1.12.0 <2.0.0' : '^3.0.0';

    final isFlutter = package.startsWith('flutter_');
    final screenshot = TestScreenshot.success();
    final pubspec = json.encode({
      'name': package,
      'version': version,
      'description': '$package is awesome',
      if (hasHomepage) 'homepage': 'https://$package.example.com/',
      if (hasRepository) 'repository': 'https://github.com/example/$package',
      'environment': {
        'sdk': '$sdkConstraint',
      },
      'dependencies': {
        if (isFlutter) 'flutter': {'sdk': 'flutter'},
      },
      'screenshots': [
        {
          'path': '${screenshot.path}',
          'description': '${screenshot.description}'
        }
      ],
      'funding': [
        'https://example.com/funding/$package',
      ],
      'topics': ['chemical-element'],
    });

    archive.addFile('pubspec.yaml', pubspec);
    archive.addFile('README.md', '# $package\n\nAwesome package.');
    archive.addFile('CHANGELOG.md', '## $version\n\n- updated');
    archive.addFile('lib/$package.dart', '''library;

void main() {
  print('Hello.');
}

class MainClass {
  final String text;
  MainClass(this.text);

  /// Converts [text] to lower case.
  String toLowerCase() => text.toLowerCase();

  @override
  String toString() => text;
}

enum TypeEnum { a, b }
''');
    archive.addFile(
        'example/example.dart', 'main() {\n  print(\'example\');\n}\n');
    archive.addFile('LICENSE', 'All rights reserved.');
    archive.addFileBytes('${screenshot.path}', screenshot.data);
    final content = await archive.toTarGzBytes();
    _archives[key] = content;
    return content;
  }
}

@visibleForTesting
class ArchiveBuilder {
  final _entries = <TarEntry>[];

  void addFile(String path, String content) {
    final bytes = utf8.encode(content);
    _entries.add(TarEntry(
      TarHeader(
        name: path,
        size: bytes.length,
        mode: 420, // 644₈
      ),
      Stream<List<int>>.fromIterable([bytes]),
    ));
  }

  void addFileBytes(String path, List<int> bytes) {
    _entries.add(TarEntry(
      TarHeader(
        name: path,
        size: bytes.length,
        mode: 420, // 644₈
      ),
      Stream<List<int>>.fromIterable([bytes]),
    ));
  }

  Future<List<int>> toTarGzBytes() async {
    final stream = Stream<TarEntry>.fromIterable(_entries)
        .transform(tarWriter)
        .transform(gzip.encoder);
    return readByteStream(stream);
  }
}

class TestScreenshot {
  List<int> data;
  String description;
  String path;

  TestScreenshot._(this.path, this.description, this.data);

  factory TestScreenshot.success() {
    final validWebp = '''
UklGRhANAABXRUJQVlA4IAQNAACQiACdASpYAlgCPpFIokwlpKOiIpTYALASCWlu/HyZpveLyux8
ffCn9x/jn4geL39p9L+nx6I/gn0fXjfrp+u/nfuC+wD8GvMH8J+iL2Avxj+Xf6nzNenPamZf/dfQ
C9g/j/6aftv5rGoF3a/S/4AP5l/N/1f/9ftX/EvAp+f/7L2AP4V/pfU4/Vv9V/cfym9i/41/af/b
/k/658gf8l/ov/f/vvtG/oB7pP3A9g39XP+8Dsqa+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+
mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a
+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4
iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviIPpr4iD6a+Ig+mviI
Ppr4iD6a+IdqthkTDfuYSuJ5DA24+yUqZmY+mviIPpr4iD6YDoBl8GUkFzRMXrMHmohMwtkgEJit
08zMfTXxEH018RB6PABkqL0+dc5rPUX8F6RhvpXMx9NfEQfTXxEH0wHMON7CtKjh9OYGzDk+gF+b
DDu5lwDfH/tT6x57DWLZ3xJ+IGVkf+A+alTm2Ig+eUhFrbHEL6VJAbf8Psx9NfEQfTXxDtfCUEM6
Ipk0yPP1NebNs7/tRw9SgElJjZ4s8zH018Q7COzPb8fRiykpsamvgYfVa/GJ27UK0EzH018RB9Nf
AtHfj/NzB7aYzMY+mr8Qvx0Zy3meGQVP+dfhZIiob8WeZj0UPlFN4eDVOs6p9xfExchqa+IdhO+b
epfWN6bEjgV8OY+0nfsKeLPMrVbCI1bJeA+jH2XUQ0e/j3ONIQAlbGfkX018RBaLSElrVYWXwL+b
GBRSDNp+khMwfUyA1BUWW4aVsk6CEu/7HdoG19AQIRT0/FdMEM5yIPpr4iCwkQFYF65o3+mviIPp
r4iCzhplTfsRTzWvVvoTZ5mPnoThD7fTaIBbPfIixN+LPMxZYYvJcHamPnG0zjx/QjBQ5ZCbPMx9
NfEO4mpjL5icGOBUO+Evd9iSMyiIBWHkW4Yy8JkBAmkAcHrnLb0oxB9NfEQfTXxEH018RB9NfEQf
TXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9N
fEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018
RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxE
H018RB9NfEQfTXxEH018RB9NfEQfTXxEH018RB9NfEQfTXxEHoAA/v9umAAAAAAAAAAAAAAAADxp
LmQrpO1HByabmnZc7DNCjtfTgk/J63NBbJFJIuC8mJL4BRiXlNJe0j0byHqdwCiYYLaf2hOZ+jka
0K3n6E6xqPS9Gz4fDhIld99VtmhKb9PEKukmw8J3jaqaetdrvnhaUeSQYgvO2FQhc3Y0zSemHFUE
0rfv+x55WPQHTG6FFCikGi55Xoto5QqDc7/0V/K/pdL5TUJw1tpr9kWo/TXYtfJNi0pph0oEHshM
P5bN+0JzP0cjWhPpy8VpLXB3pOrulIMQBIAeFvHPXPLmxmIluaDUd2cFz2GzXtWSWtRjSAhWNu+S
tex2SL5cLdVM4V+Jl2VIKkoQPID77eoHY0K3AgcQXYzYgp8GJyIizIyL+LFV9XRAyqMDGtRJBe8D
xGcHfDqRZEdTzwtRq7cv89CPki22I1al88k/m3U3hHrtL/qPiFe6b/a/vpzOESSSRaTf2qkPl7gm
tAuytknCtLz7B/st9f4UaD7CnP6Vp48WFa4YOvmhl3LbCRzvpjWZGf9UWX8jnsW4W8mA53uqYLr+
cvubcixbU/Hp8qMaG+Pz41TL7LpxMG8aNv05KdTkP4uxlFO45BvTusmrHx+eJIsP/FHh8zPczoFx
cfqV8AJRLrjv8aY8cTJoSx6GfAxl8BvxFtP6LMc00jx+wh9p+70brjNE6mRV5gB0+JaHlh4K2vZV
GHiicSOSjrzlxpgrbttYBOBIwLw37GFaN0xT7pk42CTcw9nVlnwoloUdr6cEn5PW5oLZIpJFLp81
8LFMDd8hbA1MV72GpBud/6K/lf0ul8pqE4a201+yLUfpqSkxNIFpUOxKcmqiZz5uxs9NcghIqGGh
ejJuu8cmBhQ33Bc6QIfUU5cvpJCYYJw5o6Dw/NAW/MJ79nqpr9sB2bWR6Y6KzfyaGpVIH0PozL5k
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'''
        .replaceAll('\n', '');
    return TestScreenshot._(
      'static.webp',
      'This is an awesome screenshot',
      base64Decode(validWebp),
    );
  }
}
