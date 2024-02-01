// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;
import 'dart:io';

import 'package:collection/collection.dart' show UnmodifiableSetView;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:yaml/yaml.dart';

part 'configuration.g.dart';

final _configurationKey = #_active_configuration;

/// Gets the active configuration.
Configuration get activeConfiguration {
  Configuration? config = ss.lookup(_configurationKey) as Configuration?;
  if (config == null) {
    config = Configuration.fromEnv();
    ss.register(_configurationKey, config);
  }
  return config;
}

/// Sets the active configuration.
void registerActiveConfiguration(Configuration configuration) {
  ss.register(_configurationKey, configuration);
}

/// Special value to indicate that the client is running in fake mode.
const _fakeClientAudience = 'fake-client-audience';

/// Special value to indicate that the site is running in fake mode, and the
/// client side authentication should use the fake authentication tokens.
const _fakeSiteAudience = 'fake-site-audience';

/// Special value to indicate that the site is running in fake mode.
const _fakeServerAudience = 'fake-server-audience';

/// Special value to indicate that the external client is running in fake mode.
const _fakeExternalAudience = 'https://pub.dev';

/// Class describing the configuration of running the pub site.
///
/// The configuration define the location of the Datastore with the
/// package metadata and the Cloud Storage bucket for the actual package
/// tar files.
@sealed
@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class Configuration {
  /// The name of the Cloud Storage bucket to use for storing the uploaded
  /// package archives.
  ///
  /// The bucket content policy should be private.
  final String? canonicalPackagesBucketName;

  /// The name of the Cloud Storage bucket to use for public package archive downloads.
  ///
  /// This is the bucket which users are redirected to when they want to download package tarballs.
  /// The bucket content policy should be public.
  final String? publicPackagesBucketName;

  /// The name of the Cloud Storage bucket to use for incoming package archives.
  ///
  /// When users are publishing packages using the `dart pub` client, they are given a signed-url
  /// which allows the client to upload a file. That signed-url points to an object in this bucket.
  /// Once the uploaded tarball have been verified, it can be copied to the canonical bucket.
  /// The bucket content policy should be public.
  final String? incomingPackagesBucketName;

  /// The name of the Cloud Storage bucket to use for uploaded images.
  final String? imageBucketName;

  /// The name of the Cloud Storage bucket to use for generated reports.
  final String? reportsBucketName;

  /// The name of the Cloud Storage bucket to use for exporting JSON API responses.
  final String? exportedApiBucketName;

  /// The Cloud project Id. This is only required when using Apiary to access
  /// Datastore and/or Cloud Storage
  final String projectId;

  /// The scheme://host:port prefix for the search service.
  final String searchServicePrefix;

  /// The scheme://host:port prefix for the search service.
  final String? fallbackSearchServicePrefix;

  /// The `scheme://host:port baseUrl for the default service with same
  /// AppEngine version as this instance.
  ///
  /// Useful, if you wish to call a default service with same `runtimeVersion`
  /// as this instance. Using this URL from services other than _default_ is not
  /// safe, as services may be deployed independently.
  final String defaultServiceBaseUrl;

  /// The name of the Cloud Storage bucket to use for dartdoc generated output.
  final String? dartdocStorageBucketName;

  /// The name of the Cloud Storage bucket to use for popularity data dumps.
  final String? popularityDumpBucketName;

  /// The name of the Cloud Storage bucket to use for search snapshots.
  final String? searchSnapshotBucketName;

  /// Maximum number of concurrent VM instances the task backend is allowed to
  /// created.
  final int maxTaskInstances;

  /// Maximum number of hours a task VM is allowed to run.
  final int maxTaskRunHours;

  /// The name of the Cloud Storage bucket to use for task results.
  final String? taskResultBucketName;

  /// Docker image containing `../pkg/pub_worker` to be used for running
  /// analysis.
  final String? taskWorkerImage;

  /// GCP project within which the `pub_worker` VMs are created.
  final String? taskWorkerProject;

  /// Name of the VPC within which `pub_worker` VMs should be created.
  ///
  /// This VPC should have Cloud Nat enabled.
  final String? taskWorkerNetwork;

  /// Container-Optimized OS image for running analysis tasks.
  ///
  /// See:
  /// https://cloud.google.com/container-optimized-os/docs/concepts/versioning
  final String? cosImage;

  /// Service account to be assigned task VMs.
  ///
  /// This service account need the following roles:
  ///  * Logs Writer (`roles/logging.logWriter`),
  ///  * Storage Object Viewer (`roles/storage.objectViewer`) on the container
  ///    registery buckets.
  ///
  /// The container registery buckets are usually:
  ///  * artifacts.PROJECT-ID.appspot.com
  ///  * STORAGE-REGION.artifacts.PROJECT-ID.appspot.com
  final String? taskWorkerServiceAccount;

  // The scheme://host:port prefix for storage URLs.
  final String? storageBaseUrl;

  /// The OAuth audience (`client_id`) that the `pub` client uses.
  final String? pubClientAudience;

  /// The OAuth audience (`client_id`) that the pub site's JS frontend uses.
  final String? pubSiteAudience;

  /// The OAuth audience that the pub site server backend uses.
  final String? pubServerAudience;

  /// The OAuth audience that external services should use when addressing `pub.dev`.
  /// Examples of such uses:
  /// - admin accounts
  /// - automated publishing clients
  final String? externalServiceAudience;

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
  final String? gmailRelayServiceAccount;

  /// The email of the service account which has access rights to sign upload
  /// requests. The current service must be able to impersonate this account.
  ///
  /// Authorization requires the following IAM permission on the package bucket:
  /// - iam.serviceAccounts.signBlob
  ///
  /// This service account must be "Storage Object Creator" in the following
  /// buckets:
  ///  * [incomingPackagesBucketName]
  ///  * [taskResultBucketName]
  ///
  /// https://cloud.google.com/iam/docs/reference/credentials/rest/v1/projects.serviceAccounts/signBlob
  final String? uploadSignerServiceAccount;

  /// Whether indexing of the content by robots should be blocked.
  final bool blockRobots;

  /// The list of hostnames which are considered production hosts (e.g. which
  /// are not limited in the cache use).
  final List<String>? productionHosts;

  /// The base URI to use for API endpoints.
  /// Also used as PUB_HOSTED_URL in analyzer and dartdoc.
  final Uri? primaryApiUri;

  /// The base URI to use for HTML content.
  final Uri primarySiteUri;

  /// The identifier of admins.
  final List<AdminId>? admins;

  /// The local command-line tools.
  final ToolsConfiguration? tools;

  /// The rate limits for auditable operations.
  final List<RateLimit>? rateLimits;

  /// Load [Configuration] from YAML file at [path] substituting `{{ENV}}` for
  /// the value of environment variable `ENV`.
  factory Configuration.fromYamlFile(final String path) {
    final content = replaceEnvVariables(
        File(path).readAsStringSync(), Platform.environment);
    return Configuration.fromJson(
      json.decode(json.encode(loadYaml(content))) as Map<String, dynamic>,
    );
  }

  @visibleForTesting
  static String replaceEnvVariables(
      String content, Map<String, String> environment) {
    return content.replaceAllMapped(RegExp(r'\{\{([A-Z]+[A-Z0-9_]*)\}\}'),
        (match) {
      final name = match.group(1);
      if (name != null &&
          environment.containsKey(name) &&
          environment[name]!.isNotEmpty) {
        return environment[name]!;
      } else {
        throw ArgumentError(
            'Configuration file requires "$name" environment variable, but it is not present.');
      }
    });
  }

  Configuration({
    required this.canonicalPackagesBucketName,
    required this.publicPackagesBucketName,
    required this.incomingPackagesBucketName,
    required this.projectId,
    required this.imageBucketName,
    required this.reportsBucketName,
    required this.dartdocStorageBucketName,
    required this.popularityDumpBucketName,
    required this.searchSnapshotBucketName,
    required this.exportedApiBucketName,
    required this.maxTaskInstances,
    required this.maxTaskRunHours,
    required this.taskResultBucketName,
    required this.taskWorkerImage,
    required this.taskWorkerProject,
    required this.taskWorkerNetwork,
    required this.cosImage,
    required this.taskWorkerServiceAccount,
    required this.searchServicePrefix,
    required this.fallbackSearchServicePrefix,
    required this.storageBaseUrl,
    required this.pubClientAudience,
    required this.pubSiteAudience,
    required this.pubServerAudience,
    required this.externalServiceAudience,
    required this.gmailRelayServiceAccount,
    required this.uploadSignerServiceAccount,
    required this.blockRobots,
    required this.productionHosts,
    required this.primaryApiUri,
    required this.primarySiteUri,
    required this.admins,
    required this.defaultServiceBaseUrl,
    required this.tools,
    required this.rateLimits,
  });

  /// Load configuration from `app/config/<projectId>.yaml` where `projectId`
  /// is the GCP Project ID (specified using `GOOGLE_CLOUD_PROJECT`).
  factory Configuration.fromEnv() {
    // The GOOGLE_CLOUD_PROJECT is the canonical manner to specify project ID.
    // This is undocumented for appengine custom runtime, but documented for the
    // other runtimes:
    // https://cloud.google.com/appengine/docs/standard/nodejs/runtime
    final projectId = envConfig.googleCloudProject;
    if (projectId == null || projectId.isEmpty) {
      throw StateError(
        'Environment variable \$GOOGLE_CLOUD_PROJECT must be specified!',
      );
    }

    final configFile = envConfig.configPath ??
        path.join(resolveAppDir(), 'config', projectId + '.yaml');
    if (!File(configFile).existsSync()) {
      throw StateError('Could not find configuration file: "$configFile"');
    }
    return Configuration.fromYamlFile(configFile);
  }

  /// Configuration for pkg/fake_pub_server.
  factory Configuration.fakePubServer({
    required int frontendPort,
    required int searchPort,
    required String storageBaseUrl,
  }) {
    return Configuration(
      canonicalPackagesBucketName: 'fake-canonical-packages',
      publicPackagesBucketName: 'fake-public-packages',
      incomingPackagesBucketName: 'fake-incoming-packages',
      projectId: 'dartlang-pub-fake',
      imageBucketName: 'fake-bucket-image',
      reportsBucketName: 'fake-bucket-reports',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      exportedApiBucketName: 'fake-exported-apis',
      maxTaskInstances: 10,
      maxTaskRunHours: 2,
      taskResultBucketName: 'fake-bucket-task-result',
      taskWorkerImage: '-',
      taskWorkerProject: '-',
      taskWorkerNetwork: '-',
      cosImage: 'projects/cos-cloud/global/images/family/cos-stable',
      taskWorkerServiceAccount: '-',
      searchServicePrefix: 'http://localhost:$searchPort',
      fallbackSearchServicePrefix: null,
      storageBaseUrl: storageBaseUrl,
      pubClientAudience: _fakeClientAudience,
      pubSiteAudience: _fakeSiteAudience,
      pubServerAudience: _fakeServerAudience,
      externalServiceAudience: _fakeExternalAudience,
      defaultServiceBaseUrl: 'http://localhost:$frontendPort/',
      gmailRelayServiceAccount: null, // disable email sending
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
      tools: null,
      rateLimits: null,
    );
  }

  /// Configuration for tests.
  factory Configuration.test({
    String? storageBaseUrl,
    Uri? primaryApiUri,
    Uri? primarySiteUri,
  }) {
    return Configuration(
      canonicalPackagesBucketName: 'fake-canonical-packages',
      publicPackagesBucketName: 'fake-public-packages',
      incomingPackagesBucketName: 'fake-incoming-packages',
      projectId: 'dartlang-pub-test',
      imageBucketName: 'fake-bucket-image',
      reportsBucketName: 'fake-bucket-reports',
      dartdocStorageBucketName: 'fake-bucket-dartdoc',
      popularityDumpBucketName: 'fake-bucket-popularity',
      searchSnapshotBucketName: 'fake-bucket-search',
      exportedApiBucketName: 'fake-exported-apis',
      taskResultBucketName: 'fake-bucket-task-result',
      maxTaskInstances: 10,
      maxTaskRunHours: 2,
      taskWorkerImage: '-',
      taskWorkerProject: '-',
      taskWorkerNetwork: '-',
      cosImage: 'projects/cos-cloud/global/images/family/cos-stable',
      taskWorkerServiceAccount: '-',
      searchServicePrefix: 'http://localhost:0',
      fallbackSearchServicePrefix: null,
      storageBaseUrl: storageBaseUrl ?? 'http://localhost:0',
      pubClientAudience: _fakeClientAudience,
      pubSiteAudience: _fakeSiteAudience,
      pubServerAudience: _fakeServerAudience,
      externalServiceAudience: _fakeExternalAudience,
      defaultServiceBaseUrl: primaryApiUri?.toString() ?? 'http://localhost:0/',
      gmailRelayServiceAccount: null, // disable email sending
      uploadSignerServiceAccount: null,
      blockRobots: true,
      productionHosts: ['localhost'],
      primaryApiUri: primaryApiUri ?? Uri.parse('https://pub.dartlang.org/'),
      primarySiteUri: primarySiteUri ?? Uri.parse('https://pub.dev/'),
      admins: [
        AdminId(
          oauthUserId: 'admin-pub-dev',
          email: 'admin@pub.dev',
          permissions: AdminPermission.values,
        ),
      ],
      tools: null,
      rateLimits: null,
    );
  }

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  /// All the bucket names inside this configuration.
  late final allBucketNames = List<String>.unmodifiable(<String>[
    canonicalPackagesBucketName!,
    dartdocStorageBucketName!,
    imageBucketName!,
    reportsBucketName!,
    incomingPackagesBucketName!,
    popularityDumpBucketName!,
    publicPackagesBucketName!,
    searchSnapshotBucketName!,
    taskResultBucketName!,
    if (exportedApiBucketName != null) exportedApiBucketName!,
  ]);

  late final isProduction = projectId == 'dartlang-pub';
  late final isNotProduction = !isProduction;
  late final isStaging = projectId == 'dartlang-pub-dev';

  /// NOTE: email notification on package published is temporarily disabled.
  late final isPublishedEmailNotificationEnabled = isNotProduction;
}

/// Data structure to describe an admin user.
@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class AdminId {
  final String? oauthUserId;
  final String? email;

  /// A set of strings that determine what operations the administrator is
  /// permitted to perform.
  final Set<AdminPermission> permissions;

  AdminId({
    required this.oauthUserId,
    required this.email,
    required Iterable<AdminPermission?> permissions,
  }) : permissions = UnmodifiableSetView(Set.from(permissions));

  factory AdminId.fromJson(Map<String, dynamic> json) =>
      _$AdminIdFromJson(json);
  Map<String, dynamic> toJson() => _$AdminIdToJson(this);
}

/// Permission that can be granted to administrators.
enum AdminPermission {
  /// Permission to execute a tool.
  executeTool,

  /// Permission to invoke admin actions.
  invokeAction,

  /// Permission to list all users.
  listUsers,

  /// Permission to get/set assigned-tags through admin API.
  manageAssignedTags,

  /// Permission to get/set the uploaders of a package.
  managePackageOwnership,

  /// Permission to manage retracted status of a package version.
  manageRetraction,

  /// Permission to remove a package.
  removePackage,

  /// Permission to remove a user account (granted to wipeout).
  removeUsers,
}

/// Configuration related to the local command-line tools (SDKs).
@JsonSerializable(
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class ToolsConfiguration {
  final String? stableDartSdkPath;
  final String? stableFlutterSdkPath;
  final String? previewDartSdkPath;
  final String? previewFlutterSdkPath;

  ToolsConfiguration({
    required this.stableDartSdkPath,
    required this.stableFlutterSdkPath,
    required this.previewDartSdkPath,
    required this.previewFlutterSdkPath,
  });

  factory ToolsConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ToolsConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ToolsConfigurationToJson(this);
}

/// Defines the scope and filtering rules of the rate limit rule.
enum RateLimitScope {
  /// The rate limit rule is applied on the package scope.
  package,

  /// The rate limit rule is applied on the user / service account scope.
  user,
}

/// Defines a rate limit for auditable operations.
@JsonSerializable(
  explicitToJson: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  includeIfNull: false,
)
class RateLimit {
  final String operation;
  final RateLimitScope scope;

  /// Maximum number of operations in a short burst (2 minutes).
  final int? burst;

  /// Maximum number of operations in an hour.
  final int? hourly;

  /// Maximum number of operations in 24 hours.
  final int? daily;

  RateLimit({
    required this.operation,
    required this.scope,
    this.burst,
    this.hourly,
    this.daily,
  });

  factory RateLimit.fromJson(Map<String, dynamic> json) =>
      _$RateLimitFromJson(json);

  Map<String, dynamic> toJson() => _$RateLimitToJson(this);
}
