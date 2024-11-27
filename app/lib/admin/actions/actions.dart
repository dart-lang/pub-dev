// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/exceptions.dart';
import 'download_counts_backfill.dart';
import 'download_counts_delete.dart';
import 'email_send.dart';
import 'exported_api_sync.dart';
import 'merge_moderated_package_into_existing.dart';
import 'moderate_package.dart';
import 'moderate_package_versions.dart';
import 'moderate_publisher.dart';
import 'moderate_user.dart';
import 'moderation_case_create.dart';
import 'moderation_case_delete.dart';
import 'moderation_case_info.dart';
import 'moderation_case_list.dart';
import 'moderation_case_resolve.dart';
import 'moderation_case_update.dart';
import 'moderation_transparency_metrics.dart';
import 'package_discontinue.dart';
import 'package_info.dart';
import 'package_latest_update.dart';
import 'package_reservation_create.dart';
import 'package_reservation_delete.dart';
import 'package_reservation_list.dart';
import 'package_version_info.dart';
import 'package_version_retraction.dart';
import 'publisher_block.dart';
import 'publisher_create.dart';
import 'publisher_delete.dart';
import 'publisher_info.dart';
import 'publisher_members_list.dart';
import 'publisher_package_remove.dart';
import 'task_bump_priority.dart';
import 'tool_execute.dart';
import 'tool_list.dart';
import 'uploader_count_report.dart';
import 'user_info.dart';

export '../../shared/exceptions.dart';

final class AdminAction {
  /// Name of the action is an identifier to be specified when the action is triggered.
  final String name;

  /// Map from option name to description of the option.
  final Map<String, String> options;

  /// A one-liner summary of what this action does.
  final String summary;

  /// A multi-line explanation of what this action does, written in markdown.
  ///
  /// This **must** explain what the action does? What the implications are?
  /// What other actions could be useful to use in conjunction.
  /// What are reasonable expectations around cache-time outs, etc.
  ///
  /// Do write detailed documentation and include examples.
  final String description;

  /// Function to be called to invoke the action.
  ///
  /// This function is passed an `arguments` Map where keys match the keys in
  /// [options].
  /// Returns a JSON response, a failed invocation should throw a
  /// [ResponseException].
  /// Any other exception will be considered an internal error.
  final Future<Map<String, Object?>> Function(
    Map<String, String?> arguments,
  ) invoke;

  AdminAction({
    required this.name,
    required this.summary,
    required this.description,
    this.options = const <String, String>{},
    required this.invoke,
  }) {
    // Check that name works as a command-line argument
    if (!RegExp(r'^[a-z][a-z0-9-]{0,128}$').hasMatch(name)) {
      throw ArgumentError.value(name, 'name');
    }
    // Check that the keys for options works as command-line options
    if (options.keys
        .any((k) => !RegExp(r'^[a-z][a-z0-9-]{0,128}$').hasMatch(k))) {
      throw ArgumentError.value(options, 'options');
    }
  }

  static List<AdminAction> actions = [
    downloadCountsBackfill,
    downloadCountsDelete,
    emailSend,
    exportedApiSync,
    mergeModeratedPackageIntoExisting,
    moderatePackage,
    moderatePackageVersion,
    moderatePublisher,
    moderateUser,
    moderationCaseCreate,
    moderationCaseDelete,
    moderationCaseInfo,
    moderationCaseList,
    moderationCaseResolve,
    moderationCaseUpdate,
    moderationTransparencyMetrics,
    packageDiscontinue,
    packageInfo,
    packageLatestUpdate,
    packageReservationCreate,
    packageReservationDelete,
    packageReservationList,
    packageVersionInfo,
    packageVersionRetraction,
    publisherBlock,
    publisherCreate,
    publisherDelete,
    publisherInfo,
    publisherMembersList,
    publisherPackageRemove,
    taskBumpPriority,
    toolExecute,
    toolList,
    uploaderCountReport,
    userInfo,
  ];
}
