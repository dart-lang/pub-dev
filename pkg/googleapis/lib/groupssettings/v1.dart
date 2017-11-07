// This is a generated file (see the discoveryapis_generator project).

library googleapis.groupssettings.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client groupssettings/v1';

/** Lets you manage permission levels and related settings of a group. */
class GroupssettingsApi {
  /** View and manage the settings of a G Suite group */
  static const AppsGroupsSettingsScope = "https://www.googleapis.com/auth/apps.groups.settings";


  final commons.ApiRequester _requester;

  GroupsResourceApi get groups => new GroupsResourceApi(_requester);

  GroupssettingsApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "groups/v1/groups/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class GroupsResourceApi {
  final commons.ApiRequester _requester;

  GroupsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one resource by id.
   *
   * Request parameters:
   *
   * [groupUniqueId] - The resource ID
   *
   * Completes with a [Groups].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Groups> get(core.String groupUniqueId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (groupUniqueId == null) {
      throw new core.ArgumentError("Parameter groupUniqueId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$groupUniqueId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Groups.fromJson(data));
  }

  /**
   * Updates an existing resource. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [groupUniqueId] - The resource ID
   *
   * Completes with a [Groups].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Groups> patch(Groups request, core.String groupUniqueId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (groupUniqueId == null) {
      throw new core.ArgumentError("Parameter groupUniqueId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$groupUniqueId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Groups.fromJson(data));
  }

  /**
   * Updates an existing resource.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [groupUniqueId] - The resource ID
   *
   * Completes with a [Groups].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Groups> update(Groups request, core.String groupUniqueId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (groupUniqueId == null) {
      throw new core.ArgumentError("Parameter groupUniqueId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$groupUniqueId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Groups.fromJson(data));
  }

}



/** JSON template for Group resource */
class Groups {
  /** Are external members allowed to join the group. */
  core.String allowExternalMembers;
  /** Is google allowed to contact admins. */
  core.String allowGoogleCommunication;
  /** If posting from web is allowed. */
  core.String allowWebPosting;
  /** If the group is archive only */
  core.String archiveOnly;
  /** Custom footer text. */
  core.String customFooterText;
  /** Default email to which reply to any message should go. */
  core.String customReplyTo;
  /** Default message deny notification message */
  core.String defaultMessageDenyNotificationText;
  /** Description of the group */
  core.String description;
  /** Email id of the group */
  core.String email;
  /** Whether to include custom footer. */
  core.String includeCustomFooter;
  /** If this groups should be included in global address list or not. */
  core.String includeInGlobalAddressList;
  /** If the contents of the group are archived. */
  core.String isArchived;
  /** The type of the resource. */
  core.String kind;
  /** Maximum message size allowed. */
  core.int maxMessageBytes;
  /** Can members post using the group email address. */
  core.String membersCanPostAsTheGroup;
  /**
   * Default message display font. Possible values are: DEFAULT_FONT
   * FIXED_WIDTH_FONT
   */
  core.String messageDisplayFont;
  /**
   * Moderation level for messages. Possible values are: MODERATE_ALL_MESSAGES
   * MODERATE_NON_MEMBERS MODERATE_NEW_MEMBERS MODERATE_NONE
   */
  core.String messageModerationLevel;
  /** Name of the Group */
  core.String name;
  /** Primary language for the group. */
  core.String primaryLanguage;
  /**
   * Whome should the default reply to a message go to. Possible values are:
   * REPLY_TO_CUSTOM REPLY_TO_SENDER REPLY_TO_LIST REPLY_TO_OWNER
   * REPLY_TO_IGNORE REPLY_TO_MANAGERS
   */
  core.String replyTo;
  /** Should the member be notified if his message is denied by owner. */
  core.String sendMessageDenyNotification;
  /** Is the group listed in groups directory */
  core.String showInGroupDirectory;
  /**
   * Moderation level for messages detected as spam. Possible values are: ALLOW
   * MODERATE SILENTLY_MODERATE REJECT
   */
  core.String spamModerationLevel;
  /**
   * Permissions to add members. Possible values are: ALL_MANAGERS_CAN_ADD
   * ALL_MEMBERS_CAN_ADD NONE_CAN_ADD
   */
  core.String whoCanAdd;
  /**
   * Permission to contact owner of the group via web UI. Possible values are:
   * ANYONE_CAN_CONTACT ALL_IN_DOMAIN_CAN_CONTACT ALL_MEMBERS_CAN_CONTACT
   * ALL_MANAGERS_CAN_CONTACT
   */
  core.String whoCanContactOwner;
  /**
   * Permissions to invite members. Possible values are: ALL_MEMBERS_CAN_INVITE
   * ALL_MANAGERS_CAN_INVITE NONE_CAN_INVITE
   */
  core.String whoCanInvite;
  /**
   * Permissions to join the group. Possible values are: ANYONE_CAN_JOIN
   * ALL_IN_DOMAIN_CAN_JOIN INVITED_CAN_JOIN CAN_REQUEST_TO_JOIN
   */
  core.String whoCanJoin;
  /**
   * Permission to leave the group. Possible values are: ALL_MANAGERS_CAN_LEAVE
   * ALL_MEMBERS_CAN_LEAVE NONE_CAN_LEAVE
   */
  core.String whoCanLeaveGroup;
  /**
   * Permissions to post messages to the group. Possible values are:
   * NONE_CAN_POST ALL_MANAGERS_CAN_POST ALL_MEMBERS_CAN_POST
   * ALL_IN_DOMAIN_CAN_POST ANYONE_CAN_POST
   */
  core.String whoCanPostMessage;
  /**
   * Permissions to view group. Possible values are: ANYONE_CAN_VIEW
   * ALL_IN_DOMAIN_CAN_VIEW ALL_MEMBERS_CAN_VIEW ALL_MANAGERS_CAN_VIEW
   */
  core.String whoCanViewGroup;
  /**
   * Permissions to view membership. Possible values are: ALL_IN_DOMAIN_CAN_VIEW
   * ALL_MEMBERS_CAN_VIEW ALL_MANAGERS_CAN_VIEW
   */
  core.String whoCanViewMembership;

  Groups();

  Groups.fromJson(core.Map _json) {
    if (_json.containsKey("allowExternalMembers")) {
      allowExternalMembers = _json["allowExternalMembers"];
    }
    if (_json.containsKey("allowGoogleCommunication")) {
      allowGoogleCommunication = _json["allowGoogleCommunication"];
    }
    if (_json.containsKey("allowWebPosting")) {
      allowWebPosting = _json["allowWebPosting"];
    }
    if (_json.containsKey("archiveOnly")) {
      archiveOnly = _json["archiveOnly"];
    }
    if (_json.containsKey("customFooterText")) {
      customFooterText = _json["customFooterText"];
    }
    if (_json.containsKey("customReplyTo")) {
      customReplyTo = _json["customReplyTo"];
    }
    if (_json.containsKey("defaultMessageDenyNotificationText")) {
      defaultMessageDenyNotificationText = _json["defaultMessageDenyNotificationText"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("includeCustomFooter")) {
      includeCustomFooter = _json["includeCustomFooter"];
    }
    if (_json.containsKey("includeInGlobalAddressList")) {
      includeInGlobalAddressList = _json["includeInGlobalAddressList"];
    }
    if (_json.containsKey("isArchived")) {
      isArchived = _json["isArchived"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxMessageBytes")) {
      maxMessageBytes = _json["maxMessageBytes"];
    }
    if (_json.containsKey("membersCanPostAsTheGroup")) {
      membersCanPostAsTheGroup = _json["membersCanPostAsTheGroup"];
    }
    if (_json.containsKey("messageDisplayFont")) {
      messageDisplayFont = _json["messageDisplayFont"];
    }
    if (_json.containsKey("messageModerationLevel")) {
      messageModerationLevel = _json["messageModerationLevel"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("primaryLanguage")) {
      primaryLanguage = _json["primaryLanguage"];
    }
    if (_json.containsKey("replyTo")) {
      replyTo = _json["replyTo"];
    }
    if (_json.containsKey("sendMessageDenyNotification")) {
      sendMessageDenyNotification = _json["sendMessageDenyNotification"];
    }
    if (_json.containsKey("showInGroupDirectory")) {
      showInGroupDirectory = _json["showInGroupDirectory"];
    }
    if (_json.containsKey("spamModerationLevel")) {
      spamModerationLevel = _json["spamModerationLevel"];
    }
    if (_json.containsKey("whoCanAdd")) {
      whoCanAdd = _json["whoCanAdd"];
    }
    if (_json.containsKey("whoCanContactOwner")) {
      whoCanContactOwner = _json["whoCanContactOwner"];
    }
    if (_json.containsKey("whoCanInvite")) {
      whoCanInvite = _json["whoCanInvite"];
    }
    if (_json.containsKey("whoCanJoin")) {
      whoCanJoin = _json["whoCanJoin"];
    }
    if (_json.containsKey("whoCanLeaveGroup")) {
      whoCanLeaveGroup = _json["whoCanLeaveGroup"];
    }
    if (_json.containsKey("whoCanPostMessage")) {
      whoCanPostMessage = _json["whoCanPostMessage"];
    }
    if (_json.containsKey("whoCanViewGroup")) {
      whoCanViewGroup = _json["whoCanViewGroup"];
    }
    if (_json.containsKey("whoCanViewMembership")) {
      whoCanViewMembership = _json["whoCanViewMembership"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowExternalMembers != null) {
      _json["allowExternalMembers"] = allowExternalMembers;
    }
    if (allowGoogleCommunication != null) {
      _json["allowGoogleCommunication"] = allowGoogleCommunication;
    }
    if (allowWebPosting != null) {
      _json["allowWebPosting"] = allowWebPosting;
    }
    if (archiveOnly != null) {
      _json["archiveOnly"] = archiveOnly;
    }
    if (customFooterText != null) {
      _json["customFooterText"] = customFooterText;
    }
    if (customReplyTo != null) {
      _json["customReplyTo"] = customReplyTo;
    }
    if (defaultMessageDenyNotificationText != null) {
      _json["defaultMessageDenyNotificationText"] = defaultMessageDenyNotificationText;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (includeCustomFooter != null) {
      _json["includeCustomFooter"] = includeCustomFooter;
    }
    if (includeInGlobalAddressList != null) {
      _json["includeInGlobalAddressList"] = includeInGlobalAddressList;
    }
    if (isArchived != null) {
      _json["isArchived"] = isArchived;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxMessageBytes != null) {
      _json["maxMessageBytes"] = maxMessageBytes;
    }
    if (membersCanPostAsTheGroup != null) {
      _json["membersCanPostAsTheGroup"] = membersCanPostAsTheGroup;
    }
    if (messageDisplayFont != null) {
      _json["messageDisplayFont"] = messageDisplayFont;
    }
    if (messageModerationLevel != null) {
      _json["messageModerationLevel"] = messageModerationLevel;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (primaryLanguage != null) {
      _json["primaryLanguage"] = primaryLanguage;
    }
    if (replyTo != null) {
      _json["replyTo"] = replyTo;
    }
    if (sendMessageDenyNotification != null) {
      _json["sendMessageDenyNotification"] = sendMessageDenyNotification;
    }
    if (showInGroupDirectory != null) {
      _json["showInGroupDirectory"] = showInGroupDirectory;
    }
    if (spamModerationLevel != null) {
      _json["spamModerationLevel"] = spamModerationLevel;
    }
    if (whoCanAdd != null) {
      _json["whoCanAdd"] = whoCanAdd;
    }
    if (whoCanContactOwner != null) {
      _json["whoCanContactOwner"] = whoCanContactOwner;
    }
    if (whoCanInvite != null) {
      _json["whoCanInvite"] = whoCanInvite;
    }
    if (whoCanJoin != null) {
      _json["whoCanJoin"] = whoCanJoin;
    }
    if (whoCanLeaveGroup != null) {
      _json["whoCanLeaveGroup"] = whoCanLeaveGroup;
    }
    if (whoCanPostMessage != null) {
      _json["whoCanPostMessage"] = whoCanPostMessage;
    }
    if (whoCanViewGroup != null) {
      _json["whoCanViewGroup"] = whoCanViewGroup;
    }
    if (whoCanViewMembership != null) {
      _json["whoCanViewMembership"] = whoCanViewMembership;
    }
    return _json;
  }
}
