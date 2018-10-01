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
import 'package:pool/pool.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';

part 'datastore.g.dart';

/// Usage:
/// - Create a backup and store it in the current directory:
///   dart bin/tools/datastore.dart backup
/// - Update the datastore from the latest backup:
///   dart bin/tools/datastore.dart update
Future main(List<String> arguments) async {
  final runner =
      new CommandRunner('datastore', 'Datastore backup and restore utility.')
        ..addCommand(new BackupCommand())
        ..addCommand(new UpdateCommand());
  await runner.run(arguments);
}

/// Backup user-provided data from Datastore.
class BackupCommand extends Command {
  @override
  String get name => 'backup';

  @override
  String get description => 'Backup user-provided data from Datastore.';

  BackupCommand() {
    argParser.addOption('backup-directory', help: 'The backup directory.');
  }

  @override
  Future run() async {
    final backupDir = argResults['backup-directory'] == null
        ? Directory.current
        : new Directory(argResults['backup-directory'] as String);
    await backupDir.create(recursive: true);
    // current timestamp in YYYYMMDD-HHmmss
    final ts = new DateTime.now()
        .toUtc()
        .toIso8601String()
        .replaceAll('-', '')
        .replaceAll('T', '-')
        .replaceAll(':', '')
        .split('.')
        .first;
    // output files
    final packagesFile = new File('${backupDir.path}/$ts-packages.jsonl');

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
          package: new PackageArchive(
            name: p.name,
            created: p.created,
            updated: p.updated,
            downloads: p.downloads,
            latestVersion: p.latestVersion,
            latestDevVersion: p.latestDevVersion,
            uploaderEmails: p.uploaderEmails,
            isDiscontinued: p.isDiscontinued,
            doNotAdvertise: p.doNotAdvertise,
          ),
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
      print('$pkgCounter packages backed up in ${packagesFile.path}');
    });
  }
}

/// 'Updates user-provided data from backup.'
class UpdateCommand extends Command {
  @override
  String get name => 'update';

  @override
  String get description => 'Updates user-provided data from backup.';

  UpdateCommand() {
    argParser.addOption('backup-directory', help: 'The backup directory.');
  }

  @override
  Future run() async {
    if (activeConfiguration.projectId != 'dartlang-pub-dev') {
      print('\nPROJECT_ID is not dartlang-pub-dev, exiting.\n');
      exit(-1);
    }

    final backupDir = argResults['backup-directory'] == null
        ? Directory.current
        : new Directory(argResults['backup-directory'] as String);
    // input files
    final backupPrefix = await _detectLatest(backupDir);
    print('\nFound backup prefix: $backupPrefix\n'
        'Waiting for 5 seconds before proceeding.\n');
    await new Future.delayed(const Duration(seconds: 5));
    final packagesFile = new File('$backupPrefix-packages.jsonl');

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

        await dbService.withTransaction((tx) async {
          Package p = (await tx.lookup([pkgKey])).single;
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

        final pool = new Pool(4);
        final futures = <Future>[];
        for (final versionArchive in archiveLine.versions) {
          final packageVersion = versionArchive.version;
          final versionKey = pkgKey.append(PackageVersion, id: packageVersion);
          Future updateVersion() async {
            await dbService.withTransaction((tx) async {
              PackageVersion pv = (await tx.lookup([versionKey])).single;
              if (pv == null) {
                pv = new PackageVersion()
                  ..parentKey = pkgKey
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
                pkgVersionUpdateCount++;
                tx.queueMutations(inserts: [pv]);
                await tx.commit();
              } else {
                await tx.rollback();
              }
            });
          }

          pool.withResource(updateVersion);
        }
        await Future.wait(futures);
        await pool.close();
      }
      print('$pkgCounter packages processed from ${packagesFile.path}');
      print('Updated:\n'
          '  $pkgUpdateCount packages\n'
          '  $pkgVersionUpdateCount versions.');
    });
  }

  Future<String> _detectLatest(Directory backupDir) async {
    final suffix = '-packages.jsonl';
    final list = await backupDir
        .list()
        .where((fse) => fse is File && fse.path.endsWith(suffix))
        .map((f) => f.path.substring(0, f.path.length - suffix.length))
        .toList();
    list.sort();
    return list.last;
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
