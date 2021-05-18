// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;
import 'dart:io';

import 'package:collection/collection.dart' show UnmodifiableSetView;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

part 'configuration.g.dart';

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

/// Special value to indicate that the site is running in fake mode, and the
/// client side authentication should use the fake authentication tokens.
const _fakeSiteAudience = 'fake-site-audience';

/// Class describing the configuration of running the pub site.
///
/// The configuration define the location of the Datastore with the
/// package metadata and the Cloud Storage bucket for the actual package
/// tar files.
@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
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

  /// Email of the service account which has domain-wide delegation for the
  /// GSuite account used to send emails.
  ///
  /// The [gmailRelayServiceAccount] has the following requirements:
  ///
  ///  1. The _service account_ running the server (typically appengine), must
  ///     have the `roles/iam.serviceAccountTokenCreator` role on the
  ///     [gmailRelayServiceAccount], allowing the server to create tokens
  ///     impersonating [gmailRelayServiceAccount].
  ///  2. The [gmailRelayServiceAccount] must be visible for
  ///     _domain-wide delegation_ in the Google Cloud Console.
  ///  3. The [gmailRelayServiceAccount] must be granted the scope:
  ///     `https://mail.google.com/` on the GSuite used for sending emails.
  ///
  ///  For (2) and (3) see:
  ///  https://developers.google.com/identity/protocols/oauth2/service-account
  ///
  /// **Optional**, if omitted email sending is disabled.
  final String gmailRelayServiceAccount;

  /// Email of the GSuite user account to impersonate when sending emails
  /// through the gmail SMTP relay.
  ///
  /// This must be the email for an account within the GSuite used for sending
  /// emails. It is important that the gmail SMTP relay is enabled for this
  /// GSuite, for configuration see:
  /// https://support.google.com/a/answer/176600?hl=en
  ///
  /// **Optional**, if omitted email sending is disabled.
  final String gmailRelayImpersonatedGSuiteUser;

  /// The email of the service account which has access rights to sign upload
  /// requests. The current service must be able to impersonate this account.
  ///
  /// Authorization requires the following IAM permission on the package bucket:
  /// - iam.serviceAccounts.signBlob
  ///
  /// https://cloud.google.com/iam/docs/reference/credentials/rest/v1/projects.serviceAccounts/signBlob
  final String uploadSignerServiceAccount;

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

  factory Configuration.fromYamlFile(final String path) {
    final file = File(path);
    final content = file.readAsStringSync();
    final map =
        json.decode(json.encode(loadYaml(content))) as Map<String, dynamic>;
    return Configuration.fromJson(map);
  }

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub-packages'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  @visibleForTesting
  factory Configuration.prod() {
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
      gmailRelayServiceAccount:
          'pub-gsuite-gmail-delegatee@dartlang-pub.iam.gserviceaccount.com',
      gmailRelayImpersonatedGSuiteUser: 'noreply@pub.dev',
      uploadSignerServiceAccount:
          'package-uploader-signer@dartlang-pub.iam.gserviceaccount.com',
      blockRobots: false,
      productionHosts: const ['pub.dartlang.org', 'pub.dev', 'api.pub.dev'],
      primaryApiUri: Uri.parse('https://pub.dartlang.org/'),
      primarySiteUri: Uri.parse('https://pub.dev/'),
      admins: [
        AdminId(
          email: 'assigned-tags-admin@dartlang-pub.iam.gserviceaccount.com',
          oauthUserId: '106306194842560376600',
          permissions: {AdminPermission.manageAssignedTags},
        ),
        AdminId(
          email: 'pub-admin-service@dartlang-pub.iam.gserviceaccount.com',
          oauthUserId: '114536496314409930448',
          permissions: {AdminPermission.listUsers, AdminPermission.removeUsers},
        ),
        AdminId(
          email: 'pub-moderation-admin@dartlang-pub.iam.gserviceaccount.com',
          oauthUserId: '108693445730271975989',
          permissions: {AdminPermission.removePackage},
        )
      ],
    );
  }

  /// Create a configuration for development/staging deployment.
  @visibleForTesting
  factory Configuration.staging() {
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
      gmailRelayServiceAccount: null, // disable email sending
      gmailRelayImpersonatedGSuiteUser: null, // disable email sending
      uploadSignerServiceAccount:
          'package-uploader-signer@dartlang-pub-dev.iam.gserviceaccount.com',
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
          permissions: AdminPermission.values,
        ),
        AdminId(
          oauthUserId: '117672289743137340098',
          email: 'assigned-tags-admin@dartlang-pub-dev.iam.gserviceaccount.com',
          permissions: {AdminPermission.manageAssignedTags},
        )
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
    @required this.gmailRelayServiceAccount,
    @required this.gmailRelayImpersonatedGSuiteUser,
    @required this.uploadSignerServiceAccount,
    @required this.blockRobots,
    @required this.productionHosts,
    @required this.primaryApiUri,
    @required this.primarySiteUri,
    @required this.admins,
  });

  /// Create a configuration based on the environment variables.
  factory Configuration.fromEnv(EnvConfig env) {
    if (env.gcloudProject == 'dartlang-pub') {
      return Configuration.prod();
    } else if (env.gcloudProject == 'dartlang-pub-dev') {
      return Configuration.staging();
    } else if (env.configPath?.isEmpty ?? true) {
      throw Exception(
          'Unknown project id: ${env.gcloudProject}. Please setup env var GCLOUD_PROJECT or PUB_SERVER_CONFIG');
    } else if (File(env.configPath).existsSync()) {
      return Configuration.fromYamlFile(env.configPath);
    } else {
      throw Exception(
          'File ${env.configPath} doesnt exist. Please ensure PUB_SERVER_CONFIG env is pointing to the existing config');
    }
  }

  /// Configuration for pkg/fake_pub_server.
  factory Configuration.fakePubServer({
    @required int frontendPort,
    @required int searchPort,
    @required String storageBaseUrl,
  }) {
    return Configuration(
      projectId: 'dartlang-pub-fake',
      packageBucketName: 'fake-bucket-pub',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      backupSnapshotBucketName: 'fake-bucket-backup',
      searchServicePrefix: 'http://localhost:$searchPort',
      storageBaseUrl: storageBaseUrl,
      pubClientAudience: null,
      pubSiteAudience: _fakeSiteAudience,
      adminAudience: null,
      gmailRelayServiceAccount: null, // disable email sending
      gmailRelayImpersonatedGSuiteUser: null, // disable email sending
      uploadSignerServiceAccount: null,
      blockRobots: false,
      productionHosts: ['localhost'],
      primaryApiUri: Uri.parse('http://localhost:$frontendPort/'),
      primarySiteUri: Uri.parse('http://localhost:$frontendPort/'),
      admins: [
        AdminId(
          oauthUserId: 'admin-pub-dev',
          email: 'admin@pub.dev',
          permissions: AdminPermission.values,
        ),
      ],
    );
  }

  /// Configuration for tests.
  factory Configuration.test({String storageBaseUrl}) {
    return Configuration(
      projectId: 'dartlang-pub-test',
      packageBucketName: 'fake-bucket-pub',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      backupSnapshotBucketName: 'fake-bucket-backup',
      searchServicePrefix: 'http://localhost:0',
      storageBaseUrl: storageBaseUrl ?? 'http://localhost:0',
      pubClientAudience: null,
      pubSiteAudience: null,
      adminAudience: null,
      gmailRelayServiceAccount: null, // disable email sending
      gmailRelayImpersonatedGSuiteUser: null, // disable email sending
      uploadSignerServiceAccount: null,
      blockRobots: true,
      productionHosts: ['localhost'],
      primaryApiUri: Uri.parse('https://pub.dartlang.org/'),
      primarySiteUri: Uri.parse('https://pub.dev/'),
      admins: [
        AdminId(
          oauthUserId: 'admin-pub-dev',
          email: 'admin@pub.dev',
          permissions: AdminPermission.values,
        ),
      ],
    );
  }

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
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

  /// Instance of this service in AppEngine, `null` if running locally.
  ///
  /// NOTE: use only for narrow debug flows.
  final String gaeInstance;
  final String gcloudKey;
  final String gcloudProject;
  final String stableDartSdkDir;
  final String stableFlutterSdkDir;
  final String previewDartSdkDir;
  final String previewFlutterSdkDir;
  final int frontendCount;
  final int workerCount;

  // Config Path points to configuratio file
  final String configPath;

  EnvConfig._(
    this.gaeService,
    this.gaeVersion,
    this.gaeInstance,
    this.gcloudProject,
    this.gcloudKey,
    this.stableDartSdkDir,
    this.stableFlutterSdkDir,
    this.previewDartSdkDir,
    this.previewFlutterSdkDir,
    this.frontendCount,
    this.workerCount,
    this.configPath,
  );

  factory EnvConfig._detect() {
    final frontendCount =
        int.tryParse(Platform.environment['FRONTEND_COUNT'] ?? '1') ?? 1;
    final workerCount =
        int.tryParse(Platform.environment['WORKER_COUNT'] ?? '1') ?? 1;
    return EnvConfig._(
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GAE_VERSION'],
      Platform.environment['GAE_INSTANCE'],
      Platform.environment['GCLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['TOOL_STABLE_DART_SDK'],
      Platform.environment['TOOL_STABLE_FLUTTER_SDK'],
      Platform.environment['TOOL_PREVIEW_DART_SDK'],
      Platform.environment['TOOL_PREVIEW_FLUTTER_SDK'],
      frontendCount,
      workerCount,
      Platform.environment['PUB_SERVER_CONFIG'],
    );
  }

  /// True, if running locally and not inside AppEngine.
  bool get isRunningLocally => gaeService == null || gaeVersion == null;
}

/// Configuration from the environment variables.
final EnvConfig envConfig = EnvConfig._detect();

/// Data structure to describe an admin user.
@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class AdminId {
  final String oauthUserId;
  final String email;

  /// A set of strings that determine what operations the administrator is
  /// permitted to perform.
  final Set<AdminPermission> permissions;

  AdminId({
    @required this.oauthUserId,
    @required this.email,
    @required Iterable<AdminPermission> permissions,
  }) : permissions = UnmodifiableSetView(Set.from(permissions));

  factory AdminId.fromJson(Map<String, dynamic> json) =>
      _$AdminIdFromJson(json);
  Map<String, dynamic> toJson() => _$AdminIdToJson(this);
}

/// Permission that can be granted to administrators.
enum AdminPermission {
  /// Permission to list all users.
  listUsers,

  /// Permission to remove a user account (granted to wipeout).
  removeUsers,

  /// Permission to get/set assigned-tags through admin API.
  manageAssignedTags,

  /// Permission to remove a package.
  removePackage,
}
