// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final moderationTransparencyMetrics = AdminAction(
  name: 'moderation-transparency-metrics',
  summary: 'Collects and provides transparency metrics.',
  description: '''
Scans ModerationCase and User entities and collects statistics
required for the  transparency metrics report.
''',
  options: {
    'start':
        'The inclusive start date of the reported period in the format of `YYYY-MM-DD`.',
    'end':
        'The inclusive end date of the reported period in the format of `YYYY-MM-DD`.',
  },
  invoke: (options) async {
    final dateRegExp = RegExp(r'^\d{4}\-\d{2}\-\d{2}$');

    DateTime parseDate(String key) {
      final param = options[key] ?? '';
      InvalidInputException.check(
        dateRegExp.matchAsPrefix(param) != null,
        '`$key` must be a valid date in YYYY-MM-DD format',
      );
      final parsed = DateTime.tryParse(param);
      InvalidInputException.check(
        parsed != null,
        '`$key` must be a valid date in YYYY-MM-DD format',
      );
      return parsed!;
    }

    final start = parseDate('start');
    final end = parseDate('end');

    // The number of cases where a moderation action has been done.
    var totalModerationCount = 0;
    // The grouped counts of moderation actions by violations.
    final violations = <String, int>{};
    // The grouped counts of moderation actions by detection sources.
    final sources = <String, int>{};
    // The grouped counts of moderation actions by applied restrictions.
    final restrictions = <String, int>{};

    // The number of appeals.
    var totalAppealCount = 0;
    // The number of appeals where the person responding is a known content owner.
    var contentOwnerAppealCount = 0;
    // The grouped counts of appeals by outcomes.
    final appealOutcomes = <String, int>{};
    // The list of time-to-action days - required for reporting the median.
    final appealTimeToActionDays = <int>[];

    final mcQuery = dbService.query<ModerationCase>()
      // timestamp start on 00:00:00 on the day
      ..filter('resolved >=', start)
      // adding an extra day to make sure the end day is fully included
      ..filter('resolved <', end.add(Duration(days: 1)));
    await for (final mc in mcQuery.run()) {
      // sanity check
      if (mc.resolved == null) {
        continue;
      }

      // Report group #1: case has moderated action. Whether the case was
      // a notification or appeal won't make a difference for this group.
      if (mc.status == ModerationStatus.moderationApplied ||
          mc.status == ModerationStatus.noActionReverted) {
        totalModerationCount++;
        violations.increment(mc.violation ?? '');
        sources.increment(mc.source);

        final hasUserRestriction = mc
            .getActionLog()
            .entries
            .any((e) => ModerationSubject.tryParse(e.subject)!.isUser);
        // If actions resulted in a user being blocked, then we count it as
        // "provision", even if packages were also removed.
        // Reasoning that it's natural that blocking a user would also
        // remove some of the users content.
        if (hasUserRestriction) {
          restrictions.increment('provision');
        } else {
          restrictions.increment('visibility');
        }
      }

      // Report group #2: appeals.
      if (mc.appealedCaseId != null) {
        totalAppealCount++;
        if (mc.isSubjectOwner) {
          contentOwnerAppealCount++;
        }

        switch (mc.status) {
          case ModerationStatus.noActionUpheld:
          case ModerationStatus.moderationUpheld:
            appealOutcomes.increment('upheld');
            break;
          case ModerationStatus.noActionReverted:
          case ModerationStatus.moderationReverted:
            appealOutcomes.increment('reverted');
            break;
          default:
            appealOutcomes.increment('omitted');
            break;
        }

        final timeToActionDays = mc.resolved!.difference(mc.opened).inDays + 1;
        appealTimeToActionDays.add(timeToActionDays);
      }
    }

    appealTimeToActionDays.sort();
    final appealMedianTimeToActionDays = appealTimeToActionDays.isEmpty
        ? 0
        : appealTimeToActionDays[appealTimeToActionDays.length ~/ 2];

    final userQuery = dbService.query<User>()
      // timestamp start on 00:00:00 on the day
      ..filter('moderatedAt >=', start)
      // adding an extra day to make sure the end day is fully included
      ..filter('moderatedAt <', end.add(Duration(days: 1)));
    final reasonCounts = <String, int>{};
    await for (final user in userQuery.run()) {
      // sanity check
      if (user.moderatedAt == null) {
        continue;
      }

      // Report group #3: user restrictions.
      reasonCounts.increment(user.moderatedReason ?? '');
    }

    final text = toCsV([
      // ---------------------------------------
      ['Restrictive actions', ''],
      ['Total number of actions taken', totalModerationCount],
      [
        'Number of actions taken, by type of illegal content or violation of terms and conditions',
        '',
      ],
      [
        'VIOLATION_CATEGORY_ANIMAL_WELFARE',
        violations[ModerationViolation.animalWelfare] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_DATA_PROTECTION_AND_PRIVACY_VIOLATIONS',
        violations[ModerationViolation.dataProtectionAndPrivacyViolations] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_ILLEGAL_OR_HARMFUL_SPEECH',
        violations[ModerationViolation.illegalAndHatefulSpeech] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_INTELLECTUAL_PROPERTY_INFRINGEMENTS',
        violations[ModerationViolation.intellectualPropertyInfringements] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_NEGATIVE_EFFECTS_ON_CIVIC_DISCOURSE_OR_ELECTIONS',
        violations[ModerationViolation
                .negativeEffectsOnCivicDiscourseOrElections] ??
            0,
      ],
      [
        'VIOLATION_CATEGORY_NON_CONSENSUAL_BEHAVIOUR',
        violations[ModerationViolation.nonConsensualBehavior] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_PORNOGRAPHY_OR_SEXUALIZED_CONTENT',
        violations[ModerationViolation.pornographyOrSexualizedContent] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_PROTECTION_OF_MINORS',
        violations[ModerationViolation.protectionOfMinors] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_RISK_FOR_PUBLIC_SECURITY',
        violations[ModerationViolation.riskForPublicSecurity] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_SCAMS_AND_FRAUD',
        violations[ModerationViolation.scamsAndFraud] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_SELF_HARM',
        violations[ModerationViolation.selfHarm] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_SCOPE_OF_PLATFORM_SERVICE',
        violations[ModerationViolation.scopeOfPlatformService] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_UNSAFE_AND_ILLEGAL_PRODUCTS',
        violations[ModerationViolation.unsafeAndIllegalProducts] ?? 0,
      ],
      [
        'VIOLATION_CATEGORY_VIOLENCE',
        violations[ModerationViolation.violence] ?? 0,
      ],
      ['Number of actions taken, by detection method', ''],
      [
        'Automated detection',
        sources[ModerationSource.automatedDetection] ?? 0
      ],
      [
        'Non-automated detection',
        sources.entries
            .where((e) => e.key != ModerationSource.automatedDetection)
            .map((e) => e.value)
            .fold<int>(0, (a, b) => a + b)
      ],
      ['Number of actions taken, by type of restriction applied', ''],
      [
        'Restrictions of Visibility',
        restrictions['visibility'] ?? 0,
      ],
      [
        'Restrictions of Monetisation',
        restrictions['monetisation'] ?? 0,
      ],
      [
        'Restrictions of Provision of the Service',
        restrictions['provision'] ?? 0,
      ],
      [
        'Restrictions of an Account',
        restrictions['account'] ?? 0,
      ],

      // ---------------------------------------
      ['Complaints received through internal complaint handling systems', ''],
      ['Total number of complaints received', totalAppealCount],
      ['Number of complaints received, by reason for complaint', ''],
      ['CONTENT_ACCOUNT_OWNER_APPEAL', contentOwnerAppealCount],
      ['REPORTER_APPEAL', totalAppealCount - contentOwnerAppealCount],
      ['Number of complaints received, by outcome', ''],
      [
        'Initial decision upheld',
        appealOutcomes['upheld'] ?? 0,
      ],
      [
        'Initial decision reversed',
        appealOutcomes['reverted'] ?? 0,
      ],
      [
        'Decision omitted',
        appealOutcomes['omitted'] ?? 0,
      ],
      [
        'Median time to action a complaint (days)',
        appealMedianTimeToActionDays,
      ],

      // ---------------------------------------
      ['Suspensions imposed to protect against misuse', ''],
      [
        'Number of suspensions for manifestly illegal content imposed pursuant to Article 23',
        reasonCounts[UserModeratedReason.illegalContent] ?? 0,
      ],
      [
        'Number of suspensions for manifestly unfounded notices imposed pursuant to Article 23',
        reasonCounts[UserModeratedReason.unfoundedNotifications] ?? 0,
      ],
      [
        'Number of suspensions for manifestly unfounded complaints imposed pursuant to Article 23',
        reasonCounts[UserModeratedReason.unfoundedAppeals] ?? 0,
      ],
    ]);

    return {
      'text': text,
      'moderations': {
        'total': totalModerationCount,
        'violations': violations,
        'sources': sources,
        'restrictions': restrictions,
      },
      'appeals': {
        'total': totalAppealCount,
        'contentOwner': contentOwnerAppealCount,
        'outcomes': appealOutcomes,
        'medianTimeToActionDays': appealMedianTimeToActionDays,
      },
      'users': {
        'suspensions': reasonCounts,
      }
    };
  },
);

/// Loose implementation of RFC 4180 writing tabular data into Comma Separated Values.
/// The current implementation supports only String and int values.
String toCsV(List<List<Object>> data) {
  final sb = StringBuffer();
  for (final row in data) {
    for (var i = 0; i < row.length; i++) {
      if (i > 0) {
        sb.write(',');
      }
      final value = row[i];
      if (value is int) {
        sb.write(value);
      } else if (value is String) {
        final mustEscape = value.contains(',') ||
            value.contains('"') ||
            value.contains('\r') ||
            value.contains('\n');
        sb.write(mustEscape ? '"${value.replaceAll('"', '""')}"' : value);
      } else {
        throw UnimplementedError(
            'Unhandled CSV type: ${value.runtimeType}/$value');
      }
    }
    sb.write('\r\n');
  }
  return sb.toString();
}

extension on Map<String, int> {
  void increment(String key) {
    this[key] = (this[key] ?? 0) + 1;
  }
}
