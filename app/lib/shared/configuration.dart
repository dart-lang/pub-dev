// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth.dart' as auth;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

final _logger = Logger('configuration');

final _configurationKey = #_active_configuration;

/// Gets the active configuration.
Configuration get activeConfiguration {
  Configuration config = ss.lookup(_configurationKey) as Configuration;
  if (config == null) {
    config = Configuration.fromEnv(envConfig);
    ss.register(_configurationKey, config);
  }
  return config;
}

/// Sets the active configuration.
void registerActiveConfiguration(Configuration configuration) {
  ss.register(_configurationKey, configuration);
}

/// The OAuth audience (`client_id`) that the `pub` client uses.
const _pubClientAudience =
    '818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.googleusercontent.com';

/// Class describing the configuration of running the pub site.
///
/// The configuration define the location of the Datastore with the
/// package metadata and the Cloud Storage bucket for the actual package
/// tar files.
class Configuration {
  /// The name of the Cloud Storage bucket to use for uploaded package content.
  final String packageBucketName;

  /// The Cloud project Id. This is only required when using Apiary to access
  /// Datastore and/or Cloud Storage
  final String projectId;

  /// The scheme://host:port prefix for the search service.
  final String searchServicePrefix;

  /// The name of the Cloud Storage bucket to use for dartdoc generated output.
  final String dartdocStorageBucketName;

  /// The name of the Cloud Storage bucket to use for popularity data dumps.
  final String popularityDumpBucketName;

  /// The name of the Cloud Storage bucket to use for search snapshots.
  final String searchSnapshotBucketName;

  /// The name of the Cloud Storage bucket to use for datastore backup snapshots.
  final String backupSnapshotBucketName;

  // The scheme://host:port prefix for storage URLs.
  final String storageBaseUrl;

  /// The OAuth audience (`client_id`) that the `pub` client uses.
  final String pubClientAudience;

  /// The OAuth audience (`client_id`) that the pub site uses.
  final String pubSiteAudience;

  /// The OAuth audience (`client_id`) that admin accounts use.
  final String adminAudience;

  /// Credentials to use for API calls if not reading the credentials from
  /// the Datastore.
  final auth.ServiceAccountCredentials credentials;

  /// Whether the email sender should send out e-mails even if credentials are
  /// provided.
  final bool blockEmails;

  /// Whether indexing of the content by robots should be blocked.
  final bool blockRobots;

  /// The list of hostnames which are considered production hosts (e.g. which
  /// are not limited in the cache use).
  final List<String> productionHosts;

  /// The base URI to use for API endpoints.
  /// Also used as PUB_HOSTED_URL in analyzer and dartdoc.
  final Uri primaryApiUri;

  /// The base URI to use for HTML content.
  final Uri primarySiteUri;

  /// The identifier of admins.
  final List<AdminId> admins;

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub-packages'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  factory Configuration._prod() {
    final projectId = 'dartlang-pub';
    return Configuration(
      projectId: projectId,
      packageBucketName: 'pub-packages',
      dartdocStorageBucketName: '$projectId--dartdoc-storage',
      popularityDumpBucketName: '$projectId--popularity',
      searchSnapshotBucketName: '$projectId--search-snapshot',
      backupSnapshotBucketName: '$projectId--backup-snapshots',
      searchServicePrefix: 'https://search-dot-$projectId.appspot.com',
      storageBaseUrl: 'https://storage.googleapis.com/',
      pubClientAudience: _pubClientAudience,
      pubSiteAudience:
          '818368855108-e8skaopm5ih5nbb82vhh66k7ft5o7dn3.apps.googleusercontent.com',
      adminAudience: 'https://pub.dev',
      credentials: _loadCredentials(),
      blockEmails: false,
      blockRobots: false,
      productionHosts: const ['pub.dartlang.org', 'pub.dev', 'api.pub.dev'],
      primaryApiUri: Uri.parse('https://pub.dartlang.org/'),
      primarySiteUri: Uri.parse('https://pub.dev/'),
      admins: [],
    );
  }

  /// Create a configuration for development/staging deployment.
  factory Configuration._dev() {
    final projectId = 'dartlang-pub-dev';
    return Configuration(
      projectId: projectId,
      packageBucketName: '$projectId--pub-packages',
      dartdocStorageBucketName: '$projectId--dartdoc-storage',
      popularityDumpBucketName: '$projectId--popularity',
      searchSnapshotBucketName: '$projectId--search-snapshot',
      backupSnapshotBucketName: '$projectId--backup-snapshots',
      // TODO: Support finding search on localhost when envConfig.isRunningLocally
      //       is true, this also requires running search on localhost.
      searchServicePrefix: 'https://search-dot-$projectId.appspot.com',
      storageBaseUrl: 'https://storage.googleapis.com/',
      pubClientAudience: _pubClientAudience,
      pubSiteAudience:
          '621485135717-idb8t8nnguphtu2drfn2u4ig7r56rm6n.apps.googleusercontent.com',
      adminAudience: 'https://pub.dev',
      credentials: _loadCredentials(),
      blockEmails: true,
      blockRobots: true,
      productionHosts: envConfig.isRunningLocally
          ? ['localhost']
          : [
              'dartlang-pub-dev.appspot.com',
              '${envConfig.gaeService}-dot-dartlang-pub-dev.appspot.com',
            ],
      primaryApiUri: Uri.parse('https://dartlang-pub-dev.appspot.com'),
      primarySiteUri: envConfig.isRunningLocally
          ? Uri.parse('http://localhost:8080')
          : Uri.parse(
              'https://${envConfig.gaeVersion}-dot-dartlang-pub-dev.appspot.com',
            ),
      admins: [
        AdminId(
          oauthUserId: '111042304059633250784',
          email: 'istvan.soos@gmail.com',
        ), // isoos
      ],
    );
  }

  Configuration({
    @required this.projectId,
    @required this.packageBucketName,
    @required this.dartdocStorageBucketName,
    @required this.popularityDumpBucketName,
    @required this.searchSnapshotBucketName,
    @required this.backupSnapshotBucketName,
    @required this.searchServicePrefix,
    @required this.storageBaseUrl,
    @required this.pubClientAudience,
    @required this.pubSiteAudience,
    @required this.adminAudience,
    @required this.credentials,
    @required this.blockEmails,
    @required this.blockRobots,
    @required this.productionHosts,
    @required this.primaryApiUri,
    @required this.primarySiteUri,
    @required this.admins,
  });

  /// Create a configuration based on the environment variables.
  factory Configuration.fromEnv(EnvConfig env) {
    if (env.gcloudProject == 'dartlang-pub') {
      return Configuration._prod();
    } else if (env.gcloudProject == 'dartlang-pub-dev') {
      return Configuration._dev();
    } else {
      throw Exception('Unknown project id: ${env.gcloudProject}');
    }
  }

  /// Configuration for pkg/fake_pub_server.
  factory Configuration.fakePubServer({
    @required int port,
    @required String storageBaseUrl,
  }) {
    return Configuration(
      projectId: 'dartlang-pub-fake',
      packageBucketName: 'fake-bucket-pub',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      backupSnapshotBucketName: 'fake-bucket-backup',
      searchServicePrefix: 'http://localhost:$port',
      storageBaseUrl: storageBaseUrl,
      pubClientAudience: null,
      pubSiteAudience: null,
      adminAudience: null,
      credentials: null,
      blockEmails: true,
      blockRobots: true,
      productionHosts: ['localhost'],
      primaryApiUri: Uri.parse('http://localhost:$port/'),
      primarySiteUri: Uri.parse('http://localhost:$port/'),
      admins: [AdminId(oauthUserId: 'admin-pub-dev', email: 'admin@pub.dev')],
    );
  }

  /// Configuration for tests.
  factory Configuration.test() {
    return Configuration(
      projectId: 'dartlang-pub-test',
      packageBucketName: 'fake-bucket-pub',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      backupSnapshotBucketName: 'fake-bucket-backup',
      searchServicePrefix: 'http://localhost:0',
      storageBaseUrl: 'http://localhost:0',
      pubClientAudience: null,
      pubSiteAudience: null,
      adminAudience: null,
      credentials: null,
      blockEmails: true,
      blockRobots: true,
      productionHosts: ['localhost'],
      primaryApiUri: Uri.parse('https://pub.dartlang.org/'),
      primarySiteUri: Uri.parse('https://pub.dev/'),
      admins: [AdminId(oauthUserId: 'admin-pub-dev', email: 'admin@pub.dev')],
    );
  }
}

/// Configuration from the environment variables.
class EnvConfig {
  /// Service in AppEngine that this process is running in, `null` if running
  /// locally.
  final String gaeService;

  /// Version of this service in AppEngine, `null` if running locally.
  ///
  /// Can be used to construct URLs for the given service.
  final String gaeVersion;
  final String gcloudKey;
  final String gcloudProject;
  final String toolEnvDartSdkDir;
  final String flutterSdkDir;
  final int frontendCount;
  final int workerCount;

  EnvConfig._(
    this.gaeService,
    this.gaeVersion,
    this.gcloudProject,
    this.gcloudKey,
    this.toolEnvDartSdkDir,
    this.flutterSdkDir,
    this.frontendCount,
    this.workerCount,
  ) {
    if (this.gcloudProject == null) {
      throw Exception('GCLOUD_PROJECT needs to be set!');
    }
  }

  factory EnvConfig._detect() {
    final frontendCount =
        int.tryParse(Platform.environment['FRONTEND_COUNT'] ?? '1') ?? 1;
    final workerCount =
        int.tryParse(Platform.environment['WORKER_COUNT'] ?? '1') ?? 1;
    return EnvConfig._(
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GAE_VERSION'],
      Platform.environment['GCLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['TOOL_ENV_DART_SDK'],
      Platform.environment['FLUTTER_SDK'],
      frontendCount,
      workerCount,
    );
  }

  /// True, if running locally and not inside AppEngine.
  bool get isRunningLocally => gaeService == null || gaeVersion == null;
  bool get hasCredentials => gcloudProject != null && gcloudKey != null;
}

/// Configuration from the environment variables.
final EnvConfig envConfig = EnvConfig._detect();

auth.ServiceAccountCredentials _loadCredentials() {
  if (envConfig.hasCredentials) {
    final path = envConfig.gcloudKey;
    final content = File(path).readAsStringSync();
    return auth.ServiceAccountCredentials.fromJson(content);
  } else {
    _logger.info(
        'Missing GCLOUD_PROJECT and/or GCLOUD_KEY, service account credentials are not loaded.');
    return null;
  }
}

/// Data structure to describe an admin user.
class AdminId {
  final String oauthUserId;
  final String email;

  AdminId({
    @required this.oauthUserId,
    @required this.email,
  });
}
