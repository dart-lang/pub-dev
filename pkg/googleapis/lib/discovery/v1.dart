// This is a generated file (see the discoveryapis_generator project).

library googleapis.discovery.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client discovery/v1';

/**
 * Provides information about other Google APIs, such as what APIs are
 * available, the resource, and method details for each API.
 */
class DiscoveryApi {

  final commons.ApiRequester _requester;

  ApisResourceApi get apis => new ApisResourceApi(_requester);

  DiscoveryApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "discovery/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ApisResourceApi {
  final commons.ApiRequester _requester;

  ApisResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieve the description of a particular version of an api.
   *
   * Request parameters:
   *
   * [api] - The name of the API.
   *
   * [version] - The version of the API.
   *
   * Completes with a [RestDescription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RestDescription> getRest(core.String api, core.String version) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (api == null) {
      throw new core.ArgumentError("Parameter api is required.");
    }
    if (version == null) {
      throw new core.ArgumentError("Parameter version is required.");
    }

    _url = 'apis/' + commons.Escaper.ecapeVariable('$api') + '/' + commons.Escaper.ecapeVariable('$version') + '/rest';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RestDescription.fromJson(data));
  }

  /**
   * Retrieve the list of APIs supported at this endpoint.
   *
   * Request parameters:
   *
   * [name] - Only include APIs with the given name.
   *
   * [preferred] - Return only the preferred version of an API.
   *
   * Completes with a [DirectoryList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DirectoryList> list({core.String name, core.bool preferred}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (preferred != null) {
      _queryParams["preferred"] = ["${preferred}"];
    }

    _url = 'apis';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DirectoryList.fromJson(data));
  }

}



/** Links to 16x16 and 32x32 icons representing the API. */
class DirectoryListItemsIcons {
  /** The URL of the 16x16 icon. */
  core.String x16;
  /** The URL of the 32x32 icon. */
  core.String x32;

  DirectoryListItemsIcons();

  DirectoryListItemsIcons.fromJson(core.Map _json) {
    if (_json.containsKey("x16")) {
      x16 = _json["x16"];
    }
    if (_json.containsKey("x32")) {
      x32 = _json["x32"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (x16 != null) {
      _json["x16"] = x16;
    }
    if (x32 != null) {
      _json["x32"] = x32;
    }
    return _json;
  }
}

class DirectoryListItems {
  /** The description of this API. */
  core.String description;
  /** A link to the discovery document. */
  core.String discoveryLink;
  /** The URL for the discovery REST document. */
  core.String discoveryRestUrl;
  /** A link to human readable documentation for the API. */
  core.String documentationLink;
  /** Links to 16x16 and 32x32 icons representing the API. */
  DirectoryListItemsIcons icons;
  /** The id of this API. */
  core.String id;
  /** The kind for this response. */
  core.String kind;
  /** Labels for the status of this API, such as labs or deprecated. */
  core.List<core.String> labels;
  /** The name of the API. */
  core.String name;
  /** True if this version is the preferred version to use. */
  core.bool preferred;
  /** The title of this API. */
  core.String title;
  /** The version of the API. */
  core.String version;

  DirectoryListItems();

  DirectoryListItems.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("discoveryLink")) {
      discoveryLink = _json["discoveryLink"];
    }
    if (_json.containsKey("discoveryRestUrl")) {
      discoveryRestUrl = _json["discoveryRestUrl"];
    }
    if (_json.containsKey("documentationLink")) {
      documentationLink = _json["documentationLink"];
    }
    if (_json.containsKey("icons")) {
      icons = new DirectoryListItemsIcons.fromJson(_json["icons"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("preferred")) {
      preferred = _json["preferred"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (discoveryLink != null) {
      _json["discoveryLink"] = discoveryLink;
    }
    if (discoveryRestUrl != null) {
      _json["discoveryRestUrl"] = discoveryRestUrl;
    }
    if (documentationLink != null) {
      _json["documentationLink"] = documentationLink;
    }
    if (icons != null) {
      _json["icons"] = (icons).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (preferred != null) {
      _json["preferred"] = preferred;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class DirectoryList {
  /** Indicate the version of the Discovery API used to generate this doc. */
  core.String discoveryVersion;
  /** The individual directory entries. One entry per api/version pair. */
  core.List<DirectoryListItems> items;
  /** The kind for this response. */
  core.String kind;

  DirectoryList();

  DirectoryList.fromJson(core.Map _json) {
    if (_json.containsKey("discoveryVersion")) {
      discoveryVersion = _json["discoveryVersion"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new DirectoryListItems.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (discoveryVersion != null) {
      _json["discoveryVersion"] = discoveryVersion;
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

/** Additional information about this property. */
class JsonSchemaAnnotations {
  /** A list of methods for which this property is required on requests. */
  core.List<core.String> required;

  JsonSchemaAnnotations();

  JsonSchemaAnnotations.fromJson(core.Map _json) {
    if (_json.containsKey("required")) {
      required = _json["required"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (required != null) {
      _json["required"] = required;
    }
    return _json;
  }
}

class JsonSchemaVariantMap {
  core.String P_ref;
  core.String typeValue;

  JsonSchemaVariantMap();

  JsonSchemaVariantMap.fromJson(core.Map _json) {
    if (_json.containsKey("\$ref")) {
      P_ref = _json["\$ref"];
    }
    if (_json.containsKey("type_value")) {
      typeValue = _json["type_value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (P_ref != null) {
      _json["\$ref"] = P_ref;
    }
    if (typeValue != null) {
      _json["type_value"] = typeValue;
    }
    return _json;
  }
}

/**
 * In a variant data type, the value of one property is used to determine how to
 * interpret the entire entity. Its value must exist in a map of descriminant
 * values to schema names.
 */
class JsonSchemaVariant {
  /** The name of the type discriminant property. */
  core.String discriminant;
  /** The map of discriminant value to schema to use for parsing.. */
  core.List<JsonSchemaVariantMap> map;

  JsonSchemaVariant();

  JsonSchemaVariant.fromJson(core.Map _json) {
    if (_json.containsKey("discriminant")) {
      discriminant = _json["discriminant"];
    }
    if (_json.containsKey("map")) {
      map = _json["map"].map((value) => new JsonSchemaVariantMap.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (discriminant != null) {
      _json["discriminant"] = discriminant;
    }
    if (map != null) {
      _json["map"] = map.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class JsonSchema {
  /**
   * A reference to another schema. The value of this property is the "id" of
   * another schema.
   */
  core.String P_ref;
  /**
   * If this is a schema for an object, this property is the schema for any
   * additional properties with dynamic keys on this object.
   */
  JsonSchema additionalProperties;
  /** Additional information about this property. */
  JsonSchemaAnnotations annotations;
  /** The default value of this property (if one exists). */
  core.String default_;
  /** A description of this object. */
  core.String description;
  /** Values this parameter may take (if it is an enum). */
  core.List<core.String> enum_;
  /**
   * The descriptions for the enums. Each position maps to the corresponding
   * value in the "enum" array.
   */
  core.List<core.String> enumDescriptions;
  /**
   * An additional regular expression or key that helps constrain the value. For
   * more details see:
   * http://tools.ietf.org/html/draft-zyp-json-schema-03#section-5.23
   */
  core.String format;
  /** Unique identifier for this schema. */
  core.String id;
  /**
   * If this is a schema for an array, this property is the schema for each
   * element in the array.
   */
  JsonSchema items;
  /**
   * Whether this parameter goes in the query or the path for REST requests.
   */
  core.String location;
  /** The maximum value of this parameter. */
  core.String maximum;
  /** The minimum value of this parameter. */
  core.String minimum;
  /**
   * The regular expression this parameter must conform to. Uses Java 6 regex
   * format:
   * http://docs.oracle.com/javase/6/docs/api/java/util/regex/Pattern.html
   */
  core.String pattern;
  /**
   * If this is a schema for an object, list the schema for each property of
   * this object.
   */
  core.Map<core.String, JsonSchema> properties;
  /**
   * The value is read-only, generated by the service. The value cannot be
   * modified by the client. If the value is included in a POST, PUT, or PATCH
   * request, it is ignored by the service.
   */
  core.bool readOnly;
  /** Whether this parameter may appear multiple times. */
  core.bool repeated;
  /** Whether the parameter is required. */
  core.bool required;
  /**
   * The value type for this schema. A list of values can be found here:
   * http://tools.ietf.org/html/draft-zyp-json-schema-03#section-5.1
   */
  core.String type;
  /**
   * In a variant data type, the value of one property is used to determine how
   * to interpret the entire entity. Its value must exist in a map of
   * descriminant values to schema names.
   */
  JsonSchemaVariant variant;

  JsonSchema();

  JsonSchema.fromJson(core.Map _json) {
    if (_json.containsKey("\$ref")) {
      P_ref = _json["\$ref"];
    }
    if (_json.containsKey("additionalProperties")) {
      additionalProperties = new JsonSchema.fromJson(_json["additionalProperties"]);
    }
    if (_json.containsKey("annotations")) {
      annotations = new JsonSchemaAnnotations.fromJson(_json["annotations"]);
    }
    if (_json.containsKey("default")) {
      default_ = _json["default"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("enum")) {
      enum_ = _json["enum"];
    }
    if (_json.containsKey("enumDescriptions")) {
      enumDescriptions = _json["enumDescriptions"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = new JsonSchema.fromJson(_json["items"]);
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("maximum")) {
      maximum = _json["maximum"];
    }
    if (_json.containsKey("minimum")) {
      minimum = _json["minimum"];
    }
    if (_json.containsKey("pattern")) {
      pattern = _json["pattern"];
    }
    if (_json.containsKey("properties")) {
      properties = commons.mapMap(_json["properties"], (item) => new JsonSchema.fromJson(item));
    }
    if (_json.containsKey("readOnly")) {
      readOnly = _json["readOnly"];
    }
    if (_json.containsKey("repeated")) {
      repeated = _json["repeated"];
    }
    if (_json.containsKey("required")) {
      required = _json["required"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("variant")) {
      variant = new JsonSchemaVariant.fromJson(_json["variant"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (P_ref != null) {
      _json["\$ref"] = P_ref;
    }
    if (additionalProperties != null) {
      _json["additionalProperties"] = (additionalProperties).toJson();
    }
    if (annotations != null) {
      _json["annotations"] = (annotations).toJson();
    }
    if (default_ != null) {
      _json["default"] = default_;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (enum_ != null) {
      _json["enum"] = enum_;
    }
    if (enumDescriptions != null) {
      _json["enumDescriptions"] = enumDescriptions;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (items != null) {
      _json["items"] = (items).toJson();
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (maximum != null) {
      _json["maximum"] = maximum;
    }
    if (minimum != null) {
      _json["minimum"] = minimum;
    }
    if (pattern != null) {
      _json["pattern"] = pattern;
    }
    if (properties != null) {
      _json["properties"] = commons.mapMap(properties, (item) => (item).toJson());
    }
    if (readOnly != null) {
      _json["readOnly"] = readOnly;
    }
    if (repeated != null) {
      _json["repeated"] = repeated;
    }
    if (required != null) {
      _json["required"] = required;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (variant != null) {
      _json["variant"] = (variant).toJson();
    }
    return _json;
  }
}

/** The scope value. */
class RestDescriptionAuthOauth2ScopesValue {
  /** Description of scope. */
  core.String description;

  RestDescriptionAuthOauth2ScopesValue();

  RestDescriptionAuthOauth2ScopesValue.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    return _json;
  }
}

/** OAuth 2.0 authentication information. */
class RestDescriptionAuthOauth2 {
  /** Available OAuth 2.0 scopes. */
  core.Map<core.String, RestDescriptionAuthOauth2ScopesValue> scopes;

  RestDescriptionAuthOauth2();

  RestDescriptionAuthOauth2.fromJson(core.Map _json) {
    if (_json.containsKey("scopes")) {
      scopes = commons.mapMap(_json["scopes"], (item) => new RestDescriptionAuthOauth2ScopesValue.fromJson(item));
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (scopes != null) {
      _json["scopes"] = commons.mapMap(scopes, (item) => (item).toJson());
    }
    return _json;
  }
}

/** Authentication information. */
class RestDescriptionAuth {
  /** OAuth 2.0 authentication information. */
  RestDescriptionAuthOauth2 oauth2;

  RestDescriptionAuth();

  RestDescriptionAuth.fromJson(core.Map _json) {
    if (_json.containsKey("oauth2")) {
      oauth2 = new RestDescriptionAuthOauth2.fromJson(_json["oauth2"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (oauth2 != null) {
      _json["oauth2"] = (oauth2).toJson();
    }
    return _json;
  }
}

/** Links to 16x16 and 32x32 icons representing the API. */
class RestDescriptionIcons {
  /** The URL of the 16x16 icon. */
  core.String x16;
  /** The URL of the 32x32 icon. */
  core.String x32;

  RestDescriptionIcons();

  RestDescriptionIcons.fromJson(core.Map _json) {
    if (_json.containsKey("x16")) {
      x16 = _json["x16"];
    }
    if (_json.containsKey("x32")) {
      x32 = _json["x32"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (x16 != null) {
      _json["x16"] = x16;
    }
    if (x32 != null) {
      _json["x32"] = x32;
    }
    return _json;
  }
}

class RestDescription {
  /** Authentication information. */
  RestDescriptionAuth auth;
  /** [DEPRECATED] The base path for REST requests. */
  core.String basePath;
  /** [DEPRECATED] The base URL for REST requests. */
  core.String baseUrl;
  /** The path for REST batch requests. */
  core.String batchPath;
  /**
   * Indicates how the API name should be capitalized and split into various
   * parts. Useful for generating pretty class names.
   */
  core.String canonicalName;
  /** The description of this API. */
  core.String description;
  /** Indicate the version of the Discovery API used to generate this doc. */
  core.String discoveryVersion;
  /** A link to human readable documentation for the API. */
  core.String documentationLink;
  /** The ETag for this response. */
  core.String etag;
  /**
   * Enable exponential backoff for suitable methods in the generated clients.
   */
  core.bool exponentialBackoffDefault;
  /** A list of supported features for this API. */
  core.List<core.String> features;
  /** Links to 16x16 and 32x32 icons representing the API. */
  RestDescriptionIcons icons;
  /** The ID of this API. */
  core.String id;
  /** The kind for this response. */
  core.String kind;
  /** Labels for the status of this API, such as labs or deprecated. */
  core.List<core.String> labels;
  /** API-level methods for this API. */
  core.Map<core.String, RestMethod> methods;
  /** The name of this API. */
  core.String name;
  /**
   * The domain of the owner of this API. Together with the ownerName and a
   * packagePath values, this can be used to generate a library for this API
   * which would have a unique fully qualified name.
   */
  core.String ownerDomain;
  /** The name of the owner of this API. See ownerDomain. */
  core.String ownerName;
  /** The package of the owner of this API. See ownerDomain. */
  core.String packagePath;
  /** Common parameters that apply across all apis. */
  core.Map<core.String, JsonSchema> parameters;
  /** The protocol described by this document. */
  core.String protocol;
  /** The resources in this API. */
  core.Map<core.String, RestResource> resources;
  /** The version of this API. */
  core.String revision;
  /** The root URL under which all API services live. */
  core.String rootUrl;
  /** The schemas for this API. */
  core.Map<core.String, JsonSchema> schemas;
  /** The base path for all REST requests. */
  core.String servicePath;
  /** The title of this API. */
  core.String title;
  /** The version of this API. */
  core.String version;
  core.bool versionModule;

  RestDescription();

  RestDescription.fromJson(core.Map _json) {
    if (_json.containsKey("auth")) {
      auth = new RestDescriptionAuth.fromJson(_json["auth"]);
    }
    if (_json.containsKey("basePath")) {
      basePath = _json["basePath"];
    }
    if (_json.containsKey("baseUrl")) {
      baseUrl = _json["baseUrl"];
    }
    if (_json.containsKey("batchPath")) {
      batchPath = _json["batchPath"];
    }
    if (_json.containsKey("canonicalName")) {
      canonicalName = _json["canonicalName"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("discoveryVersion")) {
      discoveryVersion = _json["discoveryVersion"];
    }
    if (_json.containsKey("documentationLink")) {
      documentationLink = _json["documentationLink"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("exponentialBackoffDefault")) {
      exponentialBackoffDefault = _json["exponentialBackoffDefault"];
    }
    if (_json.containsKey("features")) {
      features = _json["features"];
    }
    if (_json.containsKey("icons")) {
      icons = new RestDescriptionIcons.fromJson(_json["icons"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("methods")) {
      methods = commons.mapMap(_json["methods"], (item) => new RestMethod.fromJson(item));
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ownerDomain")) {
      ownerDomain = _json["ownerDomain"];
    }
    if (_json.containsKey("ownerName")) {
      ownerName = _json["ownerName"];
    }
    if (_json.containsKey("packagePath")) {
      packagePath = _json["packagePath"];
    }
    if (_json.containsKey("parameters")) {
      parameters = commons.mapMap(_json["parameters"], (item) => new JsonSchema.fromJson(item));
    }
    if (_json.containsKey("protocol")) {
      protocol = _json["protocol"];
    }
    if (_json.containsKey("resources")) {
      resources = commons.mapMap(_json["resources"], (item) => new RestResource.fromJson(item));
    }
    if (_json.containsKey("revision")) {
      revision = _json["revision"];
    }
    if (_json.containsKey("rootUrl")) {
      rootUrl = _json["rootUrl"];
    }
    if (_json.containsKey("schemas")) {
      schemas = commons.mapMap(_json["schemas"], (item) => new JsonSchema.fromJson(item));
    }
    if (_json.containsKey("servicePath")) {
      servicePath = _json["servicePath"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
    if (_json.containsKey("version_module")) {
      versionModule = _json["version_module"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auth != null) {
      _json["auth"] = (auth).toJson();
    }
    if (basePath != null) {
      _json["basePath"] = basePath;
    }
    if (baseUrl != null) {
      _json["baseUrl"] = baseUrl;
    }
    if (batchPath != null) {
      _json["batchPath"] = batchPath;
    }
    if (canonicalName != null) {
      _json["canonicalName"] = canonicalName;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (discoveryVersion != null) {
      _json["discoveryVersion"] = discoveryVersion;
    }
    if (documentationLink != null) {
      _json["documentationLink"] = documentationLink;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (exponentialBackoffDefault != null) {
      _json["exponentialBackoffDefault"] = exponentialBackoffDefault;
    }
    if (features != null) {
      _json["features"] = features;
    }
    if (icons != null) {
      _json["icons"] = (icons).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (methods != null) {
      _json["methods"] = commons.mapMap(methods, (item) => (item).toJson());
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ownerDomain != null) {
      _json["ownerDomain"] = ownerDomain;
    }
    if (ownerName != null) {
      _json["ownerName"] = ownerName;
    }
    if (packagePath != null) {
      _json["packagePath"] = packagePath;
    }
    if (parameters != null) {
      _json["parameters"] = commons.mapMap(parameters, (item) => (item).toJson());
    }
    if (protocol != null) {
      _json["protocol"] = protocol;
    }
    if (resources != null) {
      _json["resources"] = commons.mapMap(resources, (item) => (item).toJson());
    }
    if (revision != null) {
      _json["revision"] = revision;
    }
    if (rootUrl != null) {
      _json["rootUrl"] = rootUrl;
    }
    if (schemas != null) {
      _json["schemas"] = commons.mapMap(schemas, (item) => (item).toJson());
    }
    if (servicePath != null) {
      _json["servicePath"] = servicePath;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (version != null) {
      _json["version"] = version;
    }
    if (versionModule != null) {
      _json["version_module"] = versionModule;
    }
    return _json;
  }
}

/** Supports the Resumable Media Upload protocol. */
class RestMethodMediaUploadProtocolsResumable {
  /** True if this endpoint supports uploading multipart media. */
  core.bool multipart;
  /**
   * The URI path to be used for upload. Should be used in conjunction with the
   * basePath property at the api-level.
   */
  core.String path;

  RestMethodMediaUploadProtocolsResumable();

  RestMethodMediaUploadProtocolsResumable.fromJson(core.Map _json) {
    if (_json.containsKey("multipart")) {
      multipart = _json["multipart"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (multipart != null) {
      _json["multipart"] = multipart;
    }
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/** Supports uploading as a single HTTP request. */
class RestMethodMediaUploadProtocolsSimple {
  /** True if this endpoint supports upload multipart media. */
  core.bool multipart;
  /**
   * The URI path to be used for upload. Should be used in conjunction with the
   * basePath property at the api-level.
   */
  core.String path;

  RestMethodMediaUploadProtocolsSimple();

  RestMethodMediaUploadProtocolsSimple.fromJson(core.Map _json) {
    if (_json.containsKey("multipart")) {
      multipart = _json["multipart"];
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (multipart != null) {
      _json["multipart"] = multipart;
    }
    if (path != null) {
      _json["path"] = path;
    }
    return _json;
  }
}

/** Supported upload protocols. */
class RestMethodMediaUploadProtocols {
  /** Supports the Resumable Media Upload protocol. */
  RestMethodMediaUploadProtocolsResumable resumable;
  /** Supports uploading as a single HTTP request. */
  RestMethodMediaUploadProtocolsSimple simple;

  RestMethodMediaUploadProtocols();

  RestMethodMediaUploadProtocols.fromJson(core.Map _json) {
    if (_json.containsKey("resumable")) {
      resumable = new RestMethodMediaUploadProtocolsResumable.fromJson(_json["resumable"]);
    }
    if (_json.containsKey("simple")) {
      simple = new RestMethodMediaUploadProtocolsSimple.fromJson(_json["simple"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resumable != null) {
      _json["resumable"] = (resumable).toJson();
    }
    if (simple != null) {
      _json["simple"] = (simple).toJson();
    }
    return _json;
  }
}

/** Media upload parameters. */
class RestMethodMediaUpload {
  /** MIME Media Ranges for acceptable media uploads to this method. */
  core.List<core.String> accept;
  /** Maximum size of a media upload, such as "1MB", "2GB" or "3TB". */
  core.String maxSize;
  /** Supported upload protocols. */
  RestMethodMediaUploadProtocols protocols;

  RestMethodMediaUpload();

  RestMethodMediaUpload.fromJson(core.Map _json) {
    if (_json.containsKey("accept")) {
      accept = _json["accept"];
    }
    if (_json.containsKey("maxSize")) {
      maxSize = _json["maxSize"];
    }
    if (_json.containsKey("protocols")) {
      protocols = new RestMethodMediaUploadProtocols.fromJson(_json["protocols"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accept != null) {
      _json["accept"] = accept;
    }
    if (maxSize != null) {
      _json["maxSize"] = maxSize;
    }
    if (protocols != null) {
      _json["protocols"] = (protocols).toJson();
    }
    return _json;
  }
}

/** The schema for the request. */
class RestMethodRequest {
  /** Schema ID for the request schema. */
  core.String P_ref;
  /** parameter name. */
  core.String parameterName;

  RestMethodRequest();

  RestMethodRequest.fromJson(core.Map _json) {
    if (_json.containsKey("\$ref")) {
      P_ref = _json["\$ref"];
    }
    if (_json.containsKey("parameterName")) {
      parameterName = _json["parameterName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (P_ref != null) {
      _json["\$ref"] = P_ref;
    }
    if (parameterName != null) {
      _json["parameterName"] = parameterName;
    }
    return _json;
  }
}

/** The schema for the response. */
class RestMethodResponse {
  /** Schema ID for the response schema. */
  core.String P_ref;

  RestMethodResponse();

  RestMethodResponse.fromJson(core.Map _json) {
    if (_json.containsKey("\$ref")) {
      P_ref = _json["\$ref"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (P_ref != null) {
      _json["\$ref"] = P_ref;
    }
    return _json;
  }
}

class RestMethod {
  /** Description of this method. */
  core.String description;
  /**
   * Whether this method requires an ETag to be specified. The ETag is sent as
   * an HTTP If-Match or If-None-Match header.
   */
  core.bool etagRequired;
  /** HTTP method used by this method. */
  core.String httpMethod;
  /**
   * A unique ID for this method. This property can be used to match methods
   * between different versions of Discovery.
   */
  core.String id;
  /** Media upload parameters. */
  RestMethodMediaUpload mediaUpload;
  /**
   * Ordered list of required parameters, serves as a hint to clients on how to
   * structure their method signatures. The array is ordered such that the
   * "most-significant" parameter appears first.
   */
  core.List<core.String> parameterOrder;
  /** Details for all parameters in this method. */
  core.Map<core.String, JsonSchema> parameters;
  /**
   * The URI path of this REST method. Should be used in conjunction with the
   * basePath property at the api-level.
   */
  core.String path;
  /** The schema for the request. */
  RestMethodRequest request;
  /** The schema for the response. */
  RestMethodResponse response;
  /** OAuth 2.0 scopes applicable to this method. */
  core.List<core.String> scopes;
  /** Whether this method supports media downloads. */
  core.bool supportsMediaDownload;
  /** Whether this method supports media uploads. */
  core.bool supportsMediaUpload;
  /** Whether this method supports subscriptions. */
  core.bool supportsSubscription;
  /**
   * Indicates that downloads from this method should use the download service
   * URL (i.e. "/download"). Only applies if the method supports media download.
   */
  core.bool useMediaDownloadService;

  RestMethod();

  RestMethod.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("etagRequired")) {
      etagRequired = _json["etagRequired"];
    }
    if (_json.containsKey("httpMethod")) {
      httpMethod = _json["httpMethod"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("mediaUpload")) {
      mediaUpload = new RestMethodMediaUpload.fromJson(_json["mediaUpload"]);
    }
    if (_json.containsKey("parameterOrder")) {
      parameterOrder = _json["parameterOrder"];
    }
    if (_json.containsKey("parameters")) {
      parameters = commons.mapMap(_json["parameters"], (item) => new JsonSchema.fromJson(item));
    }
    if (_json.containsKey("path")) {
      path = _json["path"];
    }
    if (_json.containsKey("request")) {
      request = new RestMethodRequest.fromJson(_json["request"]);
    }
    if (_json.containsKey("response")) {
      response = new RestMethodResponse.fromJson(_json["response"]);
    }
    if (_json.containsKey("scopes")) {
      scopes = _json["scopes"];
    }
    if (_json.containsKey("supportsMediaDownload")) {
      supportsMediaDownload = _json["supportsMediaDownload"];
    }
    if (_json.containsKey("supportsMediaUpload")) {
      supportsMediaUpload = _json["supportsMediaUpload"];
    }
    if (_json.containsKey("supportsSubscription")) {
      supportsSubscription = _json["supportsSubscription"];
    }
    if (_json.containsKey("useMediaDownloadService")) {
      useMediaDownloadService = _json["useMediaDownloadService"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (etagRequired != null) {
      _json["etagRequired"] = etagRequired;
    }
    if (httpMethod != null) {
      _json["httpMethod"] = httpMethod;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (mediaUpload != null) {
      _json["mediaUpload"] = (mediaUpload).toJson();
    }
    if (parameterOrder != null) {
      _json["parameterOrder"] = parameterOrder;
    }
    if (parameters != null) {
      _json["parameters"] = commons.mapMap(parameters, (item) => (item).toJson());
    }
    if (path != null) {
      _json["path"] = path;
    }
    if (request != null) {
      _json["request"] = (request).toJson();
    }
    if (response != null) {
      _json["response"] = (response).toJson();
    }
    if (scopes != null) {
      _json["scopes"] = scopes;
    }
    if (supportsMediaDownload != null) {
      _json["supportsMediaDownload"] = supportsMediaDownload;
    }
    if (supportsMediaUpload != null) {
      _json["supportsMediaUpload"] = supportsMediaUpload;
    }
    if (supportsSubscription != null) {
      _json["supportsSubscription"] = supportsSubscription;
    }
    if (useMediaDownloadService != null) {
      _json["useMediaDownloadService"] = useMediaDownloadService;
    }
    return _json;
  }
}

class RestResource {
  /** Methods on this resource. */
  core.Map<core.String, RestMethod> methods;
  /** Sub-resources on this resource. */
  core.Map<core.String, RestResource> resources;

  RestResource();

  RestResource.fromJson(core.Map _json) {
    if (_json.containsKey("methods")) {
      methods = commons.mapMap(_json["methods"], (item) => new RestMethod.fromJson(item));
    }
    if (_json.containsKey("resources")) {
      resources = commons.mapMap(_json["resources"], (item) => new RestResource.fromJson(item));
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (methods != null) {
      _json["methods"] = commons.mapMap(methods, (item) => (item).toJson());
    }
    if (resources != null) {
      _json["resources"] = commons.mapMap(resources, (item) => (item).toJson());
    }
    return _json;
  }
}
