// This is a generated file (see the discoveryapis_generator project).

library googleapis.civicinfo.v2;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client civicinfo/v2';

/**
 * Provides polling places, early vote locations, contest data, election
 * officials, and government representatives for U.S. residential addresses.
 */
class CivicinfoApi {

  final commons.ApiRequester _requester;

  DivisionsResourceApi get divisions => new DivisionsResourceApi(_requester);
  ElectionsResourceApi get elections => new ElectionsResourceApi(_requester);
  RepresentativesResourceApi get representatives => new RepresentativesResourceApi(_requester);

  CivicinfoApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "civicinfo/v2/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class DivisionsResourceApi {
  final commons.ApiRequester _requester;

  DivisionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Searches for political divisions by their natural name or OCD ID.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [query] - The search query. Queries can cover any parts of a OCD ID or a
   * human readable division name. All words given in the query are treated as
   * required patterns. In addition to that, most query operators of the Apache
   * Lucene library are supported. See
   * http://lucene.apache.org/core/2_9_4/queryparsersyntax.html
   *
   * Completes with a [DivisionSearchResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DivisionSearchResponse> search(DivisionSearchRequest request, {core.String query}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (query != null) {
      _queryParams["query"] = [query];
    }

    _url = 'divisions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DivisionSearchResponse.fromJson(data));
  }

}


class ElectionsResourceApi {
  final commons.ApiRequester _requester;

  ElectionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List of available elections to query.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [ElectionsQueryResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ElectionsQueryResponse> electionQuery(ElectionsQueryRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'elections';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ElectionsQueryResponse.fromJson(data));
  }

  /**
   * Looks up information relevant to a voter based on the voter's registered
   * address.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [address] - The registered address of the voter to look up.
   *
   * [electionId] - The unique ID of the election to look up. A list of election
   * IDs can be obtained at
   * https://www.googleapis.com/civicinfo/{version}/elections
   *
   * [officialOnly] - If set to true, only data from official state sources will
   * be returned.
   *
   * [returnAllAvailableData] - If set to true, the query will return the
   * success codeand include any partial information when it is unable to
   * determine a matching address or unable to determine the election for
   * electionId=0 queries.
   *
   * Completes with a [VoterInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VoterInfoResponse> voterInfoQuery(VoterInfoRequest request, core.String address, {core.String electionId, core.bool officialOnly, core.bool returnAllAvailableData}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (address == null) {
      throw new core.ArgumentError("Parameter address is required.");
    }
    _queryParams["address"] = [address];
    if (electionId != null) {
      _queryParams["electionId"] = [electionId];
    }
    if (officialOnly != null) {
      _queryParams["officialOnly"] = ["${officialOnly}"];
    }
    if (returnAllAvailableData != null) {
      _queryParams["returnAllAvailableData"] = ["${returnAllAvailableData}"];
    }

    _url = 'voterinfo';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VoterInfoResponse.fromJson(data));
  }

}


class RepresentativesResourceApi {
  final commons.ApiRequester _requester;

  RepresentativesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Looks up political geography and representative information for a single
   * address.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [address] - The address to look up. May only be specified if the field
   * ocdId is not given in the URL.
   *
   * [includeOffices] - Whether to return information about offices and
   * officials. If false, only the top-level district information will be
   * returned.
   *
   * [levels] - A list of office levels to filter by. Only offices that serve at
   * least one of these levels will be returned. Divisions that don't contain a
   * matching office will not be returned.
   *
   * [roles] - A list of office roles to filter by. Only offices fulfilling one
   * of these roles will be returned. Divisions that don't contain a matching
   * office will not be returned.
   *
   * Completes with a [RepresentativeInfoResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RepresentativeInfoResponse> representativeInfoByAddress(RepresentativeInfoRequest request, {core.String address, core.bool includeOffices, core.List<core.String> levels, core.List<core.String> roles}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (address != null) {
      _queryParams["address"] = [address];
    }
    if (includeOffices != null) {
      _queryParams["includeOffices"] = ["${includeOffices}"];
    }
    if (levels != null) {
      _queryParams["levels"] = levels;
    }
    if (roles != null) {
      _queryParams["roles"] = roles;
    }

    _url = 'representatives';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RepresentativeInfoResponse.fromJson(data));
  }

  /**
   * Looks up representative information for a single geographic division.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [ocdId] - The Open Civic Data division identifier of the division to look
   * up.
   *
   * [levels] - A list of office levels to filter by. Only offices that serve at
   * least one of these levels will be returned. Divisions that don't contain a
   * matching office will not be returned.
   *
   * [recursive] - If true, information about all divisions contained in the
   * division requested will be included as well. For example, if querying
   * ocd-division/country:us/district:dc, this would also return all DC's wards
   * and ANCs.
   *
   * [roles] - A list of office roles to filter by. Only offices fulfilling one
   * of these roles will be returned. Divisions that don't contain a matching
   * office will not be returned.
   *
   * Completes with a [RepresentativeInfoData].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RepresentativeInfoData> representativeInfoByDivision(DivisionRepresentativeInfoRequest request, core.String ocdId, {core.List<core.String> levels, core.bool recursive, core.List<core.String> roles}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (ocdId == null) {
      throw new core.ArgumentError("Parameter ocdId is required.");
    }
    if (levels != null) {
      _queryParams["levels"] = levels;
    }
    if (recursive != null) {
      _queryParams["recursive"] = ["${recursive}"];
    }
    if (roles != null) {
      _queryParams["roles"] = roles;
    }

    _url = 'representatives/' + commons.Escaper.ecapeVariable('$ocdId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RepresentativeInfoData.fromJson(data));
  }

}



/** Describes information about a regional election administrative area. */
class AdministrationRegion {
  /** The election administration body for this area. */
  AdministrativeBody electionAdministrationBody;
  /**
   * An ID for this object. IDs may change in future requests and should not be
   * cached. Access to this field requires special access that can be requested
   * from the Request more link on the Quotas page.
   */
  core.String id;
  /**
   * The city or county that provides election information for this voter. This
   * object can have the same elements as state.
   */
  AdministrationRegion localJurisdiction;
  /** The name of the jurisdiction. */
  core.String name;
  /**
   * A list of sources for this area. If multiple sources are listed the data
   * has been aggregated from those sources.
   */
  core.List<Source> sources;

  AdministrationRegion();

  AdministrationRegion.fromJson(core.Map _json) {
    if (_json.containsKey("electionAdministrationBody")) {
      electionAdministrationBody = new AdministrativeBody.fromJson(_json["electionAdministrationBody"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("local_jurisdiction")) {
      localJurisdiction = new AdministrationRegion.fromJson(_json["local_jurisdiction"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (electionAdministrationBody != null) {
      _json["electionAdministrationBody"] = (electionAdministrationBody).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (localJurisdiction != null) {
      _json["local_jurisdiction"] = (localJurisdiction).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Information about an election administrative body (e.g. County Board of
 * Elections).
 */
class AdministrativeBody {
  /**
   * A URL provided by this administrative body for information on absentee
   * voting.
   */
  core.String absenteeVotingInfoUrl;
  core.List<core.String> addressLines;
  /**
   * A URL provided by this administrative body to give contest information to
   * the voter.
   */
  core.String ballotInfoUrl;
  /** The mailing address of this administrative body. */
  SimpleAddressType correspondenceAddress;
  /**
   * A URL provided by this administrative body for looking up general election
   * information.
   */
  core.String electionInfoUrl;
  /** The election officials for this election administrative body. */
  core.List<ElectionOfficial> electionOfficials;
  /**
   * A URL provided by this administrative body for confirming that the voter is
   * registered to vote.
   */
  core.String electionRegistrationConfirmationUrl;
  /**
   * A URL provided by this administrative body for looking up how to register
   * to vote.
   */
  core.String electionRegistrationUrl;
  /**
   * A URL provided by this administrative body describing election rules to the
   * voter.
   */
  core.String electionRulesUrl;
  /** A description of the hours of operation for this administrative body. */
  core.String hoursOfOperation;
  /** The name of this election administrative body. */
  core.String name;
  /** The physical address of this administrative body. */
  SimpleAddressType physicalAddress;
  /** A description of the services this administrative body may provide. */
  core.List<core.String> voterServices;
  /**
   * A URL provided by this administrative body for looking up where to vote.
   */
  core.String votingLocationFinderUrl;

  AdministrativeBody();

  AdministrativeBody.fromJson(core.Map _json) {
    if (_json.containsKey("absenteeVotingInfoUrl")) {
      absenteeVotingInfoUrl = _json["absenteeVotingInfoUrl"];
    }
    if (_json.containsKey("addressLines")) {
      addressLines = _json["addressLines"];
    }
    if (_json.containsKey("ballotInfoUrl")) {
      ballotInfoUrl = _json["ballotInfoUrl"];
    }
    if (_json.containsKey("correspondenceAddress")) {
      correspondenceAddress = new SimpleAddressType.fromJson(_json["correspondenceAddress"]);
    }
    if (_json.containsKey("electionInfoUrl")) {
      electionInfoUrl = _json["electionInfoUrl"];
    }
    if (_json.containsKey("electionOfficials")) {
      electionOfficials = _json["electionOfficials"].map((value) => new ElectionOfficial.fromJson(value)).toList();
    }
    if (_json.containsKey("electionRegistrationConfirmationUrl")) {
      electionRegistrationConfirmationUrl = _json["electionRegistrationConfirmationUrl"];
    }
    if (_json.containsKey("electionRegistrationUrl")) {
      electionRegistrationUrl = _json["electionRegistrationUrl"];
    }
    if (_json.containsKey("electionRulesUrl")) {
      electionRulesUrl = _json["electionRulesUrl"];
    }
    if (_json.containsKey("hoursOfOperation")) {
      hoursOfOperation = _json["hoursOfOperation"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("physicalAddress")) {
      physicalAddress = new SimpleAddressType.fromJson(_json["physicalAddress"]);
    }
    if (_json.containsKey("voter_services")) {
      voterServices = _json["voter_services"];
    }
    if (_json.containsKey("votingLocationFinderUrl")) {
      votingLocationFinderUrl = _json["votingLocationFinderUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (absenteeVotingInfoUrl != null) {
      _json["absenteeVotingInfoUrl"] = absenteeVotingInfoUrl;
    }
    if (addressLines != null) {
      _json["addressLines"] = addressLines;
    }
    if (ballotInfoUrl != null) {
      _json["ballotInfoUrl"] = ballotInfoUrl;
    }
    if (correspondenceAddress != null) {
      _json["correspondenceAddress"] = (correspondenceAddress).toJson();
    }
    if (electionInfoUrl != null) {
      _json["electionInfoUrl"] = electionInfoUrl;
    }
    if (electionOfficials != null) {
      _json["electionOfficials"] = electionOfficials.map((value) => (value).toJson()).toList();
    }
    if (electionRegistrationConfirmationUrl != null) {
      _json["electionRegistrationConfirmationUrl"] = electionRegistrationConfirmationUrl;
    }
    if (electionRegistrationUrl != null) {
      _json["electionRegistrationUrl"] = electionRegistrationUrl;
    }
    if (electionRulesUrl != null) {
      _json["electionRulesUrl"] = electionRulesUrl;
    }
    if (hoursOfOperation != null) {
      _json["hoursOfOperation"] = hoursOfOperation;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (physicalAddress != null) {
      _json["physicalAddress"] = (physicalAddress).toJson();
    }
    if (voterServices != null) {
      _json["voter_services"] = voterServices;
    }
    if (votingLocationFinderUrl != null) {
      _json["votingLocationFinderUrl"] = votingLocationFinderUrl;
    }
    return _json;
  }
}

/** Information about a candidate running for elected office. */
class Candidate {
  /** The URL for the candidate's campaign web site. */
  core.String candidateUrl;
  /** A list of known (social) media channels for this candidate. */
  core.List<Channel> channels;
  /** The email address for the candidate's campaign. */
  core.String email;
  /**
   * The candidate's name. If this is a joint ticket it will indicate the name
   * of the candidate at the top of a ticket followed by a / and that name of
   * candidate at the bottom of the ticket. e.g. "Mitt Romney / Paul Ryan"
   */
  core.String name;
  /** The order the candidate appears on the ballot for this contest. */
  core.String orderOnBallot;
  /** The full name of the party the candidate is a member of. */
  core.String party;
  /** The voice phone number for the candidate's campaign office. */
  core.String phone;
  /** A URL for a photo of the candidate. */
  core.String photoUrl;

  Candidate();

  Candidate.fromJson(core.Map _json) {
    if (_json.containsKey("candidateUrl")) {
      candidateUrl = _json["candidateUrl"];
    }
    if (_json.containsKey("channels")) {
      channels = _json["channels"].map((value) => new Channel.fromJson(value)).toList();
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("orderOnBallot")) {
      orderOnBallot = _json["orderOnBallot"];
    }
    if (_json.containsKey("party")) {
      party = _json["party"];
    }
    if (_json.containsKey("phone")) {
      phone = _json["phone"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (candidateUrl != null) {
      _json["candidateUrl"] = candidateUrl;
    }
    if (channels != null) {
      _json["channels"] = channels.map((value) => (value).toJson()).toList();
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (orderOnBallot != null) {
      _json["orderOnBallot"] = orderOnBallot;
    }
    if (party != null) {
      _json["party"] = party;
    }
    if (phone != null) {
      _json["phone"] = phone;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    return _json;
  }
}

/** A social media or web channel for a candidate. */
class Channel {
  /** The unique public identifier for the candidate's channel. */
  core.String id;
  /**
   * The type of channel. The following is a list of types of channels, but is
   * not exhaustive. More channel types may be added at a later time. One of:
   * GooglePlus, YouTube, Facebook, Twitter
   */
  core.String type;

  Channel();

  Channel.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Information about a contest that appears on a voter's ballot. */
class Contest {
  /**
   * A number specifying the position of this contest on the voter's ballot.
   */
  core.String ballotPlacement;
  /** The candidate choices for this contest. */
  core.List<Candidate> candidates;
  /** Information about the electoral district that this contest is in. */
  ElectoralDistrict district;
  /**
   * A description of any additional eligibility requirements for voting in this
   * contest.
   */
  core.String electorateSpecifications;
  /**
   * An ID for this object. IDs may change in future requests and should not be
   * cached. Access to this field requires special access that can be requested
   * from the Request more link on the Quotas page.
   */
  core.String id;
  /**
   * The levels of government of the office for this contest. There may be more
   * than one in cases where a jurisdiction effectively acts at two different
   * levels of government; for example, the mayor of the District of Columbia
   * acts at "locality" level, but also effectively at both
   * "administrative-area-2" and "administrative-area-1".
   */
  core.List<core.String> level;
  /**
   * The number of candidates that will be elected to office in this contest.
   */
  core.String numberElected;
  /** The number of candidates that a voter may vote for in this contest. */
  core.String numberVotingFor;
  /** The name of the office for this contest. */
  core.String office;
  /** If this is a partisan election, the name of the party it is for. */
  core.String primaryParty;
  /**
   * The set of ballot responses for the referendum. A ballot response
   * represents a line on the ballot. Common examples might include "yes" or
   * "no" for referenda. This field is only populated for contests of type
   * 'Referendum'.
   */
  core.List<core.String> referendumBallotResponses;
  /**
   * Specifies a short summary of the referendum that is typically on the ballot
   * below the title but above the text. This field is only populated for
   * contests of type 'Referendum'.
   */
  core.String referendumBrief;
  /**
   * A statement in opposition to the referendum. It does not necessarily appear
   * on the ballot. This field is only populated for contests of type
   * 'Referendum'.
   */
  core.String referendumConStatement;
  /**
   * Specifies what effect abstaining (not voting) on the proposition will have
   * (i.e. whether abstaining is considered a vote against it). This field is
   * only populated for contests of type 'Referendum'.
   */
  core.String referendumEffectOfAbstain;
  /**
   * The threshold of votes that the referendum needs in order to pass, e.g.
   * "two-thirds". This field is only populated for contests of type
   * 'Referendum'.
   */
  core.String referendumPassageThreshold;
  /**
   * A statement in favor of the referendum. It does not necessarily appear on
   * the ballot. This field is only populated for contests of type 'Referendum'.
   */
  core.String referendumProStatement;
  /**
   * A brief description of the referendum. This field is only populated for
   * contests of type 'Referendum'.
   */
  core.String referendumSubtitle;
  /**
   * The full text of the referendum. This field is only populated for contests
   * of type 'Referendum'.
   */
  core.String referendumText;
  /**
   * The title of the referendum (e.g. 'Proposition 42'). This field is only
   * populated for contests of type 'Referendum'.
   */
  core.String referendumTitle;
  /**
   * A link to the referendum. This field is only populated for contests of type
   * 'Referendum'.
   */
  core.String referendumUrl;
  /** The roles which this office fulfills. */
  core.List<core.String> roles;
  /**
   * A list of sources for this contest. If multiple sources are listed, the
   * data has been aggregated from those sources.
   */
  core.List<Source> sources;
  /**
   * "Yes" or "No" depending on whether this a contest being held outside the
   * normal election cycle.
   */
  core.String special;
  /**
   * The type of contest. Usually this will be 'General', 'Primary', or
   * 'Run-off' for contests with candidates. For referenda this will be
   * 'Referendum'. For Retention contests this will typically be 'Retention'.
   */
  core.String type;

  Contest();

  Contest.fromJson(core.Map _json) {
    if (_json.containsKey("ballotPlacement")) {
      ballotPlacement = _json["ballotPlacement"];
    }
    if (_json.containsKey("candidates")) {
      candidates = _json["candidates"].map((value) => new Candidate.fromJson(value)).toList();
    }
    if (_json.containsKey("district")) {
      district = new ElectoralDistrict.fromJson(_json["district"]);
    }
    if (_json.containsKey("electorateSpecifications")) {
      electorateSpecifications = _json["electorateSpecifications"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("level")) {
      level = _json["level"];
    }
    if (_json.containsKey("numberElected")) {
      numberElected = _json["numberElected"];
    }
    if (_json.containsKey("numberVotingFor")) {
      numberVotingFor = _json["numberVotingFor"];
    }
    if (_json.containsKey("office")) {
      office = _json["office"];
    }
    if (_json.containsKey("primaryParty")) {
      primaryParty = _json["primaryParty"];
    }
    if (_json.containsKey("referendumBallotResponses")) {
      referendumBallotResponses = _json["referendumBallotResponses"];
    }
    if (_json.containsKey("referendumBrief")) {
      referendumBrief = _json["referendumBrief"];
    }
    if (_json.containsKey("referendumConStatement")) {
      referendumConStatement = _json["referendumConStatement"];
    }
    if (_json.containsKey("referendumEffectOfAbstain")) {
      referendumEffectOfAbstain = _json["referendumEffectOfAbstain"];
    }
    if (_json.containsKey("referendumPassageThreshold")) {
      referendumPassageThreshold = _json["referendumPassageThreshold"];
    }
    if (_json.containsKey("referendumProStatement")) {
      referendumProStatement = _json["referendumProStatement"];
    }
    if (_json.containsKey("referendumSubtitle")) {
      referendumSubtitle = _json["referendumSubtitle"];
    }
    if (_json.containsKey("referendumText")) {
      referendumText = _json["referendumText"];
    }
    if (_json.containsKey("referendumTitle")) {
      referendumTitle = _json["referendumTitle"];
    }
    if (_json.containsKey("referendumUrl")) {
      referendumUrl = _json["referendumUrl"];
    }
    if (_json.containsKey("roles")) {
      roles = _json["roles"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
    if (_json.containsKey("special")) {
      special = _json["special"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ballotPlacement != null) {
      _json["ballotPlacement"] = ballotPlacement;
    }
    if (candidates != null) {
      _json["candidates"] = candidates.map((value) => (value).toJson()).toList();
    }
    if (district != null) {
      _json["district"] = (district).toJson();
    }
    if (electorateSpecifications != null) {
      _json["electorateSpecifications"] = electorateSpecifications;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (level != null) {
      _json["level"] = level;
    }
    if (numberElected != null) {
      _json["numberElected"] = numberElected;
    }
    if (numberVotingFor != null) {
      _json["numberVotingFor"] = numberVotingFor;
    }
    if (office != null) {
      _json["office"] = office;
    }
    if (primaryParty != null) {
      _json["primaryParty"] = primaryParty;
    }
    if (referendumBallotResponses != null) {
      _json["referendumBallotResponses"] = referendumBallotResponses;
    }
    if (referendumBrief != null) {
      _json["referendumBrief"] = referendumBrief;
    }
    if (referendumConStatement != null) {
      _json["referendumConStatement"] = referendumConStatement;
    }
    if (referendumEffectOfAbstain != null) {
      _json["referendumEffectOfAbstain"] = referendumEffectOfAbstain;
    }
    if (referendumPassageThreshold != null) {
      _json["referendumPassageThreshold"] = referendumPassageThreshold;
    }
    if (referendumProStatement != null) {
      _json["referendumProStatement"] = referendumProStatement;
    }
    if (referendumSubtitle != null) {
      _json["referendumSubtitle"] = referendumSubtitle;
    }
    if (referendumText != null) {
      _json["referendumText"] = referendumText;
    }
    if (referendumTitle != null) {
      _json["referendumTitle"] = referendumTitle;
    }
    if (referendumUrl != null) {
      _json["referendumUrl"] = referendumUrl;
    }
    if (roles != null) {
      _json["roles"] = roles;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    if (special != null) {
      _json["special"] = special;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class ContextParams {
  core.String clientProfile;

  ContextParams();

  ContextParams.fromJson(core.Map _json) {
    if (_json.containsKey("clientProfile")) {
      clientProfile = _json["clientProfile"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientProfile != null) {
      _json["clientProfile"] = clientProfile;
    }
    return _json;
  }
}

/** A request to look up representative information for a single division. */
class DivisionRepresentativeInfoRequest {
  ContextParams contextParams;

  DivisionRepresentativeInfoRequest();

  DivisionRepresentativeInfoRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contextParams")) {
      contextParams = new ContextParams.fromJson(_json["contextParams"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contextParams != null) {
      _json["contextParams"] = (contextParams).toJson();
    }
    return _json;
  }
}

/** A search request for political geographies. */
class DivisionSearchRequest {
  ContextParams contextParams;

  DivisionSearchRequest();

  DivisionSearchRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contextParams")) {
      contextParams = new ContextParams.fromJson(_json["contextParams"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contextParams != null) {
      _json["contextParams"] = (contextParams).toJson();
    }
    return _json;
  }
}

/** The result of a division search query. */
class DivisionSearchResponse {
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "civicinfo#divisionSearchResponse".
   */
  core.String kind;
  core.List<DivisionSearchResult> results;

  DivisionSearchResponse();

  DivisionSearchResponse.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("results")) {
      results = _json["results"].map((value) => new DivisionSearchResult.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (results != null) {
      _json["results"] = results.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Represents a political geographic division that matches the requested query.
 */
class DivisionSearchResult {
  /**
   * Other Open Civic Data identifiers that refer to the same division -- for
   * example, those that refer to other political divisions whose boundaries are
   * defined to be coterminous with this one. For example,
   * ocd-division/country:us/state:wy will include an alias of
   * ocd-division/country:us/state:wy/cd:1, since Wyoming has only one
   * Congressional district.
   */
  core.List<core.String> aliases;
  /** The name of the division. */
  core.String name;
  /** The unique Open Civic Data identifier for this division. */
  core.String ocdId;

  DivisionSearchResult();

  DivisionSearchResult.fromJson(core.Map _json) {
    if (_json.containsKey("aliases")) {
      aliases = _json["aliases"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ocdId")) {
      ocdId = _json["ocdId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aliases != null) {
      _json["aliases"] = aliases;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ocdId != null) {
      _json["ocdId"] = ocdId;
    }
    return _json;
  }
}

/** Information about the election that was queried. */
class Election {
  /** Day of the election in YYYY-MM-DD format. */
  core.String electionDay;
  /** The unique ID of this election. */
  core.String id;
  /** A displayable name for the election. */
  core.String name;
  /**
   * The political division of the election. Represented as an OCD Division ID.
   * Voters within these political jurisdictions are covered by this election.
   * This is typically a state such as ocd-division/country:us/state:ca or for
   * the midterms or general election the entire US (i.e.
   * ocd-division/country:us).
   */
  core.String ocdDivisionId;

  Election();

  Election.fromJson(core.Map _json) {
    if (_json.containsKey("electionDay")) {
      electionDay = _json["electionDay"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ocdDivisionId")) {
      ocdDivisionId = _json["ocdDivisionId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (electionDay != null) {
      _json["electionDay"] = electionDay;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ocdDivisionId != null) {
      _json["ocdDivisionId"] = ocdDivisionId;
    }
    return _json;
  }
}

/** Information about individual election officials. */
class ElectionOfficial {
  /** The email address of the election official. */
  core.String emailAddress;
  /** The fax number of the election official. */
  core.String faxNumber;
  /** The full name of the election official. */
  core.String name;
  /** The office phone number of the election official. */
  core.String officePhoneNumber;
  /** The title of the election official. */
  core.String title;

  ElectionOfficial();

  ElectionOfficial.fromJson(core.Map _json) {
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
    if (_json.containsKey("faxNumber")) {
      faxNumber = _json["faxNumber"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("officePhoneNumber")) {
      officePhoneNumber = _json["officePhoneNumber"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    if (faxNumber != null) {
      _json["faxNumber"] = faxNumber;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (officePhoneNumber != null) {
      _json["officePhoneNumber"] = officePhoneNumber;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class ElectionsQueryRequest {
  ContextParams contextParams;

  ElectionsQueryRequest();

  ElectionsQueryRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contextParams")) {
      contextParams = new ContextParams.fromJson(_json["contextParams"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contextParams != null) {
      _json["contextParams"] = (contextParams).toJson();
    }
    return _json;
  }
}

/** The list of elections available for this version of the API. */
class ElectionsQueryResponse {
  /** A list of available elections */
  core.List<Election> elections;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "civicinfo#electionsQueryResponse".
   */
  core.String kind;

  ElectionsQueryResponse();

  ElectionsQueryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("elections")) {
      elections = _json["elections"].map((value) => new Election.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (elections != null) {
      _json["elections"] = elections.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Describes the geographic scope of a contest. */
class ElectoralDistrict {
  /**
   * An identifier for this district, relative to its scope. For example, the
   * 34th State Senate district would have id "34" and a scope of stateUpper.
   */
  core.String id;
  core.String kgForeignKey;
  /** The name of the district. */
  core.String name;
  /**
   * The geographic scope of this district. If unspecified the district's
   * geography is not known. One of: national, statewide, congressional,
   * stateUpper, stateLower, countywide, judicial, schoolBoard, cityWide,
   * township, countyCouncil, cityCouncil, ward, special
   */
  core.String scope;

  ElectoralDistrict();

  ElectoralDistrict.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kgForeignKey")) {
      kgForeignKey = _json["kgForeignKey"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("scope")) {
      scope = _json["scope"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (kgForeignKey != null) {
      _json["kgForeignKey"] = kgForeignKey;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (scope != null) {
      _json["scope"] = scope;
    }
    return _json;
  }
}

/** Describes a political geography. */
class GeographicDivision {
  /**
   * Any other valid OCD IDs that refer to the same division.
   *
   * Because OCD IDs are meant to be human-readable and at least somewhat
   * predictable, there are occasionally several identifiers for a single
   * division. These identifiers are defined to be equivalent to one another,
   * and one is always indicated as the primary identifier. The primary
   * identifier will be returned in ocd_id above, and any other equivalent valid
   * identifiers will be returned in this list.
   *
   * For example, if this division's OCD ID is
   * ocd-division/country:us/district:dc, this will contain
   * ocd-division/country:us/state:dc.
   */
  core.List<core.String> alsoKnownAs;
  /** The name of the division. */
  core.String name;
  /**
   * List of indices in the offices array, one for each office elected from this
   * division. Will only be present if includeOffices was true (or absent) in
   * the request.
   */
  core.List<core.int> officeIndices;

  GeographicDivision();

  GeographicDivision.fromJson(core.Map _json) {
    if (_json.containsKey("alsoKnownAs")) {
      alsoKnownAs = _json["alsoKnownAs"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("officeIndices")) {
      officeIndices = _json["officeIndices"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alsoKnownAs != null) {
      _json["alsoKnownAs"] = alsoKnownAs;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (officeIndices != null) {
      _json["officeIndices"] = officeIndices;
    }
    return _json;
  }
}

/** Information about an Office held by one or more Officials. */
class Office {
  /** The OCD ID of the division with which this office is associated. */
  core.String divisionId;
  /**
   * The levels of government of which this office is part. There may be more
   * than one in cases where a jurisdiction effectively acts at two different
   * levels of government; for example, the mayor of the District of Columbia
   * acts at "locality" level, but also effectively at both
   * "administrative-area-2" and "administrative-area-1".
   */
  core.List<core.String> levels;
  /** The human-readable name of the office. */
  core.String name;
  /**
   * List of indices in the officials array of people who presently hold this
   * office.
   */
  core.List<core.int> officialIndices;
  /**
   * The roles which this office fulfills. Roles are not meant to be exhaustive,
   * or to exactly specify the entire set of responsibilities of a given office,
   * but are meant to be rough categories that are useful for general selection
   * from or sorting of a list of offices.
   */
  core.List<core.String> roles;
  /**
   * A list of sources for this office. If multiple sources are listed, the data
   * has been aggregated from those sources.
   */
  core.List<Source> sources;

  Office();

  Office.fromJson(core.Map _json) {
    if (_json.containsKey("divisionId")) {
      divisionId = _json["divisionId"];
    }
    if (_json.containsKey("levels")) {
      levels = _json["levels"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("officialIndices")) {
      officialIndices = _json["officialIndices"];
    }
    if (_json.containsKey("roles")) {
      roles = _json["roles"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (divisionId != null) {
      _json["divisionId"] = divisionId;
    }
    if (levels != null) {
      _json["levels"] = levels;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (officialIndices != null) {
      _json["officialIndices"] = officialIndices;
    }
    if (roles != null) {
      _json["roles"] = roles;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Information about a person holding an elected office. */
class Official {
  /** Addresses at which to contact the official. */
  core.List<SimpleAddressType> address;
  /** A list of known (social) media channels for this official. */
  core.List<Channel> channels;
  /** The direct email addresses for the official. */
  core.List<core.String> emails;
  /** The official's name. */
  core.String name;
  /** The full name of the party the official belongs to. */
  core.String party;
  /** The official's public contact phone numbers. */
  core.List<core.String> phones;
  /** A URL for a photo of the official. */
  core.String photoUrl;
  /** The official's public website URLs. */
  core.List<core.String> urls;

  Official();

  Official.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"].map((value) => new SimpleAddressType.fromJson(value)).toList();
    }
    if (_json.containsKey("channels")) {
      channels = _json["channels"].map((value) => new Channel.fromJson(value)).toList();
    }
    if (_json.containsKey("emails")) {
      emails = _json["emails"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("party")) {
      party = _json["party"];
    }
    if (_json.containsKey("phones")) {
      phones = _json["phones"];
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
    if (_json.containsKey("urls")) {
      urls = _json["urls"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address.map((value) => (value).toJson()).toList();
    }
    if (channels != null) {
      _json["channels"] = channels.map((value) => (value).toJson()).toList();
    }
    if (emails != null) {
      _json["emails"] = emails;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (party != null) {
      _json["party"] = party;
    }
    if (phones != null) {
      _json["phones"] = phones;
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    if (urls != null) {
      _json["urls"] = urls;
    }
    return _json;
  }
}

/**
 * A location where a voter can vote. This may be an early vote site, an
 * election day voting location, or a drop off location for a completed ballot.
 */
class PollingLocation {
  /** The address of the location. */
  SimpleAddressType address;
  /**
   * The last date that this early vote site or drop off location may be used.
   * This field is not populated for polling locations.
   */
  core.String endDate;
  /**
   * An ID for this object. IDs may change in future requests and should not be
   * cached. Access to this field requires special access that can be requested
   * from the Request more link on the Quotas page.
   */
  core.String id;
  /**
   * The name of the early vote site or drop off location. This field is not
   * populated for polling locations.
   */
  core.String name;
  /**
   * Notes about this location (e.g. accessibility ramp or entrance to use).
   */
  core.String notes;
  /** A description of when this location is open. */
  core.String pollingHours;
  /**
   * A list of sources for this location. If multiple sources are listed the
   * data has been aggregated from those sources.
   */
  core.List<Source> sources;
  /**
   * The first date that this early vote site or drop off location may be used.
   * This field is not populated for polling locations.
   */
  core.String startDate;
  /**
   * The services provided by this early vote site or drop off location. This
   * field is not populated for polling locations.
   */
  core.String voterServices;

  PollingLocation();

  PollingLocation.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new SimpleAddressType.fromJson(_json["address"]);
    }
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("notes")) {
      notes = _json["notes"];
    }
    if (_json.containsKey("pollingHours")) {
      pollingHours = _json["pollingHours"];
    }
    if (_json.containsKey("sources")) {
      sources = _json["sources"].map((value) => new Source.fromJson(value)).toList();
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
    }
    if (_json.containsKey("voterServices")) {
      voterServices = _json["voterServices"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (notes != null) {
      _json["notes"] = notes;
    }
    if (pollingHours != null) {
      _json["pollingHours"] = pollingHours;
    }
    if (sources != null) {
      _json["sources"] = sources.map((value) => (value).toJson()).toList();
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
    }
    if (voterServices != null) {
      _json["voterServices"] = voterServices;
    }
    return _json;
  }
}

class PostalAddress {
  core.List<core.String> addressLines;
  core.String administrativeAreaName;
  core.String countryName;
  core.String countryNameCode;
  core.String dependentLocalityName;
  core.String dependentThoroughfareLeadingType;
  core.String dependentThoroughfareName;
  core.String dependentThoroughfarePostDirection;
  core.String dependentThoroughfarePreDirection;
  core.String dependentThoroughfareTrailingType;
  core.String dependentThoroughfaresConnector;
  core.String dependentThoroughfaresIndicator;
  core.String dependentThoroughfaresType;
  core.String firmName;
  core.bool isDisputed;
  core.String languageCode;
  core.String localityName;
  core.String postBoxNumber;
  core.String postalCodeNumber;
  core.String postalCodeNumberExtension;
  core.String premiseName;
  core.String recipientName;
  core.String sortingCode;
  core.String subAdministrativeAreaName;
  core.String subPremiseName;
  core.String thoroughfareLeadingType;
  core.String thoroughfareName;
  core.String thoroughfareNumber;
  core.String thoroughfarePostDirection;
  core.String thoroughfarePreDirection;
  core.String thoroughfareTrailingType;

  PostalAddress();

  PostalAddress.fromJson(core.Map _json) {
    if (_json.containsKey("addressLines")) {
      addressLines = _json["addressLines"];
    }
    if (_json.containsKey("administrativeAreaName")) {
      administrativeAreaName = _json["administrativeAreaName"];
    }
    if (_json.containsKey("countryName")) {
      countryName = _json["countryName"];
    }
    if (_json.containsKey("countryNameCode")) {
      countryNameCode = _json["countryNameCode"];
    }
    if (_json.containsKey("dependentLocalityName")) {
      dependentLocalityName = _json["dependentLocalityName"];
    }
    if (_json.containsKey("dependentThoroughfareLeadingType")) {
      dependentThoroughfareLeadingType = _json["dependentThoroughfareLeadingType"];
    }
    if (_json.containsKey("dependentThoroughfareName")) {
      dependentThoroughfareName = _json["dependentThoroughfareName"];
    }
    if (_json.containsKey("dependentThoroughfarePostDirection")) {
      dependentThoroughfarePostDirection = _json["dependentThoroughfarePostDirection"];
    }
    if (_json.containsKey("dependentThoroughfarePreDirection")) {
      dependentThoroughfarePreDirection = _json["dependentThoroughfarePreDirection"];
    }
    if (_json.containsKey("dependentThoroughfareTrailingType")) {
      dependentThoroughfareTrailingType = _json["dependentThoroughfareTrailingType"];
    }
    if (_json.containsKey("dependentThoroughfaresConnector")) {
      dependentThoroughfaresConnector = _json["dependentThoroughfaresConnector"];
    }
    if (_json.containsKey("dependentThoroughfaresIndicator")) {
      dependentThoroughfaresIndicator = _json["dependentThoroughfaresIndicator"];
    }
    if (_json.containsKey("dependentThoroughfaresType")) {
      dependentThoroughfaresType = _json["dependentThoroughfaresType"];
    }
    if (_json.containsKey("firmName")) {
      firmName = _json["firmName"];
    }
    if (_json.containsKey("isDisputed")) {
      isDisputed = _json["isDisputed"];
    }
    if (_json.containsKey("languageCode")) {
      languageCode = _json["languageCode"];
    }
    if (_json.containsKey("localityName")) {
      localityName = _json["localityName"];
    }
    if (_json.containsKey("postBoxNumber")) {
      postBoxNumber = _json["postBoxNumber"];
    }
    if (_json.containsKey("postalCodeNumber")) {
      postalCodeNumber = _json["postalCodeNumber"];
    }
    if (_json.containsKey("postalCodeNumberExtension")) {
      postalCodeNumberExtension = _json["postalCodeNumberExtension"];
    }
    if (_json.containsKey("premiseName")) {
      premiseName = _json["premiseName"];
    }
    if (_json.containsKey("recipientName")) {
      recipientName = _json["recipientName"];
    }
    if (_json.containsKey("sortingCode")) {
      sortingCode = _json["sortingCode"];
    }
    if (_json.containsKey("subAdministrativeAreaName")) {
      subAdministrativeAreaName = _json["subAdministrativeAreaName"];
    }
    if (_json.containsKey("subPremiseName")) {
      subPremiseName = _json["subPremiseName"];
    }
    if (_json.containsKey("thoroughfareLeadingType")) {
      thoroughfareLeadingType = _json["thoroughfareLeadingType"];
    }
    if (_json.containsKey("thoroughfareName")) {
      thoroughfareName = _json["thoroughfareName"];
    }
    if (_json.containsKey("thoroughfareNumber")) {
      thoroughfareNumber = _json["thoroughfareNumber"];
    }
    if (_json.containsKey("thoroughfarePostDirection")) {
      thoroughfarePostDirection = _json["thoroughfarePostDirection"];
    }
    if (_json.containsKey("thoroughfarePreDirection")) {
      thoroughfarePreDirection = _json["thoroughfarePreDirection"];
    }
    if (_json.containsKey("thoroughfareTrailingType")) {
      thoroughfareTrailingType = _json["thoroughfareTrailingType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addressLines != null) {
      _json["addressLines"] = addressLines;
    }
    if (administrativeAreaName != null) {
      _json["administrativeAreaName"] = administrativeAreaName;
    }
    if (countryName != null) {
      _json["countryName"] = countryName;
    }
    if (countryNameCode != null) {
      _json["countryNameCode"] = countryNameCode;
    }
    if (dependentLocalityName != null) {
      _json["dependentLocalityName"] = dependentLocalityName;
    }
    if (dependentThoroughfareLeadingType != null) {
      _json["dependentThoroughfareLeadingType"] = dependentThoroughfareLeadingType;
    }
    if (dependentThoroughfareName != null) {
      _json["dependentThoroughfareName"] = dependentThoroughfareName;
    }
    if (dependentThoroughfarePostDirection != null) {
      _json["dependentThoroughfarePostDirection"] = dependentThoroughfarePostDirection;
    }
    if (dependentThoroughfarePreDirection != null) {
      _json["dependentThoroughfarePreDirection"] = dependentThoroughfarePreDirection;
    }
    if (dependentThoroughfareTrailingType != null) {
      _json["dependentThoroughfareTrailingType"] = dependentThoroughfareTrailingType;
    }
    if (dependentThoroughfaresConnector != null) {
      _json["dependentThoroughfaresConnector"] = dependentThoroughfaresConnector;
    }
    if (dependentThoroughfaresIndicator != null) {
      _json["dependentThoroughfaresIndicator"] = dependentThoroughfaresIndicator;
    }
    if (dependentThoroughfaresType != null) {
      _json["dependentThoroughfaresType"] = dependentThoroughfaresType;
    }
    if (firmName != null) {
      _json["firmName"] = firmName;
    }
    if (isDisputed != null) {
      _json["isDisputed"] = isDisputed;
    }
    if (languageCode != null) {
      _json["languageCode"] = languageCode;
    }
    if (localityName != null) {
      _json["localityName"] = localityName;
    }
    if (postBoxNumber != null) {
      _json["postBoxNumber"] = postBoxNumber;
    }
    if (postalCodeNumber != null) {
      _json["postalCodeNumber"] = postalCodeNumber;
    }
    if (postalCodeNumberExtension != null) {
      _json["postalCodeNumberExtension"] = postalCodeNumberExtension;
    }
    if (premiseName != null) {
      _json["premiseName"] = premiseName;
    }
    if (recipientName != null) {
      _json["recipientName"] = recipientName;
    }
    if (sortingCode != null) {
      _json["sortingCode"] = sortingCode;
    }
    if (subAdministrativeAreaName != null) {
      _json["subAdministrativeAreaName"] = subAdministrativeAreaName;
    }
    if (subPremiseName != null) {
      _json["subPremiseName"] = subPremiseName;
    }
    if (thoroughfareLeadingType != null) {
      _json["thoroughfareLeadingType"] = thoroughfareLeadingType;
    }
    if (thoroughfareName != null) {
      _json["thoroughfareName"] = thoroughfareName;
    }
    if (thoroughfareNumber != null) {
      _json["thoroughfareNumber"] = thoroughfareNumber;
    }
    if (thoroughfarePostDirection != null) {
      _json["thoroughfarePostDirection"] = thoroughfarePostDirection;
    }
    if (thoroughfarePreDirection != null) {
      _json["thoroughfarePreDirection"] = thoroughfarePreDirection;
    }
    if (thoroughfareTrailingType != null) {
      _json["thoroughfareTrailingType"] = thoroughfareTrailingType;
    }
    return _json;
  }
}

class RepresentativeInfoData {
  /** Political geographic divisions that contain the requested address. */
  core.Map<core.String, GeographicDivision> divisions;
  /**
   * Elected offices referenced by the divisions listed above. Will only be
   * present if includeOffices was true in the request.
   */
  core.List<Office> offices;
  /**
   * Officials holding the offices listed above. Will only be present if
   * includeOffices was true in the request.
   */
  core.List<Official> officials;

  RepresentativeInfoData();

  RepresentativeInfoData.fromJson(core.Map _json) {
    if (_json.containsKey("divisions")) {
      divisions = commons.mapMap(_json["divisions"], (item) => new GeographicDivision.fromJson(item));
    }
    if (_json.containsKey("offices")) {
      offices = _json["offices"].map((value) => new Office.fromJson(value)).toList();
    }
    if (_json.containsKey("officials")) {
      officials = _json["officials"].map((value) => new Official.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (divisions != null) {
      _json["divisions"] = commons.mapMap(divisions, (item) => (item).toJson());
    }
    if (offices != null) {
      _json["offices"] = offices.map((value) => (value).toJson()).toList();
    }
    if (officials != null) {
      _json["officials"] = officials.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A request for political geography and representative information for an
 * address.
 */
class RepresentativeInfoRequest {
  ContextParams contextParams;

  RepresentativeInfoRequest();

  RepresentativeInfoRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contextParams")) {
      contextParams = new ContextParams.fromJson(_json["contextParams"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contextParams != null) {
      _json["contextParams"] = (contextParams).toJson();
    }
    return _json;
  }
}

/** The result of a representative info lookup query. */
class RepresentativeInfoResponse {
  /** Political geographic divisions that contain the requested address. */
  core.Map<core.String, GeographicDivision> divisions;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "civicinfo#representativeInfoResponse".
   */
  core.String kind;
  /** The normalized version of the requested address */
  SimpleAddressType normalizedInput;
  /**
   * Elected offices referenced by the divisions listed above. Will only be
   * present if includeOffices was true in the request.
   */
  core.List<Office> offices;
  /**
   * Officials holding the offices listed above. Will only be present if
   * includeOffices was true in the request.
   */
  core.List<Official> officials;

  RepresentativeInfoResponse();

  RepresentativeInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("divisions")) {
      divisions = commons.mapMap(_json["divisions"], (item) => new GeographicDivision.fromJson(item));
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("normalizedInput")) {
      normalizedInput = new SimpleAddressType.fromJson(_json["normalizedInput"]);
    }
    if (_json.containsKey("offices")) {
      offices = _json["offices"].map((value) => new Office.fromJson(value)).toList();
    }
    if (_json.containsKey("officials")) {
      officials = _json["officials"].map((value) => new Official.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (divisions != null) {
      _json["divisions"] = commons.mapMap(divisions, (item) => (item).toJson());
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (normalizedInput != null) {
      _json["normalizedInput"] = (normalizedInput).toJson();
    }
    if (offices != null) {
      _json["offices"] = offices.map((value) => (value).toJson()).toList();
    }
    if (officials != null) {
      _json["officials"] = officials.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A simple representation of an address. */
class SimpleAddressType {
  /** The city or town for the address. */
  core.String city;
  /** The street name and number of this address. */
  core.String line1;
  /** The second line the address, if needed. */
  core.String line2;
  /** The third line of the address, if needed. */
  core.String line3;
  /** The name of the location. */
  core.String locationName;
  /** The US two letter state abbreviation of the address. */
  core.String state;
  /** The US Postal Zip Code of the address. */
  core.String zip;

  SimpleAddressType();

  SimpleAddressType.fromJson(core.Map _json) {
    if (_json.containsKey("city")) {
      city = _json["city"];
    }
    if (_json.containsKey("line1")) {
      line1 = _json["line1"];
    }
    if (_json.containsKey("line2")) {
      line2 = _json["line2"];
    }
    if (_json.containsKey("line3")) {
      line3 = _json["line3"];
    }
    if (_json.containsKey("locationName")) {
      locationName = _json["locationName"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("zip")) {
      zip = _json["zip"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (city != null) {
      _json["city"] = city;
    }
    if (line1 != null) {
      _json["line1"] = line1;
    }
    if (line2 != null) {
      _json["line2"] = line2;
    }
    if (line3 != null) {
      _json["line3"] = line3;
    }
    if (locationName != null) {
      _json["locationName"] = locationName;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (zip != null) {
      _json["zip"] = zip;
    }
    return _json;
  }
}

/**
 * Contains information about the data source for the element containing it.
 */
class Source {
  /** The name of the data source. */
  core.String name;
  /** Whether this data comes from an official government source. */
  core.bool official;

  Source();

  Source.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("official")) {
      official = _json["official"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (official != null) {
      _json["official"] = official;
    }
    return _json;
  }
}

/** A request for information about a voter. */
class VoterInfoRequest {
  ContextParams contextParams;
  VoterInfoSegmentResult voterInfoSegmentResult;

  VoterInfoRequest();

  VoterInfoRequest.fromJson(core.Map _json) {
    if (_json.containsKey("contextParams")) {
      contextParams = new ContextParams.fromJson(_json["contextParams"]);
    }
    if (_json.containsKey("voterInfoSegmentResult")) {
      voterInfoSegmentResult = new VoterInfoSegmentResult.fromJson(_json["voterInfoSegmentResult"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contextParams != null) {
      _json["contextParams"] = (contextParams).toJson();
    }
    if (voterInfoSegmentResult != null) {
      _json["voterInfoSegmentResult"] = (voterInfoSegmentResult).toJson();
    }
    return _json;
  }
}

/** The result of a voter info lookup query. */
class VoterInfoResponse {
  /** Contests that will appear on the voter's ballot. */
  core.List<Contest> contests;
  /**
   * Locations where a voter is eligible to drop off a completed ballot. The
   * voter must have received and completed a ballot prior to arriving at the
   * location. The location may not have ballots available on the premises.
   * These locations could be open on or before election day as indicated in the
   * pollingHours field.
   */
  core.List<PollingLocation> dropOffLocations;
  /**
   * Locations where the voter is eligible to vote early, prior to election day.
   */
  core.List<PollingLocation> earlyVoteSites;
  /** The election that was queried. */
  Election election;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "civicinfo#voterInfoResponse".
   */
  core.String kind;
  /**
   * Specifies whether voters in the precinct vote only by mailing their ballots
   * (with the possible option of dropping off their ballots as well).
   */
  core.bool mailOnly;
  /** The normalized version of the requested address */
  SimpleAddressType normalizedInput;
  /**
   * If no election ID was specified in the query, and there was more than one
   * election with data for the given voter, this will contain information about
   * the other elections that could apply.
   */
  core.List<Election> otherElections;
  /** Locations where the voter is eligible to vote on election day. */
  core.List<PollingLocation> pollingLocations;
  core.String precinctId;
  /**
   * Local Election Information for the state that the voter votes in. For the
   * US, there will only be one element in this array.
   */
  core.List<AdministrationRegion> state;

  VoterInfoResponse();

  VoterInfoResponse.fromJson(core.Map _json) {
    if (_json.containsKey("contests")) {
      contests = _json["contests"].map((value) => new Contest.fromJson(value)).toList();
    }
    if (_json.containsKey("dropOffLocations")) {
      dropOffLocations = _json["dropOffLocations"].map((value) => new PollingLocation.fromJson(value)).toList();
    }
    if (_json.containsKey("earlyVoteSites")) {
      earlyVoteSites = _json["earlyVoteSites"].map((value) => new PollingLocation.fromJson(value)).toList();
    }
    if (_json.containsKey("election")) {
      election = new Election.fromJson(_json["election"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mailOnly")) {
      mailOnly = _json["mailOnly"];
    }
    if (_json.containsKey("normalizedInput")) {
      normalizedInput = new SimpleAddressType.fromJson(_json["normalizedInput"]);
    }
    if (_json.containsKey("otherElections")) {
      otherElections = _json["otherElections"].map((value) => new Election.fromJson(value)).toList();
    }
    if (_json.containsKey("pollingLocations")) {
      pollingLocations = _json["pollingLocations"].map((value) => new PollingLocation.fromJson(value)).toList();
    }
    if (_json.containsKey("precinctId")) {
      precinctId = _json["precinctId"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"].map((value) => new AdministrationRegion.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contests != null) {
      _json["contests"] = contests.map((value) => (value).toJson()).toList();
    }
    if (dropOffLocations != null) {
      _json["dropOffLocations"] = dropOffLocations.map((value) => (value).toJson()).toList();
    }
    if (earlyVoteSites != null) {
      _json["earlyVoteSites"] = earlyVoteSites.map((value) => (value).toJson()).toList();
    }
    if (election != null) {
      _json["election"] = (election).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mailOnly != null) {
      _json["mailOnly"] = mailOnly;
    }
    if (normalizedInput != null) {
      _json["normalizedInput"] = (normalizedInput).toJson();
    }
    if (otherElections != null) {
      _json["otherElections"] = otherElections.map((value) => (value).toJson()).toList();
    }
    if (pollingLocations != null) {
      _json["pollingLocations"] = pollingLocations.map((value) => (value).toJson()).toList();
    }
    if (precinctId != null) {
      _json["precinctId"] = precinctId;
    }
    if (state != null) {
      _json["state"] = state.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class VoterInfoSegmentResult {
  core.String generatedMillis;
  PostalAddress postalAddress;
  VoterInfoRequest request;
  VoterInfoResponse response;

  VoterInfoSegmentResult();

  VoterInfoSegmentResult.fromJson(core.Map _json) {
    if (_json.containsKey("generatedMillis")) {
      generatedMillis = _json["generatedMillis"];
    }
    if (_json.containsKey("postalAddress")) {
      postalAddress = new PostalAddress.fromJson(_json["postalAddress"]);
    }
    if (_json.containsKey("request")) {
      request = new VoterInfoRequest.fromJson(_json["request"]);
    }
    if (_json.containsKey("response")) {
      response = new VoterInfoResponse.fromJson(_json["response"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (generatedMillis != null) {
      _json["generatedMillis"] = generatedMillis;
    }
    if (postalAddress != null) {
      _json["postalAddress"] = (postalAddress).toJson();
    }
    if (request != null) {
      _json["request"] = (request).toJson();
    }
    if (response != null) {
      _json["response"] = (response).toJson();
    }
    return _json;
  }
}
