// This is a generated file (see the discoveryapis_generator project).

library googleapis.people.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client people/v1';

/** Provides access to information about profiles and contacts. */
class PeopleApi {
  /** Manage your contacts */
  static const ContactsScope = "https://www.googleapis.com/auth/contacts";

  /** View your contacts */
  static const ContactsReadonlyScope = "https://www.googleapis.com/auth/contacts.readonly";

  /** Know the list of people in your circles, your age range, and language */
  static const PlusLoginScope = "https://www.googleapis.com/auth/plus.login";

  /** View your street addresses */
  static const UserAddressesReadScope = "https://www.googleapis.com/auth/user.addresses.read";

  /** View your complete date of birth */
  static const UserBirthdayReadScope = "https://www.googleapis.com/auth/user.birthday.read";

  /** View your email addresses */
  static const UserEmailsReadScope = "https://www.googleapis.com/auth/user.emails.read";

  /** View your phone numbers */
  static const UserPhonenumbersReadScope = "https://www.googleapis.com/auth/user.phonenumbers.read";

  /** View your email address */
  static const UserinfoEmailScope = "https://www.googleapis.com/auth/userinfo.email";

  /** View your basic profile info */
  static const UserinfoProfileScope = "https://www.googleapis.com/auth/userinfo.profile";


  final commons.ApiRequester _requester;

  PeopleResourceApi get people => new PeopleResourceApi(_requester);

  PeopleApi(http.Client client, {core.String rootUrl: "https://people.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class PeopleResourceApi {
  final commons.ApiRequester _requester;

  PeopleConnectionsResourceApi get connections => new PeopleConnectionsResourceApi(_requester);

  PeopleResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Provides information about a person resource for a resource name. Use
   * `people/me` to indicate the authenticated user.
   *
   * Request parameters:
   *
   * [resourceName] - The resource name of the person to provide information
   * about.
   *
   * - To get information about the authenticated user, specify `people/me`.
   * - To get information about any user, specify the resource name that
   *   identifies the user, such as the resource names returned by
   * [`people.connections.list`](/people/api/rest/v1/people.connections/list).
   * Value must have pattern "^people/[^/]+$".
   *
   * [requestMask_includeField] - Comma-separated list of fields to be included
   * in the response. Omitting
   * this field will include all fields except for connections.list requests,
   * which have a default mask that includes common fields like metadata, name,
   * photo, and profile url.
   * Each path should start with `person.`: for example, `person.names` or
   * `person.photos`.
   *
   * Completes with a [Person].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Person> get(core.String resourceName, {core.String requestMask_includeField}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (resourceName == null) {
      throw new core.ArgumentError("Parameter resourceName is required.");
    }
    if (requestMask_includeField != null) {
      _queryParams["requestMask.includeField"] = [requestMask_includeField];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resourceName');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Person.fromJson(data));
  }

  /**
   * Provides information about a list of specific people by specifying a list
   * of requested resource names. Use `people/me` to indicate the authenticated
   * user.
   *
   * Request parameters:
   *
   * [requestMask_includeField] - Comma-separated list of fields to be included
   * in the response. Omitting
   * this field will include all fields except for connections.list requests,
   * which have a default mask that includes common fields like metadata, name,
   * photo, and profile url.
   * Each path should start with `person.`: for example, `person.names` or
   * `person.photos`.
   *
   * [resourceNames] - The resource name, such as one returned by
   * [`people.connections.list`](/people/api/rest/v1/people.connections/list),
   * of one of the people to provide information about. You can include this
   * parameter up to 50 times in one request.
   *
   * Completes with a [GetPeopleResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetPeopleResponse> getBatchGet({core.String requestMask_includeField, core.List<core.String> resourceNames}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (requestMask_includeField != null) {
      _queryParams["requestMask.includeField"] = [requestMask_includeField];
    }
    if (resourceNames != null) {
      _queryParams["resourceNames"] = resourceNames;
    }

    _url = 'v1/people:batchGet';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetPeopleResponse.fromJson(data));
  }

}


class PeopleConnectionsResourceApi {
  final commons.ApiRequester _requester;

  PeopleConnectionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Provides a list of the authenticated user's contacts merged with any
   * linked profiles.
   *
   * Request parameters:
   *
   * [resourceName] - The resource name to return connections for. Only
   * `people/me` is valid.
   * Value must have pattern "^people/[^/]+$".
   *
   * [requestSyncToken] - Whether the response should include a sync token,
   * which can be used to get
   * all changes since the last request.
   *
   * [pageToken] - The token of the page to be returned.
   *
   * [requestMask_includeField] - Comma-separated list of fields to be included
   * in the response. Omitting
   * this field will include all fields except for connections.list requests,
   * which have a default mask that includes common fields like metadata, name,
   * photo, and profile url.
   * Each path should start with `person.`: for example, `person.names` or
   * `person.photos`.
   *
   * [pageSize] - The number of connections to include in the response. Valid
   * values are
   * between 1 and 500, inclusive. Defaults to 100.
   *
   * [syncToken] - A sync token, returned by a previous call to
   * `people.connections.list`.
   * Only resources changed since the sync token was created will be returned.
   *
   * [sortOrder] - The order in which the connections should be sorted. Defaults
   * to
   * `LAST_MODIFIED_ASCENDING`.
   * Possible string values are:
   * - "LAST_MODIFIED_ASCENDING" : A LAST_MODIFIED_ASCENDING.
   * - "FIRST_NAME_ASCENDING" : A FIRST_NAME_ASCENDING.
   * - "LAST_NAME_ASCENDING" : A LAST_NAME_ASCENDING.
   *
   * Completes with a [ListConnectionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListConnectionsResponse> list(core.String resourceName, {core.bool requestSyncToken, core.String pageToken, core.String requestMask_includeField, core.int pageSize, core.String syncToken, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (resourceName == null) {
      throw new core.ArgumentError("Parameter resourceName is required.");
    }
    if (requestSyncToken != null) {
      _queryParams["requestSyncToken"] = ["${requestSyncToken}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (requestMask_includeField != null) {
      _queryParams["requestMask.includeField"] = [requestMask_includeField];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (syncToken != null) {
      _queryParams["syncToken"] = [syncToken];
    }
    if (sortOrder != null) {
      _queryParams["sortOrder"] = [sortOrder];
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resourceName') + '/connections';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListConnectionsResponse.fromJson(data));
  }

}



/**
 * A person's physical address. May be a P.O. box or street address. All fields
 * are optional.
 */
class Address {
  /** The city of the address. */
  core.String city;
  /** The country of the address. */
  core.String country;
  /**
   * The [ISO 3166-1 alpha-2](http://www.iso.org/iso/country_codes.htm) country
   * code of the address.
   */
  core.String countryCode;
  /**
   * The extended address of the address; for example, the apartment number.
   */
  core.String extendedAddress;
  /**
   * The read-only type of the address translated and formatted in the viewer's
   * account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /**
   * The unstructured value of the address. If this is not set by the user it
   * will be automatically constructed from structured values.
   */
  core.String formattedValue;
  /** Metadata about the address. */
  FieldMetadata metadata;
  /** The P.O. box of the address. */
  core.String poBox;
  /** The postal code of the address. */
  core.String postalCode;
  /** The region of the address; for example, the state or province. */
  core.String region;
  /** The street address. */
  core.String streetAddress;
  /**
   * The type of the address. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `home`
   * * `work`
   * * `other`
   */
  core.String type;

  Address();

  Address.fromJson(core.Map _json) {
    if (_json.containsKey("city")) {
      city = _json["city"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("extendedAddress")) {
      extendedAddress = _json["extendedAddress"];
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("formattedValue")) {
      formattedValue = _json["formattedValue"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("poBox")) {
      poBox = _json["poBox"];
    }
    if (_json.containsKey("postalCode")) {
      postalCode = _json["postalCode"];
    }
    if (_json.containsKey("region")) {
      region = _json["region"];
    }
    if (_json.containsKey("streetAddress")) {
      streetAddress = _json["streetAddress"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (city != null) {
      _json["city"] = city;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (extendedAddress != null) {
      _json["extendedAddress"] = extendedAddress;
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (formattedValue != null) {
      _json["formattedValue"] = formattedValue;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (poBox != null) {
      _json["poBox"] = poBox;
    }
    if (postalCode != null) {
      _json["postalCode"] = postalCode;
    }
    if (region != null) {
      _json["region"] = region;
    }
    if (streetAddress != null) {
      _json["streetAddress"] = streetAddress;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A person's age range. */
class AgeRangeType {
  /**
   * The age range.
   * Possible string values are:
   * - "AGE_RANGE_UNSPECIFIED" : Unspecified.
   * - "LESS_THAN_EIGHTEEN" : Younger than eighteen.
   * - "EIGHTEEN_TO_TWENTY" : Between eighteen and twenty.
   * - "TWENTY_ONE_OR_OLDER" : Twenty-one and older.
   */
  core.String ageRange;
  /** Metadata about the age range. */
  FieldMetadata metadata;

  AgeRangeType();

  AgeRangeType.fromJson(core.Map _json) {
    if (_json.containsKey("ageRange")) {
      ageRange = _json["ageRange"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ageRange != null) {
      _json["ageRange"] = ageRange;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    return _json;
  }
}

/** A person's short biography. */
class Biography {
  /**
   * The content type of the biography.
   * Possible string values are:
   * - "CONTENT_TYPE_UNSPECIFIED" : Unspecified.
   * - "TEXT_PLAIN" : Plain text.
   * - "TEXT_HTML" : HTML text.
   */
  core.String contentType;
  /** Metadata about the biography. */
  FieldMetadata metadata;
  /** The short biography. */
  core.String value;

  Biography();

  Biography.fromJson(core.Map _json) {
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * A person's birthday. At least one of the `date` and `text` fields are
 * specified. The `date` and `text` fields typically represent the same
 * date, but are not guaranteed to.
 */
class Birthday {
  /** The date of the birthday. */
  Date date;
  /** Metadata about the birthday. */
  FieldMetadata metadata;
  /** A free-form string representing the user's birthday. */
  core.String text;

  Birthday();

  Birthday.fromJson(core.Map _json) {
    if (_json.containsKey("date")) {
      date = new Date.fromJson(_json["date"]);
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (date != null) {
      _json["date"] = (date).toJson();
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

/** A person's bragging rights. */
class BraggingRights {
  /** Metadata about the bragging rights. */
  FieldMetadata metadata;
  /** The bragging rights; for example, `climbed mount everest`. */
  core.String value;

  BraggingRights();

  BraggingRights.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A Google contact group membership. */
class ContactGroupMembership {
  /**
   * The contact group ID for the contact group membership. The contact group
   * ID can be custom or predefined. Possible values include, but are not
   * limited to, the following:
   *
   * *  `myContacts`
   * *  `starred`
   * *  A numerical ID for user-created groups.
   */
  core.String contactGroupId;

  ContactGroupMembership();

  ContactGroupMembership.fromJson(core.Map _json) {
    if (_json.containsKey("contactGroupId")) {
      contactGroupId = _json["contactGroupId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contactGroupId != null) {
      _json["contactGroupId"] = contactGroupId;
    }
    return _json;
  }
}

/**
 * A person's read-only cover photo. A large image shown on the person's
 * profile page that represents who they are or what they care about.
 */
class CoverPhoto {
  /**
   * True if the cover photo is the default cover photo;
   * false if the cover photo is a user-provided cover photo.
   */
  core.bool default_;
  /** Metadata about the cover photo. */
  FieldMetadata metadata;
  /** The URL of the cover photo. */
  core.String url;

  CoverPhoto();

  CoverPhoto.fromJson(core.Map _json) {
    if (_json.containsKey("default")) {
      default_ = _json["default"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
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
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * Represents a whole calendar date, for example a date of birth. The time
 * of day and time zone are either specified elsewhere or are not
 * significant. The date is relative to the
 * [Proleptic Gregorian
 * Calendar](https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar).
 * The day may be 0 to represent a year and month where the day is not
 * significant. The year may be 0 to represent a month and day independent
 * of year; for example, anniversary date.
 */
class Date {
  /**
   * Day of month. Must be from 1 to 31 and valid for the year and month, or 0
   * if specifying a year/month where the day is not significant.
   */
  core.int day;
  /** Month of year. Must be from 1 to 12. */
  core.int month;
  /**
   * Year of date. Must be from 1 to 9999, or 0 if specifying a date without
   * a year.
   */
  core.int year;

  Date();

  Date.fromJson(core.Map _json) {
    if (_json.containsKey("day")) {
      day = _json["day"];
    }
    if (_json.containsKey("month")) {
      month = _json["month"];
    }
    if (_json.containsKey("year")) {
      year = _json["year"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (day != null) {
      _json["day"] = day;
    }
    if (month != null) {
      _json["month"] = month;
    }
    if (year != null) {
      _json["year"] = year;
    }
    return _json;
  }
}

/** A Google Apps Domain membership. */
class DomainMembership {
  /** True if the person is in the viewer's Google Apps domain. */
  core.bool inViewerDomain;

  DomainMembership();

  DomainMembership.fromJson(core.Map _json) {
    if (_json.containsKey("inViewerDomain")) {
      inViewerDomain = _json["inViewerDomain"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (inViewerDomain != null) {
      _json["inViewerDomain"] = inViewerDomain;
    }
    return _json;
  }
}

/** A person's email address. */
class EmailAddress {
  /** The display name of the email. */
  core.String displayName;
  /**
   * The read-only type of the email address translated and formatted in the
   * viewer's account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** Metadata about the email address. */
  FieldMetadata metadata;
  /**
   * The type of the email address. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `home`
   * * `work`
   * * `other`
   */
  core.String type;
  /** The email address. */
  core.String value;

  EmailAddress();

  EmailAddress.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
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
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
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

/** An event related to the person. */
class Event {
  /** The date of the event. */
  Date date;
  /**
   * The read-only type of the event translated and formatted in the
   * viewer's account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** Metadata about the event. */
  FieldMetadata metadata;
  /**
   * The type of the event. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `anniversary`
   * * `other`
   */
  core.String type;

  Event();

  Event.fromJson(core.Map _json) {
    if (_json.containsKey("date")) {
      date = new Date.fromJson(_json["date"]);
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (date != null) {
      _json["date"] = (date).toJson();
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Metadata about a field. */
class FieldMetadata {
  /**
   * True if the field is the primary field; false if the field is a secondary
   * field.
   */
  core.bool primary;
  /** The source of the field. */
  Source source;
  /**
   * True if the field is verified; false if the field is unverified. A
   * verified field is typically a name, email address, phone number, or
   * website that has been confirmed to be owned by the person.
   */
  core.bool verified;

  FieldMetadata();

  FieldMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("source")) {
      source = new Source.fromJson(_json["source"]);
    }
    if (_json.containsKey("verified")) {
      verified = _json["verified"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (verified != null) {
      _json["verified"] = verified;
    }
    return _json;
  }
}

/** A person's gender. */
class Gender {
  /**
   * The read-only value of the gender translated and formatted in the viewer's
   * account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedValue;
  /** Metadata about the gender. */
  FieldMetadata metadata;
  /**
   * The gender for the person. The gender can be custom or predefined.
   * Possible values include, but are not limited to, the
   * following:
   *
   * * `male`
   * * `female`
   * * `other`
   * * `unknown`
   */
  core.String value;

  Gender();

  Gender.fromJson(core.Map _json) {
    if (_json.containsKey("formattedValue")) {
      formattedValue = _json["formattedValue"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedValue != null) {
      _json["formattedValue"] = formattedValue;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class GetPeopleResponse {
  /** The response for each requested resource name. */
  core.List<PersonResponse> responses;

  GetPeopleResponse();

  GetPeopleResponse.fromJson(core.Map _json) {
    if (_json.containsKey("responses")) {
      responses = _json["responses"].map((value) => new PersonResponse.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (responses != null) {
      _json["responses"] = responses.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A person's instant messaging client. */
class ImClient {
  /**
   * The read-only protocol of the IM client formatted in the viewer's account
   * locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedProtocol;
  /**
   * The read-only type of the IM client translated and formatted in the
   * viewer's account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** Metadata about the IM client. */
  FieldMetadata metadata;
  /**
   * The protocol of the IM client. The protocol can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `aim`
   * * `msn`
   * * `yahoo`
   * * `skype`
   * * `qq`
   * * `googleTalk`
   * * `icq`
   * * `jabber`
   * * `netMeeting`
   */
  core.String protocol;
  /**
   * The type of the IM client. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `home`
   * * `work`
   * * `other`
   */
  core.String type;
  /** The user name used in the IM client. */
  core.String username;

  ImClient();

  ImClient.fromJson(core.Map _json) {
    if (_json.containsKey("formattedProtocol")) {
      formattedProtocol = _json["formattedProtocol"];
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("protocol")) {
      protocol = _json["protocol"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("username")) {
      username = _json["username"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedProtocol != null) {
      _json["formattedProtocol"] = formattedProtocol;
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (protocol != null) {
      _json["protocol"] = protocol;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (username != null) {
      _json["username"] = username;
    }
    return _json;
  }
}

/** One of the person's interests. */
class Interest {
  /** Metadata about the interest. */
  FieldMetadata metadata;
  /** The interest; for example, `stargazing`. */
  core.String value;

  Interest();

  Interest.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class ListConnectionsResponse {
  /** The list of people that the requestor is connected to. */
  core.List<Person> connections;
  /** The token that can be used to retrieve the next page of results. */
  core.String nextPageToken;
  /** The token that can be used to retrieve changes since the last request. */
  core.String nextSyncToken;

  ListConnectionsResponse();

  ListConnectionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("connections")) {
      connections = _json["connections"].map((value) => new Person.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("nextSyncToken")) {
      nextSyncToken = _json["nextSyncToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (connections != null) {
      _json["connections"] = connections.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (nextSyncToken != null) {
      _json["nextSyncToken"] = nextSyncToken;
    }
    return _json;
  }
}

/** A person's locale preference. */
class Locale {
  /** Metadata about the locale. */
  FieldMetadata metadata;
  /**
   * The well-formed [IETF BCP 47](https://tools.ietf.org/html/bcp47)
   * language tag representing the locale.
   */
  core.String value;

  Locale();

  Locale.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A person's read-only membership in a group. */
class Membership {
  /** The contact group membership. */
  ContactGroupMembership contactGroupMembership;
  /** The domain membership. */
  DomainMembership domainMembership;
  /** Metadata about the membership. */
  FieldMetadata metadata;

  Membership();

  Membership.fromJson(core.Map _json) {
    if (_json.containsKey("contactGroupMembership")) {
      contactGroupMembership = new ContactGroupMembership.fromJson(_json["contactGroupMembership"]);
    }
    if (_json.containsKey("domainMembership")) {
      domainMembership = new DomainMembership.fromJson(_json["domainMembership"]);
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contactGroupMembership != null) {
      _json["contactGroupMembership"] = (contactGroupMembership).toJson();
    }
    if (domainMembership != null) {
      _json["domainMembership"] = (domainMembership).toJson();
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    return _json;
  }
}

/** A person's name. If the name is a mononym, the family name is empty. */
class Name {
  /**
   * The read-only display name formatted according to the locale specified by
   * the viewer's account or the <code>Accept-Language</code> HTTP header.
   */
  core.String displayName;
  /**
   * The read-only display name with the last name first formatted according to
   * the locale specified by the viewer's account or the
   * <code>Accept-Language</code> HTTP header.
   */
  core.String displayNameLastFirst;
  /** The family name. */
  core.String familyName;
  /** The given name. */
  core.String givenName;
  /** The honorific prefixes, such as `Mrs.` or `Dr.` */
  core.String honorificPrefix;
  /** The honorific suffixes, such as `Jr.` */
  core.String honorificSuffix;
  /** Metadata about the name. */
  FieldMetadata metadata;
  /** The middle name(s). */
  core.String middleName;
  /** The family name spelled as it sounds. */
  core.String phoneticFamilyName;
  /** The full name spelled as it sounds. */
  core.String phoneticFullName;
  /** The given name spelled as it sounds. */
  core.String phoneticGivenName;
  /** The honorific prefixes spelled as they sound. */
  core.String phoneticHonorificPrefix;
  /** The honorific suffixes spelled as they sound. */
  core.String phoneticHonorificSuffix;
  /** The middle name(s) spelled as they sound. */
  core.String phoneticMiddleName;

  Name();

  Name.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("displayNameLastFirst")) {
      displayNameLastFirst = _json["displayNameLastFirst"];
    }
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("givenName")) {
      givenName = _json["givenName"];
    }
    if (_json.containsKey("honorificPrefix")) {
      honorificPrefix = _json["honorificPrefix"];
    }
    if (_json.containsKey("honorificSuffix")) {
      honorificSuffix = _json["honorificSuffix"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("middleName")) {
      middleName = _json["middleName"];
    }
    if (_json.containsKey("phoneticFamilyName")) {
      phoneticFamilyName = _json["phoneticFamilyName"];
    }
    if (_json.containsKey("phoneticFullName")) {
      phoneticFullName = _json["phoneticFullName"];
    }
    if (_json.containsKey("phoneticGivenName")) {
      phoneticGivenName = _json["phoneticGivenName"];
    }
    if (_json.containsKey("phoneticHonorificPrefix")) {
      phoneticHonorificPrefix = _json["phoneticHonorificPrefix"];
    }
    if (_json.containsKey("phoneticHonorificSuffix")) {
      phoneticHonorificSuffix = _json["phoneticHonorificSuffix"];
    }
    if (_json.containsKey("phoneticMiddleName")) {
      phoneticMiddleName = _json["phoneticMiddleName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (displayNameLastFirst != null) {
      _json["displayNameLastFirst"] = displayNameLastFirst;
    }
    if (familyName != null) {
      _json["familyName"] = familyName;
    }
    if (givenName != null) {
      _json["givenName"] = givenName;
    }
    if (honorificPrefix != null) {
      _json["honorificPrefix"] = honorificPrefix;
    }
    if (honorificSuffix != null) {
      _json["honorificSuffix"] = honorificSuffix;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (middleName != null) {
      _json["middleName"] = middleName;
    }
    if (phoneticFamilyName != null) {
      _json["phoneticFamilyName"] = phoneticFamilyName;
    }
    if (phoneticFullName != null) {
      _json["phoneticFullName"] = phoneticFullName;
    }
    if (phoneticGivenName != null) {
      _json["phoneticGivenName"] = phoneticGivenName;
    }
    if (phoneticHonorificPrefix != null) {
      _json["phoneticHonorificPrefix"] = phoneticHonorificPrefix;
    }
    if (phoneticHonorificSuffix != null) {
      _json["phoneticHonorificSuffix"] = phoneticHonorificSuffix;
    }
    if (phoneticMiddleName != null) {
      _json["phoneticMiddleName"] = phoneticMiddleName;
    }
    return _json;
  }
}

/** A person's nickname. */
class Nickname {
  /** Metadata about the nickname. */
  FieldMetadata metadata;
  /**
   * The type of the nickname.
   * Possible string values are:
   * - "DEFAULT" : Generic nickname.
   * - "MAIDEN_NAME" : Maiden name or birth family name. Used when the person's
   * family name has
   * changed as a result of marriage.
   * - "INITIALS" : Initials.
   * - "GPLUS" : Google+ profile nickname.
   * - "OTHER_NAME" : A professional affiliation or other name; for example,
   * `Dr. Smith.`
   */
  core.String type;
  /** The nickname. */
  core.String value;

  Nickname();

  Nickname.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
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
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
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

/** A person's occupation. */
class Occupation {
  /** Metadata about the occupation. */
  FieldMetadata metadata;
  /** The occupation; for example, `carpenter`. */
  core.String value;

  Occupation();

  Occupation.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * A person's past or current organization. Overlapping date ranges are
 * permitted.
 */
class Organization {
  /**
   * True if the organization is the person's current organization;
   * false if the organization is a past organization.
   */
  core.bool current;
  /** The person's department at the organization. */
  core.String department;
  /**
   * The domain name associated with the organization; for example,
   * `google.com`.
   */
  core.String domain;
  /** The end date when the person left the organization. */
  Date endDate;
  /**
   * The read-only type of the organization translated and formatted in the
   * viewer's account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** The person's job description at the organization. */
  core.String jobDescription;
  /** The location of the organization office the person works at. */
  core.String location;
  /** Metadata about the organization. */
  FieldMetadata metadata;
  /** The name of the organization. */
  core.String name;
  /** The phonetic name of the organization. */
  core.String phoneticName;
  /** The start date when the person joined the organization. */
  Date startDate;
  /**
   * The symbol associated with the organization; for example, a stock ticker
   * symbol, abbreviation, or acronym.
   */
  core.String symbol;
  /** The person's job title at the organization. */
  core.String title;
  /**
   * The type of the organization. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `work`
   * * `school`
   */
  core.String type;

  Organization();

  Organization.fromJson(core.Map _json) {
    if (_json.containsKey("current")) {
      current = _json["current"];
    }
    if (_json.containsKey("department")) {
      department = _json["department"];
    }
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("endDate")) {
      endDate = new Date.fromJson(_json["endDate"]);
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("jobDescription")) {
      jobDescription = _json["jobDescription"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("phoneticName")) {
      phoneticName = _json["phoneticName"];
    }
    if (_json.containsKey("startDate")) {
      startDate = new Date.fromJson(_json["startDate"]);
    }
    if (_json.containsKey("symbol")) {
      symbol = _json["symbol"];
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
    if (current != null) {
      _json["current"] = current;
    }
    if (department != null) {
      _json["department"] = department;
    }
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (endDate != null) {
      _json["endDate"] = (endDate).toJson();
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (jobDescription != null) {
      _json["jobDescription"] = jobDescription;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (phoneticName != null) {
      _json["phoneticName"] = phoneticName;
    }
    if (startDate != null) {
      _json["startDate"] = (startDate).toJson();
    }
    if (symbol != null) {
      _json["symbol"] = symbol;
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

/**
 * Information about a person merged from various data sources such as the
 * authenticated user's contacts and profile data. Fields other than IDs,
 * metadata, and group memberships are user-edited.
 *
 * Most fields can have multiple items. The items in a field have no guaranteed
 * order, but each non-empty field is guaranteed to have exactly one field with
 * `metadata.primary` set to true.
 * NEXT_ID: 31
 */
class Person {
  /** The person's street addresses. */
  core.List<Address> addresses;
  /**
   * DEPRECATED(Please read person.age_ranges instead). The person's age range.
   * Possible string values are:
   * - "AGE_RANGE_UNSPECIFIED" : Unspecified.
   * - "LESS_THAN_EIGHTEEN" : Younger than eighteen.
   * - "EIGHTEEN_TO_TWENTY" : Between eighteen and twenty.
   * - "TWENTY_ONE_OR_OLDER" : Twenty-one and older.
   */
  core.String ageRange;
  /** The person's age ranges. */
  core.List<AgeRangeType> ageRanges;
  /** The person's biographies. */
  core.List<Biography> biographies;
  /** The person's birthdays. */
  core.List<Birthday> birthdays;
  /** The person's bragging rights. */
  core.List<BraggingRights> braggingRights;
  /** The person's cover photos. */
  core.List<CoverPhoto> coverPhotos;
  /** The person's email addresses. */
  core.List<EmailAddress> emailAddresses;
  /**
   * The [HTTP entity tag](https://en.wikipedia.org/wiki/HTTP_ETag) of the
   * resource. Used for web cache validation.
   */
  core.String etag;
  /** The person's events. */
  core.List<Event> events;
  /** The person's genders. */
  core.List<Gender> genders;
  /** The person's instant messaging clients. */
  core.List<ImClient> imClients;
  /** The person's interests. */
  core.List<Interest> interests;
  /** The person's locale preferences. */
  core.List<Locale> locales;
  /** The person's group memberships. */
  core.List<Membership> memberships;
  /** Metadata about the person. */
  PersonMetadata metadata;
  /** The person's names. */
  core.List<Name> names;
  /** The person's nicknames. */
  core.List<Nickname> nicknames;
  /** The person's occupations. */
  core.List<Occupation> occupations;
  /** The person's past or current organizations. */
  core.List<Organization> organizations;
  /** The person's phone numbers. */
  core.List<PhoneNumber> phoneNumbers;
  /** The person's photos. */
  core.List<Photo> photos;
  /** The person's relations. */
  core.List<Relation> relations;
  /** The kind of relationship the person is looking for. */
  core.List<RelationshipInterest> relationshipInterests;
  /** The person's relationship statuses. */
  core.List<RelationshipStatus> relationshipStatuses;
  /** The person's residences. */
  core.List<Residence> residences;
  /**
   * The resource name for the person, assigned by the server. An ASCII string
   * with a max length of 27 characters. Always starts with `people/`.
   */
  core.String resourceName;
  /** The person's skills. */
  core.List<Skill> skills;
  /** The person's taglines. */
  core.List<Tagline> taglines;
  /** The person's associated URLs. */
  core.List<Url> urls;

  Person();

  Person.fromJson(core.Map _json) {
    if (_json.containsKey("addresses")) {
      addresses = _json["addresses"].map((value) => new Address.fromJson(value)).toList();
    }
    if (_json.containsKey("ageRange")) {
      ageRange = _json["ageRange"];
    }
    if (_json.containsKey("ageRanges")) {
      ageRanges = _json["ageRanges"].map((value) => new AgeRangeType.fromJson(value)).toList();
    }
    if (_json.containsKey("biographies")) {
      biographies = _json["biographies"].map((value) => new Biography.fromJson(value)).toList();
    }
    if (_json.containsKey("birthdays")) {
      birthdays = _json["birthdays"].map((value) => new Birthday.fromJson(value)).toList();
    }
    if (_json.containsKey("braggingRights")) {
      braggingRights = _json["braggingRights"].map((value) => new BraggingRights.fromJson(value)).toList();
    }
    if (_json.containsKey("coverPhotos")) {
      coverPhotos = _json["coverPhotos"].map((value) => new CoverPhoto.fromJson(value)).toList();
    }
    if (_json.containsKey("emailAddresses")) {
      emailAddresses = _json["emailAddresses"].map((value) => new EmailAddress.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("events")) {
      events = _json["events"].map((value) => new Event.fromJson(value)).toList();
    }
    if (_json.containsKey("genders")) {
      genders = _json["genders"].map((value) => new Gender.fromJson(value)).toList();
    }
    if (_json.containsKey("imClients")) {
      imClients = _json["imClients"].map((value) => new ImClient.fromJson(value)).toList();
    }
    if (_json.containsKey("interests")) {
      interests = _json["interests"].map((value) => new Interest.fromJson(value)).toList();
    }
    if (_json.containsKey("locales")) {
      locales = _json["locales"].map((value) => new Locale.fromJson(value)).toList();
    }
    if (_json.containsKey("memberships")) {
      memberships = _json["memberships"].map((value) => new Membership.fromJson(value)).toList();
    }
    if (_json.containsKey("metadata")) {
      metadata = new PersonMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("names")) {
      names = _json["names"].map((value) => new Name.fromJson(value)).toList();
    }
    if (_json.containsKey("nicknames")) {
      nicknames = _json["nicknames"].map((value) => new Nickname.fromJson(value)).toList();
    }
    if (_json.containsKey("occupations")) {
      occupations = _json["occupations"].map((value) => new Occupation.fromJson(value)).toList();
    }
    if (_json.containsKey("organizations")) {
      organizations = _json["organizations"].map((value) => new Organization.fromJson(value)).toList();
    }
    if (_json.containsKey("phoneNumbers")) {
      phoneNumbers = _json["phoneNumbers"].map((value) => new PhoneNumber.fromJson(value)).toList();
    }
    if (_json.containsKey("photos")) {
      photos = _json["photos"].map((value) => new Photo.fromJson(value)).toList();
    }
    if (_json.containsKey("relations")) {
      relations = _json["relations"].map((value) => new Relation.fromJson(value)).toList();
    }
    if (_json.containsKey("relationshipInterests")) {
      relationshipInterests = _json["relationshipInterests"].map((value) => new RelationshipInterest.fromJson(value)).toList();
    }
    if (_json.containsKey("relationshipStatuses")) {
      relationshipStatuses = _json["relationshipStatuses"].map((value) => new RelationshipStatus.fromJson(value)).toList();
    }
    if (_json.containsKey("residences")) {
      residences = _json["residences"].map((value) => new Residence.fromJson(value)).toList();
    }
    if (_json.containsKey("resourceName")) {
      resourceName = _json["resourceName"];
    }
    if (_json.containsKey("skills")) {
      skills = _json["skills"].map((value) => new Skill.fromJson(value)).toList();
    }
    if (_json.containsKey("taglines")) {
      taglines = _json["taglines"].map((value) => new Tagline.fromJson(value)).toList();
    }
    if (_json.containsKey("urls")) {
      urls = _json["urls"].map((value) => new Url.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addresses != null) {
      _json["addresses"] = addresses.map((value) => (value).toJson()).toList();
    }
    if (ageRange != null) {
      _json["ageRange"] = ageRange;
    }
    if (ageRanges != null) {
      _json["ageRanges"] = ageRanges.map((value) => (value).toJson()).toList();
    }
    if (biographies != null) {
      _json["biographies"] = biographies.map((value) => (value).toJson()).toList();
    }
    if (birthdays != null) {
      _json["birthdays"] = birthdays.map((value) => (value).toJson()).toList();
    }
    if (braggingRights != null) {
      _json["braggingRights"] = braggingRights.map((value) => (value).toJson()).toList();
    }
    if (coverPhotos != null) {
      _json["coverPhotos"] = coverPhotos.map((value) => (value).toJson()).toList();
    }
    if (emailAddresses != null) {
      _json["emailAddresses"] = emailAddresses.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (events != null) {
      _json["events"] = events.map((value) => (value).toJson()).toList();
    }
    if (genders != null) {
      _json["genders"] = genders.map((value) => (value).toJson()).toList();
    }
    if (imClients != null) {
      _json["imClients"] = imClients.map((value) => (value).toJson()).toList();
    }
    if (interests != null) {
      _json["interests"] = interests.map((value) => (value).toJson()).toList();
    }
    if (locales != null) {
      _json["locales"] = locales.map((value) => (value).toJson()).toList();
    }
    if (memberships != null) {
      _json["memberships"] = memberships.map((value) => (value).toJson()).toList();
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (names != null) {
      _json["names"] = names.map((value) => (value).toJson()).toList();
    }
    if (nicknames != null) {
      _json["nicknames"] = nicknames.map((value) => (value).toJson()).toList();
    }
    if (occupations != null) {
      _json["occupations"] = occupations.map((value) => (value).toJson()).toList();
    }
    if (organizations != null) {
      _json["organizations"] = organizations.map((value) => (value).toJson()).toList();
    }
    if (phoneNumbers != null) {
      _json["phoneNumbers"] = phoneNumbers.map((value) => (value).toJson()).toList();
    }
    if (photos != null) {
      _json["photos"] = photos.map((value) => (value).toJson()).toList();
    }
    if (relations != null) {
      _json["relations"] = relations.map((value) => (value).toJson()).toList();
    }
    if (relationshipInterests != null) {
      _json["relationshipInterests"] = relationshipInterests.map((value) => (value).toJson()).toList();
    }
    if (relationshipStatuses != null) {
      _json["relationshipStatuses"] = relationshipStatuses.map((value) => (value).toJson()).toList();
    }
    if (residences != null) {
      _json["residences"] = residences.map((value) => (value).toJson()).toList();
    }
    if (resourceName != null) {
      _json["resourceName"] = resourceName;
    }
    if (skills != null) {
      _json["skills"] = skills.map((value) => (value).toJson()).toList();
    }
    if (taglines != null) {
      _json["taglines"] = taglines.map((value) => (value).toJson()).toList();
    }
    if (urls != null) {
      _json["urls"] = urls.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The read-only metadata about a person. */
class PersonMetadata {
  /**
   * True if the person resource has been deleted. Populated only for
   * [`connections.list`](/people/api/rest/v1/people.connections/list) requests
   * that include a sync token.
   */
  core.bool deleted;
  /** Resource names of people linked to this resource. */
  core.List<core.String> linkedPeopleResourceNames;
  /**
   * DEPRECATED(Please read person.metadata.sources.profile_metadata instead).
   * The type of the person object.
   * Possible string values are:
   * - "OBJECT_TYPE_UNSPECIFIED" : Unspecified.
   * - "PERSON" : Person.
   * - "PAGE" : [Google+ Page.](http://www.google.com/+/brands/)
   */
  core.String objectType;
  /**
   * Any former resource names this person has had. Populated only for
   * [`connections.list`](/people/api/rest/v1/people.connections/list) requests
   * that include a sync token.
   *
   * The resource name may change when adding or removing fields that link a
   * contact and profile such as a verified email, verified phone number, or
   * profile URL.
   */
  core.List<core.String> previousResourceNames;
  /** The sources of data for the person. */
  core.List<Source> sources;

  PersonMetadata();

  PersonMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("linkedPeopleResourceNames")) {
      linkedPeopleResourceNames = _json["linkedPeopleResourceNames"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("previousResourceNames")) {
      previousResourceNames = _json["previousResourceNames"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (linkedPeopleResourceNames != null) {
      _json["linkedPeopleResourceNames"] = linkedPeopleResourceNames;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (previousResourceNames != null) {
      _json["previousResourceNames"] = previousResourceNames;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The response for a single person */
class PersonResponse {
  /**
   * [HTTP 1.1 status
   * code](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).
   */
  core.int httpStatusCode;
  /** The person. */
  Person person;
  /**
   * The original requested resource name. May be different than the resource
   * name on the returned person.
   *
   * The resource name can change when adding or removing fields that link a
   * contact and profile such as a verified email, verified phone number, or a
   * profile URL.
   */
  core.String requestedResourceName;

  PersonResponse();

  PersonResponse.fromJson(core.Map _json) {
    if (_json.containsKey("httpStatusCode")) {
      httpStatusCode = _json["httpStatusCode"];
    }
    if (_json.containsKey("person")) {
      person = new Person.fromJson(_json["person"]);
    }
    if (_json.containsKey("requestedResourceName")) {
      requestedResourceName = _json["requestedResourceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (httpStatusCode != null) {
      _json["httpStatusCode"] = httpStatusCode;
    }
    if (person != null) {
      _json["person"] = (person).toJson();
    }
    if (requestedResourceName != null) {
      _json["requestedResourceName"] = requestedResourceName;
    }
    return _json;
  }
}

/** A person's phone number. */
class PhoneNumber {
  /**
   * The read-only canonicalized [ITU-T
   * E.164](https://law.resource.org/pub/us/cfr/ibr/004/itu-t.E.164.1.2008.pdf)
   * form of the phone number.
   */
  core.String canonicalForm;
  /**
   * The read-only type of the phone number translated and formatted in the
   * viewer's account locale or the the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** Metadata about the phone number. */
  FieldMetadata metadata;
  /**
   * The type of the phone number. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `home`
   * * `work`
   * * `mobile`
   * * `homeFax`
   * * `workFax`
   * * `otherFax`
   * * `pager`
   * * `workMobile`
   * * `workPager`
   * * `main`
   * * `googleVoice`
   * * `other`
   */
  core.String type;
  /** The phone number. */
  core.String value;

  PhoneNumber();

  PhoneNumber.fromJson(core.Map _json) {
    if (_json.containsKey("canonicalForm")) {
      canonicalForm = _json["canonicalForm"];
    }
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
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
    if (canonicalForm != null) {
      _json["canonicalForm"] = canonicalForm;
    }
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
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

/**
 * A person's read-only photo. A picture shown next to the person's name to
 * help others recognize the person.
 */
class Photo {
  /** Metadata about the photo. */
  FieldMetadata metadata;
  /** The URL of the photo. */
  core.String url;

  Photo();

  Photo.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The read-only metadata about a profile. */
class ProfileMetadata {
  /**
   * The profile object type.
   * Possible string values are:
   * - "OBJECT_TYPE_UNSPECIFIED" : Unspecified.
   * - "PERSON" : Person.
   * - "PAGE" : [Google+ Page.](http://www.google.com/+/brands/)
   */
  core.String objectType;

  ProfileMetadata();

  ProfileMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    return _json;
  }
}

/** A person's relation to another person. */
class Relation {
  /**
   * The type of the relation translated and formatted in the viewer's account
   * locale or the locale specified in the Accept-Language HTTP header.
   */
  core.String formattedType;
  /** Metadata about the relation. */
  FieldMetadata metadata;
  /** The name of the other person this relation refers to. */
  core.String person;
  /**
   * The person's relation to the other person. The type can be custom or
   * predefined.
   * Possible values include, but are not limited to, the following values:
   *
   * * `spouse`
   * * `child`
   * * `mother`
   * * `father`
   * * `parent`
   * * `brother`
   * * `sister`
   * * `friend`
   * * `relative`
   * * `domesticPartner`
   * * `manager`
   * * `assistant`
   * * `referredBy`
   * * `partner`
   */
  core.String type;

  Relation();

  Relation.fromJson(core.Map _json) {
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("person")) {
      person = _json["person"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (person != null) {
      _json["person"] = person;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A person's read-only relationship interest . */
class RelationshipInterest {
  /**
   * The value of the relationship interest translated and formatted in the
   * viewer's account locale or the locale specified in the Accept-Language
   * HTTP header.
   */
  core.String formattedValue;
  /** Metadata about the relationship interest. */
  FieldMetadata metadata;
  /**
   * The kind of relationship the person is looking for. The value can be custom
   * or predefined. Possible values include, but are not limited to, the
   * following values:
   *
   * * `friend`
   * * `date`
   * * `relationship`
   * * `networking`
   */
  core.String value;

  RelationshipInterest();

  RelationshipInterest.fromJson(core.Map _json) {
    if (_json.containsKey("formattedValue")) {
      formattedValue = _json["formattedValue"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedValue != null) {
      _json["formattedValue"] = formattedValue;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A person's read-only relationship status. */
class RelationshipStatus {
  /**
   * The read-only value of the relationship status translated and formatted in
   * the viewer's account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedValue;
  /** Metadata about the relationship status. */
  FieldMetadata metadata;
  /**
   * The relationship status. The value can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `single`
   * * `inARelationship`
   * * `engaged`
   * * `married`
   * * `itsComplicated`
   * * `openRelationship`
   * * `widowed`
   * * `inDomesticPartnership`
   * * `inCivilUnion`
   */
  core.String value;

  RelationshipStatus();

  RelationshipStatus.fromJson(core.Map _json) {
    if (_json.containsKey("formattedValue")) {
      formattedValue = _json["formattedValue"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formattedValue != null) {
      _json["formattedValue"] = formattedValue;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A person's past or current residence. */
class Residence {
  /**
   * True if the residence is the person's current residence;
   * false if the residence is a past residence.
   */
  core.bool current;
  /** Metadata about the residence. */
  FieldMetadata metadata;
  /** The address of the residence. */
  core.String value;

  Residence();

  Residence.fromJson(core.Map _json) {
    if (_json.containsKey("current")) {
      current = _json["current"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (current != null) {
      _json["current"] = current;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A skill that the person has. */
class Skill {
  /** Metadata about the skill. */
  FieldMetadata metadata;
  /** The skill; for example, `underwater basket weaving`. */
  core.String value;

  Skill();

  Skill.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** The source of a field. */
class Source {
  /**
   * The [HTTP entity tag](https://en.wikipedia.org/wiki/HTTP_ETag) of the
   * source. Used for web cache validation. Only populated in
   * person.metadata.sources.
   */
  core.String etag;
  /** The unique identifier within the source type generated by the server. */
  core.String id;
  /** Metadata about a source of type PROFILE. */
  ProfileMetadata profileMetadata;
  /**
   * The source type.
   * Possible string values are:
   * - "SOURCE_TYPE_UNSPECIFIED" : Unspecified.
   * - "ACCOUNT" : [Google Account](https://accounts.google.com).
   * - "PROFILE" : [Google profile](https://profiles.google.com). You can view
   * the
   * profile at https://profiles.google.com/<id> where <id> is the source
   * id.
   * - "DOMAIN_PROFILE" : [Google Apps domain
   * profile](https://admin.google.com).
   * - "CONTACT" : [Google contact](https://contacts.google.com). You can view
   * the
   * contact at https://contact.google.com/<id> where <id> is the source
   * id.
   */
  core.String type;

  Source();

  Source.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("profileMetadata")) {
      profileMetadata = new ProfileMetadata.fromJson(_json["profileMetadata"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (profileMetadata != null) {
      _json["profileMetadata"] = (profileMetadata).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A read-only brief one-line description of the person. */
class Tagline {
  /** Metadata about the tagline. */
  FieldMetadata metadata;
  /** The tagline. */
  core.String value;

  Tagline();

  Tagline.fromJson(core.Map _json) {
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** A person's associated URLs. */
class Url {
  /**
   * The read-only type of the URL translated and formatted in the viewer's
   * account locale or the `Accept-Language` HTTP header locale.
   */
  core.String formattedType;
  /** Metadata about the URL. */
  FieldMetadata metadata;
  /**
   * The type of the URL. The type can be custom or predefined.
   * Possible values include, but are not limited to, the following:
   *
   * * `home`
   * * `work`
   * * `blog`
   * * `profile`
   * * `homePage`
   * * `ftp`
   * * `reservations`
   * * `appInstallPage`: website for a Google+ application.
   * * `other`
   */
  core.String type;
  /** The URL. */
  core.String value;

  Url();

  Url.fromJson(core.Map _json) {
    if (_json.containsKey("formattedType")) {
      formattedType = _json["formattedType"];
    }
    if (_json.containsKey("metadata")) {
      metadata = new FieldMetadata.fromJson(_json["metadata"]);
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
    if (formattedType != null) {
      _json["formattedType"] = formattedType;
    }
    if (metadata != null) {
      _json["metadata"] = (metadata).toJson();
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
