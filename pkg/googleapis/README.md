Auto-generated Dart libraries for accessing [Google APIs][libs].

## Usage

First, obtain OAuth 2.0 access credentials. This can be done using the
`googleapis_auth` package. Your application can access APIs on behalf of a
user or using a service account.

After obtaining credentials, an API from the `googleapis` package can be
accessed with an authenticated HTTP client.

## Example

The following command line application lists files in Google Drive by using a
service account.

Create a `pubspec.yaml` file with the `googleapis_auth` and `googleapis`
dependencies.

```yaml
...
dependencies:
  googleapis: any
  googleapis_auth: any
```

Create a service account in the Google Cloud Console and save the credential
information.

Then create a Dart application to list files in a spececific project. *In the
example below, files from the `dart-on-cloud` project are listed.*

```dart
// bin/list_files.dart

import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

final _credentials = new ServiceAccountCredentials.fromJson(r'''
{
  "private_key_id": ...,
  "private_key": ...,
  "client_email": ...,
  "client_id": ...,
  "type": "service_account"
}
''');

const _SCOPES = const [StorageApi.DevstorageReadOnlyScope];

void main() {
  clientViaServiceAccount(_credentials, _SCOPES).then((http_client) {
    var storage = new StorageApi(http_client);
    storage.buckets.list('dart-on-cloud').then((buckets) {
      print("Received ${buckets.items.length} bucket names:");
      for (var file in buckets.items) {
        print(file.name);
      }
    });
  });
}
```

[libs]: https://developers.google.com/discovery/libraries/

## Available Google APIs

The following is a list of APIs that are currently available inside this
package.

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Accelerated Mobile Pages (AMP) URL API - acceleratedmobilepageurl v1

This API contains a single method, batchGet. Call this method to retrieve the AMP URL (and equivalent AMP Cache URL) for given public URL(s).


Official API documentation: https://developers.google.com/amp/cache/

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) Ad Exchange Buyer API - adexchangebuyer v1.3

Accesses your bidding-account information, submits creatives for validation, finds available direct deals, and retrieves performance reports.

Official API documentation: https://developers.google.com/ad-exchange/buyer-rest

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) Ad Exchange Buyer API - adexchangebuyer v1.4

Accesses your bidding-account information, submits creatives for validation, finds available direct deals, and retrieves performance reports.

Official API documentation: https://developers.google.com/ad-exchange/buyer-rest

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) Ad Exchange Seller API - adexchangeseller v1.1

Accesses the inventory of Ad Exchange seller users and generates reports.

Official API documentation: https://developers.google.com/ad-exchange/seller-rest/

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) Ad Exchange Seller API - adexchangeseller v2.0

Accesses the inventory of Ad Exchange seller users and generates reports.

Official API documentation: https://developers.google.com/ad-exchange/seller-rest/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Admin Data Transfer API - admin datatransfer_v1

Transfers user data from one user to another.

Official API documentation: https://developers.google.com/admin-sdk/data-transfer/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Admin Directory API - admin directory_v1

The Admin SDK Directory API lets you view and manage enterprise resources such as users and groups, administrative notifications, security features, and more.

Official API documentation: https://developers.google.com/admin-sdk/directory/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Admin Reports API - admin reports_v1

Fetches reports for the administrators of Google Apps customers about the usage, collaboration, security, and risk for their users.

Official API documentation: https://developers.google.com/admin-sdk/reports/

#### ![Logo](https://www.google.com/images/icons/product/adsense-16.png) AdSense Management API - adsense v1.4

Accesses AdSense publishers' inventory and generates performance reports.

Official API documentation: https://developers.google.com/adsense/management/

#### ![Logo](https://www.google.com/images/icons/product/adsense-16.png) AdSense Host API - adsensehost v4.1

Generates performance reports, generates ad codes, and provides publisher management capabilities for AdSense Hosts.

Official API documentation: https://developers.google.com/adsense/host/

#### ![Logo](https://www.google.com/images/icons/product/analytics-16.png) Google Analytics API - analytics v3

Views and manages your Google Analytics data.

Official API documentation: https://developers.google.com/analytics/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Analytics Reporting API - analyticsreporting v4

Accesses Analytics report data.

Official API documentation: https://developers.google.com/analytics/devguides/reporting/core/v4/

#### ![Logo](https://www.google.com/images/icons/product/android-16.png) Google Play EMM API - androidenterprise v1

Manages the deployment of apps to Android for Work users.

Official API documentation: https://developers.google.com/android/work/play/emm-api

#### ![Logo](https://www.google.com/images/icons/product/android-16.png) Google Play Developer API - androidpublisher v2

Lets Android application developers access their Google Play accounts.

Official API documentation: https://developers.google.com/android-publisher

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google App Engine Admin API - appengine v1

Provisions and manages App Engine applications.

Official API documentation: https://cloud.google.com/appengine/docs/admin-api/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) G Suite Activity API - appsactivity v1

Provides a historical view of activity.

Official API documentation: https://developers.google.com/google-apps/activity/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google App State API - appstate v1

The Google App State API.

Official API documentation: https://developers.google.com/games/services/web/api/states

#### ![Logo](https://www.google.com/images/icons/product/search-16.gif) BigQuery API - bigquery v2

A data platform for customers to create, manage, share and query data.

Official API documentation: https://cloud.google.com/bigquery/

#### ![Logo](https://www.google.com/images/icons/product/blogger-16.png) Blogger API - blogger v3

API for access to the data within Blogger.

Official API documentation: https://developers.google.com/blogger/docs/3.0/getting_started

#### ![Logo](https://www.google.com/images/icons/product/ebooks-16.png) Books API - books v1

Searches for books and manages your Google Books library.

Official API documentation: https://developers.google.com/books/docs/v1/getting_started

#### ![Logo](http://www.google.com/images/icons/product/calendar-16.png) Calendar API - calendar v3

Manipulates events and other calendar data.

Official API documentation: https://developers.google.com/google-apps/calendar/firstapp

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Civic Information API - civicinfo v2

Provides polling places, early vote locations, contest data, election officials, and government representatives for U.S. residential addresses.

Official API documentation: https://developers.google.com/civic-information

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Classroom API - classroom v1

Manages classes, rosters, and invitations in Google Classroom.

Official API documentation: https://developers.google.com/classroom/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Billing API - cloudbilling v1

Retrieves Google Developers Console billing accounts and associates them with projects.

Official API documentation: https://cloud.google.com/billing/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Container Builder API - cloudbuild v1

Builds container images in the cloud.

Official API documentation: https://cloud.google.com/container-builder/docs/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Stackdriver Debugger API - clouddebugger v2

Examines the call stack and variables of a running application without stopping or slowing it down.


Official API documentation: http://cloud.google.com/debugger

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Resource Manager API - cloudresourcemanager v1

The Google Cloud Resource Manager API provides methods for creating, reading, and updating project metadata.

Official API documentation: https://cloud.google.com/resource-manager

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Stackdriver Trace API - cloudtrace v1

Send and retrieve trace data from Stackdriver Trace. Data is generated and available by default for all App Engine applications. Data from other applications can be written to Stackdriver Trace for display, reporting, and analysis.


Official API documentation: https://cloud.google.com/trace

#### ![Logo](https://www.google.com/images/icons/product/compute_engine-16.png) Compute Engine API - compute v1

Creates and runs virtual machines on Google Cloud Platform.

Official API documentation: https://developers.google.com/compute/docs/reference/latest/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Consumer Surveys API - consumersurveys v2

Creates and conducts surveys, lists the surveys that an authenticated user owns, and retrieves survey results and information about specified surveys.

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Container Engine API - container v1

Builds and manages clusters that run container-based applications, powered by open source Kubernetes technology.

Official API documentation: https://cloud.google.com/container-engine/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Content API for Shopping - content v2

Manages product items, inventory, and Merchant Center accounts for Google Shopping.

Official API documentation: https://developers.google.com/shopping-content

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Content API for Shopping - content v2sandbox

Manages product items, inventory, and Merchant Center accounts for Google Shopping.

Official API documentation: https://developers.google.com/shopping-content

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) CustomSearch API - customsearch v1

Lets you search over a website or collection of websites

Official API documentation: https://developers.google.com/custom-search/v1/using_rest

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Dataproc API - dataproc v1

Manages Hadoop-based clusters and jobs on Google Cloud Platform.

Official API documentation: https://cloud.google.com/dataproc/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Datastore API - datastore v1

Accesses the schemaless NoSQL database to provide fully managed, robust, scalable storage for your application.


Official API documentation: https://cloud.google.com/datastore/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Cloud Deployment Manager API - deploymentmanager v2

Declares, configures, and deploys complex solutions on Google Cloud Platform.

Official API documentation: https://cloud.google.com/deployment-manager/

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) DCM/DFA Reporting And Trafficking API - dfareporting v2.6

Manages your DoubleClick Campaign Manager ad campaigns and reports.

Official API documentation: https://developers.google.com/doubleclick-advertisers/

#### ![Logo](https://www.google.com/images/icons/product/doubleclick-16.gif) DCM/DFA Reporting And Trafficking API - dfareporting v2.7

Manages your DoubleClick Campaign Manager ad campaigns and reports.

Official API documentation: https://developers.google.com/doubleclick-advertisers/

#### ![Logo](http://www.google.com/images/icons/feature/filing_cabinet_search-g16.png) APIs Discovery Service - discovery v1

Provides information about other Google APIs, such as what APIs are available, the resource, and method details for each API.

Official API documentation: https://developers.google.com/discovery/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Cloud DNS API - dns v1

Configures and serves authoritative DNS records.

Official API documentation: https://developers.google.com/cloud-dns

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) DoubleClick Bid Manager API - doubleclickbidmanager v1

API for viewing and managing your reports in DoubleClick Bid Manager.

Official API documentation: https://developers.google.com/bid-manager/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) DoubleClick Search API - doubleclicksearch v2

Reports and modifies your advertising data in DoubleClick Search (for example, campaigns, ad groups, keywords, and conversions).

Official API documentation: https://developers.google.com/doubleclick-search/

#### ![Logo](https://ssl.gstatic.com/docs/doclist/images/drive_icon_16.png) Drive API - drive v2

Manages files in Drive including uploading, downloading, searching, detecting changes, and updating sharing permissions.

Official API documentation: https://developers.google.com/drive/

#### ![Logo](https://ssl.gstatic.com/docs/doclist/images/drive_icon_16.png) Drive API - drive v3

Manages files in Drive including uploading, downloading, searching, detecting changes, and updating sharing permissions.

Official API documentation: https://developers.google.com/drive/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Firebase Dynamic Links API - firebasedynamiclinks v1

Firebase Dynamic Links API enables third party developers to programmatically create and manage Dynamic Links.

Official API documentation: https://firebase.google.com/docs/dynamic-links/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Firebase Rules API - firebaserules v1

Creates and manages rules that determine when a Firebase Rules-enabled service should permit a request.


Official API documentation: https://firebase.google.com/docs/storage/security

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Fitness - fitness v1

Stores and accesses user data in the fitness store from apps on any platform.

Official API documentation: https://developers.google.com/fit/rest/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Fusion Tables API - fusiontables v1

API for working with Fusion Tables data.

Official API documentation: https://developers.google.com/fusiontables

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Fusion Tables API - fusiontables v2

API for working with Fusion Tables data.

Official API documentation: https://developers.google.com/fusiontables

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Play Game Services API - games v1

The API for Google Play Game Services.

Official API documentation: https://developers.google.com/games/services/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Play Game Services Publishing API - gamesConfiguration v1configuration

The Publishing API for Google Play Game Services.

Official API documentation: https://developers.google.com/games/services

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Play Game Services Management API - gamesManagement v1management

The Management API for Google Play Game Services.

Official API documentation: https://developers.google.com/games/services

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Genomics API - genomics v1

Upload, process, query, and search Genomics data in the cloud.

Official API documentation: https://cloud.google.com/genomics

#### ![Logo](https://www.google.com/images/icons/product/googlemail-16.png) Gmail API - gmail v1

Access Gmail mailboxes including sending user email.

Official API documentation: https://developers.google.com/gmail/api/

#### ![Logo](http://www.google.com/images/icons/product/discussions-16.gif) Groups Migration API - groupsmigration v1

Groups Migration Api.

Official API documentation: https://developers.google.com/google-apps/groups-migration/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Groups Settings API - groupssettings v1

Lets you manage permission levels and related settings of a group.

Official API documentation: https://developers.google.com/google-apps/groups-settings/get_started

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Identity and Access Management (IAM) API - iam v1

Manages identity and access control for Google Cloud Platform resources, including the creation of service accounts, which you can use to authenticate to Google and make API calls.

Official API documentation: https://cloud.google.com/iam/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Identity Toolkit API - identitytoolkit v3

Help the third party sites to implement federated login.

Official API documentation: https://developers.google.com/identity-toolkit/v3/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Knowledge Graph Search API - kgsearch v1

Searches the Google Knowledge Graph for entities.

Official API documentation: https://developers.google.com/knowledge-graph/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Natural Language API - language v1

Google Cloud Natural Language API provides natural language understanding technologies to developers. Examples include sentiment analysis, entity recognition, and text annotations.

Official API documentation: https://cloud.google.com/natural-language/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Enterprise License Manager API - licensing v1

Licensing API to view and manage license for your domain.

Official API documentation: https://developers.google.com/google-apps/licensing/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Stackdriver Logging API - logging v2

Writes log entries and manages your Stackdriver Logging configuration.

Official API documentation: https://cloud.google.com/logging/docs/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Manufacturer Center API - manufacturers v1

Public API for managing Manufacturer Center related data.

Official API documentation: https://developers.google.com/manufacturers/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Mirror API - mirror v1

Interacts with Glass users via the timeline.

Official API documentation: https://developers.google.com/glass

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Stackdriver Monitoring API - monitoring v3

Manages your Stackdriver Monitoring data and configurations. Most projects must be associated with a Stackdriver account, with a few exceptions as noted on the individual method pages.

Official API documentation: https://cloud.google.com/monitoring/api/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google OAuth2 API - oauth2 v2

Obtains end-user authorization grants for use with other Google APIs.

Official API documentation: https://developers.google.com/accounts/docs/OAuth2

#### ![Logo](https://www.google.com/images/icons/product/pagespeed-16.png) PageSpeed Insights API - pagespeedonline v1

Analyzes the performance of a web page and provides tailored suggestions to make that page faster.

Official API documentation: https://developers.google.com/speed/docs/insights/v1/getting_started

#### ![Logo](https://www.google.com/images/icons/product/pagespeed-16.png) PageSpeed Insights API - pagespeedonline v2

Analyzes the performance of a web page and provides tailored suggestions to make that page faster.

Official API documentation: https://developers.google.com/speed/docs/insights/v2/getting-started

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Partners API - partners v2

Lets advertisers search certified companies and create contact leads with them, and also audits the usage of clients.

Official API documentation: https://developers.google.com/partners/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google People API - people v1

Provides access to information about profiles and contacts.

Official API documentation: https://developers.google.com/people/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Play Movies Partner API - playmoviespartner v1

Gets the delivery status of titles for Google Play Movies Partners.

Official API documentation: https://developers.google.com/playmoviespartner/

#### ![Logo](http://www.google.com/images/icons/product/gplus-16.png) Google+ API - plus v1

Builds on top of the Google+ platform.

Official API documentation: https://developers.google.com/+/api/

#### ![Logo](http://www.google.com/images/icons/product/gplus-16.png) Google+ Domains API - plusDomains v1

Builds on top of the Google+ platform for Google Apps Domains.

Official API documentation: https://developers.google.com/+/domains/

#### ![Logo](https://www.google.com/images/icons/feature/predictionapi-16.png) Prediction API - prediction v1.6

Lets you access a cloud hosted machine learning service that makes it easy to build smart apps

Official API documentation: https://developers.google.com/prediction/docs/developer-guide

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Pub/Sub API - pubsub v1

Provides reliable, many-to-many, asynchronous messaging between applications.


Official API documentation: https://cloud.google.com/pubsub/docs

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) QPX Express API - qpxExpress v1

Finds the least expensive flights between an origin and a destination.

Official API documentation: http://developers.google.com/qpx-express

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Enterprise Apps Reseller API - reseller v1

Creates and manages your customers and their subscriptions.

Official API documentation: https://developers.google.com/google-apps/reseller/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud RuntimeConfig API - runtimeconfig v1

Provides capabilities for dynamic configuration and coordination for applications running on Google Cloud Platform.


Official API documentation: https://cloud.google.com/deployment-manager/runtime-configurator/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Safe Browsing APIs - safebrowsing v4

Enables client applications to check web resources (most commonly URLs) against Google-generated lists of unsafe web resources.

Official API documentation: https://developers.google.com/safe-browsing/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Apps Script Execution API - script v1

Executes Google Apps Script projects.

Official API documentation: https://developers.google.com/apps-script/execution/rest/v1/scripts/run

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Search Console URL Testing Tools API - searchconsole v1

Provides tools for running validation tests against single URLs

Official API documentation: https://developers.google.com/webmaster-tools/search-console-api/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Service Control API - servicecontrol v1

Google Service Control provides control plane functionality to managed services, such as logging, monitoring, and status checks.

Official API documentation: https://cloud.google.com/service-control/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Service Management API - servicemanagement v1

Google Service Management allows service producers to publish their services on Google Cloud Platform so that they can be discovered and used by service consumers.

Official API documentation: https://cloud.google.com/service-management/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Service User API - serviceuser v1

Enables services that service consumers want to use on Google Cloud Platform, lists the available or enabled services, or disables services that service consumers no longer use.

Official API documentation: https://cloud.google.com/service-management/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Sheets API - sheets v4

Reads and writes Google Sheets.

Official API documentation: https://developers.google.com/sheets/

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Google Site Verification API - siteVerification v1

Verifies ownership of websites or domains with Google.

Official API documentation: https://developers.google.com/site-verification/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Slides API - slides v1

An API for creating and editing Google Slides presentations.

Official API documentation: https://developers.google.com/slides/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Cloud Source Repositories API - sourcerepo v1

Access source code repositories hosted by Google.

Official API documentation: https://cloud.google.com/eap/cloud-repositories/cloud-sourcerepo-api

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Cloud Spanner API - spanner v1

Cloud Spanner is a managed, mission-critical, globally consistent and scalable relational database service.

Official API documentation: https://cloud.google.com/spanner/

#### ![Logo](https://www.google.com/images/icons/product/cloud_storage-16.png) Cloud Storage JSON API - storage v1

Stores and retrieves potentially large, immutable data objects.

Official API documentation: https://developers.google.com/storage/docs/json_api/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Storage Transfer API - storagetransfer v1

Transfers data from external data sources to a Google Cloud Storage bucket or between Google Cloud Storage buckets.

Official API documentation: https://cloud.google.com/storage/transfer

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Surveys API - surveys v2

Creates and conducts surveys, lists the surveys that an authenticated user owns, and retrieves survey results and information about specified surveys.

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) Tag Manager API - tagmanager v1

Accesses Tag Manager accounts and containers.

Official API documentation: https://developers.google.com/tag-manager/api/v1/

#### ![Logo](https://www.google.com/images/icons/product/tasks-16.png) Tasks API - tasks v1

Lets you manage your tasks and task lists.

Official API documentation: https://developers.google.com/google-apps/tasks/firstapp

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Tracing API - tracing v1

Send and retrieve trace data from Google Stackdriver Trace.


Official API documentation: https://cloud.google.com/trace

#### ![Logo](https://www.google.com/images/icons/product/translate-16.png) Translate API - translate v2

Translates text from one language to another.

Official API documentation: https://developers.google.com/translate/v2/using_rest

#### ![Logo](https://www.gstatic.com/images/branding/product/1x/googleg_16dp.png) URL Shortener API - urlshortener v1

Lets you create, inspect, and manage goo.gl short URLs

Official API documentation: https://developers.google.com/url-shortener/v1/getting_started

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) Google Cloud Vision API - vision v1

Integrates Google Vision features, including image labeling, face, logo, and landmark detection, optical character recognition (OCR), and detection of explicit content, into applications.

Official API documentation: https://cloud.google.com/vision/

#### ![Logo](https://www.google.com/images/icons/feature/font_api-16.png) Google Fonts Developer API - webfonts v1

Accesses the metadata for all families served by Google Fonts, providing a list of families currently available (including available styles and a list of supported script subsets).

Official API documentation: https://developers.google.com/fonts/docs/developer_api

#### ![Logo](https://www.google.com/images/icons/product/webmaster_tools-16.png) Search Console API - webmasters v3

View Google Search Console data for your verified sites.

Official API documentation: https://developers.google.com/webmaster-tools/

#### ![Logo](https://www.google.com/images/icons/product/youtube-16.png) YouTube Data API - youtube v3

Supports core YouTube features, such as uploading videos, creating and managing playlists, searching for content, and much more.

Official API documentation: https://developers.google.com/youtube/v3

#### ![Logo](https://www.google.com/images/icons/product/youtube-16.png) YouTube Analytics API - youtubeAnalytics v1

Retrieves your YouTube Analytics data.

Official API documentation: http://developers.google.com/youtube/analytics/

#### ![Logo](http://www.google.com/images/icons/product/search-16.gif) YouTube Reporting API - youtubereporting v1

Schedules reporting jobs containing your YouTube Analytics data and downloads the resulting bulk data reports in the form of CSV files.

Official API documentation: https://developers.google.com/youtube/reporting/v1/reports/

