// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Backup critical (user-provided) data from Datastore.

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gcloud/db.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';

part 'datastore.g.dart';

/// Usage:
/// - Create a backup and store it in the current directory:
///   dart bin/tools/datastore.dart backup
/// - Restore the datastore from the latest backup:
///   dart bin/tools/datastore.dart restore
Future main(List<String> arguments) async {
  final runner =
      new CommandRunner('datastore', 'Datastore backup and restore utility.')
        ..addCommand(new BackupCommand())
        ..addCommand(new RestoreCommand());
  await runner.run(arguments);
}

/// Backup user-provided data from Datastore.
class BackupCommand extends Command {
  @override
  String get name => 'backup';

  @override
  String get description => 'Backup user-provided data from Datastore.';

  BackupCommand() {
    argParser.addOption('packages', help: 'The *-packages.jsonl backup file.');
  }

  @override
  Future run() async {
    String packagesFileName = argResults['packages'] as String;
    if (packagesFileName == null) {
      // current timestamp in YYYY-MM-DD-HH-mm-ss
      final ts = new DateTime.now()
          .toUtc()
          .toIso8601String()
          .replaceAll('T', '-')
          .replaceAll(':', '-')
          .split('.')
          .first;
      packagesFileName = '$ts-packages.jsonl';
    }
    final packagesFile = new File(packagesFileName);
    await packagesFile.parent.create(recursive: true);

    await withProdServices(() async {
      print('Backup packages into ${packagesFile.path}...');
      int pkgCounter = 0;
      await for (final p in dbService.query<Package>().run()) {
        pkgCounter++;
        if (pkgCounter == 1 || pkgCounter % 20 == 0) {
          print('Processing #$pkgCounter [${p.name}]...');
        }
        final versions = await dbService
            .query<PackageVersion>(ancestorKey: p.key)
            .run()
            .toList();

        final archiveLine = new ArchiveLine(
          package: _createPackageArchive(p),
          versions: versions
              .map((pv) => new PackageVersionArchive(
                    version: pv.version,
                    created: pv.created,
                    pubspecJson: convert.json.encode(pv.pubspec.asJson),
                    readmeFilename: pv.readmeFilename,
                    readmeContent: pv.readmeContent,
                    changelogFilename: pv.changelogFilename,
                    changelogContent: pv.changelogContent,
                    exampleFilename: pv.exampleFilename,
                    exampleContent: pv.exampleContent,
                    libraries: pv.libraries,
                    downloads: pv.downloads,
                    sortOrder: pv.sortOrder,
                    uploaderEmail: pv.uploaderEmail,
                  ))
              .toList(),
        );

        final line = convert.json.encode(archiveLine.toJson());
        await packagesFile.writeAsString(line + '\n',
            mode: FileMode.writeOnlyAppend);
      }
      print('$pkgCounter packages backed up in $packagesFile');
    });
  }
}

PackageArchive _createPackageArchive(Package p) {
  return new PackageArchive(
    name: p.name,
    created: p.created,
    updated: p.updated,
    downloads: p.downloads,
    latestVersion: p.latestVersion,
    latestDevVersion: p.latestDevVersion,
    uploaderEmails: p.uploaderEmails,
    isDiscontinued: p.isDiscontinued,
    doNotAdvertise: p.doNotAdvertise,
  );
}

bool _shouldUpdate(Package p, PackageArchive archive) {
  if (p == null) return true;
  final pa = _createPackageArchive(p);
  return convert.json.encode(pa) != convert.json.encode(archive);
}

/// 'Restores user-provided data from backup.'
class RestoreCommand extends Command {
  @override
  String get name => 'restore';

  @override
  String get description => 'Restores user-provided data from backup.';

  RestoreCommand() {
    argParser.addOption('packages', help: 'The *-packages.jsonl backup file.');
  }

  @override
  Future run() async {
    if (activeConfiguration.projectId != 'dartlang-pub-dev') {
      print('\nPROJECT_ID is not dartlang-pub-dev, exiting.\n');
      exit(1);
    }

    final packagesFile = new File(argResults['packages'] as String);
    if (!packagesFile.existsSync()) {
      print('Packages file $packagesFile does not exists.');
      exit(1);
    }

    await withProdServices(() async {
      print('Restoring packages from: $packagesFile');
      final stream = packagesFile
          .openRead()
          .transform(convert.utf8.decoder)
          .transform(new convert.LineSplitter())
          .map(convert.json.decode)
          .cast<Map<String, dynamic>>();
      int pkgCounter = 0;
      int pkgUpdateCount = 0;
      int pkgVersionUpdateCount = 0;
      await for (final data in stream) {
        final archiveLine = new ArchiveLine.fromJson(data);
        final pkgArchive = archiveLine.package;
        final packageName = pkgArchive.name;
        final pkgKey = dbService.emptyKey.append(Package, id: packageName);
        final latestVersionKey =
            pkgKey.append(PackageVersion, id: pkgArchive.latestVersion);
        final latestDevVersionKey = pkgArchive.latestDevVersion == null
            ? null
            : pkgKey.append(PackageVersion, id: pkgArchive.latestDevVersion);

        pkgCounter++;
        if (pkgCounter == 1 || pkgCounter % 10 == 0) {
          print('Processing #$pkgCounter [$packageName]...');
        }

        final p = (await dbService.lookup([pkgKey])).single as Package;
        if (_shouldUpdate(p, pkgArchive)) {
          await dbService.withTransaction((tx) async {
            var p = (await tx.lookup([pkgKey])).single as Package;
            p ??= new Package();
            p
              ..id = pkgArchive.name
              ..name = pkgArchive.name
              ..created = pkgArchive.created
              ..updated = pkgArchive.updated
              ..downloads = pkgArchive.downloads
              ..latestVersionKey = latestVersionKey
              ..latestDevVersionKey = latestDevVersionKey
              ..uploaderEmails = pkgArchive.uploaderEmails
              ..isDiscontinued = pkgArchive.isDiscontinued
              ..doNotAdvertise = pkgArchive.doNotAdvertise;
            pkgUpdateCount++;
            tx.queueMutations(inserts: [p]);
            await tx.commit();
          });
        }

        Future update(int batchSize) async {
          for (int s = 0; s < archiveLine.versions.length; s += batchSize) {
            final batch = archiveLine.versions.skip(s).take(batchSize).toList();
            final batchKeys = batch
                .map((pv) => pkgKey.append(PackageVersion, id: pv.version))
                .toList();
            final existingPvs = await dbService.lookup(batchKeys);
            if (existingPvs.every((m) => m != null)) continue;

            final newPvs = <PackageVersion>[];
            for (int i = 0; i < batch.length; i++) {
              final versionArchive = batch[i];
              final packageVersion = versionArchive.version;
              if (existingPvs[i] == null) {
                final pv = new PackageVersion()
                  ..parentKey = pkgKey
                  ..packageKey = pkgKey
                  ..id = packageVersion
                  ..version = packageVersion
                  ..created = versionArchive.created
                  ..pubspec = new Pubspec(versionArchive.pubspecJson)
                  ..readmeFilename = versionArchive.readmeFilename
                  ..readmeContent = versionArchive.readmeContent
                  ..changelogFilename = versionArchive.changelogFilename
                  ..changelogContent = versionArchive.changelogContent
                  ..exampleFilename = versionArchive.exampleFilename
                  ..exampleContent = versionArchive.exampleContent
                  ..libraries = versionArchive.libraries
                  ..downloads = versionArchive.downloads
                  ..sortOrder = versionArchive.sortOrder
                  ..uploaderEmail = versionArchive.uploaderEmail;
                newPvs.add(pv);
              }
            }
            await dbService.commit(inserts: newPvs);
            pkgVersionUpdateCount += newPvs.length;
          }
        }

        try {
          await update(20);
          continue;
        } catch (e) {
          print('Error while updating $packageName: $e');
          print('Retrying...');
        }
        await update(1);
      }
      print('$pkgCounter packages processed from ${packagesFile.path}');
      print('Restored:\n'
          '  $pkgUpdateCount packages\n'
          '  $pkgVersionUpdateCount versions.');
    });
  }
}

@JsonSerializable()
class ArchiveLine {
  final PackageArchive package;
  final List<PackageVersionArchive> versions;

  ArchiveLine({
    @required this.package,
    @required this.versions,
  });

  factory ArchiveLine.fromJson(Map<String, dynamic> json) =>
      _$ArchiveLineFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveLineToJson(this);
}

// NOTE: Keep in sync with PackageVersion.
@JsonSerializable()
class PackageArchive {
  final String name;
  final DateTime created;
  final DateTime updated;
  final int downloads;
  final String latestVersion;
  final String latestDevVersion;
  final List<String> uploaderEmails;
  final bool isDiscontinued;
  final bool doNotAdvertise;

  PackageArchive({
    @required this.name,
    @required this.created,
    @required this.updated,
    @required this.downloads,
    @required this.latestVersion,
    @required this.latestDevVersion,
    @required this.uploaderEmails,
    @required this.isDiscontinued,
    @required this.doNotAdvertise,
  });

  factory PackageArchive.fromJson(Map<String, dynamic> json) =>
      _$PackageArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$PackageArchiveToJson(this);
}

// NOTE: Keep in sync with PackageVersion.
@JsonSerializable()
class PackageVersionArchive {
  final String version;
  final DateTime created;
  final String pubspecJson;
  final String readmeFilename;
  final String readmeContent;
  final String changelogFilename;
  final String changelogContent;
  final String exampleFilename;
  final String exampleContent;
  final List<String> libraries;
  final int downloads;
  final int sortOrder;
  final String uploaderEmail;

  PackageVersionArchive({
    @required this.version,
    @required this.created,
    @required this.pubspecJson,
    @required this.readmeFilename,
    @required this.readmeContent,
    @required this.changelogFilename,
    @required this.changelogContent,
    @required this.exampleFilename,
    @required this.exampleContent,
    @required this.libraries,
    @required this.downloads,
    @required this.sortOrder,
    @required this.uploaderEmail,
  });

  factory PackageVersionArchive.fromJson(Map<String, dynamic> json) =>
      _$PackageVersionArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$PackageVersionArchiveToJson(this);
}
