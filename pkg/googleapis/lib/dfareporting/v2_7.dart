// This is a generated file (see the discoveryapis_generator project).

library googleapis.dfareporting.v2_7;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client dfareporting/v2.7';

/** Manages your DoubleClick Campaign Manager ad campaigns and reports. */
class DfareportingApi {
  /** Manage DoubleClick Digital Marketing conversions */
  static const DdmconversionsScope = "https://www.googleapis.com/auth/ddmconversions";

  /** View and manage DoubleClick for Advertisers reports */
  static const DfareportingScope = "https://www.googleapis.com/auth/dfareporting";

  /**
   * View and manage your DoubleClick Campaign Manager's (DCM) display ad
   * campaigns
   */
  static const DfatraffickingScope = "https://www.googleapis.com/auth/dfatrafficking";


  final commons.ApiRequester _requester;

  AccountActiveAdSummariesResourceApi get accountActiveAdSummaries => new AccountActiveAdSummariesResourceApi(_requester);
  AccountPermissionGroupsResourceApi get accountPermissionGroups => new AccountPermissionGroupsResourceApi(_requester);
  AccountPermissionsResourceApi get accountPermissions => new AccountPermissionsResourceApi(_requester);
  AccountUserProfilesResourceApi get accountUserProfiles => new AccountUserProfilesResourceApi(_requester);
  AccountsResourceApi get accounts => new AccountsResourceApi(_requester);
  AdsResourceApi get ads => new AdsResourceApi(_requester);
  AdvertiserGroupsResourceApi get advertiserGroups => new AdvertiserGroupsResourceApi(_requester);
  AdvertisersResourceApi get advertisers => new AdvertisersResourceApi(_requester);
  BrowsersResourceApi get browsers => new BrowsersResourceApi(_requester);
  CampaignCreativeAssociationsResourceApi get campaignCreativeAssociations => new CampaignCreativeAssociationsResourceApi(_requester);
  CampaignsResourceApi get campaigns => new CampaignsResourceApi(_requester);
  ChangeLogsResourceApi get changeLogs => new ChangeLogsResourceApi(_requester);
  CitiesResourceApi get cities => new CitiesResourceApi(_requester);
  ConnectionTypesResourceApi get connectionTypes => new ConnectionTypesResourceApi(_requester);
  ContentCategoriesResourceApi get contentCategories => new ContentCategoriesResourceApi(_requester);
  ConversionsResourceApi get conversions => new ConversionsResourceApi(_requester);
  CountriesResourceApi get countries => new CountriesResourceApi(_requester);
  CreativeAssetsResourceApi get creativeAssets => new CreativeAssetsResourceApi(_requester);
  CreativeFieldValuesResourceApi get creativeFieldValues => new CreativeFieldValuesResourceApi(_requester);
  CreativeFieldsResourceApi get creativeFields => new CreativeFieldsResourceApi(_requester);
  CreativeGroupsResourceApi get creativeGroups => new CreativeGroupsResourceApi(_requester);
  CreativesResourceApi get creatives => new CreativesResourceApi(_requester);
  DimensionValuesResourceApi get dimensionValues => new DimensionValuesResourceApi(_requester);
  DirectorySiteContactsResourceApi get directorySiteContacts => new DirectorySiteContactsResourceApi(_requester);
  DirectorySitesResourceApi get directorySites => new DirectorySitesResourceApi(_requester);
  DynamicTargetingKeysResourceApi get dynamicTargetingKeys => new DynamicTargetingKeysResourceApi(_requester);
  EventTagsResourceApi get eventTags => new EventTagsResourceApi(_requester);
  FilesResourceApi get files => new FilesResourceApi(_requester);
  FloodlightActivitiesResourceApi get floodlightActivities => new FloodlightActivitiesResourceApi(_requester);
  FloodlightActivityGroupsResourceApi get floodlightActivityGroups => new FloodlightActivityGroupsResourceApi(_requester);
  FloodlightConfigurationsResourceApi get floodlightConfigurations => new FloodlightConfigurationsResourceApi(_requester);
  InventoryItemsResourceApi get inventoryItems => new InventoryItemsResourceApi(_requester);
  LandingPagesResourceApi get landingPages => new LandingPagesResourceApi(_requester);
  LanguagesResourceApi get languages => new LanguagesResourceApi(_requester);
  MetrosResourceApi get metros => new MetrosResourceApi(_requester);
  MobileCarriersResourceApi get mobileCarriers => new MobileCarriersResourceApi(_requester);
  OperatingSystemVersionsResourceApi get operatingSystemVersions => new OperatingSystemVersionsResourceApi(_requester);
  OperatingSystemsResourceApi get operatingSystems => new OperatingSystemsResourceApi(_requester);
  OrderDocumentsResourceApi get orderDocuments => new OrderDocumentsResourceApi(_requester);
  OrdersResourceApi get orders => new OrdersResourceApi(_requester);
  PlacementGroupsResourceApi get placementGroups => new PlacementGroupsResourceApi(_requester);
  PlacementStrategiesResourceApi get placementStrategies => new PlacementStrategiesResourceApi(_requester);
  PlacementsResourceApi get placements => new PlacementsResourceApi(_requester);
  PlatformTypesResourceApi get platformTypes => new PlatformTypesResourceApi(_requester);
  PostalCodesResourceApi get postalCodes => new PostalCodesResourceApi(_requester);
  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);
  RegionsResourceApi get regions => new RegionsResourceApi(_requester);
  RemarketingListSharesResourceApi get remarketingListShares => new RemarketingListSharesResourceApi(_requester);
  RemarketingListsResourceApi get remarketingLists => new RemarketingListsResourceApi(_requester);
  ReportsResourceApi get reports => new ReportsResourceApi(_requester);
  SitesResourceApi get sites => new SitesResourceApi(_requester);
  SizesResourceApi get sizes => new SizesResourceApi(_requester);
  SubaccountsResourceApi get subaccounts => new SubaccountsResourceApi(_requester);
  TargetableRemarketingListsResourceApi get targetableRemarketingLists => new TargetableRemarketingListsResourceApi(_requester);
  TargetingTemplatesResourceApi get targetingTemplates => new TargetingTemplatesResourceApi(_requester);
  UserProfilesResourceApi get userProfiles => new UserProfilesResourceApi(_requester);
  UserRolePermissionGroupsResourceApi get userRolePermissionGroups => new UserRolePermissionGroupsResourceApi(_requester);
  UserRolePermissionsResourceApi get userRolePermissions => new UserRolePermissionsResourceApi(_requester);
  UserRolesResourceApi get userRoles => new UserRolesResourceApi(_requester);
  VideoFormatsResourceApi get videoFormats => new VideoFormatsResourceApi(_requester);

  DfareportingApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "dfareporting/v2.7/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AccountActiveAdSummariesResourceApi {
  final commons.ApiRequester _requester;

  AccountActiveAdSummariesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the account's active ad summary by account ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [summaryAccountId] - Account ID.
   *
   * Completes with a [AccountActiveAdSummary].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountActiveAdSummary> get(core.String profileId, core.String summaryAccountId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (summaryAccountId == null) {
      throw new core.ArgumentError("Parameter summaryAccountId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountActiveAdSummaries/' + commons.Escaper.ecapeVariable('$summaryAccountId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountActiveAdSummary.fromJson(data));
  }

}


class AccountPermissionGroupsResourceApi {
  final commons.ApiRequester _requester;

  AccountPermissionGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one account permission group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Account permission group ID.
   *
   * Completes with a [AccountPermissionGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountPermissionGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountPermissionGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountPermissionGroup.fromJson(data));
  }

  /**
   * Retrieves the list of account permission groups.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AccountPermissionGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountPermissionGroupsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountPermissionGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountPermissionGroupsListResponse.fromJson(data));
  }

}


class AccountPermissionsResourceApi {
  final commons.ApiRequester _requester;

  AccountPermissionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one account permission by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Account permission ID.
   *
   * Completes with a [AccountPermission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountPermission> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountPermissions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountPermission.fromJson(data));
  }

  /**
   * Retrieves the list of account permissions.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AccountPermissionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountPermissionsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountPermissions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountPermissionsListResponse.fromJson(data));
  }

}


class AccountUserProfilesResourceApi {
  final commons.ApiRequester _requester;

  AccountUserProfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one account user profile by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User profile ID.
   *
   * Completes with a [AccountUserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountUserProfile> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountUserProfiles/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountUserProfile.fromJson(data));
  }

  /**
   * Inserts a new account user profile.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AccountUserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountUserProfile> insert(AccountUserProfile request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountUserProfiles';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountUserProfile.fromJson(data));
  }

  /**
   * Retrieves a list of account user profiles, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [active] - Select only active user profiles.
   *
   * [ids] - Select only user profiles with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name, ID or email.
   * Wildcards (*) are allowed. For example, "user profile*2015" will return
   * objects with names like "user profile June 2015", "user profile April
   * 2015", or simply "user profile 2015". Most of the searches also add
   * wildcards implicitly at the start and the end of the search string. For
   * example, a search string of "user profile" will match objects with name "my
   * user profile", "user profile 2015", or simply "user profile".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [subaccountId] - Select only user profiles with the specified subaccount
   * ID.
   *
   * [userRoleId] - Select only user profiles with the specified user role ID.
   *
   * Completes with a [AccountUserProfilesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountUserProfilesListResponse> list(core.String profileId, {core.bool active, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String subaccountId, core.String userRoleId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (subaccountId != null) {
      _queryParams["subaccountId"] = [subaccountId];
    }
    if (userRoleId != null) {
      _queryParams["userRoleId"] = [userRoleId];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountUserProfiles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountUserProfilesListResponse.fromJson(data));
  }

  /**
   * Updates an existing account user profile. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User profile ID.
   *
   * Completes with a [AccountUserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountUserProfile> patch(AccountUserProfile request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountUserProfiles';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountUserProfile.fromJson(data));
  }

  /**
   * Updates an existing account user profile.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AccountUserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountUserProfile> update(AccountUserProfile request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accountUserProfiles';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountUserProfile.fromJson(data));
  }

}


class AccountsResourceApi {
  final commons.ApiRequester _requester;

  AccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one account by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Account ID.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accounts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /**
   * Retrieves the list of accounts, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [active] - Select only active accounts. Don't set this field to select both
   * active and non-active accounts.
   *
   * [ids] - Select only accounts with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "account*2015" will return objects with names
   * like "account June 2015", "account April 2015", or simply "account 2015".
   * Most of the searches also add wildcards implicitly at the start and the end
   * of the search string. For example, a search string of "account" will match
   * objects with name "my account", "account 2015", or simply "account".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [AccountsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AccountsListResponse> list(core.String profileId, {core.bool active, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AccountsListResponse.fromJson(data));
  }

  /**
   * Updates an existing account. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Account ID.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> patch(Account request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accounts';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

  /**
   * Updates an existing account.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Account].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Account> update(Account request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/accounts';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Account.fromJson(data));
  }

}


class AdsResourceApi {
  final commons.ApiRequester _requester;

  AdsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one ad by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Ad ID.
   *
   * Completes with a [Ad].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ad> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/ads/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Ad.fromJson(data));
  }

  /**
   * Inserts a new ad.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Ad].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ad> insert(Ad request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/ads';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Ad.fromJson(data));
  }

  /**
   * Retrieves a list of ads, possibly filtered. This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [active] - Select only active ads.
   *
   * [advertiserId] - Select only ads with this advertiser ID.
   *
   * [archived] - Select only archived ads.
   *
   * [audienceSegmentIds] - Select only ads with these audience segment IDs.
   *
   * [campaignIds] - Select only ads with these campaign IDs.
   *
   * [compatibility] - Select default ads with the specified compatibility.
   * Applicable when type is AD_SERVING_DEFAULT_AD. DISPLAY and
   * DISPLAY_INTERSTITIAL refer to rendering either on desktop or on mobile
   * devices for regular or interstitial ads, respectively. APP and
   * APP_INTERSTITIAL are for rendering in mobile apps. IN_STREAM_VIDEO refers
   * to rendering an in-stream video ads developed with the VAST standard.
   * Possible string values are:
   * - "APP"
   * - "APP_INTERSTITIAL"
   * - "DISPLAY"
   * - "DISPLAY_INTERSTITIAL"
   * - "IN_STREAM_VIDEO"
   *
   * [creativeIds] - Select only ads with these creative IDs assigned.
   *
   * [creativeOptimizationConfigurationIds] - Select only ads with these
   * creative optimization configuration IDs.
   *
   * [dynamicClickTracker] - Select only dynamic click trackers. Applicable when
   * type is AD_SERVING_CLICK_TRACKER. If true, select dynamic click trackers.
   * If false, select static click trackers. Leave unset to select both.
   *
   * [ids] - Select only ads with these IDs.
   *
   * [landingPageIds] - Select only ads with these landing page IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [overriddenEventTagId] - Select only ads with this event tag override ID.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [placementIds] - Select only ads with these placement IDs assigned.
   *
   * [remarketingListIds] - Select only ads whose list targeting expression use
   * these remarketing list IDs.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "ad*2015" will return objects with names like "ad
   * June 2015", "ad April 2015", or simply "ad 2015". Most of the searches also
   * add wildcards implicitly at the start and the end of the search string. For
   * example, a search string of "ad" will match objects with name "my ad", "ad
   * 2015", or simply "ad".
   *
   * [sizeIds] - Select only ads with these size IDs.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [sslCompliant] - Select only ads that are SSL-compliant.
   *
   * [sslRequired] - Select only ads that require SSL.
   *
   * [type] - Select only ads with these types.
   *
   * Completes with a [AdsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdsListResponse> list(core.String profileId, {core.bool active, core.String advertiserId, core.bool archived, core.List<core.String> audienceSegmentIds, core.List<core.String> campaignIds, core.String compatibility, core.List<core.String> creativeIds, core.List<core.String> creativeOptimizationConfigurationIds, core.bool dynamicClickTracker, core.List<core.String> ids, core.List<core.String> landingPageIds, core.int maxResults, core.String overriddenEventTagId, core.String pageToken, core.List<core.String> placementIds, core.List<core.String> remarketingListIds, core.String searchString, core.List<core.String> sizeIds, core.String sortField, core.String sortOrder, core.bool sslCompliant, core.bool sslRequired, core.List<core.String> type}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (archived != null) {
      _queryParams["archived"] = ["${archived}"];
    }
    if (audienceSegmentIds != null) {
      _queryParams["audienceSegmentIds"] = audienceSegmentIds;
    }
    if (campaignIds != null) {
      _queryParams["campaignIds"] = campaignIds;
    }
    if (compatibility != null) {
      _queryParams["compatibility"] = [compatibility];
    }
    if (creativeIds != null) {
      _queryParams["creativeIds"] = creativeIds;
    }
    if (creativeOptimizationConfigurationIds != null) {
      _queryParams["creativeOptimizationConfigurationIds"] = creativeOptimizationConfigurationIds;
    }
    if (dynamicClickTracker != null) {
      _queryParams["dynamicClickTracker"] = ["${dynamicClickTracker}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (landingPageIds != null) {
      _queryParams["landingPageIds"] = landingPageIds;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (overriddenEventTagId != null) {
      _queryParams["overriddenEventTagId"] = [overriddenEventTagId];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (placementIds != null) {
      _queryParams["placementIds"] = placementIds;
    }
    if (remarketingListIds != null) {
      _queryParams["remarketingListIds"] = remarketingListIds;
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sizeIds != null) {
      _queryParams["sizeIds"] = sizeIds;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (sslCompliant != null) {
      _queryParams["sslCompliant"] = ["${sslCompliant}"];
    }
    if (sslRequired != null) {
      _queryParams["sslRequired"] = ["${sslRequired}"];
    }
    if (type != null) {
      _queryParams["type"] = type;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/ads';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdsListResponse.fromJson(data));
  }

  /**
   * Updates an existing ad. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Ad ID.
   *
   * Completes with a [Ad].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ad> patch(Ad request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/ads';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Ad.fromJson(data));
  }

  /**
   * Updates an existing ad.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Ad].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Ad> update(Ad request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/ads';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Ad.fromJson(data));
  }

}


class AdvertiserGroupsResourceApi {
  final commons.ApiRequester _requester;

  AdvertiserGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing advertiser group.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Advertiser group ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one advertiser group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Advertiser group ID.
   *
   * Completes with a [AdvertiserGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertiserGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertiserGroup.fromJson(data));
  }

  /**
   * Inserts a new advertiser group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AdvertiserGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertiserGroup> insert(AdvertiserGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertiserGroup.fromJson(data));
  }

  /**
   * Retrieves a list of advertiser groups, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Select only advertiser groups with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "advertiser*2015" will return objects with names
   * like "advertiser group June 2015", "advertiser group April 2015", or simply
   * "advertiser group 2015". Most of the searches also add wildcards implicitly
   * at the start and the end of the search string. For example, a search string
   * of "advertisergroup" will match objects with name "my advertisergroup",
   * "advertisergroup 2015", or simply "advertisergroup".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [AdvertiserGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertiserGroupsListResponse> list(core.String profileId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertiserGroupsListResponse.fromJson(data));
  }

  /**
   * Updates an existing advertiser group. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Advertiser group ID.
   *
   * Completes with a [AdvertiserGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertiserGroup> patch(AdvertiserGroup request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertiserGroup.fromJson(data));
  }

  /**
   * Updates an existing advertiser group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [AdvertiserGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertiserGroup> update(AdvertiserGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertiserGroups';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertiserGroup.fromJson(data));
  }

}


class AdvertisersResourceApi {
  final commons.ApiRequester _requester;

  AdvertisersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one advertiser by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Advertiser ID.
   *
   * Completes with a [Advertiser].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Advertiser> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertisers/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Advertiser.fromJson(data));
  }

  /**
   * Inserts a new advertiser.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Advertiser].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Advertiser> insert(Advertiser request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertisers';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Advertiser.fromJson(data));
  }

  /**
   * Retrieves a list of advertisers, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserGroupIds] - Select only advertisers with these advertiser group
   * IDs.
   *
   * [floodlightConfigurationIds] - Select only advertisers with these
   * floodlight configuration IDs.
   *
   * [ids] - Select only advertisers with these IDs.
   *
   * [includeAdvertisersWithoutGroupsOnly] - Select only advertisers which do
   * not belong to any advertiser group.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [onlyParent] - Select only advertisers which use another advertiser's
   * floodlight configuration.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "advertiser*2015" will return objects with names
   * like "advertiser June 2015", "advertiser April 2015", or simply "advertiser
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "advertiser"
   * will match objects with name "my advertiser", "advertiser 2015", or simply
   * "advertiser".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [status] - Select only advertisers with the specified status.
   * Possible string values are:
   * - "APPROVED"
   * - "ON_HOLD"
   *
   * [subaccountId] - Select only advertisers with these subaccount IDs.
   *
   * Completes with a [AdvertisersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AdvertisersListResponse> list(core.String profileId, {core.List<core.String> advertiserGroupIds, core.List<core.String> floodlightConfigurationIds, core.List<core.String> ids, core.bool includeAdvertisersWithoutGroupsOnly, core.int maxResults, core.bool onlyParent, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String status, core.String subaccountId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserGroupIds != null) {
      _queryParams["advertiserGroupIds"] = advertiserGroupIds;
    }
    if (floodlightConfigurationIds != null) {
      _queryParams["floodlightConfigurationIds"] = floodlightConfigurationIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (includeAdvertisersWithoutGroupsOnly != null) {
      _queryParams["includeAdvertisersWithoutGroupsOnly"] = ["${includeAdvertisersWithoutGroupsOnly}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (onlyParent != null) {
      _queryParams["onlyParent"] = ["${onlyParent}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (status != null) {
      _queryParams["status"] = [status];
    }
    if (subaccountId != null) {
      _queryParams["subaccountId"] = [subaccountId];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertisers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AdvertisersListResponse.fromJson(data));
  }

  /**
   * Updates an existing advertiser. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Advertiser ID.
   *
   * Completes with a [Advertiser].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Advertiser> patch(Advertiser request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertisers';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Advertiser.fromJson(data));
  }

  /**
   * Updates an existing advertiser.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Advertiser].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Advertiser> update(Advertiser request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/advertisers';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Advertiser.fromJson(data));
  }

}


class BrowsersResourceApi {
  final commons.ApiRequester _requester;

  BrowsersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of browsers.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [BrowsersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BrowsersListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/browsers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BrowsersListResponse.fromJson(data));
  }

}


class CampaignCreativeAssociationsResourceApi {
  final commons.ApiRequester _requester;

  CampaignCreativeAssociationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Associates a creative with the specified campaign. This method creates a
   * default ad with dimensions matching the creative in the campaign if such a
   * default ad does not exist already.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Campaign ID in this association.
   *
   * Completes with a [CampaignCreativeAssociation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CampaignCreativeAssociation> insert(CampaignCreativeAssociation request, core.String profileId, core.String campaignId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/campaignCreativeAssociations';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CampaignCreativeAssociation.fromJson(data));
  }

  /**
   * Retrieves the list of creative IDs associated with the specified campaign.
   * This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Campaign ID in this association.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [CampaignCreativeAssociationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CampaignCreativeAssociationsListResponse> list(core.String profileId, core.String campaignId, {core.int maxResults, core.String pageToken, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/campaignCreativeAssociations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CampaignCreativeAssociationsListResponse.fromJson(data));
  }

}


class CampaignsResourceApi {
  final commons.ApiRequester _requester;

  CampaignsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one campaign by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Campaign ID.
   *
   * Completes with a [Campaign].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Campaign> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Campaign.fromJson(data));
  }

  /**
   * Inserts a new campaign.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [defaultLandingPageName] - Default landing page name for this new campaign.
   * Must be less than 256 characters long.
   *
   * [defaultLandingPageUrl] - Default landing page URL for this new campaign.
   *
   * Completes with a [Campaign].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Campaign> insert(Campaign request, core.String profileId, core.String defaultLandingPageName, core.String defaultLandingPageUrl) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (defaultLandingPageName == null) {
      throw new core.ArgumentError("Parameter defaultLandingPageName is required.");
    }
    _queryParams["defaultLandingPageName"] = [defaultLandingPageName];
    if (defaultLandingPageUrl == null) {
      throw new core.ArgumentError("Parameter defaultLandingPageUrl is required.");
    }
    _queryParams["defaultLandingPageUrl"] = [defaultLandingPageUrl];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Campaign.fromJson(data));
  }

  /**
   * Retrieves a list of campaigns, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserGroupIds] - Select only campaigns whose advertisers belong to
   * these advertiser groups.
   *
   * [advertiserIds] - Select only campaigns that belong to these advertisers.
   *
   * [archived] - Select only archived campaigns. Don't set this field to select
   * both archived and non-archived campaigns.
   *
   * [atLeastOneOptimizationActivity] - Select only campaigns that have at least
   * one optimization activity.
   *
   * [excludedIds] - Exclude campaigns with these IDs.
   *
   * [ids] - Select only campaigns with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [overriddenEventTagId] - Select only campaigns that have overridden this
   * event tag ID.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for campaigns by name or ID. Wildcards
   * (*) are allowed. For example, "campaign*2015" will return campaigns with
   * names like "campaign June 2015", "campaign April 2015", or simply "campaign
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "campaign"
   * will match campaigns with name "my campaign", "campaign 2015", or simply
   * "campaign".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [subaccountId] - Select only campaigns that belong to this subaccount.
   *
   * Completes with a [CampaignsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CampaignsListResponse> list(core.String profileId, {core.List<core.String> advertiserGroupIds, core.List<core.String> advertiserIds, core.bool archived, core.bool atLeastOneOptimizationActivity, core.List<core.String> excludedIds, core.List<core.String> ids, core.int maxResults, core.String overriddenEventTagId, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String subaccountId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserGroupIds != null) {
      _queryParams["advertiserGroupIds"] = advertiserGroupIds;
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (archived != null) {
      _queryParams["archived"] = ["${archived}"];
    }
    if (atLeastOneOptimizationActivity != null) {
      _queryParams["atLeastOneOptimizationActivity"] = ["${atLeastOneOptimizationActivity}"];
    }
    if (excludedIds != null) {
      _queryParams["excludedIds"] = excludedIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (overriddenEventTagId != null) {
      _queryParams["overriddenEventTagId"] = [overriddenEventTagId];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (subaccountId != null) {
      _queryParams["subaccountId"] = [subaccountId];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CampaignsListResponse.fromJson(data));
  }

  /**
   * Updates an existing campaign. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Campaign ID.
   *
   * Completes with a [Campaign].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Campaign> patch(Campaign request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Campaign.fromJson(data));
  }

  /**
   * Updates an existing campaign.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Campaign].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Campaign> update(Campaign request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Campaign.fromJson(data));
  }

}


class ChangeLogsResourceApi {
  final commons.ApiRequester _requester;

  ChangeLogsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one change log by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Change log ID.
   *
   * Completes with a [ChangeLog].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChangeLog> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/changeLogs/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChangeLog.fromJson(data));
  }

  /**
   * Retrieves a list of change logs. This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [action] - Select only change logs with the specified action.
   * Possible string values are:
   * - "ACTION_ADD"
   * - "ACTION_ASSIGN"
   * - "ACTION_ASSOCIATE"
   * - "ACTION_CREATE"
   * - "ACTION_DELETE"
   * - "ACTION_DISABLE"
   * - "ACTION_EMAIL_TAGS"
   * - "ACTION_ENABLE"
   * - "ACTION_LINK"
   * - "ACTION_MARK_AS_DEFAULT"
   * - "ACTION_PUSH"
   * - "ACTION_REMOVE"
   * - "ACTION_SEND"
   * - "ACTION_SHARE"
   * - "ACTION_UNASSIGN"
   * - "ACTION_UNLINK"
   * - "ACTION_UPDATE"
   *
   * [ids] - Select only change logs with these IDs.
   *
   * [maxChangeTime] - Select only change logs whose change time is before the
   * specified maxChangeTime.The time should be formatted as an RFC3339
   * date/time string. For example, for 10:54 PM on July 18th, 2015, in the
   * America/New York time zone, the format is "2015-07-18T22:54:00-04:00". In
   * other words, the year, month, day, the letter T, the hour (24-hour clock
   * system), minute, second, and then the time zone offset.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [minChangeTime] - Select only change logs whose change time is before the
   * specified minChangeTime.The time should be formatted as an RFC3339
   * date/time string. For example, for 10:54 PM on July 18th, 2015, in the
   * America/New York time zone, the format is "2015-07-18T22:54:00-04:00". In
   * other words, the year, month, day, the letter T, the hour (24-hour clock
   * system), minute, second, and then the time zone offset.
   *
   * [objectIds] - Select only change logs with these object IDs.
   *
   * [objectType] - Select only change logs with the specified object type.
   * Possible string values are:
   * - "OBJECT_ACCOUNT"
   * - "OBJECT_ACCOUNT_BILLING_FEATURE"
   * - "OBJECT_AD"
   * - "OBJECT_ADVERTISER"
   * - "OBJECT_ADVERTISER_GROUP"
   * - "OBJECT_BILLING_ACCOUNT_GROUP"
   * - "OBJECT_BILLING_FEATURE"
   * - "OBJECT_BILLING_MINIMUM_FEE"
   * - "OBJECT_BILLING_PROFILE"
   * - "OBJECT_CAMPAIGN"
   * - "OBJECT_CONTENT_CATEGORY"
   * - "OBJECT_CREATIVE"
   * - "OBJECT_CREATIVE_ASSET"
   * - "OBJECT_CREATIVE_BUNDLE"
   * - "OBJECT_CREATIVE_FIELD"
   * - "OBJECT_CREATIVE_GROUP"
   * - "OBJECT_DFA_SITE"
   * - "OBJECT_EVENT_TAG"
   * - "OBJECT_FLOODLIGHT_ACTIVITY_GROUP"
   * - "OBJECT_FLOODLIGHT_ACTVITY"
   * - "OBJECT_FLOODLIGHT_CONFIGURATION"
   * - "OBJECT_INSTREAM_CREATIVE"
   * - "OBJECT_LANDING_PAGE"
   * - "OBJECT_MEDIA_ORDER"
   * - "OBJECT_PLACEMENT"
   * - "OBJECT_PLACEMENT_STRATEGY"
   * - "OBJECT_PLAYSTORE_LINK"
   * - "OBJECT_PROVIDED_LIST_CLIENT"
   * - "OBJECT_RATE_CARD"
   * - "OBJECT_REMARKETING_LIST"
   * - "OBJECT_RICHMEDIA_CREATIVE"
   * - "OBJECT_SD_SITE"
   * - "OBJECT_SEARCH_LIFT_STUDY"
   * - "OBJECT_SIZE"
   * - "OBJECT_SUBACCOUNT"
   * - "OBJECT_TARGETING_TEMPLATE"
   * - "OBJECT_USER_PROFILE"
   * - "OBJECT_USER_PROFILE_FILTER"
   * - "OBJECT_USER_ROLE"
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Select only change logs whose object ID, user name, old or
   * new values match the search string.
   *
   * [userProfileIds] - Select only change logs with these user profile IDs.
   *
   * Completes with a [ChangeLogsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChangeLogsListResponse> list(core.String profileId, {core.String action, core.List<core.String> ids, core.String maxChangeTime, core.int maxResults, core.String minChangeTime, core.List<core.String> objectIds, core.String objectType, core.String pageToken, core.String searchString, core.List<core.String> userProfileIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (action != null) {
      _queryParams["action"] = [action];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxChangeTime != null) {
      _queryParams["maxChangeTime"] = [maxChangeTime];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (minChangeTime != null) {
      _queryParams["minChangeTime"] = [minChangeTime];
    }
    if (objectIds != null) {
      _queryParams["objectIds"] = objectIds;
    }
    if (objectType != null) {
      _queryParams["objectType"] = [objectType];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (userProfileIds != null) {
      _queryParams["userProfileIds"] = userProfileIds;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/changeLogs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChangeLogsListResponse.fromJson(data));
  }

}


class CitiesResourceApi {
  final commons.ApiRequester _requester;

  CitiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of cities, possibly filtered.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [countryDartIds] - Select only cities from these countries.
   *
   * [dartIds] - Select only cities with these DART IDs.
   *
   * [namePrefix] - Select only cities with names starting with this prefix.
   *
   * [regionDartIds] - Select only cities from these regions.
   *
   * Completes with a [CitiesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CitiesListResponse> list(core.String profileId, {core.List<core.String> countryDartIds, core.List<core.String> dartIds, core.String namePrefix, core.List<core.String> regionDartIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (countryDartIds != null) {
      _queryParams["countryDartIds"] = countryDartIds;
    }
    if (dartIds != null) {
      _queryParams["dartIds"] = dartIds;
    }
    if (namePrefix != null) {
      _queryParams["namePrefix"] = [namePrefix];
    }
    if (regionDartIds != null) {
      _queryParams["regionDartIds"] = regionDartIds;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/cities';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CitiesListResponse.fromJson(data));
  }

}


class ConnectionTypesResourceApi {
  final commons.ApiRequester _requester;

  ConnectionTypesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one connection type by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Connection type ID.
   *
   * Completes with a [ConnectionType].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConnectionType> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/connectionTypes/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConnectionType.fromJson(data));
  }

  /**
   * Retrieves a list of connection types.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [ConnectionTypesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConnectionTypesListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/connectionTypes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConnectionTypesListResponse.fromJson(data));
  }

}


class ContentCategoriesResourceApi {
  final commons.ApiRequester _requester;

  ContentCategoriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing content category.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Content category ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one content category by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Content category ID.
   *
   * Completes with a [ContentCategory].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContentCategory> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContentCategory.fromJson(data));
  }

  /**
   * Inserts a new content category.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [ContentCategory].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContentCategory> insert(ContentCategory request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContentCategory.fromJson(data));
  }

  /**
   * Retrieves a list of content categories, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Select only content categories with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "contentcategory*2015" will return objects with
   * names like "contentcategory June 2015", "contentcategory April 2015", or
   * simply "contentcategory 2015". Most of the searches also add wildcards
   * implicitly at the start and the end of the search string. For example, a
   * search string of "contentcategory" will match objects with name "my
   * contentcategory", "contentcategory 2015", or simply "contentcategory".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [ContentCategoriesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContentCategoriesListResponse> list(core.String profileId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContentCategoriesListResponse.fromJson(data));
  }

  /**
   * Updates an existing content category. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Content category ID.
   *
   * Completes with a [ContentCategory].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContentCategory> patch(ContentCategory request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContentCategory.fromJson(data));
  }

  /**
   * Updates an existing content category.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [ContentCategory].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ContentCategory> update(ContentCategory request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/contentCategories';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ContentCategory.fromJson(data));
  }

}


class ConversionsResourceApi {
  final commons.ApiRequester _requester;

  ConversionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Inserts conversions.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [ConversionsBatchInsertResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ConversionsBatchInsertResponse> batchinsert(ConversionsBatchInsertRequest request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/conversions/batchinsert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ConversionsBatchInsertResponse.fromJson(data));
  }

}


class CountriesResourceApi {
  final commons.ApiRequester _requester;

  CountriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one country by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [dartId] - Country DART ID.
   *
   * Completes with a [Country].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Country> get(core.String profileId, core.String dartId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (dartId == null) {
      throw new core.ArgumentError("Parameter dartId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/countries/' + commons.Escaper.ecapeVariable('$dartId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Country.fromJson(data));
  }

  /**
   * Retrieves a list of countries.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [CountriesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CountriesListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/countries';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CountriesListResponse.fromJson(data));
  }

}


class CreativeAssetsResourceApi {
  final commons.ApiRequester _requester;

  CreativeAssetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Inserts a new creative asset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Advertiser ID of this creative. This is a required field.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [CreativeAssetMetadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeAssetMetadata> insert(CreativeAssetMetadata request, core.String profileId, core.String advertiserId, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeAssets/' + commons.Escaper.ecapeVariable('$advertiserId') + '/creativeAssets';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/dfareporting/v2.7/userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeAssets/' + commons.Escaper.ecapeVariable('$advertiserId') + '/creativeAssets';
    } else {
      _url = '/upload/dfareporting/v2.7/userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeAssets/' + commons.Escaper.ecapeVariable('$advertiserId') + '/creativeAssets';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeAssetMetadata.fromJson(data));
  }

}


class CreativeFieldValuesResourceApi {
  final commons.ApiRequester _requester;

  CreativeFieldValuesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing creative field value.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * [id] - Creative Field Value ID
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String creativeFieldId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one creative field value by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * [id] - Creative Field Value ID
   *
   * Completes with a [CreativeFieldValue].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldValue> get(core.String profileId, core.String creativeFieldId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldValue.fromJson(data));
  }

  /**
   * Inserts a new creative field value.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * Completes with a [CreativeFieldValue].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldValue> insert(CreativeFieldValue request, core.String profileId, core.String creativeFieldId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldValue.fromJson(data));
  }

  /**
   * Retrieves a list of creative field values, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * [ids] - Select only creative field values with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for creative field values by their
   * values. Wildcards (e.g. *) are not allowed.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "VALUE"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [CreativeFieldValuesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldValuesListResponse> list(core.String profileId, core.String creativeFieldId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldValuesListResponse.fromJson(data));
  }

  /**
   * Updates an existing creative field value. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * [id] - Creative Field Value ID
   *
   * Completes with a [CreativeFieldValue].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldValue> patch(CreativeFieldValue request, core.String profileId, core.String creativeFieldId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldValue.fromJson(data));
  }

  /**
   * Updates an existing creative field value.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [creativeFieldId] - Creative field ID for this creative field value.
   *
   * Completes with a [CreativeFieldValue].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldValue> update(CreativeFieldValue request, core.String profileId, core.String creativeFieldId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (creativeFieldId == null) {
      throw new core.ArgumentError("Parameter creativeFieldId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$creativeFieldId') + '/creativeFieldValues';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldValue.fromJson(data));
  }

}


class CreativeFieldsResourceApi {
  final commons.ApiRequester _requester;

  CreativeFieldsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing creative field.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative Field ID
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one creative field by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative Field ID
   *
   * Completes with a [CreativeField].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeField> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeField.fromJson(data));
  }

  /**
   * Inserts a new creative field.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [CreativeField].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeField> insert(CreativeField request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeField.fromJson(data));
  }

  /**
   * Retrieves a list of creative fields, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserIds] - Select only creative fields that belong to these
   * advertisers.
   *
   * [ids] - Select only creative fields with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for creative fields by name or ID.
   * Wildcards (*) are allowed. For example, "creativefield*2015" will return
   * creative fields with names like "creativefield June 2015", "creativefield
   * April 2015", or simply "creativefield 2015". Most of the searches also add
   * wild-cards implicitly at the start and the end of the search string. For
   * example, a search string of "creativefield" will match creative fields with
   * the name "my creativefield", "creativefield 2015", or simply
   * "creativefield".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [CreativeFieldsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeFieldsListResponse> list(core.String profileId, {core.List<core.String> advertiserIds, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeFieldsListResponse.fromJson(data));
  }

  /**
   * Updates an existing creative field. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative Field ID
   *
   * Completes with a [CreativeField].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeField> patch(CreativeField request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeField.fromJson(data));
  }

  /**
   * Updates an existing creative field.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [CreativeField].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeField> update(CreativeField request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeFields';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeField.fromJson(data));
  }

}


class CreativeGroupsResourceApi {
  final commons.ApiRequester _requester;

  CreativeGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one creative group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative group ID.
   *
   * Completes with a [CreativeGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeGroup.fromJson(data));
  }

  /**
   * Inserts a new creative group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [CreativeGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeGroup> insert(CreativeGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeGroups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeGroup.fromJson(data));
  }

  /**
   * Retrieves a list of creative groups, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserIds] - Select only creative groups that belong to these
   * advertisers.
   *
   * [groupNumber] - Select only creative groups that belong to this subgroup.
   *
   * [ids] - Select only creative groups with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for creative groups by name or ID.
   * Wildcards (*) are allowed. For example, "creativegroup*2015" will return
   * creative groups with names like "creativegroup June 2015", "creativegroup
   * April 2015", or simply "creativegroup 2015". Most of the searches also add
   * wild-cards implicitly at the start and the end of the search string. For
   * example, a search string of "creativegroup" will match creative groups with
   * the name "my creativegroup", "creativegroup 2015", or simply
   * "creativegroup".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [CreativeGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeGroupsListResponse> list(core.String profileId, {core.List<core.String> advertiserIds, core.int groupNumber, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (groupNumber != null) {
      _queryParams["groupNumber"] = ["${groupNumber}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeGroupsListResponse.fromJson(data));
  }

  /**
   * Updates an existing creative group. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative group ID.
   *
   * Completes with a [CreativeGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeGroup> patch(CreativeGroup request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeGroups';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeGroup.fromJson(data));
  }

  /**
   * Updates an existing creative group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [CreativeGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativeGroup> update(CreativeGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creativeGroups';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativeGroup.fromJson(data));
  }

}


class CreativesResourceApi {
  final commons.ApiRequester _requester;

  CreativesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one creative by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative ID.
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creatives/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /**
   * Inserts a new creative.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> insert(Creative request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creatives';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /**
   * Retrieves a list of creatives, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [active] - Select only active creatives. Leave blank to select active and
   * inactive creatives.
   *
   * [advertiserId] - Select only creatives with this advertiser ID.
   *
   * [archived] - Select only archived creatives. Leave blank to select archived
   * and unarchived creatives.
   *
   * [campaignId] - Select only creatives with this campaign ID.
   *
   * [companionCreativeIds] - Select only in-stream video creatives with these
   * companion IDs.
   *
   * [creativeFieldIds] - Select only creatives with these creative field IDs.
   *
   * [ids] - Select only creatives with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [renderingIds] - Select only creatives with these rendering IDs.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "creative*2015" will return objects with names
   * like "creative June 2015", "creative April 2015", or simply "creative
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "creative"
   * will match objects with name "my creative", "creative 2015", or simply
   * "creative".
   *
   * [sizeIds] - Select only creatives with these size IDs.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [studioCreativeId] - Select only creatives corresponding to this Studio
   * creative ID.
   *
   * [types] - Select only creatives with these creative types.
   *
   * Completes with a [CreativesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CreativesListResponse> list(core.String profileId, {core.bool active, core.String advertiserId, core.bool archived, core.String campaignId, core.List<core.String> companionCreativeIds, core.List<core.String> creativeFieldIds, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.List<core.String> renderingIds, core.String searchString, core.List<core.String> sizeIds, core.String sortField, core.String sortOrder, core.String studioCreativeId, core.List<core.String> types}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (archived != null) {
      _queryParams["archived"] = ["${archived}"];
    }
    if (campaignId != null) {
      _queryParams["campaignId"] = [campaignId];
    }
    if (companionCreativeIds != null) {
      _queryParams["companionCreativeIds"] = companionCreativeIds;
    }
    if (creativeFieldIds != null) {
      _queryParams["creativeFieldIds"] = creativeFieldIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (renderingIds != null) {
      _queryParams["renderingIds"] = renderingIds;
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sizeIds != null) {
      _queryParams["sizeIds"] = sizeIds;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (studioCreativeId != null) {
      _queryParams["studioCreativeId"] = [studioCreativeId];
    }
    if (types != null) {
      _queryParams["types"] = types;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creatives';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CreativesListResponse.fromJson(data));
  }

  /**
   * Updates an existing creative. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Creative ID.
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> patch(Creative request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creatives';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

  /**
   * Updates an existing creative.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Creative].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Creative> update(Creative request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/creatives';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Creative.fromJson(data));
  }

}


class DimensionValuesResourceApi {
  final commons.ApiRequester _requester;

  DimensionValuesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves list of report dimension values for a list of filters.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "100".
   *
   * [pageToken] - The value of the nextToken from the previous result page.
   *
   * Completes with a [DimensionValueList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DimensionValueList> query(DimensionValueRequest request, core.String profileId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/dimensionvalues/query';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DimensionValueList.fromJson(data));
  }

}


class DirectorySiteContactsResourceApi {
  final commons.ApiRequester _requester;

  DirectorySiteContactsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one directory site contact by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Directory site contact ID.
   *
   * Completes with a [DirectorySiteContact].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectorySiteContact> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/directorySiteContacts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectorySiteContact.fromJson(data));
  }

  /**
   * Retrieves a list of directory site contacts, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [directorySiteIds] - Select only directory site contacts with these
   * directory site IDs. This is a required field.
   *
   * [ids] - Select only directory site contacts with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name, ID or email.
   * Wildcards (*) are allowed. For example, "directory site contact*2015" will
   * return objects with names like "directory site contact June 2015",
   * "directory site contact April 2015", or simply "directory site contact
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "directory
   * site contact" will match objects with name "my directory site contact",
   * "directory site contact 2015", or simply "directory site contact".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [DirectorySiteContactsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectorySiteContactsListResponse> list(core.String profileId, {core.List<core.String> directorySiteIds, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (directorySiteIds != null) {
      _queryParams["directorySiteIds"] = directorySiteIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/directorySiteContacts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectorySiteContactsListResponse.fromJson(data));
  }

}


class DirectorySitesResourceApi {
  final commons.ApiRequester _requester;

  DirectorySitesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one directory site by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Directory site ID.
   *
   * Completes with a [DirectorySite].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectorySite> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/directorySites/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectorySite.fromJson(data));
  }

  /**
   * Inserts a new directory site.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [DirectorySite].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectorySite> insert(DirectorySite request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/directorySites';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectorySite.fromJson(data));
  }

  /**
   * Retrieves a list of directory sites, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [acceptsInStreamVideoPlacements] - This search filter is no longer
   * supported and will have no effect on the results returned.
   *
   * [acceptsInterstitialPlacements] - This search filter is no longer supported
   * and will have no effect on the results returned.
   *
   * [acceptsPublisherPaidPlacements] - Select only directory sites that accept
   * publisher paid placements. This field can be left blank.
   *
   * [active] - Select only active directory sites. Leave blank to retrieve both
   * active and inactive directory sites.
   *
   * [countryId] - Select only directory sites with this country ID.
   *
   * [dfpNetworkCode] - Select only directory sites with this DFP network code.
   *
   * [ids] - Select only directory sites with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [parentId] - Select only directory sites with this parent ID.
   *
   * [searchString] - Allows searching for objects by name, ID or URL. Wildcards
   * (*) are allowed. For example, "directory site*2015" will return objects
   * with names like "directory site June 2015", "directory site April 2015", or
   * simply "directory site 2015". Most of the searches also add wildcards
   * implicitly at the start and the end of the search string. For example, a
   * search string of "directory site" will match objects with name "my
   * directory site", "directory site 2015" or simply, "directory site".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [DirectorySitesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectorySitesListResponse> list(core.String profileId, {core.bool acceptsInStreamVideoPlacements, core.bool acceptsInterstitialPlacements, core.bool acceptsPublisherPaidPlacements, core.bool active, core.String countryId, core.String dfpNetworkCode, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String parentId, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (acceptsInStreamVideoPlacements != null) {
      _queryParams["acceptsInStreamVideoPlacements"] = ["${acceptsInStreamVideoPlacements}"];
    }
    if (acceptsInterstitialPlacements != null) {
      _queryParams["acceptsInterstitialPlacements"] = ["${acceptsInterstitialPlacements}"];
    }
    if (acceptsPublisherPaidPlacements != null) {
      _queryParams["acceptsPublisherPaidPlacements"] = ["${acceptsPublisherPaidPlacements}"];
    }
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (countryId != null) {
      _queryParams["countryId"] = [countryId];
    }
    if (dfpNetworkCode != null) {
      _queryParams["dfp_network_code"] = [dfpNetworkCode];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (parentId != null) {
      _queryParams["parentId"] = [parentId];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/directorySites';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectorySitesListResponse.fromJson(data));
  }

}


class DynamicTargetingKeysResourceApi {
  final commons.ApiRequester _requester;

  DynamicTargetingKeysResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing dynamic targeting key.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [objectId] - ID of the object of this dynamic targeting key. This is a
   * required field.
   *
   * [name] - Name of this dynamic targeting key. This is a required field. Must
   * be less than 256 characters long and cannot contain commas. All characters
   * are converted to lowercase.
   *
   * [objectType] - Type of the object of this dynamic targeting key. This is a
   * required field.
   * Possible string values are:
   * - "OBJECT_AD"
   * - "OBJECT_ADVERTISER"
   * - "OBJECT_CREATIVE"
   * - "OBJECT_PLACEMENT"
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String objectId, core.String name, core.String objectType) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (objectId == null) {
      throw new core.ArgumentError("Parameter objectId is required.");
    }
    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    _queryParams["name"] = [name];
    if (objectType == null) {
      throw new core.ArgumentError("Parameter objectType is required.");
    }
    _queryParams["objectType"] = [objectType];

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/dynamicTargetingKeys/' + commons.Escaper.ecapeVariable('$objectId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Inserts a new dynamic targeting key. Keys must be created at the advertiser
   * level before being assigned to the advertiser's ads, creatives, or
   * placements. There is a maximum of 1000 keys per advertiser, out of which a
   * maximum of 20 keys can be assigned per ad, creative, or placement.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [DynamicTargetingKey].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DynamicTargetingKey> insert(DynamicTargetingKey request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/dynamicTargetingKeys';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DynamicTargetingKey.fromJson(data));
  }

  /**
   * Retrieves a list of dynamic targeting keys.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only dynamic targeting keys whose object has this
   * advertiser ID.
   *
   * [names] - Select only dynamic targeting keys exactly matching these names.
   *
   * [objectId] - Select only dynamic targeting keys with this object ID.
   *
   * [objectType] - Select only dynamic targeting keys with this object type.
   * Possible string values are:
   * - "OBJECT_AD"
   * - "OBJECT_ADVERTISER"
   * - "OBJECT_CREATIVE"
   * - "OBJECT_PLACEMENT"
   *
   * Completes with a [DynamicTargetingKeysListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DynamicTargetingKeysListResponse> list(core.String profileId, {core.String advertiserId, core.List<core.String> names, core.String objectId, core.String objectType}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (names != null) {
      _queryParams["names"] = names;
    }
    if (objectId != null) {
      _queryParams["objectId"] = [objectId];
    }
    if (objectType != null) {
      _queryParams["objectType"] = [objectType];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/dynamicTargetingKeys';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DynamicTargetingKeysListResponse.fromJson(data));
  }

}


class EventTagsResourceApi {
  final commons.ApiRequester _requester;

  EventTagsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing event tag.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Event tag ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one event tag by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Event tag ID.
   *
   * Completes with a [EventTag].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventTag> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventTag.fromJson(data));
  }

  /**
   * Inserts a new event tag.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [EventTag].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventTag> insert(EventTag request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventTag.fromJson(data));
  }

  /**
   * Retrieves a list of event tags, possibly filtered.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [adId] - Select only event tags that belong to this ad.
   *
   * [advertiserId] - Select only event tags that belong to this advertiser.
   *
   * [campaignId] - Select only event tags that belong to this campaign.
   *
   * [definitionsOnly] - Examine only the specified campaign or advertiser's
   * event tags for matching selector criteria. When set to false, the parent
   * advertiser and parent campaign of the specified ad or campaign is examined
   * as well. In addition, when set to false, the status field is examined as
   * well, along with the enabledByDefault field. This parameter can not be set
   * to true when adId is specified as ads do not define their own even tags.
   *
   * [enabled] - Select only enabled event tags. What is considered enabled or
   * disabled depends on the definitionsOnly parameter. When definitionsOnly is
   * set to true, only the specified advertiser or campaign's event tags'
   * enabledByDefault field is examined. When definitionsOnly is set to false,
   * the specified ad or specified campaign's parent advertiser's or parent
   * campaign's event tags' enabledByDefault and status fields are examined as
   * well.
   *
   * [eventTagTypes] - Select only event tags with the specified event tag
   * types. Event tag types can be used to specify whether to use a third-party
   * pixel, a third-party JavaScript URL, or a third-party click-through URL for
   * either impression or click tracking.
   *
   * [ids] - Select only event tags with these IDs.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "eventtag*2015" will return objects with names
   * like "eventtag June 2015", "eventtag April 2015", or simply "eventtag
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "eventtag"
   * will match objects with name "my eventtag", "eventtag 2015", or simply
   * "eventtag".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [EventTagsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventTagsListResponse> list(core.String profileId, {core.String adId, core.String advertiserId, core.String campaignId, core.bool definitionsOnly, core.bool enabled, core.List<core.String> eventTagTypes, core.List<core.String> ids, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (adId != null) {
      _queryParams["adId"] = [adId];
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (campaignId != null) {
      _queryParams["campaignId"] = [campaignId];
    }
    if (definitionsOnly != null) {
      _queryParams["definitionsOnly"] = ["${definitionsOnly}"];
    }
    if (enabled != null) {
      _queryParams["enabled"] = ["${enabled}"];
    }
    if (eventTagTypes != null) {
      _queryParams["eventTagTypes"] = eventTagTypes;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventTagsListResponse.fromJson(data));
  }

  /**
   * Updates an existing event tag. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Event tag ID.
   *
   * Completes with a [EventTag].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventTag> patch(EventTag request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventTag.fromJson(data));
  }

  /**
   * Updates an existing event tag.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [EventTag].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<EventTag> update(EventTag request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/eventTags';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new EventTag.fromJson(data));
  }

}


class FilesResourceApi {
  final commons.ApiRequester _requester;

  FilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a report file by its report ID and file ID.
   *
   * Request parameters:
   *
   * [reportId] - The ID of the report.
   *
   * [fileId] - The ID of the report file.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [File] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String reportId, core.String fileId, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _downloadOptions = downloadOptions;

    _url = 'reports/' + commons.Escaper.ecapeVariable('$reportId') + '/files/' + commons.Escaper.ecapeVariable('$fileId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new File.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Lists files for a user profile.
   *
   * Request parameters:
   *
   * [profileId] - The DFA profile ID.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "10".
   *
   * [pageToken] - The value of the nextToken from the previous result page.
   *
   * [scope] - The scope that defines which results are returned, default is
   * 'MINE'.
   * Possible string values are:
   * - "ALL" : All files in account.
   * - "MINE" : My files.
   * - "SHARED_WITH_ME" : Files shared with me.
   *
   * [sortField] - The field by which to sort the list.
   * Possible string values are:
   * - "ID" : Sort by file ID.
   * - "LAST_MODIFIED_TIME" : Sort by 'lastmodifiedAt' field.
   *
   * [sortOrder] - Order of sorted results, default is 'DESCENDING'.
   * Possible string values are:
   * - "ASCENDING" : Ascending order.
   * - "DESCENDING" : Descending order.
   *
   * Completes with a [FileList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FileList> list(core.String profileId, {core.int maxResults, core.String pageToken, core.String scope, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (scope != null) {
      _queryParams["scope"] = [scope];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/files';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FileList.fromJson(data));
  }

}


class FloodlightActivitiesResourceApi {
  final commons.ApiRequester _requester;

  FloodlightActivitiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing floodlight activity.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight activity ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Generates a tag for a floodlight activity.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [floodlightActivityId] - Floodlight activity ID for which we want to
   * generate a tag.
   *
   * Completes with a [FloodlightActivitiesGenerateTagResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivitiesGenerateTagResponse> generatetag(core.String profileId, {core.String floodlightActivityId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (floodlightActivityId != null) {
      _queryParams["floodlightActivityId"] = [floodlightActivityId];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities/generatetag';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivitiesGenerateTagResponse.fromJson(data));
  }

  /**
   * Gets one floodlight activity by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight activity ID.
   *
   * Completes with a [FloodlightActivity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivity> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivity.fromJson(data));
  }

  /**
   * Inserts a new floodlight activity.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [FloodlightActivity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivity> insert(FloodlightActivity request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivity.fromJson(data));
  }

  /**
   * Retrieves a list of floodlight activities, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only floodlight activities for the specified
   * advertiser ID. Must specify either ids, advertiserId, or
   * floodlightConfigurationId for a non-empty result.
   *
   * [floodlightActivityGroupIds] - Select only floodlight activities with the
   * specified floodlight activity group IDs.
   *
   * [floodlightActivityGroupName] - Select only floodlight activities with the
   * specified floodlight activity group name.
   *
   * [floodlightActivityGroupTagString] - Select only floodlight activities with
   * the specified floodlight activity group tag string.
   *
   * [floodlightActivityGroupType] - Select only floodlight activities with the
   * specified floodlight activity group type.
   * Possible string values are:
   * - "COUNTER"
   * - "SALE"
   *
   * [floodlightConfigurationId] - Select only floodlight activities for the
   * specified floodlight configuration ID. Must specify either ids,
   * advertiserId, or floodlightConfigurationId for a non-empty result.
   *
   * [ids] - Select only floodlight activities with the specified IDs. Must
   * specify either ids, advertiserId, or floodlightConfigurationId for a
   * non-empty result.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "floodlightactivity*2015" will return objects
   * with names like "floodlightactivity June 2015", "floodlightactivity April
   * 2015", or simply "floodlightactivity 2015". Most of the searches also add
   * wildcards implicitly at the start and the end of the search string. For
   * example, a search string of "floodlightactivity" will match objects with
   * name "my floodlightactivity activity", "floodlightactivity 2015", or simply
   * "floodlightactivity".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [tagString] - Select only floodlight activities with the specified tag
   * string.
   *
   * Completes with a [FloodlightActivitiesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivitiesListResponse> list(core.String profileId, {core.String advertiserId, core.List<core.String> floodlightActivityGroupIds, core.String floodlightActivityGroupName, core.String floodlightActivityGroupTagString, core.String floodlightActivityGroupType, core.String floodlightConfigurationId, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String tagString}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (floodlightActivityGroupIds != null) {
      _queryParams["floodlightActivityGroupIds"] = floodlightActivityGroupIds;
    }
    if (floodlightActivityGroupName != null) {
      _queryParams["floodlightActivityGroupName"] = [floodlightActivityGroupName];
    }
    if (floodlightActivityGroupTagString != null) {
      _queryParams["floodlightActivityGroupTagString"] = [floodlightActivityGroupTagString];
    }
    if (floodlightActivityGroupType != null) {
      _queryParams["floodlightActivityGroupType"] = [floodlightActivityGroupType];
    }
    if (floodlightConfigurationId != null) {
      _queryParams["floodlightConfigurationId"] = [floodlightConfigurationId];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (tagString != null) {
      _queryParams["tagString"] = [tagString];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivitiesListResponse.fromJson(data));
  }

  /**
   * Updates an existing floodlight activity. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight activity ID.
   *
   * Completes with a [FloodlightActivity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivity> patch(FloodlightActivity request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivity.fromJson(data));
  }

  /**
   * Updates an existing floodlight activity.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [FloodlightActivity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivity> update(FloodlightActivity request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivities';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivity.fromJson(data));
  }

}


class FloodlightActivityGroupsResourceApi {
  final commons.ApiRequester _requester;

  FloodlightActivityGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one floodlight activity group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight activity Group ID.
   *
   * Completes with a [FloodlightActivityGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivityGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivityGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivityGroup.fromJson(data));
  }

  /**
   * Inserts a new floodlight activity group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [FloodlightActivityGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivityGroup> insert(FloodlightActivityGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivityGroups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivityGroup.fromJson(data));
  }

  /**
   * Retrieves a list of floodlight activity groups, possibly filtered. This
   * method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only floodlight activity groups with the specified
   * advertiser ID. Must specify either advertiserId or
   * floodlightConfigurationId for a non-empty result.
   *
   * [floodlightConfigurationId] - Select only floodlight activity groups with
   * the specified floodlight configuration ID. Must specify either
   * advertiserId, or floodlightConfigurationId for a non-empty result.
   *
   * [ids] - Select only floodlight activity groups with the specified IDs. Must
   * specify either advertiserId or floodlightConfigurationId for a non-empty
   * result.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "floodlightactivitygroup*2015" will return
   * objects with names like "floodlightactivitygroup June 2015",
   * "floodlightactivitygroup April 2015", or simply "floodlightactivitygroup
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of
   * "floodlightactivitygroup" will match objects with name "my
   * floodlightactivitygroup activity", "floodlightactivitygroup 2015", or
   * simply "floodlightactivitygroup".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [type] - Select only floodlight activity groups with the specified
   * floodlight activity group type.
   * Possible string values are:
   * - "COUNTER"
   * - "SALE"
   *
   * Completes with a [FloodlightActivityGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivityGroupsListResponse> list(core.String profileId, {core.String advertiserId, core.String floodlightConfigurationId, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String type}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (floodlightConfigurationId != null) {
      _queryParams["floodlightConfigurationId"] = [floodlightConfigurationId];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (type != null) {
      _queryParams["type"] = [type];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivityGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivityGroupsListResponse.fromJson(data));
  }

  /**
   * Updates an existing floodlight activity group. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight activity Group ID.
   *
   * Completes with a [FloodlightActivityGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivityGroup> patch(FloodlightActivityGroup request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivityGroups';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivityGroup.fromJson(data));
  }

  /**
   * Updates an existing floodlight activity group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [FloodlightActivityGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightActivityGroup> update(FloodlightActivityGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightActivityGroups';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightActivityGroup.fromJson(data));
  }

}


class FloodlightConfigurationsResourceApi {
  final commons.ApiRequester _requester;

  FloodlightConfigurationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one floodlight configuration by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight configuration ID.
   *
   * Completes with a [FloodlightConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightConfiguration> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightConfigurations/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightConfiguration.fromJson(data));
  }

  /**
   * Retrieves a list of floodlight configurations, possibly filtered.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Set of IDs of floodlight configurations to retrieve. Required
   * field; otherwise an empty list will be returned.
   *
   * Completes with a [FloodlightConfigurationsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightConfigurationsListResponse> list(core.String profileId, {core.List<core.String> ids}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightConfigurations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightConfigurationsListResponse.fromJson(data));
  }

  /**
   * Updates an existing floodlight configuration. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Floodlight configuration ID.
   *
   * Completes with a [FloodlightConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightConfiguration> patch(FloodlightConfiguration request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightConfigurations';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightConfiguration.fromJson(data));
  }

  /**
   * Updates an existing floodlight configuration.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [FloodlightConfiguration].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FloodlightConfiguration> update(FloodlightConfiguration request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/floodlightConfigurations';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FloodlightConfiguration.fromJson(data));
  }

}


class InventoryItemsResourceApi {
  final commons.ApiRequester _requester;

  InventoryItemsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one inventory item by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for order documents.
   *
   * [id] - Inventory item ID.
   *
   * Completes with a [InventoryItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InventoryItem> get(core.String profileId, core.String projectId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/inventoryItems/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InventoryItem.fromJson(data));
  }

  /**
   * Retrieves a list of inventory items, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for order documents.
   *
   * [ids] - Select only inventory items with these IDs.
   *
   * [inPlan] - Select only inventory items that are in plan.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [orderId] - Select only inventory items that belong to specified orders.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [siteId] - Select only inventory items that are associated with these
   * sites.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [type] - Select only inventory items with this type.
   * Possible string values are:
   * - "PLANNING_PLACEMENT_TYPE_CREDIT"
   * - "PLANNING_PLACEMENT_TYPE_REGULAR"
   *
   * Completes with a [InventoryItemsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<InventoryItemsListResponse> list(core.String profileId, core.String projectId, {core.List<core.String> ids, core.bool inPlan, core.int maxResults, core.List<core.String> orderId, core.String pageToken, core.List<core.String> siteId, core.String sortField, core.String sortOrder, core.String type}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (inPlan != null) {
      _queryParams["inPlan"] = ["${inPlan}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderId != null) {
      _queryParams["orderId"] = orderId;
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (siteId != null) {
      _queryParams["siteId"] = siteId;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (type != null) {
      _queryParams["type"] = [type];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/inventoryItems';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new InventoryItemsListResponse.fromJson(data));
  }

}


class LandingPagesResourceApi {
  final commons.ApiRequester _requester;

  LandingPagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing campaign landing page.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * [id] - Landing page ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String campaignId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one campaign landing page by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * [id] - Landing page ID.
   *
   * Completes with a [LandingPage].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LandingPage> get(core.String profileId, core.String campaignId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LandingPage.fromJson(data));
  }

  /**
   * Inserts a new landing page for the specified campaign.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * Completes with a [LandingPage].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LandingPage> insert(LandingPage request, core.String profileId, core.String campaignId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LandingPage.fromJson(data));
  }

  /**
   * Retrieves the list of landing pages for the specified campaign.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * Completes with a [LandingPagesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LandingPagesListResponse> list(core.String profileId, core.String campaignId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LandingPagesListResponse.fromJson(data));
  }

  /**
   * Updates an existing campaign landing page. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * [id] - Landing page ID.
   *
   * Completes with a [LandingPage].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LandingPage> patch(LandingPage request, core.String profileId, core.String campaignId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LandingPage.fromJson(data));
  }

  /**
   * Updates an existing campaign landing page.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Landing page campaign ID.
   *
   * Completes with a [LandingPage].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LandingPage> update(LandingPage request, core.String profileId, core.String campaignId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId == null) {
      throw new core.ArgumentError("Parameter campaignId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/campaigns/' + commons.Escaper.ecapeVariable('$campaignId') + '/landingPages';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LandingPage.fromJson(data));
  }

}


class LanguagesResourceApi {
  final commons.ApiRequester _requester;

  LanguagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of languages.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [LanguagesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LanguagesListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/languages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LanguagesListResponse.fromJson(data));
  }

}


class MetrosResourceApi {
  final commons.ApiRequester _requester;

  MetrosResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of metros.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [MetrosListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MetrosListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/metros';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MetrosListResponse.fromJson(data));
  }

}


class MobileCarriersResourceApi {
  final commons.ApiRequester _requester;

  MobileCarriersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one mobile carrier by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Mobile carrier ID.
   *
   * Completes with a [MobileCarrier].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MobileCarrier> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/mobileCarriers/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MobileCarrier.fromJson(data));
  }

  /**
   * Retrieves a list of mobile carriers.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [MobileCarriersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<MobileCarriersListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/mobileCarriers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new MobileCarriersListResponse.fromJson(data));
  }

}


class OperatingSystemVersionsResourceApi {
  final commons.ApiRequester _requester;

  OperatingSystemVersionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one operating system version by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Operating system version ID.
   *
   * Completes with a [OperatingSystemVersion].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OperatingSystemVersion> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/operatingSystemVersions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OperatingSystemVersion.fromJson(data));
  }

  /**
   * Retrieves a list of operating system versions.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [OperatingSystemVersionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OperatingSystemVersionsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/operatingSystemVersions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OperatingSystemVersionsListResponse.fromJson(data));
  }

}


class OperatingSystemsResourceApi {
  final commons.ApiRequester _requester;

  OperatingSystemsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one operating system by DART ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [dartId] - Operating system DART ID.
   *
   * Completes with a [OperatingSystem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OperatingSystem> get(core.String profileId, core.String dartId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (dartId == null) {
      throw new core.ArgumentError("Parameter dartId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/operatingSystems/' + commons.Escaper.ecapeVariable('$dartId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OperatingSystem.fromJson(data));
  }

  /**
   * Retrieves a list of operating systems.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [OperatingSystemsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OperatingSystemsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/operatingSystems';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OperatingSystemsListResponse.fromJson(data));
  }

}


class OrderDocumentsResourceApi {
  final commons.ApiRequester _requester;

  OrderDocumentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one order document by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for order documents.
   *
   * [id] - Order document ID.
   *
   * Completes with a [OrderDocument].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrderDocument> get(core.String profileId, core.String projectId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/orderDocuments/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrderDocument.fromJson(data));
  }

  /**
   * Retrieves a list of order documents, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for order documents.
   *
   * [approved] - Select only order documents that have been approved by at
   * least one user.
   *
   * [ids] - Select only order documents with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [orderId] - Select only order documents for specified orders.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for order documents by name or ID.
   * Wildcards (*) are allowed. For example, "orderdocument*2015" will return
   * order documents with names like "orderdocument June 2015", "orderdocument
   * April 2015", or simply "orderdocument 2015". Most of the searches also add
   * wildcards implicitly at the start and the end of the search string. For
   * example, a search string of "orderdocument" will match order documents with
   * name "my orderdocument", "orderdocument 2015", or simply "orderdocument".
   *
   * [siteId] - Select only order documents that are associated with these
   * sites.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [OrderDocumentsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrderDocumentsListResponse> list(core.String profileId, core.String projectId, {core.bool approved, core.List<core.String> ids, core.int maxResults, core.List<core.String> orderId, core.String pageToken, core.String searchString, core.List<core.String> siteId, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (approved != null) {
      _queryParams["approved"] = ["${approved}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderId != null) {
      _queryParams["orderId"] = orderId;
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (siteId != null) {
      _queryParams["siteId"] = siteId;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/orderDocuments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrderDocumentsListResponse.fromJson(data));
  }

}


class OrdersResourceApi {
  final commons.ApiRequester _requester;

  OrdersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one order by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for orders.
   *
   * [id] - Order ID.
   *
   * Completes with a [Order].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Order> get(core.String profileId, core.String projectId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/orders/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Order.fromJson(data));
  }

  /**
   * Retrieves a list of orders, possibly filtered. This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [projectId] - Project ID for orders.
   *
   * [ids] - Select only orders with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for orders by name or ID. Wildcards (*)
   * are allowed. For example, "order*2015" will return orders with names like
   * "order June 2015", "order April 2015", or simply "order 2015". Most of the
   * searches also add wildcards implicitly at the start and the end of the
   * search string. For example, a search string of "order" will match orders
   * with name "my order", "order 2015", or simply "order".
   *
   * [siteId] - Select only orders that are associated with these site IDs.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [OrdersListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<OrdersListResponse> list(core.String profileId, core.String projectId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.List<core.String> siteId, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (siteId != null) {
      _queryParams["siteId"] = siteId;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$projectId') + '/orders';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new OrdersListResponse.fromJson(data));
  }

}


class PlacementGroupsResourceApi {
  final commons.ApiRequester _requester;

  PlacementGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one placement group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement group ID.
   *
   * Completes with a [PlacementGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementGroup.fromJson(data));
  }

  /**
   * Inserts a new placement group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PlacementGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementGroup> insert(PlacementGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementGroups';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementGroup.fromJson(data));
  }

  /**
   * Retrieves a list of placement groups, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserIds] - Select only placement groups that belong to these
   * advertisers.
   *
   * [archived] - Select only archived placements. Don't set this field to
   * select both archived and non-archived placements.
   *
   * [campaignIds] - Select only placement groups that belong to these
   * campaigns.
   *
   * [contentCategoryIds] - Select only placement groups that are associated
   * with these content categories.
   *
   * [directorySiteIds] - Select only placement groups that are associated with
   * these directory sites.
   *
   * [ids] - Select only placement groups with these IDs.
   *
   * [maxEndDate] - Select only placements or placement groups whose end date is
   * on or before the specified maxEndDate. The date should be formatted as
   * "yyyy-MM-dd".
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [maxStartDate] - Select only placements or placement groups whose start
   * date is on or before the specified maxStartDate. The date should be
   * formatted as "yyyy-MM-dd".
   *
   * [minEndDate] - Select only placements or placement groups whose end date is
   * on or after the specified minEndDate. The date should be formatted as
   * "yyyy-MM-dd".
   *
   * [minStartDate] - Select only placements or placement groups whose start
   * date is on or after the specified minStartDate. The date should be
   * formatted as "yyyy-MM-dd".
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [placementGroupType] - Select only placement groups belonging with this
   * group type. A package is a simple group of placements that acts as a single
   * pricing point for a group of tags. A roadblock is a group of placements
   * that not only acts as a single pricing point but also assumes that all the
   * tags in it will be served at the same time. A roadblock requires one of its
   * assigned placements to be marked as primary for reporting.
   * Possible string values are:
   * - "PLACEMENT_PACKAGE"
   * - "PLACEMENT_ROADBLOCK"
   *
   * [placementStrategyIds] - Select only placement groups that are associated
   * with these placement strategies.
   *
   * [pricingTypes] - Select only placement groups with these pricing types.
   *
   * [searchString] - Allows searching for placement groups by name or ID.
   * Wildcards (*) are allowed. For example, "placement*2015" will return
   * placement groups with names like "placement group June 2015", "placement
   * group May 2015", or simply "placements 2015". Most of the searches also add
   * wildcards implicitly at the start and the end of the search string. For
   * example, a search string of "placementgroup" will match placement groups
   * with name "my placementgroup", "placementgroup 2015", or simply
   * "placementgroup".
   *
   * [siteIds] - Select only placement groups that are associated with these
   * sites.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [PlacementGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementGroupsListResponse> list(core.String profileId, {core.List<core.String> advertiserIds, core.bool archived, core.List<core.String> campaignIds, core.List<core.String> contentCategoryIds, core.List<core.String> directorySiteIds, core.List<core.String> ids, core.String maxEndDate, core.int maxResults, core.String maxStartDate, core.String minEndDate, core.String minStartDate, core.String pageToken, core.String placementGroupType, core.List<core.String> placementStrategyIds, core.List<core.String> pricingTypes, core.String searchString, core.List<core.String> siteIds, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (archived != null) {
      _queryParams["archived"] = ["${archived}"];
    }
    if (campaignIds != null) {
      _queryParams["campaignIds"] = campaignIds;
    }
    if (contentCategoryIds != null) {
      _queryParams["contentCategoryIds"] = contentCategoryIds;
    }
    if (directorySiteIds != null) {
      _queryParams["directorySiteIds"] = directorySiteIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxEndDate != null) {
      _queryParams["maxEndDate"] = [maxEndDate];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (maxStartDate != null) {
      _queryParams["maxStartDate"] = [maxStartDate];
    }
    if (minEndDate != null) {
      _queryParams["minEndDate"] = [minEndDate];
    }
    if (minStartDate != null) {
      _queryParams["minStartDate"] = [minStartDate];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (placementGroupType != null) {
      _queryParams["placementGroupType"] = [placementGroupType];
    }
    if (placementStrategyIds != null) {
      _queryParams["placementStrategyIds"] = placementStrategyIds;
    }
    if (pricingTypes != null) {
      _queryParams["pricingTypes"] = pricingTypes;
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (siteIds != null) {
      _queryParams["siteIds"] = siteIds;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementGroupsListResponse.fromJson(data));
  }

  /**
   * Updates an existing placement group. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement group ID.
   *
   * Completes with a [PlacementGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementGroup> patch(PlacementGroup request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementGroups';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementGroup.fromJson(data));
  }

  /**
   * Updates an existing placement group.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PlacementGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementGroup> update(PlacementGroup request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementGroups';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementGroup.fromJson(data));
  }

}


class PlacementStrategiesResourceApi {
  final commons.ApiRequester _requester;

  PlacementStrategiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing placement strategy.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement strategy ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one placement strategy by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement strategy ID.
   *
   * Completes with a [PlacementStrategy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementStrategy> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementStrategy.fromJson(data));
  }

  /**
   * Inserts a new placement strategy.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PlacementStrategy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementStrategy> insert(PlacementStrategy request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementStrategy.fromJson(data));
  }

  /**
   * Retrieves a list of placement strategies, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Select only placement strategies with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "placementstrategy*2015" will return objects with
   * names like "placementstrategy June 2015", "placementstrategy April 2015",
   * or simply "placementstrategy 2015". Most of the searches also add wildcards
   * implicitly at the start and the end of the search string. For example, a
   * search string of "placementstrategy" will match objects with name "my
   * placementstrategy", "placementstrategy 2015", or simply
   * "placementstrategy".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [PlacementStrategiesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementStrategiesListResponse> list(core.String profileId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementStrategiesListResponse.fromJson(data));
  }

  /**
   * Updates an existing placement strategy. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement strategy ID.
   *
   * Completes with a [PlacementStrategy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementStrategy> patch(PlacementStrategy request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementStrategy.fromJson(data));
  }

  /**
   * Updates an existing placement strategy.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PlacementStrategy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementStrategy> update(PlacementStrategy request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placementStrategies';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementStrategy.fromJson(data));
  }

}


class PlacementsResourceApi {
  final commons.ApiRequester _requester;

  PlacementsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Generates tags for a placement.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [campaignId] - Generate placements belonging to this campaign. This is a
   * required field.
   *
   * [placementIds] - Generate tags for these placements.
   *
   * [tagFormats] - Tag formats to generate for these placements.
   *
   * Completes with a [PlacementsGenerateTagsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementsGenerateTagsResponse> generatetags(core.String profileId, {core.String campaignId, core.List<core.String> placementIds, core.List<core.String> tagFormats}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (campaignId != null) {
      _queryParams["campaignId"] = [campaignId];
    }
    if (placementIds != null) {
      _queryParams["placementIds"] = placementIds;
    }
    if (tagFormats != null) {
      _queryParams["tagFormats"] = tagFormats;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements/generatetags';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementsGenerateTagsResponse.fromJson(data));
  }

  /**
   * Gets one placement by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement ID.
   *
   * Completes with a [Placement].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Placement> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Placement.fromJson(data));
  }

  /**
   * Inserts a new placement.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Placement].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Placement> insert(Placement request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Placement.fromJson(data));
  }

  /**
   * Retrieves a list of placements, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserIds] - Select only placements that belong to these advertisers.
   *
   * [archived] - Select only archived placements. Don't set this field to
   * select both archived and non-archived placements.
   *
   * [campaignIds] - Select only placements that belong to these campaigns.
   *
   * [compatibilities] - Select only placements that are associated with these
   * compatibilities. DISPLAY and DISPLAY_INTERSTITIAL refer to rendering either
   * on desktop or on mobile devices for regular or interstitial ads
   * respectively. APP and APP_INTERSTITIAL are for rendering in mobile apps.
   * IN_STREAM_VIDEO refers to rendering in in-stream video ads developed with
   * the VAST standard.
   *
   * [contentCategoryIds] - Select only placements that are associated with
   * these content categories.
   *
   * [directorySiteIds] - Select only placements that are associated with these
   * directory sites.
   *
   * [groupIds] - Select only placements that belong to these placement groups.
   *
   * [ids] - Select only placements with these IDs.
   *
   * [maxEndDate] - Select only placements or placement groups whose end date is
   * on or before the specified maxEndDate. The date should be formatted as
   * "yyyy-MM-dd".
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [maxStartDate] - Select only placements or placement groups whose start
   * date is on or before the specified maxStartDate. The date should be
   * formatted as "yyyy-MM-dd".
   *
   * [minEndDate] - Select only placements or placement groups whose end date is
   * on or after the specified minEndDate. The date should be formatted as
   * "yyyy-MM-dd".
   *
   * [minStartDate] - Select only placements or placement groups whose start
   * date is on or after the specified minStartDate. The date should be
   * formatted as "yyyy-MM-dd".
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [paymentSource] - Select only placements with this payment source.
   * Possible string values are:
   * - "PLACEMENT_AGENCY_PAID"
   * - "PLACEMENT_PUBLISHER_PAID"
   *
   * [placementStrategyIds] - Select only placements that are associated with
   * these placement strategies.
   *
   * [pricingTypes] - Select only placements with these pricing types.
   *
   * [searchString] - Allows searching for placements by name or ID. Wildcards
   * (*) are allowed. For example, "placement*2015" will return placements with
   * names like "placement June 2015", "placement May 2015", or simply
   * "placements 2015". Most of the searches also add wildcards implicitly at
   * the start and the end of the search string. For example, a search string of
   * "placement" will match placements with name "my placement", "placement
   * 2015", or simply "placement".
   *
   * [siteIds] - Select only placements that are associated with these sites.
   *
   * [sizeIds] - Select only placements that are associated with these sizes.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [PlacementsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlacementsListResponse> list(core.String profileId, {core.List<core.String> advertiserIds, core.bool archived, core.List<core.String> campaignIds, core.List<core.String> compatibilities, core.List<core.String> contentCategoryIds, core.List<core.String> directorySiteIds, core.List<core.String> groupIds, core.List<core.String> ids, core.String maxEndDate, core.int maxResults, core.String maxStartDate, core.String minEndDate, core.String minStartDate, core.String pageToken, core.String paymentSource, core.List<core.String> placementStrategyIds, core.List<core.String> pricingTypes, core.String searchString, core.List<core.String> siteIds, core.List<core.String> sizeIds, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (archived != null) {
      _queryParams["archived"] = ["${archived}"];
    }
    if (campaignIds != null) {
      _queryParams["campaignIds"] = campaignIds;
    }
    if (compatibilities != null) {
      _queryParams["compatibilities"] = compatibilities;
    }
    if (contentCategoryIds != null) {
      _queryParams["contentCategoryIds"] = contentCategoryIds;
    }
    if (directorySiteIds != null) {
      _queryParams["directorySiteIds"] = directorySiteIds;
    }
    if (groupIds != null) {
      _queryParams["groupIds"] = groupIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxEndDate != null) {
      _queryParams["maxEndDate"] = [maxEndDate];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (maxStartDate != null) {
      _queryParams["maxStartDate"] = [maxStartDate];
    }
    if (minEndDate != null) {
      _queryParams["minEndDate"] = [minEndDate];
    }
    if (minStartDate != null) {
      _queryParams["minStartDate"] = [minStartDate];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (paymentSource != null) {
      _queryParams["paymentSource"] = [paymentSource];
    }
    if (placementStrategyIds != null) {
      _queryParams["placementStrategyIds"] = placementStrategyIds;
    }
    if (pricingTypes != null) {
      _queryParams["pricingTypes"] = pricingTypes;
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (siteIds != null) {
      _queryParams["siteIds"] = siteIds;
    }
    if (sizeIds != null) {
      _queryParams["sizeIds"] = sizeIds;
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlacementsListResponse.fromJson(data));
  }

  /**
   * Updates an existing placement. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Placement ID.
   *
   * Completes with a [Placement].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Placement> patch(Placement request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Placement.fromJson(data));
  }

  /**
   * Updates an existing placement.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Placement].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Placement> update(Placement request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/placements';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Placement.fromJson(data));
  }

}


class PlatformTypesResourceApi {
  final commons.ApiRequester _requester;

  PlatformTypesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one platform type by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Platform type ID.
   *
   * Completes with a [PlatformType].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlatformType> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/platformTypes/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlatformType.fromJson(data));
  }

  /**
   * Retrieves a list of platform types.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PlatformTypesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlatformTypesListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/platformTypes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlatformTypesListResponse.fromJson(data));
  }

}


class PostalCodesResourceApi {
  final commons.ApiRequester _requester;

  PostalCodesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one postal code by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [code] - Postal code ID.
   *
   * Completes with a [PostalCode].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostalCode> get(core.String profileId, core.String code) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (code == null) {
      throw new core.ArgumentError("Parameter code is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/postalCodes/' + commons.Escaper.ecapeVariable('$code');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostalCode.fromJson(data));
  }

  /**
   * Retrieves a list of postal codes.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [PostalCodesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostalCodesListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/postalCodes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostalCodesListResponse.fromJson(data));
  }

}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one project by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Project ID.
   *
   * Completes with a [Project].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Project> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Project.fromJson(data));
  }

  /**
   * Retrieves a list of projects, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserIds] - Select only projects with these advertiser IDs.
   *
   * [ids] - Select only projects with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for projects by name or ID. Wildcards (*)
   * are allowed. For example, "project*2015" will return projects with names
   * like "project June 2015", "project April 2015", or simply "project 2015".
   * Most of the searches also add wildcards implicitly at the start and the end
   * of the search string. For example, a search string of "project" will match
   * projects with name "my project", "project 2015", or simply "project".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [ProjectsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ProjectsListResponse> list(core.String profileId, {core.List<core.String> advertiserIds, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserIds != null) {
      _queryParams["advertiserIds"] = advertiserIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/projects';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ProjectsListResponse.fromJson(data));
  }

}


class RegionsResourceApi {
  final commons.ApiRequester _requester;

  RegionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a list of regions.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [RegionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RegionsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/regions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RegionsListResponse.fromJson(data));
  }

}


class RemarketingListSharesResourceApi {
  final commons.ApiRequester _requester;

  RemarketingListSharesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one remarketing list share by remarketing list ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [remarketingListId] - Remarketing list ID.
   *
   * Completes with a [RemarketingListShare].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingListShare> get(core.String profileId, core.String remarketingListId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (remarketingListId == null) {
      throw new core.ArgumentError("Parameter remarketingListId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingListShares/' + commons.Escaper.ecapeVariable('$remarketingListId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingListShare.fromJson(data));
  }

  /**
   * Updates an existing remarketing list share. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [remarketingListId] - Remarketing list ID.
   *
   * Completes with a [RemarketingListShare].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingListShare> patch(RemarketingListShare request, core.String profileId, core.String remarketingListId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (remarketingListId == null) {
      throw new core.ArgumentError("Parameter remarketingListId is required.");
    }
    _queryParams["remarketingListId"] = [remarketingListId];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingListShares';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingListShare.fromJson(data));
  }

  /**
   * Updates an existing remarketing list share.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [RemarketingListShare].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingListShare> update(RemarketingListShare request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingListShares';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingListShare.fromJson(data));
  }

}


class RemarketingListsResourceApi {
  final commons.ApiRequester _requester;

  RemarketingListsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one remarketing list by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Remarketing list ID.
   *
   * Completes with a [RemarketingList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingList> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingLists/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingList.fromJson(data));
  }

  /**
   * Inserts a new remarketing list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [RemarketingList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingList> insert(RemarketingList request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingLists';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingList.fromJson(data));
  }

  /**
   * Retrieves a list of remarketing lists, possibly filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only remarketing lists owned by this advertiser.
   *
   * [active] - Select only active or only inactive remarketing lists.
   *
   * [floodlightActivityId] - Select only remarketing lists that have this
   * floodlight activity ID.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [name] - Allows searching for objects by name or ID. Wildcards (*) are
   * allowed. For example, "remarketing list*2015" will return objects with
   * names like "remarketing list June 2015", "remarketing list April 2015", or
   * simply "remarketing list 2015". Most of the searches also add wildcards
   * implicitly at the start and the end of the search string. For example, a
   * search string of "remarketing list" will match objects with name "my
   * remarketing list", "remarketing list 2015", or simply "remarketing list".
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [RemarketingListsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingListsListResponse> list(core.String profileId, core.String advertiserId, {core.bool active, core.String floodlightActivityId, core.int maxResults, core.String name, core.String pageToken, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }
    _queryParams["advertiserId"] = [advertiserId];
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (floodlightActivityId != null) {
      _queryParams["floodlightActivityId"] = [floodlightActivityId];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingLists';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingListsListResponse.fromJson(data));
  }

  /**
   * Updates an existing remarketing list. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Remarketing list ID.
   *
   * Completes with a [RemarketingList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingList> patch(RemarketingList request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingLists';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingList.fromJson(data));
  }

  /**
   * Updates an existing remarketing list.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [RemarketingList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RemarketingList> update(RemarketingList request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/remarketingLists';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RemarketingList.fromJson(data));
  }

}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsCompatibleFieldsResourceApi get compatibleFields => new ReportsCompatibleFieldsResourceApi(_requester);
  ReportsFilesResourceApi get files => new ReportsFilesResourceApi(_requester);

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a report by its ID.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String reportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Retrieves a report by its ID.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> get(core.String profileId, core.String reportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * Creates a report.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> insert(Report request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * Retrieves list of reports.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "10".
   *
   * [pageToken] - The value of the nextToken from the previous result page.
   *
   * [scope] - The scope that defines which results are returned, default is
   * 'MINE'.
   * Possible string values are:
   * - "ALL" : All reports in account.
   * - "MINE" : My reports.
   *
   * [sortField] - The field by which to sort the list.
   * Possible string values are:
   * - "ID" : Sort by report ID.
   * - "LAST_MODIFIED_TIME" : Sort by 'lastModifiedTime' field.
   * - "NAME" : Sort by name of reports.
   *
   * [sortOrder] - Order of sorted results, default is 'DESCENDING'.
   * Possible string values are:
   * - "ASCENDING" : Ascending order.
   * - "DESCENDING" : Descending order.
   *
   * Completes with a [ReportList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReportList> list(core.String profileId, {core.int maxResults, core.String pageToken, core.String scope, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (scope != null) {
      _queryParams["scope"] = [scope];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReportList.fromJson(data));
  }

  /**
   * Updates a report. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> patch(Report request, core.String profileId, core.String reportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

  /**
   * Runs a report.
   *
   * Request parameters:
   *
   * [profileId] - The DFA profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * [synchronous] - If set and true, tries to run the report synchronously.
   *
   * Completes with a [File].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<File> run(core.String profileId, core.String reportId, {core.bool synchronous}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (synchronous != null) {
      _queryParams["synchronous"] = ["${synchronous}"];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId') + '/run';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new File.fromJson(data));
  }

  /**
   * Updates a report.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * Completes with a [Report].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Report> update(Report request, core.String profileId, core.String reportId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Report.fromJson(data));
  }

}


class ReportsCompatibleFieldsResourceApi {
  final commons.ApiRequester _requester;

  ReportsCompatibleFieldsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the fields that are compatible to be selected in the respective
   * sections of a report criteria, given the fields already selected in the
   * input report and user permissions.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - The DFA user profile ID.
   *
   * Completes with a [CompatibleFields].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CompatibleFields> query(Report request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/compatiblefields/query';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CompatibleFields.fromJson(data));
  }

}


class ReportsFilesResourceApi {
  final commons.ApiRequester _requester;

  ReportsFilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves a report file.
   *
   * Request parameters:
   *
   * [profileId] - The DFA profile ID.
   *
   * [reportId] - The ID of the report.
   *
   * [fileId] - The ID of the report file.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [File] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String profileId, core.String reportId, core.String fileId, {commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (fileId == null) {
      throw new core.ArgumentError("Parameter fileId is required.");
    }

    _downloadOptions = downloadOptions;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId') + '/files/' + commons.Escaper.ecapeVariable('$fileId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new File.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Lists files for a report.
   *
   * Request parameters:
   *
   * [profileId] - The DFA profile ID.
   *
   * [reportId] - The ID of the parent report.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "10".
   *
   * [pageToken] - The value of the nextToken from the previous result page.
   *
   * [sortField] - The field by which to sort the list.
   * Possible string values are:
   * - "ID" : Sort by file ID.
   * - "LAST_MODIFIED_TIME" : Sort by 'lastmodifiedAt' field.
   *
   * [sortOrder] - Order of sorted results, default is 'DESCENDING'.
   * Possible string values are:
   * - "ASCENDING" : Ascending order.
   * - "DESCENDING" : Descending order.
   *
   * Completes with a [FileList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FileList> list(core.String profileId, core.String reportId, {core.int maxResults, core.String pageToken, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (reportId == null) {
      throw new core.ArgumentError("Parameter reportId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/reports/' + commons.Escaper.ecapeVariable('$reportId') + '/files';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FileList.fromJson(data));
  }

}


class SitesResourceApi {
  final commons.ApiRequester _requester;

  SitesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one site by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Site ID.
   *
   * Completes with a [Site].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Site> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sites/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Site.fromJson(data));
  }

  /**
   * Inserts a new site.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Site].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Site> insert(Site request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sites';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Site.fromJson(data));
  }

  /**
   * Retrieves a list of sites, possibly filtered. This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [acceptsInStreamVideoPlacements] - This search filter is no longer
   * supported and will have no effect on the results returned.
   *
   * [acceptsInterstitialPlacements] - This search filter is no longer supported
   * and will have no effect on the results returned.
   *
   * [acceptsPublisherPaidPlacements] - Select only sites that accept publisher
   * paid placements.
   *
   * [adWordsSite] - Select only AdWords sites.
   *
   * [approved] - Select only approved sites.
   *
   * [campaignIds] - Select only sites with these campaign IDs.
   *
   * [directorySiteIds] - Select only sites with these directory site IDs.
   *
   * [ids] - Select only sites with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name, ID or keyName.
   * Wildcards (*) are allowed. For example, "site*2015" will return objects
   * with names like "site June 2015", "site April 2015", or simply "site 2015".
   * Most of the searches also add wildcards implicitly at the start and the end
   * of the search string. For example, a search string of "site" will match
   * objects with name "my site", "site 2015", or simply "site".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [subaccountId] - Select only sites with this subaccount ID.
   *
   * [unmappedSite] - Select only sites that have not been mapped to a directory
   * site.
   *
   * Completes with a [SitesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SitesListResponse> list(core.String profileId, {core.bool acceptsInStreamVideoPlacements, core.bool acceptsInterstitialPlacements, core.bool acceptsPublisherPaidPlacements, core.bool adWordsSite, core.bool approved, core.List<core.String> campaignIds, core.List<core.String> directorySiteIds, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String subaccountId, core.bool unmappedSite}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (acceptsInStreamVideoPlacements != null) {
      _queryParams["acceptsInStreamVideoPlacements"] = ["${acceptsInStreamVideoPlacements}"];
    }
    if (acceptsInterstitialPlacements != null) {
      _queryParams["acceptsInterstitialPlacements"] = ["${acceptsInterstitialPlacements}"];
    }
    if (acceptsPublisherPaidPlacements != null) {
      _queryParams["acceptsPublisherPaidPlacements"] = ["${acceptsPublisherPaidPlacements}"];
    }
    if (adWordsSite != null) {
      _queryParams["adWordsSite"] = ["${adWordsSite}"];
    }
    if (approved != null) {
      _queryParams["approved"] = ["${approved}"];
    }
    if (campaignIds != null) {
      _queryParams["campaignIds"] = campaignIds;
    }
    if (directorySiteIds != null) {
      _queryParams["directorySiteIds"] = directorySiteIds;
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (subaccountId != null) {
      _queryParams["subaccountId"] = [subaccountId];
    }
    if (unmappedSite != null) {
      _queryParams["unmappedSite"] = ["${unmappedSite}"];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sites';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SitesListResponse.fromJson(data));
  }

  /**
   * Updates an existing site. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Site ID.
   *
   * Completes with a [Site].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Site> patch(Site request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sites';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Site.fromJson(data));
  }

  /**
   * Updates an existing site.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Site].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Site> update(Site request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sites';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Site.fromJson(data));
  }

}


class SizesResourceApi {
  final commons.ApiRequester _requester;

  SizesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one size by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Size ID.
   *
   * Completes with a [Size].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Size> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sizes/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Size.fromJson(data));
  }

  /**
   * Inserts a new size.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Size].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Size> insert(Size request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sizes';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Size.fromJson(data));
  }

  /**
   * Retrieves a list of sizes, possibly filtered.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [height] - Select only sizes with this height.
   *
   * [iabStandard] - Select only IAB standard sizes.
   *
   * [ids] - Select only sizes with these IDs.
   *
   * [width] - Select only sizes with this width.
   *
   * Completes with a [SizesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SizesListResponse> list(core.String profileId, {core.int height, core.bool iabStandard, core.List<core.String> ids, core.int width}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (height != null) {
      _queryParams["height"] = ["${height}"];
    }
    if (iabStandard != null) {
      _queryParams["iabStandard"] = ["${iabStandard}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (width != null) {
      _queryParams["width"] = ["${width}"];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/sizes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SizesListResponse.fromJson(data));
  }

}


class SubaccountsResourceApi {
  final commons.ApiRequester _requester;

  SubaccountsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one subaccount by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Subaccount ID.
   *
   * Completes with a [Subaccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subaccount> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/subaccounts/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subaccount.fromJson(data));
  }

  /**
   * Inserts a new subaccount.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Subaccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subaccount> insert(Subaccount request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/subaccounts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subaccount.fromJson(data));
  }

  /**
   * Gets a list of subaccounts, possibly filtered. This method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Select only subaccounts with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "subaccount*2015" will return objects with names
   * like "subaccount June 2015", "subaccount April 2015", or simply "subaccount
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "subaccount"
   * will match objects with name "my subaccount", "subaccount 2015", or simply
   * "subaccount".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [SubaccountsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SubaccountsListResponse> list(core.String profileId, {core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/subaccounts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SubaccountsListResponse.fromJson(data));
  }

  /**
   * Updates an existing subaccount. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Subaccount ID.
   *
   * Completes with a [Subaccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subaccount> patch(Subaccount request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/subaccounts';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subaccount.fromJson(data));
  }

  /**
   * Updates an existing subaccount.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [Subaccount].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subaccount> update(Subaccount request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/subaccounts';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subaccount.fromJson(data));
  }

}


class TargetableRemarketingListsResourceApi {
  final commons.ApiRequester _requester;

  TargetableRemarketingListsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one remarketing list by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Remarketing list ID.
   *
   * Completes with a [TargetableRemarketingList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetableRemarketingList> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetableRemarketingLists/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetableRemarketingList.fromJson(data));
  }

  /**
   * Retrieves a list of targetable remarketing lists, possibly filtered. This
   * method supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only targetable remarketing lists targetable by
   * these advertisers.
   *
   * [active] - Select only active or only inactive targetable remarketing
   * lists.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [name] - Allows searching for objects by name or ID. Wildcards (*) are
   * allowed. For example, "remarketing list*2015" will return objects with
   * names like "remarketing list June 2015", "remarketing list April 2015", or
   * simply "remarketing list 2015". Most of the searches also add wildcards
   * implicitly at the start and the end of the search string. For example, a
   * search string of "remarketing list" will match objects with name "my
   * remarketing list", "remarketing list 2015", or simply "remarketing list".
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [TargetableRemarketingListsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetableRemarketingListsListResponse> list(core.String profileId, core.String advertiserId, {core.bool active, core.int maxResults, core.String name, core.String pageToken, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId == null) {
      throw new core.ArgumentError("Parameter advertiserId is required.");
    }
    _queryParams["advertiserId"] = [advertiserId];
    if (active != null) {
      _queryParams["active"] = ["${active}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetableRemarketingLists';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetableRemarketingListsListResponse.fromJson(data));
  }

}


class TargetingTemplatesResourceApi {
  final commons.ApiRequester _requester;

  TargetingTemplatesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one targeting template by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Targeting template ID.
   *
   * Completes with a [TargetingTemplate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetingTemplate> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetingTemplates/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetingTemplate.fromJson(data));
  }

  /**
   * Inserts a new targeting template.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [TargetingTemplate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetingTemplate> insert(TargetingTemplate request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetingTemplates';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetingTemplate.fromJson(data));
  }

  /**
   * Retrieves a list of targeting templates, optionally filtered. This method
   * supports paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [advertiserId] - Select only targeting templates with this advertiser ID.
   *
   * [ids] - Select only targeting templates with these IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "template*2015" will return objects with names
   * like "template June 2015", "template April 2015", or simply "template
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "template"
   * will match objects with name "my template", "template 2015", or simply
   * "template".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * Completes with a [TargetingTemplatesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetingTemplatesListResponse> list(core.String profileId, {core.String advertiserId, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (advertiserId != null) {
      _queryParams["advertiserId"] = [advertiserId];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetingTemplates';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetingTemplatesListResponse.fromJson(data));
  }

  /**
   * Updates an existing targeting template. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Targeting template ID.
   *
   * Completes with a [TargetingTemplate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetingTemplate> patch(TargetingTemplate request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetingTemplates';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetingTemplate.fromJson(data));
  }

  /**
   * Updates an existing targeting template.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [TargetingTemplate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TargetingTemplate> update(TargetingTemplate request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/targetingTemplates';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TargetingTemplate.fromJson(data));
  }

}


class UserProfilesResourceApi {
  final commons.ApiRequester _requester;

  UserProfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one user profile by ID.
   *
   * Request parameters:
   *
   * [profileId] - The user profile ID.
   *
   * Completes with a [UserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserProfile> get(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserProfile.fromJson(data));
  }

  /**
   * Retrieves list of user profiles for a user.
   *
   * Request parameters:
   *
   * Completes with a [UserProfileList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserProfileList> list() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'userprofiles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserProfileList.fromJson(data));
  }

}


class UserRolePermissionGroupsResourceApi {
  final commons.ApiRequester _requester;

  UserRolePermissionGroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one user role permission group by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User role permission group ID.
   *
   * Completes with a [UserRolePermissionGroup].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRolePermissionGroup> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRolePermissionGroups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRolePermissionGroup.fromJson(data));
  }

  /**
   * Gets a list of all supported user role permission groups.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [UserRolePermissionGroupsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRolePermissionGroupsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRolePermissionGroups';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRolePermissionGroupsListResponse.fromJson(data));
  }

}


class UserRolePermissionsResourceApi {
  final commons.ApiRequester _requester;

  UserRolePermissionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one user role permission by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User role permission ID.
   *
   * Completes with a [UserRolePermission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRolePermission> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRolePermissions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRolePermission.fromJson(data));
  }

  /**
   * Gets a list of user role permissions, possibly filtered.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [ids] - Select only user role permissions with these IDs.
   *
   * Completes with a [UserRolePermissionsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRolePermissionsListResponse> list(core.String profileId, {core.List<core.String> ids}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRolePermissions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRolePermissionsListResponse.fromJson(data));
  }

}


class UserRolesResourceApi {
  final commons.ApiRequester _requester;

  UserRolesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an existing user role.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User role ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Gets one user role by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User role ID.
   *
   * Completes with a [UserRole].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRole> get(core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRole.fromJson(data));
  }

  /**
   * Inserts a new user role.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [UserRole].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRole> insert(UserRole request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRole.fromJson(data));
  }

  /**
   * Retrieves a list of user roles, possibly filtered. This method supports
   * paging.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [accountUserRoleOnly] - Select only account level user roles not associated
   * with any specific subaccount.
   *
   * [ids] - Select only user roles with the specified IDs.
   *
   * [maxResults] - Maximum number of results to return.
   *
   * [pageToken] - Value of the nextPageToken from the previous result page.
   *
   * [searchString] - Allows searching for objects by name or ID. Wildcards (*)
   * are allowed. For example, "userrole*2015" will return objects with names
   * like "userrole June 2015", "userrole April 2015", or simply "userrole
   * 2015". Most of the searches also add wildcards implicitly at the start and
   * the end of the search string. For example, a search string of "userrole"
   * will match objects with name "my userrole", "userrole 2015", or simply
   * "userrole".
   *
   * [sortField] - Field by which to sort the list.
   * Possible string values are:
   * - "ID"
   * - "NAME"
   *
   * [sortOrder] - Order of sorted results, default is ASCENDING.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   *
   * [subaccountId] - Select only user roles that belong to this subaccount.
   *
   * Completes with a [UserRolesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRolesListResponse> list(core.String profileId, {core.bool accountUserRoleOnly, core.List<core.String> ids, core.int maxResults, core.String pageToken, core.String searchString, core.String sortField, core.String sortOrder, core.String subaccountId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (accountUserRoleOnly != null) {
      _queryParams["accountUserRoleOnly"] = ["${accountUserRoleOnly}"];
    }
    if (ids != null) {
      _queryParams["ids"] = ids;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchString != null) {
      _queryParams["searchString"] = [searchString];
    }
    if (sortField != null) {
      _queryParams["sortField"] = [sortField];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }
    if (subaccountId != null) {
      _queryParams["subaccountId"] = [subaccountId];
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRolesListResponse.fromJson(data));
  }

  /**
   * Updates an existing user role. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - User role ID.
   *
   * Completes with a [UserRole].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRole> patch(UserRole request, core.String profileId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles';

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRole.fromJson(data));
  }

  /**
   * Updates an existing user role.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [UserRole].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserRole> update(UserRole request, core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/userRoles';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserRole.fromJson(data));
  }

}


class VideoFormatsResourceApi {
  final commons.ApiRequester _requester;

  VideoFormatsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one video format by ID.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * [id] - Video format ID.
   *
   * Completes with a [VideoFormat].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoFormat> get(core.String profileId, core.int id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/videoFormats/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoFormat.fromJson(data));
  }

  /**
   * Lists available video formats.
   *
   * Request parameters:
   *
   * [profileId] - User profile ID associated with this request.
   *
   * Completes with a [VideoFormatsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoFormatsListResponse> list(core.String profileId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (profileId == null) {
      throw new core.ArgumentError("Parameter profileId is required.");
    }

    _url = 'userprofiles/' + commons.Escaper.ecapeVariable('$profileId') + '/videoFormats';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoFormatsListResponse.fromJson(data));
  }

}



/** Contains properties of a DCM account. */
class Account {
  /** Account permissions assigned to this account. */
  core.List<core.String> accountPermissionIds;
  /**
   * Profile for this account. This is a read-only field that can be left blank.
   * Possible string values are:
   * - "ACCOUNT_PROFILE_BASIC"
   * - "ACCOUNT_PROFILE_STANDARD"
   */
  core.String accountProfile;
  /** Whether this account is active. */
  core.bool active;
  /**
   * Maximum number of active ads allowed for this account.
   * Possible string values are:
   * - "ACTIVE_ADS_TIER_100K"
   * - "ACTIVE_ADS_TIER_200K"
   * - "ACTIVE_ADS_TIER_300K"
   * - "ACTIVE_ADS_TIER_40K"
   * - "ACTIVE_ADS_TIER_500K"
   * - "ACTIVE_ADS_TIER_750K"
   * - "ACTIVE_ADS_TIER_75K"
   */
  core.String activeAdsLimitTier;
  /**
   * Whether to serve creatives with Active View tags. If disabled, viewability
   * data will not be available for any impressions.
   */
  core.bool activeViewOptOut;
  /** User role permissions available to the user roles of this account. */
  core.List<core.String> availablePermissionIds;
  /** ID of the country associated with this account. */
  core.String countryId;
  /**
   * ID of currency associated with this account. This is a required field.
   * Acceptable values are:
   * - "1" for USD
   * - "2" for GBP
   * - "3" for ESP
   * - "4" for SEK
   * - "5" for CAD
   * - "6" for JPY
   * - "7" for DEM
   * - "8" for AUD
   * - "9" for FRF
   * - "10" for ITL
   * - "11" for DKK
   * - "12" for NOK
   * - "13" for FIM
   * - "14" for ZAR
   * - "15" for IEP
   * - "16" for NLG
   * - "17" for EUR
   * - "18" for KRW
   * - "19" for TWD
   * - "20" for SGD
   * - "21" for CNY
   * - "22" for HKD
   * - "23" for NZD
   * - "24" for MYR
   * - "25" for BRL
   * - "26" for PTE
   * - "27" for MXP
   * - "28" for CLP
   * - "29" for TRY
   * - "30" for ARS
   * - "31" for PEN
   * - "32" for ILS
   * - "33" for CHF
   * - "34" for VEF
   * - "35" for COP
   * - "36" for GTQ
   * - "37" for PLN
   * - "39" for INR
   * - "40" for THB
   * - "41" for IDR
   * - "42" for CZK
   * - "43" for RON
   * - "44" for HUF
   * - "45" for RUB
   * - "46" for AED
   * - "47" for BGN
   * - "48" for HRK
   */
  core.String currencyId;
  /** Default placement dimensions for this account. */
  core.String defaultCreativeSizeId;
  /** Description of this account. */
  core.String description;
  /** ID of this account. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#account".
   */
  core.String kind;
  /**
   * Locale of this account.
   * Acceptable values are:
   * - "cs" (Czech)
   * - "de" (German)
   * - "en" (English)
   * - "en-GB" (English United Kingdom)
   * - "es" (Spanish)
   * - "fr" (French)
   * - "it" (Italian)
   * - "ja" (Japanese)
   * - "ko" (Korean)
   * - "pl" (Polish)
   * - "pt-BR" (Portuguese Brazil)
   * - "ru" (Russian)
   * - "sv" (Swedish)
   * - "tr" (Turkish)
   * - "zh-CN" (Chinese Simplified)
   * - "zh-TW" (Chinese Traditional)
   */
  core.String locale;
  /** Maximum image size allowed for this account. */
  core.String maximumImageSize;
  /**
   * Name of this account. This is a required field, and must be less than 128
   * characters long and be globally unique.
   */
  core.String name;
  /**
   * Whether campaigns created in this account will be enabled for Nielsen OCR
   * reach ratings by default.
   */
  core.bool nielsenOcrEnabled;
  /** Reporting configuration of this account. */
  ReportsConfiguration reportsConfiguration;
  /** Share Path to Conversion reports with Twitter. */
  core.bool shareReportsWithTwitter;
  /**
   * File size limit in kilobytes of Rich Media teaser creatives. Must be
   * between 1 and 10240.
   */
  core.String teaserSizeLimit;

  Account();

  Account.fromJson(core.Map _json) {
    if (_json.containsKey("accountPermissionIds")) {
      accountPermissionIds = _json["accountPermissionIds"];
    }
    if (_json.containsKey("accountProfile")) {
      accountProfile = _json["accountProfile"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("activeAdsLimitTier")) {
      activeAdsLimitTier = _json["activeAdsLimitTier"];
    }
    if (_json.containsKey("activeViewOptOut")) {
      activeViewOptOut = _json["activeViewOptOut"];
    }
    if (_json.containsKey("availablePermissionIds")) {
      availablePermissionIds = _json["availablePermissionIds"];
    }
    if (_json.containsKey("countryId")) {
      countryId = _json["countryId"];
    }
    if (_json.containsKey("currencyId")) {
      currencyId = _json["currencyId"];
    }
    if (_json.containsKey("defaultCreativeSizeId")) {
      defaultCreativeSizeId = _json["defaultCreativeSizeId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("maximumImageSize")) {
      maximumImageSize = _json["maximumImageSize"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("nielsenOcrEnabled")) {
      nielsenOcrEnabled = _json["nielsenOcrEnabled"];
    }
    if (_json.containsKey("reportsConfiguration")) {
      reportsConfiguration = new ReportsConfiguration.fromJson(_json["reportsConfiguration"]);
    }
    if (_json.containsKey("shareReportsWithTwitter")) {
      shareReportsWithTwitter = _json["shareReportsWithTwitter"];
    }
    if (_json.containsKey("teaserSizeLimit")) {
      teaserSizeLimit = _json["teaserSizeLimit"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountPermissionIds != null) {
      _json["accountPermissionIds"] = accountPermissionIds;
    }
    if (accountProfile != null) {
      _json["accountProfile"] = accountProfile;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (activeAdsLimitTier != null) {
      _json["activeAdsLimitTier"] = activeAdsLimitTier;
    }
    if (activeViewOptOut != null) {
      _json["activeViewOptOut"] = activeViewOptOut;
    }
    if (availablePermissionIds != null) {
      _json["availablePermissionIds"] = availablePermissionIds;
    }
    if (countryId != null) {
      _json["countryId"] = countryId;
    }
    if (currencyId != null) {
      _json["currencyId"] = currencyId;
    }
    if (defaultCreativeSizeId != null) {
      _json["defaultCreativeSizeId"] = defaultCreativeSizeId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (maximumImageSize != null) {
      _json["maximumImageSize"] = maximumImageSize;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (nielsenOcrEnabled != null) {
      _json["nielsenOcrEnabled"] = nielsenOcrEnabled;
    }
    if (reportsConfiguration != null) {
      _json["reportsConfiguration"] = (reportsConfiguration).toJson();
    }
    if (shareReportsWithTwitter != null) {
      _json["shareReportsWithTwitter"] = shareReportsWithTwitter;
    }
    if (teaserSizeLimit != null) {
      _json["teaserSizeLimit"] = teaserSizeLimit;
    }
    return _json;
  }
}

/** Gets a summary of active ads in an account. */
class AccountActiveAdSummary {
  /** ID of the account. */
  core.String accountId;
  /** Ads that have been activated for the account */
  core.String activeAds;
  /**
   * Maximum number of active ads allowed for the account.
   * Possible string values are:
   * - "ACTIVE_ADS_TIER_100K"
   * - "ACTIVE_ADS_TIER_200K"
   * - "ACTIVE_ADS_TIER_300K"
   * - "ACTIVE_ADS_TIER_40K"
   * - "ACTIVE_ADS_TIER_500K"
   * - "ACTIVE_ADS_TIER_750K"
   * - "ACTIVE_ADS_TIER_75K"
   */
  core.String activeAdsLimitTier;
  /** Ads that can be activated for the account. */
  core.String availableAds;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountActiveAdSummary".
   */
  core.String kind;

  AccountActiveAdSummary();

  AccountActiveAdSummary.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("activeAds")) {
      activeAds = _json["activeAds"];
    }
    if (_json.containsKey("activeAdsLimitTier")) {
      activeAdsLimitTier = _json["activeAdsLimitTier"];
    }
    if (_json.containsKey("availableAds")) {
      availableAds = _json["availableAds"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (activeAds != null) {
      _json["activeAds"] = activeAds;
    }
    if (activeAdsLimitTier != null) {
      _json["activeAdsLimitTier"] = activeAdsLimitTier;
    }
    if (availableAds != null) {
      _json["availableAds"] = availableAds;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * AccountPermissions contains information about a particular account
 * permission. Some features of DCM require an account permission to be present
 * in the account.
 */
class AccountPermission {
  /**
   * Account profiles associated with this account permission.
   *
   * Possible values are:
   * - "ACCOUNT_PROFILE_BASIC"
   * - "ACCOUNT_PROFILE_STANDARD"
   */
  core.List<core.String> accountProfiles;
  /** ID of this account permission. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountPermission".
   */
  core.String kind;
  /**
   * Administrative level required to enable this account permission.
   * Possible string values are:
   * - "ADMINISTRATOR"
   * - "USER"
   */
  core.String level;
  /** Name of this account permission. */
  core.String name;
  /** Permission group of this account permission. */
  core.String permissionGroupId;

  AccountPermission();

  AccountPermission.fromJson(core.Map _json) {
    if (_json.containsKey("accountProfiles")) {
      accountProfiles = _json["accountProfiles"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("permissionGroupId")) {
      permissionGroupId = _json["permissionGroupId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountProfiles != null) {
      _json["accountProfiles"] = accountProfiles;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (permissionGroupId != null) {
      _json["permissionGroupId"] = permissionGroupId;
    }
    return _json;
  }
}

/**
 * AccountPermissionGroups contains a mapping of permission group IDs to names.
 * A permission group is a grouping of account permissions.
 */
class AccountPermissionGroup {
  /** ID of this account permission group. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountPermissionGroup".
   */
  core.String kind;
  /** Name of this account permission group. */
  core.String name;

  AccountPermissionGroup();

  AccountPermissionGroup.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Account Permission Group List Response */
class AccountPermissionGroupsListResponse {
  /** Account permission group collection. */
  core.List<AccountPermissionGroup> accountPermissionGroups;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountPermissionGroupsListResponse".
   */
  core.String kind;

  AccountPermissionGroupsListResponse();

  AccountPermissionGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountPermissionGroups")) {
      accountPermissionGroups = _json["accountPermissionGroups"].map((value) => new AccountPermissionGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountPermissionGroups != null) {
      _json["accountPermissionGroups"] = accountPermissionGroups.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Account Permission List Response */
class AccountPermissionsListResponse {
  /** Account permission collection. */
  core.List<AccountPermission> accountPermissions;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountPermissionsListResponse".
   */
  core.String kind;

  AccountPermissionsListResponse();

  AccountPermissionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountPermissions")) {
      accountPermissions = _json["accountPermissions"].map((value) => new AccountPermission.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountPermissions != null) {
      _json["accountPermissions"] = accountPermissions.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * AccountUserProfiles contains properties of a DCM user profile. This resource
 * is specifically for managing user profiles, whereas UserProfiles is for
 * accessing the API.
 */
class AccountUserProfile {
  /**
   * Account ID of the user profile. This is a read-only field that can be left
   * blank.
   */
  core.String accountId;
  /**
   * Whether this user profile is active. This defaults to false, and must be
   * set true on insert for the user profile to be usable.
   */
  core.bool active;
  /**
   * Filter that describes which advertisers are visible to the user profile.
   */
  ObjectFilter advertiserFilter;
  /** Filter that describes which campaigns are visible to the user profile. */
  ObjectFilter campaignFilter;
  /** Comments for this user profile. */
  core.String comments;
  /**
   * Email of the user profile. The email addresss must be linked to a Google
   * Account. This field is required on insertion and is read-only after
   * insertion.
   */
  core.String email;
  /** ID of the user profile. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountUserProfile".
   */
  core.String kind;
  /**
   * Locale of the user profile. This is a required field.
   * Acceptable values are:
   * - "cs" (Czech)
   * - "de" (German)
   * - "en" (English)
   * - "en-GB" (English United Kingdom)
   * - "es" (Spanish)
   * - "fr" (French)
   * - "it" (Italian)
   * - "ja" (Japanese)
   * - "ko" (Korean)
   * - "pl" (Polish)
   * - "pt-BR" (Portuguese Brazil)
   * - "ru" (Russian)
   * - "sv" (Swedish)
   * - "tr" (Turkish)
   * - "zh-CN" (Chinese Simplified)
   * - "zh-TW" (Chinese Traditional)
   */
  core.String locale;
  /**
   * Name of the user profile. This is a required field. Must be less than 64
   * characters long, must be globally unique, and cannot contain whitespace or
   * any of the following characters: "&;"#%,".
   */
  core.String name;
  /** Filter that describes which sites are visible to the user profile. */
  ObjectFilter siteFilter;
  /**
   * Subaccount ID of the user profile. This is a read-only field that can be
   * left blank.
   */
  core.String subaccountId;
  /**
   * Trafficker type of this user profile.
   * Possible string values are:
   * - "EXTERNAL_TRAFFICKER"
   * - "INTERNAL_NON_TRAFFICKER"
   * - "INTERNAL_TRAFFICKER"
   */
  core.String traffickerType;
  /**
   * User type of the user profile. This is a read-only field that can be left
   * blank.
   * Possible string values are:
   * - "INTERNAL_ADMINISTRATOR"
   * - "NORMAL_USER"
   * - "READ_ONLY_SUPER_USER"
   * - "SUPER_USER"
   */
  core.String userAccessType;
  /**
   * Filter that describes which user roles are visible to the user profile.
   */
  ObjectFilter userRoleFilter;
  /** User role ID of the user profile. This is a required field. */
  core.String userRoleId;

  AccountUserProfile();

  AccountUserProfile.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("advertiserFilter")) {
      advertiserFilter = new ObjectFilter.fromJson(_json["advertiserFilter"]);
    }
    if (_json.containsKey("campaignFilter")) {
      campaignFilter = new ObjectFilter.fromJson(_json["campaignFilter"]);
    }
    if (_json.containsKey("comments")) {
      comments = _json["comments"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("locale")) {
      locale = _json["locale"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("siteFilter")) {
      siteFilter = new ObjectFilter.fromJson(_json["siteFilter"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("traffickerType")) {
      traffickerType = _json["traffickerType"];
    }
    if (_json.containsKey("userAccessType")) {
      userAccessType = _json["userAccessType"];
    }
    if (_json.containsKey("userRoleFilter")) {
      userRoleFilter = new ObjectFilter.fromJson(_json["userRoleFilter"]);
    }
    if (_json.containsKey("userRoleId")) {
      userRoleId = _json["userRoleId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (advertiserFilter != null) {
      _json["advertiserFilter"] = (advertiserFilter).toJson();
    }
    if (campaignFilter != null) {
      _json["campaignFilter"] = (campaignFilter).toJson();
    }
    if (comments != null) {
      _json["comments"] = comments;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (locale != null) {
      _json["locale"] = locale;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (siteFilter != null) {
      _json["siteFilter"] = (siteFilter).toJson();
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (traffickerType != null) {
      _json["traffickerType"] = traffickerType;
    }
    if (userAccessType != null) {
      _json["userAccessType"] = userAccessType;
    }
    if (userRoleFilter != null) {
      _json["userRoleFilter"] = (userRoleFilter).toJson();
    }
    if (userRoleId != null) {
      _json["userRoleId"] = userRoleId;
    }
    return _json;
  }
}

/** Account User Profile List Response */
class AccountUserProfilesListResponse {
  /** Account user profile collection. */
  core.List<AccountUserProfile> accountUserProfiles;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountUserProfilesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  AccountUserProfilesListResponse();

  AccountUserProfilesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accountUserProfiles")) {
      accountUserProfiles = _json["accountUserProfiles"].map((value) => new AccountUserProfile.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountUserProfiles != null) {
      _json["accountUserProfiles"] = accountUserProfiles.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Account List Response */
class AccountsListResponse {
  /** Account collection. */
  core.List<Account> accounts;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#accountsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  AccountsListResponse();

  AccountsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("accounts")) {
      accounts = _json["accounts"].map((value) => new Account.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accounts != null) {
      _json["accounts"] = accounts.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Represents an activity group. */
class Activities {
  /**
   * List of activity filters. The dimension values need to be all either of
   * type "dfa:activity" or "dfa:activityGroup".
   */
  core.List<DimensionValue> filters;
  /** The kind of resource this is, in this case dfareporting#activities. */
  core.String kind;
  /** List of names of floodlight activity metrics. */
  core.List<core.String> metricNames;

  Activities();

  Activities.fromJson(core.Map _json) {
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    return _json;
  }
}

/** Contains properties of a DCM ad. */
class Ad {
  /**
   * Account ID of this ad. This is a read-only field that can be left blank.
   */
  core.String accountId;
  /** Whether this ad is active. When true, archived must be false. */
  core.bool active;
  /** Advertiser ID of this ad. This is a required field on insertion. */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Whether this ad is archived. When true, active must be false. */
  core.bool archived;
  /**
   * Audience segment ID that is being targeted for this ad. Applicable when
   * type is AD_SERVING_STANDARD_AD.
   */
  core.String audienceSegmentId;
  /** Campaign ID of this ad. This is a required field on insertion. */
  core.String campaignId;
  /**
   * Dimension value for the ID of the campaign. This is a read-only,
   * auto-generated field.
   */
  DimensionValue campaignIdDimensionValue;
  /**
   * Click-through URL for this ad. This is a required field on insertion.
   * Applicable when type is AD_SERVING_CLICK_TRACKER.
   */
  ClickThroughUrl clickThroughUrl;
  /**
   * Click-through URL suffix properties for this ad. Applies to the URL in the
   * ad or (if overriding ad properties) the URL in the creative.
   */
  ClickThroughUrlSuffixProperties clickThroughUrlSuffixProperties;
  /** Comments for this ad. */
  core.String comments;
  /**
   * Compatibility of this ad. Applicable when type is AD_SERVING_DEFAULT_AD.
   * DISPLAY and DISPLAY_INTERSTITIAL refer to either rendering on desktop or on
   * mobile devices or in mobile apps for regular or interstitial ads,
   * respectively. APP and APP_INTERSTITIAL are only used for existing default
   * ads. New mobile placements must be assigned DISPLAY or DISPLAY_INTERSTITIAL
   * and default ads created for those placements will be limited to those
   * compatibility types. IN_STREAM_VIDEO refers to rendering in-stream video
   * ads developed with the VAST standard.
   * Possible string values are:
   * - "APP"
   * - "APP_INTERSTITIAL"
   * - "DISPLAY"
   * - "DISPLAY_INTERSTITIAL"
   * - "IN_STREAM_VIDEO"
   */
  core.String compatibility;
  /** Information about the creation of this ad. This is a read-only field. */
  LastModifiedInfo createInfo;
  /**
   * Creative group assignments for this ad. Applicable when type is
   * AD_SERVING_CLICK_TRACKER. Only one assignment per creative group number is
   * allowed for a maximum of two assignments.
   */
  core.List<CreativeGroupAssignment> creativeGroupAssignments;
  /**
   * Creative rotation for this ad. Applicable when type is
   * AD_SERVING_DEFAULT_AD, AD_SERVING_STANDARD_AD, or AD_SERVING_TRACKING. When
   * type is AD_SERVING_DEFAULT_AD, this field should have exactly one
   * creativeAssignment.
   */
  CreativeRotation creativeRotation;
  /**
   * Time and day targeting information for this ad. This field must be left
   * blank if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  DayPartTargeting dayPartTargeting;
  /** Default click-through event tag properties for this ad. */
  DefaultClickThroughEventTagProperties defaultClickThroughEventTagProperties;
  /**
   * Delivery schedule information for this ad. Applicable when type is
   * AD_SERVING_STANDARD_AD or AD_SERVING_TRACKING. This field along with
   * subfields priority and impressionRatio are required on insertion when type
   * is AD_SERVING_STANDARD_AD.
   */
  DeliverySchedule deliverySchedule;
  /**
   * Whether this ad is a dynamic click tracker. Applicable when type is
   * AD_SERVING_CLICK_TRACKER. This is a required field on insert, and is
   * read-only after insert.
   */
  core.bool dynamicClickTracker;
  /**
   * Date and time that this ad should stop serving. Must be later than the
   * start time. This is a required field on insertion.
   */
  core.DateTime endTime;
  /** Event tag overrides for this ad. */
  core.List<EventTagOverride> eventTagOverrides;
  /**
   * Geographical targeting information for this ad. This field must be left
   * blank if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  GeoTargeting geoTargeting;
  /** ID of this ad. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this ad. This is a read-only, auto-generated
   * field.
   */
  DimensionValue idDimensionValue;
  /**
   * Key-value targeting information for this ad. This field must be left blank
   * if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  KeyValueTargetingExpression keyValueTargetingExpression;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#ad".
   */
  core.String kind;
  /**
   * Language targeting information for this ad. This field must be left blank
   * if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  LanguageTargeting languageTargeting;
  /**
   * Information about the most recent modification of this ad. This is a
   * read-only field.
   */
  LastModifiedInfo lastModifiedInfo;
  /**
   * Name of this ad. This is a required field and must be less than 256
   * characters long.
   */
  core.String name;
  /** Placement assignments for this ad. */
  core.List<PlacementAssignment> placementAssignments;
  /**
   * Remarketing list targeting expression for this ad. This field must be left
   * blank if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  ListTargetingExpression remarketingListExpression;
  /** Size of this ad. Applicable when type is AD_SERVING_DEFAULT_AD. */
  Size size;
  /**
   * Whether this ad is ssl compliant. This is a read-only field that is
   * auto-generated when the ad is inserted or updated.
   */
  core.bool sslCompliant;
  /**
   * Whether this ad requires ssl. This is a read-only field that is
   * auto-generated when the ad is inserted or updated.
   */
  core.bool sslRequired;
  /**
   * Date and time that this ad should start serving. If creating an ad, this
   * field must be a time in the future. This is a required field on insertion.
   */
  core.DateTime startTime;
  /**
   * Subaccount ID of this ad. This is a read-only field that can be left blank.
   */
  core.String subaccountId;
  /**
   * Targeting template ID, used to apply preconfigured targeting information to
   * this ad. This cannot be set while any of dayPartTargeting, geoTargeting,
   * keyValueTargetingExpression, languageTargeting, remarketingListExpression,
   * or technologyTargeting are set. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  core.String targetingTemplateId;
  /**
   * Technology platform targeting information for this ad. This field must be
   * left blank if the ad is using a targeting template. Applicable when type is
   * AD_SERVING_STANDARD_AD.
   */
  TechnologyTargeting technologyTargeting;
  /**
   * Type of ad. This is a required field on insertion. Note that default ads
   * (AD_SERVING_DEFAULT_AD) cannot be created directly (see Creative resource).
   * Possible string values are:
   * - "AD_SERVING_CLICK_TRACKER"
   * - "AD_SERVING_DEFAULT_AD"
   * - "AD_SERVING_STANDARD_AD"
   * - "AD_SERVING_TRACKING"
   */
  core.String type;

  Ad();

  Ad.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("archived")) {
      archived = _json["archived"];
    }
    if (_json.containsKey("audienceSegmentId")) {
      audienceSegmentId = _json["audienceSegmentId"];
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("campaignIdDimensionValue")) {
      campaignIdDimensionValue = new DimensionValue.fromJson(_json["campaignIdDimensionValue"]);
    }
    if (_json.containsKey("clickThroughUrl")) {
      clickThroughUrl = new ClickThroughUrl.fromJson(_json["clickThroughUrl"]);
    }
    if (_json.containsKey("clickThroughUrlSuffixProperties")) {
      clickThroughUrlSuffixProperties = new ClickThroughUrlSuffixProperties.fromJson(_json["clickThroughUrlSuffixProperties"]);
    }
    if (_json.containsKey("comments")) {
      comments = _json["comments"];
    }
    if (_json.containsKey("compatibility")) {
      compatibility = _json["compatibility"];
    }
    if (_json.containsKey("createInfo")) {
      createInfo = new LastModifiedInfo.fromJson(_json["createInfo"]);
    }
    if (_json.containsKey("creativeGroupAssignments")) {
      creativeGroupAssignments = _json["creativeGroupAssignments"].map((value) => new CreativeGroupAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeRotation")) {
      creativeRotation = new CreativeRotation.fromJson(_json["creativeRotation"]);
    }
    if (_json.containsKey("dayPartTargeting")) {
      dayPartTargeting = new DayPartTargeting.fromJson(_json["dayPartTargeting"]);
    }
    if (_json.containsKey("defaultClickThroughEventTagProperties")) {
      defaultClickThroughEventTagProperties = new DefaultClickThroughEventTagProperties.fromJson(_json["defaultClickThroughEventTagProperties"]);
    }
    if (_json.containsKey("deliverySchedule")) {
      deliverySchedule = new DeliverySchedule.fromJson(_json["deliverySchedule"]);
    }
    if (_json.containsKey("dynamicClickTracker")) {
      dynamicClickTracker = _json["dynamicClickTracker"];
    }
    if (_json.containsKey("endTime")) {
      endTime = core.DateTime.parse(_json["endTime"]);
    }
    if (_json.containsKey("eventTagOverrides")) {
      eventTagOverrides = _json["eventTagOverrides"].map((value) => new EventTagOverride.fromJson(value)).toList();
    }
    if (_json.containsKey("geoTargeting")) {
      geoTargeting = new GeoTargeting.fromJson(_json["geoTargeting"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("keyValueTargetingExpression")) {
      keyValueTargetingExpression = new KeyValueTargetingExpression.fromJson(_json["keyValueTargetingExpression"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languageTargeting")) {
      languageTargeting = new LanguageTargeting.fromJson(_json["languageTargeting"]);
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("placementAssignments")) {
      placementAssignments = _json["placementAssignments"].map((value) => new PlacementAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("remarketingListExpression")) {
      remarketingListExpression = new ListTargetingExpression.fromJson(_json["remarketingListExpression"]);
    }
    if (_json.containsKey("size")) {
      size = new Size.fromJson(_json["size"]);
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("sslRequired")) {
      sslRequired = _json["sslRequired"];
    }
    if (_json.containsKey("startTime")) {
      startTime = core.DateTime.parse(_json["startTime"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("targetingTemplateId")) {
      targetingTemplateId = _json["targetingTemplateId"];
    }
    if (_json.containsKey("technologyTargeting")) {
      technologyTargeting = new TechnologyTargeting.fromJson(_json["technologyTargeting"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (archived != null) {
      _json["archived"] = archived;
    }
    if (audienceSegmentId != null) {
      _json["audienceSegmentId"] = audienceSegmentId;
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (campaignIdDimensionValue != null) {
      _json["campaignIdDimensionValue"] = (campaignIdDimensionValue).toJson();
    }
    if (clickThroughUrl != null) {
      _json["clickThroughUrl"] = (clickThroughUrl).toJson();
    }
    if (clickThroughUrlSuffixProperties != null) {
      _json["clickThroughUrlSuffixProperties"] = (clickThroughUrlSuffixProperties).toJson();
    }
    if (comments != null) {
      _json["comments"] = comments;
    }
    if (compatibility != null) {
      _json["compatibility"] = compatibility;
    }
    if (createInfo != null) {
      _json["createInfo"] = (createInfo).toJson();
    }
    if (creativeGroupAssignments != null) {
      _json["creativeGroupAssignments"] = creativeGroupAssignments.map((value) => (value).toJson()).toList();
    }
    if (creativeRotation != null) {
      _json["creativeRotation"] = (creativeRotation).toJson();
    }
    if (dayPartTargeting != null) {
      _json["dayPartTargeting"] = (dayPartTargeting).toJson();
    }
    if (defaultClickThroughEventTagProperties != null) {
      _json["defaultClickThroughEventTagProperties"] = (defaultClickThroughEventTagProperties).toJson();
    }
    if (deliverySchedule != null) {
      _json["deliverySchedule"] = (deliverySchedule).toJson();
    }
    if (dynamicClickTracker != null) {
      _json["dynamicClickTracker"] = dynamicClickTracker;
    }
    if (endTime != null) {
      _json["endTime"] = (endTime).toIso8601String();
    }
    if (eventTagOverrides != null) {
      _json["eventTagOverrides"] = eventTagOverrides.map((value) => (value).toJson()).toList();
    }
    if (geoTargeting != null) {
      _json["geoTargeting"] = (geoTargeting).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (keyValueTargetingExpression != null) {
      _json["keyValueTargetingExpression"] = (keyValueTargetingExpression).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languageTargeting != null) {
      _json["languageTargeting"] = (languageTargeting).toJson();
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (placementAssignments != null) {
      _json["placementAssignments"] = placementAssignments.map((value) => (value).toJson()).toList();
    }
    if (remarketingListExpression != null) {
      _json["remarketingListExpression"] = (remarketingListExpression).toJson();
    }
    if (size != null) {
      _json["size"] = (size).toJson();
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (sslRequired != null) {
      _json["sslRequired"] = sslRequired;
    }
    if (startTime != null) {
      _json["startTime"] = (startTime).toIso8601String();
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (targetingTemplateId != null) {
      _json["targetingTemplateId"] = targetingTemplateId;
    }
    if (technologyTargeting != null) {
      _json["technologyTargeting"] = (technologyTargeting).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Ad Slot */
class AdSlot {
  /** Comment for this ad slot. */
  core.String comment;
  /**
   * Ad slot compatibility. DISPLAY and DISPLAY_INTERSTITIAL refer to rendering
   * either on desktop, mobile devices or in mobile apps for regular or
   * interstitial ads respectively. APP and APP_INTERSTITIAL are for rendering
   * in mobile apps. IN_STREAM_VIDEO refers to rendering in in-stream video ads
   * developed with the VAST standard.
   * Possible string values are:
   * - "APP"
   * - "APP_INTERSTITIAL"
   * - "DISPLAY"
   * - "DISPLAY_INTERSTITIAL"
   * - "IN_STREAM_VIDEO"
   */
  core.String compatibility;
  /** Height of this ad slot. */
  core.String height;
  /**
   * ID of the placement from an external platform that is linked to this ad
   * slot.
   */
  core.String linkedPlacementId;
  /** Name of this ad slot. */
  core.String name;
  /**
   * Payment source type of this ad slot.
   * Possible string values are:
   * - "PLANNING_PAYMENT_SOURCE_TYPE_AGENCY_PAID"
   * - "PLANNING_PAYMENT_SOURCE_TYPE_PUBLISHER_PAID"
   */
  core.String paymentSourceType;
  /** Primary ad slot of a roadblock inventory item. */
  core.bool primary;
  /** Width of this ad slot. */
  core.String width;

  AdSlot();

  AdSlot.fromJson(core.Map _json) {
    if (_json.containsKey("comment")) {
      comment = _json["comment"];
    }
    if (_json.containsKey("compatibility")) {
      compatibility = _json["compatibility"];
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("linkedPlacementId")) {
      linkedPlacementId = _json["linkedPlacementId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("paymentSourceType")) {
      paymentSourceType = _json["paymentSourceType"];
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comment != null) {
      _json["comment"] = comment;
    }
    if (compatibility != null) {
      _json["compatibility"] = compatibility;
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (linkedPlacementId != null) {
      _json["linkedPlacementId"] = linkedPlacementId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (paymentSourceType != null) {
      _json["paymentSourceType"] = paymentSourceType;
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** Ad List Response */
class AdsListResponse {
  /** Ad collection. */
  core.List<Ad> ads;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#adsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  AdsListResponse();

  AdsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("ads")) {
      ads = _json["ads"].map((value) => new Ad.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ads != null) {
      _json["ads"] = ads.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Contains properties of a DCM advertiser. */
class Advertiser {
  /**
   * Account ID of this advertiser.This is a read-only field that can be left
   * blank.
   */
  core.String accountId;
  /**
   * ID of the advertiser group this advertiser belongs to. You can group
   * advertisers for reporting purposes, allowing you to see aggregated
   * information for all advertisers in each group.
   */
  core.String advertiserGroupId;
  /**
   * Suffix added to click-through URL of ad creative associations under this
   * advertiser. Must be less than 129 characters long.
   */
  core.String clickThroughUrlSuffix;
  /**
   * ID of the click-through event tag to apply by default to the landing pages
   * of this advertiser's campaigns.
   */
  core.String defaultClickThroughEventTagId;
  /** Default email address used in sender field for tag emails. */
  core.String defaultEmail;
  /**
   * Floodlight configuration ID of this advertiser. The floodlight
   * configuration ID will be created automatically, so on insert this field
   * should be left blank. This field can be set to another advertiser's
   * floodlight configuration ID in order to share that advertiser's floodlight
   * configuration with this advertiser, so long as:
   * - This advertiser's original floodlight configuration is not already
   * associated with floodlight activities or floodlight activity groups.
   * - This advertiser's original floodlight configuration is not already shared
   * with another advertiser.
   */
  core.String floodlightConfigurationId;
  /**
   * Dimension value for the ID of the floodlight configuration. This is a
   * read-only, auto-generated field.
   */
  DimensionValue floodlightConfigurationIdDimensionValue;
  /** ID of this advertiser. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#advertiser".
   */
  core.String kind;
  /**
   * Name of this advertiser. This is a required field and must be less than 256
   * characters long and unique among advertisers of the same account.
   */
  core.String name;
  /**
   * Original floodlight configuration before any sharing occurred. Set the
   * floodlightConfigurationId of this advertiser to
   * originalFloodlightConfigurationId to unshare the advertiser's current
   * floodlight configuration. You cannot unshare an advertiser's floodlight
   * configuration if the shared configuration has activities associated with
   * any campaign or placement.
   */
  core.String originalFloodlightConfigurationId;
  /**
   * Status of this advertiser.
   * Possible string values are:
   * - "APPROVED"
   * - "ON_HOLD"
   */
  core.String status;
  /**
   * Subaccount ID of this advertiser.This is a read-only field that can be left
   * blank.
   */
  core.String subaccountId;
  /** Suspension status of this advertiser. */
  core.bool suspended;

  Advertiser();

  Advertiser.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserGroupId")) {
      advertiserGroupId = _json["advertiserGroupId"];
    }
    if (_json.containsKey("clickThroughUrlSuffix")) {
      clickThroughUrlSuffix = _json["clickThroughUrlSuffix"];
    }
    if (_json.containsKey("defaultClickThroughEventTagId")) {
      defaultClickThroughEventTagId = _json["defaultClickThroughEventTagId"];
    }
    if (_json.containsKey("defaultEmail")) {
      defaultEmail = _json["defaultEmail"];
    }
    if (_json.containsKey("floodlightConfigurationId")) {
      floodlightConfigurationId = _json["floodlightConfigurationId"];
    }
    if (_json.containsKey("floodlightConfigurationIdDimensionValue")) {
      floodlightConfigurationIdDimensionValue = new DimensionValue.fromJson(_json["floodlightConfigurationIdDimensionValue"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("originalFloodlightConfigurationId")) {
      originalFloodlightConfigurationId = _json["originalFloodlightConfigurationId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("suspended")) {
      suspended = _json["suspended"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserGroupId != null) {
      _json["advertiserGroupId"] = advertiserGroupId;
    }
    if (clickThroughUrlSuffix != null) {
      _json["clickThroughUrlSuffix"] = clickThroughUrlSuffix;
    }
    if (defaultClickThroughEventTagId != null) {
      _json["defaultClickThroughEventTagId"] = defaultClickThroughEventTagId;
    }
    if (defaultEmail != null) {
      _json["defaultEmail"] = defaultEmail;
    }
    if (floodlightConfigurationId != null) {
      _json["floodlightConfigurationId"] = floodlightConfigurationId;
    }
    if (floodlightConfigurationIdDimensionValue != null) {
      _json["floodlightConfigurationIdDimensionValue"] = (floodlightConfigurationIdDimensionValue).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (originalFloodlightConfigurationId != null) {
      _json["originalFloodlightConfigurationId"] = originalFloodlightConfigurationId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (suspended != null) {
      _json["suspended"] = suspended;
    }
    return _json;
  }
}

/**
 * Groups advertisers together so that reports can be generated for the entire
 * group at once.
 */
class AdvertiserGroup {
  /**
   * Account ID of this advertiser group. This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * ID of this advertiser group. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#advertiserGroup".
   */
  core.String kind;
  /**
   * Name of this advertiser group. This is a required field and must be less
   * than 256 characters long and unique among advertiser groups of the same
   * account.
   */
  core.String name;

  AdvertiserGroup();

  AdvertiserGroup.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Advertiser Group List Response */
class AdvertiserGroupsListResponse {
  /** Advertiser group collection. */
  core.List<AdvertiserGroup> advertiserGroups;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#advertiserGroupsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  AdvertiserGroupsListResponse();

  AdvertiserGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("advertiserGroups")) {
      advertiserGroups = _json["advertiserGroups"].map((value) => new AdvertiserGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertiserGroups != null) {
      _json["advertiserGroups"] = advertiserGroups.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Advertiser List Response */
class AdvertisersListResponse {
  /** Advertiser collection. */
  core.List<Advertiser> advertisers;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#advertisersListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  AdvertisersListResponse();

  AdvertisersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("advertisers")) {
      advertisers = _json["advertisers"].map((value) => new Advertiser.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertisers != null) {
      _json["advertisers"] = advertisers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Audience Segment. */
class AudienceSegment {
  /**
   * Weight allocated to this segment. Must be between 1 and 1000. The weight
   * assigned will be understood in proportion to the weights assigned to other
   * segments in the same segment group.
   */
  core.int allocation;
  /**
   * ID of this audience segment. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Name of this audience segment. This is a required field and must be less
   * than 65 characters long.
   */
  core.String name;

  AudienceSegment();

  AudienceSegment.fromJson(core.Map _json) {
    if (_json.containsKey("allocation")) {
      allocation = _json["allocation"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allocation != null) {
      _json["allocation"] = allocation;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Audience Segment Group. */
class AudienceSegmentGroup {
  /**
   * Audience segments assigned to this group. The number of segments must be
   * between 2 and 100.
   */
  core.List<AudienceSegment> audienceSegments;
  /**
   * ID of this audience segment group. This is a read-only, auto-generated
   * field.
   */
  core.String id;
  /**
   * Name of this audience segment group. This is a required field and must be
   * less than 65 characters long.
   */
  core.String name;

  AudienceSegmentGroup();

  AudienceSegmentGroup.fromJson(core.Map _json) {
    if (_json.containsKey("audienceSegments")) {
      audienceSegments = _json["audienceSegments"].map((value) => new AudienceSegment.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audienceSegments != null) {
      _json["audienceSegments"] = audienceSegments.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Contains information about a browser that can be targeted by ads. */
class Browser {
  /**
   * ID referring to this grouping of browser and version numbers. This is the
   * ID used for targeting.
   */
  core.String browserVersionId;
  /** DART ID of this browser. This is the ID used when generating reports. */
  core.String dartId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#browser".
   */
  core.String kind;
  /**
   * Major version number (leftmost number) of this browser. For example, for
   * Chrome 5.0.376.86 beta, this field should be set to 5. An asterisk (*) may
   * be used to target any version number, and a question mark (?) may be used
   * to target cases where the version number cannot be identified. For example,
   * Chrome *.* targets any version of Chrome: 1.2, 2.5, 3.5, and so on. Chrome
   * 3.* targets Chrome 3.1, 3.5, but not 4.0. Firefox ?.? targets cases where
   * the ad server knows the browser is Firefox but can't tell which version it
   * is.
   */
  core.String majorVersion;
  /**
   * Minor version number (number after first dot on left) of this browser. For
   * example, for Chrome 5.0.375.86 beta, this field should be set to 0. An
   * asterisk (*) may be used to target any version number, and a question mark
   * (?) may be used to target cases where the version number cannot be
   * identified. For example, Chrome *.* targets any version of Chrome: 1.2,
   * 2.5, 3.5, and so on. Chrome 3.* targets Chrome 3.1, 3.5, but not 4.0.
   * Firefox ?.? targets cases where the ad server knows the browser is Firefox
   * but can't tell which version it is.
   */
  core.String minorVersion;
  /** Name of this browser. */
  core.String name;

  Browser();

  Browser.fromJson(core.Map _json) {
    if (_json.containsKey("browserVersionId")) {
      browserVersionId = _json["browserVersionId"];
    }
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("majorVersion")) {
      majorVersion = _json["majorVersion"];
    }
    if (_json.containsKey("minorVersion")) {
      minorVersion = _json["minorVersion"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (browserVersionId != null) {
      _json["browserVersionId"] = browserVersionId;
    }
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (majorVersion != null) {
      _json["majorVersion"] = majorVersion;
    }
    if (minorVersion != null) {
      _json["minorVersion"] = minorVersion;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Browser List Response */
class BrowsersListResponse {
  /** Browser collection. */
  core.List<Browser> browsers;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#browsersListResponse".
   */
  core.String kind;

  BrowsersListResponse();

  BrowsersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("browsers")) {
      browsers = _json["browsers"].map((value) => new Browser.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (browsers != null) {
      _json["browsers"] = browsers.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains properties of a DCM campaign. */
class Campaign {
  /**
   * Account ID of this campaign. This is a read-only field that can be left
   * blank.
   */
  core.String accountId;
  /** Additional creative optimization configurations for the campaign. */
  core.List<CreativeOptimizationConfiguration> additionalCreativeOptimizationConfigurations;
  /** Advertiser group ID of the associated advertiser. */
  core.String advertiserGroupId;
  /** Advertiser ID of this campaign. This is a required field. */
  core.String advertiserId;
  /**
   * Dimension value for the advertiser ID of this campaign. This is a
   * read-only, auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Whether this campaign has been archived. */
  core.bool archived;
  /**
   * Audience segment groups assigned to this campaign. Cannot have more than
   * 300 segment groups.
   */
  core.List<AudienceSegmentGroup> audienceSegmentGroups;
  /**
   * Billing invoice code included in the DCM client billing invoices associated
   * with the campaign.
   */
  core.String billingInvoiceCode;
  /** Click-through URL suffix override properties for this campaign. */
  ClickThroughUrlSuffixProperties clickThroughUrlSuffixProperties;
  /**
   * Arbitrary comments about this campaign. Must be less than 256 characters
   * long.
   */
  core.String comment;
  /**
   * Information about the creation of this campaign. This is a read-only field.
   */
  LastModifiedInfo createInfo;
  /** List of creative group IDs that are assigned to the campaign. */
  core.List<core.String> creativeGroupIds;
  /** Creative optimization configuration for the campaign. */
  CreativeOptimizationConfiguration creativeOptimizationConfiguration;
  /** Click-through event tag ID override properties for this campaign. */
  DefaultClickThroughEventTagProperties defaultClickThroughEventTagProperties;
  /**
   * Date on which the campaign will stop running. On insert, the end date must
   * be today or a future date. The end date must be later than or be the same
   * as the start date. If, for example, you set 6/25/2015 as both the start and
   * end dates, the effective campaign run date is just that day only,
   * 6/25/2015. The hours, minutes, and seconds of the end date should not be
   * set, as doing so will result in an error. This is a required field.
   */
  core.DateTime endDate;
  /**
   * Overrides that can be used to activate or deactivate advertiser event tags.
   */
  core.List<EventTagOverride> eventTagOverrides;
  /** External ID for this campaign. */
  core.String externalId;
  /** ID of this campaign. This is a read-only auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this campaign. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#campaign".
   */
  core.String kind;
  /**
   * Information about the most recent modification of this campaign. This is a
   * read-only field.
   */
  LastModifiedInfo lastModifiedInfo;
  /** Lookback window settings for the campaign. */
  LookbackConfiguration lookbackConfiguration;
  /**
   * Name of this campaign. This is a required field and must be less than 256
   * characters long and unique among campaigns of the same advertiser.
   */
  core.String name;
  /** Whether Nielsen reports are enabled for this campaign. */
  core.bool nielsenOcrEnabled;
  /**
   * Date on which the campaign starts running. The start date can be any date.
   * The hours, minutes, and seconds of the start date should not be set, as
   * doing so will result in an error. This is a required field.
   */
  core.DateTime startDate;
  /**
   * Subaccount ID of this campaign. This is a read-only field that can be left
   * blank.
   */
  core.String subaccountId;
  /** Campaign trafficker contact emails. */
  core.List<core.String> traffickerEmails;

  Campaign();

  Campaign.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("additionalCreativeOptimizationConfigurations")) {
      additionalCreativeOptimizationConfigurations = _json["additionalCreativeOptimizationConfigurations"].map((value) => new CreativeOptimizationConfiguration.fromJson(value)).toList();
    }
    if (_json.containsKey("advertiserGroupId")) {
      advertiserGroupId = _json["advertiserGroupId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("archived")) {
      archived = _json["archived"];
    }
    if (_json.containsKey("audienceSegmentGroups")) {
      audienceSegmentGroups = _json["audienceSegmentGroups"].map((value) => new AudienceSegmentGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("billingInvoiceCode")) {
      billingInvoiceCode = _json["billingInvoiceCode"];
    }
    if (_json.containsKey("clickThroughUrlSuffixProperties")) {
      clickThroughUrlSuffixProperties = new ClickThroughUrlSuffixProperties.fromJson(_json["clickThroughUrlSuffixProperties"]);
    }
    if (_json.containsKey("comment")) {
      comment = _json["comment"];
    }
    if (_json.containsKey("createInfo")) {
      createInfo = new LastModifiedInfo.fromJson(_json["createInfo"]);
    }
    if (_json.containsKey("creativeGroupIds")) {
      creativeGroupIds = _json["creativeGroupIds"];
    }
    if (_json.containsKey("creativeOptimizationConfiguration")) {
      creativeOptimizationConfiguration = new CreativeOptimizationConfiguration.fromJson(_json["creativeOptimizationConfiguration"]);
    }
    if (_json.containsKey("defaultClickThroughEventTagProperties")) {
      defaultClickThroughEventTagProperties = new DefaultClickThroughEventTagProperties.fromJson(_json["defaultClickThroughEventTagProperties"]);
    }
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("eventTagOverrides")) {
      eventTagOverrides = _json["eventTagOverrides"].map((value) => new EventTagOverride.fromJson(value)).toList();
    }
    if (_json.containsKey("externalId")) {
      externalId = _json["externalId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("lookbackConfiguration")) {
      lookbackConfiguration = new LookbackConfiguration.fromJson(_json["lookbackConfiguration"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("nielsenOcrEnabled")) {
      nielsenOcrEnabled = _json["nielsenOcrEnabled"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("traffickerEmails")) {
      traffickerEmails = _json["traffickerEmails"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (additionalCreativeOptimizationConfigurations != null) {
      _json["additionalCreativeOptimizationConfigurations"] = additionalCreativeOptimizationConfigurations.map((value) => (value).toJson()).toList();
    }
    if (advertiserGroupId != null) {
      _json["advertiserGroupId"] = advertiserGroupId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (archived != null) {
      _json["archived"] = archived;
    }
    if (audienceSegmentGroups != null) {
      _json["audienceSegmentGroups"] = audienceSegmentGroups.map((value) => (value).toJson()).toList();
    }
    if (billingInvoiceCode != null) {
      _json["billingInvoiceCode"] = billingInvoiceCode;
    }
    if (clickThroughUrlSuffixProperties != null) {
      _json["clickThroughUrlSuffixProperties"] = (clickThroughUrlSuffixProperties).toJson();
    }
    if (comment != null) {
      _json["comment"] = comment;
    }
    if (createInfo != null) {
      _json["createInfo"] = (createInfo).toJson();
    }
    if (creativeGroupIds != null) {
      _json["creativeGroupIds"] = creativeGroupIds;
    }
    if (creativeOptimizationConfiguration != null) {
      _json["creativeOptimizationConfiguration"] = (creativeOptimizationConfiguration).toJson();
    }
    if (defaultClickThroughEventTagProperties != null) {
      _json["defaultClickThroughEventTagProperties"] = (defaultClickThroughEventTagProperties).toJson();
    }
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (eventTagOverrides != null) {
      _json["eventTagOverrides"] = eventTagOverrides.map((value) => (value).toJson()).toList();
    }
    if (externalId != null) {
      _json["externalId"] = externalId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (lookbackConfiguration != null) {
      _json["lookbackConfiguration"] = (lookbackConfiguration).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (nielsenOcrEnabled != null) {
      _json["nielsenOcrEnabled"] = nielsenOcrEnabled;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (traffickerEmails != null) {
      _json["traffickerEmails"] = traffickerEmails;
    }
    return _json;
  }
}

/** Identifies a creative which has been associated with a given campaign. */
class CampaignCreativeAssociation {
  /**
   * ID of the creative associated with the campaign. This is a required field.
   */
  core.String creativeId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#campaignCreativeAssociation".
   */
  core.String kind;

  CampaignCreativeAssociation();

  CampaignCreativeAssociation.fromJson(core.Map _json) {
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Campaign Creative Association List Response */
class CampaignCreativeAssociationsListResponse {
  /** Campaign creative association collection */
  core.List<CampaignCreativeAssociation> campaignCreativeAssociations;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#campaignCreativeAssociationsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CampaignCreativeAssociationsListResponse();

  CampaignCreativeAssociationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("campaignCreativeAssociations")) {
      campaignCreativeAssociations = _json["campaignCreativeAssociations"].map((value) => new CampaignCreativeAssociation.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (campaignCreativeAssociations != null) {
      _json["campaignCreativeAssociations"] = campaignCreativeAssociations.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Campaign List Response */
class CampaignsListResponse {
  /** Campaign collection. */
  core.List<Campaign> campaigns;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#campaignsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CampaignsListResponse();

  CampaignsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("campaigns")) {
      campaigns = _json["campaigns"].map((value) => new Campaign.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (campaigns != null) {
      _json["campaigns"] = campaigns.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Describes a change that a user has made to a resource. */
class ChangeLog {
  /** Account ID of the modified object. */
  core.String accountId;
  /** Action which caused the change. */
  core.String action;
  /** Time when the object was modified. */
  core.DateTime changeTime;
  /** Field name of the object which changed. */
  core.String fieldName;
  /** ID of this change log. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#changeLog".
   */
  core.String kind;
  /** New value of the object field. */
  core.String newValue;
  /**
   * ID of the object of this change log. The object could be a campaign,
   * placement, ad, or other type.
   */
  core.String objectId;
  /** Object type of the change log. */
  core.String objectType;
  /** Old value of the object field. */
  core.String oldValue;
  /** Subaccount ID of the modified object. */
  core.String subaccountId;
  /**
   * Transaction ID of this change log. When a single API call results in many
   * changes, each change will have a separate ID in the change log but will
   * share the same transactionId.
   */
  core.String transactionId;
  /** ID of the user who modified the object. */
  core.String userProfileId;
  /** User profile name of the user who modified the object. */
  core.String userProfileName;

  ChangeLog();

  ChangeLog.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("action")) {
      action = _json["action"];
    }
    if (_json.containsKey("changeTime")) {
      changeTime = core.DateTime.parse(_json["changeTime"]);
    }
    if (_json.containsKey("fieldName")) {
      fieldName = _json["fieldName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("newValue")) {
      newValue = _json["newValue"];
    }
    if (_json.containsKey("objectId")) {
      objectId = _json["objectId"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("oldValue")) {
      oldValue = _json["oldValue"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("transactionId")) {
      transactionId = _json["transactionId"];
    }
    if (_json.containsKey("userProfileId")) {
      userProfileId = _json["userProfileId"];
    }
    if (_json.containsKey("userProfileName")) {
      userProfileName = _json["userProfileName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (action != null) {
      _json["action"] = action;
    }
    if (changeTime != null) {
      _json["changeTime"] = (changeTime).toIso8601String();
    }
    if (fieldName != null) {
      _json["fieldName"] = fieldName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (newValue != null) {
      _json["newValue"] = newValue;
    }
    if (objectId != null) {
      _json["objectId"] = objectId;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (oldValue != null) {
      _json["oldValue"] = oldValue;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (transactionId != null) {
      _json["transactionId"] = transactionId;
    }
    if (userProfileId != null) {
      _json["userProfileId"] = userProfileId;
    }
    if (userProfileName != null) {
      _json["userProfileName"] = userProfileName;
    }
    return _json;
  }
}

/** Change Log List Response */
class ChangeLogsListResponse {
  /** Change log collection. */
  core.List<ChangeLog> changeLogs;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#changeLogsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  ChangeLogsListResponse();

  ChangeLogsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("changeLogs")) {
      changeLogs = _json["changeLogs"].map((value) => new ChangeLog.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (changeLogs != null) {
      _json["changeLogs"] = changeLogs.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** City List Response */
class CitiesListResponse {
  /** City collection. */
  core.List<City> cities;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#citiesListResponse".
   */
  core.String kind;

  CitiesListResponse();

  CitiesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("cities")) {
      cities = _json["cities"].map((value) => new City.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cities != null) {
      _json["cities"] = cities.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains information about a city that can be targeted by ads. */
class City {
  /** Country code of the country to which this city belongs. */
  core.String countryCode;
  /** DART ID of the country to which this city belongs. */
  core.String countryDartId;
  /**
   * DART ID of this city. This is the ID used for targeting and generating
   * reports.
   */
  core.String dartId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#city".
   */
  core.String kind;
  /**
   * Metro region code of the metro region (DMA) to which this city belongs.
   */
  core.String metroCode;
  /** ID of the metro region (DMA) to which this city belongs. */
  core.String metroDmaId;
  /** Name of this city. */
  core.String name;
  /** Region code of the region to which this city belongs. */
  core.String regionCode;
  /** DART ID of the region to which this city belongs. */
  core.String regionDartId;

  City();

  City.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("countryDartId")) {
      countryDartId = _json["countryDartId"];
    }
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metroCode")) {
      metroCode = _json["metroCode"];
    }
    if (_json.containsKey("metroDmaId")) {
      metroDmaId = _json["metroDmaId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("regionCode")) {
      regionCode = _json["regionCode"];
    }
    if (_json.containsKey("regionDartId")) {
      regionDartId = _json["regionDartId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (countryDartId != null) {
      _json["countryDartId"] = countryDartId;
    }
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metroCode != null) {
      _json["metroCode"] = metroCode;
    }
    if (metroDmaId != null) {
      _json["metroDmaId"] = metroDmaId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (regionCode != null) {
      _json["regionCode"] = regionCode;
    }
    if (regionDartId != null) {
      _json["regionDartId"] = regionDartId;
    }
    return _json;
  }
}

/** Creative Click Tag. */
class ClickTag {
  /**
   * Advertiser event name associated with the click tag. This field is used by
   * DISPLAY_IMAGE_GALLERY and HTML5_BANNER creatives. Applicable to DISPLAY
   * when the primary asset type is not HTML_IMAGE.
   */
  core.String eventName;
  /**
   * Parameter name for the specified click tag. For DISPLAY_IMAGE_GALLERY
   * creative assets, this field must match the value of the creative asset's
   * creativeAssetId.name field.
   */
  core.String name;
  /**
   * Parameter value for the specified click tag. This field contains a
   * click-through url.
   */
  core.String value;

  ClickTag();

  ClickTag.fromJson(core.Map _json) {
    if (_json.containsKey("eventName")) {
      eventName = _json["eventName"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventName != null) {
      _json["eventName"] = eventName;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Click-through URL */
class ClickThroughUrl {
  /**
   * Read-only convenience field representing the actual URL that will be used
   * for this click-through. The URL is computed as follows:
   * - If defaultLandingPage is enabled then the campaign's default landing page
   * URL is assigned to this field.
   * - If defaultLandingPage is not enabled and a landingPageId is specified
   * then that landing page's URL is assigned to this field.
   * - If neither of the above cases apply, then the customClickThroughUrl is
   * assigned to this field.
   */
  core.String computedClickThroughUrl;
  /**
   * Custom click-through URL. Applicable if the defaultLandingPage field is set
   * to false and the landingPageId field is left unset.
   */
  core.String customClickThroughUrl;
  /** Whether the campaign default landing page is used. */
  core.bool defaultLandingPage;
  /**
   * ID of the landing page for the click-through URL. Applicable if the
   * defaultLandingPage field is set to false.
   */
  core.String landingPageId;

  ClickThroughUrl();

  ClickThroughUrl.fromJson(core.Map _json) {
    if (_json.containsKey("computedClickThroughUrl")) {
      computedClickThroughUrl = _json["computedClickThroughUrl"];
    }
    if (_json.containsKey("customClickThroughUrl")) {
      customClickThroughUrl = _json["customClickThroughUrl"];
    }
    if (_json.containsKey("defaultLandingPage")) {
      defaultLandingPage = _json["defaultLandingPage"];
    }
    if (_json.containsKey("landingPageId")) {
      landingPageId = _json["landingPageId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (computedClickThroughUrl != null) {
      _json["computedClickThroughUrl"] = computedClickThroughUrl;
    }
    if (customClickThroughUrl != null) {
      _json["customClickThroughUrl"] = customClickThroughUrl;
    }
    if (defaultLandingPage != null) {
      _json["defaultLandingPage"] = defaultLandingPage;
    }
    if (landingPageId != null) {
      _json["landingPageId"] = landingPageId;
    }
    return _json;
  }
}

/** Click Through URL Suffix settings. */
class ClickThroughUrlSuffixProperties {
  /**
   * Click-through URL suffix to apply to all ads in this entity's scope. Must
   * be less than 128 characters long.
   */
  core.String clickThroughUrlSuffix;
  /**
   * Whether this entity should override the inherited click-through URL suffix
   * with its own defined value.
   */
  core.bool overrideInheritedSuffix;

  ClickThroughUrlSuffixProperties();

  ClickThroughUrlSuffixProperties.fromJson(core.Map _json) {
    if (_json.containsKey("clickThroughUrlSuffix")) {
      clickThroughUrlSuffix = _json["clickThroughUrlSuffix"];
    }
    if (_json.containsKey("overrideInheritedSuffix")) {
      overrideInheritedSuffix = _json["overrideInheritedSuffix"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clickThroughUrlSuffix != null) {
      _json["clickThroughUrlSuffix"] = clickThroughUrlSuffix;
    }
    if (overrideInheritedSuffix != null) {
      _json["overrideInheritedSuffix"] = overrideInheritedSuffix;
    }
    return _json;
  }
}

/** Companion Click-through override. */
class CompanionClickThroughOverride {
  /** Click-through URL of this companion click-through override. */
  ClickThroughUrl clickThroughUrl;
  /** ID of the creative for this companion click-through override. */
  core.String creativeId;

  CompanionClickThroughOverride();

  CompanionClickThroughOverride.fromJson(core.Map _json) {
    if (_json.containsKey("clickThroughUrl")) {
      clickThroughUrl = new ClickThroughUrl.fromJson(_json["clickThroughUrl"]);
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clickThroughUrl != null) {
      _json["clickThroughUrl"] = (clickThroughUrl).toJson();
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    return _json;
  }
}

/** Companion Settings */
class CompanionSetting {
  /** Whether companions are disabled for this placement. */
  core.bool companionsDisabled;
  /**
   * Whitelist of companion sizes to be served to this placement. Set this list
   * to null or empty to serve all companion sizes.
   */
  core.List<Size> enabledSizes;
  /** Whether to serve only static images as companions. */
  core.bool imageOnly;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#companionSetting".
   */
  core.String kind;

  CompanionSetting();

  CompanionSetting.fromJson(core.Map _json) {
    if (_json.containsKey("companionsDisabled")) {
      companionsDisabled = _json["companionsDisabled"];
    }
    if (_json.containsKey("enabledSizes")) {
      enabledSizes = _json["enabledSizes"].map((value) => new Size.fromJson(value)).toList();
    }
    if (_json.containsKey("imageOnly")) {
      imageOnly = _json["imageOnly"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (companionsDisabled != null) {
      _json["companionsDisabled"] = companionsDisabled;
    }
    if (enabledSizes != null) {
      _json["enabledSizes"] = enabledSizes.map((value) => (value).toJson()).toList();
    }
    if (imageOnly != null) {
      _json["imageOnly"] = imageOnly;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Represents a response to the queryCompatibleFields method. */
class CompatibleFields {
  /**
   * Contains items that are compatible to be selected for a report of type
   * "CROSS_DIMENSION_REACH".
   */
  CrossDimensionReachReportCompatibleFields crossDimensionReachReportCompatibleFields;
  /**
   * Contains items that are compatible to be selected for a report of type
   * "FLOODLIGHT".
   */
  FloodlightReportCompatibleFields floodlightReportCompatibleFields;
  /**
   * The kind of resource this is, in this case dfareporting#compatibleFields.
   */
  core.String kind;
  /**
   * Contains items that are compatible to be selected for a report of type
   * "PATH_TO_CONVERSION".
   */
  PathToConversionReportCompatibleFields pathToConversionReportCompatibleFields;
  /**
   * Contains items that are compatible to be selected for a report of type
   * "REACH".
   */
  ReachReportCompatibleFields reachReportCompatibleFields;
  /**
   * Contains items that are compatible to be selected for a report of type
   * "STANDARD".
   */
  ReportCompatibleFields reportCompatibleFields;

  CompatibleFields();

  CompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("crossDimensionReachReportCompatibleFields")) {
      crossDimensionReachReportCompatibleFields = new CrossDimensionReachReportCompatibleFields.fromJson(_json["crossDimensionReachReportCompatibleFields"]);
    }
    if (_json.containsKey("floodlightReportCompatibleFields")) {
      floodlightReportCompatibleFields = new FloodlightReportCompatibleFields.fromJson(_json["floodlightReportCompatibleFields"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pathToConversionReportCompatibleFields")) {
      pathToConversionReportCompatibleFields = new PathToConversionReportCompatibleFields.fromJson(_json["pathToConversionReportCompatibleFields"]);
    }
    if (_json.containsKey("reachReportCompatibleFields")) {
      reachReportCompatibleFields = new ReachReportCompatibleFields.fromJson(_json["reachReportCompatibleFields"]);
    }
    if (_json.containsKey("reportCompatibleFields")) {
      reportCompatibleFields = new ReportCompatibleFields.fromJson(_json["reportCompatibleFields"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (crossDimensionReachReportCompatibleFields != null) {
      _json["crossDimensionReachReportCompatibleFields"] = (crossDimensionReachReportCompatibleFields).toJson();
    }
    if (floodlightReportCompatibleFields != null) {
      _json["floodlightReportCompatibleFields"] = (floodlightReportCompatibleFields).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pathToConversionReportCompatibleFields != null) {
      _json["pathToConversionReportCompatibleFields"] = (pathToConversionReportCompatibleFields).toJson();
    }
    if (reachReportCompatibleFields != null) {
      _json["reachReportCompatibleFields"] = (reachReportCompatibleFields).toJson();
    }
    if (reportCompatibleFields != null) {
      _json["reportCompatibleFields"] = (reportCompatibleFields).toJson();
    }
    return _json;
  }
}

/**
 * Contains information about an internet connection type that can be targeted
 * by ads. Clients can use the connection type to target mobile vs. broadband
 * users.
 */
class ConnectionType {
  /** ID of this connection type. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#connectionType".
   */
  core.String kind;
  /** Name of this connection type. */
  core.String name;

  ConnectionType();

  ConnectionType.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Connection Type List Response */
class ConnectionTypesListResponse {
  /** Collection of connection types such as broadband and mobile. */
  core.List<ConnectionType> connectionTypes;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#connectionTypesListResponse".
   */
  core.String kind;

  ConnectionTypesListResponse();

  ConnectionTypesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("connectionTypes")) {
      connectionTypes = _json["connectionTypes"].map((value) => new ConnectionType.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (connectionTypes != null) {
      _json["connectionTypes"] = connectionTypes.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Content Category List Response */
class ContentCategoriesListResponse {
  /** Content category collection. */
  core.List<ContentCategory> contentCategories;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#contentCategoriesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  ContentCategoriesListResponse();

  ContentCategoriesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("contentCategories")) {
      contentCategories = _json["contentCategories"].map((value) => new ContentCategory.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentCategories != null) {
      _json["contentCategories"] = contentCategories.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * Organizes placements according to the contents of their associated webpages.
 */
class ContentCategory {
  /**
   * Account ID of this content category. This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * ID of this content category. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#contentCategory".
   */
  core.String kind;
  /**
   * Name of this content category. This is a required field and must be less
   * than 256 characters long and unique among content categories of the same
   * account.
   */
  core.String name;

  ContentCategory();

  ContentCategory.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * A Conversion represents when a user successfully performs a desired action
 * after seeing an ad.
 */
class Conversion {
  /** Whether the conversion was directed toward children. */
  core.bool childDirectedTreatment;
  /** Custom floodlight variables. */
  core.List<CustomFloodlightVariable> customVariables;
  /**
   * The alphanumeric encrypted user ID. When set, encryptionInfo should also be
   * specified. This field is mutually exclusive with
   * encryptedUserIdCandidates[] and mobileDeviceId. This or
   * encryptedUserIdCandidates[] or mobileDeviceId is a required field.
   */
  core.String encryptedUserId;
  /**
   * A list of the alphanumeric encrypted user IDs. Any user ID with exposure
   * prior to the conversion timestamp will be used in the inserted conversion.
   * If no such user ID is found then the conversion will be rejected with
   * NO_COOKIE_MATCH_FOUND error. When set, encryptionInfo should also be
   * specified. This field should only be used when calling
   * conversions.batchinsert. This field is mutually exclusive with
   * encryptedUserId and mobileDeviceId. This or encryptedUserId or
   * mobileDeviceId is a required field.
   */
  core.List<core.String> encryptedUserIdCandidates;
  /** Floodlight Activity ID of this conversion. This is a required field. */
  core.String floodlightActivityId;
  /**
   * Floodlight Configuration ID of this conversion. This is a required field.
   */
  core.String floodlightConfigurationId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#conversion".
   */
  core.String kind;
  /**
   * Whether Limit Ad Tracking is enabled. When set to true, the conversion will
   * be used for reporting but not targeting. This will prevent remarketing.
   */
  core.bool limitAdTracking;
  /**
   * The mobile device ID. This field is mutually exclusive with encryptedUserId
   * and encryptedUserIdCandidates[]. This or encryptedUserId or
   * encryptedUserIdCandidates[] is a required field.
   */
  core.String mobileDeviceId;
  /**
   * The ordinal of the conversion. Use this field to control how conversions of
   * the same user and day are de-duplicated. This is a required field.
   */
  core.String ordinal;
  /** The quantity of the conversion. */
  core.String quantity;
  /**
   * The timestamp of conversion, in Unix epoch micros. This is a required
   * field.
   */
  core.String timestampMicros;
  /** The value of the conversion. */
  core.double value;

  Conversion();

  Conversion.fromJson(core.Map _json) {
    if (_json.containsKey("childDirectedTreatment")) {
      childDirectedTreatment = _json["childDirectedTreatment"];
    }
    if (_json.containsKey("customVariables")) {
      customVariables = _json["customVariables"].map((value) => new CustomFloodlightVariable.fromJson(value)).toList();
    }
    if (_json.containsKey("encryptedUserId")) {
      encryptedUserId = _json["encryptedUserId"];
    }
    if (_json.containsKey("encryptedUserIdCandidates")) {
      encryptedUserIdCandidates = _json["encryptedUserIdCandidates"];
    }
    if (_json.containsKey("floodlightActivityId")) {
      floodlightActivityId = _json["floodlightActivityId"];
    }
    if (_json.containsKey("floodlightConfigurationId")) {
      floodlightConfigurationId = _json["floodlightConfigurationId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("limitAdTracking")) {
      limitAdTracking = _json["limitAdTracking"];
    }
    if (_json.containsKey("mobileDeviceId")) {
      mobileDeviceId = _json["mobileDeviceId"];
    }
    if (_json.containsKey("ordinal")) {
      ordinal = _json["ordinal"];
    }
    if (_json.containsKey("quantity")) {
      quantity = _json["quantity"];
    }
    if (_json.containsKey("timestampMicros")) {
      timestampMicros = _json["timestampMicros"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (childDirectedTreatment != null) {
      _json["childDirectedTreatment"] = childDirectedTreatment;
    }
    if (customVariables != null) {
      _json["customVariables"] = customVariables.map((value) => (value).toJson()).toList();
    }
    if (encryptedUserId != null) {
      _json["encryptedUserId"] = encryptedUserId;
    }
    if (encryptedUserIdCandidates != null) {
      _json["encryptedUserIdCandidates"] = encryptedUserIdCandidates;
    }
    if (floodlightActivityId != null) {
      _json["floodlightActivityId"] = floodlightActivityId;
    }
    if (floodlightConfigurationId != null) {
      _json["floodlightConfigurationId"] = floodlightConfigurationId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (limitAdTracking != null) {
      _json["limitAdTracking"] = limitAdTracking;
    }
    if (mobileDeviceId != null) {
      _json["mobileDeviceId"] = mobileDeviceId;
    }
    if (ordinal != null) {
      _json["ordinal"] = ordinal;
    }
    if (quantity != null) {
      _json["quantity"] = quantity;
    }
    if (timestampMicros != null) {
      _json["timestampMicros"] = timestampMicros;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * The error code and description for a conversion that failed to insert or
 * update.
 */
class ConversionError {
  /**
   * The error code.
   * Possible string values are:
   * - "INTERNAL"
   * - "INVALID_ARGUMENT"
   * - "NOT_FOUND"
   * - "PERMISSION_DENIED"
   */
  core.String code;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#conversionError".
   */
  core.String kind;
  /** A description of the error. */
  core.String message;

  ConversionError();

  ConversionError.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (message != null) {
      _json["message"] = message;
    }
    return _json;
  }
}

/**
 * The original conversion that was inserted or updated and whether there were
 * any errors.
 */
class ConversionStatus {
  /** The original conversion that was inserted or updated. */
  Conversion conversion;
  /** A list of errors related to this conversion. */
  core.List<ConversionError> errors;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#conversionStatus".
   */
  core.String kind;

  ConversionStatus();

  ConversionStatus.fromJson(core.Map _json) {
    if (_json.containsKey("conversion")) {
      conversion = new Conversion.fromJson(_json["conversion"]);
    }
    if (_json.containsKey("errors")) {
      errors = _json["errors"].map((value) => new ConversionError.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conversion != null) {
      _json["conversion"] = (conversion).toJson();
    }
    if (errors != null) {
      _json["errors"] = errors.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Insert Conversions Request. */
class ConversionsBatchInsertRequest {
  /** The set of conversions to insert. */
  core.List<Conversion> conversions;
  /**
   * Describes how encryptedUserId or encryptedUserIdCandidates[] is encrypted.
   * This is a required field if encryptedUserId or encryptedUserIdCandidates[]
   * is used.
   */
  EncryptionInfo encryptionInfo;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#conversionsBatchInsertRequest".
   */
  core.String kind;

  ConversionsBatchInsertRequest();

  ConversionsBatchInsertRequest.fromJson(core.Map _json) {
    if (_json.containsKey("conversions")) {
      conversions = _json["conversions"].map((value) => new Conversion.fromJson(value)).toList();
    }
    if (_json.containsKey("encryptionInfo")) {
      encryptionInfo = new EncryptionInfo.fromJson(_json["encryptionInfo"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conversions != null) {
      _json["conversions"] = conversions.map((value) => (value).toJson()).toList();
    }
    if (encryptionInfo != null) {
      _json["encryptionInfo"] = (encryptionInfo).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Insert Conversions Response. */
class ConversionsBatchInsertResponse {
  /** Indicates that some or all conversions failed to insert. */
  core.bool hasFailures;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#conversionsBatchInsertResponse".
   */
  core.String kind;
  /**
   * The status of each conversion's insertion status. The status is returned in
   * the same order that conversions are inserted.
   */
  core.List<ConversionStatus> status;

  ConversionsBatchInsertResponse();

  ConversionsBatchInsertResponse.fromJson(core.Map _json) {
    if (_json.containsKey("hasFailures")) {
      hasFailures = _json["hasFailures"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"].map((value) => new ConversionStatus.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hasFailures != null) {
      _json["hasFailures"] = hasFailures;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (status != null) {
      _json["status"] = status.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Country List Response */
class CountriesListResponse {
  /** Country collection. */
  core.List<Country> countries;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#countriesListResponse".
   */
  core.String kind;

  CountriesListResponse();

  CountriesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("countries")) {
      countries = _json["countries"].map((value) => new Country.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countries != null) {
      _json["countries"] = countries.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains information about a country that can be targeted by ads. */
class Country {
  /** Country code. */
  core.String countryCode;
  /**
   * DART ID of this country. This is the ID used for targeting and generating
   * reports.
   */
  core.String dartId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#country".
   */
  core.String kind;
  /** Name of this country. */
  core.String name;
  /** Whether ad serving supports secure servers in this country. */
  core.bool sslEnabled;

  Country();

  Country.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sslEnabled")) {
      sslEnabled = _json["sslEnabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (sslEnabled != null) {
      _json["sslEnabled"] = sslEnabled;
    }
    return _json;
  }
}

/** Contains properties of a Creative. */
class Creative {
  /**
   * Account ID of this creative. This field, if left unset, will be
   * auto-generated for both insert and update operations. Applicable to all
   * creative types.
   */
  core.String accountId;
  /** Whether the creative is active. Applicable to all creative types. */
  core.bool active;
  /**
   * Ad parameters user for VPAID creative. This is a read-only field.
   * Applicable to the following creative types: all VPAID.
   */
  core.String adParameters;
  /**
   * Keywords for a Rich Media creative. Keywords let you customize the creative
   * settings of a Rich Media ad running on your site without having to contact
   * the advertiser. You can use keywords to dynamically change the look or
   * functionality of a creative. Applicable to the following creative types:
   * all RICH_MEDIA, and all VPAID.
   */
  core.List<core.String> adTagKeys;
  /**
   * Advertiser ID of this creative. This is a required field. Applicable to all
   * creative types.
   */
  core.String advertiserId;
  /**
   * Whether script access is allowed for this creative. This is a read-only and
   * deprecated field which will automatically be set to true on update.
   * Applicable to the following creative types: FLASH_INPAGE.
   */
  core.bool allowScriptAccess;
  /** Whether the creative is archived. Applicable to all creative types. */
  core.bool archived;
  /**
   * Type of artwork used for the creative. This is a read-only field.
   * Applicable to the following creative types: all RICH_MEDIA, and all VPAID.
   * Possible string values are:
   * - "ARTWORK_TYPE_FLASH"
   * - "ARTWORK_TYPE_HTML5"
   * - "ARTWORK_TYPE_IMAGE"
   * - "ARTWORK_TYPE_MIXED"
   */
  core.String artworkType;
  /**
   * Source application where creative was authored. Presently, only DBM
   * authored creatives will have this field set. Applicable to all creative
   * types.
   * Possible string values are:
   * - "CREATIVE_AUTHORING_SOURCE_DBM"
   * - "CREATIVE_AUTHORING_SOURCE_DCM"
   * - "CREATIVE_AUTHORING_SOURCE_STUDIO"
   */
  core.String authoringSource;
  /**
   * Authoring tool for HTML5 banner creatives. This is a read-only field.
   * Applicable to the following creative types: HTML5_BANNER.
   * Possible string values are:
   * - "NINJA"
   * - "SWIFFY"
   */
  core.String authoringTool;
  /**
   * Whether images are automatically advanced for image gallery creatives.
   * Applicable to the following creative types: DISPLAY_IMAGE_GALLERY.
   */
  core.bool autoAdvanceImages;
  /**
   * The 6-character HTML color code, beginning with #, for the background of
   * the window area where the Flash file is displayed. Default is white.
   * Applicable to the following creative types: FLASH_INPAGE.
   */
  core.String backgroundColor;
  /**
   * Click-through URL for backup image. Applicable to the following creative
   * types: FLASH_INPAGE and HTML5_BANNER. Applicable to DISPLAY when the
   * primary asset type is not HTML_IMAGE.
   */
  core.String backupImageClickThroughUrl;
  /**
   * List of feature dependencies that will cause a backup image to be served if
   * the browser that serves the ad does not support them. Feature dependencies
   * are features that a browser must be able to support in order to render your
   * HTML5 creative asset correctly. This field is initially auto-generated to
   * contain all features detected by DCM for all the assets of this creative
   * and can then be modified by the client. To reset this field, copy over all
   * the creativeAssets' detected features. Applicable to the following creative
   * types: HTML5_BANNER. Applicable to DISPLAY when the primary asset type is
   * not HTML_IMAGE.
   */
  core.List<core.String> backupImageFeatures;
  /**
   * Reporting label used for HTML5 banner backup image. Applicable to the
   * following creative types: DISPLAY when the primary asset type is not
   * HTML_IMAGE.
   */
  core.String backupImageReportingLabel;
  /**
   * Target window for backup image. Applicable to the following creative types:
   * FLASH_INPAGE and HTML5_BANNER. Applicable to DISPLAY when the primary asset
   * type is not HTML_IMAGE.
   */
  TargetWindow backupImageTargetWindow;
  /**
   * Click tags of the creative. For DISPLAY, FLASH_INPAGE, and HTML5_BANNER
   * creatives, this is a subset of detected click tags for the assets
   * associated with this creative. After creating a flash asset, detected click
   * tags will be returned in the creativeAssetMetadata. When inserting the
   * creative, populate the creative clickTags field using the
   * creativeAssetMetadata.clickTags field. For DISPLAY_IMAGE_GALLERY creatives,
   * there should be exactly one entry in this list for each image creative
   * asset. A click tag is matched with a corresponding creative asset by
   * matching the clickTag.name field with the
   * creativeAsset.assetIdentifier.name field. Applicable to the following
   * creative types: DISPLAY_IMAGE_GALLERY, FLASH_INPAGE, HTML5_BANNER.
   * Applicable to DISPLAY when the primary asset type is not HTML_IMAGE.
   */
  core.List<ClickTag> clickTags;
  /**
   * Industry standard ID assigned to creative for reach and frequency.
   * Applicable to the following creative types: all INSTREAM_VIDEO and all
   * VPAID.
   */
  core.String commercialId;
  /**
   * List of companion creatives assigned to an in-Stream videocreative.
   * Acceptable values include IDs of existing flash and image creatives.
   * Applicable to the following creative types: all VPAID and all
   * INSTREAM_VIDEO with dynamicAssetSelection set to false.
   */
  core.List<core.String> companionCreatives;
  /**
   * Compatibilities associated with this creative. This is a read-only field.
   * DISPLAY and DISPLAY_INTERSTITIAL refer to rendering either on desktop or on
   * mobile devices or in mobile apps for regular or interstitial ads,
   * respectively. APP and APP_INTERSTITIAL are for rendering in mobile apps.
   * Only pre-existing creatives may have these compatibilities since new
   * creatives will either be assigned DISPLAY or DISPLAY_INTERSTITIAL instead.
   * IN_STREAM_VIDEO refers to rendering in in-stream video ads developed with
   * the VAST standard. Applicable to all creative types.
   *
   * Acceptable values are:
   * - "APP"
   * - "APP_INTERSTITIAL"
   * - "IN_STREAM_VIDEO"
   * - "DISPLAY"
   * - "DISPLAY_INTERSTITIAL"
   */
  core.List<core.String> compatibility;
  /**
   * Whether Flash assets associated with the creative need to be automatically
   * converted to HTML5. This flag is enabled by default and users can choose to
   * disable it if they don't want the system to generate and use HTML5 asset
   * for this creative. Applicable to the following creative type: FLASH_INPAGE.
   * Applicable to DISPLAY when the primary asset type is not HTML_IMAGE.
   */
  core.bool convertFlashToHtml5;
  /**
   * List of counter events configured for the creative. For
   * DISPLAY_IMAGE_GALLERY creatives, these are read-only and auto-generated
   * from clickTags. Applicable to the following creative types:
   * DISPLAY_IMAGE_GALLERY, all RICH_MEDIA, and all VPAID.
   */
  core.List<CreativeCustomEvent> counterCustomEvents;
  /** Required if dynamicAssetSelection is true. */
  CreativeAssetSelection creativeAssetSelection;
  /**
   * Assets associated with a creative. Applicable to all but the following
   * creative types: INTERNAL_REDIRECT, INTERSTITIAL_INTERNAL_REDIRECT, and
   * REDIRECT
   */
  core.List<CreativeAsset> creativeAssets;
  /**
   * Creative field assignments for this creative. Applicable to all creative
   * types.
   */
  core.List<CreativeFieldAssignment> creativeFieldAssignments;
  /**
   * Custom key-values for a Rich Media creative. Key-values let you customize
   * the creative settings of a Rich Media ad running on your site without
   * having to contact the advertiser. You can use key-values to dynamically
   * change the look or functionality of a creative. Applicable to the following
   * creative types: all RICH_MEDIA, and all VPAID.
   */
  core.List<core.String> customKeyValues;
  /**
   * Set this to true to enable the use of rules to target individual assets in
   * this creative. When set to true creativeAssetSelection must be set. This
   * also controls asset-level companions. When this is true, companion
   * creatives should be assigned to creative assets. Learn more. Applicable to
   * INSTREAM_VIDEO creatives.
   */
  core.bool dynamicAssetSelection;
  /**
   * List of exit events configured for the creative. For DISPLAY and
   * DISPLAY_IMAGE_GALLERY creatives, these are read-only and auto-generated
   * from clickTags, For DISPLAY, an event is also created from the
   * backupImageReportingLabel. Applicable to the following creative types:
   * DISPLAY_IMAGE_GALLERY, all RICH_MEDIA, and all VPAID. Applicable to DISPLAY
   * when the primary asset type is not HTML_IMAGE.
   */
  core.List<CreativeCustomEvent> exitCustomEvents;
  /**
   * OpenWindow FSCommand of this creative. This lets the SWF file communicate
   * with either Flash Player or the program hosting Flash Player, such as a web
   * browser. This is only triggered if allowScriptAccess field is true.
   * Applicable to the following creative types: FLASH_INPAGE.
   */
  FsCommand fsCommand;
  /**
   * HTML code for the creative. This is a required field when applicable. This
   * field is ignored if htmlCodeLocked is false. Applicable to the following
   * creative types: all CUSTOM, FLASH_INPAGE, and HTML5_BANNER, and all
   * RICH_MEDIA.
   */
  core.String htmlCode;
  /**
   * Whether HTML code is DCM-generated or manually entered. Set to true to
   * ignore changes to htmlCode. Applicable to the following creative types:
   * FLASH_INPAGE and HTML5_BANNER.
   */
  core.bool htmlCodeLocked;
  /**
   * ID of this creative. This is a read-only, auto-generated field. Applicable
   * to all creative types.
   */
  core.String id;
  /**
   * Dimension value for the ID of this creative. This is a read-only field.
   * Applicable to all creative types.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creative".
   */
  core.String kind;
  /**
   * Creative last modification information. This is a read-only field.
   * Applicable to all creative types.
   */
  LastModifiedInfo lastModifiedInfo;
  /**
   * Latest Studio trafficked creative ID associated with rich media and VPAID
   * creatives. This is a read-only field. Applicable to the following creative
   * types: all RICH_MEDIA, and all VPAID.
   */
  core.String latestTraffickedCreativeId;
  /**
   * Name of the creative. This is a required field and must be less than 256
   * characters long. Applicable to all creative types.
   */
  core.String name;
  /**
   * Override CSS value for rich media creatives. Applicable to the following
   * creative types: all RICH_MEDIA.
   */
  core.String overrideCss;
  /**
   * Amount of time to play the video before counting a view. Applicable to the
   * following creative types: all INSTREAM_VIDEO.
   */
  VideoOffset progressOffset;
  /**
   * URL of hosted image or hosted video or another ad tag. For
   * INSTREAM_VIDEO_REDIRECT creatives this is the in-stream video redirect URL.
   * The standard for a VAST (Video Ad Serving Template) ad response allows for
   * a redirect link to another VAST 2.0 or 3.0 call. This is a required field
   * when applicable. Applicable to the following creative types:
   * DISPLAY_REDIRECT, INTERNAL_REDIRECT, INTERSTITIAL_INTERNAL_REDIRECT, and
   * INSTREAM_VIDEO_REDIRECT
   */
  core.String redirectUrl;
  /**
   * ID of current rendering version. This is a read-only field. Applicable to
   * all creative types.
   */
  core.String renderingId;
  /**
   * Dimension value for the rendering ID of this creative. This is a read-only
   * field. Applicable to all creative types.
   */
  DimensionValue renderingIdDimensionValue;
  /**
   * The minimum required Flash plugin version for this creative. For example,
   * 11.2.202.235. This is a read-only field. Applicable to the following
   * creative types: all RICH_MEDIA, and all VPAID.
   */
  core.String requiredFlashPluginVersion;
  /**
   * The internal Flash version for this creative as calculated by DoubleClick
   * Studio. This is a read-only field. Applicable to the following creative
   * types: FLASH_INPAGE all RICH_MEDIA, and all VPAID. Applicable to DISPLAY
   * when the primary asset type is not HTML_IMAGE.
   */
  core.int requiredFlashVersion;
  /**
   * Size associated with this creative. When inserting or updating a creative
   * either the size ID field or size width and height fields can be used. This
   * is a required field when applicable; however for IMAGE, FLASH_INPAGE
   * creatives, and for DISPLAY creatives with a primary asset of type
   * HTML_IMAGE, if left blank, this field will be automatically set using the
   * actual size of the associated image assets. Applicable to the following
   * creative types: DISPLAY, DISPLAY_IMAGE_GALLERY, FLASH_INPAGE, HTML5_BANNER,
   * IMAGE, and all RICH_MEDIA.
   */
  Size size;
  /**
   * Amount of time to play the video before the skip button appears. Applicable
   * to the following creative types: all INSTREAM_VIDEO.
   */
  VideoOffset skipOffset;
  /**
   * Whether the user can choose to skip the creative. Applicable to the
   * following creative types: all INSTREAM_VIDEO and all VPAID.
   */
  core.bool skippable;
  /**
   * Whether the creative is SSL-compliant. This is a read-only field.
   * Applicable to all creative types.
   */
  core.bool sslCompliant;
  /**
   * Whether creative should be treated as SSL compliant even if the system scan
   * shows it's not. Applicable to all creative types.
   */
  core.bool sslOverride;
  /**
   * Studio advertiser ID associated with rich media and VPAID creatives. This
   * is a read-only field. Applicable to the following creative types: all
   * RICH_MEDIA, and all VPAID.
   */
  core.String studioAdvertiserId;
  /**
   * Studio creative ID associated with rich media and VPAID creatives. This is
   * a read-only field. Applicable to the following creative types: all
   * RICH_MEDIA, and all VPAID.
   */
  core.String studioCreativeId;
  /**
   * Studio trafficked creative ID associated with rich media and VPAID
   * creatives. This is a read-only field. Applicable to the following creative
   * types: all RICH_MEDIA, and all VPAID.
   */
  core.String studioTraffickedCreativeId;
  /**
   * Subaccount ID of this creative. This field, if left unset, will be
   * auto-generated for both insert and update operations. Applicable to all
   * creative types.
   */
  core.String subaccountId;
  /**
   * Third-party URL used to record backup image impressions. Applicable to the
   * following creative types: all RICH_MEDIA.
   */
  core.String thirdPartyBackupImageImpressionsUrl;
  /**
   * Third-party URL used to record rich media impressions. Applicable to the
   * following creative types: all RICH_MEDIA.
   */
  core.String thirdPartyRichMediaImpressionsUrl;
  /**
   * Third-party URLs for tracking in-stream video creative events. Applicable
   * to the following creative types: all INSTREAM_VIDEO and all VPAID.
   */
  core.List<ThirdPartyTrackingUrl> thirdPartyUrls;
  /**
   * List of timer events configured for the creative. For DISPLAY_IMAGE_GALLERY
   * creatives, these are read-only and auto-generated from clickTags.
   * Applicable to the following creative types: DISPLAY_IMAGE_GALLERY, all
   * RICH_MEDIA, and all VPAID. Applicable to DISPLAY when the primary asset is
   * not HTML_IMAGE.
   */
  core.List<CreativeCustomEvent> timerCustomEvents;
  /**
   * Combined size of all creative assets. This is a read-only field. Applicable
   * to the following creative types: all RICH_MEDIA, and all VPAID.
   */
  core.String totalFileSize;
  /**
   * Type of this creative. This is a required field. Applicable to all creative
   * types.
   *
   * Note: FLASH_INPAGE, HTML5_BANNER, and IMAGE are only used for existing
   * creatives. New creatives should use DISPLAY as a replacement for these
   * types.
   * Possible string values are:
   * - "BRAND_SAFE_DEFAULT_INSTREAM_VIDEO"
   * - "CUSTOM_DISPLAY"
   * - "CUSTOM_DISPLAY_INTERSTITIAL"
   * - "DISPLAY"
   * - "DISPLAY_IMAGE_GALLERY"
   * - "DISPLAY_REDIRECT"
   * - "FLASH_INPAGE"
   * - "HTML5_BANNER"
   * - "IMAGE"
   * - "INSTREAM_VIDEO"
   * - "INSTREAM_VIDEO_REDIRECT"
   * - "INTERNAL_REDIRECT"
   * - "INTERSTITIAL_INTERNAL_REDIRECT"
   * - "RICH_MEDIA_DISPLAY_BANNER"
   * - "RICH_MEDIA_DISPLAY_EXPANDING"
   * - "RICH_MEDIA_DISPLAY_INTERSTITIAL"
   * - "RICH_MEDIA_DISPLAY_MULTI_FLOATING_INTERSTITIAL"
   * - "RICH_MEDIA_IM_EXPAND"
   * - "RICH_MEDIA_INPAGE_FLOATING"
   * - "RICH_MEDIA_MOBILE_IN_APP"
   * - "RICH_MEDIA_PEEL_DOWN"
   * - "TRACKING_TEXT"
   * - "VPAID_LINEAR_VIDEO"
   * - "VPAID_NON_LINEAR_VIDEO"
   */
  core.String type;
  /**
   * The version number helps you keep track of multiple versions of your
   * creative in your reports. The version number will always be auto-generated
   * during insert operations to start at 1. For tracking creatives the version
   * cannot be incremented and will always remain at 1. For all other creative
   * types the version can be incremented only by 1 during update operations. In
   * addition, the version will be automatically incremented by 1 when
   * undergoing Rich Media creative merging. Applicable to all creative types.
   */
  core.int version;
  /**
   * Description of the video ad. Applicable to the following creative types:
   * all INSTREAM_VIDEO and all VPAID.
   */
  core.String videoDescription;
  /**
   * Creative video duration in seconds. This is a read-only field. Applicable
   * to the following creative types: INSTREAM_VIDEO, all RICH_MEDIA, and all
   * VPAID.
   */
  core.double videoDuration;

  Creative();

  Creative.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("adParameters")) {
      adParameters = _json["adParameters"];
    }
    if (_json.containsKey("adTagKeys")) {
      adTagKeys = _json["adTagKeys"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("allowScriptAccess")) {
      allowScriptAccess = _json["allowScriptAccess"];
    }
    if (_json.containsKey("archived")) {
      archived = _json["archived"];
    }
    if (_json.containsKey("artworkType")) {
      artworkType = _json["artworkType"];
    }
    if (_json.containsKey("authoringSource")) {
      authoringSource = _json["authoringSource"];
    }
    if (_json.containsKey("authoringTool")) {
      authoringTool = _json["authoringTool"];
    }
    if (_json.containsKey("auto_advance_images")) {
      autoAdvanceImages = _json["auto_advance_images"];
    }
    if (_json.containsKey("backgroundColor")) {
      backgroundColor = _json["backgroundColor"];
    }
    if (_json.containsKey("backupImageClickThroughUrl")) {
      backupImageClickThroughUrl = _json["backupImageClickThroughUrl"];
    }
    if (_json.containsKey("backupImageFeatures")) {
      backupImageFeatures = _json["backupImageFeatures"];
    }
    if (_json.containsKey("backupImageReportingLabel")) {
      backupImageReportingLabel = _json["backupImageReportingLabel"];
    }
    if (_json.containsKey("backupImageTargetWindow")) {
      backupImageTargetWindow = new TargetWindow.fromJson(_json["backupImageTargetWindow"]);
    }
    if (_json.containsKey("clickTags")) {
      clickTags = _json["clickTags"].map((value) => new ClickTag.fromJson(value)).toList();
    }
    if (_json.containsKey("commercialId")) {
      commercialId = _json["commercialId"];
    }
    if (_json.containsKey("companionCreatives")) {
      companionCreatives = _json["companionCreatives"];
    }
    if (_json.containsKey("compatibility")) {
      compatibility = _json["compatibility"];
    }
    if (_json.containsKey("convertFlashToHtml5")) {
      convertFlashToHtml5 = _json["convertFlashToHtml5"];
    }
    if (_json.containsKey("counterCustomEvents")) {
      counterCustomEvents = _json["counterCustomEvents"].map((value) => new CreativeCustomEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeAssetSelection")) {
      creativeAssetSelection = new CreativeAssetSelection.fromJson(_json["creativeAssetSelection"]);
    }
    if (_json.containsKey("creativeAssets")) {
      creativeAssets = _json["creativeAssets"].map((value) => new CreativeAsset.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeFieldAssignments")) {
      creativeFieldAssignments = _json["creativeFieldAssignments"].map((value) => new CreativeFieldAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("customKeyValues")) {
      customKeyValues = _json["customKeyValues"];
    }
    if (_json.containsKey("dynamicAssetSelection")) {
      dynamicAssetSelection = _json["dynamicAssetSelection"];
    }
    if (_json.containsKey("exitCustomEvents")) {
      exitCustomEvents = _json["exitCustomEvents"].map((value) => new CreativeCustomEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("fsCommand")) {
      fsCommand = new FsCommand.fromJson(_json["fsCommand"]);
    }
    if (_json.containsKey("htmlCode")) {
      htmlCode = _json["htmlCode"];
    }
    if (_json.containsKey("htmlCodeLocked")) {
      htmlCodeLocked = _json["htmlCodeLocked"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("latestTraffickedCreativeId")) {
      latestTraffickedCreativeId = _json["latestTraffickedCreativeId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("overrideCss")) {
      overrideCss = _json["overrideCss"];
    }
    if (_json.containsKey("progressOffset")) {
      progressOffset = new VideoOffset.fromJson(_json["progressOffset"]);
    }
    if (_json.containsKey("redirectUrl")) {
      redirectUrl = _json["redirectUrl"];
    }
    if (_json.containsKey("renderingId")) {
      renderingId = _json["renderingId"];
    }
    if (_json.containsKey("renderingIdDimensionValue")) {
      renderingIdDimensionValue = new DimensionValue.fromJson(_json["renderingIdDimensionValue"]);
    }
    if (_json.containsKey("requiredFlashPluginVersion")) {
      requiredFlashPluginVersion = _json["requiredFlashPluginVersion"];
    }
    if (_json.containsKey("requiredFlashVersion")) {
      requiredFlashVersion = _json["requiredFlashVersion"];
    }
    if (_json.containsKey("size")) {
      size = new Size.fromJson(_json["size"]);
    }
    if (_json.containsKey("skipOffset")) {
      skipOffset = new VideoOffset.fromJson(_json["skipOffset"]);
    }
    if (_json.containsKey("skippable")) {
      skippable = _json["skippable"];
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("sslOverride")) {
      sslOverride = _json["sslOverride"];
    }
    if (_json.containsKey("studioAdvertiserId")) {
      studioAdvertiserId = _json["studioAdvertiserId"];
    }
    if (_json.containsKey("studioCreativeId")) {
      studioCreativeId = _json["studioCreativeId"];
    }
    if (_json.containsKey("studioTraffickedCreativeId")) {
      studioTraffickedCreativeId = _json["studioTraffickedCreativeId"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("thirdPartyBackupImageImpressionsUrl")) {
      thirdPartyBackupImageImpressionsUrl = _json["thirdPartyBackupImageImpressionsUrl"];
    }
    if (_json.containsKey("thirdPartyRichMediaImpressionsUrl")) {
      thirdPartyRichMediaImpressionsUrl = _json["thirdPartyRichMediaImpressionsUrl"];
    }
    if (_json.containsKey("thirdPartyUrls")) {
      thirdPartyUrls = _json["thirdPartyUrls"].map((value) => new ThirdPartyTrackingUrl.fromJson(value)).toList();
    }
    if (_json.containsKey("timerCustomEvents")) {
      timerCustomEvents = _json["timerCustomEvents"].map((value) => new CreativeCustomEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("totalFileSize")) {
      totalFileSize = _json["totalFileSize"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("videoDescription")) {
      videoDescription = _json["videoDescription"];
    }
    if (_json.containsKey("videoDuration")) {
      videoDuration = _json["videoDuration"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (adParameters != null) {
      _json["adParameters"] = adParameters;
    }
    if (adTagKeys != null) {
      _json["adTagKeys"] = adTagKeys;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (allowScriptAccess != null) {
      _json["allowScriptAccess"] = allowScriptAccess;
    }
    if (archived != null) {
      _json["archived"] = archived;
    }
    if (artworkType != null) {
      _json["artworkType"] = artworkType;
    }
    if (authoringSource != null) {
      _json["authoringSource"] = authoringSource;
    }
    if (authoringTool != null) {
      _json["authoringTool"] = authoringTool;
    }
    if (autoAdvanceImages != null) {
      _json["auto_advance_images"] = autoAdvanceImages;
    }
    if (backgroundColor != null) {
      _json["backgroundColor"] = backgroundColor;
    }
    if (backupImageClickThroughUrl != null) {
      _json["backupImageClickThroughUrl"] = backupImageClickThroughUrl;
    }
    if (backupImageFeatures != null) {
      _json["backupImageFeatures"] = backupImageFeatures;
    }
    if (backupImageReportingLabel != null) {
      _json["backupImageReportingLabel"] = backupImageReportingLabel;
    }
    if (backupImageTargetWindow != null) {
      _json["backupImageTargetWindow"] = (backupImageTargetWindow).toJson();
    }
    if (clickTags != null) {
      _json["clickTags"] = clickTags.map((value) => (value).toJson()).toList();
    }
    if (commercialId != null) {
      _json["commercialId"] = commercialId;
    }
    if (companionCreatives != null) {
      _json["companionCreatives"] = companionCreatives;
    }
    if (compatibility != null) {
      _json["compatibility"] = compatibility;
    }
    if (convertFlashToHtml5 != null) {
      _json["convertFlashToHtml5"] = convertFlashToHtml5;
    }
    if (counterCustomEvents != null) {
      _json["counterCustomEvents"] = counterCustomEvents.map((value) => (value).toJson()).toList();
    }
    if (creativeAssetSelection != null) {
      _json["creativeAssetSelection"] = (creativeAssetSelection).toJson();
    }
    if (creativeAssets != null) {
      _json["creativeAssets"] = creativeAssets.map((value) => (value).toJson()).toList();
    }
    if (creativeFieldAssignments != null) {
      _json["creativeFieldAssignments"] = creativeFieldAssignments.map((value) => (value).toJson()).toList();
    }
    if (customKeyValues != null) {
      _json["customKeyValues"] = customKeyValues;
    }
    if (dynamicAssetSelection != null) {
      _json["dynamicAssetSelection"] = dynamicAssetSelection;
    }
    if (exitCustomEvents != null) {
      _json["exitCustomEvents"] = exitCustomEvents.map((value) => (value).toJson()).toList();
    }
    if (fsCommand != null) {
      _json["fsCommand"] = (fsCommand).toJson();
    }
    if (htmlCode != null) {
      _json["htmlCode"] = htmlCode;
    }
    if (htmlCodeLocked != null) {
      _json["htmlCodeLocked"] = htmlCodeLocked;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (latestTraffickedCreativeId != null) {
      _json["latestTraffickedCreativeId"] = latestTraffickedCreativeId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (overrideCss != null) {
      _json["overrideCss"] = overrideCss;
    }
    if (progressOffset != null) {
      _json["progressOffset"] = (progressOffset).toJson();
    }
    if (redirectUrl != null) {
      _json["redirectUrl"] = redirectUrl;
    }
    if (renderingId != null) {
      _json["renderingId"] = renderingId;
    }
    if (renderingIdDimensionValue != null) {
      _json["renderingIdDimensionValue"] = (renderingIdDimensionValue).toJson();
    }
    if (requiredFlashPluginVersion != null) {
      _json["requiredFlashPluginVersion"] = requiredFlashPluginVersion;
    }
    if (requiredFlashVersion != null) {
      _json["requiredFlashVersion"] = requiredFlashVersion;
    }
    if (size != null) {
      _json["size"] = (size).toJson();
    }
    if (skipOffset != null) {
      _json["skipOffset"] = (skipOffset).toJson();
    }
    if (skippable != null) {
      _json["skippable"] = skippable;
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (sslOverride != null) {
      _json["sslOverride"] = sslOverride;
    }
    if (studioAdvertiserId != null) {
      _json["studioAdvertiserId"] = studioAdvertiserId;
    }
    if (studioCreativeId != null) {
      _json["studioCreativeId"] = studioCreativeId;
    }
    if (studioTraffickedCreativeId != null) {
      _json["studioTraffickedCreativeId"] = studioTraffickedCreativeId;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (thirdPartyBackupImageImpressionsUrl != null) {
      _json["thirdPartyBackupImageImpressionsUrl"] = thirdPartyBackupImageImpressionsUrl;
    }
    if (thirdPartyRichMediaImpressionsUrl != null) {
      _json["thirdPartyRichMediaImpressionsUrl"] = thirdPartyRichMediaImpressionsUrl;
    }
    if (thirdPartyUrls != null) {
      _json["thirdPartyUrls"] = thirdPartyUrls.map((value) => (value).toJson()).toList();
    }
    if (timerCustomEvents != null) {
      _json["timerCustomEvents"] = timerCustomEvents.map((value) => (value).toJson()).toList();
    }
    if (totalFileSize != null) {
      _json["totalFileSize"] = totalFileSize;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (videoDescription != null) {
      _json["videoDescription"] = videoDescription;
    }
    if (videoDuration != null) {
      _json["videoDuration"] = videoDuration;
    }
    return _json;
  }
}

/** Creative Asset. */
class CreativeAsset {
  /**
   * Whether ActionScript3 is enabled for the flash asset. This is a read-only
   * field. Applicable to the following creative type: FLASH_INPAGE. Applicable
   * to DISPLAY when the primary asset type is not HTML_IMAGE.
   */
  core.bool actionScript3;
  /**
   * Whether the video asset is active. This is a read-only field for
   * VPAID_NON_LINEAR_VIDEO assets. Applicable to the following creative types:
   * INSTREAM_VIDEO and all VPAID.
   */
  core.bool active;
  /**
   * Possible alignments for an asset. This is a read-only field. Applicable to
   * the following creative types:
   * RICH_MEDIA_DISPLAY_MULTI_FLOATING_INTERSTITIAL.
   * Possible string values are:
   * - "ALIGNMENT_BOTTOM"
   * - "ALIGNMENT_LEFT"
   * - "ALIGNMENT_RIGHT"
   * - "ALIGNMENT_TOP"
   */
  core.String alignment;
  /**
   * Artwork type of rich media creative. This is a read-only field. Applicable
   * to the following creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "ARTWORK_TYPE_FLASH"
   * - "ARTWORK_TYPE_HTML5"
   * - "ARTWORK_TYPE_IMAGE"
   * - "ARTWORK_TYPE_MIXED"
   */
  core.String artworkType;
  /**
   * Identifier of this asset. This is the same identifier returned during
   * creative asset insert operation. This is a required field. Applicable to
   * all but the following creative types: all REDIRECT and TRACKING_TEXT.
   */
  CreativeAssetId assetIdentifier;
  /**
   * Exit event configured for the backup image. Applicable to the following
   * creative types: all RICH_MEDIA.
   */
  CreativeCustomEvent backupImageExit;
  /**
   * Detected bit-rate for video asset. This is a read-only field. Applicable to
   * the following creative types: INSTREAM_VIDEO and all VPAID.
   */
  core.int bitRate;
  /**
   * Rich media child asset type. This is a read-only field. Applicable to the
   * following creative types: all VPAID.
   * Possible string values are:
   * - "CHILD_ASSET_TYPE_DATA"
   * - "CHILD_ASSET_TYPE_FLASH"
   * - "CHILD_ASSET_TYPE_IMAGE"
   * - "CHILD_ASSET_TYPE_VIDEO"
   */
  core.String childAssetType;
  /**
   * Size of an asset when collapsed. This is a read-only field. Applicable to
   * the following creative types: all RICH_MEDIA and all VPAID. Additionally,
   * applicable to assets whose displayType is ASSET_DISPLAY_TYPE_EXPANDING or
   * ASSET_DISPLAY_TYPE_PEEL_DOWN.
   */
  Size collapsedSize;
  /**
   * List of companion creatives assigned to an in-stream video creative asset.
   * Acceptable values include IDs of existing flash and image creatives.
   * Applicable to INSTREAM_VIDEO creative type with dynamicAssetSelection set
   * to true.
   */
  core.List<core.String> companionCreativeIds;
  /**
   * Custom start time in seconds for making the asset visible. Applicable to
   * the following creative types: all RICH_MEDIA.
   */
  core.int customStartTimeValue;
  /**
   * List of feature dependencies for the creative asset that are detected by
   * DCM. Feature dependencies are features that a browser must be able to
   * support in order to render your HTML5 creative correctly. This is a
   * read-only, auto-generated field. Applicable to the following creative
   * types: HTML5_BANNER. Applicable to DISPLAY when the primary asset type is
   * not HTML_IMAGE.
   */
  core.List<core.String> detectedFeatures;
  /**
   * Type of rich media asset. This is a read-only field. Applicable to the
   * following creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "ASSET_DISPLAY_TYPE_BACKDROP"
   * - "ASSET_DISPLAY_TYPE_EXPANDING"
   * - "ASSET_DISPLAY_TYPE_FLASH_IN_FLASH"
   * - "ASSET_DISPLAY_TYPE_FLASH_IN_FLASH_EXPANDING"
   * - "ASSET_DISPLAY_TYPE_FLOATING"
   * - "ASSET_DISPLAY_TYPE_INPAGE"
   * - "ASSET_DISPLAY_TYPE_OVERLAY"
   * - "ASSET_DISPLAY_TYPE_PEEL_DOWN"
   * - "ASSET_DISPLAY_TYPE_VPAID_LINEAR"
   * - "ASSET_DISPLAY_TYPE_VPAID_NON_LINEAR"
   */
  core.String displayType;
  /**
   * Duration in seconds for which an asset will be displayed. Applicable to the
   * following creative types: INSTREAM_VIDEO and VPAID_LINEAR_VIDEO.
   */
  core.int duration;
  /**
   * Duration type for which an asset will be displayed. Applicable to the
   * following creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "ASSET_DURATION_TYPE_AUTO"
   * - "ASSET_DURATION_TYPE_CUSTOM"
   * - "ASSET_DURATION_TYPE_NONE"
   */
  core.String durationType;
  /**
   * Detected expanded dimension for video asset. This is a read-only field.
   * Applicable to the following creative types: INSTREAM_VIDEO and all VPAID.
   */
  Size expandedDimension;
  /**
   * File size associated with this creative asset. This is a read-only field.
   * Applicable to all but the following creative types: all REDIRECT and
   * TRACKING_TEXT.
   */
  core.String fileSize;
  /**
   * Flash version of the asset. This is a read-only field. Applicable to the
   * following creative types: FLASH_INPAGE, all RICH_MEDIA, and all VPAID.
   * Applicable to DISPLAY when the primary asset type is not HTML_IMAGE.
   */
  core.int flashVersion;
  /**
   * Whether to hide Flash objects flag for an asset. Applicable to the
   * following creative types: all RICH_MEDIA.
   */
  core.bool hideFlashObjects;
  /**
   * Whether to hide selection boxes flag for an asset. Applicable to the
   * following creative types: all RICH_MEDIA.
   */
  core.bool hideSelectionBoxes;
  /**
   * Whether the asset is horizontally locked. This is a read-only field.
   * Applicable to the following creative types: all RICH_MEDIA.
   */
  core.bool horizontallyLocked;
  /**
   * Numeric ID of this creative asset. This is a required field and should not
   * be modified. Applicable to all but the following creative types: all
   * REDIRECT and TRACKING_TEXT.
   */
  core.String id;
  /**
   * Dimension value for the ID of the asset. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Detected MIME type for video asset. This is a read-only field. Applicable
   * to the following creative types: INSTREAM_VIDEO and all VPAID.
   */
  core.String mimeType;
  /**
   * Offset position for an asset in collapsed mode. This is a read-only field.
   * Applicable to the following creative types: all RICH_MEDIA and all VPAID.
   * Additionally, only applicable to assets whose displayType is
   * ASSET_DISPLAY_TYPE_EXPANDING or ASSET_DISPLAY_TYPE_PEEL_DOWN.
   */
  OffsetPosition offset;
  /**
   * Whether the backup asset is original or changed by the user in DCM.
   * Applicable to the following creative types: all RICH_MEDIA.
   */
  core.bool originalBackup;
  /**
   * Offset position for an asset. Applicable to the following creative types:
   * all RICH_MEDIA.
   */
  OffsetPosition position;
  /**
   * Offset left unit for an asset. This is a read-only field. Applicable to the
   * following creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "OFFSET_UNIT_PERCENT"
   * - "OFFSET_UNIT_PIXEL"
   * - "OFFSET_UNIT_PIXEL_FROM_CENTER"
   */
  core.String positionLeftUnit;
  /**
   * Offset top unit for an asset. This is a read-only field if the asset
   * displayType is ASSET_DISPLAY_TYPE_OVERLAY. Applicable to the following
   * creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "OFFSET_UNIT_PERCENT"
   * - "OFFSET_UNIT_PIXEL"
   * - "OFFSET_UNIT_PIXEL_FROM_CENTER"
   */
  core.String positionTopUnit;
  /**
   * Progressive URL for video asset. This is a read-only field. Applicable to
   * the following creative types: INSTREAM_VIDEO and all VPAID.
   */
  core.String progressiveServingUrl;
  /**
   * Whether the asset pushes down other content. Applicable to the following
   * creative types: all RICH_MEDIA. Additionally, only applicable when the
   * asset offsets are 0, the collapsedSize.width matches size.width, and the
   * collapsedSize.height is less than size.height.
   */
  core.bool pushdown;
  /**
   * Pushdown duration in seconds for an asset. Must be between 0 and 9.99.
   * Applicable to the following creative types: all RICH_MEDIA.Additionally,
   * only applicable when the asset pushdown field is true, the offsets are 0,
   * the collapsedSize.width matches size.width, and the collapsedSize.height is
   * less than size.height.
   */
  core.double pushdownDuration;
  /**
   * Role of the asset in relation to creative. Applicable to all but the
   * following creative types: all REDIRECT and TRACKING_TEXT. This is a
   * required field.
   * PRIMARY applies to DISPLAY, FLASH_INPAGE, HTML5_BANNER, IMAGE,
   * DISPLAY_IMAGE_GALLERY, all RICH_MEDIA (which may contain multiple primary
   * assets), and all VPAID creatives.
   * BACKUP_IMAGE applies to FLASH_INPAGE, HTML5_BANNER, all RICH_MEDIA, and all
   * VPAID creatives. Applicable to DISPLAY when the primary asset type is not
   * HTML_IMAGE.
   * ADDITIONAL_IMAGE and ADDITIONAL_FLASH apply to FLASH_INPAGE creatives.
   * OTHER refers to assets from sources other than DCM, such as Studio uploaded
   * assets, applicable to all RICH_MEDIA and all VPAID creatives.
   * PARENT_VIDEO refers to videos uploaded by the user in DCM and is applicable
   * to INSTREAM_VIDEO and VPAID_LINEAR_VIDEO creatives.
   * TRANSCODED_VIDEO refers to videos transcoded by DCM from PARENT_VIDEO
   * assets and is applicable to INSTREAM_VIDEO and VPAID_LINEAR_VIDEO
   * creatives.
   * ALTERNATE_VIDEO refers to the DCM representation of child asset videos from
   * Studio, and is applicable to VPAID_LINEAR_VIDEO creatives. These cannot be
   * added or removed within DCM.
   * For VPAID_LINEAR_VIDEO creatives, PARENT_VIDEO, TRANSCODED_VIDEO and
   * ALTERNATE_VIDEO assets that are marked active serve as backup in case the
   * VPAID creative cannot be served. Only PARENT_VIDEO assets can be added or
   * removed for an INSTREAM_VIDEO or VPAID_LINEAR_VIDEO creative.
   * Possible string values are:
   * - "ADDITIONAL_FLASH"
   * - "ADDITIONAL_IMAGE"
   * - "ALTERNATE_VIDEO"
   * - "BACKUP_IMAGE"
   * - "OTHER"
   * - "PARENT_VIDEO"
   * - "PRIMARY"
   * - "TRANSCODED_VIDEO"
   */
  core.String role;
  /**
   * Size associated with this creative asset. This is a required field when
   * applicable; however for IMAGE and FLASH_INPAGE, creatives if left blank,
   * this field will be automatically set using the actual size of the
   * associated image asset. Applicable to the following creative types:
   * DISPLAY_IMAGE_GALLERY, FLASH_INPAGE, HTML5_BANNER, IMAGE, and all
   * RICH_MEDIA. Applicable to DISPLAY when the primary asset type is not
   * HTML_IMAGE.
   */
  Size size;
  /**
   * Whether the asset is SSL-compliant. This is a read-only field. Applicable
   * to all but the following creative types: all REDIRECT and TRACKING_TEXT.
   */
  core.bool sslCompliant;
  /**
   * Initial wait time type before making the asset visible. Applicable to the
   * following creative types: all RICH_MEDIA.
   * Possible string values are:
   * - "ASSET_START_TIME_TYPE_CUSTOM"
   * - "ASSET_START_TIME_TYPE_NONE"
   */
  core.String startTimeType;
  /**
   * Streaming URL for video asset. This is a read-only field. Applicable to the
   * following creative types: INSTREAM_VIDEO and all VPAID.
   */
  core.String streamingServingUrl;
  /**
   * Whether the asset is transparent. Applicable to the following creative
   * types: all RICH_MEDIA. Additionally, only applicable to HTML5 assets.
   */
  core.bool transparency;
  /**
   * Whether the asset is vertically locked. This is a read-only field.
   * Applicable to the following creative types: all RICH_MEDIA.
   */
  core.bool verticallyLocked;
  /**
   * Detected video duration for video asset. This is a read-only field.
   * Applicable to the following creative types: INSTREAM_VIDEO and all VPAID.
   */
  core.double videoDuration;
  /**
   * Window mode options for flash assets. Applicable to the following creative
   * types: FLASH_INPAGE, RICH_MEDIA_DISPLAY_EXPANDING, RICH_MEDIA_IM_EXPAND,
   * RICH_MEDIA_DISPLAY_BANNER, and RICH_MEDIA_INPAGE_FLOATING.
   * Possible string values are:
   * - "OPAQUE"
   * - "TRANSPARENT"
   * - "WINDOW"
   */
  core.String windowMode;
  /**
   * zIndex value of an asset. This is a read-only field. Applicable to the
   * following creative types: all RICH_MEDIA.Additionally, only applicable to
   * assets whose displayType is NOT one of the following types:
   * ASSET_DISPLAY_TYPE_INPAGE or ASSET_DISPLAY_TYPE_OVERLAY.
   */
  core.int zIndex;
  /**
   * File name of zip file. This is a read-only field. Applicable to the
   * following creative types: HTML5_BANNER.
   */
  core.String zipFilename;
  /**
   * Size of zip file. This is a read-only field. Applicable to the following
   * creative types: HTML5_BANNER.
   */
  core.String zipFilesize;

  CreativeAsset();

  CreativeAsset.fromJson(core.Map _json) {
    if (_json.containsKey("actionScript3")) {
      actionScript3 = _json["actionScript3"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("alignment")) {
      alignment = _json["alignment"];
    }
    if (_json.containsKey("artworkType")) {
      artworkType = _json["artworkType"];
    }
    if (_json.containsKey("assetIdentifier")) {
      assetIdentifier = new CreativeAssetId.fromJson(_json["assetIdentifier"]);
    }
    if (_json.containsKey("backupImageExit")) {
      backupImageExit = new CreativeCustomEvent.fromJson(_json["backupImageExit"]);
    }
    if (_json.containsKey("bitRate")) {
      bitRate = _json["bitRate"];
    }
    if (_json.containsKey("childAssetType")) {
      childAssetType = _json["childAssetType"];
    }
    if (_json.containsKey("collapsedSize")) {
      collapsedSize = new Size.fromJson(_json["collapsedSize"]);
    }
    if (_json.containsKey("companionCreativeIds")) {
      companionCreativeIds = _json["companionCreativeIds"];
    }
    if (_json.containsKey("customStartTimeValue")) {
      customStartTimeValue = _json["customStartTimeValue"];
    }
    if (_json.containsKey("detectedFeatures")) {
      detectedFeatures = _json["detectedFeatures"];
    }
    if (_json.containsKey("displayType")) {
      displayType = _json["displayType"];
    }
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("durationType")) {
      durationType = _json["durationType"];
    }
    if (_json.containsKey("expandedDimension")) {
      expandedDimension = new Size.fromJson(_json["expandedDimension"]);
    }
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("flashVersion")) {
      flashVersion = _json["flashVersion"];
    }
    if (_json.containsKey("hideFlashObjects")) {
      hideFlashObjects = _json["hideFlashObjects"];
    }
    if (_json.containsKey("hideSelectionBoxes")) {
      hideSelectionBoxes = _json["hideSelectionBoxes"];
    }
    if (_json.containsKey("horizontallyLocked")) {
      horizontallyLocked = _json["horizontallyLocked"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("mimeType")) {
      mimeType = _json["mimeType"];
    }
    if (_json.containsKey("offset")) {
      offset = new OffsetPosition.fromJson(_json["offset"]);
    }
    if (_json.containsKey("originalBackup")) {
      originalBackup = _json["originalBackup"];
    }
    if (_json.containsKey("position")) {
      position = new OffsetPosition.fromJson(_json["position"]);
    }
    if (_json.containsKey("positionLeftUnit")) {
      positionLeftUnit = _json["positionLeftUnit"];
    }
    if (_json.containsKey("positionTopUnit")) {
      positionTopUnit = _json["positionTopUnit"];
    }
    if (_json.containsKey("progressiveServingUrl")) {
      progressiveServingUrl = _json["progressiveServingUrl"];
    }
    if (_json.containsKey("pushdown")) {
      pushdown = _json["pushdown"];
    }
    if (_json.containsKey("pushdownDuration")) {
      pushdownDuration = _json["pushdownDuration"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("size")) {
      size = new Size.fromJson(_json["size"]);
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("startTimeType")) {
      startTimeType = _json["startTimeType"];
    }
    if (_json.containsKey("streamingServingUrl")) {
      streamingServingUrl = _json["streamingServingUrl"];
    }
    if (_json.containsKey("transparency")) {
      transparency = _json["transparency"];
    }
    if (_json.containsKey("verticallyLocked")) {
      verticallyLocked = _json["verticallyLocked"];
    }
    if (_json.containsKey("videoDuration")) {
      videoDuration = _json["videoDuration"];
    }
    if (_json.containsKey("windowMode")) {
      windowMode = _json["windowMode"];
    }
    if (_json.containsKey("zIndex")) {
      zIndex = _json["zIndex"];
    }
    if (_json.containsKey("zipFilename")) {
      zipFilename = _json["zipFilename"];
    }
    if (_json.containsKey("zipFilesize")) {
      zipFilesize = _json["zipFilesize"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actionScript3 != null) {
      _json["actionScript3"] = actionScript3;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (alignment != null) {
      _json["alignment"] = alignment;
    }
    if (artworkType != null) {
      _json["artworkType"] = artworkType;
    }
    if (assetIdentifier != null) {
      _json["assetIdentifier"] = (assetIdentifier).toJson();
    }
    if (backupImageExit != null) {
      _json["backupImageExit"] = (backupImageExit).toJson();
    }
    if (bitRate != null) {
      _json["bitRate"] = bitRate;
    }
    if (childAssetType != null) {
      _json["childAssetType"] = childAssetType;
    }
    if (collapsedSize != null) {
      _json["collapsedSize"] = (collapsedSize).toJson();
    }
    if (companionCreativeIds != null) {
      _json["companionCreativeIds"] = companionCreativeIds;
    }
    if (customStartTimeValue != null) {
      _json["customStartTimeValue"] = customStartTimeValue;
    }
    if (detectedFeatures != null) {
      _json["detectedFeatures"] = detectedFeatures;
    }
    if (displayType != null) {
      _json["displayType"] = displayType;
    }
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (durationType != null) {
      _json["durationType"] = durationType;
    }
    if (expandedDimension != null) {
      _json["expandedDimension"] = (expandedDimension).toJson();
    }
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (flashVersion != null) {
      _json["flashVersion"] = flashVersion;
    }
    if (hideFlashObjects != null) {
      _json["hideFlashObjects"] = hideFlashObjects;
    }
    if (hideSelectionBoxes != null) {
      _json["hideSelectionBoxes"] = hideSelectionBoxes;
    }
    if (horizontallyLocked != null) {
      _json["horizontallyLocked"] = horizontallyLocked;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (mimeType != null) {
      _json["mimeType"] = mimeType;
    }
    if (offset != null) {
      _json["offset"] = (offset).toJson();
    }
    if (originalBackup != null) {
      _json["originalBackup"] = originalBackup;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (positionLeftUnit != null) {
      _json["positionLeftUnit"] = positionLeftUnit;
    }
    if (positionTopUnit != null) {
      _json["positionTopUnit"] = positionTopUnit;
    }
    if (progressiveServingUrl != null) {
      _json["progressiveServingUrl"] = progressiveServingUrl;
    }
    if (pushdown != null) {
      _json["pushdown"] = pushdown;
    }
    if (pushdownDuration != null) {
      _json["pushdownDuration"] = pushdownDuration;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (size != null) {
      _json["size"] = (size).toJson();
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (startTimeType != null) {
      _json["startTimeType"] = startTimeType;
    }
    if (streamingServingUrl != null) {
      _json["streamingServingUrl"] = streamingServingUrl;
    }
    if (transparency != null) {
      _json["transparency"] = transparency;
    }
    if (verticallyLocked != null) {
      _json["verticallyLocked"] = verticallyLocked;
    }
    if (videoDuration != null) {
      _json["videoDuration"] = videoDuration;
    }
    if (windowMode != null) {
      _json["windowMode"] = windowMode;
    }
    if (zIndex != null) {
      _json["zIndex"] = zIndex;
    }
    if (zipFilename != null) {
      _json["zipFilename"] = zipFilename;
    }
    if (zipFilesize != null) {
      _json["zipFilesize"] = zipFilesize;
    }
    return _json;
  }
}

/** Creative Asset ID. */
class CreativeAssetId {
  /**
   * Name of the creative asset. This is a required field while inserting an
   * asset. After insertion, this assetIdentifier is used to identify the
   * uploaded asset. Characters in the name must be alphanumeric or one of the
   * following: ".-_ ". Spaces are allowed.
   */
  core.String name;
  /**
   * Type of asset to upload. This is a required field. FLASH and IMAGE are no
   * longer supported for new uploads. All image assets should use HTML_IMAGE.
   * Possible string values are:
   * - "FLASH"
   * - "HTML"
   * - "HTML_IMAGE"
   * - "IMAGE"
   * - "VIDEO"
   */
  core.String type;

  CreativeAssetId();

  CreativeAssetId.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * CreativeAssets contains properties of a creative asset file which will be
 * uploaded or has already been uploaded. Refer to the creative sample code for
 * how to upload assets and insert a creative.
 */
class CreativeAssetMetadata {
  /** ID of the creative asset. This is a required field. */
  CreativeAssetId assetIdentifier;
  /**
   * List of detected click tags for assets. This is a read-only auto-generated
   * field.
   */
  core.List<ClickTag> clickTags;
  /**
   * List of feature dependencies for the creative asset that are detected by
   * DCM. Feature dependencies are features that a browser must be able to
   * support in order to render your HTML5 creative correctly. This is a
   * read-only, auto-generated field.
   */
  core.List<core.String> detectedFeatures;
  /** Numeric ID of the asset. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the numeric ID of the asset. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeAssetMetadata".
   */
  core.String kind;
  /**
   * Rules validated during code generation that generated a warning. This is a
   * read-only, auto-generated field.
   *
   * Possible values are:
   * - "ADMOB_REFERENCED"
   * - "ASSET_FORMAT_UNSUPPORTED_DCM"
   * - "ASSET_INVALID"
   * - "CLICK_TAG_HARD_CODED"
   * - "CLICK_TAG_INVALID"
   * - "CLICK_TAG_IN_GWD"
   * - "CLICK_TAG_MISSING"
   * - "CLICK_TAG_MORE_THAN_ONE"
   * - "CLICK_TAG_NON_TOP_LEVEL"
   * - "COMPONENT_UNSUPPORTED_DCM"
   * - "ENABLER_UNSUPPORTED_METHOD_DCM"
   * - "EXTERNAL_FILE_REFERENCED"
   * - "FILE_DETAIL_EMPTY"
   * - "FILE_TYPE_INVALID"
   * - "GWD_PROPERTIES_INVALID"
   * - "HTML5_FEATURE_UNSUPPORTED"
   * - "LINKED_FILE_NOT_FOUND"
   * - "MAX_FLASH_VERSION_11"
   * - "MRAID_REFERENCED"
   * - "NOT_SSL_COMPLIANT"
   * - "ORPHANED_ASSET"
   * - "PRIMARY_HTML_MISSING"
   * - "SVG_INVALID"
   * - "ZIP_INVALID"
   */
  core.List<core.String> warnedValidationRules;

  CreativeAssetMetadata();

  CreativeAssetMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("assetIdentifier")) {
      assetIdentifier = new CreativeAssetId.fromJson(_json["assetIdentifier"]);
    }
    if (_json.containsKey("clickTags")) {
      clickTags = _json["clickTags"].map((value) => new ClickTag.fromJson(value)).toList();
    }
    if (_json.containsKey("detectedFeatures")) {
      detectedFeatures = _json["detectedFeatures"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("warnedValidationRules")) {
      warnedValidationRules = _json["warnedValidationRules"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (assetIdentifier != null) {
      _json["assetIdentifier"] = (assetIdentifier).toJson();
    }
    if (clickTags != null) {
      _json["clickTags"] = clickTags.map((value) => (value).toJson()).toList();
    }
    if (detectedFeatures != null) {
      _json["detectedFeatures"] = detectedFeatures;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (warnedValidationRules != null) {
      _json["warnedValidationRules"] = warnedValidationRules;
    }
    return _json;
  }
}

/**
 * Encapsulates the list of rules for asset selection and a default asset in
 * case none of the rules match. Applicable to INSTREAM_VIDEO creatives.
 */
class CreativeAssetSelection {
  /**
   * A creativeAssets[].id. This should refer to one of the parent assets in
   * this creative, and will be served if none of the rules match. This is a
   * required field.
   */
  core.String defaultAssetId;
  /**
   * Rules determine which asset will be served to a viewer. Rules will be
   * evaluated in the order in which they are stored in this list. This list
   * must contain at least one rule. Applicable to INSTREAM_VIDEO creatives.
   */
  core.List<Rule> rules;

  CreativeAssetSelection();

  CreativeAssetSelection.fromJson(core.Map _json) {
    if (_json.containsKey("defaultAssetId")) {
      defaultAssetId = _json["defaultAssetId"];
    }
    if (_json.containsKey("rules")) {
      rules = _json["rules"].map((value) => new Rule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultAssetId != null) {
      _json["defaultAssetId"] = defaultAssetId;
    }
    if (rules != null) {
      _json["rules"] = rules.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Creative Assignment. */
class CreativeAssignment {
  /**
   * Whether this creative assignment is active. When true, the creative will be
   * included in the ad's rotation.
   */
  core.bool active;
  /**
   * Whether applicable event tags should fire when this creative assignment is
   * rendered. If this value is unset when the ad is inserted or updated, it
   * will default to true for all creative types EXCEPT for INTERNAL_REDIRECT,
   * INTERSTITIAL_INTERNAL_REDIRECT, and INSTREAM_VIDEO.
   */
  core.bool applyEventTags;
  /** Click-through URL of the creative assignment. */
  ClickThroughUrl clickThroughUrl;
  /**
   * Companion creative overrides for this creative assignment. Applicable to
   * video ads.
   */
  core.List<CompanionClickThroughOverride> companionCreativeOverrides;
  /**
   * Creative group assignments for this creative assignment. Only one
   * assignment per creative group number is allowed for a maximum of two
   * assignments.
   */
  core.List<CreativeGroupAssignment> creativeGroupAssignments;
  /** ID of the creative to be assigned. This is a required field. */
  core.String creativeId;
  /**
   * Dimension value for the ID of the creative. This is a read-only,
   * auto-generated field.
   */
  DimensionValue creativeIdDimensionValue;
  /**
   * Date and time that the assigned creative should stop serving. Must be later
   * than the start time.
   */
  core.DateTime endTime;
  /**
   * Rich media exit overrides for this creative assignment.
   * Applicable when the creative type is any of the following:
   * - RICH_MEDIA_INPAGE
   * - RICH_MEDIA_INPAGE_FLOATING
   * - RICH_MEDIA_IM_EXPAND
   * - RICH_MEDIA_EXPANDING
   * - RICH_MEDIA_INTERSTITIAL_FLOAT
   * - RICH_MEDIA_MOBILE_IN_APP
   * - RICH_MEDIA_MULTI_FLOATING
   * - RICH_MEDIA_PEEL_DOWN
   * - ADVANCED_BANNER
   * - VPAID_LINEAR
   * - VPAID_NON_LINEAR
   */
  core.List<RichMediaExitOverride> richMediaExitOverrides;
  /**
   * Sequence number of the creative assignment, applicable when the rotation
   * type is CREATIVE_ROTATION_TYPE_SEQUENTIAL.
   */
  core.int sequence;
  /**
   * Whether the creative to be assigned is SSL-compliant. This is a read-only
   * field that is auto-generated when the ad is inserted or updated.
   */
  core.bool sslCompliant;
  /** Date and time that the assigned creative should start serving. */
  core.DateTime startTime;
  /**
   * Weight of the creative assignment, applicable when the rotation type is
   * CREATIVE_ROTATION_TYPE_RANDOM.
   */
  core.int weight;

  CreativeAssignment();

  CreativeAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("applyEventTags")) {
      applyEventTags = _json["applyEventTags"];
    }
    if (_json.containsKey("clickThroughUrl")) {
      clickThroughUrl = new ClickThroughUrl.fromJson(_json["clickThroughUrl"]);
    }
    if (_json.containsKey("companionCreativeOverrides")) {
      companionCreativeOverrides = _json["companionCreativeOverrides"].map((value) => new CompanionClickThroughOverride.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeGroupAssignments")) {
      creativeGroupAssignments = _json["creativeGroupAssignments"].map((value) => new CreativeGroupAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("creativeIdDimensionValue")) {
      creativeIdDimensionValue = new DimensionValue.fromJson(_json["creativeIdDimensionValue"]);
    }
    if (_json.containsKey("endTime")) {
      endTime = core.DateTime.parse(_json["endTime"]);
    }
    if (_json.containsKey("richMediaExitOverrides")) {
      richMediaExitOverrides = _json["richMediaExitOverrides"].map((value) => new RichMediaExitOverride.fromJson(value)).toList();
    }
    if (_json.containsKey("sequence")) {
      sequence = _json["sequence"];
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("startTime")) {
      startTime = core.DateTime.parse(_json["startTime"]);
    }
    if (_json.containsKey("weight")) {
      weight = _json["weight"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (applyEventTags != null) {
      _json["applyEventTags"] = applyEventTags;
    }
    if (clickThroughUrl != null) {
      _json["clickThroughUrl"] = (clickThroughUrl).toJson();
    }
    if (companionCreativeOverrides != null) {
      _json["companionCreativeOverrides"] = companionCreativeOverrides.map((value) => (value).toJson()).toList();
    }
    if (creativeGroupAssignments != null) {
      _json["creativeGroupAssignments"] = creativeGroupAssignments.map((value) => (value).toJson()).toList();
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (creativeIdDimensionValue != null) {
      _json["creativeIdDimensionValue"] = (creativeIdDimensionValue).toJson();
    }
    if (endTime != null) {
      _json["endTime"] = (endTime).toIso8601String();
    }
    if (richMediaExitOverrides != null) {
      _json["richMediaExitOverrides"] = richMediaExitOverrides.map((value) => (value).toJson()).toList();
    }
    if (sequence != null) {
      _json["sequence"] = sequence;
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (startTime != null) {
      _json["startTime"] = (startTime).toIso8601String();
    }
    if (weight != null) {
      _json["weight"] = weight;
    }
    return _json;
  }
}

/** Creative Custom Event. */
class CreativeCustomEvent {
  /**
   * Unique ID of this event used by DDM Reporting and Data Transfer. This is a
   * read-only field.
   */
  core.String advertiserCustomEventId;
  /** User-entered name for the event. */
  core.String advertiserCustomEventName;
  /**
   * Type of the event. This is a read-only field.
   * Possible string values are:
   * - "ADVERTISER_EVENT_COUNTER"
   * - "ADVERTISER_EVENT_EXIT"
   * - "ADVERTISER_EVENT_TIMER"
   */
  core.String advertiserCustomEventType;
  /**
   * Artwork label column, used to link events in DCM back to events in Studio.
   * This is a required field and should not be modified after insertion.
   */
  core.String artworkLabel;
  /**
   * Artwork type used by the creative.This is a read-only field.
   * Possible string values are:
   * - "ARTWORK_TYPE_FLASH"
   * - "ARTWORK_TYPE_HTML5"
   * - "ARTWORK_TYPE_IMAGE"
   * - "ARTWORK_TYPE_MIXED"
   */
  core.String artworkType;
  /** Exit URL of the event. This field is used only for exit events. */
  core.String exitUrl;
  /**
   * ID of this event. This is a required field and should not be modified after
   * insertion.
   */
  core.String id;
  /**
   * Properties for rich media popup windows. This field is used only for exit
   * events.
   */
  PopupWindowProperties popupWindowProperties;
  /**
   * Target type used by the event.
   * Possible string values are:
   * - "TARGET_BLANK"
   * - "TARGET_PARENT"
   * - "TARGET_POPUP"
   * - "TARGET_SELF"
   * - "TARGET_TOP"
   */
  core.String targetType;
  /**
   * Video reporting ID, used to differentiate multiple videos in a single
   * creative. This is a read-only field.
   */
  core.String videoReportingId;

  CreativeCustomEvent();

  CreativeCustomEvent.fromJson(core.Map _json) {
    if (_json.containsKey("advertiserCustomEventId")) {
      advertiserCustomEventId = _json["advertiserCustomEventId"];
    }
    if (_json.containsKey("advertiserCustomEventName")) {
      advertiserCustomEventName = _json["advertiserCustomEventName"];
    }
    if (_json.containsKey("advertiserCustomEventType")) {
      advertiserCustomEventType = _json["advertiserCustomEventType"];
    }
    if (_json.containsKey("artworkLabel")) {
      artworkLabel = _json["artworkLabel"];
    }
    if (_json.containsKey("artworkType")) {
      artworkType = _json["artworkType"];
    }
    if (_json.containsKey("exitUrl")) {
      exitUrl = _json["exitUrl"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("popupWindowProperties")) {
      popupWindowProperties = new PopupWindowProperties.fromJson(_json["popupWindowProperties"]);
    }
    if (_json.containsKey("targetType")) {
      targetType = _json["targetType"];
    }
    if (_json.containsKey("videoReportingId")) {
      videoReportingId = _json["videoReportingId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (advertiserCustomEventId != null) {
      _json["advertiserCustomEventId"] = advertiserCustomEventId;
    }
    if (advertiserCustomEventName != null) {
      _json["advertiserCustomEventName"] = advertiserCustomEventName;
    }
    if (advertiserCustomEventType != null) {
      _json["advertiserCustomEventType"] = advertiserCustomEventType;
    }
    if (artworkLabel != null) {
      _json["artworkLabel"] = artworkLabel;
    }
    if (artworkType != null) {
      _json["artworkType"] = artworkType;
    }
    if (exitUrl != null) {
      _json["exitUrl"] = exitUrl;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (popupWindowProperties != null) {
      _json["popupWindowProperties"] = (popupWindowProperties).toJson();
    }
    if (targetType != null) {
      _json["targetType"] = targetType;
    }
    if (videoReportingId != null) {
      _json["videoReportingId"] = videoReportingId;
    }
    return _json;
  }
}

/** Contains properties of a creative field. */
class CreativeField {
  /**
   * Account ID of this creative field. This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this creative field. This is a required field on
   * insertion.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** ID of this creative field. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeField".
   */
  core.String kind;
  /**
   * Name of this creative field. This is a required field and must be less than
   * 256 characters long and unique among creative fields of the same
   * advertiser.
   */
  core.String name;
  /**
   * Subaccount ID of this creative field. This is a read-only field that can be
   * left blank.
   */
  core.String subaccountId;

  CreativeField();

  CreativeField.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Creative Field Assignment. */
class CreativeFieldAssignment {
  /** ID of the creative field. */
  core.String creativeFieldId;
  /** ID of the creative field value. */
  core.String creativeFieldValueId;

  CreativeFieldAssignment();

  CreativeFieldAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("creativeFieldId")) {
      creativeFieldId = _json["creativeFieldId"];
    }
    if (_json.containsKey("creativeFieldValueId")) {
      creativeFieldValueId = _json["creativeFieldValueId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeFieldId != null) {
      _json["creativeFieldId"] = creativeFieldId;
    }
    if (creativeFieldValueId != null) {
      _json["creativeFieldValueId"] = creativeFieldValueId;
    }
    return _json;
  }
}

/** Contains properties of a creative field value. */
class CreativeFieldValue {
  /**
   * ID of this creative field value. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeFieldValue".
   */
  core.String kind;
  /**
   * Value of this creative field value. It needs to be less than 256 characters
   * in length and unique per creative field.
   */
  core.String value;

  CreativeFieldValue();

  CreativeFieldValue.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Creative Field Value List Response */
class CreativeFieldValuesListResponse {
  /** Creative field value collection. */
  core.List<CreativeFieldValue> creativeFieldValues;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeFieldValuesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CreativeFieldValuesListResponse();

  CreativeFieldValuesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creativeFieldValues")) {
      creativeFieldValues = _json["creativeFieldValues"].map((value) => new CreativeFieldValue.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeFieldValues != null) {
      _json["creativeFieldValues"] = creativeFieldValues.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Creative Field List Response */
class CreativeFieldsListResponse {
  /** Creative field collection. */
  core.List<CreativeField> creativeFields;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeFieldsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CreativeFieldsListResponse();

  CreativeFieldsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creativeFields")) {
      creativeFields = _json["creativeFields"].map((value) => new CreativeField.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeFields != null) {
      _json["creativeFields"] = creativeFields.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Contains properties of a creative group. */
class CreativeGroup {
  /**
   * Account ID of this creative group. This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this creative group. This is a required field on
   * insertion.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /**
   * Subgroup of the creative group. Assign your creative groups to one of the
   * following subgroups in order to filter or manage them more easily. This
   * field is required on insertion and is read-only after insertion.
   * Acceptable values are:
   * - 1
   * - 2
   */
  core.int groupNumber;
  /** ID of this creative group. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeGroup".
   */
  core.String kind;
  /**
   * Name of this creative group. This is a required field and must be less than
   * 256 characters long and unique among creative groups of the same
   * advertiser.
   */
  core.String name;
  /**
   * Subaccount ID of this creative group. This is a read-only field that can be
   * left blank.
   */
  core.String subaccountId;

  CreativeGroup();

  CreativeGroup.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("groupNumber")) {
      groupNumber = _json["groupNumber"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (groupNumber != null) {
      _json["groupNumber"] = groupNumber;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Creative Group Assignment. */
class CreativeGroupAssignment {
  /** ID of the creative group to be assigned. */
  core.String creativeGroupId;
  /**
   * Creative group number of the creative group assignment.
   * Possible string values are:
   * - "CREATIVE_GROUP_ONE"
   * - "CREATIVE_GROUP_TWO"
   */
  core.String creativeGroupNumber;

  CreativeGroupAssignment();

  CreativeGroupAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("creativeGroupId")) {
      creativeGroupId = _json["creativeGroupId"];
    }
    if (_json.containsKey("creativeGroupNumber")) {
      creativeGroupNumber = _json["creativeGroupNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeGroupId != null) {
      _json["creativeGroupId"] = creativeGroupId;
    }
    if (creativeGroupNumber != null) {
      _json["creativeGroupNumber"] = creativeGroupNumber;
    }
    return _json;
  }
}

/** Creative Group List Response */
class CreativeGroupsListResponse {
  /** Creative group collection. */
  core.List<CreativeGroup> creativeGroups;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativeGroupsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CreativeGroupsListResponse();

  CreativeGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creativeGroups")) {
      creativeGroups = _json["creativeGroups"].map((value) => new CreativeGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeGroups != null) {
      _json["creativeGroups"] = creativeGroups.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Creative optimization settings. */
class CreativeOptimizationConfiguration {
  /**
   * ID of this creative optimization config. This field is auto-generated when
   * the campaign is inserted or updated. It can be null for existing campaigns.
   */
  core.String id;
  /**
   * Name of this creative optimization config. This is a required field and
   * must be less than 129 characters long.
   */
  core.String name;
  /** List of optimization activities associated with this configuration. */
  core.List<OptimizationActivity> optimizationActivitys;
  /**
   * Optimization model for this configuration.
   * Possible string values are:
   * - "CLICK"
   * - "POST_CLICK"
   * - "POST_CLICK_AND_IMPRESSION"
   * - "POST_IMPRESSION"
   * - "VIDEO_COMPLETION"
   */
  core.String optimizationModel;

  CreativeOptimizationConfiguration();

  CreativeOptimizationConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("optimizationActivitys")) {
      optimizationActivitys = _json["optimizationActivitys"].map((value) => new OptimizationActivity.fromJson(value)).toList();
    }
    if (_json.containsKey("optimizationModel")) {
      optimizationModel = _json["optimizationModel"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (optimizationActivitys != null) {
      _json["optimizationActivitys"] = optimizationActivitys.map((value) => (value).toJson()).toList();
    }
    if (optimizationModel != null) {
      _json["optimizationModel"] = optimizationModel;
    }
    return _json;
  }
}

/** Creative Rotation. */
class CreativeRotation {
  /** Creative assignments in this creative rotation. */
  core.List<CreativeAssignment> creativeAssignments;
  /**
   * Creative optimization configuration that is used by this ad. It should
   * refer to one of the existing optimization configurations in the ad's
   * campaign. If it is unset or set to 0, then the campaign's default
   * optimization configuration will be used for this ad.
   */
  core.String creativeOptimizationConfigurationId;
  /**
   * Type of creative rotation. Can be used to specify whether to use sequential
   * or random rotation.
   * Possible string values are:
   * - "CREATIVE_ROTATION_TYPE_RANDOM"
   * - "CREATIVE_ROTATION_TYPE_SEQUENTIAL"
   */
  core.String type;
  /**
   * Strategy for calculating weights. Used with CREATIVE_ROTATION_TYPE_RANDOM.
   * Possible string values are:
   * - "WEIGHT_STRATEGY_CUSTOM"
   * - "WEIGHT_STRATEGY_EQUAL"
   * - "WEIGHT_STRATEGY_HIGHEST_CTR"
   * - "WEIGHT_STRATEGY_OPTIMIZED"
   */
  core.String weightCalculationStrategy;

  CreativeRotation();

  CreativeRotation.fromJson(core.Map _json) {
    if (_json.containsKey("creativeAssignments")) {
      creativeAssignments = _json["creativeAssignments"].map((value) => new CreativeAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("creativeOptimizationConfigurationId")) {
      creativeOptimizationConfigurationId = _json["creativeOptimizationConfigurationId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("weightCalculationStrategy")) {
      weightCalculationStrategy = _json["weightCalculationStrategy"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creativeAssignments != null) {
      _json["creativeAssignments"] = creativeAssignments.map((value) => (value).toJson()).toList();
    }
    if (creativeOptimizationConfigurationId != null) {
      _json["creativeOptimizationConfigurationId"] = creativeOptimizationConfigurationId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (weightCalculationStrategy != null) {
      _json["weightCalculationStrategy"] = weightCalculationStrategy;
    }
    return _json;
  }
}

/** Creative Settings */
class CreativeSettings {
  /**
   * Header text for iFrames for this site. Must be less than or equal to 2000
   * characters long.
   */
  core.String iFrameFooter;
  /**
   * Header text for iFrames for this site. Must be less than or equal to 2000
   * characters long.
   */
  core.String iFrameHeader;

  CreativeSettings();

  CreativeSettings.fromJson(core.Map _json) {
    if (_json.containsKey("iFrameFooter")) {
      iFrameFooter = _json["iFrameFooter"];
    }
    if (_json.containsKey("iFrameHeader")) {
      iFrameHeader = _json["iFrameHeader"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (iFrameFooter != null) {
      _json["iFrameFooter"] = iFrameFooter;
    }
    if (iFrameHeader != null) {
      _json["iFrameHeader"] = iFrameHeader;
    }
    return _json;
  }
}

/** Creative List Response */
class CreativesListResponse {
  /** Creative collection. */
  core.List<Creative> creatives;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#creativesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  CreativesListResponse();

  CreativesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("creatives")) {
      creatives = _json["creatives"].map((value) => new Creative.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creatives != null) {
      _json["creatives"] = creatives.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * Represents fields that are compatible to be selected for a report of type
 * "CROSS_DIMENSION_REACH".
 */
class CrossDimensionReachReportCompatibleFields {
  /**
   * Dimensions which are compatible to be selected in the "breakdown" section
   * of the report.
   */
  core.List<Dimension> breakdown;
  /**
   * Dimensions which are compatible to be selected in the "dimensionFilters"
   * section of the report.
   */
  core.List<Dimension> dimensionFilters;
  /**
   * The kind of resource this is, in this case
   * dfareporting#crossDimensionReachReportCompatibleFields.
   */
  core.String kind;
  /**
   * Metrics which are compatible to be selected in the "metricNames" section of
   * the report.
   */
  core.List<Metric> metrics;
  /**
   * Metrics which are compatible to be selected in the "overlapMetricNames"
   * section of the report.
   */
  core.List<Metric> overlapMetrics;

  CrossDimensionReachReportCompatibleFields();

  CrossDimensionReachReportCompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("breakdown")) {
      breakdown = _json["breakdown"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("overlapMetrics")) {
      overlapMetrics = _json["overlapMetrics"].map((value) => new Metric.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakdown != null) {
      _json["breakdown"] = breakdown.map((value) => (value).toJson()).toList();
    }
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (overlapMetrics != null) {
      _json["overlapMetrics"] = overlapMetrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A custom floodlight variable. */
class CustomFloodlightVariable {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#customFloodlightVariable".
   */
  core.String kind;
  /**
   * The type of custom floodlight variable to supply a value for. These map to
   * the "u[1-20]=" in the tags.
   * Possible string values are:
   * - "U1"
   * - "U10"
   * - "U100"
   * - "U11"
   * - "U12"
   * - "U13"
   * - "U14"
   * - "U15"
   * - "U16"
   * - "U17"
   * - "U18"
   * - "U19"
   * - "U2"
   * - "U20"
   * - "U21"
   * - "U22"
   * - "U23"
   * - "U24"
   * - "U25"
   * - "U26"
   * - "U27"
   * - "U28"
   * - "U29"
   * - "U3"
   * - "U30"
   * - "U31"
   * - "U32"
   * - "U33"
   * - "U34"
   * - "U35"
   * - "U36"
   * - "U37"
   * - "U38"
   * - "U39"
   * - "U4"
   * - "U40"
   * - "U41"
   * - "U42"
   * - "U43"
   * - "U44"
   * - "U45"
   * - "U46"
   * - "U47"
   * - "U48"
   * - "U49"
   * - "U5"
   * - "U50"
   * - "U51"
   * - "U52"
   * - "U53"
   * - "U54"
   * - "U55"
   * - "U56"
   * - "U57"
   * - "U58"
   * - "U59"
   * - "U6"
   * - "U60"
   * - "U61"
   * - "U62"
   * - "U63"
   * - "U64"
   * - "U65"
   * - "U66"
   * - "U67"
   * - "U68"
   * - "U69"
   * - "U7"
   * - "U70"
   * - "U71"
   * - "U72"
   * - "U73"
   * - "U74"
   * - "U75"
   * - "U76"
   * - "U77"
   * - "U78"
   * - "U79"
   * - "U8"
   * - "U80"
   * - "U81"
   * - "U82"
   * - "U83"
   * - "U84"
   * - "U85"
   * - "U86"
   * - "U87"
   * - "U88"
   * - "U89"
   * - "U9"
   * - "U90"
   * - "U91"
   * - "U92"
   * - "U93"
   * - "U94"
   * - "U95"
   * - "U96"
   * - "U97"
   * - "U98"
   * - "U99"
   */
  core.String type;
  /**
   * The value of the custom floodlight variable. The length of string must not
   * exceed 50 characters.
   */
  core.String value;

  CustomFloodlightVariable();

  CustomFloodlightVariable.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Represents a Custom Rich Media Events group. */
class CustomRichMediaEvents {
  /**
   * List of custom rich media event IDs. Dimension values must be all of type
   * dfa:richMediaEventTypeIdAndName.
   */
  core.List<DimensionValue> filteredEventIds;
  /**
   * The kind of resource this is, in this case
   * dfareporting#customRichMediaEvents.
   */
  core.String kind;

  CustomRichMediaEvents();

  CustomRichMediaEvents.fromJson(core.Map _json) {
    if (_json.containsKey("filteredEventIds")) {
      filteredEventIds = _json["filteredEventIds"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filteredEventIds != null) {
      _json["filteredEventIds"] = filteredEventIds.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Represents a date range. */
class DateRange {
  /**
   * The end date of the date range, inclusive. A string of the format:
   * "yyyy-MM-dd".
   */
  core.DateTime endDate;
  /** The kind of resource this is, in this case dfareporting#dateRange. */
  core.String kind;
  /**
   * The date range relative to the date of when the report is run.
   * Possible string values are:
   * - "LAST_24_MONTHS"
   * - "LAST_30_DAYS"
   * - "LAST_365_DAYS"
   * - "LAST_7_DAYS"
   * - "LAST_90_DAYS"
   * - "MONTH_TO_DATE"
   * - "PREVIOUS_MONTH"
   * - "PREVIOUS_QUARTER"
   * - "PREVIOUS_WEEK"
   * - "PREVIOUS_YEAR"
   * - "QUARTER_TO_DATE"
   * - "TODAY"
   * - "WEEK_TO_DATE"
   * - "YEAR_TO_DATE"
   * - "YESTERDAY"
   */
  core.String relativeDateRange;
  /**
   * The start date of the date range, inclusive. A string of the format:
   * "yyyy-MM-dd".
   */
  core.DateTime startDate;

  DateRange();

  DateRange.fromJson(core.Map _json) {
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("relativeDateRange")) {
      relativeDateRange = _json["relativeDateRange"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (relativeDateRange != null) {
      _json["relativeDateRange"] = relativeDateRange;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    return _json;
  }
}

/** Day Part Targeting. */
class DayPartTargeting {
  /**
   * Days of the week when the ad will serve.
   *
   * Acceptable values are:
   * - "SUNDAY"
   * - "MONDAY"
   * - "TUESDAY"
   * - "WEDNESDAY"
   * - "THURSDAY"
   * - "FRIDAY"
   * - "SATURDAY"
   */
  core.List<core.String> daysOfWeek;
  /**
   * Hours of the day when the ad will serve. Must be an integer between 0 and
   * 23 (inclusive), where 0 is midnight to 1 AM, and 23 is 11 PM to midnight.
   * Can be specified with days of week, in which case the ad would serve during
   * these hours on the specified days. For example, if Monday, Wednesday,
   * Friday are the days of week specified and 9-10am, 3-5pm (hours 9, 15, and
   * 16) is specified, the ad would serve Monday, Wednesdays, and Fridays at
   * 9-10am and 3-5pm.
   */
  core.List<core.int> hoursOfDay;
  /**
   * Whether or not to use the user's local time. If false, the America/New York
   * time zone applies.
   */
  core.bool userLocalTime;

  DayPartTargeting();

  DayPartTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("daysOfWeek")) {
      daysOfWeek = _json["daysOfWeek"];
    }
    if (_json.containsKey("hoursOfDay")) {
      hoursOfDay = _json["hoursOfDay"];
    }
    if (_json.containsKey("userLocalTime")) {
      userLocalTime = _json["userLocalTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (daysOfWeek != null) {
      _json["daysOfWeek"] = daysOfWeek;
    }
    if (hoursOfDay != null) {
      _json["hoursOfDay"] = hoursOfDay;
    }
    if (userLocalTime != null) {
      _json["userLocalTime"] = userLocalTime;
    }
    return _json;
  }
}

/**
 * Properties of inheriting and overriding the default click-through event tag.
 * A campaign may override the event tag defined at the advertiser level, and an
 * ad may also override the campaign's setting further.
 */
class DefaultClickThroughEventTagProperties {
  /**
   * ID of the click-through event tag to apply to all ads in this entity's
   * scope.
   */
  core.String defaultClickThroughEventTagId;
  /**
   * Whether this entity should override the inherited default click-through
   * event tag with its own defined value.
   */
  core.bool overrideInheritedEventTag;

  DefaultClickThroughEventTagProperties();

  DefaultClickThroughEventTagProperties.fromJson(core.Map _json) {
    if (_json.containsKey("defaultClickThroughEventTagId")) {
      defaultClickThroughEventTagId = _json["defaultClickThroughEventTagId"];
    }
    if (_json.containsKey("overrideInheritedEventTag")) {
      overrideInheritedEventTag = _json["overrideInheritedEventTag"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultClickThroughEventTagId != null) {
      _json["defaultClickThroughEventTagId"] = defaultClickThroughEventTagId;
    }
    if (overrideInheritedEventTag != null) {
      _json["overrideInheritedEventTag"] = overrideInheritedEventTag;
    }
    return _json;
  }
}

/** Delivery Schedule. */
class DeliverySchedule {
  /**
   * Limit on the number of times an individual user can be served the ad within
   * a specified period of time.
   */
  FrequencyCap frequencyCap;
  /**
   * Whether or not hard cutoff is enabled. If true, the ad will not serve after
   * the end date and time. Otherwise the ad will continue to be served until it
   * has reached its delivery goals.
   */
  core.bool hardCutoff;
  /**
   * Impression ratio for this ad. This ratio determines how often each ad is
   * served relative to the others. For example, if ad A has an impression ratio
   * of 1 and ad B has an impression ratio of 3, then DCM will serve ad B three
   * times as often as ad A. Must be between 1 and 10.
   */
  core.String impressionRatio;
  /**
   * Serving priority of an ad, with respect to other ads. The lower the
   * priority number, the greater the priority with which it is served.
   * Possible string values are:
   * - "AD_PRIORITY_01"
   * - "AD_PRIORITY_02"
   * - "AD_PRIORITY_03"
   * - "AD_PRIORITY_04"
   * - "AD_PRIORITY_05"
   * - "AD_PRIORITY_06"
   * - "AD_PRIORITY_07"
   * - "AD_PRIORITY_08"
   * - "AD_PRIORITY_09"
   * - "AD_PRIORITY_10"
   * - "AD_PRIORITY_11"
   * - "AD_PRIORITY_12"
   * - "AD_PRIORITY_13"
   * - "AD_PRIORITY_14"
   * - "AD_PRIORITY_15"
   * - "AD_PRIORITY_16"
   */
  core.String priority;

  DeliverySchedule();

  DeliverySchedule.fromJson(core.Map _json) {
    if (_json.containsKey("frequencyCap")) {
      frequencyCap = new FrequencyCap.fromJson(_json["frequencyCap"]);
    }
    if (_json.containsKey("hardCutoff")) {
      hardCutoff = _json["hardCutoff"];
    }
    if (_json.containsKey("impressionRatio")) {
      impressionRatio = _json["impressionRatio"];
    }
    if (_json.containsKey("priority")) {
      priority = _json["priority"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (frequencyCap != null) {
      _json["frequencyCap"] = (frequencyCap).toJson();
    }
    if (hardCutoff != null) {
      _json["hardCutoff"] = hardCutoff;
    }
    if (impressionRatio != null) {
      _json["impressionRatio"] = impressionRatio;
    }
    if (priority != null) {
      _json["priority"] = priority;
    }
    return _json;
  }
}

/** DFP Settings */
class DfpSettings {
  /** DFP network code for this directory site. */
  core.String dfpNetworkCode;
  /** DFP network name for this directory site. */
  core.String dfpNetworkName;
  /** Whether this directory site accepts programmatic placements. */
  core.bool programmaticPlacementAccepted;
  /** Whether this directory site accepts publisher-paid tags. */
  core.bool pubPaidPlacementAccepted;
  /**
   * Whether this directory site is available only via DoubleClick Publisher
   * Portal.
   */
  core.bool publisherPortalOnly;

  DfpSettings();

  DfpSettings.fromJson(core.Map _json) {
    if (_json.containsKey("dfp_network_code")) {
      dfpNetworkCode = _json["dfp_network_code"];
    }
    if (_json.containsKey("dfp_network_name")) {
      dfpNetworkName = _json["dfp_network_name"];
    }
    if (_json.containsKey("programmaticPlacementAccepted")) {
      programmaticPlacementAccepted = _json["programmaticPlacementAccepted"];
    }
    if (_json.containsKey("pubPaidPlacementAccepted")) {
      pubPaidPlacementAccepted = _json["pubPaidPlacementAccepted"];
    }
    if (_json.containsKey("publisherPortalOnly")) {
      publisherPortalOnly = _json["publisherPortalOnly"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dfpNetworkCode != null) {
      _json["dfp_network_code"] = dfpNetworkCode;
    }
    if (dfpNetworkName != null) {
      _json["dfp_network_name"] = dfpNetworkName;
    }
    if (programmaticPlacementAccepted != null) {
      _json["programmaticPlacementAccepted"] = programmaticPlacementAccepted;
    }
    if (pubPaidPlacementAccepted != null) {
      _json["pubPaidPlacementAccepted"] = pubPaidPlacementAccepted;
    }
    if (publisherPortalOnly != null) {
      _json["publisherPortalOnly"] = publisherPortalOnly;
    }
    return _json;
  }
}

/** Represents a dimension. */
class Dimension {
  /** The kind of resource this is, in this case dfareporting#dimension. */
  core.String kind;
  /** The dimension name, e.g. dfa:advertiser */
  core.String name;

  Dimension();

  Dimension.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Represents a dimension filter. */
class DimensionFilter {
  /** The name of the dimension to filter. */
  core.String dimensionName;
  /**
   * The kind of resource this is, in this case dfareporting#dimensionFilter.
   */
  core.String kind;
  /** The value of the dimension to filter. */
  core.String value;

  DimensionFilter();

  DimensionFilter.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionName")) {
      dimensionName = _json["dimensionName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionName != null) {
      _json["dimensionName"] = dimensionName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Represents a DimensionValue resource. */
class DimensionValue {
  /** The name of the dimension. */
  core.String dimensionName;
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The ID associated with the value if available. */
  core.String id;
  /**
   * The kind of resource this is, in this case dfareporting#dimensionValue.
   */
  core.String kind;
  /**
   * Determines how the 'value' field is matched when filtering. If not
   * specified, defaults to EXACT. If set to WILDCARD_EXPRESSION, '*' is allowed
   * as a placeholder for variable length character sequences, and it can be
   * escaped with a backslash. Note, only paid search dimensions
   * ('dfa:paidSearch*') allow a matchType other than EXACT.
   * Possible string values are:
   * - "BEGINS_WITH"
   * - "CONTAINS"
   * - "EXACT"
   * - "WILDCARD_EXPRESSION"
   */
  core.String matchType;
  /** The value of the dimension. */
  core.String value;

  DimensionValue();

  DimensionValue.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionName")) {
      dimensionName = _json["dimensionName"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("matchType")) {
      matchType = _json["matchType"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionName != null) {
      _json["dimensionName"] = dimensionName;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (matchType != null) {
      _json["matchType"] = matchType;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Represents the list of DimensionValue resources. */
class DimensionValueList {
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The dimension values returned in this response. */
  core.List<DimensionValue> items;
  /**
   * The kind of list this is, in this case dfareporting#dimensionValueList.
   */
  core.String kind;
  /**
   * Continuation token used to page through dimension values. To retrieve the
   * next page of results, set the next request's "pageToken" to the value of
   * this field. The page token is only valid for a limited amount of time and
   * should not be persisted.
   */
  core.String nextPageToken;

  DimensionValueList();

  DimensionValueList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Represents a DimensionValuesRequest. */
class DimensionValueRequest {
  /** The name of the dimension for which values should be requested. */
  core.String dimensionName;
  /**
   * The end date of the date range for which to retrieve dimension values. A
   * string of the format "yyyy-MM-dd".
   */
  core.DateTime endDate;
  /** The list of filters by which to filter values. The filters are ANDed. */
  core.List<DimensionFilter> filters;
  /**
   * The kind of request this is, in this case
   * dfareporting#dimensionValueRequest.
   */
  core.String kind;
  /**
   * The start date of the date range for which to retrieve dimension values. A
   * string of the format "yyyy-MM-dd".
   */
  core.DateTime startDate;

  DimensionValueRequest();

  DimensionValueRequest.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionName")) {
      dimensionName = _json["dimensionName"];
    }
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new DimensionFilter.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionName != null) {
      _json["dimensionName"] = dimensionName;
    }
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    return _json;
  }
}

/**
 * DirectorySites contains properties of a website from the Site Directory.
 * Sites need to be added to an account via the Sites resource before they can
 * be assigned to a placement.
 */
class DirectorySite {
  /** Whether this directory site is active. */
  core.bool active;
  /** Directory site contacts. */
  core.List<DirectorySiteContactAssignment> contactAssignments;
  /** Country ID of this directory site. */
  core.String countryId;
  /**
   * Currency ID of this directory site.
   * Possible values are:
   * - "1" for USD
   * - "2" for GBP
   * - "3" for ESP
   * - "4" for SEK
   * - "5" for CAD
   * - "6" for JPY
   * - "7" for DEM
   * - "8" for AUD
   * - "9" for FRF
   * - "10" for ITL
   * - "11" for DKK
   * - "12" for NOK
   * - "13" for FIM
   * - "14" for ZAR
   * - "15" for IEP
   * - "16" for NLG
   * - "17" for EUR
   * - "18" for KRW
   * - "19" for TWD
   * - "20" for SGD
   * - "21" for CNY
   * - "22" for HKD
   * - "23" for NZD
   * - "24" for MYR
   * - "25" for BRL
   * - "26" for PTE
   * - "27" for MXP
   * - "28" for CLP
   * - "29" for TRY
   * - "30" for ARS
   * - "31" for PEN
   * - "32" for ILS
   * - "33" for CHF
   * - "34" for VEF
   * - "35" for COP
   * - "36" for GTQ
   * - "37" for PLN
   * - "39" for INR
   * - "40" for THB
   * - "41" for IDR
   * - "42" for CZK
   * - "43" for RON
   * - "44" for HUF
   * - "45" for RUB
   * - "46" for AED
   * - "47" for BGN
   * - "48" for HRK
   */
  core.String currencyId;
  /** Description of this directory site. */
  core.String description;
  /** ID of this directory site. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this directory site. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Tag types for regular placements.
   *
   * Acceptable values are:
   * - "STANDARD"
   * - "IFRAME_JAVASCRIPT_INPAGE"
   * - "INTERNAL_REDIRECT_INPAGE"
   * - "JAVASCRIPT_INPAGE"
   */
  core.List<core.String> inpageTagFormats;
  /**
   * Tag types for interstitial placements.
   *
   * Acceptable values are:
   * - "IFRAME_JAVASCRIPT_INTERSTITIAL"
   * - "INTERNAL_REDIRECT_INTERSTITIAL"
   * - "JAVASCRIPT_INTERSTITIAL"
   */
  core.List<core.String> interstitialTagFormats;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#directorySite".
   */
  core.String kind;
  /** Name of this directory site. */
  core.String name;
  /** Parent directory site ID. */
  core.String parentId;
  /** Directory site settings. */
  DirectorySiteSettings settings;
  /** URL of this directory site. */
  core.String url;

  DirectorySite();

  DirectorySite.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("contactAssignments")) {
      contactAssignments = _json["contactAssignments"].map((value) => new DirectorySiteContactAssignment.fromJson(value)).toList();
    }
    if (_json.containsKey("countryId")) {
      countryId = _json["countryId"];
    }
    if (_json.containsKey("currencyId")) {
      currencyId = _json["currencyId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("inpageTagFormats")) {
      inpageTagFormats = _json["inpageTagFormats"];
    }
    if (_json.containsKey("interstitialTagFormats")) {
      interstitialTagFormats = _json["interstitialTagFormats"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentId")) {
      parentId = _json["parentId"];
    }
    if (_json.containsKey("settings")) {
      settings = new DirectorySiteSettings.fromJson(_json["settings"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (contactAssignments != null) {
      _json["contactAssignments"] = contactAssignments.map((value) => (value).toJson()).toList();
    }
    if (countryId != null) {
      _json["countryId"] = countryId;
    }
    if (currencyId != null) {
      _json["currencyId"] = currencyId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (inpageTagFormats != null) {
      _json["inpageTagFormats"] = inpageTagFormats;
    }
    if (interstitialTagFormats != null) {
      _json["interstitialTagFormats"] = interstitialTagFormats;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentId != null) {
      _json["parentId"] = parentId;
    }
    if (settings != null) {
      _json["settings"] = (settings).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Contains properties of a Site Directory contact. */
class DirectorySiteContact {
  /** Address of this directory site contact. */
  core.String address;
  /** Email address of this directory site contact. */
  core.String email;
  /** First name of this directory site contact. */
  core.String firstName;
  /**
   * ID of this directory site contact. This is a read-only, auto-generated
   * field.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#directorySiteContact".
   */
  core.String kind;
  /** Last name of this directory site contact. */
  core.String lastName;
  /** Phone number of this directory site contact. */
  core.String phone;
  /**
   * Directory site contact role.
   * Possible string values are:
   * - "ADMIN"
   * - "EDIT"
   * - "VIEW"
   */
  core.String role;
  /** Title or designation of this directory site contact. */
  core.String title;
  /**
   * Directory site contact type.
   * Possible string values are:
   * - "BILLING"
   * - "OTHER"
   * - "SALES"
   * - "TECHNICAL"
   */
  core.String type;

  DirectorySiteContact();

  DirectorySiteContact.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("firstName")) {
      firstName = _json["firstName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastName")) {
      lastName = _json["lastName"];
    }
    if (_json.containsKey("phone")) {
      phone = _json["phone"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (firstName != null) {
      _json["firstName"] = firstName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastName != null) {
      _json["lastName"] = lastName;
    }
    if (phone != null) {
      _json["phone"] = phone;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Directory Site Contact Assignment */
class DirectorySiteContactAssignment {
  /**
   * ID of this directory site contact. This is a read-only, auto-generated
   * field.
   */
  core.String contactId;
  /**
   * Visibility of this directory site contact assignment. When set to PUBLIC
   * this contact assignment is visible to all account and agency users; when
   * set to PRIVATE it is visible only to the site.
   * Possible string values are:
   * - "PRIVATE"
   * - "PUBLIC"
   */
  core.String visibility;

  DirectorySiteContactAssignment();

  DirectorySiteContactAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("contactId")) {
      contactId = _json["contactId"];
    }
    if (_json.containsKey("visibility")) {
      visibility = _json["visibility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contactId != null) {
      _json["contactId"] = contactId;
    }
    if (visibility != null) {
      _json["visibility"] = visibility;
    }
    return _json;
  }
}

/** Directory Site Contact List Response */
class DirectorySiteContactsListResponse {
  /** Directory site contact collection */
  core.List<DirectorySiteContact> directorySiteContacts;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#directorySiteContactsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  DirectorySiteContactsListResponse();

  DirectorySiteContactsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("directorySiteContacts")) {
      directorySiteContacts = _json["directorySiteContacts"].map((value) => new DirectorySiteContact.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (directorySiteContacts != null) {
      _json["directorySiteContacts"] = directorySiteContacts.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Directory Site Settings */
class DirectorySiteSettings {
  /** Whether this directory site has disabled active view creatives. */
  core.bool activeViewOptOut;
  /** Directory site DFP settings. */
  DfpSettings dfpSettings;
  /** Whether this site accepts in-stream video ads. */
  core.bool instreamVideoPlacementAccepted;
  /** Whether this site accepts interstitial ads. */
  core.bool interstitialPlacementAccepted;
  /** Whether this directory site has disabled Nielsen OCR reach ratings. */
  core.bool nielsenOcrOptOut;
  /**
   * Whether this directory site has disabled generation of Verification ins
   * tags.
   */
  core.bool verificationTagOptOut;
  /**
   * Whether this directory site has disabled active view for in-stream video
   * creatives.
   */
  core.bool videoActiveViewOptOut;

  DirectorySiteSettings();

  DirectorySiteSettings.fromJson(core.Map _json) {
    if (_json.containsKey("activeViewOptOut")) {
      activeViewOptOut = _json["activeViewOptOut"];
    }
    if (_json.containsKey("dfp_settings")) {
      dfpSettings = new DfpSettings.fromJson(_json["dfp_settings"]);
    }
    if (_json.containsKey("instream_video_placement_accepted")) {
      instreamVideoPlacementAccepted = _json["instream_video_placement_accepted"];
    }
    if (_json.containsKey("interstitialPlacementAccepted")) {
      interstitialPlacementAccepted = _json["interstitialPlacementAccepted"];
    }
    if (_json.containsKey("nielsenOcrOptOut")) {
      nielsenOcrOptOut = _json["nielsenOcrOptOut"];
    }
    if (_json.containsKey("verificationTagOptOut")) {
      verificationTagOptOut = _json["verificationTagOptOut"];
    }
    if (_json.containsKey("videoActiveViewOptOut")) {
      videoActiveViewOptOut = _json["videoActiveViewOptOut"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activeViewOptOut != null) {
      _json["activeViewOptOut"] = activeViewOptOut;
    }
    if (dfpSettings != null) {
      _json["dfp_settings"] = (dfpSettings).toJson();
    }
    if (instreamVideoPlacementAccepted != null) {
      _json["instream_video_placement_accepted"] = instreamVideoPlacementAccepted;
    }
    if (interstitialPlacementAccepted != null) {
      _json["interstitialPlacementAccepted"] = interstitialPlacementAccepted;
    }
    if (nielsenOcrOptOut != null) {
      _json["nielsenOcrOptOut"] = nielsenOcrOptOut;
    }
    if (verificationTagOptOut != null) {
      _json["verificationTagOptOut"] = verificationTagOptOut;
    }
    if (videoActiveViewOptOut != null) {
      _json["videoActiveViewOptOut"] = videoActiveViewOptOut;
    }
    return _json;
  }
}

/** Directory Site List Response */
class DirectorySitesListResponse {
  /** Directory site collection. */
  core.List<DirectorySite> directorySites;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#directorySitesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  DirectorySitesListResponse();

  DirectorySitesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("directorySites")) {
      directorySites = _json["directorySites"].map((value) => new DirectorySite.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (directorySites != null) {
      _json["directorySites"] = directorySites.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * Contains properties of a dynamic targeting key. Dynamic targeting keys are
 * unique, user-friendly labels, created at the advertiser level in DCM, that
 * can be assigned to ads, creatives, and placements and used for targeting with
 * DoubleClick Studio dynamic creatives. Use these labels instead of numeric DCM
 * IDs (such as placement IDs) to save time and avoid errors in your dynamic
 * feeds.
 */
class DynamicTargetingKey {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#dynamicTargetingKey".
   */
  core.String kind;
  /**
   * Name of this dynamic targeting key. This is a required field. Must be less
   * than 256 characters long and cannot contain commas. All characters are
   * converted to lowercase.
   */
  core.String name;
  /**
   * ID of the object of this dynamic targeting key. This is a required field.
   */
  core.String objectId;
  /**
   * Type of the object of this dynamic targeting key. This is a required field.
   * Possible string values are:
   * - "OBJECT_AD"
   * - "OBJECT_ADVERTISER"
   * - "OBJECT_CREATIVE"
   * - "OBJECT_PLACEMENT"
   */
  core.String objectType;

  DynamicTargetingKey();

  DynamicTargetingKey.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("objectId")) {
      objectId = _json["objectId"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (objectId != null) {
      _json["objectId"] = objectId;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    return _json;
  }
}

/** Dynamic Targeting Key List Response */
class DynamicTargetingKeysListResponse {
  /** Dynamic targeting key collection. */
  core.List<DynamicTargetingKey> dynamicTargetingKeys;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#dynamicTargetingKeysListResponse".
   */
  core.String kind;

  DynamicTargetingKeysListResponse();

  DynamicTargetingKeysListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("dynamicTargetingKeys")) {
      dynamicTargetingKeys = _json["dynamicTargetingKeys"].map((value) => new DynamicTargetingKey.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dynamicTargetingKeys != null) {
      _json["dynamicTargetingKeys"] = dynamicTargetingKeys.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** A description of how user IDs are encrypted. */
class EncryptionInfo {
  /**
   * The encryption entity ID. This should match the encryption configuration
   * for ad serving or Data Transfer.
   */
  core.String encryptionEntityId;
  /**
   * The encryption entity type. This should match the encryption configuration
   * for ad serving or Data Transfer.
   * Possible string values are:
   * - "ADWORDS_CUSTOMER"
   * - "DBM_ADVERTISER"
   * - "DBM_PARTNER"
   * - "DCM_ACCOUNT"
   * - "DCM_ADVERTISER"
   * - "ENCRYPTION_ENTITY_TYPE_UNKNOWN"
   */
  core.String encryptionEntityType;
  /**
   * Describes whether the encrypted cookie was received from ad serving (the %m
   * macro) or from Data Transfer.
   * Possible string values are:
   * - "AD_SERVING"
   * - "DATA_TRANSFER"
   * - "ENCRYPTION_SCOPE_UNKNOWN"
   */
  core.String encryptionSource;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#encryptionInfo".
   */
  core.String kind;

  EncryptionInfo();

  EncryptionInfo.fromJson(core.Map _json) {
    if (_json.containsKey("encryptionEntityId")) {
      encryptionEntityId = _json["encryptionEntityId"];
    }
    if (_json.containsKey("encryptionEntityType")) {
      encryptionEntityType = _json["encryptionEntityType"];
    }
    if (_json.containsKey("encryptionSource")) {
      encryptionSource = _json["encryptionSource"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (encryptionEntityId != null) {
      _json["encryptionEntityId"] = encryptionEntityId;
    }
    if (encryptionEntityType != null) {
      _json["encryptionEntityType"] = encryptionEntityType;
    }
    if (encryptionSource != null) {
      _json["encryptionSource"] = encryptionSource;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains properties of an event tag. */
class EventTag {
  /**
   * Account ID of this event tag. This is a read-only field that can be left
   * blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this event tag. This field or the campaignId field is
   * required on insertion.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /**
   * Campaign ID of this event tag. This field or the advertiserId field is
   * required on insertion.
   */
  core.String campaignId;
  /**
   * Dimension value for the ID of the campaign. This is a read-only,
   * auto-generated field.
   */
  DimensionValue campaignIdDimensionValue;
  /**
   * Whether this event tag should be automatically enabled for all of the
   * advertiser's campaigns and ads.
   */
  core.bool enabledByDefault;
  /**
   * Whether to remove this event tag from ads that are trafficked through
   * DoubleClick Bid Manager to Ad Exchange. This may be useful if the event tag
   * uses a pixel that is unapproved for Ad Exchange bids on one or more
   * networks, such as the Google Display Network.
   */
  core.bool excludeFromAdxRequests;
  /** ID of this event tag. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#eventTag".
   */
  core.String kind;
  /**
   * Name of this event tag. This is a required field and must be less than 256
   * characters long.
   */
  core.String name;
  /**
   * Site filter type for this event tag. If no type is specified then the event
   * tag will be applied to all sites.
   * Possible string values are:
   * - "BLACKLIST"
   * - "WHITELIST"
   */
  core.String siteFilterType;
  /**
   * Filter list of site IDs associated with this event tag. The siteFilterType
   * determines whether this is a whitelist or blacklist filter.
   */
  core.List<core.String> siteIds;
  /** Whether this tag is SSL-compliant or not. This is a read-only field. */
  core.bool sslCompliant;
  /**
   * Status of this event tag. Must be ENABLED for this event tag to fire. This
   * is a required field.
   * Possible string values are:
   * - "DISABLED"
   * - "ENABLED"
   */
  core.String status;
  /**
   * Subaccount ID of this event tag. This is a read-only field that can be left
   * blank.
   */
  core.String subaccountId;
  /**
   * Event tag type. Can be used to specify whether to use a third-party pixel,
   * a third-party JavaScript URL, or a third-party click-through URL for either
   * impression or click tracking. This is a required field.
   * Possible string values are:
   * - "CLICK_THROUGH_EVENT_TAG"
   * - "IMPRESSION_IMAGE_EVENT_TAG"
   * - "IMPRESSION_JAVASCRIPT_EVENT_TAG"
   */
  core.String type;
  /**
   * Payload URL for this event tag. The URL on a click-through event tag should
   * have a landing page URL appended to the end of it. This field is required
   * on insertion.
   */
  core.String url;
  /**
   * Number of times the landing page URL should be URL-escaped before being
   * appended to the click-through event tag URL. Only applies to click-through
   * event tags as specified by the event tag type.
   */
  core.int urlEscapeLevels;

  EventTag();

  EventTag.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("campaignIdDimensionValue")) {
      campaignIdDimensionValue = new DimensionValue.fromJson(_json["campaignIdDimensionValue"]);
    }
    if (_json.containsKey("enabledByDefault")) {
      enabledByDefault = _json["enabledByDefault"];
    }
    if (_json.containsKey("excludeFromAdxRequests")) {
      excludeFromAdxRequests = _json["excludeFromAdxRequests"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("siteFilterType")) {
      siteFilterType = _json["siteFilterType"];
    }
    if (_json.containsKey("siteIds")) {
      siteIds = _json["siteIds"];
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("urlEscapeLevels")) {
      urlEscapeLevels = _json["urlEscapeLevels"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (campaignIdDimensionValue != null) {
      _json["campaignIdDimensionValue"] = (campaignIdDimensionValue).toJson();
    }
    if (enabledByDefault != null) {
      _json["enabledByDefault"] = enabledByDefault;
    }
    if (excludeFromAdxRequests != null) {
      _json["excludeFromAdxRequests"] = excludeFromAdxRequests;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (siteFilterType != null) {
      _json["siteFilterType"] = siteFilterType;
    }
    if (siteIds != null) {
      _json["siteIds"] = siteIds;
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (urlEscapeLevels != null) {
      _json["urlEscapeLevels"] = urlEscapeLevels;
    }
    return _json;
  }
}

/** Event tag override information. */
class EventTagOverride {
  /** Whether this override is enabled. */
  core.bool enabled;
  /**
   * ID of this event tag override. This is a read-only, auto-generated field.
   */
  core.String id;

  EventTagOverride();

  EventTagOverride.fromJson(core.Map _json) {
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

/** Event Tag List Response */
class EventTagsListResponse {
  /** Event tag collection. */
  core.List<EventTag> eventTags;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#eventTagsListResponse".
   */
  core.String kind;

  EventTagsListResponse();

  EventTagsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("eventTags")) {
      eventTags = _json["eventTags"].map((value) => new EventTag.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (eventTags != null) {
      _json["eventTags"] = eventTags.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** The URLs where the completed report file can be downloaded. */
class FileUrls {
  /** The URL for downloading the report data through the API. */
  core.String apiUrl;
  /** The URL for downloading the report data through a browser. */
  core.String browserUrl;

  FileUrls();

  FileUrls.fromJson(core.Map _json) {
    if (_json.containsKey("apiUrl")) {
      apiUrl = _json["apiUrl"];
    }
    if (_json.containsKey("browserUrl")) {
      browserUrl = _json["browserUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (apiUrl != null) {
      _json["apiUrl"] = apiUrl;
    }
    if (browserUrl != null) {
      _json["browserUrl"] = browserUrl;
    }
    return _json;
  }
}

/**
 * Represents a File resource. A file contains the metadata for a report run. It
 * shows the status of the run and holds the URLs to the generated report data
 * if the run is finished and the status is "REPORT_AVAILABLE".
 */
class File {
  /**
   * The date range for which the file has report data. The date range will
   * always be the absolute date range for which the report is run.
   */
  DateRange dateRange;
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The filename of the file. */
  core.String fileName;
  /**
   * The output format of the report. Only available once the file is available.
   * Possible string values are:
   * - "CSV"
   * - "EXCEL"
   */
  core.String format;
  /** The unique ID of this report file. */
  core.String id;
  /** The kind of resource this is, in this case dfareporting#file. */
  core.String kind;
  /**
   * The timestamp in milliseconds since epoch when this file was last modified.
   */
  core.String lastModifiedTime;
  /** The ID of the report this file was generated from. */
  core.String reportId;
  /**
   * The status of the report file.
   * Possible string values are:
   * - "CANCELLED"
   * - "FAILED"
   * - "PROCESSING"
   * - "REPORT_AVAILABLE"
   */
  core.String status;
  /** The URLs where the completed report file can be downloaded. */
  FileUrls urls;

  File();

  File.fromJson(core.Map _json) {
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedTime")) {
      lastModifiedTime = _json["lastModifiedTime"];
    }
    if (_json.containsKey("reportId")) {
      reportId = _json["reportId"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("urls")) {
      urls = new FileUrls.fromJson(_json["urls"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedTime != null) {
      _json["lastModifiedTime"] = lastModifiedTime;
    }
    if (reportId != null) {
      _json["reportId"] = reportId;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (urls != null) {
      _json["urls"] = (urls).toJson();
    }
    return _json;
  }
}

/** Represents the list of File resources. */
class FileList {
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The files returned in this response. */
  core.List<File> items;
  /** The kind of list this is, in this case dfareporting#fileList. */
  core.String kind;
  /**
   * Continuation token used to page through files. To retrieve the next page of
   * results, set the next request's "pageToken" to the value of this field. The
   * page token is only valid for a limited amount of time and should not be
   * persisted.
   */
  core.String nextPageToken;

  FileList();

  FileList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new File.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Flight */
class Flight {
  /** Inventory item flight end date. */
  core.DateTime endDate;
  /** Rate or cost of this flight. */
  core.String rateOrCost;
  /** Inventory item flight start date. */
  core.DateTime startDate;
  /** Units of this flight. */
  core.String units;

  Flight();

  Flight.fromJson(core.Map _json) {
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("rateOrCost")) {
      rateOrCost = _json["rateOrCost"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("units")) {
      units = _json["units"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (rateOrCost != null) {
      _json["rateOrCost"] = rateOrCost;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    if (units != null) {
      _json["units"] = units;
    }
    return _json;
  }
}

/** Floodlight Activity GenerateTag Response */
class FloodlightActivitiesGenerateTagResponse {
  /** Generated tag for this floodlight activity. */
  core.String floodlightActivityTag;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightActivitiesGenerateTagResponse".
   */
  core.String kind;

  FloodlightActivitiesGenerateTagResponse();

  FloodlightActivitiesGenerateTagResponse.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightActivityTag")) {
      floodlightActivityTag = _json["floodlightActivityTag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightActivityTag != null) {
      _json["floodlightActivityTag"] = floodlightActivityTag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Floodlight Activity List Response */
class FloodlightActivitiesListResponse {
  /** Floodlight activity collection. */
  core.List<FloodlightActivity> floodlightActivities;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightActivitiesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  FloodlightActivitiesListResponse();

  FloodlightActivitiesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightActivities")) {
      floodlightActivities = _json["floodlightActivities"].map((value) => new FloodlightActivity.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightActivities != null) {
      _json["floodlightActivities"] = floodlightActivities.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Contains properties of a Floodlight activity. */
class FloodlightActivity {
  /**
   * Account ID of this floodlight activity. This is a read-only field that can
   * be left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this floodlight activity. If this field is left blank, the
   * value will be copied over either from the activity group's advertiser or
   * the existing activity's advertiser.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /**
   * Code type used for cache busting in the generated tag.
   * Possible string values are:
   * - "ACTIVE_SERVER_PAGE"
   * - "COLD_FUSION"
   * - "JAVASCRIPT"
   * - "JSP"
   * - "PHP"
   */
  core.String cacheBustingType;
  /**
   * Counting method for conversions for this floodlight activity. This is a
   * required field.
   * Possible string values are:
   * - "ITEMS_SOLD_COUNTING"
   * - "SESSION_COUNTING"
   * - "STANDARD_COUNTING"
   * - "TRANSACTIONS_COUNTING"
   * - "UNIQUE_COUNTING"
   */
  core.String countingMethod;
  /** Dynamic floodlight tags. */
  core.List<FloodlightActivityDynamicTag> defaultTags;
  /**
   * URL where this tag will be deployed. If specified, must be less than 256
   * characters long.
   */
  core.String expectedUrl;
  /**
   * Floodlight activity group ID of this floodlight activity. This is a
   * required field.
   */
  core.String floodlightActivityGroupId;
  /**
   * Name of the associated floodlight activity group. This is a read-only
   * field.
   */
  core.String floodlightActivityGroupName;
  /**
   * Tag string of the associated floodlight activity group. This is a read-only
   * field.
   */
  core.String floodlightActivityGroupTagString;
  /**
   * Type of the associated floodlight activity group. This is a read-only
   * field.
   * Possible string values are:
   * - "COUNTER"
   * - "SALE"
   */
  core.String floodlightActivityGroupType;
  /**
   * Floodlight configuration ID of this floodlight activity. If this field is
   * left blank, the value will be copied over either from the activity group's
   * floodlight configuration or from the existing activity's floodlight
   * configuration.
   */
  core.String floodlightConfigurationId;
  /**
   * Dimension value for the ID of the floodlight configuration. This is a
   * read-only, auto-generated field.
   */
  DimensionValue floodlightConfigurationIdDimensionValue;
  /** Whether this activity is archived. */
  core.bool hidden;
  /**
   * ID of this floodlight activity. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Dimension value for the ID of this floodlight activity. This is a
   * read-only, auto-generated field.
   */
  DimensionValue idDimensionValue;
  /** Whether the image tag is enabled for this activity. */
  core.bool imageTagEnabled;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightActivity".
   */
  core.String kind;
  /**
   * Name of this floodlight activity. This is a required field. Must be less
   * than 129 characters long and cannot contain quotes.
   */
  core.String name;
  /** General notes or implementation instructions for the tag. */
  core.String notes;
  /** Publisher dynamic floodlight tags. */
  core.List<FloodlightActivityPublisherDynamicTag> publisherTags;
  /** Whether this tag should use SSL. */
  core.bool secure;
  /**
   * Whether the floodlight activity is SSL-compliant. This is a read-only
   * field, its value detected by the system from the floodlight tags.
   */
  core.bool sslCompliant;
  /** Whether this floodlight activity must be SSL-compliant. */
  core.bool sslRequired;
  /**
   * Subaccount ID of this floodlight activity. This is a read-only field that
   * can be left blank.
   */
  core.String subaccountId;
  /**
   * Tag format type for the floodlight activity. If left blank, the tag format
   * will default to HTML.
   * Possible string values are:
   * - "HTML"
   * - "XHTML"
   */
  core.String tagFormat;
  /**
   * Value of the cat= paramter in the floodlight tag, which the ad servers use
   * to identify the activity. This is optional: if empty, a new tag string will
   * be generated for you. This string must be 1 to 8 characters long, with
   * valid characters being [a-z][A-Z][0-9][-][ _ ]. This tag string must also
   * be unique among activities of the same activity group. This field is
   * read-only after insertion.
   */
  core.String tagString;
  /**
   * List of the user-defined variables used by this conversion tag. These map
   * to the "u[1-20]=" in the tags. Each of these can have a user defined type.
   * Acceptable values are:
   * - "U1"
   * - "U2"
   * - "U3"
   * - "U4"
   * - "U5"
   * - "U6"
   * - "U7"
   * - "U8"
   * - "U9"
   * - "U10"
   * - "U11"
   * - "U12"
   * - "U13"
   * - "U14"
   * - "U15"
   * - "U16"
   * - "U17"
   * - "U18"
   * - "U19"
   * - "U20"
   */
  core.List<core.String> userDefinedVariableTypes;

  FloodlightActivity();

  FloodlightActivity.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("cacheBustingType")) {
      cacheBustingType = _json["cacheBustingType"];
    }
    if (_json.containsKey("countingMethod")) {
      countingMethod = _json["countingMethod"];
    }
    if (_json.containsKey("defaultTags")) {
      defaultTags = _json["defaultTags"].map((value) => new FloodlightActivityDynamicTag.fromJson(value)).toList();
    }
    if (_json.containsKey("expectedUrl")) {
      expectedUrl = _json["expectedUrl"];
    }
    if (_json.containsKey("floodlightActivityGroupId")) {
      floodlightActivityGroupId = _json["floodlightActivityGroupId"];
    }
    if (_json.containsKey("floodlightActivityGroupName")) {
      floodlightActivityGroupName = _json["floodlightActivityGroupName"];
    }
    if (_json.containsKey("floodlightActivityGroupTagString")) {
      floodlightActivityGroupTagString = _json["floodlightActivityGroupTagString"];
    }
    if (_json.containsKey("floodlightActivityGroupType")) {
      floodlightActivityGroupType = _json["floodlightActivityGroupType"];
    }
    if (_json.containsKey("floodlightConfigurationId")) {
      floodlightConfigurationId = _json["floodlightConfigurationId"];
    }
    if (_json.containsKey("floodlightConfigurationIdDimensionValue")) {
      floodlightConfigurationIdDimensionValue = new DimensionValue.fromJson(_json["floodlightConfigurationIdDimensionValue"]);
    }
    if (_json.containsKey("hidden")) {
      hidden = _json["hidden"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("imageTagEnabled")) {
      imageTagEnabled = _json["imageTagEnabled"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("notes")) {
      notes = _json["notes"];
    }
    if (_json.containsKey("publisherTags")) {
      publisherTags = _json["publisherTags"].map((value) => new FloodlightActivityPublisherDynamicTag.fromJson(value)).toList();
    }
    if (_json.containsKey("secure")) {
      secure = _json["secure"];
    }
    if (_json.containsKey("sslCompliant")) {
      sslCompliant = _json["sslCompliant"];
    }
    if (_json.containsKey("sslRequired")) {
      sslRequired = _json["sslRequired"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("tagFormat")) {
      tagFormat = _json["tagFormat"];
    }
    if (_json.containsKey("tagString")) {
      tagString = _json["tagString"];
    }
    if (_json.containsKey("userDefinedVariableTypes")) {
      userDefinedVariableTypes = _json["userDefinedVariableTypes"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (cacheBustingType != null) {
      _json["cacheBustingType"] = cacheBustingType;
    }
    if (countingMethod != null) {
      _json["countingMethod"] = countingMethod;
    }
    if (defaultTags != null) {
      _json["defaultTags"] = defaultTags.map((value) => (value).toJson()).toList();
    }
    if (expectedUrl != null) {
      _json["expectedUrl"] = expectedUrl;
    }
    if (floodlightActivityGroupId != null) {
      _json["floodlightActivityGroupId"] = floodlightActivityGroupId;
    }
    if (floodlightActivityGroupName != null) {
      _json["floodlightActivityGroupName"] = floodlightActivityGroupName;
    }
    if (floodlightActivityGroupTagString != null) {
      _json["floodlightActivityGroupTagString"] = floodlightActivityGroupTagString;
    }
    if (floodlightActivityGroupType != null) {
      _json["floodlightActivityGroupType"] = floodlightActivityGroupType;
    }
    if (floodlightConfigurationId != null) {
      _json["floodlightConfigurationId"] = floodlightConfigurationId;
    }
    if (floodlightConfigurationIdDimensionValue != null) {
      _json["floodlightConfigurationIdDimensionValue"] = (floodlightConfigurationIdDimensionValue).toJson();
    }
    if (hidden != null) {
      _json["hidden"] = hidden;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (imageTagEnabled != null) {
      _json["imageTagEnabled"] = imageTagEnabled;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (notes != null) {
      _json["notes"] = notes;
    }
    if (publisherTags != null) {
      _json["publisherTags"] = publisherTags.map((value) => (value).toJson()).toList();
    }
    if (secure != null) {
      _json["secure"] = secure;
    }
    if (sslCompliant != null) {
      _json["sslCompliant"] = sslCompliant;
    }
    if (sslRequired != null) {
      _json["sslRequired"] = sslRequired;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (tagFormat != null) {
      _json["tagFormat"] = tagFormat;
    }
    if (tagString != null) {
      _json["tagString"] = tagString;
    }
    if (userDefinedVariableTypes != null) {
      _json["userDefinedVariableTypes"] = userDefinedVariableTypes;
    }
    return _json;
  }
}

/** Dynamic Tag */
class FloodlightActivityDynamicTag {
  /** ID of this dynamic tag. This is a read-only, auto-generated field. */
  core.String id;
  /** Name of this tag. */
  core.String name;
  /** Tag code. */
  core.String tag;

  FloodlightActivityDynamicTag();

  FloodlightActivityDynamicTag.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/** Contains properties of a Floodlight activity group. */
class FloodlightActivityGroup {
  /**
   * Account ID of this floodlight activity group. This is a read-only field
   * that can be left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this floodlight activity group. If this field is left
   * blank, the value will be copied over either from the floodlight
   * configuration's advertiser or from the existing activity group's
   * advertiser.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /**
   * Floodlight configuration ID of this floodlight activity group. This is a
   * required field.
   */
  core.String floodlightConfigurationId;
  /**
   * Dimension value for the ID of the floodlight configuration. This is a
   * read-only, auto-generated field.
   */
  DimensionValue floodlightConfigurationIdDimensionValue;
  /**
   * ID of this floodlight activity group. This is a read-only, auto-generated
   * field.
   */
  core.String id;
  /**
   * Dimension value for the ID of this floodlight activity group. This is a
   * read-only, auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightActivityGroup".
   */
  core.String kind;
  /**
   * Name of this floodlight activity group. This is a required field. Must be
   * less than 65 characters long and cannot contain quotes.
   */
  core.String name;
  /**
   * Subaccount ID of this floodlight activity group. This is a read-only field
   * that can be left blank.
   */
  core.String subaccountId;
  /**
   * Value of the type= parameter in the floodlight tag, which the ad servers
   * use to identify the activity group that the activity belongs to. This is
   * optional: if empty, a new tag string will be generated for you. This string
   * must be 1 to 8 characters long, with valid characters being
   * [a-z][A-Z][0-9][-][ _ ]. This tag string must also be unique among activity
   * groups of the same floodlight configuration. This field is read-only after
   * insertion.
   */
  core.String tagString;
  /**
   * Type of the floodlight activity group. This is a required field that is
   * read-only after insertion.
   * Possible string values are:
   * - "COUNTER"
   * - "SALE"
   */
  core.String type;

  FloodlightActivityGroup();

  FloodlightActivityGroup.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("floodlightConfigurationId")) {
      floodlightConfigurationId = _json["floodlightConfigurationId"];
    }
    if (_json.containsKey("floodlightConfigurationIdDimensionValue")) {
      floodlightConfigurationIdDimensionValue = new DimensionValue.fromJson(_json["floodlightConfigurationIdDimensionValue"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("tagString")) {
      tagString = _json["tagString"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (floodlightConfigurationId != null) {
      _json["floodlightConfigurationId"] = floodlightConfigurationId;
    }
    if (floodlightConfigurationIdDimensionValue != null) {
      _json["floodlightConfigurationIdDimensionValue"] = (floodlightConfigurationIdDimensionValue).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (tagString != null) {
      _json["tagString"] = tagString;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Floodlight Activity Group List Response */
class FloodlightActivityGroupsListResponse {
  /** Floodlight activity group collection. */
  core.List<FloodlightActivityGroup> floodlightActivityGroups;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightActivityGroupsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  FloodlightActivityGroupsListResponse();

  FloodlightActivityGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightActivityGroups")) {
      floodlightActivityGroups = _json["floodlightActivityGroups"].map((value) => new FloodlightActivityGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightActivityGroups != null) {
      _json["floodlightActivityGroups"] = floodlightActivityGroups.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Publisher Dynamic Tag */
class FloodlightActivityPublisherDynamicTag {
  /** Whether this tag is applicable only for click-throughs. */
  core.bool clickThrough;
  /**
   * Directory site ID of this dynamic tag. This is a write-only field that can
   * be used as an alternative to the siteId field. When this resource is
   * retrieved, only the siteId field will be populated.
   */
  core.String directorySiteId;
  /** Dynamic floodlight tag. */
  FloodlightActivityDynamicTag dynamicTag;
  /** Site ID of this dynamic tag. */
  core.String siteId;
  /**
   * Dimension value for the ID of the site. This is a read-only, auto-generated
   * field.
   */
  DimensionValue siteIdDimensionValue;
  /** Whether this tag is applicable only for view-throughs. */
  core.bool viewThrough;

  FloodlightActivityPublisherDynamicTag();

  FloodlightActivityPublisherDynamicTag.fromJson(core.Map _json) {
    if (_json.containsKey("clickThrough")) {
      clickThrough = _json["clickThrough"];
    }
    if (_json.containsKey("directorySiteId")) {
      directorySiteId = _json["directorySiteId"];
    }
    if (_json.containsKey("dynamicTag")) {
      dynamicTag = new FloodlightActivityDynamicTag.fromJson(_json["dynamicTag"]);
    }
    if (_json.containsKey("siteId")) {
      siteId = _json["siteId"];
    }
    if (_json.containsKey("siteIdDimensionValue")) {
      siteIdDimensionValue = new DimensionValue.fromJson(_json["siteIdDimensionValue"]);
    }
    if (_json.containsKey("viewThrough")) {
      viewThrough = _json["viewThrough"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clickThrough != null) {
      _json["clickThrough"] = clickThrough;
    }
    if (directorySiteId != null) {
      _json["directorySiteId"] = directorySiteId;
    }
    if (dynamicTag != null) {
      _json["dynamicTag"] = (dynamicTag).toJson();
    }
    if (siteId != null) {
      _json["siteId"] = siteId;
    }
    if (siteIdDimensionValue != null) {
      _json["siteIdDimensionValue"] = (siteIdDimensionValue).toJson();
    }
    if (viewThrough != null) {
      _json["viewThrough"] = viewThrough;
    }
    return _json;
  }
}

/** Contains properties of a Floodlight configuration. */
class FloodlightConfiguration {
  /**
   * Account ID of this floodlight configuration. This is a read-only field that
   * can be left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of the parent advertiser of this floodlight configuration.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Whether advertiser data is shared with Google Analytics. */
  core.bool analyticsDataSharingEnabled;
  /**
   * Whether the exposure-to-conversion report is enabled. This report shows
   * detailed pathway information on up to 10 of the most recent ad exposures
   * seen by a user before converting.
   */
  core.bool exposureToConversionEnabled;
  /**
   * Day that will be counted as the first day of the week in reports. This is a
   * required field.
   * Possible string values are:
   * - "MONDAY"
   * - "SUNDAY"
   */
  core.String firstDayOfWeek;
  /**
   * ID of this floodlight configuration. This is a read-only, auto-generated
   * field.
   */
  core.String id;
  /**
   * Dimension value for the ID of this floodlight configuration. This is a
   * read-only, auto-generated field.
   */
  DimensionValue idDimensionValue;
  /** Whether in-app attribution tracking is enabled. */
  core.bool inAppAttributionTrackingEnabled;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightConfiguration".
   */
  core.String kind;
  /** Lookback window settings for this floodlight configuration. */
  LookbackConfiguration lookbackConfiguration;
  /**
   * Types of attribution options for natural search conversions.
   * Possible string values are:
   * - "EXCLUDE_NATURAL_SEARCH_CONVERSION_ATTRIBUTION"
   * - "INCLUDE_NATURAL_SEARCH_CONVERSION_ATTRIBUTION"
   * - "INCLUDE_NATURAL_SEARCH_TIERED_CONVERSION_ATTRIBUTION"
   */
  core.String naturalSearchConversionAttributionOption;
  /** Settings for DCM Omniture integration. */
  OmnitureSettings omnitureSettings;
  /**
   * List of standard variables enabled for this configuration.
   *
   * Acceptable values are:
   * - "ORD"
   * - "NUM"
   */
  core.List<core.String> standardVariableTypes;
  /**
   * Subaccount ID of this floodlight configuration. This is a read-only field
   * that can be left blank.
   */
  core.String subaccountId;
  /** Configuration settings for dynamic and image floodlight tags. */
  TagSettings tagSettings;
  /**
   * List of third-party authentication tokens enabled for this configuration.
   */
  core.List<ThirdPartyAuthenticationToken> thirdPartyAuthenticationTokens;
  /** List of user defined variables enabled for this configuration. */
  core.List<UserDefinedVariableConfiguration> userDefinedVariableConfigurations;

  FloodlightConfiguration();

  FloodlightConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("analyticsDataSharingEnabled")) {
      analyticsDataSharingEnabled = _json["analyticsDataSharingEnabled"];
    }
    if (_json.containsKey("exposureToConversionEnabled")) {
      exposureToConversionEnabled = _json["exposureToConversionEnabled"];
    }
    if (_json.containsKey("firstDayOfWeek")) {
      firstDayOfWeek = _json["firstDayOfWeek"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("inAppAttributionTrackingEnabled")) {
      inAppAttributionTrackingEnabled = _json["inAppAttributionTrackingEnabled"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lookbackConfiguration")) {
      lookbackConfiguration = new LookbackConfiguration.fromJson(_json["lookbackConfiguration"]);
    }
    if (_json.containsKey("naturalSearchConversionAttributionOption")) {
      naturalSearchConversionAttributionOption = _json["naturalSearchConversionAttributionOption"];
    }
    if (_json.containsKey("omnitureSettings")) {
      omnitureSettings = new OmnitureSettings.fromJson(_json["omnitureSettings"]);
    }
    if (_json.containsKey("standardVariableTypes")) {
      standardVariableTypes = _json["standardVariableTypes"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("tagSettings")) {
      tagSettings = new TagSettings.fromJson(_json["tagSettings"]);
    }
    if (_json.containsKey("thirdPartyAuthenticationTokens")) {
      thirdPartyAuthenticationTokens = _json["thirdPartyAuthenticationTokens"].map((value) => new ThirdPartyAuthenticationToken.fromJson(value)).toList();
    }
    if (_json.containsKey("userDefinedVariableConfigurations")) {
      userDefinedVariableConfigurations = _json["userDefinedVariableConfigurations"].map((value) => new UserDefinedVariableConfiguration.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (analyticsDataSharingEnabled != null) {
      _json["analyticsDataSharingEnabled"] = analyticsDataSharingEnabled;
    }
    if (exposureToConversionEnabled != null) {
      _json["exposureToConversionEnabled"] = exposureToConversionEnabled;
    }
    if (firstDayOfWeek != null) {
      _json["firstDayOfWeek"] = firstDayOfWeek;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (inAppAttributionTrackingEnabled != null) {
      _json["inAppAttributionTrackingEnabled"] = inAppAttributionTrackingEnabled;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lookbackConfiguration != null) {
      _json["lookbackConfiguration"] = (lookbackConfiguration).toJson();
    }
    if (naturalSearchConversionAttributionOption != null) {
      _json["naturalSearchConversionAttributionOption"] = naturalSearchConversionAttributionOption;
    }
    if (omnitureSettings != null) {
      _json["omnitureSettings"] = (omnitureSettings).toJson();
    }
    if (standardVariableTypes != null) {
      _json["standardVariableTypes"] = standardVariableTypes;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (tagSettings != null) {
      _json["tagSettings"] = (tagSettings).toJson();
    }
    if (thirdPartyAuthenticationTokens != null) {
      _json["thirdPartyAuthenticationTokens"] = thirdPartyAuthenticationTokens.map((value) => (value).toJson()).toList();
    }
    if (userDefinedVariableConfigurations != null) {
      _json["userDefinedVariableConfigurations"] = userDefinedVariableConfigurations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Floodlight Configuration List Response */
class FloodlightConfigurationsListResponse {
  /** Floodlight configuration collection. */
  core.List<FloodlightConfiguration> floodlightConfigurations;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#floodlightConfigurationsListResponse".
   */
  core.String kind;

  FloodlightConfigurationsListResponse();

  FloodlightConfigurationsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightConfigurations")) {
      floodlightConfigurations = _json["floodlightConfigurations"].map((value) => new FloodlightConfiguration.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightConfigurations != null) {
      _json["floodlightConfigurations"] = floodlightConfigurations.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/**
 * Represents fields that are compatible to be selected for a report of type
 * "FlOODLIGHT".
 */
class FloodlightReportCompatibleFields {
  /**
   * Dimensions which are compatible to be selected in the "dimensionFilters"
   * section of the report.
   */
  core.List<Dimension> dimensionFilters;
  /**
   * Dimensions which are compatible to be selected in the "dimensions" section
   * of the report.
   */
  core.List<Dimension> dimensions;
  /**
   * The kind of resource this is, in this case
   * dfareporting#floodlightReportCompatibleFields.
   */
  core.String kind;
  /**
   * Metrics which are compatible to be selected in the "metricNames" section of
   * the report.
   */
  core.List<Metric> metrics;

  FloodlightReportCompatibleFields();

  FloodlightReportCompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Frequency Cap. */
class FrequencyCap {
  /**
   * Duration of time, in seconds, for this frequency cap. The maximum duration
   * is 90 days in seconds, or 7,776,000.
   */
  core.String duration;
  /**
   * Number of times an individual user can be served the ad within the
   * specified duration. The maximum allowed is 15.
   */
  core.String impressions;

  FrequencyCap();

  FrequencyCap.fromJson(core.Map _json) {
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("impressions")) {
      impressions = _json["impressions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (impressions != null) {
      _json["impressions"] = impressions;
    }
    return _json;
  }
}

/** FsCommand. */
class FsCommand {
  /**
   * Distance from the left of the browser.Applicable when positionOption is
   * DISTANCE_FROM_TOP_LEFT_CORNER.
   */
  core.int left;
  /**
   * Position in the browser where the window will open.
   * Possible string values are:
   * - "CENTERED"
   * - "DISTANCE_FROM_TOP_LEFT_CORNER"
   */
  core.String positionOption;
  /**
   * Distance from the top of the browser. Applicable when positionOption is
   * DISTANCE_FROM_TOP_LEFT_CORNER.
   */
  core.int top;
  /** Height of the window. */
  core.int windowHeight;
  /** Width of the window. */
  core.int windowWidth;

  FsCommand();

  FsCommand.fromJson(core.Map _json) {
    if (_json.containsKey("left")) {
      left = _json["left"];
    }
    if (_json.containsKey("positionOption")) {
      positionOption = _json["positionOption"];
    }
    if (_json.containsKey("top")) {
      top = _json["top"];
    }
    if (_json.containsKey("windowHeight")) {
      windowHeight = _json["windowHeight"];
    }
    if (_json.containsKey("windowWidth")) {
      windowWidth = _json["windowWidth"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (left != null) {
      _json["left"] = left;
    }
    if (positionOption != null) {
      _json["positionOption"] = positionOption;
    }
    if (top != null) {
      _json["top"] = top;
    }
    if (windowHeight != null) {
      _json["windowHeight"] = windowHeight;
    }
    if (windowWidth != null) {
      _json["windowWidth"] = windowWidth;
    }
    return _json;
  }
}

/** Geographical Targeting. */
class GeoTargeting {
  /**
   * Cities to be targeted. For each city only dartId is required. The other
   * fields are populated automatically when the ad is inserted or updated. If
   * targeting a city, do not target or exclude the country of the city, and do
   * not target the metro or region of the city.
   */
  core.List<City> cities;
  /**
   * Countries to be targeted or excluded from targeting, depending on the
   * setting of the excludeCountries field. For each country only dartId is
   * required. The other fields are populated automatically when the ad is
   * inserted or updated. If targeting or excluding a country, do not target
   * regions, cities, metros, or postal codes in the same country.
   */
  core.List<Country> countries;
  /**
   * Whether or not to exclude the countries in the countries field from
   * targeting. If false, the countries field refers to countries which will be
   * targeted by the ad.
   */
  core.bool excludeCountries;
  /**
   * Metros to be targeted. For each metro only dmaId is required. The other
   * fields are populated automatically when the ad is inserted or updated. If
   * targeting a metro, do not target or exclude the country of the metro.
   */
  core.List<Metro> metros;
  /**
   * Postal codes to be targeted. For each postal code only id is required. The
   * other fields are populated automatically when the ad is inserted or
   * updated. If targeting a postal code, do not target or exclude the country
   * of the postal code.
   */
  core.List<PostalCode> postalCodes;
  /**
   * Regions to be targeted. For each region only dartId is required. The other
   * fields are populated automatically when the ad is inserted or updated. If
   * targeting a region, do not target or exclude the country of the region.
   */
  core.List<Region> regions;

  GeoTargeting();

  GeoTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("cities")) {
      cities = _json["cities"].map((value) => new City.fromJson(value)).toList();
    }
    if (_json.containsKey("countries")) {
      countries = _json["countries"].map((value) => new Country.fromJson(value)).toList();
    }
    if (_json.containsKey("excludeCountries")) {
      excludeCountries = _json["excludeCountries"];
    }
    if (_json.containsKey("metros")) {
      metros = _json["metros"].map((value) => new Metro.fromJson(value)).toList();
    }
    if (_json.containsKey("postalCodes")) {
      postalCodes = _json["postalCodes"].map((value) => new PostalCode.fromJson(value)).toList();
    }
    if (_json.containsKey("regions")) {
      regions = _json["regions"].map((value) => new Region.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cities != null) {
      _json["cities"] = cities.map((value) => (value).toJson()).toList();
    }
    if (countries != null) {
      _json["countries"] = countries.map((value) => (value).toJson()).toList();
    }
    if (excludeCountries != null) {
      _json["excludeCountries"] = excludeCountries;
    }
    if (metros != null) {
      _json["metros"] = metros.map((value) => (value).toJson()).toList();
    }
    if (postalCodes != null) {
      _json["postalCodes"] = postalCodes.map((value) => (value).toJson()).toList();
    }
    if (regions != null) {
      _json["regions"] = regions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Represents a buy from the DoubleClick Planning inventory store. */
class InventoryItem {
  /** Account ID of this inventory item. */
  core.String accountId;
  /**
   * Ad slots of this inventory item. If this inventory item represents a
   * standalone placement, there will be exactly one ad slot. If this inventory
   * item represents a placement group, there will be more than one ad slot,
   * each representing one child placement in that placement group.
   */
  core.List<AdSlot> adSlots;
  /** Advertiser ID of this inventory item. */
  core.String advertiserId;
  /** Content category ID of this inventory item. */
  core.String contentCategoryId;
  /** Estimated click-through rate of this inventory item. */
  core.String estimatedClickThroughRate;
  /** Estimated conversion rate of this inventory item. */
  core.String estimatedConversionRate;
  /** ID of this inventory item. */
  core.String id;
  /** Whether this inventory item is in plan. */
  core.bool inPlan;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#inventoryItem".
   */
  core.String kind;
  /** Information about the most recent modification of this inventory item. */
  LastModifiedInfo lastModifiedInfo;
  /**
   * Name of this inventory item. For standalone inventory items, this is the
   * same name as that of its only ad slot. For group inventory items, this can
   * differ from the name of any of its ad slots.
   */
  core.String name;
  /** Negotiation channel ID of this inventory item. */
  core.String negotiationChannelId;
  /** Order ID of this inventory item. */
  core.String orderId;
  /** Placement strategy ID of this inventory item. */
  core.String placementStrategyId;
  /** Pricing of this inventory item. */
  Pricing pricing;
  /** Project ID of this inventory item. */
  core.String projectId;
  /** RFP ID of this inventory item. */
  core.String rfpId;
  /** ID of the site this inventory item is associated with. */
  core.String siteId;
  /** Subaccount ID of this inventory item. */
  core.String subaccountId;
  /**
   * Type of inventory item.
   * Possible string values are:
   * - "PLANNING_PLACEMENT_TYPE_CREDIT"
   * - "PLANNING_PLACEMENT_TYPE_REGULAR"
   */
  core.String type;

  InventoryItem();

  InventoryItem.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("adSlots")) {
      adSlots = _json["adSlots"].map((value) => new AdSlot.fromJson(value)).toList();
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("contentCategoryId")) {
      contentCategoryId = _json["contentCategoryId"];
    }
    if (_json.containsKey("estimatedClickThroughRate")) {
      estimatedClickThroughRate = _json["estimatedClickThroughRate"];
    }
    if (_json.containsKey("estimatedConversionRate")) {
      estimatedConversionRate = _json["estimatedConversionRate"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inPlan")) {
      inPlan = _json["inPlan"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("negotiationChannelId")) {
      negotiationChannelId = _json["negotiationChannelId"];
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("placementStrategyId")) {
      placementStrategyId = _json["placementStrategyId"];
    }
    if (_json.containsKey("pricing")) {
      pricing = new Pricing.fromJson(_json["pricing"]);
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("rfpId")) {
      rfpId = _json["rfpId"];
    }
    if (_json.containsKey("siteId")) {
      siteId = _json["siteId"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (adSlots != null) {
      _json["adSlots"] = adSlots.map((value) => (value).toJson()).toList();
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (contentCategoryId != null) {
      _json["contentCategoryId"] = contentCategoryId;
    }
    if (estimatedClickThroughRate != null) {
      _json["estimatedClickThroughRate"] = estimatedClickThroughRate;
    }
    if (estimatedConversionRate != null) {
      _json["estimatedConversionRate"] = estimatedConversionRate;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inPlan != null) {
      _json["inPlan"] = inPlan;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (negotiationChannelId != null) {
      _json["negotiationChannelId"] = negotiationChannelId;
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (placementStrategyId != null) {
      _json["placementStrategyId"] = placementStrategyId;
    }
    if (pricing != null) {
      _json["pricing"] = (pricing).toJson();
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (rfpId != null) {
      _json["rfpId"] = rfpId;
    }
    if (siteId != null) {
      _json["siteId"] = siteId;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Inventory item List Response */
class InventoryItemsListResponse {
  /** Inventory item collection */
  core.List<InventoryItem> inventoryItems;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#inventoryItemsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;

  InventoryItemsListResponse();

  InventoryItemsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("inventoryItems")) {
      inventoryItems = _json["inventoryItems"].map((value) => new InventoryItem.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inventoryItems != null) {
      _json["inventoryItems"] = inventoryItems.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Key Value Targeting Expression. */
class KeyValueTargetingExpression {
  /** Keyword expression being targeted by the ad. */
  core.String expression;

  KeyValueTargetingExpression();

  KeyValueTargetingExpression.fromJson(core.Map _json) {
    if (_json.containsKey("expression")) {
      expression = _json["expression"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expression != null) {
      _json["expression"] = expression;
    }
    return _json;
  }
}

/**
 * Contains information about where a user's browser is taken after the user
 * clicks an ad.
 */
class LandingPage {
  /**
   * Whether or not this landing page will be assigned to any ads or creatives
   * that do not have a landing page assigned explicitly. Only one default
   * landing page is allowed per campaign.
   */
  core.bool default_;
  /** ID of this landing page. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#landingPage".
   */
  core.String kind;
  /**
   * Name of this landing page. This is a required field. It must be less than
   * 256 characters long, and must be unique among landing pages of the same
   * campaign.
   */
  core.String name;
  /** URL of this landing page. This is a required field. */
  core.String url;

  LandingPage();

  LandingPage.fromJson(core.Map _json) {
    if (_json.containsKey("default")) {
      default_ = _json["default"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (default_ != null) {
      _json["default"] = default_;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Landing Page List Response */
class LandingPagesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#landingPagesListResponse".
   */
  core.String kind;
  /** Landing page collection */
  core.List<LandingPage> landingPages;

  LandingPagesListResponse();

  LandingPagesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("landingPages")) {
      landingPages = _json["landingPages"].map((value) => new LandingPage.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (landingPages != null) {
      _json["landingPages"] = landingPages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains information about a language that can be targeted by ads. */
class Language {
  /**
   * Language ID of this language. This is the ID used for targeting and
   * generating reports.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#language".
   */
  core.String kind;
  /**
   * Format of language code is an ISO 639 two-letter language code optionally
   * followed by an underscore followed by an ISO 3166 code. Examples are "en"
   * for English or "zh_CN" for Simplified Chinese.
   */
  core.String languageCode;
  /** Name of this language. */
  core.String name;

  Language();

  Language.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Language Targeting. */
class LanguageTargeting {
  /**
   * Languages that this ad targets. For each language only languageId is
   * required. The other fields are populated automatically when the ad is
   * inserted or updated.
   */
  core.List<Language> languages;

  LanguageTargeting();

  LanguageTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("languages")) {
      languages = _json["languages"].map((value) => new Language.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (languages != null) {
      _json["languages"] = languages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Language List Response */
class LanguagesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#languagesListResponse".
   */
  core.String kind;
  /** Language collection. */
  core.List<Language> languages;

  LanguagesListResponse();

  LanguagesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languages")) {
      languages = _json["languages"].map((value) => new Language.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languages != null) {
      _json["languages"] = languages.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Modification timestamp. */
class LastModifiedInfo {
  /** Timestamp of the last change in milliseconds since epoch. */
  core.String time;

  LastModifiedInfo();

  LastModifiedInfo.fromJson(core.Map _json) {
    if (_json.containsKey("time")) {
      time = _json["time"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (time != null) {
      _json["time"] = time;
    }
    return _json;
  }
}

/**
 * A group clause made up of list population terms representing constraints
 * joined by ORs.
 */
class ListPopulationClause {
  /**
   * Terms of this list population clause. Each clause is made up of list
   * population terms representing constraints and are joined by ORs.
   */
  core.List<ListPopulationTerm> terms;

  ListPopulationClause();

  ListPopulationClause.fromJson(core.Map _json) {
    if (_json.containsKey("terms")) {
      terms = _json["terms"].map((value) => new ListPopulationTerm.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (terms != null) {
      _json["terms"] = terms.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Remarketing List Population Rule. */
class ListPopulationRule {
  /**
   * Floodlight activity ID associated with this rule. This field can be left
   * blank.
   */
  core.String floodlightActivityId;
  /**
   * Name of floodlight activity associated with this rule. This is a read-only,
   * auto-generated field.
   */
  core.String floodlightActivityName;
  /**
   * Clauses that make up this list population rule. Clauses are joined by ANDs,
   * and the clauses themselves are made up of list population terms which are
   * joined by ORs.
   */
  core.List<ListPopulationClause> listPopulationClauses;

  ListPopulationRule();

  ListPopulationRule.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightActivityId")) {
      floodlightActivityId = _json["floodlightActivityId"];
    }
    if (_json.containsKey("floodlightActivityName")) {
      floodlightActivityName = _json["floodlightActivityName"];
    }
    if (_json.containsKey("listPopulationClauses")) {
      listPopulationClauses = _json["listPopulationClauses"].map((value) => new ListPopulationClause.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightActivityId != null) {
      _json["floodlightActivityId"] = floodlightActivityId;
    }
    if (floodlightActivityName != null) {
      _json["floodlightActivityName"] = floodlightActivityName;
    }
    if (listPopulationClauses != null) {
      _json["listPopulationClauses"] = listPopulationClauses.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Remarketing List Population Rule Term. */
class ListPopulationTerm {
  /**
   * Will be true if the term should check if the user is in the list and false
   * if the term should check if the user is not in the list. This field is only
   * relevant when type is set to LIST_MEMBERSHIP_TERM. False by default.
   */
  core.bool contains;
  /**
   * Whether to negate the comparison result of this term during rule
   * evaluation. This field is only relevant when type is left unset or set to
   * CUSTOM_VARIABLE_TERM or REFERRER_TERM.
   */
  core.bool negation;
  /**
   * Comparison operator of this term. This field is only relevant when type is
   * left unset or set to CUSTOM_VARIABLE_TERM or REFERRER_TERM.
   * Possible string values are:
   * - "NUM_EQUALS"
   * - "NUM_GREATER_THAN"
   * - "NUM_GREATER_THAN_EQUAL"
   * - "NUM_LESS_THAN"
   * - "NUM_LESS_THAN_EQUAL"
   * - "STRING_CONTAINS"
   * - "STRING_EQUALS"
   */
  core.String operator;
  /**
   * ID of the list in question. This field is only relevant when type is set to
   * LIST_MEMBERSHIP_TERM.
   */
  core.String remarketingListId;
  /**
   * List population term type determines the applicable fields in this object.
   * If left unset or set to CUSTOM_VARIABLE_TERM, then variableName,
   * variableFriendlyName, operator, value, and negation are applicable. If set
   * to LIST_MEMBERSHIP_TERM then remarketingListId and contains are applicable.
   * If set to REFERRER_TERM then operator, value, and negation are applicable.
   * Possible string values are:
   * - "CUSTOM_VARIABLE_TERM"
   * - "LIST_MEMBERSHIP_TERM"
   * - "REFERRER_TERM"
   */
  core.String type;
  /**
   * Literal to compare the variable to. This field is only relevant when type
   * is left unset or set to CUSTOM_VARIABLE_TERM or REFERRER_TERM.
   */
  core.String value;
  /**
   * Friendly name of this term's variable. This is a read-only, auto-generated
   * field. This field is only relevant when type is left unset or set to
   * CUSTOM_VARIABLE_TERM.
   */
  core.String variableFriendlyName;
  /**
   * Name of the variable (U1, U2, etc.) being compared in this term. This field
   * is only relevant when type is set to null, CUSTOM_VARIABLE_TERM or
   * REFERRER_TERM.
   */
  core.String variableName;

  ListPopulationTerm();

  ListPopulationTerm.fromJson(core.Map _json) {
    if (_json.containsKey("contains")) {
      contains = _json["contains"];
    }
    if (_json.containsKey("negation")) {
      negation = _json["negation"];
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
    if (_json.containsKey("remarketingListId")) {
      remarketingListId = _json["remarketingListId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
    if (_json.containsKey("variableFriendlyName")) {
      variableFriendlyName = _json["variableFriendlyName"];
    }
    if (_json.containsKey("variableName")) {
      variableName = _json["variableName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contains != null) {
      _json["contains"] = contains;
    }
    if (negation != null) {
      _json["negation"] = negation;
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    if (remarketingListId != null) {
      _json["remarketingListId"] = remarketingListId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    if (variableFriendlyName != null) {
      _json["variableFriendlyName"] = variableFriendlyName;
    }
    if (variableName != null) {
      _json["variableName"] = variableName;
    }
    return _json;
  }
}

/** Remarketing List Targeting Expression. */
class ListTargetingExpression {
  /** Expression describing which lists are being targeted by the ad. */
  core.String expression;

  ListTargetingExpression();

  ListTargetingExpression.fromJson(core.Map _json) {
    if (_json.containsKey("expression")) {
      expression = _json["expression"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (expression != null) {
      _json["expression"] = expression;
    }
    return _json;
  }
}

/** Lookback configuration settings. */
class LookbackConfiguration {
  /**
   * Lookback window, in days, from the last time a given user clicked on one of
   * your ads. If you enter 0, clicks will not be considered as triggering
   * events for floodlight tracking. If you leave this field blank, the default
   * value for your account will be used.
   */
  core.int clickDuration;
  /**
   * Lookback window, in days, from the last time a given user viewed one of
   * your ads. If you enter 0, impressions will not be considered as triggering
   * events for floodlight tracking. If you leave this field blank, the default
   * value for your account will be used.
   */
  core.int postImpressionActivitiesDuration;

  LookbackConfiguration();

  LookbackConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("clickDuration")) {
      clickDuration = _json["clickDuration"];
    }
    if (_json.containsKey("postImpressionActivitiesDuration")) {
      postImpressionActivitiesDuration = _json["postImpressionActivitiesDuration"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clickDuration != null) {
      _json["clickDuration"] = clickDuration;
    }
    if (postImpressionActivitiesDuration != null) {
      _json["postImpressionActivitiesDuration"] = postImpressionActivitiesDuration;
    }
    return _json;
  }
}

/** Represents a metric. */
class Metric {
  /** The kind of resource this is, in this case dfareporting#metric. */
  core.String kind;
  /** The metric name, e.g. dfa:impressions */
  core.String name;

  Metric();

  Metric.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Contains information about a metro region that can be targeted by ads. */
class Metro {
  /** Country code of the country to which this metro region belongs. */
  core.String countryCode;
  /** DART ID of the country to which this metro region belongs. */
  core.String countryDartId;
  /** DART ID of this metro region. */
  core.String dartId;
  /**
   * DMA ID of this metro region. This is the ID used for targeting and
   * generating reports, and is equivalent to metro_code.
   */
  core.String dmaId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#metro".
   */
  core.String kind;
  /** Metro code of this metro region. This is equivalent to dma_id. */
  core.String metroCode;
  /** Name of this metro region. */
  core.String name;

  Metro();

  Metro.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("countryDartId")) {
      countryDartId = _json["countryDartId"];
    }
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("dmaId")) {
      dmaId = _json["dmaId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metroCode")) {
      metroCode = _json["metroCode"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (countryDartId != null) {
      _json["countryDartId"] = countryDartId;
    }
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (dmaId != null) {
      _json["dmaId"] = dmaId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metroCode != null) {
      _json["metroCode"] = metroCode;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Metro List Response */
class MetrosListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#metrosListResponse".
   */
  core.String kind;
  /** Metro collection. */
  core.List<Metro> metros;

  MetrosListResponse();

  MetrosListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metros")) {
      metros = _json["metros"].map((value) => new Metro.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metros != null) {
      _json["metros"] = metros.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains information about a mobile carrier that can be targeted by ads. */
class MobileCarrier {
  /** Country code of the country to which this mobile carrier belongs. */
  core.String countryCode;
  /** DART ID of the country to which this mobile carrier belongs. */
  core.String countryDartId;
  /** ID of this mobile carrier. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#mobileCarrier".
   */
  core.String kind;
  /** Name of this mobile carrier. */
  core.String name;

  MobileCarrier();

  MobileCarrier.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("countryDartId")) {
      countryDartId = _json["countryDartId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (countryDartId != null) {
      _json["countryDartId"] = countryDartId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Mobile Carrier List Response */
class MobileCarriersListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#mobileCarriersListResponse".
   */
  core.String kind;
  /** Mobile carrier collection. */
  core.List<MobileCarrier> mobileCarriers;

  MobileCarriersListResponse();

  MobileCarriersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mobileCarriers")) {
      mobileCarriers = _json["mobileCarriers"].map((value) => new MobileCarrier.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mobileCarriers != null) {
      _json["mobileCarriers"] = mobileCarriers.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Object Filter. */
class ObjectFilter {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#objectFilter".
   */
  core.String kind;
  /**
   * Applicable when status is ASSIGNED. The user has access to objects with
   * these object IDs.
   */
  core.List<core.String> objectIds;
  /**
   * Status of the filter. NONE means the user has access to none of the
   * objects. ALL means the user has access to all objects. ASSIGNED means the
   * user has access to the objects with IDs in the objectIds list.
   * Possible string values are:
   * - "ALL"
   * - "ASSIGNED"
   * - "NONE"
   */
  core.String status;

  ObjectFilter();

  ObjectFilter.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("objectIds")) {
      objectIds = _json["objectIds"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (objectIds != null) {
      _json["objectIds"] = objectIds;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/** Offset Position. */
class OffsetPosition {
  /** Offset distance from left side of an asset or a window. */
  core.int left;
  /** Offset distance from top side of an asset or a window. */
  core.int top;

  OffsetPosition();

  OffsetPosition.fromJson(core.Map _json) {
    if (_json.containsKey("left")) {
      left = _json["left"];
    }
    if (_json.containsKey("top")) {
      top = _json["top"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (left != null) {
      _json["left"] = left;
    }
    if (top != null) {
      _json["top"] = top;
    }
    return _json;
  }
}

/** Omniture Integration Settings. */
class OmnitureSettings {
  /**
   * Whether placement cost data will be sent to Omniture. This property can be
   * enabled only if omnitureIntegrationEnabled is true.
   */
  core.bool omnitureCostDataEnabled;
  /**
   * Whether Omniture integration is enabled. This property can be enabled only
   * when the "Advanced Ad Serving" account setting is enabled.
   */
  core.bool omnitureIntegrationEnabled;

  OmnitureSettings();

  OmnitureSettings.fromJson(core.Map _json) {
    if (_json.containsKey("omnitureCostDataEnabled")) {
      omnitureCostDataEnabled = _json["omnitureCostDataEnabled"];
    }
    if (_json.containsKey("omnitureIntegrationEnabled")) {
      omnitureIntegrationEnabled = _json["omnitureIntegrationEnabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (omnitureCostDataEnabled != null) {
      _json["omnitureCostDataEnabled"] = omnitureCostDataEnabled;
    }
    if (omnitureIntegrationEnabled != null) {
      _json["omnitureIntegrationEnabled"] = omnitureIntegrationEnabled;
    }
    return _json;
  }
}

/**
 * Contains information about an operating system that can be targeted by ads.
 */
class OperatingSystem {
  /** DART ID of this operating system. This is the ID used for targeting. */
  core.String dartId;
  /** Whether this operating system is for desktop. */
  core.bool desktop;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#operatingSystem".
   */
  core.String kind;
  /** Whether this operating system is for mobile. */
  core.bool mobile;
  /** Name of this operating system. */
  core.String name;

  OperatingSystem();

  OperatingSystem.fromJson(core.Map _json) {
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("desktop")) {
      desktop = _json["desktop"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mobile")) {
      mobile = _json["mobile"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (desktop != null) {
      _json["desktop"] = desktop;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mobile != null) {
      _json["mobile"] = mobile;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * Contains information about a particular version of an operating system that
 * can be targeted by ads.
 */
class OperatingSystemVersion {
  /** ID of this operating system version. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#operatingSystemVersion".
   */
  core.String kind;
  /** Major version (leftmost number) of this operating system version. */
  core.String majorVersion;
  /**
   * Minor version (number after the first dot) of this operating system
   * version.
   */
  core.String minorVersion;
  /** Name of this operating system version. */
  core.String name;
  /** Operating system of this operating system version. */
  OperatingSystem operatingSystem;

  OperatingSystemVersion();

  OperatingSystemVersion.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("majorVersion")) {
      majorVersion = _json["majorVersion"];
    }
    if (_json.containsKey("minorVersion")) {
      minorVersion = _json["minorVersion"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("operatingSystem")) {
      operatingSystem = new OperatingSystem.fromJson(_json["operatingSystem"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (majorVersion != null) {
      _json["majorVersion"] = majorVersion;
    }
    if (minorVersion != null) {
      _json["minorVersion"] = minorVersion;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (operatingSystem != null) {
      _json["operatingSystem"] = (operatingSystem).toJson();
    }
    return _json;
  }
}

/** Operating System Version List Response */
class OperatingSystemVersionsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#operatingSystemVersionsListResponse".
   */
  core.String kind;
  /** Operating system version collection. */
  core.List<OperatingSystemVersion> operatingSystemVersions;

  OperatingSystemVersionsListResponse();

  OperatingSystemVersionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operatingSystemVersions")) {
      operatingSystemVersions = _json["operatingSystemVersions"].map((value) => new OperatingSystemVersion.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operatingSystemVersions != null) {
      _json["operatingSystemVersions"] = operatingSystemVersions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Operating System List Response */
class OperatingSystemsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#operatingSystemsListResponse".
   */
  core.String kind;
  /** Operating system collection. */
  core.List<OperatingSystem> operatingSystems;

  OperatingSystemsListResponse();

  OperatingSystemsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("operatingSystems")) {
      operatingSystems = _json["operatingSystems"].map((value) => new OperatingSystem.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (operatingSystems != null) {
      _json["operatingSystems"] = operatingSystems.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Creative optimization activity. */
class OptimizationActivity {
  /**
   * Floodlight activity ID of this optimization activity. This is a required
   * field.
   */
  core.String floodlightActivityId;
  /**
   * Dimension value for the ID of the floodlight activity. This is a read-only,
   * auto-generated field.
   */
  DimensionValue floodlightActivityIdDimensionValue;
  /**
   * Weight associated with this optimization. Must be greater than 1. The
   * weight assigned will be understood in proportion to the weights assigned to
   * the other optimization activities.
   */
  core.int weight;

  OptimizationActivity();

  OptimizationActivity.fromJson(core.Map _json) {
    if (_json.containsKey("floodlightActivityId")) {
      floodlightActivityId = _json["floodlightActivityId"];
    }
    if (_json.containsKey("floodlightActivityIdDimensionValue")) {
      floodlightActivityIdDimensionValue = new DimensionValue.fromJson(_json["floodlightActivityIdDimensionValue"]);
    }
    if (_json.containsKey("weight")) {
      weight = _json["weight"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (floodlightActivityId != null) {
      _json["floodlightActivityId"] = floodlightActivityId;
    }
    if (floodlightActivityIdDimensionValue != null) {
      _json["floodlightActivityIdDimensionValue"] = (floodlightActivityIdDimensionValue).toJson();
    }
    if (weight != null) {
      _json["weight"] = weight;
    }
    return _json;
  }
}

/** Describes properties of a DoubleClick Planning order. */
class Order {
  /** Account ID of this order. */
  core.String accountId;
  /** Advertiser ID of this order. */
  core.String advertiserId;
  /** IDs for users that have to approve documents created for this order. */
  core.List<core.String> approverUserProfileIds;
  /** Buyer invoice ID associated with this order. */
  core.String buyerInvoiceId;
  /** Name of the buyer organization. */
  core.String buyerOrganizationName;
  /** Comments in this order. */
  core.String comments;
  /** Contacts for this order. */
  core.List<OrderContact> contacts;
  /** ID of this order. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#order".
   */
  core.String kind;
  /** Information about the most recent modification of this order. */
  LastModifiedInfo lastModifiedInfo;
  /** Name of this order. */
  core.String name;
  /** Notes of this order. */
  core.String notes;
  /** ID of the terms and conditions template used in this order. */
  core.String planningTermId;
  /** Project ID of this order. */
  core.String projectId;
  /** Seller order ID associated with this order. */
  core.String sellerOrderId;
  /** Name of the seller organization. */
  core.String sellerOrganizationName;
  /** Site IDs this order is associated with. */
  core.List<core.String> siteId;
  /** Free-form site names this order is associated with. */
  core.List<core.String> siteNames;
  /** Subaccount ID of this order. */
  core.String subaccountId;
  /** Terms and conditions of this order. */
  core.String termsAndConditions;

  Order();

  Order.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("approverUserProfileIds")) {
      approverUserProfileIds = _json["approverUserProfileIds"];
    }
    if (_json.containsKey("buyerInvoiceId")) {
      buyerInvoiceId = _json["buyerInvoiceId"];
    }
    if (_json.containsKey("buyerOrganizationName")) {
      buyerOrganizationName = _json["buyerOrganizationName"];
    }
    if (_json.containsKey("comments")) {
      comments = _json["comments"];
    }
    if (_json.containsKey("contacts")) {
      contacts = _json["contacts"].map((value) => new OrderContact.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("notes")) {
      notes = _json["notes"];
    }
    if (_json.containsKey("planningTermId")) {
      planningTermId = _json["planningTermId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("sellerOrderId")) {
      sellerOrderId = _json["sellerOrderId"];
    }
    if (_json.containsKey("sellerOrganizationName")) {
      sellerOrganizationName = _json["sellerOrganizationName"];
    }
    if (_json.containsKey("siteId")) {
      siteId = _json["siteId"];
    }
    if (_json.containsKey("siteNames")) {
      siteNames = _json["siteNames"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("termsAndConditions")) {
      termsAndConditions = _json["termsAndConditions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (approverUserProfileIds != null) {
      _json["approverUserProfileIds"] = approverUserProfileIds;
    }
    if (buyerInvoiceId != null) {
      _json["buyerInvoiceId"] = buyerInvoiceId;
    }
    if (buyerOrganizationName != null) {
      _json["buyerOrganizationName"] = buyerOrganizationName;
    }
    if (comments != null) {
      _json["comments"] = comments;
    }
    if (contacts != null) {
      _json["contacts"] = contacts.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (notes != null) {
      _json["notes"] = notes;
    }
    if (planningTermId != null) {
      _json["planningTermId"] = planningTermId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (sellerOrderId != null) {
      _json["sellerOrderId"] = sellerOrderId;
    }
    if (sellerOrganizationName != null) {
      _json["sellerOrganizationName"] = sellerOrganizationName;
    }
    if (siteId != null) {
      _json["siteId"] = siteId;
    }
    if (siteNames != null) {
      _json["siteNames"] = siteNames;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (termsAndConditions != null) {
      _json["termsAndConditions"] = termsAndConditions;
    }
    return _json;
  }
}

/** Contact of an order. */
class OrderContact {
  /**
   * Free-form information about this contact. It could be any information
   * related to this contact in addition to type, title, name, and signature
   * user profile ID.
   */
  core.String contactInfo;
  /** Name of this contact. */
  core.String contactName;
  /** Title of this contact. */
  core.String contactTitle;
  /**
   * Type of this contact.
   * Possible string values are:
   * - "PLANNING_ORDER_CONTACT_BUYER_BILLING_CONTACT"
   * - "PLANNING_ORDER_CONTACT_BUYER_CONTACT"
   * - "PLANNING_ORDER_CONTACT_SELLER_CONTACT"
   */
  core.String contactType;
  /**
   * ID of the user profile containing the signature that will be embedded into
   * order documents.
   */
  core.String signatureUserProfileId;

  OrderContact();

  OrderContact.fromJson(core.Map _json) {
    if (_json.containsKey("contactInfo")) {
      contactInfo = _json["contactInfo"];
    }
    if (_json.containsKey("contactName")) {
      contactName = _json["contactName"];
    }
    if (_json.containsKey("contactTitle")) {
      contactTitle = _json["contactTitle"];
    }
    if (_json.containsKey("contactType")) {
      contactType = _json["contactType"];
    }
    if (_json.containsKey("signatureUserProfileId")) {
      signatureUserProfileId = _json["signatureUserProfileId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contactInfo != null) {
      _json["contactInfo"] = contactInfo;
    }
    if (contactName != null) {
      _json["contactName"] = contactName;
    }
    if (contactTitle != null) {
      _json["contactTitle"] = contactTitle;
    }
    if (contactType != null) {
      _json["contactType"] = contactType;
    }
    if (signatureUserProfileId != null) {
      _json["signatureUserProfileId"] = signatureUserProfileId;
    }
    return _json;
  }
}

/** Contains properties of a DoubleClick Planning order document. */
class OrderDocument {
  /** Account ID of this order document. */
  core.String accountId;
  /** Advertiser ID of this order document. */
  core.String advertiserId;
  /**
   * The amended order document ID of this order document. An order document can
   * be created by optionally amending another order document so that the change
   * history can be preserved.
   */
  core.String amendedOrderDocumentId;
  /** IDs of users who have approved this order document. */
  core.List<core.String> approvedByUserProfileIds;
  /** Whether this order document is cancelled. */
  core.bool cancelled;
  /** Information about the creation of this order document. */
  LastModifiedInfo createdInfo;
  /** Effective date of this order document. */
  core.DateTime effectiveDate;
  /** ID of this order document. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#orderDocument".
   */
  core.String kind;
  /** List of email addresses that received the last sent document. */
  core.List<core.String> lastSentRecipients;
  /** Timestamp of the last email sent with this order document. */
  core.DateTime lastSentTime;
  /** ID of the order from which this order document is created. */
  core.String orderId;
  /** Project ID of this order document. */
  core.String projectId;
  /** Whether this order document has been signed. */
  core.bool signed;
  /** Subaccount ID of this order document. */
  core.String subaccountId;
  /** Title of this order document. */
  core.String title;
  /**
   * Type of this order document
   * Possible string values are:
   * - "PLANNING_ORDER_TYPE_CHANGE_ORDER"
   * - "PLANNING_ORDER_TYPE_INSERTION_ORDER"
   */
  core.String type;

  OrderDocument();

  OrderDocument.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("amendedOrderDocumentId")) {
      amendedOrderDocumentId = _json["amendedOrderDocumentId"];
    }
    if (_json.containsKey("approvedByUserProfileIds")) {
      approvedByUserProfileIds = _json["approvedByUserProfileIds"];
    }
    if (_json.containsKey("cancelled")) {
      cancelled = _json["cancelled"];
    }
    if (_json.containsKey("createdInfo")) {
      createdInfo = new LastModifiedInfo.fromJson(_json["createdInfo"]);
    }
    if (_json.containsKey("effectiveDate")) {
      effectiveDate = core.DateTime.parse(_json["effectiveDate"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastSentRecipients")) {
      lastSentRecipients = _json["lastSentRecipients"];
    }
    if (_json.containsKey("lastSentTime")) {
      lastSentTime = core.DateTime.parse(_json["lastSentTime"]);
    }
    if (_json.containsKey("orderId")) {
      orderId = _json["orderId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("signed")) {
      signed = _json["signed"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (amendedOrderDocumentId != null) {
      _json["amendedOrderDocumentId"] = amendedOrderDocumentId;
    }
    if (approvedByUserProfileIds != null) {
      _json["approvedByUserProfileIds"] = approvedByUserProfileIds;
    }
    if (cancelled != null) {
      _json["cancelled"] = cancelled;
    }
    if (createdInfo != null) {
      _json["createdInfo"] = (createdInfo).toJson();
    }
    if (effectiveDate != null) {
      _json["effectiveDate"] = "${(effectiveDate).year.toString().padLeft(4, '0')}-${(effectiveDate).month.toString().padLeft(2, '0')}-${(effectiveDate).day.toString().padLeft(2, '0')}";
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastSentRecipients != null) {
      _json["lastSentRecipients"] = lastSentRecipients;
    }
    if (lastSentTime != null) {
      _json["lastSentTime"] = (lastSentTime).toIso8601String();
    }
    if (orderId != null) {
      _json["orderId"] = orderId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (signed != null) {
      _json["signed"] = signed;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Order document List Response */
class OrderDocumentsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#orderDocumentsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Order document collection */
  core.List<OrderDocument> orderDocuments;

  OrderDocumentsListResponse();

  OrderDocumentsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("orderDocuments")) {
      orderDocuments = _json["orderDocuments"].map((value) => new OrderDocument.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (orderDocuments != null) {
      _json["orderDocuments"] = orderDocuments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Order List Response */
class OrdersListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#ordersListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Order collection. */
  core.List<Order> orders;

  OrdersListResponse();

  OrdersListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("orders")) {
      orders = _json["orders"].map((value) => new Order.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (orders != null) {
      _json["orders"] = orders.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents fields that are compatible to be selected for a report of type
 * "PATH_TO_CONVERSION".
 */
class PathToConversionReportCompatibleFields {
  /**
   * Conversion dimensions which are compatible to be selected in the
   * "conversionDimensions" section of the report.
   */
  core.List<Dimension> conversionDimensions;
  /**
   * Custom floodlight variables which are compatible to be selected in the
   * "customFloodlightVariables" section of the report.
   */
  core.List<Dimension> customFloodlightVariables;
  /**
   * The kind of resource this is, in this case
   * dfareporting#pathToConversionReportCompatibleFields.
   */
  core.String kind;
  /**
   * Metrics which are compatible to be selected in the "metricNames" section of
   * the report.
   */
  core.List<Metric> metrics;
  /**
   * Per-interaction dimensions which are compatible to be selected in the
   * "perInteractionDimensions" section of the report.
   */
  core.List<Dimension> perInteractionDimensions;

  PathToConversionReportCompatibleFields();

  PathToConversionReportCompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("conversionDimensions")) {
      conversionDimensions = _json["conversionDimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("customFloodlightVariables")) {
      customFloodlightVariables = _json["customFloodlightVariables"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("perInteractionDimensions")) {
      perInteractionDimensions = _json["perInteractionDimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conversionDimensions != null) {
      _json["conversionDimensions"] = conversionDimensions.map((value) => (value).toJson()).toList();
    }
    if (customFloodlightVariables != null) {
      _json["customFloodlightVariables"] = customFloodlightVariables.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (perInteractionDimensions != null) {
      _json["perInteractionDimensions"] = perInteractionDimensions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains properties of a placement. */
class Placement {
  /** Account ID of this placement. This field can be left blank. */
  core.String accountId;
  /** Advertiser ID of this placement. This field can be left blank. */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Whether this placement is archived. */
  core.bool archived;
  /**
   * Campaign ID of this placement. This field is a required field on insertion.
   */
  core.String campaignId;
  /**
   * Dimension value for the ID of the campaign. This is a read-only,
   * auto-generated field.
   */
  DimensionValue campaignIdDimensionValue;
  /** Comments for this placement. */
  core.String comment;
  /**
   * Placement compatibility. DISPLAY and DISPLAY_INTERSTITIAL refer to
   * rendering on desktop, on mobile devices or in mobile apps for regular or
   * interstitial ads respectively. APP and APP_INTERSTITIAL are no longer
   * allowed for new placement insertions. Instead, use DISPLAY or
   * DISPLAY_INTERSTITIAL. IN_STREAM_VIDEO refers to rendering in in-stream
   * video ads developed with the VAST standard. This field is required on
   * insertion.
   * Possible string values are:
   * - "APP"
   * - "APP_INTERSTITIAL"
   * - "DISPLAY"
   * - "DISPLAY_INTERSTITIAL"
   * - "IN_STREAM_VIDEO"
   */
  core.String compatibility;
  /** ID of the content category assigned to this placement. */
  core.String contentCategoryId;
  /**
   * Information about the creation of this placement. This is a read-only
   * field.
   */
  LastModifiedInfo createInfo;
  /**
   * Directory site ID of this placement. On insert, you must set either this
   * field or the siteId field to specify the site associated with this
   * placement. This is a required field that is read-only after insertion.
   */
  core.String directorySiteId;
  /**
   * Dimension value for the ID of the directory site. This is a read-only,
   * auto-generated field.
   */
  DimensionValue directorySiteIdDimensionValue;
  /** External ID for this placement. */
  core.String externalId;
  /** ID of this placement. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this placement. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /** Key name of this placement. This is a read-only, auto-generated field. */
  core.String keyName;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placement".
   */
  core.String kind;
  /**
   * Information about the most recent modification of this placement. This is a
   * read-only field.
   */
  LastModifiedInfo lastModifiedInfo;
  /** Lookback window settings for this placement. */
  LookbackConfiguration lookbackConfiguration;
  /**
   * Name of this placement.This is a required field and must be less than 256
   * characters long.
   */
  core.String name;
  /**
   * Whether payment was approved for this placement. This is a read-only field
   * relevant only to publisher-paid placements.
   */
  core.bool paymentApproved;
  /**
   * Payment source for this placement. This is a required field that is
   * read-only after insertion.
   * Possible string values are:
   * - "PLACEMENT_AGENCY_PAID"
   * - "PLACEMENT_PUBLISHER_PAID"
   */
  core.String paymentSource;
  /** ID of this placement's group, if applicable. */
  core.String placementGroupId;
  /**
   * Dimension value for the ID of the placement group. This is a read-only,
   * auto-generated field.
   */
  DimensionValue placementGroupIdDimensionValue;
  /** ID of the placement strategy assigned to this placement. */
  core.String placementStrategyId;
  /**
   * Pricing schedule of this placement. This field is required on insertion,
   * specifically subfields startDate, endDate and pricingType.
   */
  PricingSchedule pricingSchedule;
  /**
   * Whether this placement is the primary placement of a roadblock (placement
   * group). You cannot change this field from true to false. Setting this field
   * to true will automatically set the primary field on the original primary
   * placement of the roadblock to false, and it will automatically set the
   * roadblock's primaryPlacementId field to the ID of this placement.
   */
  core.bool primary;
  /**
   * Information about the last publisher update. This is a read-only field.
   */
  LastModifiedInfo publisherUpdateInfo;
  /**
   * Site ID associated with this placement. On insert, you must set either this
   * field or the directorySiteId field to specify the site associated with this
   * placement. This is a required field that is read-only after insertion.
   */
  core.String siteId;
  /**
   * Dimension value for the ID of the site. This is a read-only, auto-generated
   * field.
   */
  DimensionValue siteIdDimensionValue;
  /**
   * Size associated with this placement. When inserting or updating a
   * placement, only the size ID field is used. This field is required on
   * insertion.
   */
  Size size;
  /** Whether creatives assigned to this placement must be SSL-compliant. */
  core.bool sslRequired;
  /**
   * Third-party placement status.
   * Possible string values are:
   * - "ACKNOWLEDGE_ACCEPTANCE"
   * - "ACKNOWLEDGE_REJECTION"
   * - "DRAFT"
   * - "PAYMENT_ACCEPTED"
   * - "PAYMENT_REJECTED"
   * - "PENDING_REVIEW"
   */
  core.String status;
  /** Subaccount ID of this placement. This field can be left blank. */
  core.String subaccountId;
  /**
   * Tag formats to generate for this placement. This field is required on
   * insertion.
   * Acceptable values are:
   * - "PLACEMENT_TAG_STANDARD"
   * - "PLACEMENT_TAG_IFRAME_JAVASCRIPT"
   * - "PLACEMENT_TAG_IFRAME_ILAYER"
   * - "PLACEMENT_TAG_INTERNAL_REDIRECT"
   * - "PLACEMENT_TAG_JAVASCRIPT"
   * - "PLACEMENT_TAG_INTERSTITIAL_IFRAME_JAVASCRIPT"
   * - "PLACEMENT_TAG_INTERSTITIAL_INTERNAL_REDIRECT"
   * - "PLACEMENT_TAG_INTERSTITIAL_JAVASCRIPT"
   * - "PLACEMENT_TAG_CLICK_COMMANDS"
   * - "PLACEMENT_TAG_INSTREAM_VIDEO_PREFETCH"
   * - "PLACEMENT_TAG_TRACKING"
   * - "PLACEMENT_TAG_TRACKING_IFRAME"
   * - "PLACEMENT_TAG_TRACKING_JAVASCRIPT"
   */
  core.List<core.String> tagFormats;
  /** Tag settings for this placement. */
  TagSetting tagSetting;
  /**
   * Whether Verification and ActiveView are disabled for in-stream video
   * creatives for this placement. The same setting videoActiveViewOptOut exists
   * on the site level -- the opt out occurs if either of these settings are
   * true. These settings are distinct from
   * DirectorySites.settings.activeViewOptOut or
   * Sites.siteSettings.activeViewOptOut which only apply to display ads.
   * However, Accounts.activeViewOptOut opts out both video traffic, as well as
   * display ads, from Verification and ActiveView.
   */
  core.bool videoActiveViewOptOut;
  /**
   * A collection of settings which affect video creatives served through this
   * placement. Applicable to placements with IN_STREAM_VIDEO compatibility.
   */
  VideoSettings videoSettings;
  /**
   * VPAID adapter setting for this placement. Controls which VPAID format the
   * measurement adapter will use for in-stream video creatives assigned to this
   * placement.
   * Possible string values are:
   * - "BOTH"
   * - "DEFAULT"
   * - "FLASH"
   * - "HTML5"
   */
  core.String vpaidAdapterChoice;

  Placement();

  Placement.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("archived")) {
      archived = _json["archived"];
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("campaignIdDimensionValue")) {
      campaignIdDimensionValue = new DimensionValue.fromJson(_json["campaignIdDimensionValue"]);
    }
    if (_json.containsKey("comment")) {
      comment = _json["comment"];
    }
    if (_json.containsKey("compatibility")) {
      compatibility = _json["compatibility"];
    }
    if (_json.containsKey("contentCategoryId")) {
      contentCategoryId = _json["contentCategoryId"];
    }
    if (_json.containsKey("createInfo")) {
      createInfo = new LastModifiedInfo.fromJson(_json["createInfo"]);
    }
    if (_json.containsKey("directorySiteId")) {
      directorySiteId = _json["directorySiteId"];
    }
    if (_json.containsKey("directorySiteIdDimensionValue")) {
      directorySiteIdDimensionValue = new DimensionValue.fromJson(_json["directorySiteIdDimensionValue"]);
    }
    if (_json.containsKey("externalId")) {
      externalId = _json["externalId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("keyName")) {
      keyName = _json["keyName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("lookbackConfiguration")) {
      lookbackConfiguration = new LookbackConfiguration.fromJson(_json["lookbackConfiguration"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("paymentApproved")) {
      paymentApproved = _json["paymentApproved"];
    }
    if (_json.containsKey("paymentSource")) {
      paymentSource = _json["paymentSource"];
    }
    if (_json.containsKey("placementGroupId")) {
      placementGroupId = _json["placementGroupId"];
    }
    if (_json.containsKey("placementGroupIdDimensionValue")) {
      placementGroupIdDimensionValue = new DimensionValue.fromJson(_json["placementGroupIdDimensionValue"]);
    }
    if (_json.containsKey("placementStrategyId")) {
      placementStrategyId = _json["placementStrategyId"];
    }
    if (_json.containsKey("pricingSchedule")) {
      pricingSchedule = new PricingSchedule.fromJson(_json["pricingSchedule"]);
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("publisherUpdateInfo")) {
      publisherUpdateInfo = new LastModifiedInfo.fromJson(_json["publisherUpdateInfo"]);
    }
    if (_json.containsKey("siteId")) {
      siteId = _json["siteId"];
    }
    if (_json.containsKey("siteIdDimensionValue")) {
      siteIdDimensionValue = new DimensionValue.fromJson(_json["siteIdDimensionValue"]);
    }
    if (_json.containsKey("size")) {
      size = new Size.fromJson(_json["size"]);
    }
    if (_json.containsKey("sslRequired")) {
      sslRequired = _json["sslRequired"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("tagFormats")) {
      tagFormats = _json["tagFormats"];
    }
    if (_json.containsKey("tagSetting")) {
      tagSetting = new TagSetting.fromJson(_json["tagSetting"]);
    }
    if (_json.containsKey("videoActiveViewOptOut")) {
      videoActiveViewOptOut = _json["videoActiveViewOptOut"];
    }
    if (_json.containsKey("videoSettings")) {
      videoSettings = new VideoSettings.fromJson(_json["videoSettings"]);
    }
    if (_json.containsKey("vpaidAdapterChoice")) {
      vpaidAdapterChoice = _json["vpaidAdapterChoice"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (archived != null) {
      _json["archived"] = archived;
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (campaignIdDimensionValue != null) {
      _json["campaignIdDimensionValue"] = (campaignIdDimensionValue).toJson();
    }
    if (comment != null) {
      _json["comment"] = comment;
    }
    if (compatibility != null) {
      _json["compatibility"] = compatibility;
    }
    if (contentCategoryId != null) {
      _json["contentCategoryId"] = contentCategoryId;
    }
    if (createInfo != null) {
      _json["createInfo"] = (createInfo).toJson();
    }
    if (directorySiteId != null) {
      _json["directorySiteId"] = directorySiteId;
    }
    if (directorySiteIdDimensionValue != null) {
      _json["directorySiteIdDimensionValue"] = (directorySiteIdDimensionValue).toJson();
    }
    if (externalId != null) {
      _json["externalId"] = externalId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (keyName != null) {
      _json["keyName"] = keyName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (lookbackConfiguration != null) {
      _json["lookbackConfiguration"] = (lookbackConfiguration).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (paymentApproved != null) {
      _json["paymentApproved"] = paymentApproved;
    }
    if (paymentSource != null) {
      _json["paymentSource"] = paymentSource;
    }
    if (placementGroupId != null) {
      _json["placementGroupId"] = placementGroupId;
    }
    if (placementGroupIdDimensionValue != null) {
      _json["placementGroupIdDimensionValue"] = (placementGroupIdDimensionValue).toJson();
    }
    if (placementStrategyId != null) {
      _json["placementStrategyId"] = placementStrategyId;
    }
    if (pricingSchedule != null) {
      _json["pricingSchedule"] = (pricingSchedule).toJson();
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (publisherUpdateInfo != null) {
      _json["publisherUpdateInfo"] = (publisherUpdateInfo).toJson();
    }
    if (siteId != null) {
      _json["siteId"] = siteId;
    }
    if (siteIdDimensionValue != null) {
      _json["siteIdDimensionValue"] = (siteIdDimensionValue).toJson();
    }
    if (size != null) {
      _json["size"] = (size).toJson();
    }
    if (sslRequired != null) {
      _json["sslRequired"] = sslRequired;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (tagFormats != null) {
      _json["tagFormats"] = tagFormats;
    }
    if (tagSetting != null) {
      _json["tagSetting"] = (tagSetting).toJson();
    }
    if (videoActiveViewOptOut != null) {
      _json["videoActiveViewOptOut"] = videoActiveViewOptOut;
    }
    if (videoSettings != null) {
      _json["videoSettings"] = (videoSettings).toJson();
    }
    if (vpaidAdapterChoice != null) {
      _json["vpaidAdapterChoice"] = vpaidAdapterChoice;
    }
    return _json;
  }
}

/** Placement Assignment. */
class PlacementAssignment {
  /**
   * Whether this placement assignment is active. When true, the placement will
   * be included in the ad's rotation.
   */
  core.bool active;
  /** ID of the placement to be assigned. This is a required field. */
  core.String placementId;
  /**
   * Dimension value for the ID of the placement. This is a read-only,
   * auto-generated field.
   */
  DimensionValue placementIdDimensionValue;
  /**
   * Whether the placement to be assigned requires SSL. This is a read-only
   * field that is auto-generated when the ad is inserted or updated.
   */
  core.bool sslRequired;

  PlacementAssignment();

  PlacementAssignment.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("placementId")) {
      placementId = _json["placementId"];
    }
    if (_json.containsKey("placementIdDimensionValue")) {
      placementIdDimensionValue = new DimensionValue.fromJson(_json["placementIdDimensionValue"]);
    }
    if (_json.containsKey("sslRequired")) {
      sslRequired = _json["sslRequired"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (placementId != null) {
      _json["placementId"] = placementId;
    }
    if (placementIdDimensionValue != null) {
      _json["placementIdDimensionValue"] = (placementIdDimensionValue).toJson();
    }
    if (sslRequired != null) {
      _json["sslRequired"] = sslRequired;
    }
    return _json;
  }
}

/** Contains properties of a package or roadblock. */
class PlacementGroup {
  /**
   * Account ID of this placement group. This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * Advertiser ID of this placement group. This is a required field on
   * insertion.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Whether this placement group is archived. */
  core.bool archived;
  /**
   * Campaign ID of this placement group. This field is required on insertion.
   */
  core.String campaignId;
  /**
   * Dimension value for the ID of the campaign. This is a read-only,
   * auto-generated field.
   */
  DimensionValue campaignIdDimensionValue;
  /**
   * IDs of placements which are assigned to this placement group. This is a
   * read-only, auto-generated field.
   */
  core.List<core.String> childPlacementIds;
  /** Comments for this placement group. */
  core.String comment;
  /** ID of the content category assigned to this placement group. */
  core.String contentCategoryId;
  /**
   * Information about the creation of this placement group. This is a read-only
   * field.
   */
  LastModifiedInfo createInfo;
  /**
   * Directory site ID associated with this placement group. On insert, you must
   * set either this field or the site_id field to specify the site associated
   * with this placement group. This is a required field that is read-only after
   * insertion.
   */
  core.String directorySiteId;
  /**
   * Dimension value for the ID of the directory site. This is a read-only,
   * auto-generated field.
   */
  DimensionValue directorySiteIdDimensionValue;
  /** External ID for this placement. */
  core.String externalId;
  /** ID of this placement group. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this placement group. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementGroup".
   */
  core.String kind;
  /**
   * Information about the most recent modification of this placement group.
   * This is a read-only field.
   */
  LastModifiedInfo lastModifiedInfo;
  /**
   * Name of this placement group. This is a required field and must be less
   * than 256 characters long.
   */
  core.String name;
  /**
   * Type of this placement group. A package is a simple group of placements
   * that acts as a single pricing point for a group of tags. A roadblock is a
   * group of placements that not only acts as a single pricing point, but also
   * assumes that all the tags in it will be served at the same time. A
   * roadblock requires one of its assigned placements to be marked as primary
   * for reporting. This field is required on insertion.
   * Possible string values are:
   * - "PLACEMENT_PACKAGE"
   * - "PLACEMENT_ROADBLOCK"
   */
  core.String placementGroupType;
  /** ID of the placement strategy assigned to this placement group. */
  core.String placementStrategyId;
  /**
   * Pricing schedule of this placement group. This field is required on
   * insertion.
   */
  PricingSchedule pricingSchedule;
  /**
   * ID of the primary placement, used to calculate the media cost of a
   * roadblock (placement group). Modifying this field will automatically modify
   * the primary field on all affected roadblock child placements.
   */
  core.String primaryPlacementId;
  /**
   * Dimension value for the ID of the primary placement. This is a read-only,
   * auto-generated field.
   */
  DimensionValue primaryPlacementIdDimensionValue;
  /**
   * Site ID associated with this placement group. On insert, you must set
   * either this field or the directorySiteId field to specify the site
   * associated with this placement group. This is a required field that is
   * read-only after insertion.
   */
  core.String siteId;
  /**
   * Dimension value for the ID of the site. This is a read-only, auto-generated
   * field.
   */
  DimensionValue siteIdDimensionValue;
  /**
   * Subaccount ID of this placement group. This is a read-only field that can
   * be left blank.
   */
  core.String subaccountId;

  PlacementGroup();

  PlacementGroup.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("archived")) {
      archived = _json["archived"];
    }
    if (_json.containsKey("campaignId")) {
      campaignId = _json["campaignId"];
    }
    if (_json.containsKey("campaignIdDimensionValue")) {
      campaignIdDimensionValue = new DimensionValue.fromJson(_json["campaignIdDimensionValue"]);
    }
    if (_json.containsKey("childPlacementIds")) {
      childPlacementIds = _json["childPlacementIds"];
    }
    if (_json.containsKey("comment")) {
      comment = _json["comment"];
    }
    if (_json.containsKey("contentCategoryId")) {
      contentCategoryId = _json["contentCategoryId"];
    }
    if (_json.containsKey("createInfo")) {
      createInfo = new LastModifiedInfo.fromJson(_json["createInfo"]);
    }
    if (_json.containsKey("directorySiteId")) {
      directorySiteId = _json["directorySiteId"];
    }
    if (_json.containsKey("directorySiteIdDimensionValue")) {
      directorySiteIdDimensionValue = new DimensionValue.fromJson(_json["directorySiteIdDimensionValue"]);
    }
    if (_json.containsKey("externalId")) {
      externalId = _json["externalId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("placementGroupType")) {
      placementGroupType = _json["placementGroupType"];
    }
    if (_json.containsKey("placementStrategyId")) {
      placementStrategyId = _json["placementStrategyId"];
    }
    if (_json.containsKey("pricingSchedule")) {
      pricingSchedule = new PricingSchedule.fromJson(_json["pricingSchedule"]);
    }
    if (_json.containsKey("primaryPlacementId")) {
      primaryPlacementId = _json["primaryPlacementId"];
    }
    if (_json.containsKey("primaryPlacementIdDimensionValue")) {
      primaryPlacementIdDimensionValue = new DimensionValue.fromJson(_json["primaryPlacementIdDimensionValue"]);
    }
    if (_json.containsKey("siteId")) {
      siteId = _json["siteId"];
    }
    if (_json.containsKey("siteIdDimensionValue")) {
      siteIdDimensionValue = new DimensionValue.fromJson(_json["siteIdDimensionValue"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (archived != null) {
      _json["archived"] = archived;
    }
    if (campaignId != null) {
      _json["campaignId"] = campaignId;
    }
    if (campaignIdDimensionValue != null) {
      _json["campaignIdDimensionValue"] = (campaignIdDimensionValue).toJson();
    }
    if (childPlacementIds != null) {
      _json["childPlacementIds"] = childPlacementIds;
    }
    if (comment != null) {
      _json["comment"] = comment;
    }
    if (contentCategoryId != null) {
      _json["contentCategoryId"] = contentCategoryId;
    }
    if (createInfo != null) {
      _json["createInfo"] = (createInfo).toJson();
    }
    if (directorySiteId != null) {
      _json["directorySiteId"] = directorySiteId;
    }
    if (directorySiteIdDimensionValue != null) {
      _json["directorySiteIdDimensionValue"] = (directorySiteIdDimensionValue).toJson();
    }
    if (externalId != null) {
      _json["externalId"] = externalId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (placementGroupType != null) {
      _json["placementGroupType"] = placementGroupType;
    }
    if (placementStrategyId != null) {
      _json["placementStrategyId"] = placementStrategyId;
    }
    if (pricingSchedule != null) {
      _json["pricingSchedule"] = (pricingSchedule).toJson();
    }
    if (primaryPlacementId != null) {
      _json["primaryPlacementId"] = primaryPlacementId;
    }
    if (primaryPlacementIdDimensionValue != null) {
      _json["primaryPlacementIdDimensionValue"] = (primaryPlacementIdDimensionValue).toJson();
    }
    if (siteId != null) {
      _json["siteId"] = siteId;
    }
    if (siteIdDimensionValue != null) {
      _json["siteIdDimensionValue"] = (siteIdDimensionValue).toJson();
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Placement Group List Response */
class PlacementGroupsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementGroupsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Placement group collection. */
  core.List<PlacementGroup> placementGroups;

  PlacementGroupsListResponse();

  PlacementGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("placementGroups")) {
      placementGroups = _json["placementGroups"].map((value) => new PlacementGroup.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (placementGroups != null) {
      _json["placementGroups"] = placementGroups.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Placement Strategy List Response */
class PlacementStrategiesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementStrategiesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Placement strategy collection. */
  core.List<PlacementStrategy> placementStrategies;

  PlacementStrategiesListResponse();

  PlacementStrategiesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("placementStrategies")) {
      placementStrategies = _json["placementStrategies"].map((value) => new PlacementStrategy.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (placementStrategies != null) {
      _json["placementStrategies"] = placementStrategies.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains properties of a placement strategy. */
class PlacementStrategy {
  /**
   * Account ID of this placement strategy.This is a read-only field that can be
   * left blank.
   */
  core.String accountId;
  /**
   * ID of this placement strategy. This is a read-only, auto-generated field.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementStrategy".
   */
  core.String kind;
  /**
   * Name of this placement strategy. This is a required field. It must be less
   * than 256 characters long and unique among placement strategies of the same
   * account.
   */
  core.String name;

  PlacementStrategy();

  PlacementStrategy.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Placement Tag */
class PlacementTag {
  /** Placement ID */
  core.String placementId;
  /** Tags generated for this placement. */
  core.List<TagData> tagDatas;

  PlacementTag();

  PlacementTag.fromJson(core.Map _json) {
    if (_json.containsKey("placementId")) {
      placementId = _json["placementId"];
    }
    if (_json.containsKey("tagDatas")) {
      tagDatas = _json["tagDatas"].map((value) => new TagData.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (placementId != null) {
      _json["placementId"] = placementId;
    }
    if (tagDatas != null) {
      _json["tagDatas"] = tagDatas.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Placement GenerateTags Response */
class PlacementsGenerateTagsResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementsGenerateTagsResponse".
   */
  core.String kind;
  /** Set of generated tags for the specified placements. */
  core.List<PlacementTag> placementTags;

  PlacementsGenerateTagsResponse();

  PlacementsGenerateTagsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("placementTags")) {
      placementTags = _json["placementTags"].map((value) => new PlacementTag.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (placementTags != null) {
      _json["placementTags"] = placementTags.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Placement List Response */
class PlacementsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#placementsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Placement collection. */
  core.List<Placement> placements;

  PlacementsListResponse();

  PlacementsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("placements")) {
      placements = _json["placements"].map((value) => new Placement.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (placements != null) {
      _json["placements"] = placements.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains information about a platform type that can be targeted by ads. */
class PlatformType {
  /** ID of this platform type. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#platformType".
   */
  core.String kind;
  /** Name of this platform type. */
  core.String name;

  PlatformType();

  PlatformType.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Platform Type List Response */
class PlatformTypesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#platformTypesListResponse".
   */
  core.String kind;
  /** Platform type collection. */
  core.List<PlatformType> platformTypes;

  PlatformTypesListResponse();

  PlatformTypesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("platformTypes")) {
      platformTypes = _json["platformTypes"].map((value) => new PlatformType.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (platformTypes != null) {
      _json["platformTypes"] = platformTypes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Popup Window Properties. */
class PopupWindowProperties {
  /**
   * Popup dimension for a creative. This is a read-only field. Applicable to
   * the following creative types: all RICH_MEDIA and all VPAID
   */
  Size dimension;
  /**
   * Upper-left corner coordinates of the popup window. Applicable if
   * positionType is COORDINATES.
   */
  OffsetPosition offset;
  /**
   * Popup window position either centered or at specific coordinate.
   * Possible string values are:
   * - "CENTER"
   * - "COORDINATES"
   */
  core.String positionType;
  /** Whether to display the browser address bar. */
  core.bool showAddressBar;
  /** Whether to display the browser menu bar. */
  core.bool showMenuBar;
  /** Whether to display the browser scroll bar. */
  core.bool showScrollBar;
  /** Whether to display the browser status bar. */
  core.bool showStatusBar;
  /** Whether to display the browser tool bar. */
  core.bool showToolBar;
  /** Title of popup window. */
  core.String title;

  PopupWindowProperties();

  PopupWindowProperties.fromJson(core.Map _json) {
    if (_json.containsKey("dimension")) {
      dimension = new Size.fromJson(_json["dimension"]);
    }
    if (_json.containsKey("offset")) {
      offset = new OffsetPosition.fromJson(_json["offset"]);
    }
    if (_json.containsKey("positionType")) {
      positionType = _json["positionType"];
    }
    if (_json.containsKey("showAddressBar")) {
      showAddressBar = _json["showAddressBar"];
    }
    if (_json.containsKey("showMenuBar")) {
      showMenuBar = _json["showMenuBar"];
    }
    if (_json.containsKey("showScrollBar")) {
      showScrollBar = _json["showScrollBar"];
    }
    if (_json.containsKey("showStatusBar")) {
      showStatusBar = _json["showStatusBar"];
    }
    if (_json.containsKey("showToolBar")) {
      showToolBar = _json["showToolBar"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimension != null) {
      _json["dimension"] = (dimension).toJson();
    }
    if (offset != null) {
      _json["offset"] = (offset).toJson();
    }
    if (positionType != null) {
      _json["positionType"] = positionType;
    }
    if (showAddressBar != null) {
      _json["showAddressBar"] = showAddressBar;
    }
    if (showMenuBar != null) {
      _json["showMenuBar"] = showMenuBar;
    }
    if (showScrollBar != null) {
      _json["showScrollBar"] = showScrollBar;
    }
    if (showStatusBar != null) {
      _json["showStatusBar"] = showStatusBar;
    }
    if (showToolBar != null) {
      _json["showToolBar"] = showToolBar;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Contains information about a postal code that can be targeted by ads. */
class PostalCode {
  /** Postal code. This is equivalent to the id field. */
  core.String code;
  /** Country code of the country to which this postal code belongs. */
  core.String countryCode;
  /** DART ID of the country to which this postal code belongs. */
  core.String countryDartId;
  /** ID of this postal code. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#postalCode".
   */
  core.String kind;

  PostalCode();

  PostalCode.fromJson(core.Map _json) {
    if (_json.containsKey("code")) {
      code = _json["code"];
    }
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("countryDartId")) {
      countryDartId = _json["countryDartId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (code != null) {
      _json["code"] = code;
    }
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (countryDartId != null) {
      _json["countryDartId"] = countryDartId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Postal Code List Response */
class PostalCodesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#postalCodesListResponse".
   */
  core.String kind;
  /** Postal code collection. */
  core.List<PostalCode> postalCodes;

  PostalCodesListResponse();

  PostalCodesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("postalCodes")) {
      postalCodes = _json["postalCodes"].map((value) => new PostalCode.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (postalCodes != null) {
      _json["postalCodes"] = postalCodes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Pricing Information */
class Pricing {
  /**
   * Cap cost type of this inventory item.
   * Possible string values are:
   * - "PLANNING_PLACEMENT_CAP_COST_TYPE_CUMULATIVE"
   * - "PLANNING_PLACEMENT_CAP_COST_TYPE_MONTHLY"
   * - "PLANNING_PLACEMENT_CAP_COST_TYPE_NONE"
   */
  core.String capCostType;
  /** End date of this inventory item. */
  core.DateTime endDate;
  /**
   * Flights of this inventory item. A flight (a.k.a. pricing period) represents
   * the inventory item pricing information for a specific period of time.
   */
  core.List<Flight> flights;
  /**
   * Group type of this inventory item if it represents a placement group. Is
   * null otherwise. There are two type of placement groups:
   * PLANNING_PLACEMENT_GROUP_TYPE_PACKAGE is a simple group of inventory items
   * that acts as a single pricing point for a group of tags.
   * PLANNING_PLACEMENT_GROUP_TYPE_ROADBLOCK is a group of inventory items that
   * not only acts as a single pricing point, but also assumes that all the tags
   * in it will be served at the same time. A roadblock requires one of its
   * assigned inventory items to be marked as primary.
   * Possible string values are:
   * - "PLANNING_PLACEMENT_GROUP_TYPE_PACKAGE"
   * - "PLANNING_PLACEMENT_GROUP_TYPE_ROADBLOCK"
   */
  core.String groupType;
  /**
   * Pricing type of this inventory item.
   * Possible string values are:
   * - "PLANNING_PLACEMENT_PRICING_TYPE_CLICKS"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_CPA"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_CPC"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_CPM"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_CPM_ACTIVEVIEW"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_FLAT_RATE_CLICKS"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_FLAT_RATE_IMPRESSIONS"
   * - "PLANNING_PLACEMENT_PRICING_TYPE_IMPRESSIONS"
   */
  core.String pricingType;
  /** Start date of this inventory item. */
  core.DateTime startDate;

  Pricing();

  Pricing.fromJson(core.Map _json) {
    if (_json.containsKey("capCostType")) {
      capCostType = _json["capCostType"];
    }
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("flights")) {
      flights = _json["flights"].map((value) => new Flight.fromJson(value)).toList();
    }
    if (_json.containsKey("groupType")) {
      groupType = _json["groupType"];
    }
    if (_json.containsKey("pricingType")) {
      pricingType = _json["pricingType"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (capCostType != null) {
      _json["capCostType"] = capCostType;
    }
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (flights != null) {
      _json["flights"] = flights.map((value) => (value).toJson()).toList();
    }
    if (groupType != null) {
      _json["groupType"] = groupType;
    }
    if (pricingType != null) {
      _json["pricingType"] = pricingType;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    return _json;
  }
}

/** Pricing Schedule */
class PricingSchedule {
  /**
   * Placement cap cost option.
   * Possible string values are:
   * - "CAP_COST_CUMULATIVE"
   * - "CAP_COST_MONTHLY"
   * - "CAP_COST_NONE"
   */
  core.String capCostOption;
  /** Whether cap costs are ignored by ad serving. */
  core.bool disregardOverdelivery;
  /**
   * Placement end date. This date must be later than, or the same day as, the
   * placement start date, but not later than the campaign end date. If, for
   * example, you set 6/25/2015 as both the start and end dates, the effective
   * placement date is just that day only, 6/25/2015. The hours, minutes, and
   * seconds of the end date should not be set, as doing so will result in an
   * error. This field is required on insertion.
   */
  core.DateTime endDate;
  /**
   * Whether this placement is flighted. If true, pricing periods will be
   * computed automatically.
   */
  core.bool flighted;
  /**
   * Floodlight activity ID associated with this placement. This field should be
   * set when placement pricing type is set to PRICING_TYPE_CPA.
   */
  core.String floodlightActivityId;
  /** Pricing periods for this placement. */
  core.List<PricingSchedulePricingPeriod> pricingPeriods;
  /**
   * Placement pricing type. This field is required on insertion.
   * Possible string values are:
   * - "PRICING_TYPE_CPA"
   * - "PRICING_TYPE_CPC"
   * - "PRICING_TYPE_CPM"
   * - "PRICING_TYPE_CPM_ACTIVEVIEW"
   * - "PRICING_TYPE_FLAT_RATE_CLICKS"
   * - "PRICING_TYPE_FLAT_RATE_IMPRESSIONS"
   */
  core.String pricingType;
  /**
   * Placement start date. This date must be later than, or the same day as, the
   * campaign start date. The hours, minutes, and seconds of the start date
   * should not be set, as doing so will result in an error. This field is
   * required on insertion.
   */
  core.DateTime startDate;
  /**
   * Testing start date of this placement. The hours, minutes, and seconds of
   * the start date should not be set, as doing so will result in an error.
   */
  core.DateTime testingStartDate;

  PricingSchedule();

  PricingSchedule.fromJson(core.Map _json) {
    if (_json.containsKey("capCostOption")) {
      capCostOption = _json["capCostOption"];
    }
    if (_json.containsKey("disregardOverdelivery")) {
      disregardOverdelivery = _json["disregardOverdelivery"];
    }
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("flighted")) {
      flighted = _json["flighted"];
    }
    if (_json.containsKey("floodlightActivityId")) {
      floodlightActivityId = _json["floodlightActivityId"];
    }
    if (_json.containsKey("pricingPeriods")) {
      pricingPeriods = _json["pricingPeriods"].map((value) => new PricingSchedulePricingPeriod.fromJson(value)).toList();
    }
    if (_json.containsKey("pricingType")) {
      pricingType = _json["pricingType"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("testingStartDate")) {
      testingStartDate = core.DateTime.parse(_json["testingStartDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (capCostOption != null) {
      _json["capCostOption"] = capCostOption;
    }
    if (disregardOverdelivery != null) {
      _json["disregardOverdelivery"] = disregardOverdelivery;
    }
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (flighted != null) {
      _json["flighted"] = flighted;
    }
    if (floodlightActivityId != null) {
      _json["floodlightActivityId"] = floodlightActivityId;
    }
    if (pricingPeriods != null) {
      _json["pricingPeriods"] = pricingPeriods.map((value) => (value).toJson()).toList();
    }
    if (pricingType != null) {
      _json["pricingType"] = pricingType;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    if (testingStartDate != null) {
      _json["testingStartDate"] = "${(testingStartDate).year.toString().padLeft(4, '0')}-${(testingStartDate).month.toString().padLeft(2, '0')}-${(testingStartDate).day.toString().padLeft(2, '0')}";
    }
    return _json;
  }
}

/** Pricing Period */
class PricingSchedulePricingPeriod {
  /**
   * Pricing period end date. This date must be later than, or the same day as,
   * the pricing period start date, but not later than the placement end date.
   * The period end date can be the same date as the period start date. If, for
   * example, you set 6/25/2015 as both the start and end dates, the effective
   * pricing period date is just that day only, 6/25/2015. The hours, minutes,
   * and seconds of the end date should not be set, as doing so will result in
   * an error.
   */
  core.DateTime endDate;
  /** Comments for this pricing period. */
  core.String pricingComment;
  /** Rate or cost of this pricing period. */
  core.String rateOrCostNanos;
  /**
   * Pricing period start date. This date must be later than, or the same day
   * as, the placement start date. The hours, minutes, and seconds of the start
   * date should not be set, as doing so will result in an error.
   */
  core.DateTime startDate;
  /** Units of this pricing period. */
  core.String units;

  PricingSchedulePricingPeriod();

  PricingSchedulePricingPeriod.fromJson(core.Map _json) {
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("pricingComment")) {
      pricingComment = _json["pricingComment"];
    }
    if (_json.containsKey("rateOrCostNanos")) {
      rateOrCostNanos = _json["rateOrCostNanos"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("units")) {
      units = _json["units"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (pricingComment != null) {
      _json["pricingComment"] = pricingComment;
    }
    if (rateOrCostNanos != null) {
      _json["rateOrCostNanos"] = rateOrCostNanos;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    if (units != null) {
      _json["units"] = units;
    }
    return _json;
  }
}

/** Contains properties of a DoubleClick Planning project. */
class Project {
  /** Account ID of this project. */
  core.String accountId;
  /** Advertiser ID of this project. */
  core.String advertiserId;
  /**
   * Audience age group of this project.
   * Possible string values are:
   * - "PLANNING_AUDIENCE_AGE_18_24"
   * - "PLANNING_AUDIENCE_AGE_25_34"
   * - "PLANNING_AUDIENCE_AGE_35_44"
   * - "PLANNING_AUDIENCE_AGE_45_54"
   * - "PLANNING_AUDIENCE_AGE_55_64"
   * - "PLANNING_AUDIENCE_AGE_65_OR_MORE"
   * - "PLANNING_AUDIENCE_AGE_UNKNOWN"
   */
  core.String audienceAgeGroup;
  /**
   * Audience gender of this project.
   * Possible string values are:
   * - "PLANNING_AUDIENCE_GENDER_FEMALE"
   * - "PLANNING_AUDIENCE_GENDER_MALE"
   */
  core.String audienceGender;
  /**
   * Budget of this project in the currency specified by the current account.
   * The value stored in this field represents only the non-fractional amount.
   * For example, for USD, the smallest value that can be represented by this
   * field is 1 US dollar.
   */
  core.String budget;
  /** Client billing code of this project. */
  core.String clientBillingCode;
  /** Name of the project client. */
  core.String clientName;
  /** End date of the project. */
  core.DateTime endDate;
  /** ID of this project. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#project".
   */
  core.String kind;
  /** Information about the most recent modification of this project. */
  LastModifiedInfo lastModifiedInfo;
  /** Name of this project. */
  core.String name;
  /** Overview of this project. */
  core.String overview;
  /** Start date of the project. */
  core.DateTime startDate;
  /** Subaccount ID of this project. */
  core.String subaccountId;
  /** Number of clicks that the advertiser is targeting. */
  core.String targetClicks;
  /** Number of conversions that the advertiser is targeting. */
  core.String targetConversions;
  /** CPA that the advertiser is targeting. */
  core.String targetCpaNanos;
  /** CPC that the advertiser is targeting. */
  core.String targetCpcNanos;
  /** vCPM from Active View that the advertiser is targeting. */
  core.String targetCpmActiveViewNanos;
  /** CPM that the advertiser is targeting. */
  core.String targetCpmNanos;
  /** Number of impressions that the advertiser is targeting. */
  core.String targetImpressions;

  Project();

  Project.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("audienceAgeGroup")) {
      audienceAgeGroup = _json["audienceAgeGroup"];
    }
    if (_json.containsKey("audienceGender")) {
      audienceGender = _json["audienceGender"];
    }
    if (_json.containsKey("budget")) {
      budget = _json["budget"];
    }
    if (_json.containsKey("clientBillingCode")) {
      clientBillingCode = _json["clientBillingCode"];
    }
    if (_json.containsKey("clientName")) {
      clientName = _json["clientName"];
    }
    if (_json.containsKey("endDate")) {
      endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedInfo")) {
      lastModifiedInfo = new LastModifiedInfo.fromJson(_json["lastModifiedInfo"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("overview")) {
      overview = _json["overview"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("targetClicks")) {
      targetClicks = _json["targetClicks"];
    }
    if (_json.containsKey("targetConversions")) {
      targetConversions = _json["targetConversions"];
    }
    if (_json.containsKey("targetCpaNanos")) {
      targetCpaNanos = _json["targetCpaNanos"];
    }
    if (_json.containsKey("targetCpcNanos")) {
      targetCpcNanos = _json["targetCpcNanos"];
    }
    if (_json.containsKey("targetCpmActiveViewNanos")) {
      targetCpmActiveViewNanos = _json["targetCpmActiveViewNanos"];
    }
    if (_json.containsKey("targetCpmNanos")) {
      targetCpmNanos = _json["targetCpmNanos"];
    }
    if (_json.containsKey("targetImpressions")) {
      targetImpressions = _json["targetImpressions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (audienceAgeGroup != null) {
      _json["audienceAgeGroup"] = audienceAgeGroup;
    }
    if (audienceGender != null) {
      _json["audienceGender"] = audienceGender;
    }
    if (budget != null) {
      _json["budget"] = budget;
    }
    if (clientBillingCode != null) {
      _json["clientBillingCode"] = clientBillingCode;
    }
    if (clientName != null) {
      _json["clientName"] = clientName;
    }
    if (endDate != null) {
      _json["endDate"] = "${(endDate).year.toString().padLeft(4, '0')}-${(endDate).month.toString().padLeft(2, '0')}-${(endDate).day.toString().padLeft(2, '0')}";
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedInfo != null) {
      _json["lastModifiedInfo"] = (lastModifiedInfo).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (overview != null) {
      _json["overview"] = overview;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (targetClicks != null) {
      _json["targetClicks"] = targetClicks;
    }
    if (targetConversions != null) {
      _json["targetConversions"] = targetConversions;
    }
    if (targetCpaNanos != null) {
      _json["targetCpaNanos"] = targetCpaNanos;
    }
    if (targetCpcNanos != null) {
      _json["targetCpcNanos"] = targetCpcNanos;
    }
    if (targetCpmActiveViewNanos != null) {
      _json["targetCpmActiveViewNanos"] = targetCpmActiveViewNanos;
    }
    if (targetCpmNanos != null) {
      _json["targetCpmNanos"] = targetCpmNanos;
    }
    if (targetImpressions != null) {
      _json["targetImpressions"] = targetImpressions;
    }
    return _json;
  }
}

/** Project List Response */
class ProjectsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#projectsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Project collection. */
  core.List<Project> projects;

  ProjectsListResponse();

  ProjectsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("projects")) {
      projects = _json["projects"].map((value) => new Project.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (projects != null) {
      _json["projects"] = projects.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents fields that are compatible to be selected for a report of type
 * "REACH".
 */
class ReachReportCompatibleFields {
  /**
   * Dimensions which are compatible to be selected in the "dimensionFilters"
   * section of the report.
   */
  core.List<Dimension> dimensionFilters;
  /**
   * Dimensions which are compatible to be selected in the "dimensions" section
   * of the report.
   */
  core.List<Dimension> dimensions;
  /**
   * The kind of resource this is, in this case
   * dfareporting#reachReportCompatibleFields.
   */
  core.String kind;
  /**
   * Metrics which are compatible to be selected in the "metricNames" section of
   * the report.
   */
  core.List<Metric> metrics;
  /**
   * Metrics which are compatible to be selected as activity metrics to pivot on
   * in the "activities" section of the report.
   */
  core.List<Metric> pivotedActivityMetrics;
  /**
   * Metrics which are compatible to be selected in the
   * "reachByFrequencyMetricNames" section of the report.
   */
  core.List<Metric> reachByFrequencyMetrics;

  ReachReportCompatibleFields();

  ReachReportCompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("pivotedActivityMetrics")) {
      pivotedActivityMetrics = _json["pivotedActivityMetrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("reachByFrequencyMetrics")) {
      reachByFrequencyMetrics = _json["reachByFrequencyMetrics"].map((value) => new Metric.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (pivotedActivityMetrics != null) {
      _json["pivotedActivityMetrics"] = pivotedActivityMetrics.map((value) => (value).toJson()).toList();
    }
    if (reachByFrequencyMetrics != null) {
      _json["reachByFrequencyMetrics"] = reachByFrequencyMetrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Represents a recipient. */
class Recipient {
  /**
   * The delivery type for the recipient.
   * Possible string values are:
   * - "ATTACHMENT"
   * - "LINK"
   */
  core.String deliveryType;
  /** The email address of the recipient. */
  core.String email;
  /** The kind of resource this is, in this case dfareporting#recipient. */
  core.String kind;

  Recipient();

  Recipient.fromJson(core.Map _json) {
    if (_json.containsKey("deliveryType")) {
      deliveryType = _json["deliveryType"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deliveryType != null) {
      _json["deliveryType"] = deliveryType;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains information about a region that can be targeted by ads. */
class Region {
  /** Country code of the country to which this region belongs. */
  core.String countryCode;
  /** DART ID of the country to which this region belongs. */
  core.String countryDartId;
  /** DART ID of this region. */
  core.String dartId;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#region".
   */
  core.String kind;
  /** Name of this region. */
  core.String name;
  /** Region code. */
  core.String regionCode;

  Region();

  Region.fromJson(core.Map _json) {
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("countryDartId")) {
      countryDartId = _json["countryDartId"];
    }
    if (_json.containsKey("dartId")) {
      dartId = _json["dartId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("regionCode")) {
      regionCode = _json["regionCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (countryDartId != null) {
      _json["countryDartId"] = countryDartId;
    }
    if (dartId != null) {
      _json["dartId"] = dartId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (regionCode != null) {
      _json["regionCode"] = regionCode;
    }
    return _json;
  }
}

/** Region List Response */
class RegionsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#regionsListResponse".
   */
  core.String kind;
  /** Region collection. */
  core.List<Region> regions;

  RegionsListResponse();

  RegionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("regions")) {
      regions = _json["regions"].map((value) => new Region.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (regions != null) {
      _json["regions"] = regions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Contains properties of a remarketing list. Remarketing enables you to create
 * lists of users who have performed specific actions on a site, then target ads
 * to members of those lists. This resource can be used to manage remarketing
 * lists that are owned by your advertisers. To see all remarketing lists that
 * are visible to your advertisers, including those that are shared to your
 * advertiser or account, use the TargetableRemarketingLists resource.
 */
class RemarketingList {
  /**
   * Account ID of this remarketing list. This is a read-only, auto-generated
   * field that is only returned in GET requests.
   */
  core.String accountId;
  /** Whether this remarketing list is active. */
  core.bool active;
  /**
   * Dimension value for the advertiser ID that owns this remarketing list. This
   * is a required field.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Remarketing list description. */
  core.String description;
  /** Remarketing list ID. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#remarketingList".
   */
  core.String kind;
  /**
   * Number of days that a user should remain in the remarketing list without an
   * impression.
   */
  core.String lifeSpan;
  /** Rule used to populate the remarketing list with users. */
  ListPopulationRule listPopulationRule;
  /** Number of users currently in the list. This is a read-only field. */
  core.String listSize;
  /**
   * Product from which this remarketing list was originated.
   * Possible string values are:
   * - "REMARKETING_LIST_SOURCE_ADX"
   * - "REMARKETING_LIST_SOURCE_DBM"
   * - "REMARKETING_LIST_SOURCE_DFA"
   * - "REMARKETING_LIST_SOURCE_DFP"
   * - "REMARKETING_LIST_SOURCE_DMP"
   * - "REMARKETING_LIST_SOURCE_GA"
   * - "REMARKETING_LIST_SOURCE_GPLUS"
   * - "REMARKETING_LIST_SOURCE_OTHER"
   * - "REMARKETING_LIST_SOURCE_PLAY_STORE"
   * - "REMARKETING_LIST_SOURCE_XFP"
   * - "REMARKETING_LIST_SOURCE_YOUTUBE"
   */
  core.String listSource;
  /**
   * Name of the remarketing list. This is a required field. Must be no greater
   * than 128 characters long.
   */
  core.String name;
  /**
   * Subaccount ID of this remarketing list. This is a read-only, auto-generated
   * field that is only returned in GET requests.
   */
  core.String subaccountId;

  RemarketingList();

  RemarketingList.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lifeSpan")) {
      lifeSpan = _json["lifeSpan"];
    }
    if (_json.containsKey("listPopulationRule")) {
      listPopulationRule = new ListPopulationRule.fromJson(_json["listPopulationRule"]);
    }
    if (_json.containsKey("listSize")) {
      listSize = _json["listSize"];
    }
    if (_json.containsKey("listSource")) {
      listSource = _json["listSource"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lifeSpan != null) {
      _json["lifeSpan"] = lifeSpan;
    }
    if (listPopulationRule != null) {
      _json["listPopulationRule"] = (listPopulationRule).toJson();
    }
    if (listSize != null) {
      _json["listSize"] = listSize;
    }
    if (listSource != null) {
      _json["listSource"] = listSource;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/**
 * Contains properties of a remarketing list's sharing information. Sharing
 * allows other accounts or advertisers to target to your remarketing lists.
 * This resource can be used to manage remarketing list sharing to other
 * accounts and advertisers.
 */
class RemarketingListShare {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#remarketingListShare".
   */
  core.String kind;
  /** Remarketing list ID. This is a read-only, auto-generated field. */
  core.String remarketingListId;
  /** Accounts that the remarketing list is shared with. */
  core.List<core.String> sharedAccountIds;
  /** Advertisers that the remarketing list is shared with. */
  core.List<core.String> sharedAdvertiserIds;

  RemarketingListShare();

  RemarketingListShare.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("remarketingListId")) {
      remarketingListId = _json["remarketingListId"];
    }
    if (_json.containsKey("sharedAccountIds")) {
      sharedAccountIds = _json["sharedAccountIds"];
    }
    if (_json.containsKey("sharedAdvertiserIds")) {
      sharedAdvertiserIds = _json["sharedAdvertiserIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (remarketingListId != null) {
      _json["remarketingListId"] = remarketingListId;
    }
    if (sharedAccountIds != null) {
      _json["sharedAccountIds"] = sharedAccountIds;
    }
    if (sharedAdvertiserIds != null) {
      _json["sharedAdvertiserIds"] = sharedAdvertiserIds;
    }
    return _json;
  }
}

/** Remarketing list response */
class RemarketingListsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#remarketingListsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Remarketing list collection. */
  core.List<RemarketingList> remarketingLists;

  RemarketingListsListResponse();

  RemarketingListsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("remarketingLists")) {
      remarketingLists = _json["remarketingLists"].map((value) => new RemarketingList.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (remarketingLists != null) {
      _json["remarketingLists"] = remarketingLists.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The report criteria for a report of type "STANDARD". */
class ReportCriteria {
  /** Activity group. */
  Activities activities;
  /** Custom Rich Media Events group. */
  CustomRichMediaEvents customRichMediaEvents;
  /** The date range for which this report should be run. */
  DateRange dateRange;
  /**
   * The list of filters on which dimensions are filtered.
   * Filters for different dimensions are ANDed, filters for the same dimension
   * are grouped together and ORed.
   */
  core.List<DimensionValue> dimensionFilters;
  /** The list of standard dimensions the report should include. */
  core.List<SortedDimension> dimensions;
  /** The list of names of metrics the report should include. */
  core.List<core.String> metricNames;

  ReportCriteria();

  ReportCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("activities")) {
      activities = new Activities.fromJson(_json["activities"]);
    }
    if (_json.containsKey("customRichMediaEvents")) {
      customRichMediaEvents = new CustomRichMediaEvents.fromJson(_json["customRichMediaEvents"]);
    }
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activities != null) {
      _json["activities"] = (activities).toJson();
    }
    if (customRichMediaEvents != null) {
      _json["customRichMediaEvents"] = (customRichMediaEvents).toJson();
    }
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    return _json;
  }
}

/** The report criteria for a report of type "CROSS_DIMENSION_REACH". */
class ReportCrossDimensionReachCriteria {
  /** The list of dimensions the report should include. */
  core.List<SortedDimension> breakdown;
  /** The date range this report should be run for. */
  DateRange dateRange;
  /**
   * The dimension option.
   * Possible string values are:
   * - "ADVERTISER"
   * - "CAMPAIGN"
   * - "SITE_BY_ADVERTISER"
   * - "SITE_BY_CAMPAIGN"
   */
  core.String dimension;
  /** The list of filters on which dimensions are filtered. */
  core.List<DimensionValue> dimensionFilters;
  /** The list of names of metrics the report should include. */
  core.List<core.String> metricNames;
  /** The list of names of overlap metrics the report should include. */
  core.List<core.String> overlapMetricNames;
  /** Whether the report is pivoted or not. Defaults to true. */
  core.bool pivoted;

  ReportCrossDimensionReachCriteria();

  ReportCrossDimensionReachCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("breakdown")) {
      breakdown = _json["breakdown"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("dimension")) {
      dimension = _json["dimension"];
    }
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
    if (_json.containsKey("overlapMetricNames")) {
      overlapMetricNames = _json["overlapMetricNames"];
    }
    if (_json.containsKey("pivoted")) {
      pivoted = _json["pivoted"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (breakdown != null) {
      _json["breakdown"] = breakdown.map((value) => (value).toJson()).toList();
    }
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (dimension != null) {
      _json["dimension"] = dimension;
    }
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    if (overlapMetricNames != null) {
      _json["overlapMetricNames"] = overlapMetricNames;
    }
    if (pivoted != null) {
      _json["pivoted"] = pivoted;
    }
    return _json;
  }
}

/** The report's email delivery settings. */
class ReportDelivery {
  /** Whether the report should be emailed to the report owner. */
  core.bool emailOwner;
  /**
   * The type of delivery for the owner to receive, if enabled.
   * Possible string values are:
   * - "ATTACHMENT"
   * - "LINK"
   */
  core.String emailOwnerDeliveryType;
  /** The message to be sent with each email. */
  core.String message;
  /** The list of recipients to which to email the report. */
  core.List<Recipient> recipients;

  ReportDelivery();

  ReportDelivery.fromJson(core.Map _json) {
    if (_json.containsKey("emailOwner")) {
      emailOwner = _json["emailOwner"];
    }
    if (_json.containsKey("emailOwnerDeliveryType")) {
      emailOwnerDeliveryType = _json["emailOwnerDeliveryType"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("recipients")) {
      recipients = _json["recipients"].map((value) => new Recipient.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (emailOwner != null) {
      _json["emailOwner"] = emailOwner;
    }
    if (emailOwnerDeliveryType != null) {
      _json["emailOwnerDeliveryType"] = emailOwnerDeliveryType;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (recipients != null) {
      _json["recipients"] = recipients.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The properties of the report. */
class ReportFloodlightCriteriaReportProperties {
  /** Include conversions that have no cookie, but do have an exposure path. */
  core.bool includeAttributedIPConversions;
  /**
   * Include conversions of users with a DoubleClick cookie but without an
   * exposure. That means the user did not click or see an ad from the
   * advertiser within the Floodlight group, or that the interaction happened
   * outside the lookback window.
   */
  core.bool includeUnattributedCookieConversions;
  /**
   * Include conversions that have no associated cookies and no exposures. It’s
   * therefore impossible to know how the user was exposed to your ads during
   * the lookback window prior to a conversion.
   */
  core.bool includeUnattributedIPConversions;

  ReportFloodlightCriteriaReportProperties();

  ReportFloodlightCriteriaReportProperties.fromJson(core.Map _json) {
    if (_json.containsKey("includeAttributedIPConversions")) {
      includeAttributedIPConversions = _json["includeAttributedIPConversions"];
    }
    if (_json.containsKey("includeUnattributedCookieConversions")) {
      includeUnattributedCookieConversions = _json["includeUnattributedCookieConversions"];
    }
    if (_json.containsKey("includeUnattributedIPConversions")) {
      includeUnattributedIPConversions = _json["includeUnattributedIPConversions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (includeAttributedIPConversions != null) {
      _json["includeAttributedIPConversions"] = includeAttributedIPConversions;
    }
    if (includeUnattributedCookieConversions != null) {
      _json["includeUnattributedCookieConversions"] = includeUnattributedCookieConversions;
    }
    if (includeUnattributedIPConversions != null) {
      _json["includeUnattributedIPConversions"] = includeUnattributedIPConversions;
    }
    return _json;
  }
}

/** The report criteria for a report of type "FLOODLIGHT". */
class ReportFloodlightCriteria {
  /** The list of custom rich media events to include. */
  core.List<DimensionValue> customRichMediaEvents;
  /** The date range this report should be run for. */
  DateRange dateRange;
  /**
   * The list of filters on which dimensions are filtered.
   * Filters for different dimensions are ANDed, filters for the same dimension
   * are grouped together and ORed.
   */
  core.List<DimensionValue> dimensionFilters;
  /** The list of dimensions the report should include. */
  core.List<SortedDimension> dimensions;
  /**
   * The floodlight ID for which to show data in this report. All advertisers
   * associated with that ID will automatically be added. The dimension of the
   * value needs to be 'dfa:floodlightConfigId'.
   */
  DimensionValue floodlightConfigId;
  /** The list of names of metrics the report should include. */
  core.List<core.String> metricNames;
  /** The properties of the report. */
  ReportFloodlightCriteriaReportProperties reportProperties;

  ReportFloodlightCriteria();

  ReportFloodlightCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("customRichMediaEvents")) {
      customRichMediaEvents = _json["customRichMediaEvents"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("floodlightConfigId")) {
      floodlightConfigId = new DimensionValue.fromJson(_json["floodlightConfigId"]);
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
    if (_json.containsKey("reportProperties")) {
      reportProperties = new ReportFloodlightCriteriaReportProperties.fromJson(_json["reportProperties"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customRichMediaEvents != null) {
      _json["customRichMediaEvents"] = customRichMediaEvents.map((value) => (value).toJson()).toList();
    }
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (floodlightConfigId != null) {
      _json["floodlightConfigId"] = (floodlightConfigId).toJson();
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    if (reportProperties != null) {
      _json["reportProperties"] = (reportProperties).toJson();
    }
    return _json;
  }
}

/** The properties of the report. */
class ReportPathToConversionCriteriaReportProperties {
  /**
   * DFA checks to see if a click interaction occurred within the specified
   * period of time before a conversion. By default the value is pulled from
   * Floodlight or you can manually enter a custom value. Valid values: 1-90.
   */
  core.int clicksLookbackWindow;
  /**
   * DFA checks to see if an impression interaction occurred within the
   * specified period of time before a conversion. By default the value is
   * pulled from Floodlight or you can manually enter a custom value. Valid
   * values: 1-90.
   */
  core.int impressionsLookbackWindow;
  /** Deprecated: has no effect. */
  core.bool includeAttributedIPConversions;
  /**
   * Include conversions of users with a DoubleClick cookie but without an
   * exposure. That means the user did not click or see an ad from the
   * advertiser within the Floodlight group, or that the interaction happened
   * outside the lookback window.
   */
  core.bool includeUnattributedCookieConversions;
  /**
   * Include conversions that have no associated cookies and no exposures. It’s
   * therefore impossible to know how the user was exposed to your ads during
   * the lookback window prior to a conversion.
   */
  core.bool includeUnattributedIPConversions;
  /**
   * The maximum number of click interactions to include in the report.
   * Advertisers currently paying for E2C reports get up to 200 (100 clicks, 100
   * impressions). If another advertiser in your network is paying for E2C, you
   * can have up to 5 total exposures per report.
   */
  core.int maximumClickInteractions;
  /**
   * The maximum number of click interactions to include in the report.
   * Advertisers currently paying for E2C reports get up to 200 (100 clicks, 100
   * impressions). If another advertiser in your network is paying for E2C, you
   * can have up to 5 total exposures per report.
   */
  core.int maximumImpressionInteractions;
  /**
   * The maximum amount of time that can take place between interactions (clicks
   * or impressions) by the same user. Valid values: 1-90.
   */
  core.int maximumInteractionGap;
  /** Enable pivoting on interaction path. */
  core.bool pivotOnInteractionPath;

  ReportPathToConversionCriteriaReportProperties();

  ReportPathToConversionCriteriaReportProperties.fromJson(core.Map _json) {
    if (_json.containsKey("clicksLookbackWindow")) {
      clicksLookbackWindow = _json["clicksLookbackWindow"];
    }
    if (_json.containsKey("impressionsLookbackWindow")) {
      impressionsLookbackWindow = _json["impressionsLookbackWindow"];
    }
    if (_json.containsKey("includeAttributedIPConversions")) {
      includeAttributedIPConversions = _json["includeAttributedIPConversions"];
    }
    if (_json.containsKey("includeUnattributedCookieConversions")) {
      includeUnattributedCookieConversions = _json["includeUnattributedCookieConversions"];
    }
    if (_json.containsKey("includeUnattributedIPConversions")) {
      includeUnattributedIPConversions = _json["includeUnattributedIPConversions"];
    }
    if (_json.containsKey("maximumClickInteractions")) {
      maximumClickInteractions = _json["maximumClickInteractions"];
    }
    if (_json.containsKey("maximumImpressionInteractions")) {
      maximumImpressionInteractions = _json["maximumImpressionInteractions"];
    }
    if (_json.containsKey("maximumInteractionGap")) {
      maximumInteractionGap = _json["maximumInteractionGap"];
    }
    if (_json.containsKey("pivotOnInteractionPath")) {
      pivotOnInteractionPath = _json["pivotOnInteractionPath"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clicksLookbackWindow != null) {
      _json["clicksLookbackWindow"] = clicksLookbackWindow;
    }
    if (impressionsLookbackWindow != null) {
      _json["impressionsLookbackWindow"] = impressionsLookbackWindow;
    }
    if (includeAttributedIPConversions != null) {
      _json["includeAttributedIPConversions"] = includeAttributedIPConversions;
    }
    if (includeUnattributedCookieConversions != null) {
      _json["includeUnattributedCookieConversions"] = includeUnattributedCookieConversions;
    }
    if (includeUnattributedIPConversions != null) {
      _json["includeUnattributedIPConversions"] = includeUnattributedIPConversions;
    }
    if (maximumClickInteractions != null) {
      _json["maximumClickInteractions"] = maximumClickInteractions;
    }
    if (maximumImpressionInteractions != null) {
      _json["maximumImpressionInteractions"] = maximumImpressionInteractions;
    }
    if (maximumInteractionGap != null) {
      _json["maximumInteractionGap"] = maximumInteractionGap;
    }
    if (pivotOnInteractionPath != null) {
      _json["pivotOnInteractionPath"] = pivotOnInteractionPath;
    }
    return _json;
  }
}

/** The report criteria for a report of type "PATH_TO_CONVERSION". */
class ReportPathToConversionCriteria {
  /** The list of 'dfa:activity' values to filter on. */
  core.List<DimensionValue> activityFilters;
  /** The list of conversion dimensions the report should include. */
  core.List<SortedDimension> conversionDimensions;
  /** The list of custom floodlight variables the report should include. */
  core.List<SortedDimension> customFloodlightVariables;
  /** The list of custom rich media events to include. */
  core.List<DimensionValue> customRichMediaEvents;
  /** The date range this report should be run for. */
  DateRange dateRange;
  /**
   * The floodlight ID for which to show data in this report. All advertisers
   * associated with that ID will automatically be added. The dimension of the
   * value needs to be 'dfa:floodlightConfigId'.
   */
  DimensionValue floodlightConfigId;
  /** The list of names of metrics the report should include. */
  core.List<core.String> metricNames;
  /** The list of per interaction dimensions the report should include. */
  core.List<SortedDimension> perInteractionDimensions;
  /** The properties of the report. */
  ReportPathToConversionCriteriaReportProperties reportProperties;

  ReportPathToConversionCriteria();

  ReportPathToConversionCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("activityFilters")) {
      activityFilters = _json["activityFilters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("conversionDimensions")) {
      conversionDimensions = _json["conversionDimensions"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("customFloodlightVariables")) {
      customFloodlightVariables = _json["customFloodlightVariables"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("customRichMediaEvents")) {
      customRichMediaEvents = _json["customRichMediaEvents"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("floodlightConfigId")) {
      floodlightConfigId = new DimensionValue.fromJson(_json["floodlightConfigId"]);
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
    if (_json.containsKey("perInteractionDimensions")) {
      perInteractionDimensions = _json["perInteractionDimensions"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("reportProperties")) {
      reportProperties = new ReportPathToConversionCriteriaReportProperties.fromJson(_json["reportProperties"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activityFilters != null) {
      _json["activityFilters"] = activityFilters.map((value) => (value).toJson()).toList();
    }
    if (conversionDimensions != null) {
      _json["conversionDimensions"] = conversionDimensions.map((value) => (value).toJson()).toList();
    }
    if (customFloodlightVariables != null) {
      _json["customFloodlightVariables"] = customFloodlightVariables.map((value) => (value).toJson()).toList();
    }
    if (customRichMediaEvents != null) {
      _json["customRichMediaEvents"] = customRichMediaEvents.map((value) => (value).toJson()).toList();
    }
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (floodlightConfigId != null) {
      _json["floodlightConfigId"] = (floodlightConfigId).toJson();
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    if (perInteractionDimensions != null) {
      _json["perInteractionDimensions"] = perInteractionDimensions.map((value) => (value).toJson()).toList();
    }
    if (reportProperties != null) {
      _json["reportProperties"] = (reportProperties).toJson();
    }
    return _json;
  }
}

/** The report criteria for a report of type "REACH". */
class ReportReachCriteria {
  /** Activity group. */
  Activities activities;
  /** Custom Rich Media Events group. */
  CustomRichMediaEvents customRichMediaEvents;
  /** The date range this report should be run for. */
  DateRange dateRange;
  /**
   * The list of filters on which dimensions are filtered.
   * Filters for different dimensions are ANDed, filters for the same dimension
   * are grouped together and ORed.
   */
  core.List<DimensionValue> dimensionFilters;
  /** The list of dimensions the report should include. */
  core.List<SortedDimension> dimensions;
  /**
   * Whether to enable all reach dimension combinations in the report. Defaults
   * to false. If enabled, the date range of the report should be within the
   * last three months.
   */
  core.bool enableAllDimensionCombinations;
  /** The list of names of metrics the report should include. */
  core.List<core.String> metricNames;
  /**
   * The list of names of  Reach By Frequency metrics the report should include.
   */
  core.List<core.String> reachByFrequencyMetricNames;

  ReportReachCriteria();

  ReportReachCriteria.fromJson(core.Map _json) {
    if (_json.containsKey("activities")) {
      activities = new Activities.fromJson(_json["activities"]);
    }
    if (_json.containsKey("customRichMediaEvents")) {
      customRichMediaEvents = new CustomRichMediaEvents.fromJson(_json["customRichMediaEvents"]);
    }
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new DimensionValue.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new SortedDimension.fromJson(value)).toList();
    }
    if (_json.containsKey("enableAllDimensionCombinations")) {
      enableAllDimensionCombinations = _json["enableAllDimensionCombinations"];
    }
    if (_json.containsKey("metricNames")) {
      metricNames = _json["metricNames"];
    }
    if (_json.containsKey("reachByFrequencyMetricNames")) {
      reachByFrequencyMetricNames = _json["reachByFrequencyMetricNames"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activities != null) {
      _json["activities"] = (activities).toJson();
    }
    if (customRichMediaEvents != null) {
      _json["customRichMediaEvents"] = (customRichMediaEvents).toJson();
    }
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (enableAllDimensionCombinations != null) {
      _json["enableAllDimensionCombinations"] = enableAllDimensionCombinations;
    }
    if (metricNames != null) {
      _json["metricNames"] = metricNames;
    }
    if (reachByFrequencyMetricNames != null) {
      _json["reachByFrequencyMetricNames"] = reachByFrequencyMetricNames;
    }
    return _json;
  }
}

/**
 * The report's schedule. Can only be set if the report's 'dateRange' is a
 * relative date range and the relative date range is not "TODAY".
 */
class ReportSchedule {
  /**
   * Whether the schedule is active or not. Must be set to either true or false.
   */
  core.bool active;
  /**
   * Defines every how many days, weeks or months the report should be run.
   * Needs to be set when "repeats" is either "DAILY", "WEEKLY" or "MONTHLY".
   */
  core.int every;
  /** The expiration date when the scheduled report stops running. */
  core.DateTime expirationDate;
  /**
   * The interval for which the report is repeated. Note:
   * - "DAILY" also requires field "every" to be set.
   * - "WEEKLY" also requires fields "every" and "repeatsOnWeekDays" to be set.
   * - "MONTHLY" also requires fields "every" and "runsOnDayOfMonth" to be set.
   */
  core.String repeats;
  /** List of week days "WEEKLY" on which scheduled reports should run. */
  core.List<core.String> repeatsOnWeekDays;
  /**
   * Enum to define for "MONTHLY" scheduled reports whether reports should be
   * repeated on the same day of the month as "startDate" or the same day of the
   * week of the month.
   * Example: If 'startDate' is Monday, April 2nd 2012 (2012-04-02),
   * "DAY_OF_MONTH" would run subsequent reports on the 2nd of every Month, and
   * "WEEK_OF_MONTH" would run subsequent reports on the first Monday of the
   * month.
   * Possible string values are:
   * - "DAY_OF_MONTH"
   * - "WEEK_OF_MONTH"
   */
  core.String runsOnDayOfMonth;
  /** Start date of date range for which scheduled reports should be run. */
  core.DateTime startDate;

  ReportSchedule();

  ReportSchedule.fromJson(core.Map _json) {
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("every")) {
      every = _json["every"];
    }
    if (_json.containsKey("expirationDate")) {
      expirationDate = core.DateTime.parse(_json["expirationDate"]);
    }
    if (_json.containsKey("repeats")) {
      repeats = _json["repeats"];
    }
    if (_json.containsKey("repeatsOnWeekDays")) {
      repeatsOnWeekDays = _json["repeatsOnWeekDays"];
    }
    if (_json.containsKey("runsOnDayOfMonth")) {
      runsOnDayOfMonth = _json["runsOnDayOfMonth"];
    }
    if (_json.containsKey("startDate")) {
      startDate = core.DateTime.parse(_json["startDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (active != null) {
      _json["active"] = active;
    }
    if (every != null) {
      _json["every"] = every;
    }
    if (expirationDate != null) {
      _json["expirationDate"] = "${(expirationDate).year.toString().padLeft(4, '0')}-${(expirationDate).month.toString().padLeft(2, '0')}-${(expirationDate).day.toString().padLeft(2, '0')}";
    }
    if (repeats != null) {
      _json["repeats"] = repeats;
    }
    if (repeatsOnWeekDays != null) {
      _json["repeatsOnWeekDays"] = repeatsOnWeekDays;
    }
    if (runsOnDayOfMonth != null) {
      _json["runsOnDayOfMonth"] = runsOnDayOfMonth;
    }
    if (startDate != null) {
      _json["startDate"] = "${(startDate).year.toString().padLeft(4, '0')}-${(startDate).month.toString().padLeft(2, '0')}-${(startDate).day.toString().padLeft(2, '0')}";
    }
    return _json;
  }
}

/** Represents a Report resource. */
class Report {
  /** The account ID to which this report belongs. */
  core.String accountId;
  /** The report criteria for a report of type "STANDARD". */
  ReportCriteria criteria;
  /** The report criteria for a report of type "CROSS_DIMENSION_REACH". */
  ReportCrossDimensionReachCriteria crossDimensionReachCriteria;
  /** The report's email delivery settings. */
  ReportDelivery delivery;
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The filename used when generating report files for this report. */
  core.String fileName;
  /** The report criteria for a report of type "FLOODLIGHT". */
  ReportFloodlightCriteria floodlightCriteria;
  /**
   * The output format of the report. If not specified, default format is "CSV".
   * Note that the actual format in the completed report file might differ if
   * for instance the report's size exceeds the format's capabilities. "CSV"
   * will then be the fallback format.
   * Possible string values are:
   * - "CSV"
   * - "EXCEL"
   */
  core.String format;
  /** The unique ID identifying this report resource. */
  core.String id;
  /** The kind of resource this is, in this case dfareporting#report. */
  core.String kind;
  /**
   * The timestamp (in milliseconds since epoch) of when this report was last
   * modified.
   */
  core.String lastModifiedTime;
  /** The name of the report. */
  core.String name;
  /** The user profile id of the owner of this report. */
  core.String ownerProfileId;
  /** The report criteria for a report of type "PATH_TO_CONVERSION". */
  ReportPathToConversionCriteria pathToConversionCriteria;
  /** The report criteria for a report of type "REACH". */
  ReportReachCriteria reachCriteria;
  /**
   * The report's schedule. Can only be set if the report's 'dateRange' is a
   * relative date range and the relative date range is not "TODAY".
   */
  ReportSchedule schedule;
  /** The subaccount ID to which this report belongs if applicable. */
  core.String subAccountId;
  /**
   * The type of the report.
   * Possible string values are:
   * - "CROSS_DIMENSION_REACH"
   * - "FLOODLIGHT"
   * - "PATH_TO_CONVERSION"
   * - "REACH"
   * - "STANDARD"
   */
  core.String type;

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("criteria")) {
      criteria = new ReportCriteria.fromJson(_json["criteria"]);
    }
    if (_json.containsKey("crossDimensionReachCriteria")) {
      crossDimensionReachCriteria = new ReportCrossDimensionReachCriteria.fromJson(_json["crossDimensionReachCriteria"]);
    }
    if (_json.containsKey("delivery")) {
      delivery = new ReportDelivery.fromJson(_json["delivery"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("floodlightCriteria")) {
      floodlightCriteria = new ReportFloodlightCriteria.fromJson(_json["floodlightCriteria"]);
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lastModifiedTime")) {
      lastModifiedTime = _json["lastModifiedTime"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ownerProfileId")) {
      ownerProfileId = _json["ownerProfileId"];
    }
    if (_json.containsKey("pathToConversionCriteria")) {
      pathToConversionCriteria = new ReportPathToConversionCriteria.fromJson(_json["pathToConversionCriteria"]);
    }
    if (_json.containsKey("reachCriteria")) {
      reachCriteria = new ReportReachCriteria.fromJson(_json["reachCriteria"]);
    }
    if (_json.containsKey("schedule")) {
      schedule = new ReportSchedule.fromJson(_json["schedule"]);
    }
    if (_json.containsKey("subAccountId")) {
      subAccountId = _json["subAccountId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (criteria != null) {
      _json["criteria"] = (criteria).toJson();
    }
    if (crossDimensionReachCriteria != null) {
      _json["crossDimensionReachCriteria"] = (crossDimensionReachCriteria).toJson();
    }
    if (delivery != null) {
      _json["delivery"] = (delivery).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (floodlightCriteria != null) {
      _json["floodlightCriteria"] = (floodlightCriteria).toJson();
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lastModifiedTime != null) {
      _json["lastModifiedTime"] = lastModifiedTime;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ownerProfileId != null) {
      _json["ownerProfileId"] = ownerProfileId;
    }
    if (pathToConversionCriteria != null) {
      _json["pathToConversionCriteria"] = (pathToConversionCriteria).toJson();
    }
    if (reachCriteria != null) {
      _json["reachCriteria"] = (reachCriteria).toJson();
    }
    if (schedule != null) {
      _json["schedule"] = (schedule).toJson();
    }
    if (subAccountId != null) {
      _json["subAccountId"] = subAccountId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Represents fields that are compatible to be selected for a report of type
 * "STANDARD".
 */
class ReportCompatibleFields {
  /**
   * Dimensions which are compatible to be selected in the "dimensionFilters"
   * section of the report.
   */
  core.List<Dimension> dimensionFilters;
  /**
   * Dimensions which are compatible to be selected in the "dimensions" section
   * of the report.
   */
  core.List<Dimension> dimensions;
  /**
   * The kind of resource this is, in this case
   * dfareporting#reportCompatibleFields.
   */
  core.String kind;
  /**
   * Metrics which are compatible to be selected in the "metricNames" section of
   * the report.
   */
  core.List<Metric> metrics;
  /**
   * Metrics which are compatible to be selected as activity metrics to pivot on
   * in the "activities" section of the report.
   */
  core.List<Metric> pivotedActivityMetrics;

  ReportCompatibleFields();

  ReportCompatibleFields.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionFilters")) {
      dimensionFilters = _json["dimensionFilters"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("pivotedActivityMetrics")) {
      pivotedActivityMetrics = _json["pivotedActivityMetrics"].map((value) => new Metric.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionFilters != null) {
      _json["dimensionFilters"] = dimensionFilters.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (pivotedActivityMetrics != null) {
      _json["pivotedActivityMetrics"] = pivotedActivityMetrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Represents the list of reports. */
class ReportList {
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The reports returned in this response. */
  core.List<Report> items;
  /** The kind of list this is, in this case dfareporting#reportList. */
  core.String kind;
  /**
   * Continuation token used to page through reports. To retrieve the next page
   * of results, set the next request's "pageToken" to the value of this field.
   * The page token is only valid for a limited amount of time and should not be
   * persisted.
   */
  core.String nextPageToken;

  ReportList();

  ReportList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Report.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Reporting Configuration */
class ReportsConfiguration {
  /**
   * Whether the exposure to conversion report is enabled. This report shows
   * detailed pathway information on up to 10 of the most recent ad exposures
   * seen by a user before converting.
   */
  core.bool exposureToConversionEnabled;
  /** Default lookback windows for new advertisers in this account. */
  LookbackConfiguration lookbackConfiguration;
  /**
   * Report generation time zone ID of this account. This is a required field
   * that can only be changed by a superuser.
   * Acceptable values are:
   *
   * - "1" for "America/New_York"
   * - "2" for "Europe/London"
   * - "3" for "Europe/Paris"
   * - "4" for "Africa/Johannesburg"
   * - "5" for "Asia/Jerusalem"
   * - "6" for "Asia/Shanghai"
   * - "7" for "Asia/Hong_Kong"
   * - "8" for "Asia/Tokyo"
   * - "9" for "Australia/Sydney"
   * - "10" for "Asia/Dubai"
   * - "11" for "America/Los_Angeles"
   * - "12" for "Pacific/Auckland"
   * - "13" for "America/Sao_Paulo"
   */
  core.String reportGenerationTimeZoneId;

  ReportsConfiguration();

  ReportsConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("exposureToConversionEnabled")) {
      exposureToConversionEnabled = _json["exposureToConversionEnabled"];
    }
    if (_json.containsKey("lookbackConfiguration")) {
      lookbackConfiguration = new LookbackConfiguration.fromJson(_json["lookbackConfiguration"]);
    }
    if (_json.containsKey("reportGenerationTimeZoneId")) {
      reportGenerationTimeZoneId = _json["reportGenerationTimeZoneId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exposureToConversionEnabled != null) {
      _json["exposureToConversionEnabled"] = exposureToConversionEnabled;
    }
    if (lookbackConfiguration != null) {
      _json["lookbackConfiguration"] = (lookbackConfiguration).toJson();
    }
    if (reportGenerationTimeZoneId != null) {
      _json["reportGenerationTimeZoneId"] = reportGenerationTimeZoneId;
    }
    return _json;
  }
}

/** Rich Media Exit Override. */
class RichMediaExitOverride {
  /**
   * Click-through URL of this rich media exit override. Applicable if the
   * enabled field is set to true.
   */
  ClickThroughUrl clickThroughUrl;
  /**
   * Whether to use the clickThroughUrl. If false, the creative-level exit will
   * be used.
   */
  core.bool enabled;
  /** ID for the override to refer to a specific exit in the creative. */
  core.String exitId;

  RichMediaExitOverride();

  RichMediaExitOverride.fromJson(core.Map _json) {
    if (_json.containsKey("clickThroughUrl")) {
      clickThroughUrl = new ClickThroughUrl.fromJson(_json["clickThroughUrl"]);
    }
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
    if (_json.containsKey("exitId")) {
      exitId = _json["exitId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clickThroughUrl != null) {
      _json["clickThroughUrl"] = (clickThroughUrl).toJson();
    }
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    if (exitId != null) {
      _json["exitId"] = exitId;
    }
    return _json;
  }
}

/**
 * A rule associates an asset with a targeting template for asset-level
 * targeting. Applicable to INSTREAM_VIDEO creatives.
 */
class Rule {
  /**
   * A creativeAssets[].id. This should refer to one of the parent assets in
   * this creative. This is a required field.
   */
  core.String assetId;
  /** A user-friendly name for this rule. This is a required field. */
  core.String name;
  /**
   * A targeting template ID. The targeting from the targeting template will be
   * used to determine whether this asset should be served. This is a required
   * field.
   */
  core.String targetingTemplateId;

  Rule();

  Rule.fromJson(core.Map _json) {
    if (_json.containsKey("assetId")) {
      assetId = _json["assetId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("targetingTemplateId")) {
      targetingTemplateId = _json["targetingTemplateId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (assetId != null) {
      _json["assetId"] = assetId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (targetingTemplateId != null) {
      _json["targetingTemplateId"] = targetingTemplateId;
    }
    return _json;
  }
}

/** Contains properties of a site. */
class Site {
  /**
   * Account ID of this site. This is a read-only field that can be left blank.
   */
  core.String accountId;
  /** Whether this site is approved. */
  core.bool approved;
  /**
   * Directory site associated with this site. This is a required field that is
   * read-only after insertion.
   */
  core.String directorySiteId;
  /**
   * Dimension value for the ID of the directory site. This is a read-only,
   * auto-generated field.
   */
  DimensionValue directorySiteIdDimensionValue;
  /** ID of this site. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Dimension value for the ID of this site. This is a read-only,
   * auto-generated field.
   */
  DimensionValue idDimensionValue;
  /** Key name of this site. This is a read-only, auto-generated field. */
  core.String keyName;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#site".
   */
  core.String kind;
  /**
   * Name of this site.This is a required field. Must be less than 128
   * characters long. If this site is under a subaccount, the name must be
   * unique among sites of the same subaccount. Otherwise, this site is a
   * top-level site, and the name must be unique among top-level sites of the
   * same account.
   */
  core.String name;
  /** Site contacts. */
  core.List<SiteContact> siteContacts;
  /** Site-wide settings. */
  SiteSettings siteSettings;
  /**
   * Subaccount ID of this site. This is a read-only field that can be left
   * blank.
   */
  core.String subaccountId;

  Site();

  Site.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("approved")) {
      approved = _json["approved"];
    }
    if (_json.containsKey("directorySiteId")) {
      directorySiteId = _json["directorySiteId"];
    }
    if (_json.containsKey("directorySiteIdDimensionValue")) {
      directorySiteIdDimensionValue = new DimensionValue.fromJson(_json["directorySiteIdDimensionValue"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("idDimensionValue")) {
      idDimensionValue = new DimensionValue.fromJson(_json["idDimensionValue"]);
    }
    if (_json.containsKey("keyName")) {
      keyName = _json["keyName"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("siteContacts")) {
      siteContacts = _json["siteContacts"].map((value) => new SiteContact.fromJson(value)).toList();
    }
    if (_json.containsKey("siteSettings")) {
      siteSettings = new SiteSettings.fromJson(_json["siteSettings"]);
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (approved != null) {
      _json["approved"] = approved;
    }
    if (directorySiteId != null) {
      _json["directorySiteId"] = directorySiteId;
    }
    if (directorySiteIdDimensionValue != null) {
      _json["directorySiteIdDimensionValue"] = (directorySiteIdDimensionValue).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (idDimensionValue != null) {
      _json["idDimensionValue"] = (idDimensionValue).toJson();
    }
    if (keyName != null) {
      _json["keyName"] = keyName;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (siteContacts != null) {
      _json["siteContacts"] = siteContacts.map((value) => (value).toJson()).toList();
    }
    if (siteSettings != null) {
      _json["siteSettings"] = (siteSettings).toJson();
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Site Contact */
class SiteContact {
  /** Address of this site contact. */
  core.String address;
  /**
   * Site contact type.
   * Possible string values are:
   * - "SALES_PERSON"
   * - "TRAFFICKER"
   */
  core.String contactType;
  /** Email address of this site contact. This is a required field. */
  core.String email;
  /** First name of this site contact. */
  core.String firstName;
  /** ID of this site contact. This is a read-only, auto-generated field. */
  core.String id;
  /** Last name of this site contact. */
  core.String lastName;
  /** Primary phone number of this site contact. */
  core.String phone;
  /** Title or designation of this site contact. */
  core.String title;

  SiteContact();

  SiteContact.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("contactType")) {
      contactType = _json["contactType"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("firstName")) {
      firstName = _json["firstName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("lastName")) {
      lastName = _json["lastName"];
    }
    if (_json.containsKey("phone")) {
      phone = _json["phone"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (contactType != null) {
      _json["contactType"] = contactType;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (firstName != null) {
      _json["firstName"] = firstName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (lastName != null) {
      _json["lastName"] = lastName;
    }
    if (phone != null) {
      _json["phone"] = phone;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Site Settings */
class SiteSettings {
  /** Whether active view creatives are disabled for this site. */
  core.bool activeViewOptOut;
  /** Site-wide creative settings. */
  CreativeSettings creativeSettings;
  /** Whether brand safe ads are disabled for this site. */
  core.bool disableBrandSafeAds;
  /** Whether new cookies are disabled for this site. */
  core.bool disableNewCookie;
  /** Lookback window settings for this site. */
  LookbackConfiguration lookbackConfiguration;
  /** Configuration settings for dynamic and image floodlight tags. */
  TagSetting tagSetting;
  /**
   * Whether Verification and ActiveView for in-stream video creatives are
   * disabled by default for new placements created under this site. This value
   * will be used to populate the placement.videoActiveViewOptOut field, when no
   * value is specified for the new placement.
   */
  core.bool videoActiveViewOptOutTemplate;
  /**
   * Default VPAID adapter setting for new placements created under this site.
   * This value will be used to populate the placements.vpaidAdapterChoice
   * field, when no value is specified for the new placement. Controls which
   * VPAID format the measurement adapter will use for in-stream video creatives
   * assigned to the placement. The publisher's specifications will typically
   * determine this setting. For VPAID creatives, the adapter format will match
   * the VPAID format (HTML5 VPAID creatives use the HTML5 adapter, and Flash
   * VPAID creatives use the Flash adapter).
   * Possible string values are:
   * - "BOTH"
   * - "DEFAULT"
   * - "FLASH"
   * - "HTML5"
   */
  core.String vpaidAdapterChoiceTemplate;

  SiteSettings();

  SiteSettings.fromJson(core.Map _json) {
    if (_json.containsKey("activeViewOptOut")) {
      activeViewOptOut = _json["activeViewOptOut"];
    }
    if (_json.containsKey("creativeSettings")) {
      creativeSettings = new CreativeSettings.fromJson(_json["creativeSettings"]);
    }
    if (_json.containsKey("disableBrandSafeAds")) {
      disableBrandSafeAds = _json["disableBrandSafeAds"];
    }
    if (_json.containsKey("disableNewCookie")) {
      disableNewCookie = _json["disableNewCookie"];
    }
    if (_json.containsKey("lookbackConfiguration")) {
      lookbackConfiguration = new LookbackConfiguration.fromJson(_json["lookbackConfiguration"]);
    }
    if (_json.containsKey("tagSetting")) {
      tagSetting = new TagSetting.fromJson(_json["tagSetting"]);
    }
    if (_json.containsKey("videoActiveViewOptOutTemplate")) {
      videoActiveViewOptOutTemplate = _json["videoActiveViewOptOutTemplate"];
    }
    if (_json.containsKey("vpaidAdapterChoiceTemplate")) {
      vpaidAdapterChoiceTemplate = _json["vpaidAdapterChoiceTemplate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activeViewOptOut != null) {
      _json["activeViewOptOut"] = activeViewOptOut;
    }
    if (creativeSettings != null) {
      _json["creativeSettings"] = (creativeSettings).toJson();
    }
    if (disableBrandSafeAds != null) {
      _json["disableBrandSafeAds"] = disableBrandSafeAds;
    }
    if (disableNewCookie != null) {
      _json["disableNewCookie"] = disableNewCookie;
    }
    if (lookbackConfiguration != null) {
      _json["lookbackConfiguration"] = (lookbackConfiguration).toJson();
    }
    if (tagSetting != null) {
      _json["tagSetting"] = (tagSetting).toJson();
    }
    if (videoActiveViewOptOutTemplate != null) {
      _json["videoActiveViewOptOutTemplate"] = videoActiveViewOptOutTemplate;
    }
    if (vpaidAdapterChoiceTemplate != null) {
      _json["vpaidAdapterChoiceTemplate"] = vpaidAdapterChoiceTemplate;
    }
    return _json;
  }
}

/** Site List Response */
class SitesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#sitesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Site collection. */
  core.List<Site> sites;

  SitesListResponse();

  SitesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("sites")) {
      sites = _json["sites"].map((value) => new Site.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (sites != null) {
      _json["sites"] = sites.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents the dimensions of ads, placements, creatives, or creative assets.
 */
class Size {
  /** Height of this size. */
  core.int height;
  /** IAB standard size. This is a read-only, auto-generated field. */
  core.bool iab;
  /** ID of this size. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#size".
   */
  core.String kind;
  /** Width of this size. */
  core.int width;

  Size();

  Size.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("iab")) {
      iab = _json["iab"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (height != null) {
      _json["height"] = height;
    }
    if (iab != null) {
      _json["iab"] = iab;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** Size List Response */
class SizesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#sizesListResponse".
   */
  core.String kind;
  /** Size collection. */
  core.List<Size> sizes;

  SizesListResponse();

  SizesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sizes")) {
      sizes = _json["sizes"].map((value) => new Size.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sizes != null) {
      _json["sizes"] = sizes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Skippable Settings */
class SkippableSetting {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#skippableSetting".
   */
  core.String kind;
  /**
   * Amount of time to play videos served to this placement before counting a
   * view. Applicable when skippable is true.
   */
  VideoOffset progressOffset;
  /**
   * Amount of time to play videos served to this placement before the skip
   * button should appear. Applicable when skippable is true.
   */
  VideoOffset skipOffset;
  /** Whether the user can skip creatives served to this placement. */
  core.bool skippable;

  SkippableSetting();

  SkippableSetting.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("progressOffset")) {
      progressOffset = new VideoOffset.fromJson(_json["progressOffset"]);
    }
    if (_json.containsKey("skipOffset")) {
      skipOffset = new VideoOffset.fromJson(_json["skipOffset"]);
    }
    if (_json.containsKey("skippable")) {
      skippable = _json["skippable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (progressOffset != null) {
      _json["progressOffset"] = (progressOffset).toJson();
    }
    if (skipOffset != null) {
      _json["skipOffset"] = (skipOffset).toJson();
    }
    if (skippable != null) {
      _json["skippable"] = skippable;
    }
    return _json;
  }
}

/** Represents a sorted dimension. */
class SortedDimension {
  /**
   * The kind of resource this is, in this case dfareporting#sortedDimension.
   */
  core.String kind;
  /** The name of the dimension. */
  core.String name;
  /**
   * An optional sort order for the dimension column.
   * Possible string values are:
   * - "ASCENDING"
   * - "DESCENDING"
   */
  core.String sortOrder;

  SortedDimension();

  SortedDimension.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sortOrder")) {
      sortOrder = _json["sortOrder"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (sortOrder != null) {
      _json["sortOrder"] = sortOrder;
    }
    return _json;
  }
}

/** Contains properties of a DCM subaccount. */
class Subaccount {
  /**
   * ID of the account that contains this subaccount. This is a read-only field
   * that can be left blank.
   */
  core.String accountId;
  /** IDs of the available user role permissions for this subaccount. */
  core.List<core.String> availablePermissionIds;
  /** ID of this subaccount. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#subaccount".
   */
  core.String kind;
  /**
   * Name of this subaccount. This is a required field. Must be less than 128
   * characters long and be unique among subaccounts of the same account.
   */
  core.String name;

  Subaccount();

  Subaccount.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("availablePermissionIds")) {
      availablePermissionIds = _json["availablePermissionIds"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (availablePermissionIds != null) {
      _json["availablePermissionIds"] = availablePermissionIds;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Subaccount List Response */
class SubaccountsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#subaccountsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Subaccount collection. */
  core.List<Subaccount> subaccounts;

  SubaccountsListResponse();

  SubaccountsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("subaccounts")) {
      subaccounts = _json["subaccounts"].map((value) => new Subaccount.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (subaccounts != null) {
      _json["subaccounts"] = subaccounts.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Placement Tag Data */
class TagData {
  /** Ad associated with this placement tag. */
  core.String adId;
  /** Tag string to record a click. */
  core.String clickTag;
  /** Creative associated with this placement tag. */
  core.String creativeId;
  /**
   * TagData tag format of this tag.
   * Possible string values are:
   * - "PLACEMENT_TAG_CLICK_COMMANDS"
   * - "PLACEMENT_TAG_IFRAME_ILAYER"
   * - "PLACEMENT_TAG_IFRAME_JAVASCRIPT"
   * - "PLACEMENT_TAG_IFRAME_JAVASCRIPT_LEGACY"
   * - "PLACEMENT_TAG_INSTREAM_VIDEO_PREFETCH"
   * - "PLACEMENT_TAG_INSTREAM_VIDEO_PREFETCH_VAST_3"
   * - "PLACEMENT_TAG_INTERNAL_REDIRECT"
   * - "PLACEMENT_TAG_INTERSTITIAL_IFRAME_JAVASCRIPT"
   * - "PLACEMENT_TAG_INTERSTITIAL_IFRAME_JAVASCRIPT_LEGACY"
   * - "PLACEMENT_TAG_INTERSTITIAL_INTERNAL_REDIRECT"
   * - "PLACEMENT_TAG_INTERSTITIAL_JAVASCRIPT"
   * - "PLACEMENT_TAG_INTERSTITIAL_JAVASCRIPT_LEGACY"
   * - "PLACEMENT_TAG_JAVASCRIPT"
   * - "PLACEMENT_TAG_JAVASCRIPT_LEGACY"
   * - "PLACEMENT_TAG_STANDARD"
   * - "PLACEMENT_TAG_TRACKING"
   * - "PLACEMENT_TAG_TRACKING_IFRAME"
   * - "PLACEMENT_TAG_TRACKING_JAVASCRIPT"
   */
  core.String format;
  /** Tag string for serving an ad. */
  core.String impressionTag;

  TagData();

  TagData.fromJson(core.Map _json) {
    if (_json.containsKey("adId")) {
      adId = _json["adId"];
    }
    if (_json.containsKey("clickTag")) {
      clickTag = _json["clickTag"];
    }
    if (_json.containsKey("creativeId")) {
      creativeId = _json["creativeId"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("impressionTag")) {
      impressionTag = _json["impressionTag"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adId != null) {
      _json["adId"] = adId;
    }
    if (clickTag != null) {
      _json["clickTag"] = clickTag;
    }
    if (creativeId != null) {
      _json["creativeId"] = creativeId;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (impressionTag != null) {
      _json["impressionTag"] = impressionTag;
    }
    return _json;
  }
}

/** Tag Settings */
class TagSetting {
  /**
   * Additional key-values to be included in tags. Each key-value pair must be
   * of the form key=value, and pairs must be separated by a semicolon (;). Keys
   * and values must not contain commas. For example, id=2;color=red is a valid
   * value for this field.
   */
  core.String additionalKeyValues;
  /**
   * Whether static landing page URLs should be included in the tags. This
   * setting applies only to placements.
   */
  core.bool includeClickThroughUrls;
  /** Whether click-tracking string should be included in the tags. */
  core.bool includeClickTracking;
  /**
   * Option specifying how keywords are embedded in ad tags. This setting can be
   * used to specify whether keyword placeholders are inserted in placement tags
   * for this site. Publishers can then add keywords to those placeholders.
   * Possible string values are:
   * - "GENERATE_SEPARATE_TAG_FOR_EACH_KEYWORD"
   * - "IGNORE"
   * - "PLACEHOLDER_WITH_LIST_OF_KEYWORDS"
   */
  core.String keywordOption;

  TagSetting();

  TagSetting.fromJson(core.Map _json) {
    if (_json.containsKey("additionalKeyValues")) {
      additionalKeyValues = _json["additionalKeyValues"];
    }
    if (_json.containsKey("includeClickThroughUrls")) {
      includeClickThroughUrls = _json["includeClickThroughUrls"];
    }
    if (_json.containsKey("includeClickTracking")) {
      includeClickTracking = _json["includeClickTracking"];
    }
    if (_json.containsKey("keywordOption")) {
      keywordOption = _json["keywordOption"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additionalKeyValues != null) {
      _json["additionalKeyValues"] = additionalKeyValues;
    }
    if (includeClickThroughUrls != null) {
      _json["includeClickThroughUrls"] = includeClickThroughUrls;
    }
    if (includeClickTracking != null) {
      _json["includeClickTracking"] = includeClickTracking;
    }
    if (keywordOption != null) {
      _json["keywordOption"] = keywordOption;
    }
    return _json;
  }
}

/** Dynamic and Image Tag Settings. */
class TagSettings {
  /** Whether dynamic floodlight tags are enabled. */
  core.bool dynamicTagEnabled;
  /** Whether image tags are enabled. */
  core.bool imageTagEnabled;

  TagSettings();

  TagSettings.fromJson(core.Map _json) {
    if (_json.containsKey("dynamicTagEnabled")) {
      dynamicTagEnabled = _json["dynamicTagEnabled"];
    }
    if (_json.containsKey("imageTagEnabled")) {
      imageTagEnabled = _json["imageTagEnabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dynamicTagEnabled != null) {
      _json["dynamicTagEnabled"] = dynamicTagEnabled;
    }
    if (imageTagEnabled != null) {
      _json["imageTagEnabled"] = imageTagEnabled;
    }
    return _json;
  }
}

/** Target Window. */
class TargetWindow {
  /** User-entered value. */
  core.String customHtml;
  /**
   * Type of browser window for which the backup image of the flash creative can
   * be displayed.
   * Possible string values are:
   * - "CURRENT_WINDOW"
   * - "CUSTOM"
   * - "NEW_WINDOW"
   */
  core.String targetWindowOption;

  TargetWindow();

  TargetWindow.fromJson(core.Map _json) {
    if (_json.containsKey("customHtml")) {
      customHtml = _json["customHtml"];
    }
    if (_json.containsKey("targetWindowOption")) {
      targetWindowOption = _json["targetWindowOption"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customHtml != null) {
      _json["customHtml"] = customHtml;
    }
    if (targetWindowOption != null) {
      _json["targetWindowOption"] = targetWindowOption;
    }
    return _json;
  }
}

/**
 * Contains properties of a targetable remarketing list. Remarketing enables you
 * to create lists of users who have performed specific actions on a site, then
 * target ads to members of those lists. This resource is a read-only view of a
 * remarketing list to be used to faciliate targeting ads to specific lists.
 * Remarketing lists that are owned by your advertisers and those that are
 * shared to your advertisers or account are accessible via this resource. To
 * manage remarketing lists that are owned by your advertisers, use the
 * RemarketingLists resource.
 */
class TargetableRemarketingList {
  /**
   * Account ID of this remarketing list. This is a read-only, auto-generated
   * field that is only returned in GET requests.
   */
  core.String accountId;
  /** Whether this targetable remarketing list is active. */
  core.bool active;
  /**
   * Dimension value for the advertiser ID that owns this targetable remarketing
   * list.
   */
  core.String advertiserId;
  /** Dimension value for the ID of the advertiser. */
  DimensionValue advertiserIdDimensionValue;
  /** Targetable remarketing list description. */
  core.String description;
  /** Targetable remarketing list ID. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#targetableRemarketingList".
   */
  core.String kind;
  /**
   * Number of days that a user should remain in the targetable remarketing list
   * without an impression.
   */
  core.String lifeSpan;
  /** Number of users currently in the list. This is a read-only field. */
  core.String listSize;
  /**
   * Product from which this targetable remarketing list was originated.
   * Possible string values are:
   * - "REMARKETING_LIST_SOURCE_ADX"
   * - "REMARKETING_LIST_SOURCE_DBM"
   * - "REMARKETING_LIST_SOURCE_DFA"
   * - "REMARKETING_LIST_SOURCE_DFP"
   * - "REMARKETING_LIST_SOURCE_DMP"
   * - "REMARKETING_LIST_SOURCE_GA"
   * - "REMARKETING_LIST_SOURCE_GPLUS"
   * - "REMARKETING_LIST_SOURCE_OTHER"
   * - "REMARKETING_LIST_SOURCE_PLAY_STORE"
   * - "REMARKETING_LIST_SOURCE_XFP"
   * - "REMARKETING_LIST_SOURCE_YOUTUBE"
   */
  core.String listSource;
  /**
   * Name of the targetable remarketing list. Is no greater than 128 characters
   * long.
   */
  core.String name;
  /**
   * Subaccount ID of this remarketing list. This is a read-only, auto-generated
   * field that is only returned in GET requests.
   */
  core.String subaccountId;

  TargetableRemarketingList();

  TargetableRemarketingList.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("active")) {
      active = _json["active"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("lifeSpan")) {
      lifeSpan = _json["lifeSpan"];
    }
    if (_json.containsKey("listSize")) {
      listSize = _json["listSize"];
    }
    if (_json.containsKey("listSource")) {
      listSource = _json["listSource"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (active != null) {
      _json["active"] = active;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (lifeSpan != null) {
      _json["lifeSpan"] = lifeSpan;
    }
    if (listSize != null) {
      _json["listSize"] = listSize;
    }
    if (listSource != null) {
      _json["listSource"] = listSource;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Targetable remarketing list response */
class TargetableRemarketingListsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#targetableRemarketingListsListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Targetable remarketing list collection. */
  core.List<TargetableRemarketingList> targetableRemarketingLists;

  TargetableRemarketingListsListResponse();

  TargetableRemarketingListsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("targetableRemarketingLists")) {
      targetableRemarketingLists = _json["targetableRemarketingLists"].map((value) => new TargetableRemarketingList.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (targetableRemarketingLists != null) {
      _json["targetableRemarketingLists"] = targetableRemarketingLists.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Contains properties of a targeting template. A targeting template
 * encapsulates targeting information which can be reused across multiple ads.
 */
class TargetingTemplate {
  /**
   * Account ID of this targeting template. This field, if left unset, will be
   * auto-generated on insert and is read-only after insert.
   */
  core.String accountId;
  /**
   * Advertiser ID of this targeting template. This is a required field on
   * insert and is read-only after insert.
   */
  core.String advertiserId;
  /**
   * Dimension value for the ID of the advertiser. This is a read-only,
   * auto-generated field.
   */
  DimensionValue advertiserIdDimensionValue;
  /** Time and day targeting criteria. */
  DayPartTargeting dayPartTargeting;
  /** Geographical targeting criteria. */
  GeoTargeting geoTargeting;
  /**
   * ID of this targeting template. This is a read-only, auto-generated field.
   */
  core.String id;
  /** Key-value targeting criteria. */
  KeyValueTargetingExpression keyValueTargetingExpression;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#targetingTemplate".
   */
  core.String kind;
  /** Language targeting criteria. */
  LanguageTargeting languageTargeting;
  /** Remarketing list targeting criteria. */
  ListTargetingExpression listTargetingExpression;
  /**
   * Name of this targeting template. This field is required. It must be less
   * than 256 characters long and unique within an advertiser.
   */
  core.String name;
  /**
   * Subaccount ID of this targeting template. This field, if left unset, will
   * be auto-generated on insert and is read-only after insert.
   */
  core.String subaccountId;
  /** Technology platform targeting criteria. */
  TechnologyTargeting technologyTargeting;

  TargetingTemplate();

  TargetingTemplate.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("advertiserId")) {
      advertiserId = _json["advertiserId"];
    }
    if (_json.containsKey("advertiserIdDimensionValue")) {
      advertiserIdDimensionValue = new DimensionValue.fromJson(_json["advertiserIdDimensionValue"]);
    }
    if (_json.containsKey("dayPartTargeting")) {
      dayPartTargeting = new DayPartTargeting.fromJson(_json["dayPartTargeting"]);
    }
    if (_json.containsKey("geoTargeting")) {
      geoTargeting = new GeoTargeting.fromJson(_json["geoTargeting"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("keyValueTargetingExpression")) {
      keyValueTargetingExpression = new KeyValueTargetingExpression.fromJson(_json["keyValueTargetingExpression"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("languageTargeting")) {
      languageTargeting = new LanguageTargeting.fromJson(_json["languageTargeting"]);
    }
    if (_json.containsKey("listTargetingExpression")) {
      listTargetingExpression = new ListTargetingExpression.fromJson(_json["listTargetingExpression"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
    if (_json.containsKey("technologyTargeting")) {
      technologyTargeting = new TechnologyTargeting.fromJson(_json["technologyTargeting"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (advertiserId != null) {
      _json["advertiserId"] = advertiserId;
    }
    if (advertiserIdDimensionValue != null) {
      _json["advertiserIdDimensionValue"] = (advertiserIdDimensionValue).toJson();
    }
    if (dayPartTargeting != null) {
      _json["dayPartTargeting"] = (dayPartTargeting).toJson();
    }
    if (geoTargeting != null) {
      _json["geoTargeting"] = (geoTargeting).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (keyValueTargetingExpression != null) {
      _json["keyValueTargetingExpression"] = (keyValueTargetingExpression).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (languageTargeting != null) {
      _json["languageTargeting"] = (languageTargeting).toJson();
    }
    if (listTargetingExpression != null) {
      _json["listTargetingExpression"] = (listTargetingExpression).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    if (technologyTargeting != null) {
      _json["technologyTargeting"] = (technologyTargeting).toJson();
    }
    return _json;
  }
}

/** Targeting Template List Response */
class TargetingTemplatesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#targetingTemplatesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** Targeting template collection. */
  core.List<TargetingTemplate> targetingTemplates;

  TargetingTemplatesListResponse();

  TargetingTemplatesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("targetingTemplates")) {
      targetingTemplates = _json["targetingTemplates"].map((value) => new TargetingTemplate.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (targetingTemplates != null) {
      _json["targetingTemplates"] = targetingTemplates.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Technology Targeting. */
class TechnologyTargeting {
  /**
   * Browsers that this ad targets. For each browser either set browserVersionId
   * or dartId along with the version numbers. If both are specified, only
   * browserVersionId will be used. The other fields are populated automatically
   * when the ad is inserted or updated.
   */
  core.List<Browser> browsers;
  /**
   * Connection types that this ad targets. For each connection type only id is
   * required. The other fields are populated automatically when the ad is
   * inserted or updated.
   */
  core.List<ConnectionType> connectionTypes;
  /**
   * Mobile carriers that this ad targets. For each mobile carrier only id is
   * required, and the other fields are populated automatically when the ad is
   * inserted or updated. If targeting a mobile carrier, do not set targeting
   * for any zip codes.
   */
  core.List<MobileCarrier> mobileCarriers;
  /**
   * Operating system versions that this ad targets. To target all versions, use
   * operatingSystems. For each operating system version, only id is required.
   * The other fields are populated automatically when the ad is inserted or
   * updated. If targeting an operating system version, do not set targeting for
   * the corresponding operating system in operatingSystems.
   */
  core.List<OperatingSystemVersion> operatingSystemVersions;
  /**
   * Operating systems that this ad targets. To target specific versions, use
   * operatingSystemVersions. For each operating system only dartId is required.
   * The other fields are populated automatically when the ad is inserted or
   * updated. If targeting an operating system, do not set targeting for
   * operating system versions for the same operating system.
   */
  core.List<OperatingSystem> operatingSystems;
  /**
   * Platform types that this ad targets. For example, desktop, mobile, or
   * tablet. For each platform type, only id is required, and the other fields
   * are populated automatically when the ad is inserted or updated.
   */
  core.List<PlatformType> platformTypes;

  TechnologyTargeting();

  TechnologyTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("browsers")) {
      browsers = _json["browsers"].map((value) => new Browser.fromJson(value)).toList();
    }
    if (_json.containsKey("connectionTypes")) {
      connectionTypes = _json["connectionTypes"].map((value) => new ConnectionType.fromJson(value)).toList();
    }
    if (_json.containsKey("mobileCarriers")) {
      mobileCarriers = _json["mobileCarriers"].map((value) => new MobileCarrier.fromJson(value)).toList();
    }
    if (_json.containsKey("operatingSystemVersions")) {
      operatingSystemVersions = _json["operatingSystemVersions"].map((value) => new OperatingSystemVersion.fromJson(value)).toList();
    }
    if (_json.containsKey("operatingSystems")) {
      operatingSystems = _json["operatingSystems"].map((value) => new OperatingSystem.fromJson(value)).toList();
    }
    if (_json.containsKey("platformTypes")) {
      platformTypes = _json["platformTypes"].map((value) => new PlatformType.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (browsers != null) {
      _json["browsers"] = browsers.map((value) => (value).toJson()).toList();
    }
    if (connectionTypes != null) {
      _json["connectionTypes"] = connectionTypes.map((value) => (value).toJson()).toList();
    }
    if (mobileCarriers != null) {
      _json["mobileCarriers"] = mobileCarriers.map((value) => (value).toJson()).toList();
    }
    if (operatingSystemVersions != null) {
      _json["operatingSystemVersions"] = operatingSystemVersions.map((value) => (value).toJson()).toList();
    }
    if (operatingSystems != null) {
      _json["operatingSystems"] = operatingSystems.map((value) => (value).toJson()).toList();
    }
    if (platformTypes != null) {
      _json["platformTypes"] = platformTypes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Third Party Authentication Token */
class ThirdPartyAuthenticationToken {
  /** Name of the third-party authentication token. */
  core.String name;
  /**
   * Value of the third-party authentication token. This is a read-only,
   * auto-generated field.
   */
  core.String value;

  ThirdPartyAuthenticationToken();

  ThirdPartyAuthenticationToken.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Third-party Tracking URL. */
class ThirdPartyTrackingUrl {
  /**
   * Third-party URL type for in-stream video creatives.
   * Possible string values are:
   * - "CLICK_TRACKING"
   * - "IMPRESSION"
   * - "RICH_MEDIA_BACKUP_IMPRESSION"
   * - "RICH_MEDIA_IMPRESSION"
   * - "RICH_MEDIA_RM_IMPRESSION"
   * - "SURVEY"
   * - "VIDEO_COMPLETE"
   * - "VIDEO_CUSTOM"
   * - "VIDEO_FIRST_QUARTILE"
   * - "VIDEO_FULLSCREEN"
   * - "VIDEO_MIDPOINT"
   * - "VIDEO_MUTE"
   * - "VIDEO_PAUSE"
   * - "VIDEO_PROGRESS"
   * - "VIDEO_REWIND"
   * - "VIDEO_SKIP"
   * - "VIDEO_START"
   * - "VIDEO_STOP"
   * - "VIDEO_THIRD_QUARTILE"
   */
  core.String thirdPartyUrlType;
  /** URL for the specified third-party URL type. */
  core.String url;

  ThirdPartyTrackingUrl();

  ThirdPartyTrackingUrl.fromJson(core.Map _json) {
    if (_json.containsKey("thirdPartyUrlType")) {
      thirdPartyUrlType = _json["thirdPartyUrlType"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (thirdPartyUrlType != null) {
      _json["thirdPartyUrlType"] = thirdPartyUrlType;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Transcode Settings */
class TranscodeSetting {
  /**
   * Whitelist of video formats to be served to this placement. Set this list to
   * null or empty to serve all video formats.
   */
  core.List<core.int> enabledVideoFormats;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#transcodeSetting".
   */
  core.String kind;

  TranscodeSetting();

  TranscodeSetting.fromJson(core.Map _json) {
    if (_json.containsKey("enabledVideoFormats")) {
      enabledVideoFormats = _json["enabledVideoFormats"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enabledVideoFormats != null) {
      _json["enabledVideoFormats"] = enabledVideoFormats;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** User Defined Variable configuration. */
class UserDefinedVariableConfiguration {
  /**
   * Data type for the variable. This is a required field.
   * Possible string values are:
   * - "NUMBER"
   * - "STRING"
   */
  core.String dataType;
  /**
   * User-friendly name for the variable which will appear in reports. This is a
   * required field, must be less than 64 characters long, and cannot contain
   * the following characters: ""<>".
   */
  core.String reportName;
  /**
   * Variable name in the tag. This is a required field.
   * Possible string values are:
   * - "U1"
   * - "U10"
   * - "U100"
   * - "U11"
   * - "U12"
   * - "U13"
   * - "U14"
   * - "U15"
   * - "U16"
   * - "U17"
   * - "U18"
   * - "U19"
   * - "U2"
   * - "U20"
   * - "U21"
   * - "U22"
   * - "U23"
   * - "U24"
   * - "U25"
   * - "U26"
   * - "U27"
   * - "U28"
   * - "U29"
   * - "U3"
   * - "U30"
   * - "U31"
   * - "U32"
   * - "U33"
   * - "U34"
   * - "U35"
   * - "U36"
   * - "U37"
   * - "U38"
   * - "U39"
   * - "U4"
   * - "U40"
   * - "U41"
   * - "U42"
   * - "U43"
   * - "U44"
   * - "U45"
   * - "U46"
   * - "U47"
   * - "U48"
   * - "U49"
   * - "U5"
   * - "U50"
   * - "U51"
   * - "U52"
   * - "U53"
   * - "U54"
   * - "U55"
   * - "U56"
   * - "U57"
   * - "U58"
   * - "U59"
   * - "U6"
   * - "U60"
   * - "U61"
   * - "U62"
   * - "U63"
   * - "U64"
   * - "U65"
   * - "U66"
   * - "U67"
   * - "U68"
   * - "U69"
   * - "U7"
   * - "U70"
   * - "U71"
   * - "U72"
   * - "U73"
   * - "U74"
   * - "U75"
   * - "U76"
   * - "U77"
   * - "U78"
   * - "U79"
   * - "U8"
   * - "U80"
   * - "U81"
   * - "U82"
   * - "U83"
   * - "U84"
   * - "U85"
   * - "U86"
   * - "U87"
   * - "U88"
   * - "U89"
   * - "U9"
   * - "U90"
   * - "U91"
   * - "U92"
   * - "U93"
   * - "U94"
   * - "U95"
   * - "U96"
   * - "U97"
   * - "U98"
   * - "U99"
   */
  core.String variableType;

  UserDefinedVariableConfiguration();

  UserDefinedVariableConfiguration.fromJson(core.Map _json) {
    if (_json.containsKey("dataType")) {
      dataType = _json["dataType"];
    }
    if (_json.containsKey("reportName")) {
      reportName = _json["reportName"];
    }
    if (_json.containsKey("variableType")) {
      variableType = _json["variableType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataType != null) {
      _json["dataType"] = dataType;
    }
    if (reportName != null) {
      _json["reportName"] = reportName;
    }
    if (variableType != null) {
      _json["variableType"] = variableType;
    }
    return _json;
  }
}

/** Represents a UserProfile resource. */
class UserProfile {
  /** The account ID to which this profile belongs. */
  core.String accountId;
  /** The account name this profile belongs to. */
  core.String accountName;
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The kind of resource this is, in this case dfareporting#userProfile. */
  core.String kind;
  /** The unique ID of the user profile. */
  core.String profileId;
  /** The sub account ID this profile belongs to if applicable. */
  core.String subAccountId;
  /** The sub account name this profile belongs to if applicable. */
  core.String subAccountName;
  /** The user name. */
  core.String userName;

  UserProfile();

  UserProfile.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("accountName")) {
      accountName = _json["accountName"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("profileId")) {
      profileId = _json["profileId"];
    }
    if (_json.containsKey("subAccountId")) {
      subAccountId = _json["subAccountId"];
    }
    if (_json.containsKey("subAccountName")) {
      subAccountName = _json["subAccountName"];
    }
    if (_json.containsKey("userName")) {
      userName = _json["userName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (accountName != null) {
      _json["accountName"] = accountName;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (profileId != null) {
      _json["profileId"] = profileId;
    }
    if (subAccountId != null) {
      _json["subAccountId"] = subAccountId;
    }
    if (subAccountName != null) {
      _json["subAccountName"] = subAccountName;
    }
    if (userName != null) {
      _json["userName"] = userName;
    }
    return _json;
  }
}

/** Represents the list of user profiles. */
class UserProfileList {
  /** The eTag of this response for caching purposes. */
  core.String etag;
  /** The user profiles returned in this response. */
  core.List<UserProfile> items;
  /** The kind of list this is, in this case dfareporting#userProfileList. */
  core.String kind;

  UserProfileList();

  UserProfileList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new UserProfile.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Contains properties of auser role, which is used to manage user access. */
class UserRole {
  /**
   * Account ID of this user role. This is a read-only field that can be left
   * blank.
   */
  core.String accountId;
  /**
   * Whether this is a default user role. Default user roles are created by the
   * system for the account/subaccount and cannot be modified or deleted. Each
   * default user role comes with a basic set of preassigned permissions.
   */
  core.bool defaultUserRole;
  /** ID of this user role. This is a read-only, auto-generated field. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRole".
   */
  core.String kind;
  /**
   * Name of this user role. This is a required field. Must be less than 256
   * characters long. If this user role is under a subaccount, the name must be
   * unique among sites of the same subaccount. Otherwise, this user role is a
   * top-level user role, and the name must be unique among top-level user roles
   * of the same account.
   */
  core.String name;
  /**
   * ID of the user role that this user role is based on or copied from. This is
   * a required field.
   */
  core.String parentUserRoleId;
  /** List of permissions associated with this user role. */
  core.List<UserRolePermission> permissions;
  /**
   * Subaccount ID of this user role. This is a read-only field that can be left
   * blank.
   */
  core.String subaccountId;

  UserRole();

  UserRole.fromJson(core.Map _json) {
    if (_json.containsKey("accountId")) {
      accountId = _json["accountId"];
    }
    if (_json.containsKey("defaultUserRole")) {
      defaultUserRole = _json["defaultUserRole"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("parentUserRoleId")) {
      parentUserRoleId = _json["parentUserRoleId"];
    }
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"].map((value) => new UserRolePermission.fromJson(value)).toList();
    }
    if (_json.containsKey("subaccountId")) {
      subaccountId = _json["subaccountId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accountId != null) {
      _json["accountId"] = accountId;
    }
    if (defaultUserRole != null) {
      _json["defaultUserRole"] = defaultUserRole;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (parentUserRoleId != null) {
      _json["parentUserRoleId"] = parentUserRoleId;
    }
    if (permissions != null) {
      _json["permissions"] = permissions.map((value) => (value).toJson()).toList();
    }
    if (subaccountId != null) {
      _json["subaccountId"] = subaccountId;
    }
    return _json;
  }
}

/** Contains properties of a user role permission. */
class UserRolePermission {
  /**
   * Levels of availability for a user role permission.
   * Possible string values are:
   * - "ACCOUNT_ALWAYS"
   * - "ACCOUNT_BY_DEFAULT"
   * - "NOT_AVAILABLE_BY_DEFAULT"
   * - "SUBACCOUNT_AND_ACCOUNT_ALWAYS"
   * - "SUBACCOUNT_AND_ACCOUNT_BY_DEFAULT"
   */
  core.String availability;
  /** ID of this user role permission. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRolePermission".
   */
  core.String kind;
  /** Name of this user role permission. */
  core.String name;
  /** ID of the permission group that this user role permission belongs to. */
  core.String permissionGroupId;

  UserRolePermission();

  UserRolePermission.fromJson(core.Map _json) {
    if (_json.containsKey("availability")) {
      availability = _json["availability"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("permissionGroupId")) {
      permissionGroupId = _json["permissionGroupId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (availability != null) {
      _json["availability"] = availability;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (permissionGroupId != null) {
      _json["permissionGroupId"] = permissionGroupId;
    }
    return _json;
  }
}

/** Represents a grouping of related user role permissions. */
class UserRolePermissionGroup {
  /** ID of this user role permission. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRolePermissionGroup".
   */
  core.String kind;
  /** Name of this user role permission group. */
  core.String name;

  UserRolePermissionGroup();

  UserRolePermissionGroup.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** User Role Permission Group List Response */
class UserRolePermissionGroupsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRolePermissionGroupsListResponse".
   */
  core.String kind;
  /** User role permission group collection. */
  core.List<UserRolePermissionGroup> userRolePermissionGroups;

  UserRolePermissionGroupsListResponse();

  UserRolePermissionGroupsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("userRolePermissionGroups")) {
      userRolePermissionGroups = _json["userRolePermissionGroups"].map((value) => new UserRolePermissionGroup.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (userRolePermissionGroups != null) {
      _json["userRolePermissionGroups"] = userRolePermissionGroups.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** User Role Permission List Response */
class UserRolePermissionsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRolePermissionsListResponse".
   */
  core.String kind;
  /** User role permission collection. */
  core.List<UserRolePermission> userRolePermissions;

  UserRolePermissionsListResponse();

  UserRolePermissionsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("userRolePermissions")) {
      userRolePermissions = _json["userRolePermissions"].map((value) => new UserRolePermission.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (userRolePermissions != null) {
      _json["userRolePermissions"] = userRolePermissions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** User Role List Response */
class UserRolesListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#userRolesListResponse".
   */
  core.String kind;
  /** Pagination token to be used for the next list operation. */
  core.String nextPageToken;
  /** User role collection. */
  core.List<UserRole> userRoles;

  UserRolesListResponse();

  UserRolesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("userRoles")) {
      userRoles = _json["userRoles"].map((value) => new UserRole.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (userRoles != null) {
      _json["userRoles"] = userRoles.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Contains information about supported video formats. */
class VideoFormat {
  /**
   * File type of the video format.
   * Possible string values are:
   * - "FLV"
   * - "M3U8"
   * - "MP4"
   * - "THREEGPP"
   * - "WEBM"
   */
  core.String fileType;
  /** ID of the video format. */
  core.int id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#videoFormat".
   */
  core.String kind;
  /** The resolution of this video format. */
  Size resolution;
  /** The target bit rate of this video format. */
  core.int targetBitRate;

  VideoFormat();

  VideoFormat.fromJson(core.Map _json) {
    if (_json.containsKey("fileType")) {
      fileType = _json["fileType"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("resolution")) {
      resolution = new Size.fromJson(_json["resolution"]);
    }
    if (_json.containsKey("targetBitRate")) {
      targetBitRate = _json["targetBitRate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fileType != null) {
      _json["fileType"] = fileType;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (resolution != null) {
      _json["resolution"] = (resolution).toJson();
    }
    if (targetBitRate != null) {
      _json["targetBitRate"] = targetBitRate;
    }
    return _json;
  }
}

/** Video Format List Response */
class VideoFormatsListResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#videoFormatsListResponse".
   */
  core.String kind;
  /** Video format collection. */
  core.List<VideoFormat> videoFormats;

  VideoFormatsListResponse();

  VideoFormatsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("videoFormats")) {
      videoFormats = _json["videoFormats"].map((value) => new VideoFormat.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (videoFormats != null) {
      _json["videoFormats"] = videoFormats.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Video Offset */
class VideoOffset {
  /**
   * Duration, as a percentage of video duration. Do not set when offsetSeconds
   * is set.
   */
  core.int offsetPercentage;
  /** Duration, in seconds. Do not set when offsetPercentage is set. */
  core.int offsetSeconds;

  VideoOffset();

  VideoOffset.fromJson(core.Map _json) {
    if (_json.containsKey("offsetPercentage")) {
      offsetPercentage = _json["offsetPercentage"];
    }
    if (_json.containsKey("offsetSeconds")) {
      offsetSeconds = _json["offsetSeconds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (offsetPercentage != null) {
      _json["offsetPercentage"] = offsetPercentage;
    }
    if (offsetSeconds != null) {
      _json["offsetSeconds"] = offsetSeconds;
    }
    return _json;
  }
}

/** Video Settings */
class VideoSettings {
  /**
   * Settings for the companion creatives of video creatives served to this
   * placement.
   */
  CompanionSetting companionSettings;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dfareporting#videoSettings".
   */
  core.String kind;
  /**
   * Settings for the skippability of video creatives served to this placement.
   * If this object is provided, the creative-level skippable settings will be
   * overridden.
   */
  SkippableSetting skippableSettings;
  /**
   * Settings for the transcodes of video creatives served to this placement. If
   * this object is provided, the creative-level transcode settings will be
   * overridden.
   */
  TranscodeSetting transcodeSettings;

  VideoSettings();

  VideoSettings.fromJson(core.Map _json) {
    if (_json.containsKey("companionSettings")) {
      companionSettings = new CompanionSetting.fromJson(_json["companionSettings"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("skippableSettings")) {
      skippableSettings = new SkippableSetting.fromJson(_json["skippableSettings"]);
    }
    if (_json.containsKey("transcodeSettings")) {
      transcodeSettings = new TranscodeSetting.fromJson(_json["transcodeSettings"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (companionSettings != null) {
      _json["companionSettings"] = (companionSettings).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (skippableSettings != null) {
      _json["skippableSettings"] = (skippableSettings).toJson();
    }
    if (transcodeSettings != null) {
      _json["transcodeSettings"] = (transcodeSettings).toJson();
    }
    return _json;
  }
}
