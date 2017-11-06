// This is a generated file (see the discoveryapis_generator project).

library googleapis.dns.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client dns/v1';

/** Configures and serves authoritative DNS records. */
class DnsApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";

  /** View your DNS records hosted by Google Cloud DNS */
  static const NdevClouddnsReadonlyScope = "https://www.googleapis.com/auth/ndev.clouddns.readonly";

  /** View and manage your DNS records hosted by Google Cloud DNS */
  static const NdevClouddnsReadwriteScope = "https://www.googleapis.com/auth/ndev.clouddns.readwrite";


  final commons.ApiRequester _requester;

  ChangesResourceApi get changes => new ChangesResourceApi(_requester);
  ManagedZonesResourceApi get managedZones => new ManagedZonesResourceApi(_requester);
  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);
  ResourceRecordSetsResourceApi get resourceRecordSets => new ResourceRecordSetsResourceApi(_requester);

  DnsApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "dns/v1/projects/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ChangesResourceApi {
  final commons.ApiRequester _requester;

  ChangesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Atomically update the ResourceRecordSet collection.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * Completes with a [Change].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Change> create(Change request, core.String project, core.String managedZone) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone') + '/changes';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Change.fromJson(data));
  }

  /**
   * Fetch the representation of an existing Change.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * [changeId] - The identifier of the requested change, from a previous
   * ResourceRecordSetsChangeResponse.
   *
   * Completes with a [Change].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Change> get(core.String project, core.String managedZone, core.String changeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
    }
    if (changeId == null) {
      throw new core.ArgumentError("Parameter changeId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone') + '/changes/' + commons.Escaper.ecapeVariable('$changeId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Change.fromJson(data));
  }

  /**
   * Enumerate Changes to a ResourceRecordSet collection.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * [maxResults] - Optional. Maximum number of results to be returned. If
   * unspecified, the server will decide how many results to return.
   *
   * [pageToken] - Optional. A tag returned by a previous list request that was
   * truncated. Use this parameter to continue a previous list request.
   *
   * [sortBy] - Sorting criterion. The only supported value is change sequence.
   * Possible string values are:
   * - "changeSequence"
   *
   * [sortOrder] - Sorting order direction: 'ascending' or 'descending'.
   *
   * Completes with a [ChangesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChangesListResponse> list(core.String project, core.String managedZone, {core.int maxResults, core.String pageToken, core.String sortBy, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (sortBy != null) {
      _queryParams["sortBy"] = [sortBy];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone') + '/changes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChangesListResponse.fromJson(data));
  }

}


class ManagedZonesResourceApi {
  final commons.ApiRequester _requester;

  ManagedZonesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Create a new ManagedZone.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * Completes with a [ManagedZone].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ManagedZone> create(ManagedZone request, core.String project) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ManagedZone.fromJson(data));
  }

  /**
   * Delete a previously created ManagedZone.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String project, core.String managedZone) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone');

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
   * Fetch the representation of an existing ManagedZone.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * Completes with a [ManagedZone].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ManagedZone> get(core.String project, core.String managedZone) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ManagedZone.fromJson(data));
  }

  /**
   * Enumerate ManagedZones that have been created but not yet deleted.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [dnsName] - Restricts the list to return only zones with this domain name.
   *
   * [maxResults] - Optional. Maximum number of results to be returned. If
   * unspecified, the server will decide how many results to return.
   *
   * [pageToken] - Optional. A tag returned by a previous list request that was
   * truncated. Use this parameter to continue a previous list request.
   *
   * Completes with a [ManagedZonesListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ManagedZonesListResponse> list(core.String project, {core.String dnsName, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (dnsName != null) {
      _queryParams["dnsName"] = [dnsName];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ManagedZonesListResponse.fromJson(data));
  }

}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Fetch the representation of an existing Project.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * Completes with a [Project].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Project> get(core.String project) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }

    _url = commons.Escaper.ecapeVariable('$project');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Project.fromJson(data));
  }

}


class ResourceRecordSetsResourceApi {
  final commons.ApiRequester _requester;

  ResourceRecordSetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Enumerate ResourceRecordSets that have been created but not yet deleted.
   *
   * Request parameters:
   *
   * [project] - Identifies the project addressed by this request.
   *
   * [managedZone] - Identifies the managed zone addressed by this request. Can
   * be the managed zone name or id.
   *
   * [maxResults] - Optional. Maximum number of results to be returned. If
   * unspecified, the server will decide how many results to return.
   *
   * [name] - Restricts the list to return only records with this fully
   * qualified domain name.
   *
   * [pageToken] - Optional. A tag returned by a previous list request that was
   * truncated. Use this parameter to continue a previous list request.
   *
   * [type] - Restricts the list to return only records of this type. If
   * present, the "name" parameter must also be present.
   *
   * Completes with a [ResourceRecordSetsListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ResourceRecordSetsListResponse> list(core.String project, core.String managedZone, {core.int maxResults, core.String name, core.String pageToken, core.String type}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    if (managedZone == null) {
      throw new core.ArgumentError("Parameter managedZone is required.");
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
    if (type != null) {
      _queryParams["type"] = [type];
    }

    _url = commons.Escaper.ecapeVariable('$project') + '/managedZones/' + commons.Escaper.ecapeVariable('$managedZone') + '/rrsets';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ResourceRecordSetsListResponse.fromJson(data));
  }

}



/** An atomic update to a collection of ResourceRecordSets. */
class Change {
  /** Which ResourceRecordSets to add? */
  core.List<ResourceRecordSet> additions;
  /** Which ResourceRecordSets to remove? Must match existing data exactly. */
  core.List<ResourceRecordSet> deletions;
  /**
   * Unique identifier for the resource; defined by the server (output only).
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dns#change".
   */
  core.String kind;
  /**
   * The time that this operation was started by the server (output only). This
   * is in RFC3339 text format.
   */
  core.String startTime;
  /**
   * Status of the operation (output only).
   * Possible string values are:
   * - "done"
   * - "pending"
   */
  core.String status;

  Change();

  Change.fromJson(core.Map _json) {
    if (_json.containsKey("additions")) {
      additions = _json["additions"].map((value) => new ResourceRecordSet.fromJson(value)).toList();
    }
    if (_json.containsKey("deletions")) {
      deletions = _json["deletions"].map((value) => new ResourceRecordSet.fromJson(value)).toList();
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (additions != null) {
      _json["additions"] = additions.map((value) => (value).toJson()).toList();
    }
    if (deletions != null) {
      _json["deletions"] = deletions.map((value) => (value).toJson()).toList();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

/**
 * The response to a request to enumerate Changes to a ResourceRecordSets
 * collection.
 */
class ChangesListResponse {
  /** The requested changes. */
  core.List<Change> changes;
  /** Type of resource. */
  core.String kind;
  /**
   * The presence of this field indicates that there exist more results
   * following your last page of results in pagination order. To fetch them,
   * make another list request using this value as your pagination token.
   *
   * In this way you can retrieve the complete contents of even very large
   * collections one page at a time. However, if the contents of the collection
   * change between the first and last paginated list request, the set of all
   * elements returned will be an inconsistent view of the collection. There is
   * no way to retrieve a "snapshot" of collections larger than the maximum page
   * size.
   */
  core.String nextPageToken;

  ChangesListResponse();

  ChangesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("changes")) {
      changes = _json["changes"].map((value) => new Change.fromJson(value)).toList();
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
    if (changes != null) {
      _json["changes"] = changes.map((value) => (value).toJson()).toList();
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
 * A zone is a subtree of the DNS namespace under one administrative
 * responsibility. A ManagedZone is a resource that represents a DNS zone hosted
 * by the Cloud DNS service.
 */
class ManagedZone {
  /**
   * The time that this resource was created on the server. This is in RFC3339
   * text format. Output only.
   */
  core.String creationTime;
  /**
   * A mutable string of at most 1024 characters associated with this resource
   * for the user's convenience. Has no effect on the managed zone's function.
   */
  core.String description;
  /** The DNS name of this managed zone, for instance "example.com.". */
  core.String dnsName;
  /**
   * Unique identifier for the resource; defined by the server (output only)
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dns#managedZone".
   */
  core.String kind;
  /**
   * User assigned name for this resource. Must be unique within the project.
   * The name must be 1-63 characters long, must begin with a letter, end with a
   * letter or digit, and only contain lowercase letters, digits or dashes.
   */
  core.String name;
  /**
   * Optionally specifies the NameServerSet for this ManagedZone. A
   * NameServerSet is a set of DNS name servers that all host the same
   * ManagedZones. Most users will leave this field unset.
   */
  core.String nameServerSet;
  /**
   * Delegate your managed_zone to these virtual name servers; defined by the
   * server (output only)
   */
  core.List<core.String> nameServers;

  ManagedZone();

  ManagedZone.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("dnsName")) {
      dnsName = _json["dnsName"];
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
    if (_json.containsKey("nameServerSet")) {
      nameServerSet = _json["nameServerSet"];
    }
    if (_json.containsKey("nameServers")) {
      nameServers = _json["nameServers"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (dnsName != null) {
      _json["dnsName"] = dnsName;
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
    if (nameServerSet != null) {
      _json["nameServerSet"] = nameServerSet;
    }
    if (nameServers != null) {
      _json["nameServers"] = nameServers;
    }
    return _json;
  }
}

class ManagedZonesListResponse {
  /** Type of resource. */
  core.String kind;
  /** The managed zone resources. */
  core.List<ManagedZone> managedZones;
  /**
   * The presence of this field indicates that there exist more results
   * following your last page of results in pagination order. To fetch them,
   * make another list request using this value as your page token.
   *
   * In this way you can retrieve the complete contents of even very large
   * collections one page at a time. However, if the contents of the collection
   * change between the first and last paginated list request, the set of all
   * elements returned will be an inconsistent view of the collection. There is
   * no way to retrieve a consistent snapshot of a collection larger than the
   * maximum page size.
   */
  core.String nextPageToken;

  ManagedZonesListResponse();

  ManagedZonesListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("managedZones")) {
      managedZones = _json["managedZones"].map((value) => new ManagedZone.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (managedZones != null) {
      _json["managedZones"] = managedZones.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/**
 * A project resource. The project is a top level container for resources
 * including Cloud DNS ManagedZones. Projects can be created only in the APIs
 * console.
 */
class Project {
  /** User assigned unique identifier for the resource (output only). */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dns#project".
   */
  core.String kind;
  /**
   * Unique numeric identifier for the resource; defined by the server (output
   * only).
   */
  core.String number;
  /** Quotas assigned to this project (output only). */
  Quota quota;

  Project();

  Project.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
    }
    if (_json.containsKey("quota")) {
      quota = new Quota.fromJson(_json["quota"]);
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
    if (number != null) {
      _json["number"] = number;
    }
    if (quota != null) {
      _json["quota"] = (quota).toJson();
    }
    return _json;
  }
}

/** Limits associated with a Project. */
class Quota {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dns#quota".
   */
  core.String kind;
  /** Maximum allowed number of managed zones in the project. */
  core.int managedZones;
  /** Maximum allowed number of ResourceRecords per ResourceRecordSet. */
  core.int resourceRecordsPerRrset;
  /**
   * Maximum allowed number of ResourceRecordSets to add per
   * ChangesCreateRequest.
   */
  core.int rrsetAdditionsPerChange;
  /**
   * Maximum allowed number of ResourceRecordSets to delete per
   * ChangesCreateRequest.
   */
  core.int rrsetDeletionsPerChange;
  /** Maximum allowed number of ResourceRecordSets per zone in the project. */
  core.int rrsetsPerManagedZone;
  /**
   * Maximum allowed size for total rrdata in one ChangesCreateRequest in bytes.
   */
  core.int totalRrdataSizePerChange;

  Quota();

  Quota.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("managedZones")) {
      managedZones = _json["managedZones"];
    }
    if (_json.containsKey("resourceRecordsPerRrset")) {
      resourceRecordsPerRrset = _json["resourceRecordsPerRrset"];
    }
    if (_json.containsKey("rrsetAdditionsPerChange")) {
      rrsetAdditionsPerChange = _json["rrsetAdditionsPerChange"];
    }
    if (_json.containsKey("rrsetDeletionsPerChange")) {
      rrsetDeletionsPerChange = _json["rrsetDeletionsPerChange"];
    }
    if (_json.containsKey("rrsetsPerManagedZone")) {
      rrsetsPerManagedZone = _json["rrsetsPerManagedZone"];
    }
    if (_json.containsKey("totalRrdataSizePerChange")) {
      totalRrdataSizePerChange = _json["totalRrdataSizePerChange"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (managedZones != null) {
      _json["managedZones"] = managedZones;
    }
    if (resourceRecordsPerRrset != null) {
      _json["resourceRecordsPerRrset"] = resourceRecordsPerRrset;
    }
    if (rrsetAdditionsPerChange != null) {
      _json["rrsetAdditionsPerChange"] = rrsetAdditionsPerChange;
    }
    if (rrsetDeletionsPerChange != null) {
      _json["rrsetDeletionsPerChange"] = rrsetDeletionsPerChange;
    }
    if (rrsetsPerManagedZone != null) {
      _json["rrsetsPerManagedZone"] = rrsetsPerManagedZone;
    }
    if (totalRrdataSizePerChange != null) {
      _json["totalRrdataSizePerChange"] = totalRrdataSizePerChange;
    }
    return _json;
  }
}

/** A unit of data that will be returned by the DNS servers. */
class ResourceRecordSet {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "dns#resourceRecordSet".
   */
  core.String kind;
  /** For example, www.example.com. */
  core.String name;
  /** As defined in RFC 1035 (section 5) and RFC 1034 (section 3.6.1). */
  core.List<core.String> rrdatas;
  /**
   * Number of seconds that this ResourceRecordSet can be cached by resolvers.
   */
  core.int ttl;
  /**
   * The identifier of a supported record type, for example, A, AAAA, MX, TXT,
   * and so on.
   */
  core.String type;

  ResourceRecordSet();

  ResourceRecordSet.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("rrdatas")) {
      rrdatas = _json["rrdatas"];
    }
    if (_json.containsKey("ttl")) {
      ttl = _json["ttl"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
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
    if (rrdatas != null) {
      _json["rrdatas"] = rrdatas;
    }
    if (ttl != null) {
      _json["ttl"] = ttl;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class ResourceRecordSetsListResponse {
  /** Type of resource. */
  core.String kind;
  /**
   * The presence of this field indicates that there exist more results
   * following your last page of results in pagination order. To fetch them,
   * make another list request using this value as your pagination token.
   *
   * In this way you can retrieve the complete contents of even very large
   * collections one page at a time. However, if the contents of the collection
   * change between the first and last paginated list request, the set of all
   * elements returned will be an inconsistent view of the collection. There is
   * no way to retrieve a consistent snapshot of a collection larger than the
   * maximum page size.
   */
  core.String nextPageToken;
  /** The resource record set resources. */
  core.List<ResourceRecordSet> rrsets;

  ResourceRecordSetsListResponse();

  ResourceRecordSetsListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("rrsets")) {
      rrsets = _json["rrsets"].map((value) => new ResourceRecordSet.fromJson(value)).toList();
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
    if (rrsets != null) {
      _json["rrsets"] = rrsets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
