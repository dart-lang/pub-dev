// This is a generated file (see the discoveryapis_generator project).

library googleapis.plusDomains.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client plusDomains/v1';

/** Builds on top of the Google+ platform for Google Apps Domains. */
class PlusDomainsApi {
  /** View your circles and the people and pages in them */
  static const PlusCirclesReadScope = "https://www.googleapis.com/auth/plus.circles.read";

  /**
   * Manage your circles and add people and pages. People and pages you add to
   * your circles will be notified. Others may see this information publicly.
   * People you add to circles can use Hangouts with you.
   */
  static const PlusCirclesWriteScope = "https://www.googleapis.com/auth/plus.circles.write";

  /** Know the list of people in your circles, your age range, and language */
  static const PlusLoginScope = "https://www.googleapis.com/auth/plus.login";

  /** Know who you are on Google */
  static const PlusMeScope = "https://www.googleapis.com/auth/plus.me";

  /** Send your photos and videos to Google+ */
  static const PlusMediaUploadScope = "https://www.googleapis.com/auth/plus.media.upload";

  /** View your own Google+ profile and profiles visible to you */
  static const PlusProfilesReadScope = "https://www.googleapis.com/auth/plus.profiles.read";

  /** View your Google+ posts, comments, and stream */
  static const PlusStreamReadScope = "https://www.googleapis.com/auth/plus.stream.read";

  /** Manage your Google+ posts, comments, and stream */
  static const PlusStreamWriteScope = "https://www.googleapis.com/auth/plus.stream.write";

  /** View your email address */
  static const UserinfoEmailScope = "https://www.googleapis.com/auth/userinfo.email";

  /** View your basic profile info */
  static const UserinfoProfileScope = "https://www.googleapis.com/auth/userinfo.profile";


  final commons.ApiRequester _requester;

  ActivitiesResourceApi get activities => new ActivitiesResourceApi(_requester);
  AudiencesResourceApi get audiences => new AudiencesResourceApi(_requester);
  CirclesResourceApi get circles => new CirclesResourceApi(_requester);
  CommentsResourceApi get comments => new CommentsResourceApi(_requester);
  MediaResourceApi get media => new MediaResourceApi(_requester);
  PeopleResourceApi get people => new PeopleResourceApi(_requester);

  PlusDomainsApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "plusDomains/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ActivitiesResourceApi {
  final commons.ApiRequester _requester;

  ActivitiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get an activity.
   *
   * Request parameters:
   *
   * [activityId] - The ID of the activity to get.
   *
   * Completes with a [Activity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Activity> get(core.String activityId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (activityId == null) {
      throw new core.ArgumentError("Parameter activityId is required.");
    }

    _url = 'activities/' + commons.Escaper.ecapeVariable('$activityId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Activity.fromJson(data));
  }

  /**
   * Create a new activity for the authenticated user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to create the activity on behalf of. Its
   * value should be "me", to indicate the authenticated user.
   *
   * [preview] - If "true", extract the potential media attachments for a URL.
   * The response will include all possible attachments for a URL, including
   * video, photos, and articles based on the content of the page.
   *
   * Completes with a [Activity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Activity> insert(Activity request, core.String userId, {core.bool preview}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (preview != null) {
      _queryParams["preview"] = ["${preview}"];
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/activities';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Activity.fromJson(data));
  }

  /**
   * List all of the activities in the specified collection for a particular
   * user.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to get activities for. The special value "me"
   * can be used to indicate the authenticated user.
   *
   * [collection] - The collection of activities to list.
   * Possible string values are:
   * - "user" : All activities created by the specified user that the
   * authenticated user is authorized to view.
   *
   * [maxResults] - The maximum number of activities to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [ActivityFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ActivityFeed> list(core.String userId, core.String collection, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/activities/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ActivityFeed.fromJson(data));
  }

}


class AudiencesResourceApi {
  final commons.ApiRequester _requester;

  AudiencesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List all of the audiences to which a user can share.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to get audiences for. The special value "me"
   * can be used to indicate the authenticated user.
   *
   * [maxResults] - The maximum number of circles to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [AudiencesFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AudiencesFeed> list(core.String userId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/audiences';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AudiencesFeed.fromJson(data));
  }

}


class CirclesResourceApi {
  final commons.ApiRequester _requester;

  CirclesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Add a person to a circle. Google+ limits certain circle operations,
   * including the number of circle adds. Learn More.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to add the person to.
   *
   * [email] - Email of the people to add to the circle. Optional, can be
   * repeated.
   *
   * [userId] - IDs of the people to add to the circle. Optional, can be
   * repeated.
   *
   * Completes with a [Circle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Circle> addPeople(core.String circleId, {core.List<core.String> email, core.List<core.String> userId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }
    if (email != null) {
      _queryParams["email"] = email;
    }
    if (userId != null) {
      _queryParams["userId"] = userId;
    }

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId') + '/people';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Circle.fromJson(data));
  }

  /**
   * Get a circle.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to get.
   *
   * Completes with a [Circle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Circle> get(core.String circleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Circle.fromJson(data));
  }

  /**
   * Create a new circle for the authenticated user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to create the circle on behalf of. The value
   * "me" can be used to indicate the authenticated user.
   *
   * Completes with a [Circle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Circle> insert(Circle request, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/circles';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Circle.fromJson(data));
  }

  /**
   * List all of the circles for a user.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to get circles for. The special value "me"
   * can be used to indicate the authenticated user.
   *
   * [maxResults] - The maximum number of circles to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [CircleFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CircleFeed> list(core.String userId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/circles';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CircleFeed.fromJson(data));
  }

  /**
   * Update a circle's description. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to update.
   *
   * Completes with a [Circle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Circle> patch(Circle request, core.String circleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Circle.fromJson(data));
  }

  /**
   * Delete a circle.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future remove(core.String circleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }

    _downloadOptions = null;

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId');

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
   * Remove a person from a circle.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to remove the person from.
   *
   * [email] - Email of the people to add to the circle. Optional, can be
   * repeated.
   *
   * [userId] - IDs of the people to remove from the circle. Optional, can be
   * repeated.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future removePeople(core.String circleId, {core.List<core.String> email, core.List<core.String> userId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }
    if (email != null) {
      _queryParams["email"] = email;
    }
    if (userId != null) {
      _queryParams["userId"] = userId;
    }

    _downloadOptions = null;

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId') + '/people';

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
   * Update a circle's description.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to update.
   *
   * Completes with a [Circle].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Circle> update(Circle request, core.String circleId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Circle.fromJson(data));
  }

}


class CommentsResourceApi {
  final commons.ApiRequester _requester;

  CommentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a comment.
   *
   * Request parameters:
   *
   * [commentId] - The ID of the comment to get.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> get(core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'comments/' + commons.Escaper.ecapeVariable('$commentId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

  /**
   * Create a new comment in reply to an activity.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [activityId] - The ID of the activity to reply to.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> insert(Comment request, core.String activityId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (activityId == null) {
      throw new core.ArgumentError("Parameter activityId is required.");
    }

    _url = 'activities/' + commons.Escaper.ecapeVariable('$activityId') + '/comments';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

  /**
   * List all of the comments for an activity.
   *
   * Request parameters:
   *
   * [activityId] - The ID of the activity to get comments for.
   *
   * [maxResults] - The maximum number of comments to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "0" and "500".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * [sortOrder] - The order in which to sort the list of comments.
   * Possible string values are:
   * - "ascending" : Sort oldest comments first.
   * - "descending" : Sort newest comments first.
   *
   * Completes with a [CommentFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentFeed> list(core.String activityId, {core.int maxResults, core.String pageToken, core.String sortOrder}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (activityId == null) {
      throw new core.ArgumentError("Parameter activityId is required.");
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

    _url = 'activities/' + commons.Escaper.ecapeVariable('$activityId') + '/comments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentFeed.fromJson(data));
  }

}


class MediaResourceApi {
  final commons.ApiRequester _requester;

  MediaResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Add a new media item to an album. The current upload size limitations are
   * 36MB for a photo and 1GB for a video. Uploads do not count against quota if
   * photos are less than 2048 pixels on their longest side or videos are less
   * than 15 minutes in length.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to create the activity on behalf of.
   *
   * [collection] - null
   * Possible string values are:
   * - "cloud" : Upload the media to share on Google+.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Media].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Media> insert(Media request, core.String userId, core.String collection, {commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/media/' + commons.Escaper.ecapeVariable('$collection');
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/plusDomains/v1/people/' + commons.Escaper.ecapeVariable('$userId') + '/media/' + commons.Escaper.ecapeVariable('$collection');
    } else {
      _url = '/upload/plusDomains/v1/people/' + commons.Escaper.ecapeVariable('$userId') + '/media/' + commons.Escaper.ecapeVariable('$collection');
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Media.fromJson(data));
  }

}


class PeopleResourceApi {
  final commons.ApiRequester _requester;

  PeopleResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Get a person's profile.
   *
   * Request parameters:
   *
   * [userId] - The ID of the person to get the profile for. The special value
   * "me" can be used to indicate the authenticated user.
   *
   * Completes with a [Person].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Person> get(core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId');

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
   * List all of the people in the specified collection.
   *
   * Request parameters:
   *
   * [userId] - Get the collection of people for the person identified. Use "me"
   * to indicate the authenticated user.
   *
   * [collection] - The collection of people to list.
   * Possible string values are:
   * - "circled" : The list of people who this user has added to one or more
   * circles.
   *
   * [maxResults] - The maximum number of people to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [orderBy] - The order to return people in.
   * Possible string values are:
   * - "alphabetical" : Order the people by their display name.
   * - "best" : Order people based on the relevence to the viewer.
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [PeopleFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PeopleFeed> list(core.String userId, core.String collection, {core.int maxResults, core.String orderBy, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'people/' + commons.Escaper.ecapeVariable('$userId') + '/people/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PeopleFeed.fromJson(data));
  }

  /**
   * List all of the people in the specified collection for a particular
   * activity.
   *
   * Request parameters:
   *
   * [activityId] - The ID of the activity to get the list of people for.
   *
   * [collection] - The collection of people to list.
   * Possible string values are:
   * - "plusoners" : List all people who have +1'd this activity.
   * - "resharers" : List all people who have reshared this activity.
   * - "sharedto" : List all people who this activity was shared to.
   *
   * [maxResults] - The maximum number of people to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [PeopleFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PeopleFeed> listByActivity(core.String activityId, core.String collection, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (activityId == null) {
      throw new core.ArgumentError("Parameter activityId is required.");
    }
    if (collection == null) {
      throw new core.ArgumentError("Parameter collection is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'activities/' + commons.Escaper.ecapeVariable('$activityId') + '/people/' + commons.Escaper.ecapeVariable('$collection');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PeopleFeed.fromJson(data));
  }

  /**
   * List all of the people who are members of a circle.
   *
   * Request parameters:
   *
   * [circleId] - The ID of the circle to get the members of.
   *
   * [maxResults] - The maximum number of people to include in the response,
   * which is used for paging. For any response, the actual number returned
   * might be less than the specified maxResults.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of "nextPageToken" from the previous response.
   *
   * Completes with a [PeopleFeed].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PeopleFeed> listByCircle(core.String circleId, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (circleId == null) {
      throw new core.ArgumentError("Parameter circleId is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'circles/' + commons.Escaper.ecapeVariable('$circleId') + '/people';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PeopleFeed.fromJson(data));
  }

}



class Acl {
  /** Description of the access granted, suitable for display. */
  core.String description;
  /** Whether access is restricted to the domain. */
  core.bool domainRestricted;
  /** The list of access entries. */
  core.List<PlusDomainsAclentryResource> items;
  /**
   * Identifies this resource as a collection of access controls. Value:
   * "plus#acl".
   */
  core.String kind;

  Acl();

  Acl.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("domainRestricted")) {
      domainRestricted = _json["domainRestricted"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PlusDomainsAclentryResource.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (domainRestricted != null) {
      _json["domainRestricted"] = domainRestricted;
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

/** Actor info specific to YouTube clients. */
class ActivityActorClientSpecificActorInfoYoutubeActorInfo {
  /** ID of the YouTube channel owned by the Actor. */
  core.String channelId;

  ActivityActorClientSpecificActorInfoYoutubeActorInfo();

  ActivityActorClientSpecificActorInfoYoutubeActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    return _json;
  }
}

/** Actor info specific to particular clients. */
class ActivityActorClientSpecificActorInfo {
  /** Actor info specific to YouTube clients. */
  ActivityActorClientSpecificActorInfoYoutubeActorInfo youtubeActorInfo;

  ActivityActorClientSpecificActorInfo();

  ActivityActorClientSpecificActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("youtubeActorInfo")) {
      youtubeActorInfo = new ActivityActorClientSpecificActorInfoYoutubeActorInfo.fromJson(_json["youtubeActorInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (youtubeActorInfo != null) {
      _json["youtubeActorInfo"] = (youtubeActorInfo).toJson();
    }
    return _json;
  }
}

/** The image representation of the actor. */
class ActivityActorImage {
  /**
   * The URL of the actor's profile photo. To resize the image and crop it to a
   * square, append the query string ?sz=x, where x is the dimension in pixels
   * of each side.
   */
  core.String url;

  ActivityActorImage();

  ActivityActorImage.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** An object representation of the individual components of name. */
class ActivityActorName {
  /** The family name ("last name") of the actor. */
  core.String familyName;
  /** The given name ("first name") of the actor. */
  core.String givenName;

  ActivityActorName();

  ActivityActorName.fromJson(core.Map _json) {
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("givenName")) {
      givenName = _json["givenName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (familyName != null) {
      _json["familyName"] = familyName;
    }
    if (givenName != null) {
      _json["givenName"] = givenName;
    }
    return _json;
  }
}

/** Verification status of actor. */
class ActivityActorVerification {
  /** Verification for one-time or manual processes. */
  core.String adHocVerified;

  ActivityActorVerification();

  ActivityActorVerification.fromJson(core.Map _json) {
    if (_json.containsKey("adHocVerified")) {
      adHocVerified = _json["adHocVerified"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adHocVerified != null) {
      _json["adHocVerified"] = adHocVerified;
    }
    return _json;
  }
}

/** The person who performed this activity. */
class ActivityActor {
  /** Actor info specific to particular clients. */
  ActivityActorClientSpecificActorInfo clientSpecificActorInfo;
  /** The name of the actor, suitable for display. */
  core.String displayName;
  /** The ID of the actor's Person resource. */
  core.String id;
  /** The image representation of the actor. */
  ActivityActorImage image;
  /** An object representation of the individual components of name. */
  ActivityActorName name;
  /** The link to the actor's Google profile. */
  core.String url;
  /** Verification status of actor. */
  ActivityActorVerification verification;

  ActivityActor();

  ActivityActor.fromJson(core.Map _json) {
    if (_json.containsKey("clientSpecificActorInfo")) {
      clientSpecificActorInfo = new ActivityActorClientSpecificActorInfo.fromJson(_json["clientSpecificActorInfo"]);
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new ActivityActorImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("name")) {
      name = new ActivityActorName.fromJson(_json["name"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("verification")) {
      verification = new ActivityActorVerification.fromJson(_json["verification"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientSpecificActorInfo != null) {
      _json["clientSpecificActorInfo"] = (clientSpecificActorInfo).toJson();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (verification != null) {
      _json["verification"] = (verification).toJson();
    }
    return _json;
  }
}

/** Actor info specific to YouTube clients. */
class ActivityObjectActorClientSpecificActorInfoYoutubeActorInfo {
  /** ID of the YouTube channel owned by the Actor. */
  core.String channelId;

  ActivityObjectActorClientSpecificActorInfoYoutubeActorInfo();

  ActivityObjectActorClientSpecificActorInfoYoutubeActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    return _json;
  }
}

/** Actor info specific to particular clients. */
class ActivityObjectActorClientSpecificActorInfo {
  /** Actor info specific to YouTube clients. */
  ActivityObjectActorClientSpecificActorInfoYoutubeActorInfo youtubeActorInfo;

  ActivityObjectActorClientSpecificActorInfo();

  ActivityObjectActorClientSpecificActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("youtubeActorInfo")) {
      youtubeActorInfo = new ActivityObjectActorClientSpecificActorInfoYoutubeActorInfo.fromJson(_json["youtubeActorInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (youtubeActorInfo != null) {
      _json["youtubeActorInfo"] = (youtubeActorInfo).toJson();
    }
    return _json;
  }
}

/** The image representation of the original actor. */
class ActivityObjectActorImage {
  /** A URL that points to a thumbnail photo of the original actor. */
  core.String url;

  ActivityObjectActorImage();

  ActivityObjectActorImage.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Verification status of actor. */
class ActivityObjectActorVerification {
  /** Verification for one-time or manual processes. */
  core.String adHocVerified;

  ActivityObjectActorVerification();

  ActivityObjectActorVerification.fromJson(core.Map _json) {
    if (_json.containsKey("adHocVerified")) {
      adHocVerified = _json["adHocVerified"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adHocVerified != null) {
      _json["adHocVerified"] = adHocVerified;
    }
    return _json;
  }
}

/**
 * If this activity's object is itself another activity, such as when a person
 * reshares an activity, this property specifies the original activity's actor.
 */
class ActivityObjectActor {
  /** Actor info specific to particular clients. */
  ActivityObjectActorClientSpecificActorInfo clientSpecificActorInfo;
  /** The original actor's name, which is suitable for display. */
  core.String displayName;
  /** ID of the original actor. */
  core.String id;
  /** The image representation of the original actor. */
  ActivityObjectActorImage image;
  /** A link to the original actor's Google profile. */
  core.String url;
  /** Verification status of actor. */
  ActivityObjectActorVerification verification;

  ActivityObjectActor();

  ActivityObjectActor.fromJson(core.Map _json) {
    if (_json.containsKey("clientSpecificActorInfo")) {
      clientSpecificActorInfo = new ActivityObjectActorClientSpecificActorInfo.fromJson(_json["clientSpecificActorInfo"]);
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new ActivityObjectActorImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("verification")) {
      verification = new ActivityObjectActorVerification.fromJson(_json["verification"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientSpecificActorInfo != null) {
      _json["clientSpecificActorInfo"] = (clientSpecificActorInfo).toJson();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (verification != null) {
      _json["verification"] = (verification).toJson();
    }
    return _json;
  }
}

/** If the attachment is a video, the embeddable link. */
class ActivityObjectAttachmentsEmbed {
  /** Media type of the link. */
  core.String type;
  /** URL of the link. */
  core.String url;

  ActivityObjectAttachmentsEmbed();

  ActivityObjectAttachmentsEmbed.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The full image URL for photo attachments. */
class ActivityObjectAttachmentsFullImage {
  /** The height, in pixels, of the linked resource. */
  core.int height;
  /** Media type of the link. */
  core.String type;
  /** URL of the image. */
  core.String url;
  /** The width, in pixels, of the linked resource. */
  core.int width;

  ActivityObjectAttachmentsFullImage();

  ActivityObjectAttachmentsFullImage.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
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
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** The preview image for photos or videos. */
class ActivityObjectAttachmentsImage {
  /** The height, in pixels, of the linked resource. */
  core.int height;
  /** Media type of the link. */
  core.String type;
  /** Image URL. */
  core.String url;
  /** The width, in pixels, of the linked resource. */
  core.int width;

  ActivityObjectAttachmentsImage();

  ActivityObjectAttachmentsImage.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
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
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class ActivityObjectAttachmentsPreviewThumbnails {
  /** URL of the thumbnail image. */
  core.String url;

  ActivityObjectAttachmentsPreviewThumbnails();

  ActivityObjectAttachmentsPreviewThumbnails.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Image resource. */
class ActivityObjectAttachmentsThumbnailsImage {
  /** The height, in pixels, of the linked resource. */
  core.int height;
  /** Media type of the link. */
  core.String type;
  /** Image url. */
  core.String url;
  /** The width, in pixels, of the linked resource. */
  core.int width;

  ActivityObjectAttachmentsThumbnailsImage();

  ActivityObjectAttachmentsThumbnailsImage.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
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
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class ActivityObjectAttachmentsThumbnails {
  /** Potential name of the thumbnail. */
  core.String description;
  /** Image resource. */
  ActivityObjectAttachmentsThumbnailsImage image;
  /** URL of the webpage containing the image. */
  core.String url;

  ActivityObjectAttachmentsThumbnails();

  ActivityObjectAttachmentsThumbnails.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("image")) {
      image = new ActivityObjectAttachmentsThumbnailsImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class ActivityObjectAttachments {
  /**
   * If the attachment is an article, this property contains a snippet of text
   * from the article. It can also include descriptions for other types.
   */
  core.String content;
  /**
   * The title of the attachment, such as a photo caption or an article title.
   */
  core.String displayName;
  /** If the attachment is a video, the embeddable link. */
  ActivityObjectAttachmentsEmbed embed;
  /** The full image URL for photo attachments. */
  ActivityObjectAttachmentsFullImage fullImage;
  /** The ID of the attachment. */
  core.String id;
  /** The preview image for photos or videos. */
  ActivityObjectAttachmentsImage image;
  /**
   * The type of media object. Possible values include, but are not limited to,
   * the following values:
   * - "photo" - A photo.
   * - "album" - A photo album.
   * - "video" - A video.
   * - "article" - An article, specified by a link.
   */
  core.String objectType;
  /**
   * When previewing, these are the optional thumbnails for the post. When
   * posting an article, choose one by setting the attachment.image.url
   * property. If you don't choose one, one will be chosen for you.
   */
  core.List<ActivityObjectAttachmentsPreviewThumbnails> previewThumbnails;
  /**
   * If the attachment is an album, this property is a list of potential
   * additional thumbnails from the album.
   */
  core.List<ActivityObjectAttachmentsThumbnails> thumbnails;
  /** The link to the attachment, which should be of type text/html. */
  core.String url;

  ActivityObjectAttachments();

  ActivityObjectAttachments.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("embed")) {
      embed = new ActivityObjectAttachmentsEmbed.fromJson(_json["embed"]);
    }
    if (_json.containsKey("fullImage")) {
      fullImage = new ActivityObjectAttachmentsFullImage.fromJson(_json["fullImage"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new ActivityObjectAttachmentsImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("previewThumbnails")) {
      previewThumbnails = _json["previewThumbnails"].map((value) => new ActivityObjectAttachmentsPreviewThumbnails.fromJson(value)).toList();
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = _json["thumbnails"].map((value) => new ActivityObjectAttachmentsThumbnails.fromJson(value)).toList();
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (embed != null) {
      _json["embed"] = (embed).toJson();
    }
    if (fullImage != null) {
      _json["fullImage"] = (fullImage).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (previewThumbnails != null) {
      _json["previewThumbnails"] = previewThumbnails.map((value) => (value).toJson()).toList();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = thumbnails.map((value) => (value).toJson()).toList();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** People who +1'd this activity. */
class ActivityObjectPlusoners {
  /** The URL for the collection of people who +1'd this activity. */
  core.String selfLink;
  /** Total number of people who +1'd this activity. */
  core.int totalItems;

  ActivityObjectPlusoners();

  ActivityObjectPlusoners.fromJson(core.Map _json) {
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** Comments in reply to this activity. */
class ActivityObjectReplies {
  /** The URL for the collection of comments in reply to this activity. */
  core.String selfLink;
  /** Total number of comments on this activity. */
  core.int totalItems;

  ActivityObjectReplies();

  ActivityObjectReplies.fromJson(core.Map _json) {
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** People who reshared this activity. */
class ActivityObjectResharers {
  /** The URL for the collection of resharers. */
  core.String selfLink;
  /** Total number of people who reshared this activity. */
  core.int totalItems;

  ActivityObjectResharers();

  ActivityObjectResharers.fromJson(core.Map _json) {
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** Status of the activity as seen by the viewer. */
class ActivityObjectStatusForViewer {
  /** Whether the viewer can comment on the activity. */
  core.bool canComment;
  /** Whether the viewer can +1 the activity. */
  core.bool canPlusone;
  /** Whether the viewer can edit or delete the activity. */
  core.bool canUpdate;
  /** Whether the viewer has +1'd the activity. */
  core.bool isPlusOned;
  /** Whether reshares are disabled for the activity. */
  core.bool resharingDisabled;

  ActivityObjectStatusForViewer();

  ActivityObjectStatusForViewer.fromJson(core.Map _json) {
    if (_json.containsKey("canComment")) {
      canComment = _json["canComment"];
    }
    if (_json.containsKey("canPlusone")) {
      canPlusone = _json["canPlusone"];
    }
    if (_json.containsKey("canUpdate")) {
      canUpdate = _json["canUpdate"];
    }
    if (_json.containsKey("isPlusOned")) {
      isPlusOned = _json["isPlusOned"];
    }
    if (_json.containsKey("resharingDisabled")) {
      resharingDisabled = _json["resharingDisabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (canComment != null) {
      _json["canComment"] = canComment;
    }
    if (canPlusone != null) {
      _json["canPlusone"] = canPlusone;
    }
    if (canUpdate != null) {
      _json["canUpdate"] = canUpdate;
    }
    if (isPlusOned != null) {
      _json["isPlusOned"] = isPlusOned;
    }
    if (resharingDisabled != null) {
      _json["resharingDisabled"] = resharingDisabled;
    }
    return _json;
  }
}

/** The object of this activity. */
class ActivityObject {
  /**
   * If this activity's object is itself another activity, such as when a person
   * reshares an activity, this property specifies the original activity's
   * actor.
   */
  ActivityObjectActor actor;
  /** The media objects attached to this activity. */
  core.List<ActivityObjectAttachments> attachments;
  /** The HTML-formatted content, which is suitable for display. */
  core.String content;
  /**
   * The ID of the object. When resharing an activity, this is the ID of the
   * activity that is being reshared.
   */
  core.String id;
  /**
   * The type of the object. Possible values include, but are not limited to,
   * the following values:
   * - "note" - Textual content.
   * - "activity" - A Google+ activity.
   */
  core.String objectType;
  /**
   * The content (text) as provided by the author, which is stored without any
   * HTML formatting. When creating or updating an activity, this value must be
   * supplied as plain text in the request.
   */
  core.String originalContent;
  /** People who +1'd this activity. */
  ActivityObjectPlusoners plusoners;
  /** Comments in reply to this activity. */
  ActivityObjectReplies replies;
  /** People who reshared this activity. */
  ActivityObjectResharers resharers;
  /** Status of the activity as seen by the viewer. */
  ActivityObjectStatusForViewer statusForViewer;
  /** The URL that points to the linked resource. */
  core.String url;

  ActivityObject();

  ActivityObject.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = new ActivityObjectActor.fromJson(_json["actor"]);
    }
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"].map((value) => new ActivityObjectAttachments.fromJson(value)).toList();
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("originalContent")) {
      originalContent = _json["originalContent"];
    }
    if (_json.containsKey("plusoners")) {
      plusoners = new ActivityObjectPlusoners.fromJson(_json["plusoners"]);
    }
    if (_json.containsKey("replies")) {
      replies = new ActivityObjectReplies.fromJson(_json["replies"]);
    }
    if (_json.containsKey("resharers")) {
      resharers = new ActivityObjectResharers.fromJson(_json["resharers"]);
    }
    if (_json.containsKey("statusForViewer")) {
      statusForViewer = new ActivityObjectStatusForViewer.fromJson(_json["statusForViewer"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = (actor).toJson();
    }
    if (attachments != null) {
      _json["attachments"] = attachments.map((value) => (value).toJson()).toList();
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (originalContent != null) {
      _json["originalContent"] = originalContent;
    }
    if (plusoners != null) {
      _json["plusoners"] = (plusoners).toJson();
    }
    if (replies != null) {
      _json["replies"] = (replies).toJson();
    }
    if (resharers != null) {
      _json["resharers"] = (resharers).toJson();
    }
    if (statusForViewer != null) {
      _json["statusForViewer"] = (statusForViewer).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The service provider that initially published this activity. */
class ActivityProvider {
  /** Name of the service provider. */
  core.String title;

  ActivityProvider();

  ActivityProvider.fromJson(core.Map _json) {
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class Activity {
  /** Identifies who has access to see this activity. */
  Acl access;
  /** The person who performed this activity. */
  ActivityActor actor;
  /** Street address where this activity occurred. */
  core.String address;
  /**
   * Additional content added by the person who shared this activity, applicable
   * only when resharing an activity.
   */
  core.String annotation;
  /**
   * If this activity is a crosspost from another system, this property
   * specifies the ID of the original activity.
   */
  core.String crosspostSource;
  /** ETag of this response for caching purposes. */
  core.String etag;
  /**
   * Latitude and longitude where this activity occurred. Format is latitude
   * followed by longitude, space separated.
   */
  core.String geocode;
  /** The ID of this activity. */
  core.String id;
  /** Identifies this resource as an activity. Value: "plus#activity". */
  core.String kind;
  /** The location where this activity occurred. */
  Place location;
  /** The object of this activity. */
  ActivityObject object;
  /** ID of the place where this activity occurred. */
  core.String placeId;
  /** Name of the place where this activity occurred. */
  core.String placeName;
  /** The service provider that initially published this activity. */
  ActivityProvider provider;
  /**
   * The time at which this activity was initially published. Formatted as an
   * RFC 3339 timestamp.
   */
  core.DateTime published;
  /**
   * Radius, in meters, of the region where this activity occurred, centered at
   * the latitude and longitude identified in geocode.
   */
  core.String radius;
  /** Title of this activity. */
  core.String title;
  /**
   * The time at which this activity was last updated. Formatted as an RFC 3339
   * timestamp.
   */
  core.DateTime updated;
  /** The link to this activity. */
  core.String url;
  /**
   * This activity's verb, which indicates the action that was performed.
   * Possible values include, but are not limited to, the following values:
   * - "post" - Publish content to the stream.
   * - "share" - Reshare an activity.
   */
  core.String verb;

  Activity();

  Activity.fromJson(core.Map _json) {
    if (_json.containsKey("access")) {
      access = new Acl.fromJson(_json["access"]);
    }
    if (_json.containsKey("actor")) {
      actor = new ActivityActor.fromJson(_json["actor"]);
    }
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("annotation")) {
      annotation = _json["annotation"];
    }
    if (_json.containsKey("crosspostSource")) {
      crosspostSource = _json["crosspostSource"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("geocode")) {
      geocode = _json["geocode"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("location")) {
      location = new Place.fromJson(_json["location"]);
    }
    if (_json.containsKey("object")) {
      object = new ActivityObject.fromJson(_json["object"]);
    }
    if (_json.containsKey("placeId")) {
      placeId = _json["placeId"];
    }
    if (_json.containsKey("placeName")) {
      placeName = _json["placeName"];
    }
    if (_json.containsKey("provider")) {
      provider = new ActivityProvider.fromJson(_json["provider"]);
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("radius")) {
      radius = _json["radius"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("verb")) {
      verb = _json["verb"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (access != null) {
      _json["access"] = (access).toJson();
    }
    if (actor != null) {
      _json["actor"] = (actor).toJson();
    }
    if (address != null) {
      _json["address"] = address;
    }
    if (annotation != null) {
      _json["annotation"] = annotation;
    }
    if (crosspostSource != null) {
      _json["crosspostSource"] = crosspostSource;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (geocode != null) {
      _json["geocode"] = geocode;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (object != null) {
      _json["object"] = (object).toJson();
    }
    if (placeId != null) {
      _json["placeId"] = placeId;
    }
    if (placeName != null) {
      _json["placeName"] = placeName;
    }
    if (provider != null) {
      _json["provider"] = (provider).toJson();
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (radius != null) {
      _json["radius"] = radius;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (verb != null) {
      _json["verb"] = verb;
    }
    return _json;
  }
}

class ActivityFeed {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ID of this collection of activities. Deprecated. */
  core.String id;
  /** The activities in this page of results. */
  core.List<Activity> items;
  /**
   * Identifies this resource as a collection of activities. Value:
   * "plus#activityFeed".
   */
  core.String kind;
  /** Link to the next page of activities. */
  core.String nextLink;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /** Link to this activity resource. */
  core.String selfLink;
  /**
   * The title of this collection of activities, which is a truncated portion of
   * the content.
   */
  core.String title;
  /**
   * The time at which this collection of activities was last updated. Formatted
   * as an RFC 3339 timestamp.
   */
  core.DateTime updated;

  ActivityFeed();

  ActivityFeed.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Activity.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
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
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class Audience {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The access control list entry. */
  PlusDomainsAclentryResource item;
  /** Identifies this resource as an audience. Value: "plus#audience". */
  core.String kind;
  /**
   * The number of people in this circle. This only applies if entity_type is
   * CIRCLE.
   */
  core.int memberCount;
  /**
   * The circle members' visibility as chosen by the owner of the circle. This
   * only applies for items with "item.type" equals "circle". Possible values
   * are:
   * - "public" - Members are visible to the public.
   * - "limited" - Members are visible to a limited audience.
   * - "private" - Members are visible to the owner only.
   */
  core.String visibility;

  Audience();

  Audience.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("item")) {
      item = new PlusDomainsAclentryResource.fromJson(_json["item"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("memberCount")) {
      memberCount = _json["memberCount"];
    }
    if (_json.containsKey("visibility")) {
      visibility = _json["visibility"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (item != null) {
      _json["item"] = (item).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (memberCount != null) {
      _json["memberCount"] = memberCount;
    }
    if (visibility != null) {
      _json["visibility"] = visibility;
    }
    return _json;
  }
}

class AudiencesFeed {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The audiences in this result. */
  core.List<Audience> items;
  /**
   * Identifies this resource as a collection of audiences. Value:
   * "plus#audienceFeed".
   */
  core.String kind;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /**
   * The total number of ACL entries. The number of entries in this response may
   * be smaller due to paging.
   */
  core.int totalItems;

  AudiencesFeed();

  AudiencesFeed.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Audience.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** The people in this circle. */
class CirclePeople {
  /** The total number of people in this circle. */
  core.int totalItems;

  CirclePeople();

  CirclePeople.fromJson(core.Map _json) {
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class Circle {
  /** The description of this circle. */
  core.String description;
  /** The circle name. */
  core.String displayName;
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ID of the circle. */
  core.String id;
  /** Identifies this resource as a circle. Value: "plus#circle". */
  core.String kind;
  /** The people in this circle. */
  CirclePeople people;
  /** Link to this circle resource */
  core.String selfLink;

  Circle();

  Circle.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
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
    if (_json.containsKey("people")) {
      people = new CirclePeople.fromJson(_json["people"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
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
    if (people != null) {
      _json["people"] = (people).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

class CircleFeed {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The circles in this page of results. */
  core.List<Circle> items;
  /**
   * Identifies this resource as a collection of circles. Value:
   * "plus#circleFeed".
   */
  core.String kind;
  /** Link to the next page of circles. */
  core.String nextLink;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /** Link to this page of circles. */
  core.String selfLink;
  /** The title of this list of resources. */
  core.String title;
  /**
   * The total number of circles. The number of circles in this response may be
   * smaller due to paging.
   */
  core.int totalItems;

  CircleFeed();

  CircleFeed.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Circle.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** Actor info specific to YouTube clients. */
class CommentActorClientSpecificActorInfoYoutubeActorInfo {
  /** ID of the YouTube channel owned by the Actor. */
  core.String channelId;

  CommentActorClientSpecificActorInfoYoutubeActorInfo();

  CommentActorClientSpecificActorInfoYoutubeActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    return _json;
  }
}

/** Actor info specific to particular clients. */
class CommentActorClientSpecificActorInfo {
  /** Actor info specific to YouTube clients. */
  CommentActorClientSpecificActorInfoYoutubeActorInfo youtubeActorInfo;

  CommentActorClientSpecificActorInfo();

  CommentActorClientSpecificActorInfo.fromJson(core.Map _json) {
    if (_json.containsKey("youtubeActorInfo")) {
      youtubeActorInfo = new CommentActorClientSpecificActorInfoYoutubeActorInfo.fromJson(_json["youtubeActorInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (youtubeActorInfo != null) {
      _json["youtubeActorInfo"] = (youtubeActorInfo).toJson();
    }
    return _json;
  }
}

/** The image representation of this actor. */
class CommentActorImage {
  /**
   * The URL of the actor's profile photo. To resize the image and crop it to a
   * square, append the query string ?sz=x, where x is the dimension in pixels
   * of each side.
   */
  core.String url;

  CommentActorImage();

  CommentActorImage.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Verification status of actor. */
class CommentActorVerification {
  /** Verification for one-time or manual processes. */
  core.String adHocVerified;

  CommentActorVerification();

  CommentActorVerification.fromJson(core.Map _json) {
    if (_json.containsKey("adHocVerified")) {
      adHocVerified = _json["adHocVerified"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adHocVerified != null) {
      _json["adHocVerified"] = adHocVerified;
    }
    return _json;
  }
}

/** The person who posted this comment. */
class CommentActor {
  /** Actor info specific to particular clients. */
  CommentActorClientSpecificActorInfo clientSpecificActorInfo;
  /** The name of this actor, suitable for display. */
  core.String displayName;
  /** The ID of the actor. */
  core.String id;
  /** The image representation of this actor. */
  CommentActorImage image;
  /** A link to the Person resource for this actor. */
  core.String url;
  /** Verification status of actor. */
  CommentActorVerification verification;

  CommentActor();

  CommentActor.fromJson(core.Map _json) {
    if (_json.containsKey("clientSpecificActorInfo")) {
      clientSpecificActorInfo = new CommentActorClientSpecificActorInfo.fromJson(_json["clientSpecificActorInfo"]);
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new CommentActorImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("verification")) {
      verification = new CommentActorVerification.fromJson(_json["verification"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientSpecificActorInfo != null) {
      _json["clientSpecificActorInfo"] = (clientSpecificActorInfo).toJson();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (verification != null) {
      _json["verification"] = (verification).toJson();
    }
    return _json;
  }
}

class CommentInReplyTo {
  /** The ID of the activity. */
  core.String id;
  /** The URL of the activity. */
  core.String url;

  CommentInReplyTo();

  CommentInReplyTo.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The object of this comment. */
class CommentObject {
  /** The HTML-formatted content, suitable for display. */
  core.String content;
  /**
   * The object type of this comment. Possible values are:
   * - "comment" - A comment in reply to an activity.
   */
  core.String objectType;
  /**
   * The content (text) as provided by the author, stored without any HTML
   * formatting. When creating or updating a comment, this value must be
   * supplied as plain text in the request.
   */
  core.String originalContent;

  CommentObject();

  CommentObject.fromJson(core.Map _json) {
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("originalContent")) {
      originalContent = _json["originalContent"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (content != null) {
      _json["content"] = content;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (originalContent != null) {
      _json["originalContent"] = originalContent;
    }
    return _json;
  }
}

/** People who +1'd this comment. */
class CommentPlusoners {
  /** Total number of people who +1'd this comment. */
  core.int totalItems;

  CommentPlusoners();

  CommentPlusoners.fromJson(core.Map _json) {
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class Comment {
  /** The person who posted this comment. */
  CommentActor actor;
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ID of this comment. */
  core.String id;
  /** The activity this comment replied to. */
  core.List<CommentInReplyTo> inReplyTo;
  /** Identifies this resource as a comment. Value: "plus#comment". */
  core.String kind;
  /** The object of this comment. */
  CommentObject object;
  /** People who +1'd this comment. */
  CommentPlusoners plusoners;
  /**
   * The time at which this comment was initially published. Formatted as an RFC
   * 3339 timestamp.
   */
  core.DateTime published;
  /** Link to this comment resource. */
  core.String selfLink;
  /**
   * The time at which this comment was last updated. Formatted as an RFC 3339
   * timestamp.
   */
  core.DateTime updated;
  /**
   * This comment's verb, indicating what action was performed. Possible values
   * are:
   * - "post" - Publish content to the stream.
   */
  core.String verb;

  Comment();

  Comment.fromJson(core.Map _json) {
    if (_json.containsKey("actor")) {
      actor = new CommentActor.fromJson(_json["actor"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inReplyTo")) {
      inReplyTo = _json["inReplyTo"].map((value) => new CommentInReplyTo.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("object")) {
      object = new CommentObject.fromJson(_json["object"]);
    }
    if (_json.containsKey("plusoners")) {
      plusoners = new CommentPlusoners.fromJson(_json["plusoners"]);
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("verb")) {
      verb = _json["verb"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actor != null) {
      _json["actor"] = (actor).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inReplyTo != null) {
      _json["inReplyTo"] = inReplyTo.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (object != null) {
      _json["object"] = (object).toJson();
    }
    if (plusoners != null) {
      _json["plusoners"] = (plusoners).toJson();
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (verb != null) {
      _json["verb"] = verb;
    }
    return _json;
  }
}

class CommentFeed {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** The ID of this collection of comments. */
  core.String id;
  /** The comments in this page of results. */
  core.List<Comment> items;
  /**
   * Identifies this resource as a collection of comments. Value:
   * "plus#commentFeed".
   */
  core.String kind;
  /** Link to the next page of activities. */
  core.String nextLink;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /** The title of this collection of comments. */
  core.String title;
  /**
   * The time at which this collection of comments was last updated. Formatted
   * as an RFC 3339 timestamp.
   */
  core.DateTime updated;

  CommentFeed();

  CommentFeed.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Comment.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextLink")) {
      nextLink = _json["nextLink"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
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
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (nextLink != null) {
      _json["nextLink"] = nextLink;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/** The author's Google profile image. */
class MediaAuthorImage {
  /**
   * The URL of the author's profile photo. To resize the image and crop it to a
   * square, append the query string ?sz=x, where x is the dimension in pixels
   * of each side.
   */
  core.String url;

  MediaAuthorImage();

  MediaAuthorImage.fromJson(core.Map _json) {
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** The person who uploaded this media. */
class MediaAuthor {
  /** The author's name. */
  core.String displayName;
  /** ID of the author. */
  core.String id;
  /** The author's Google profile image. */
  MediaAuthorImage image;
  /** A link to the author's Google profile. */
  core.String url;

  MediaAuthor();

  MediaAuthor.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new MediaAuthorImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Exif information of the media item. */
class MediaExif {
  /** The time the media was captured. Formatted as an RFC 3339 timestamp. */
  core.DateTime time;

  MediaExif();

  MediaExif.fromJson(core.Map _json) {
    if (_json.containsKey("time")) {
      time = core.DateTime.parse(_json["time"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (time != null) {
      _json["time"] = (time).toIso8601String();
    }
    return _json;
  }
}

class Media {
  /** The person who uploaded this media. */
  MediaAuthor author;
  /** The display name for this media. */
  core.String displayName;
  /** ETag of this response for caching purposes. */
  core.String etag;
  /** Exif information of the media item. */
  MediaExif exif;
  /** The height in pixels of the original image. */
  core.int height;
  /** ID of this media, which is generated by the API. */
  core.String id;
  /** The type of resource. */
  core.String kind;
  /**
   * The time at which this media was originally created in UTC. Formatted as an
   * RFC 3339 timestamp that matches this example: 2010-11-25T14:30:27.655Z
   */
  core.DateTime mediaCreatedTime;
  /** The URL of this photo or video's still image. */
  core.String mediaUrl;
  /**
   * The time at which this media was uploaded. Formatted as an RFC 3339
   * timestamp.
   */
  core.DateTime published;
  /** The size in bytes of this video. */
  core.String sizeBytes;
  /**
   * The list of video streams for this video. There might be several different
   * streams available for a single video, either Flash or MPEG, of various
   * sizes
   */
  core.List<Videostream> streams;
  /** A description, or caption, for this media. */
  core.String summary;
  /**
   * The time at which this media was last updated. This includes changes to
   * media metadata. Formatted as an RFC 3339 timestamp.
   */
  core.DateTime updated;
  /** The URL for the page that hosts this media. */
  core.String url;
  /** The duration in milliseconds of this video. */
  core.String videoDuration;
  /**
   * The encoding status of this video. Possible values are:
   * - "UPLOADING" - Not all the video bytes have been received.
   * - "PENDING" - Video not yet processed.
   * - "FAILED" - Video processing failed.
   * - "READY" - A single video stream is playable.
   * - "FINAL" - All video streams are playable.
   */
  core.String videoStatus;
  /** The width in pixels of the original image. */
  core.int width;

  Media();

  Media.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new MediaAuthor.fromJson(_json["author"]);
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("exif")) {
      exif = new MediaExif.fromJson(_json["exif"]);
    }
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("mediaCreatedTime")) {
      mediaCreatedTime = core.DateTime.parse(_json["mediaCreatedTime"]);
    }
    if (_json.containsKey("mediaUrl")) {
      mediaUrl = _json["mediaUrl"];
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("sizeBytes")) {
      sizeBytes = _json["sizeBytes"];
    }
    if (_json.containsKey("streams")) {
      streams = _json["streams"].map((value) => new Videostream.fromJson(value)).toList();
    }
    if (_json.containsKey("summary")) {
      summary = _json["summary"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("videoDuration")) {
      videoDuration = _json["videoDuration"];
    }
    if (_json.containsKey("videoStatus")) {
      videoStatus = _json["videoStatus"];
    }
    if (_json.containsKey("width")) {
      width = _json["width"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (exif != null) {
      _json["exif"] = (exif).toJson();
    }
    if (height != null) {
      _json["height"] = height;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (mediaCreatedTime != null) {
      _json["mediaCreatedTime"] = (mediaCreatedTime).toIso8601String();
    }
    if (mediaUrl != null) {
      _json["mediaUrl"] = mediaUrl;
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (sizeBytes != null) {
      _json["sizeBytes"] = sizeBytes;
    }
    if (streams != null) {
      _json["streams"] = streams.map((value) => (value).toJson()).toList();
    }
    if (summary != null) {
      _json["summary"] = summary;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (videoDuration != null) {
      _json["videoDuration"] = videoDuration;
    }
    if (videoStatus != null) {
      _json["videoStatus"] = videoStatus;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

class PeopleFeed {
  /** ETag of this response for caching purposes. */
  core.String etag;
  /**
   * The people in this page of results. Each item includes the id, displayName,
   * image, and url for the person. To retrieve additional profile data, see the
   * people.get method.
   */
  core.List<Person> items;
  /**
   * Identifies this resource as a collection of people. Value:
   * "plus#peopleFeed".
   */
  core.String kind;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /** Link to this resource. */
  core.String selfLink;
  /** The title of this collection of people. */
  core.String title;
  /**
   * The total number of people available in this list. The number of people in
   * a response might be smaller due to paging. This might not be set for all
   * collections.
   */
  core.int totalItems;

  PeopleFeed();

  PeopleFeed.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Person.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

/** Extra information about the cover photo. */
class PersonCoverCoverInfo {
  /**
   * The difference between the left position of the cover image and the actual
   * displayed cover image. Only valid for banner layout.
   */
  core.int leftImageOffset;
  /**
   * The difference between the top position of the cover image and the actual
   * displayed cover image. Only valid for banner layout.
   */
  core.int topImageOffset;

  PersonCoverCoverInfo();

  PersonCoverCoverInfo.fromJson(core.Map _json) {
    if (_json.containsKey("leftImageOffset")) {
      leftImageOffset = _json["leftImageOffset"];
    }
    if (_json.containsKey("topImageOffset")) {
      topImageOffset = _json["topImageOffset"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (leftImageOffset != null) {
      _json["leftImageOffset"] = leftImageOffset;
    }
    if (topImageOffset != null) {
      _json["topImageOffset"] = topImageOffset;
    }
    return _json;
  }
}

/** The person's primary cover image. */
class PersonCoverCoverPhoto {
  /** The height of the image. */
  core.int height;
  /** The URL of the image. */
  core.String url;
  /** The width of the image. */
  core.int width;

  PersonCoverCoverPhoto();

  PersonCoverCoverPhoto.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
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
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/** The cover photo content. */
class PersonCover {
  /** Extra information about the cover photo. */
  PersonCoverCoverInfo coverInfo;
  /** The person's primary cover image. */
  PersonCoverCoverPhoto coverPhoto;
  /**
   * The layout of the cover art. Possible values include, but are not limited
   * to, the following values:
   * - "banner" - One large image banner.
   */
  core.String layout;

  PersonCover();

  PersonCover.fromJson(core.Map _json) {
    if (_json.containsKey("coverInfo")) {
      coverInfo = new PersonCoverCoverInfo.fromJson(_json["coverInfo"]);
    }
    if (_json.containsKey("coverPhoto")) {
      coverPhoto = new PersonCoverCoverPhoto.fromJson(_json["coverPhoto"]);
    }
    if (_json.containsKey("layout")) {
      layout = _json["layout"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (coverInfo != null) {
      _json["coverInfo"] = (coverInfo).toJson();
    }
    if (coverPhoto != null) {
      _json["coverPhoto"] = (coverPhoto).toJson();
    }
    if (layout != null) {
      _json["layout"] = layout;
    }
    return _json;
  }
}

class PersonEmails {
  /**
   * The type of address. Possible values include, but are not limited to, the
   * following values:
   * - "account" - Google account email address.
   * - "home" - Home email address.
   * - "work" - Work email address.
   * - "other" - Other.
   */
  core.String type;
  /** The email address. */
  core.String value;

  PersonEmails();

  PersonEmails.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** The representation of the person's profile photo. */
class PersonImage {
  /** Whether the person's profile photo is the default one */
  core.bool isDefault;
  /**
   * The URL of the person's profile photo. To resize the image and crop it to a
   * square, append the query string ?sz=x, where x is the dimension in pixels
   * of each side.
   */
  core.String url;

  PersonImage();

  PersonImage.fromJson(core.Map _json) {
    if (_json.containsKey("isDefault")) {
      isDefault = _json["isDefault"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isDefault != null) {
      _json["isDefault"] = isDefault;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/**
 * An object representation of the individual components of a person's name.
 */
class PersonName {
  /** The family name (last name) of this person. */
  core.String familyName;
  /** The full name of this person, including middle names, suffixes, etc. */
  core.String formatted;
  /** The given name (first name) of this person. */
  core.String givenName;
  /** The honorific prefixes (such as "Dr." or "Mrs.") for this person. */
  core.String honorificPrefix;
  /** The honorific suffixes (such as "Jr.") for this person. */
  core.String honorificSuffix;
  /** The middle name of this person. */
  core.String middleName;

  PersonName();

  PersonName.fromJson(core.Map _json) {
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("formatted")) {
      formatted = _json["formatted"];
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
    if (_json.containsKey("middleName")) {
      middleName = _json["middleName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (familyName != null) {
      _json["familyName"] = familyName;
    }
    if (formatted != null) {
      _json["formatted"] = formatted;
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
    if (middleName != null) {
      _json["middleName"] = middleName;
    }
    return _json;
  }
}

class PersonOrganizations {
  /** The department within the organization. Deprecated. */
  core.String department;
  /**
   * A short description of the person's role in this organization. Deprecated.
   */
  core.String description;
  /** The date that the person left this organization. */
  core.String endDate;
  /** The location of this organization. Deprecated. */
  core.String location;
  /** The name of the organization. */
  core.String name;
  /**
   * If "true", indicates this organization is the person's primary one, which
   * is typically interpreted as the current one.
   */
  core.bool primary;
  /** The date that the person joined this organization. */
  core.String startDate;
  /** The person's job title or role within the organization. */
  core.String title;
  /**
   * The type of organization. Possible values include, but are not limited to,
   * the following values:
   * - "work" - Work.
   * - "school" - School.
   */
  core.String type;

  PersonOrganizations();

  PersonOrganizations.fromJson(core.Map _json) {
    if (_json.containsKey("department")) {
      department = _json["department"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
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
    if (department != null) {
      _json["department"] = department;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
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

class PersonPlacesLived {
  /** If "true", this place of residence is this person's primary residence. */
  core.bool primary;
  /**
   * A place where this person has lived. For example: "Seattle, WA", "Near
   * Toronto".
   */
  core.String value;

  PersonPlacesLived();

  PersonPlacesLived.fromJson(core.Map _json) {
    if (_json.containsKey("primary")) {
      primary = _json["primary"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (primary != null) {
      _json["primary"] = primary;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class PersonUrls {
  /** The label of the URL. */
  core.String label;
  /**
   * The type of URL. Possible values include, but are not limited to, the
   * following values:
   * - "otherProfile" - URL for another profile.
   * - "contributor" - URL to a site for which this person is a contributor.
   * - "website" - URL for this Google+ Page's primary website.
   * - "other" - Other URL.
   */
  core.String type;
  /** The URL value. */
  core.String value;

  PersonUrls();

  PersonUrls.fromJson(core.Map _json) {
    if (_json.containsKey("label")) {
      label = _json["label"];
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
    if (label != null) {
      _json["label"] = label;
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

class Person {
  /** A short biography for this person. */
  core.String aboutMe;
  /** The person's date of birth, represented as YYYY-MM-DD. */
  core.String birthday;
  /** The "bragging rights" line of this person. */
  core.String braggingRights;
  /**
   * For followers who are visible, the number of people who have added this
   * person or page to a circle.
   */
  core.int circledByCount;
  /** The cover photo content. */
  PersonCover cover;
  /** (this field is not currently used) */
  core.String currentLocation;
  /** The name of this person, which is suitable for display. */
  core.String displayName;
  /**
   * The hosted domain name for the user's Google Apps account. For instance,
   * example.com. The plus.profile.emails.read or email scope is needed to get
   * this domain name.
   */
  core.String domain;
  /**
   * A list of email addresses that this person has, including their Google
   * account email address, and the public verified email addresses on their
   * Google+ profile. The plus.profile.emails.read scope is needed to retrieve
   * these email addresses, or the email scope can be used to retrieve just the
   * Google account email address.
   */
  core.List<PersonEmails> emails;
  /** ETag of this response for caching purposes. */
  core.String etag;
  /**
   * The person's gender. Possible values include, but are not limited to, the
   * following values:
   * - "male" - Male gender.
   * - "female" - Female gender.
   * - "other" - Other.
   */
  core.String gender;
  /** The ID of this person. */
  core.String id;
  /** The representation of the person's profile photo. */
  PersonImage image;
  /** Whether this user has signed up for Google+. */
  core.bool isPlusUser;
  /** Identifies this resource as a person. Value: "plus#person". */
  core.String kind;
  /**
   * An object representation of the individual components of a person's name.
   */
  PersonName name;
  /** The nickname of this person. */
  core.String nickname;
  /**
   * Type of person within Google+. Possible values include, but are not limited
   * to, the following values:
   * - "person" - represents an actual person.
   * - "page" - represents a page.
   */
  core.String objectType;
  /** The occupation of this person. */
  core.String occupation;
  /**
   * A list of current or past organizations with which this person is
   * associated.
   */
  core.List<PersonOrganizations> organizations;
  /** A list of places where this person has lived. */
  core.List<PersonPlacesLived> placesLived;
  /** If a Google+ Page, the number of people who have +1'd this page. */
  core.int plusOneCount;
  /**
   * The person's relationship status. Possible values include, but are not
   * limited to, the following values:
   * - "single" - Person is single.
   * - "in_a_relationship" - Person is in a relationship.
   * - "engaged" - Person is engaged.
   * - "married" - Person is married.
   * - "its_complicated" - The relationship is complicated.
   * - "open_relationship" - Person is in an open relationship.
   * - "widowed" - Person is widowed.
   * - "in_domestic_partnership" - Person is in a domestic partnership.
   * - "in_civil_union" - Person is in a civil union.
   */
  core.String relationshipStatus;
  /** The person's skills. */
  core.String skills;
  /** The brief description (tagline) of this person. */
  core.String tagline;
  /** The URL of this person's profile. */
  core.String url;
  /** A list of URLs for this person. */
  core.List<PersonUrls> urls;
  /** Whether the person or Google+ Page has been verified. */
  core.bool verified;

  Person();

  Person.fromJson(core.Map _json) {
    if (_json.containsKey("aboutMe")) {
      aboutMe = _json["aboutMe"];
    }
    if (_json.containsKey("birthday")) {
      birthday = _json["birthday"];
    }
    if (_json.containsKey("braggingRights")) {
      braggingRights = _json["braggingRights"];
    }
    if (_json.containsKey("circledByCount")) {
      circledByCount = _json["circledByCount"];
    }
    if (_json.containsKey("cover")) {
      cover = new PersonCover.fromJson(_json["cover"]);
    }
    if (_json.containsKey("currentLocation")) {
      currentLocation = _json["currentLocation"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("emails")) {
      emails = _json["emails"].map((value) => new PersonEmails.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("gender")) {
      gender = _json["gender"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new PersonImage.fromJson(_json["image"]);
    }
    if (_json.containsKey("isPlusUser")) {
      isPlusUser = _json["isPlusUser"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("name")) {
      name = new PersonName.fromJson(_json["name"]);
    }
    if (_json.containsKey("nickname")) {
      nickname = _json["nickname"];
    }
    if (_json.containsKey("objectType")) {
      objectType = _json["objectType"];
    }
    if (_json.containsKey("occupation")) {
      occupation = _json["occupation"];
    }
    if (_json.containsKey("organizations")) {
      organizations = _json["organizations"].map((value) => new PersonOrganizations.fromJson(value)).toList();
    }
    if (_json.containsKey("placesLived")) {
      placesLived = _json["placesLived"].map((value) => new PersonPlacesLived.fromJson(value)).toList();
    }
    if (_json.containsKey("plusOneCount")) {
      plusOneCount = _json["plusOneCount"];
    }
    if (_json.containsKey("relationshipStatus")) {
      relationshipStatus = _json["relationshipStatus"];
    }
    if (_json.containsKey("skills")) {
      skills = _json["skills"];
    }
    if (_json.containsKey("tagline")) {
      tagline = _json["tagline"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
    if (_json.containsKey("urls")) {
      urls = _json["urls"].map((value) => new PersonUrls.fromJson(value)).toList();
    }
    if (_json.containsKey("verified")) {
      verified = _json["verified"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aboutMe != null) {
      _json["aboutMe"] = aboutMe;
    }
    if (birthday != null) {
      _json["birthday"] = birthday;
    }
    if (braggingRights != null) {
      _json["braggingRights"] = braggingRights;
    }
    if (circledByCount != null) {
      _json["circledByCount"] = circledByCount;
    }
    if (cover != null) {
      _json["cover"] = (cover).toJson();
    }
    if (currentLocation != null) {
      _json["currentLocation"] = currentLocation;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (emails != null) {
      _json["emails"] = emails.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (gender != null) {
      _json["gender"] = gender;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (isPlusUser != null) {
      _json["isPlusUser"] = isPlusUser;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (nickname != null) {
      _json["nickname"] = nickname;
    }
    if (objectType != null) {
      _json["objectType"] = objectType;
    }
    if (occupation != null) {
      _json["occupation"] = occupation;
    }
    if (organizations != null) {
      _json["organizations"] = organizations.map((value) => (value).toJson()).toList();
    }
    if (placesLived != null) {
      _json["placesLived"] = placesLived.map((value) => (value).toJson()).toList();
    }
    if (plusOneCount != null) {
      _json["plusOneCount"] = plusOneCount;
    }
    if (relationshipStatus != null) {
      _json["relationshipStatus"] = relationshipStatus;
    }
    if (skills != null) {
      _json["skills"] = skills;
    }
    if (tagline != null) {
      _json["tagline"] = tagline;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (urls != null) {
      _json["urls"] = urls.map((value) => (value).toJson()).toList();
    }
    if (verified != null) {
      _json["verified"] = verified;
    }
    return _json;
  }
}

/** The physical address of the place. */
class PlaceAddress {
  /** The formatted address for display. */
  core.String formatted;

  PlaceAddress();

  PlaceAddress.fromJson(core.Map _json) {
    if (_json.containsKey("formatted")) {
      formatted = _json["formatted"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formatted != null) {
      _json["formatted"] = formatted;
    }
    return _json;
  }
}

/** The position of the place. */
class PlacePosition {
  /** The latitude of this position. */
  core.double latitude;
  /** The longitude of this position. */
  core.double longitude;

  PlacePosition();

  PlacePosition.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

class Place {
  /** The physical address of the place. */
  PlaceAddress address;
  /** The display name of the place. */
  core.String displayName;
  /** The id of the place. */
  core.String id;
  /** Identifies this resource as a place. Value: "plus#place". */
  core.String kind;
  /** The position of the place. */
  PlacePosition position;

  Place();

  Place.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = new PlaceAddress.fromJson(_json["address"]);
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("position")) {
      position = new PlacePosition.fromJson(_json["position"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = (address).toJson();
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    return _json;
  }
}

class PlusDomainsAclentryResource {
  /** A descriptive name for this entry. Suitable for display. */
  core.String displayName;
  /**
   * The ID of the entry. For entries of type "person" or "circle", this is the
   * ID of the resource. For other types, this property is not set.
   */
  core.String id;
  /**
   * The type of entry describing to whom access is granted. Possible values
   * are:
   * - "person" - Access to an individual.
   * - "circle" - Access to members of a circle.
   * - "myCircles" - Access to members of all the person's circles.
   * - "extendedCircles" - Access to members of all the person's circles, plus
   * all of the people in their circles.
   * - "domain" - Access to members of the person's Google Apps domain.
   * - "public" - Access to anyone on the web.
   */
  core.String type;

  PlusDomainsAclentryResource();

  PlusDomainsAclentryResource.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class Videostream {
  /** The height, in pixels, of the video resource. */
  core.int height;
  /** MIME type of the video stream. */
  core.String type;
  /** URL of the video stream. */
  core.String url;
  /** The width, in pixels, of the video resource. */
  core.int width;

  Videostream();

  Videostream.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
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
    if (type != null) {
      _json["type"] = type;
    }
    if (url != null) {
      _json["url"] = url;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}
