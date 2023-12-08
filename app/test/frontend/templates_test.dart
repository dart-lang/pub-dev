// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/format/x_ago_format.dart';
import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:clock/clock.dart';
import 'package:html/parser.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/frontend/handlers/package.dart'
    show loadPackagePageData;
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/frontend/templates/admin.dart';
import 'package:pub_dev/frontend/templates/consent.dart';
import 'package:pub_dev/frontend/templates/landing.dart';
import 'package:pub_dev/frontend/templates/listing.dart';
import 'package:pub_dev/frontend/templates/misc.dart';
import 'package:pub_dev/frontend/templates/package.dart';
import 'package:pub_dev/frontend/templates/package_admin.dart';
import 'package:pub_dev/frontend/templates/publisher.dart';
import 'package:pub_dev/frontend/templates/views/pkg/score_tab.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/search_adapter.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/service/youtube/backend.dart';
import 'package:pub_dev/shared/utils.dart' show shortDateFormat;
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';
import 'handlers/_utils.dart';

const String goldenDir = 'test/frontend/golden';

final _regenerateGoldens = false;

void main() {
  group('templates', () {
    Future<PackagePageData> loadPackagePageDataByName(
            String name, String versionName, String? assetKind) async =>
        loadPackagePageData((await packageBackend.lookupPackage(name))!,
            versionName, assetKind);

    void expectGoldenFile(
      String content,
      String fileName, {
      bool isFragment = false,
      Map<String, DateTime?>? timestamps,
      Map<String, String>? replacements,
    }) {
      // Making sure it is valid HTML
      final htmlParser = HtmlParser(content, strict: true);

      if (isFragment) {
        final root = htmlParser.parseFragment();
        validateHtml(root);
      } else {
        final root = htmlParser.parse();
        validateHtml(root);
      }

      var replacedContent = content;
      timestamps?.forEach((key, value) {
        if (value != null) {
          final age = clock.now().difference(value);
          replacedContent = replacedContent
              .replaceAll(shortDateFormat.format(value), '%%$key-date%%')
              .replaceAll(value.toIso8601String(), '%%$key-timestamp%%')
              .replaceAll(value.toIso8601String().replaceAll(':', r'\u003a'),
                  '%%$key-escaped-timestamp%%')
              .replaceAll(RegExp(r'data-timestamp="\d+"'),
                  'data-timestamp="%%millis%%"')
              .replaceAll(formatXAgo(age), '%%x-ago%%');
        }
      });
      replacements?.forEach((key, value) {
        replacedContent = replacedContent.replaceAll(value, '%%$key%%');
      });
      replacedContent = replacedContent
          .replaceAll('Pana <code>$panaVersion</code>,',
              'Pana <code>%%pana-version%%</code>,')
          .replaceAll('Dart <code>$toolStableDartSdkVersion</code>',
              'Dart <code>%%stable-dart-version%%</code>')
          .replaceAll('/static/hash-${staticFileCache.etag}/',
              '/static/hash-%%etag%%/');
      final csrfToken = requestContext.sessionData?.csrfToken;
      if (csrfToken != null) {
        replacedContent =
            replacedContent.replaceAll(csrfToken, '%%csrf-token%%');
      }
      final xmlContent =
          prettyPrintHtml(replacedContent, isFragment: isFragment);

      if (_regenerateGoldens) {
        File('$goldenDir/$fileName').writeAsStringSync(xmlContent);
        fail('Set `_regenerateGoldens` to `false` to run tests.');
      }
      final golden = File('$goldenDir/$fileName').readAsStringSync();
      expect(xmlContent.split('\n'), golden.split('\n'));
    }

    testWithProfile(
      'landing page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final html = renderLandingPage(ffPackages: [
          (await scoreCardBackend.getPackageView('flutter_titanium'))!,
        ], mostPopularPackages: [
          (await scoreCardBackend.getPackageView('neon'))!,
          (await scoreCardBackend.getPackageView('oxygen'))!,
        ], topPoWVideos: [
          PkgOfWeekVideo(
              videoId: 'video-id',
              title: 'POW Title',
              description: 'POW description',
              thumbnailUrl: 'http://youtube.com/image/thumbnail?i=123&s=4'),
        ]);
        expectGoldenFile(html, 'landing_page.html');
      },
    );

    testWithProfile(
      'package show page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await withFakeAuthRequestContext(
          adminAtPubDevEmail,
          () => loadPackagePageDataByName('oxygen', '1.2.0', AssetKind.readme),
        );
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_page.html', timestamps: {
          'published': data.package.created,
          'updated': data.version.created,
        });
      },
    );

    testWithProfile(
      'package changelog page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageDataByName(
            'oxygen', '1.2.0', AssetKind.changelog);
        final html = renderPkgChangelogPage(data);
        expectGoldenFile(html, 'pkg_changelog_page.html', timestamps: {
          'published': data.package.created,
          'updated': data.version.created,
        });
      },
    );

    testWithProfile(
      'package example page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageDataByName(
            'oxygen', '1.2.0', AssetKind.example);
        final html = renderPkgExamplePage(data);
        expectGoldenFile(html, 'pkg_example_page.html', timestamps: {
          'published': data.package.created,
          'updated': data.version.created,
        });
      },
    );

    testWithProfile(
      'package install page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageDataByName('oxygen', '1.2.0', null);
        final html = renderPkgInstallPage(data);
        expectGoldenFile(html, 'pkg_install_page.html', timestamps: {
          'published': data.package.created,
          'updated': data.version.created,
        });
      },
    );

    testWithProfile('package score page', processJobsWithFakeRunners: true,
        fn: () async {
      final data = await loadPackagePageDataByName('oxygen', '1.2.0', null);
      final html = renderPkgScorePage(data);
      expectGoldenFile(html, 'pkg_score_page.html', timestamps: {
        'published': data.package.created,
        'updated': data.version.created,
      });
    });

    testWithProfile(
      'package show page - with version',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageDataByName(
            'oxygen', '1.2.0', AssetKind.readme);
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_version_page.html', timestamps: {
          'published': data.package.created,
          'updated': data.version.created,
        });
      },
    );

    testWithProfile(
      'package show page with flutter_plugin',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await withFakeAuthRequestContext(
          adminAtPubDevEmail,
          () => loadPackagePageDataByName(
              'flutter_titanium', '1.10.0', AssetKind.readme),
        );
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html',
            timestamps: {
              'published': data.package.created,
              'updated': data.version.created,
            });
      },
    );

    testWithProfile('package show page with discontinued version',
        testProfile: TestProfile(
          packages: [
            TestPackage(name: 'other'),
            TestPackage(
              name: 'pkg',
              versions: [TestVersion(version: '1.0.0')],
              isDiscontinued: true,
              replacedBy: 'other',
            ),
          ],
          defaultUser: 'admin@pub.dev',
        ),
        processJobsWithFakeRunners: true, fn: () async {
      final data =
          await loadPackagePageDataByName('pkg', '1.0.0', AssetKind.readme);
      final html = renderPkgShowPage(data);
      expectGoldenFile(html, 'pkg_show_page_discontinued.html', timestamps: {
        'published': data.package.created,
        'updated': data.version.created,
      });
    });

    testWithProfile('package show page with retracted version',
        testProfile: TestProfile(
          packages: [
            TestPackage(
              name: 'pkg',
              versions: [
                TestVersion(version: '1.0.0'),
                TestVersion(version: '2.0.0'),
              ],
              retractedVersions: ['1.0.0'],
            ),
          ],
          defaultUser: 'admin@pub.dev',
        ),
        processJobsWithFakeRunners: true, fn: () async {
      final data =
          await loadPackagePageDataByName('pkg', '1.0.0', AssetKind.readme);
      final html = renderPkgShowPage(data);
      expectGoldenFile(html, 'pkg_show_page_retracted.html', timestamps: {
        'published': data.package.created,
        'updated': data.version.created,
      });

      final data2 =
          await loadPackagePageDataByName('pkg', '2.0.0', AssetKind.readme);
      final html2 = renderPkgShowPage(data2);
      expectGoldenFile(
          html2, 'pkg_show_page_retracted_non_retracted_version.html',
          timestamps: {
            'published': data2.package.created,
            'updated': data2.version.created,
          });
    });

    testWithProfile('package show page with non-retracted version',
        testProfile: TestProfile(
          packages: [
            TestPackage(
              name: 'pkg',
              versions: [
                TestVersion(version: '1.0.0'),
                TestVersion(version: '2.0.0'),
              ],
              retractedVersions: ['1.0.0'],
            ),
          ],
          defaultUser: 'admin@pub.dev',
        ),
        processJobsWithFakeRunners: true, fn: () async {
      final data2 =
          await loadPackagePageDataByName('pkg', '2.0.0', AssetKind.readme);
      final html2 = renderPkgShowPage(data2);
      expectGoldenFile(
          html2, 'pkg_show_page_retracted_non_retracted_version.html',
          timestamps: {
            'published': data2.package.created,
            'updated': data2.version.created,
          });
    });

    // package analysis was intentionally left out for this template
    testWithProfile(
      'package show page with publisher',
      fn: () async {
        final data =
            await loadPackagePageDataByName('neon', '1.0.0', AssetKind.readme);
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_page_publisher.html', timestamps: {
          'published': data.package.created,
          'updated': data.package.lastVersionPublished,
        });
      },
      processJobsWithFakeRunners: true,
    );

    scopedTest('no content for analysis tab', () async {
      // no content
      expect(
          scoreTabNode(
            package: 'pkg',
            version: '1.1.1',
            card: null,
            likeCount: 4,
            usesFlutter: false,
            isLatestStable: false,
          ).toString(),
          '<i>Awaiting analysis to complete.</i>');
    });

    testWithProfile(
      'package admin page',
      processJobsWithFakeRunners: true,
      fn: () async {
        await withFakeAuthRequestContext(
          adminAtPubDevEmail,
          () async {
            final data = await loadPackagePageDataByName(
                'oxygen', '1.2.0', AssetKind.readme);
            final html = renderPkgAdminPage(
              data,
              ['example.com'],
              await accountBackend.lookupUsersByEmail('admin@pub.dev'),
              ['2.0.0'],
              ['1.0.0'],
            );
            expectGoldenFile(html, 'pkg_admin_page.html', timestamps: {
              'published': data.package.created,
              'updated': data.version.created,
            });
          },
        );
      },
    );

    testWithProfile(
      'package activity log page',
      processJobsWithFakeRunners: true,
      fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final data = await loadPackagePageDataByName('oxygen', '1.2.0', null);
          final activities = await auditBackend.listRecordsForPackage('oxygen');
          expect(activities.records, isNotEmpty);

          // extra records to trigger the 2-month seaprator
          final mockPresent = clock.now();
          activities.records.insert(
              0,
              AuditLogRecord()
                ..created = mockPresent
                ..expires = mockPresent.add(Duration(days: 61))
                ..summary = 'recent action');

          final mockPast = data.package.created!.subtract(Duration(days: 75));
          activities.records.add(AuditLogRecord()
            ..created = mockPast
            ..expires = auditLogRecordExpiresInFarFuture
            ..summary = 'old action');

          final html = renderPkgActivityLogPage(data, activities);
          expectGoldenFile(html, 'pkg_activity_log_page.html', timestamps: {
            'published': data.package.created,
            'updated': data.version.created,
            ..._activityLogTimestamps(activities),
          });
        });
      },
    );

    testWithProfile(
      'package index page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm(query: 'sdk:dart');
        final oxygen = (await scoreCardBackend.getPackageView('oxygen'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final String html = renderPkgIndexPage(
          SearchResultPage(
            searchForm,
            2,
            sdkLibraryHits: [
              SdkLibraryHit(
                sdk: 'dart',
                version: '2.14.0',
                library: 'dart:core',
                description: 'core description',
                url: 'https://api.dart.dev/library-page.html',
                score: 1.0,
                apiPages: null,
              ),
            ],
            packageHits: [oxygen, titanium],
          ),
          PageLinks.empty(),
          searchForm: searchForm,
        );
        expectGoldenFile(html, 'pkg_index_page.html', timestamps: {
          'oxygen-created': oxygen.created,
          'titanium-created': titanium.created,
        });
      },
    );

    testWithProfile(
      'package index page with search',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm(query: 'foobar', order: SearchOrder.top);
        final oxygen = (await scoreCardBackend.getPackageView('oxygen'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final String html = renderPkgIndexPage(
          SearchResultPage(
            searchForm,
            2,
            packageHits: [
              oxygen.change(
                apiPages: [
                  ApiPageRef(path: 'some/some-library.html'),
                  ApiPageRef(title: 'Class X', path: 'some/x-class.html'),
                ],
              ),
              titanium,
            ],
          ),
          PageLinks(searchForm, 50),
          searchForm: searchForm,
        );
        expectGoldenFile(html, 'search_page.html', timestamps: {
          'oxygen-created': oxygen.created,
          'titanium-created': titanium.created,
        });
      },
    );

    testWithProfile(
      'package versions page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageDataByName('oxygen', '1.2.0', null);
        final rs = await issueGet('/packages/oxygen/versions');
        final html = await rs.readAsString();
        expectGoldenFile(html, 'pkg_versions_page.html', timestamps: {
          'version-created': data.version.created,
          'package-created': data.package.created,
        });
      },
    );

    testWithProfile('publisher list page', fn: () async {
      final html = renderPublisherListPage(
        [
          PublisherSummary(
            publisherId: 'example.com',
            created: DateTime(2019, 09, 13),
          ),
          PublisherSummary(
            publisherId: 'other-domain.com',
            created: DateTime(2019, 09, 19),
          ),
        ],
      );
      expectGoldenFile(
        html,
        'publisher_list_page.html',
        timestamps: {
          'example-created': DateTime(2019, 09, 13),
          'other-created': DateTime(2019, 09, 19),
        },
      );
    });

    testWithProfile(
      'publisher packages page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm();
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final neon = (await scoreCardBackend.getPackageView('neon'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final html = renderPublisherPackagesPage(
          publisher: publisher,
          kind: PublisherPackagesPageKind.listed,
          searchResultPage: SearchResultPage(
            searchForm,
            2,
            packageHits: [neon, titanium],
          ),
          totalCount: 2,
          searchForm: searchForm,
          pageLinks: PageLinks(searchForm, 10),
          isAdmin: true,
          messageFromBackend: null,
        );
        expectGoldenFile(html, 'publisher_packages_page.html', timestamps: {
          'neon-created': neon.created,
          'titanium-created': titanium.created,
          'publisher-created': publisher.created,
          'publisher-updated': publisher.updated,
        });
      },
    );

    testWithProfile(
      'publisher unlisted packages page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm();
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final neon = (await scoreCardBackend.getPackageView('neon'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final html = renderPublisherPackagesPage(
          publisher: publisher,
          kind: PublisherPackagesPageKind.unlisted,
          searchResultPage: SearchResultPage(
            searchForm,
            2,
            packageHits: [neon, titanium],
          ),
          totalCount: 2,
          searchForm: searchForm,
          pageLinks: PageLinks(searchForm, 10),
          isAdmin: true,
          messageFromBackend: null,
        );
        expectGoldenFile(html, 'publisher_unlisted_packages_page.html',
            timestamps: {
              'neon-created': neon.created,
              'titanium-created': titanium.created,
              'publisher-created': publisher.created,
              'publisher-updated': publisher.updated,
            });
      },
    );

    testWithProfile(
      'publisher admin page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final members =
            await publisherBackend.listPublisherMembers('example.com');
        final html = renderPublisherAdminPage(
          publisher: publisher,
          members: members,
        );
        expectGoldenFile(
          html,
          'publisher_admin_page.html',
          timestamps: {
            'publisher-created': publisher.created,
            'publisher-updated': publisher.updated,
          },
          replacements: {
            ...Map.fromIterables(
                members.map((m) => m.email), members.map((m) => m.userId)),
          },
        );
      },
    );

    testWithProfile(
      'publisher activity log page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final activities =
            await auditBackend.listRecordsForPublisher('example.com');
        expect(activities.records, isNotEmpty);
        final html = renderPublisherActivityLogPage(
          publisher: publisher,
          activities: activities,
        );
        expectGoldenFile(html, 'publisher_activity_log_page.html', timestamps: {
          'publisher-created': publisher.created,
          'publisher-updated': publisher.updated,
          ..._activityLogTimestamps(activities),
        });
      },
    );

    testWithProfile(
      '/my-packages page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final oxygen = await scoreCardBackend.getPackageView('oxygen');
        final neon = await scoreCardBackend.getPackageView('neon');
        await withFakeAuthRequestContext(userAtPubDevEmail, () async {
          final authenticatedUser = await requireAuthenticatedWebUser();
          final user = authenticatedUser.user;
          final html = renderAccountPackagesPage(
            user: user,
            userSessionData: requestContext.sessionData!,
            packageHits: [oxygen!, neon!],
            startPackage: 'oxygen',
            nextPackage: 'package_after_neon',
          );
          expectGoldenFile(html, 'my_packages.html', timestamps: {
            'oxygen-created': oxygen.created,
            'neon-created': neon.created,
          });
        });
      },
    );

    testWithProfile('/my-liked-packages page', fn: () async {
      await withFakeAuthRequestContext(userAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final liked1 = DateTime.fromMillisecondsSinceEpoch(1574423824000);
        final liked2 = DateTime.fromMillisecondsSinceEpoch(1574423824000);
        final html = renderMyLikedPackagesPage(
          user: user,
          userSessionData: requestContext.sessionData!,
          likes: [
            LikeData(package: 'super_package', created: liked1),
            LikeData(package: 'another_package', created: liked2)
          ],
        );
        expectGoldenFile(html, 'my_liked_packages.html', timestamps: {
          'user-created': user.created,
          'liked1': liked1,
          'liked2': liked2,
        });
      });
    });

    testWithProfile('/my-publishers page', fn: () async {
      await withFakeAuthRequestContext(userAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final publisherCreated = DateTime(2021, 07, 01, 16, 05);
        final html = renderAccountPublishersPage(
          user: user,
          userSessionData: requestContext.sessionData!,
          publishers: [
            PublisherSummary(
              publisherId: 'example.com',
              created: publisherCreated,
            ),
          ],
        );
        expectGoldenFile(html, 'my_publishers.html', timestamps: {
          'user-created': user.created,
          'publisher-created': publisherCreated,
        });
      });
    });

    testWithProfile('/my-activity-log page', fn: () async {
      await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final activities = await auditBackend.listRecordsForUserId(user.userId);
        expect(activities.records, isNotEmpty);
        final html = renderAccountMyActivityPage(
          user: user,
          userSessionData: requestContext.sessionData!,
          activities: activities,
        );
        expectGoldenFile(html, 'my_activity_log_page.html', timestamps: {
          'user-created': user.created,
          ..._activityLogTimestamps(activities),
        });
      });
    });

    testWithProfile('create publisher page', fn: () async {
      final html = renderCreatePublisherPage(domain: null);
      expectGoldenFile(html, 'create_publisher_page.html');
    });

    testWithProfile('consent page', fn: () async {
      final html = renderConsentPage(
        consentId: '1234-5678',
        title: 'Invite for something',
        descriptionHtml: '<b>Warning!</b> And text...',
      );
      expectGoldenFile(html, 'consent_page.html');
    });

    testWithProfile('consent - package uploader invite (anonymous)',
        fn: () async {
      final html = renderPackageUploaderInvite(
        invitingUserEmail: 'admin@pub.dev',
        packageName: 'example_pkg',
        currentUserEmail: null,
      );
      expectGoldenFile(
        html,
        'consent_package_uploader_anonymous.html',
        isFragment: true,
      );
    });

    testWithProfile('consent - package uploader invite (authenticated)',
        fn: () async {
      final html = renderPackageUploaderInvite(
        invitingUserEmail: 'admin@pub.dev',
        packageName: 'example_pkg',
        currentUserEmail: 'user@pub.dev',
      );
      expectGoldenFile(
        html,
        'consent_package_uploader_authenticated.html',
        isFragment: true,
      );
    });

    testWithProfile('consent - publisher contact invite', fn: () async {
      final html = renderPublisherContactInvite(
        invitingUserEmail: 'admin@pub.dev',
        contactEmail: 'hello@example.com',
        publisherId: 'dart.dev',
      );
      expectGoldenFile(
        html,
        'consent_publisher_contact_invite.html',
        isFragment: true,
      );
    });

    testWithProfile('consent - publisher member invite', fn: () async {
      final html = renderPublisherMemberInvite(
        invitingUserEmail: 'admin@pub.dev',
        publisherId: 'dart.dev',
      );
      expectGoldenFile(
        html,
        'consent_publisher_member_invite.html',
        isFragment: true,
      );
    });

    testWithProfile('authorized page', fn: () async {
      final String html = renderAuthorizedPage();
      expectGoldenFile(html, 'authorized_page.html');
    });

    testWithProfile('error page', fn: () async {
      final String html = renderErrorPage('error_title', 'error_message');
      expectGoldenFile(html, 'error_page.html');
    });

    testWithProfile('help page', fn: () async {
      final html = renderHelpPage();
      expectGoldenFile(html, 'help_page.html');
    });

    testWithProfile('topics page', fn: () async {
      final html = renderTopicsPage({'ui': 5, 'network': 7, 'http': 4});
      expectGoldenFile(html, 'topics_page.html');
    });

    scopedTest('pagination: single page', () {
      final html = paginationNode(PageLinks.empty()).toString();
      expectGoldenFile(html, 'pagination_single.html', isFragment: true);
    });

    scopedTest('pagination: in the middle', () {
      final html = paginationNode(PageLinks(SearchForm(currentPage: 10), 299))
          .toString();
      expectGoldenFile(html, 'pagination_middle.html', isFragment: true);
    });

    scopedTest('pagination: at first page', () {
      final html = paginationNode(PageLinks(SearchForm(), 600)).toString();
      expectGoldenFile(html, 'pagination_first.html', isFragment: true);
    });

    scopedTest('pagination: at last page', () {
      final html =
          paginationNode(PageLinks(SearchForm(currentPage: 10), 91)).toString();
      expectGoldenFile(html, 'pagination_last.html', isFragment: true);
    });
  });

  group('PageLinks', () {
    test('empty', () {
      final links = PageLinks.empty();
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('one', () {
      final links = PageLinks(SearchForm(), 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(SearchForm(), resultsPerPage - 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE', () {
      final links = PageLinks(SearchForm(), resultsPerPage);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(SearchForm(), resultsPerPage + 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    final int page2Offset = resultsPerPage;

    test('page=2 + one item', () {
      final links = PageLinks(SearchForm(currentPage: 2), page2Offset + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(
          SearchForm(currentPage: 2), page2Offset + resultsPerPage - 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE', () {
      final links =
          PageLinks(SearchForm(currentPage: 2), page2Offset + resultsPerPage);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(
          SearchForm(currentPage: 2), page2Offset + resultsPerPage + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 3);
    });

    test('deep in the middle', () {
      final links = PageLinks(SearchForm(currentPage: 21), 600);
      expect(links.currentPage, 21);
      expect(links.leftmostPage, 16);
      expect(links.rightmostPage, 26);
    });
  });
}

Map<String, DateTime> _activityLogTimestamps(AuditLogRecordPage page) {
  final map = <String, DateTime>{};
  for (final record in page.records) {
    final index = map.length;
    map['activity-$index'] = record.created!;
  }
  return map;
}
