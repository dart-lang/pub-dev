// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/backfill_download_counts.dart';
import 'package:pub_dev/admin/actions/delete_download_counts.dart';

import '../../shared/exceptions.dart';
import 'create_moderation_case.dart';
import 'create_publisher.dart';
import 'delete_moderation_case.dart';
import 'delete_publisher.dart';
import 'list_moderation_cases.dart';
import 'merge_moderated_package_into_existing.dart';
import 'moderate_package.dart';
import 'moderate_package_versions.dart';
import 'moderate_publisher.dart';
import 'moderate_user.dart';
import 'moderation_case_info.dart';
import 'package_version_retraction.dart';
import 'publisher_block.dart';
import 'publisher_members_list.dart';
import 'remove_package_from_publisher.dart';
import 'resolve_moderation_case.dart';
import 'send_email.dart';
import 'task_bump_priority.dart';
import 'tool_execute.dart';
import 'tool_list.dart';
import 'update_moderation_case.dart';
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
    backfillDownloadCounts,
    createModerationCase,
    createPublisher,
    deleteModerationCase,
    deletePublisher,
    deleteDownloadCounts,
    listModerationCases,
    mergeModeratedPackageIntoExisting,
    moderatePackage,
    moderatePackageVersion,
    moderatePublisher,
    moderateUser,
    moderationCaseInfo,
    packageVersionRetraction,
    publisherBlock,
    publisherMembersList,
    removePackageFromPublisher,
    resolveModerationCase,
    sendEmail,
    taskBumpPriority,
    toolExecute,
    toolList,
    updateModerationCase,
    uploaderCountReport,
    userInfo,
  ];
}
