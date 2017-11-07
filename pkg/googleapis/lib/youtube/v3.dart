// This is a generated file (see the discoveryapis_generator project).

library googleapis.youtube.v3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client youtube/v3';

/**
 * Supports core YouTube features, such as uploading videos, creating and
 * managing playlists, searching for content, and much more.
 */
class YoutubeApi {
  /** Manage your YouTube account */
  static const YoutubeScope = "https://www.googleapis.com/auth/youtube";

  /** Manage your YouTube account */
  static const YoutubeForceSslScope = "https://www.googleapis.com/auth/youtube.force-ssl";

  /** View your YouTube account */
  static const YoutubeReadonlyScope = "https://www.googleapis.com/auth/youtube.readonly";

  /** Manage your YouTube videos */
  static const YoutubeUploadScope = "https://www.googleapis.com/auth/youtube.upload";

  /** View and manage your assets and associated content on YouTube */
  static const YoutubepartnerScope = "https://www.googleapis.com/auth/youtubepartner";

  /**
   * View private information of your YouTube channel relevant during the audit
   * process with a YouTube partner
   */
  static const YoutubepartnerChannelAuditScope = "https://www.googleapis.com/auth/youtubepartner-channel-audit";


  final commons.ApiRequester _requester;

  ActivitiesResourceApi get activities => new ActivitiesResourceApi(_requester);
  CaptionsResourceApi get captions => new CaptionsResourceApi(_requester);
  ChannelBannersResourceApi get channelBanners => new ChannelBannersResourceApi(_requester);
  ChannelSectionsResourceApi get channelSections => new ChannelSectionsResourceApi(_requester);
  ChannelsResourceApi get channels => new ChannelsResourceApi(_requester);
  CommentThreadsResourceApi get commentThreads => new CommentThreadsResourceApi(_requester);
  CommentsResourceApi get comments => new CommentsResourceApi(_requester);
  FanFundingEventsResourceApi get fanFundingEvents => new FanFundingEventsResourceApi(_requester);
  GuideCategoriesResourceApi get guideCategories => new GuideCategoriesResourceApi(_requester);
  I18nLanguagesResourceApi get i18nLanguages => new I18nLanguagesResourceApi(_requester);
  I18nRegionsResourceApi get i18nRegions => new I18nRegionsResourceApi(_requester);
  LiveBroadcastsResourceApi get liveBroadcasts => new LiveBroadcastsResourceApi(_requester);
  LiveChatBansResourceApi get liveChatBans => new LiveChatBansResourceApi(_requester);
  LiveChatMessagesResourceApi get liveChatMessages => new LiveChatMessagesResourceApi(_requester);
  LiveChatModeratorsResourceApi get liveChatModerators => new LiveChatModeratorsResourceApi(_requester);
  LiveStreamsResourceApi get liveStreams => new LiveStreamsResourceApi(_requester);
  PlaylistItemsResourceApi get playlistItems => new PlaylistItemsResourceApi(_requester);
  PlaylistsResourceApi get playlists => new PlaylistsResourceApi(_requester);
  SearchResourceApi get search => new SearchResourceApi(_requester);
  SponsorsResourceApi get sponsors => new SponsorsResourceApi(_requester);
  SubscriptionsResourceApi get subscriptions => new SubscriptionsResourceApi(_requester);
  SuperChatEventsResourceApi get superChatEvents => new SuperChatEventsResourceApi(_requester);
  ThumbnailsResourceApi get thumbnails => new ThumbnailsResourceApi(_requester);
  VideoAbuseReportReasonsResourceApi get videoAbuseReportReasons => new VideoAbuseReportReasonsResourceApi(_requester);
  VideoCategoriesResourceApi get videoCategories => new VideoCategoriesResourceApi(_requester);
  VideosResourceApi get videos => new VideosResourceApi(_requester);
  WatermarksResourceApi get watermarks => new WatermarksResourceApi(_requester);

  YoutubeApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "youtube/v3/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ActivitiesResourceApi {
  final commons.ApiRequester _requester;

  ActivitiesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Posts a bulletin for a specific channel. (The user submitting the request
   * must be authorized to act on the channel's behalf.)
   *
   * Note: Even though an activity resource can contain information about
   * actions like a user rating a video or marking a video as a favorite, you
   * need to use other API methods to generate those activity resources. For
   * example, you would use the API's videos.rate() method to rate a video and
   * the playlistItems.insert() method to mark a video as a favorite.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Completes with a [Activity].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Activity> insert(Activity request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'activities';

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
   * Returns a list of channel activity events that match the request criteria.
   * For example, you can retrieve events associated with a particular channel,
   * events associated with the user's subscriptions and Google+ friends, or the
   * YouTube home page feed, which is customized for each user.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * activity resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in an
   * activity resource, the snippet property contains other properties that
   * identify the type of activity, a display title for the activity, and so
   * forth. If you set part=snippet, the API response will also contain all of
   * those nested properties.
   *
   * [channelId] - The channelId parameter specifies a unique YouTube channel
   * ID. The API will then return a list of that channel's activities.
   *
   * [home] - Set this parameter's value to true to retrieve the activity feed
   * that displays on the YouTube home page for the currently authenticated
   * user.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - Set this parameter's value to true to retrieve a feed of the
   * authenticated user's activities.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * [publishedAfter] - The publishedAfter parameter specifies the earliest date
   * and time that an activity could have occurred for that activity to be
   * included in the API response. If the parameter value specifies a day, but
   * not a time, then any activities that occurred that day will be included in
   * the result set. The value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ)
   * format.
   *
   * [publishedBefore] - The publishedBefore parameter specifies the date and
   * time before which an activity must have occurred for that activity to be
   * included in the API response. If the parameter value specifies a day, but
   * not a time, then any activities that occurred that day will be excluded
   * from the result set. The value is specified in ISO 8601
   * (YYYY-MM-DDThh:mm:ss.sZ) format.
   *
   * [regionCode] - The regionCode parameter instructs the API to return results
   * for the specified country. The parameter value is an ISO 3166-1 alpha-2
   * country code. YouTube uses this value when the authorized user's previous
   * activity on YouTube does not provide enough information to generate the
   * activity feed.
   *
   * Completes with a [ActivityListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ActivityListResponse> list(core.String part, {core.String channelId, core.bool home, core.int maxResults, core.bool mine, core.String pageToken, core.DateTime publishedAfter, core.DateTime publishedBefore, core.String regionCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (home != null) {
      _queryParams["home"] = ["${home}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (publishedAfter != null) {
      _queryParams["publishedAfter"] = [(publishedAfter).toIso8601String()];
    }
    if (publishedBefore != null) {
      _queryParams["publishedBefore"] = [(publishedBefore).toIso8601String()];
    }
    if (regionCode != null) {
      _queryParams["regionCode"] = [regionCode];
    }

    _url = 'activities';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ActivityListResponse.fromJson(data));
  }

}


class CaptionsResourceApi {
  final commons.ApiRequester _requester;

  CaptionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a specified caption track.
   *
   * Request parameters:
   *
   * [id] - The id parameter identifies the caption track that is being deleted.
   * The value is a caption track ID as identified by the id property in a
   * caption resource.
   *
   * [onBehalfOf] - ID of the Google+ Page for the channel that the request is
   * be on behalf of
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOf, core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOf != null) {
      _queryParams["onBehalfOf"] = [onBehalfOf];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'captions';

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
   * Downloads a caption track. The caption track is returned in its original
   * format unless the request specifies a value for the tfmt parameter and in
   * its original language unless the request specifies a value for the tlang
   * parameter.
   *
   * Request parameters:
   *
   * [id] - The id parameter identifies the caption track that is being
   * retrieved. The value is a caption track ID as identified by the id property
   * in a caption resource.
   *
   * [onBehalfOf] - ID of the Google+ Page for the channel that the request is
   * be on behalf of
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * [tfmt] - The tfmt parameter specifies that the caption track should be
   * returned in a specific format. If the parameter is not included in the
   * request, the track is returned in its original format.
   * Possible string values are:
   * - "sbv" : SubViewer subtitle.
   * - "scc" : Scenarist Closed Caption format.
   * - "srt" : SubRip subtitle.
   * - "ttml" : Timed Text Markup Language caption.
   * - "vtt" : Web Video Text Tracks caption.
   *
   * [tlang] - The tlang parameter specifies that the API response should return
   * a translation of the specified caption track. The parameter value is an ISO
   * 639-1 two-letter language code that identifies the desired caption
   * language. The translation is generated by using machine translation, such
   * as Google Translate.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future download(core.String id, {core.String onBehalfOf, core.String onBehalfOfContentOwner, core.String tfmt, core.String tlang, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (onBehalfOf != null) {
      _queryParams["onBehalfOf"] = [onBehalfOf];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (tfmt != null) {
      _queryParams["tfmt"] = [tfmt];
    }
    if (tlang != null) {
      _queryParams["tlang"] = [tlang];
    }

    _downloadOptions = downloadOptions;

    _url = 'captions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => null);
    } else {
      return _response;
    }
  }

  /**
   * Uploads a caption track.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the caption resource parts that the
   * API response will include. Set the parameter value to snippet.
   *
   * [onBehalfOf] - ID of the Google+ Page for the channel that the request is
   * be on behalf of
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * [sync] - The sync parameter indicates whether YouTube should automatically
   * synchronize the caption file with the audio track of the video. If you set
   * the value to true, YouTube will disregard any time codes that are in the
   * uploaded caption file and generate new time codes for the captions.
   *
   * You should set the sync parameter to true if you are uploading a
   * transcript, which has no time codes, or if you suspect the time codes in
   * your file are incorrect and want YouTube to try to fix them.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Caption].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Caption> insert(Caption request, core.String part, {core.String onBehalfOf, core.String onBehalfOfContentOwner, core.bool sync, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOf != null) {
      _queryParams["onBehalfOf"] = [onBehalfOf];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (sync != null) {
      _queryParams["sync"] = ["${sync}"];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'captions';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/captions';
    } else {
      _url = '/upload/youtube/v3/captions';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Caption.fromJson(data));
  }

  /**
   * Returns a list of caption tracks that are associated with a specified
   * video. Note that the API response does not contain the actual captions and
   * that the captions.download method provides the ability to retrieve a
   * caption track.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * caption resource parts that the API response will include. The part names
   * that you can include in the parameter value are id and snippet.
   *
   * [videoId] - The videoId parameter specifies the YouTube video ID of the
   * video for which the API should return caption tracks.
   *
   * [id] - The id parameter specifies a comma-separated list of IDs that
   * identify the caption resources that should be retrieved. Each ID must
   * identify a caption track associated with the specified video.
   *
   * [onBehalfOf] - ID of the Google+ Page for the channel that the request is
   * on behalf of.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * Completes with a [CaptionListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CaptionListResponse> list(core.String part, core.String videoId, {core.String id, core.String onBehalfOf, core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (videoId == null) {
      throw new core.ArgumentError("Parameter videoId is required.");
    }
    _queryParams["videoId"] = [videoId];
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (onBehalfOf != null) {
      _queryParams["onBehalfOf"] = [onBehalfOf];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'captions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CaptionListResponse.fromJson(data));
  }

  /**
   * Updates a caption track. When updating a caption track, you can change the
   * track's draft status, upload a new caption file for the track, or both.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include. Set the property value to
   * snippet if you are updating the track's draft status. Otherwise, set the
   * property value to id.
   *
   * [onBehalfOf] - ID of the Google+ Page for the channel that the request is
   * be on behalf of
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * [sync] - Note: The API server only processes the parameter value if the
   * request contains an updated caption file.
   *
   * The sync parameter indicates whether YouTube should automatically
   * synchronize the caption file with the audio track of the video. If you set
   * the value to true, YouTube will automatically synchronize the caption track
   * with the audio track.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Caption].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Caption> update(Caption request, core.String part, {core.String onBehalfOf, core.String onBehalfOfContentOwner, core.bool sync, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOf != null) {
      _queryParams["onBehalfOf"] = [onBehalfOf];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (sync != null) {
      _queryParams["sync"] = ["${sync}"];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'captions';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/captions';
    } else {
      _url = '/upload/youtube/v3/captions';
    }


    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Caption.fromJson(data));
  }

}


class ChannelBannersResourceApi {
  final commons.ApiRequester _requester;

  ChannelBannersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Uploads a channel banner image to YouTube. This method represents the first
   * two steps in a three-step process to update the banner image for a channel:
   *
   * - Call the channelBanners.insert method to upload the binary image data to
   * YouTube. The image must have a 16:9 aspect ratio and be at least 2120x1192
   * pixels.
   * - Extract the url property's value from the response that the API returns
   * for step 1.
   * - Call the channels.update method to update the channel's branding
   * settings. Set the brandingSettings.image.bannerExternalUrl property's value
   * to the URL obtained in step 2.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [ChannelBannerResource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChannelBannerResource> insert(ChannelBannerResource request, {core.String onBehalfOfContentOwner, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'channelBanners/insert';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/channelBanners/insert';
    } else {
      _url = '/upload/youtube/v3/channelBanners/insert';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChannelBannerResource.fromJson(data));
  }

}


class ChannelSectionsResourceApi {
  final commons.ApiRequester _requester;

  ChannelSectionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a channelSection.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube channelSection ID for the
   * resource that is being deleted. In a channelSection resource, the id
   * property specifies the YouTube channelSection ID.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'channelSections';

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
   * Adds a channelSection for the authenticated user's channel.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part names that you can include in the parameter value are snippet and
   * contentDetails.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [ChannelSection].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChannelSection> insert(ChannelSection request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'channelSections';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChannelSection.fromJson(data));
  }

  /**
   * Returns channelSection resources that match the API request criteria.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * channelSection resource properties that the API response will include. The
   * part names that you can include in the parameter value are id, snippet, and
   * contentDetails.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a
   * channelSection resource, the snippet property contains other properties,
   * such as a display title for the channelSection. If you set part=snippet,
   * the API response will also contain all of those nested properties.
   *
   * [channelId] - The channelId parameter specifies a YouTube channel ID. The
   * API will only return that channel's channelSections.
   *
   * [hl] - The hl parameter indicates that the snippet.localized property
   * values in the returned channelSection resources should be in the specified
   * language if localized values for that language are available. For example,
   * if the API request specifies hl=de, the snippet.localized properties in the
   * API response will contain German titles if German titles are available.
   * Channel owners can provide localized channel section titles using either
   * the channelSections.insert or channelSections.update method.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * channelSection ID(s) for the resource(s) that are being retrieved. In a
   * channelSection resource, the id property specifies the YouTube
   * channelSection ID.
   *
   * [mine] - Set this parameter's value to true to retrieve a feed of the
   * authenticated user's channelSections.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [ChannelSectionListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChannelSectionListResponse> list(core.String part, {core.String channelId, core.String hl, core.String id, core.bool mine, core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'channelSections';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChannelSectionListResponse.fromJson(data));
  }

  /**
   * Update a channelSection.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part names that you can include in the parameter value are snippet and
   * contentDetails.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [ChannelSection].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChannelSection> update(ChannelSection request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'channelSections';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChannelSection.fromJson(data));
  }

}


class ChannelsResourceApi {
  final commons.ApiRequester _requester;

  ChannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a collection of zero or more channel resources that match the
   * request criteria.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * channel resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a
   * channel resource, the contentDetails property contains other properties,
   * such as the uploads properties. As such, if you set part=contentDetails,
   * the API response will also contain all of those nested properties.
   *
   * [categoryId] - The categoryId parameter specifies a YouTube guide category,
   * thereby requesting YouTube channels associated with that category.
   *
   * [forUsername] - The forUsername parameter specifies a YouTube username,
   * thereby requesting the channel associated with that username.
   *
   * [hl] - The hl parameter should be used for filter out the properties that
   * are not in the given language. Used for the brandingSettings part.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * channel ID(s) for the resource(s) that are being retrieved. In a channel
   * resource, the id property specifies the channel's YouTube channel ID.
   *
   * [managedByMe] - Note: This parameter is intended exclusively for YouTube
   * content partners.
   *
   * Set this parameter's value to true to instruct the API to only return
   * channels managed by the content owner that the onBehalfOfContentOwner
   * parameter specifies. The user must be authenticated as a CMS account linked
   * to the specified content owner and onBehalfOfContentOwner must be provided.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - Set this parameter's value to true to instruct the API to only
   * return channels owned by the authenticated user.
   *
   * [mySubscribers] - Use the subscriptions.list method and its mySubscribers
   * parameter to retrieve a list of subscribers to the authenticated user's
   * channel.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [ChannelListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ChannelListResponse> list(core.String part, {core.String categoryId, core.String forUsername, core.String hl, core.String id, core.bool managedByMe, core.int maxResults, core.bool mine, core.bool mySubscribers, core.String onBehalfOfContentOwner, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (categoryId != null) {
      _queryParams["categoryId"] = [categoryId];
    }
    if (forUsername != null) {
      _queryParams["forUsername"] = [forUsername];
    }
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (managedByMe != null) {
      _queryParams["managedByMe"] = ["${managedByMe}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (mySubscribers != null) {
      _queryParams["mySubscribers"] = ["${mySubscribers}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'channels';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ChannelListResponse.fromJson(data));
  }

  /**
   * Updates a channel's metadata. Note that this method currently only supports
   * updates to the channel resource's brandingSettings and invideoPromotion
   * objects and their child properties.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The API currently only allows the parameter value to be set to either
   * brandingSettings or invideoPromotion. (You cannot update both of those
   * parts with a single request.)
   *
   * Note that this method overrides the existing values for all of the mutable
   * properties that are contained in any parts that the parameter value
   * specifies.
   *
   * [onBehalfOfContentOwner] - The onBehalfOfContentOwner parameter indicates
   * that the authenticated user is acting on behalf of the content owner
   * specified in the parameter value. This parameter is intended for YouTube
   * content partners that own and manage many different YouTube channels. It
   * allows content owners to authenticate once and get access to all their
   * video and channel data, without having to provide authentication
   * credentials for each individual channel. The actual CMS account that the
   * user authenticates with needs to be linked to the specified YouTube content
   * owner.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> update(Channel request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'channels';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}


class CommentThreadsResourceApi {
  final commons.ApiRequester _requester;

  CommentThreadsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new top-level comment. To add a reply to an existing comment, use
   * the comments.insert method instead.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter identifies the properties that the API response
   * will include. Set the parameter value to snippet. The snippet part has a
   * quota cost of 2 units.
   *
   * Completes with a [CommentThread].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentThread> insert(CommentThread request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'commentThreads';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentThread.fromJson(data));
  }

  /**
   * Returns a list of comment threads that match the API request parameters.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * commentThread resource properties that the API response will include.
   *
   * [allThreadsRelatedToChannelId] - The allThreadsRelatedToChannelId parameter
   * instructs the API to return all comment threads associated with the
   * specified channel. The response can include comments about the channel or
   * about the channel's videos.
   *
   * [channelId] - The channelId parameter instructs the API to return comment
   * threads containing comments about the specified channel. (The response will
   * not include comments left on videos that the channel uploaded.)
   *
   * [id] - The id parameter specifies a comma-separated list of comment thread
   * IDs for the resources that should be retrieved.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   * Value must be between "1" and "100".
   *
   * [moderationStatus] - Set this parameter to limit the returned comment
   * threads to a particular moderation state.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   * Possible string values are:
   * - "heldForReview" : Retrieve comment threads that are awaiting review by a
   * moderator. A comment thread can be included in the response if the
   * top-level comment or at least one of the replies to that comment are
   * awaiting review.
   * - "likelySpam" : Retrieve comment threads classified as likely to be spam.
   * A comment thread can be included in the response if the top-level comment
   * or at least one of the replies to that comment is considered likely to be
   * spam.
   * - "published" : Retrieve threads of published comments. This is the default
   * value. A comment thread can be included in the response if its top-level
   * comment has been published.
   *
   * [order] - The order parameter specifies the order in which the API response
   * should list comment threads. Valid values are:
   * - time - Comment threads are ordered by time. This is the default behavior.
   * - relevance - Comment threads are ordered by relevance.Note: This parameter
   * is not supported for use in conjunction with the id parameter.
   * Possible string values are:
   * - "relevance" : Order by relevance.
   * - "time" : Order by time.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * property identifies the next page of the result that can be retrieved.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   *
   * [searchTerms] - The searchTerms parameter instructs the API to limit the
   * API response to only contain comments that contain the specified search
   * terms.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   *
   * [textFormat] - Set this parameter's value to html or plainText to instruct
   * the API to return the comments left by users in html formatted or in plain
   * text.
   * Possible string values are:
   * - "html" : Returns the comments in HTML format. This is the default value.
   * - "plainText" : Returns the comments in plain text format.
   *
   * [videoId] - The videoId parameter instructs the API to return comment
   * threads associated with the specified video ID.
   *
   * Completes with a [CommentThreadListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentThreadListResponse> list(core.String part, {core.String allThreadsRelatedToChannelId, core.String channelId, core.String id, core.int maxResults, core.String moderationStatus, core.String order, core.String pageToken, core.String searchTerms, core.String textFormat, core.String videoId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (allThreadsRelatedToChannelId != null) {
      _queryParams["allThreadsRelatedToChannelId"] = [allThreadsRelatedToChannelId];
    }
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (moderationStatus != null) {
      _queryParams["moderationStatus"] = [moderationStatus];
    }
    if (order != null) {
      _queryParams["order"] = [order];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (searchTerms != null) {
      _queryParams["searchTerms"] = [searchTerms];
    }
    if (textFormat != null) {
      _queryParams["textFormat"] = [textFormat];
    }
    if (videoId != null) {
      _queryParams["videoId"] = [videoId];
    }

    _url = 'commentThreads';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentThreadListResponse.fromJson(data));
  }

  /**
   * Modifies the top-level comment in a comment thread.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of
   * commentThread resource properties that the API response will include. You
   * must at least include the snippet part in the parameter value since that
   * part contains all of the properties that the API request can update.
   *
   * Completes with a [CommentThread].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentThread> update(CommentThread request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'commentThreads';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentThread.fromJson(data));
  }

}


class CommentsResourceApi {
  final commons.ApiRequester _requester;

  CommentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a comment.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the comment ID for the resource that is
   * being deleted.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'comments';

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
   * Creates a reply to an existing comment. Note: To create a top-level
   * comment, use the commentThreads.insert method.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter identifies the properties that the API response
   * will include. Set the parameter value to snippet. The snippet part has a
   * quota cost of 2 units.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> insert(Comment request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'comments';

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
   * Returns a list of comments that match the API request parameters.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * comment resource properties that the API response will include.
   *
   * [id] - The id parameter specifies a comma-separated list of comment IDs for
   * the resources that are being retrieved. In a comment resource, the id
   * property specifies the comment's ID.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   * Value must be between "1" and "100".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * property identifies the next page of the result that can be retrieved.
   *
   * Note: This parameter is not supported for use in conjunction with the id
   * parameter.
   *
   * [parentId] - The parentId parameter specifies the ID of the comment for
   * which replies should be retrieved.
   *
   * Note: YouTube currently supports replies only for top-level comments.
   * However, replies to replies may be supported in the future.
   *
   * [textFormat] - This parameter indicates whether the API should return
   * comments formatted as HTML or as plain text.
   * Possible string values are:
   * - "html" : Returns the comments in HTML format. This is the default value.
   * - "plainText" : Returns the comments in plain text format.
   *
   * Completes with a [CommentListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentListResponse> list(core.String part, {core.String id, core.int maxResults, core.String pageToken, core.String parentId, core.String textFormat}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (id != null) {
      _queryParams["id"] = [id];
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
    if (textFormat != null) {
      _queryParams["textFormat"] = [textFormat];
    }

    _url = 'comments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentListResponse.fromJson(data));
  }

  /**
   * Expresses the caller's opinion that one or more comments should be flagged
   * as spam.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies a comma-separated list of IDs of comments
   * that the caller believes should be classified as spam.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future markAsSpam(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'comments/markAsSpam';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Sets the moderation status of one or more comments. The API request must be
   * authorized by the owner of the channel or video associated with the
   * comments.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies a comma-separated list of IDs that
   * identify the comments for which you are updating the moderation status.
   *
   * [moderationStatus] - Identifies the new moderation status of the specified
   * comments.
   * Possible string values are:
   * - "heldForReview" : Marks a comment as awaiting review by a moderator.
   * - "published" : Clears a comment for public display.
   * - "rejected" : Rejects a comment as being unfit for display. This action
   * also effectively hides all replies to the rejected comment.
   *
   * Note: The API does not currently provide a way to list or otherwise
   * discover rejected comments. However, you can change the moderation status
   * of a rejected comment if you still know its ID. If you were to change the
   * moderation status of a rejected comment, the comment replies would
   * subsequently be discoverable again as well.
   *
   * [banAuthor] - The banAuthor parameter lets you indicate that you want to
   * automatically reject any additional comments written by the comment's
   * author. Set the parameter value to true to ban the author.
   *
   * Note: This parameter is only valid if the moderationStatus parameter is
   * also set to rejected.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future setModerationStatus(core.String id, core.String moderationStatus, {core.bool banAuthor}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (moderationStatus == null) {
      throw new core.ArgumentError("Parameter moderationStatus is required.");
    }
    _queryParams["moderationStatus"] = [moderationStatus];
    if (banAuthor != null) {
      _queryParams["banAuthor"] = ["${banAuthor}"];
    }

    _downloadOptions = null;

    _url = 'comments/setModerationStatus';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Modifies a comment.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter identifies the properties that the API response
   * will include. You must at least include the snippet part in the parameter
   * value since that part contains all of the properties that the API request
   * can update.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> update(Comment request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'comments';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

}


class FanFundingEventsResourceApi {
  final commons.ApiRequester _requester;

  FanFundingEventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists fan funding events for a channel.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the fanFundingEvent resource parts
   * that the API response will include. Supported values are id and snippet.
   *
   * [hl] - The hl parameter instructs the API to retrieve localized resource
   * metadata for a specific application language that the YouTube website
   * supports. The parameter value must be a language code included in the list
   * returned by the i18nLanguages.list method.
   *
   * If localized resource details are available in that language, the
   * resource's snippet.localized object will contain the localized values.
   * However, if localized details are not available, the snippet.localized
   * object will contain resource details in the resource's default language.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [FanFundingEventListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<FanFundingEventListResponse> list(core.String part, {core.String hl, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'fanFundingEvents';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new FanFundingEventListResponse.fromJson(data));
  }

}


class GuideCategoriesResourceApi {
  final commons.ApiRequester _requester;

  GuideCategoriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of categories that can be associated with YouTube channels.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the guideCategory resource properties
   * that the API response will include. Set the parameter value to snippet.
   *
   * [hl] - The hl parameter specifies the language that will be used for text
   * values in the API response.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * channel category ID(s) for the resource(s) that are being retrieved. In a
   * guideCategory resource, the id property specifies the YouTube channel
   * category ID.
   *
   * [regionCode] - The regionCode parameter instructs the API to return the
   * list of guide categories available in the specified country. The parameter
   * value is an ISO 3166-1 alpha-2 country code.
   *
   * Completes with a [GuideCategoryListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GuideCategoryListResponse> list(core.String part, {core.String hl, core.String id, core.String regionCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (regionCode != null) {
      _queryParams["regionCode"] = [regionCode];
    }

    _url = 'guideCategories';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GuideCategoryListResponse.fromJson(data));
  }

}


class I18nLanguagesResourceApi {
  final commons.ApiRequester _requester;

  I18nLanguagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of application languages that the YouTube website supports.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the i18nLanguage resource properties
   * that the API response will include. Set the parameter value to snippet.
   *
   * [hl] - The hl parameter specifies the language that should be used for text
   * values in the API response.
   *
   * Completes with a [I18nLanguageListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<I18nLanguageListResponse> list(core.String part, {core.String hl}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }

    _url = 'i18nLanguages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new I18nLanguageListResponse.fromJson(data));
  }

}


class I18nRegionsResourceApi {
  final commons.ApiRequester _requester;

  I18nRegionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of content regions that the YouTube website supports.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the i18nRegion resource properties
   * that the API response will include. Set the parameter value to snippet.
   *
   * [hl] - The hl parameter specifies the language that should be used for text
   * values in the API response.
   *
   * Completes with a [I18nRegionListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<I18nRegionListResponse> list(core.String part, {core.String hl}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }

    _url = 'i18nRegions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new I18nRegionListResponse.fromJson(data));
  }

}


class LiveBroadcastsResourceApi {
  final commons.ApiRequester _requester;

  LiveBroadcastsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Binds a YouTube broadcast to a stream or removes an existing binding
   * between a broadcast and a stream. A broadcast can only be bound to one
   * video stream, though a video stream may be bound to more than one
   * broadcast.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the unique ID of the broadcast that is
   * being bound to a video stream.
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * liveBroadcast resource properties that the API response will include. The
   * part names that you can include in the parameter value are id, snippet,
   * contentDetails, and status.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [streamId] - The streamId parameter specifies the unique ID of the video
   * stream that is being bound to a broadcast. If this parameter is omitted,
   * the API will remove any existing binding between the broadcast and a video
   * stream.
   *
   * Completes with a [LiveBroadcast].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcast> bind(core.String id, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.String streamId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (streamId != null) {
      _queryParams["streamId"] = [streamId];
    }

    _url = 'liveBroadcasts/bind';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcast.fromJson(data));
  }

  /**
   * Controls the settings for a slate that can be displayed in the broadcast
   * stream.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube live broadcast ID that
   * uniquely identifies the broadcast in which the slate is being updated.
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * liveBroadcast resource properties that the API response will include. The
   * part names that you can include in the parameter value are id, snippet,
   * contentDetails, and status.
   *
   * [displaySlate] - The displaySlate parameter specifies whether the slate is
   * being enabled or disabled.
   *
   * [offsetTimeMs] - The offsetTimeMs parameter specifies a positive time
   * offset when the specified slate change will occur. The value is measured in
   * milliseconds from the beginning of the broadcast's monitor stream, which is
   * the time that the testing phase for the broadcast began. Even though it is
   * specified in milliseconds, the value is actually an approximation, and
   * YouTube completes the requested action as closely as possible to that time.
   *
   * If you do not specify a value for this parameter, then YouTube performs the
   * action as soon as possible. See the Getting started guide for more details.
   *
   * Important: You should only specify a value for this parameter if your
   * broadcast stream is delayed.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [walltime] - The walltime parameter specifies the wall clock time at which
   * the specified slate change will occur. The value is specified in ISO 8601
   * (YYYY-MM-DDThh:mm:ss.sssZ) format.
   *
   * Completes with a [LiveBroadcast].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcast> control(core.String id, core.String part, {core.bool displaySlate, core.String offsetTimeMs, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.DateTime walltime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (displaySlate != null) {
      _queryParams["displaySlate"] = ["${displaySlate}"];
    }
    if (offsetTimeMs != null) {
      _queryParams["offsetTimeMs"] = [offsetTimeMs];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (walltime != null) {
      _queryParams["walltime"] = [(walltime).toIso8601String()];
    }

    _url = 'liveBroadcasts/control';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcast.fromJson(data));
  }

  /**
   * Deletes a broadcast.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube live broadcast ID for the
   * resource that is being deleted.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _downloadOptions = null;

    _url = 'liveBroadcasts';

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
   * Creates a broadcast.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part properties that you can include in the parameter value are id,
   * snippet, contentDetails, and status.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [LiveBroadcast].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcast> insert(LiveBroadcast request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'liveBroadcasts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcast.fromJson(data));
  }

  /**
   * Returns a list of YouTube broadcasts that match the API request parameters.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * liveBroadcast resource properties that the API response will include. The
   * part names that you can include in the parameter value are id, snippet,
   * contentDetails, and status.
   *
   * [broadcastStatus] - The broadcastStatus parameter filters the API response
   * to only include broadcasts with the specified status.
   * Possible string values are:
   * - "active" : Return current live broadcasts.
   * - "all" : Return all broadcasts.
   * - "completed" : Return broadcasts that have already ended.
   * - "upcoming" : Return broadcasts that have not yet started.
   *
   * [broadcastType] - The broadcastType parameter filters the API response to
   * only include broadcasts with the specified type. This is only compatible
   * with the mine filter for now.
   * Possible string values are:
   * - "all" : Return all broadcasts.
   * - "event" : Return only scheduled event broadcasts.
   * - "persistent" : Return only persistent broadcasts.
   *
   * [id] - The id parameter specifies a comma-separated list of YouTube
   * broadcast IDs that identify the broadcasts being retrieved. In a
   * liveBroadcast resource, the id property specifies the broadcast's ID.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - The mine parameter can be used to instruct the API to only return
   * broadcasts owned by the authenticated user. Set the parameter value to true
   * to only retrieve your own broadcasts.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [LiveBroadcastListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcastListResponse> list(core.String part, {core.String broadcastStatus, core.String broadcastType, core.String id, core.int maxResults, core.bool mine, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (broadcastStatus != null) {
      _queryParams["broadcastStatus"] = [broadcastStatus];
    }
    if (broadcastType != null) {
      _queryParams["broadcastType"] = [broadcastType];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'liveBroadcasts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcastListResponse.fromJson(data));
  }

  /**
   * Changes the status of a YouTube live broadcast and initiates any processes
   * associated with the new status. For example, when you transition a
   * broadcast's status to testing, YouTube starts to transmit video to that
   * broadcast's monitor stream. Before calling this method, you should confirm
   * that the value of the status.streamStatus property for the stream bound to
   * your broadcast is active.
   *
   * Request parameters:
   *
   * [broadcastStatus] - The broadcastStatus parameter identifies the state to
   * which the broadcast is changing. Note that to transition a broadcast to
   * either the testing or live state, the status.streamStatus must be active
   * for the stream that the broadcast is bound to.
   * Possible string values are:
   * - "complete" : The broadcast is over. YouTube stops transmitting video.
   * - "live" : The broadcast is visible to its audience. YouTube transmits
   * video to the broadcast's monitor stream and its broadcast stream.
   * - "testing" : Start testing the broadcast. YouTube transmits video to the
   * broadcast's monitor stream. Note that you can only transition a broadcast
   * to the testing state if its
   * contentDetails.monitorStream.enableMonitorStream property is set to true.
   *
   * [id] - The id parameter specifies the unique ID of the broadcast that is
   * transitioning to another status.
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * liveBroadcast resource properties that the API response will include. The
   * part names that you can include in the parameter value are id, snippet,
   * contentDetails, and status.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [LiveBroadcast].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcast> transition(core.String broadcastStatus, core.String id, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (broadcastStatus == null) {
      throw new core.ArgumentError("Parameter broadcastStatus is required.");
    }
    _queryParams["broadcastStatus"] = [broadcastStatus];
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'liveBroadcasts/transition';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcast.fromJson(data));
  }

  /**
   * Updates a broadcast. For example, you could modify the broadcast settings
   * defined in the liveBroadcast resource's contentDetails object.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part properties that you can include in the parameter value are id,
   * snippet, contentDetails, and status.
   *
   * Note that this method will override the existing values for all of the
   * mutable properties that are contained in any parts that the parameter value
   * specifies. For example, a broadcast's privacy status is defined in the
   * status part. As such, if your request is updating a private or unlisted
   * broadcast, and the request's part parameter value includes the status part,
   * the broadcast's privacy setting will be updated to whatever value the
   * request body specifies. If the request body does not specify a value, the
   * existing privacy setting will be removed and the broadcast will revert to
   * the default privacy setting.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [LiveBroadcast].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveBroadcast> update(LiveBroadcast request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'liveBroadcasts';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveBroadcast.fromJson(data));
  }

}


class LiveChatBansResourceApi {
  final commons.ApiRequester _requester;

  LiveChatBansResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a chat ban.
   *
   * Request parameters:
   *
   * [id] - The id parameter identifies the chat ban to remove. The value
   * uniquely identifies both the ban and the chat.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'liveChat/bans';

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
   * Adds a new ban to the chat.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response returns. Set the parameter value to
   * snippet.
   *
   * Completes with a [LiveChatBan].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveChatBan> insert(LiveChatBan request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'liveChat/bans';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveChatBan.fromJson(data));
  }

}


class LiveChatMessagesResourceApi {
  final commons.ApiRequester _requester;

  LiveChatMessagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a chat message.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube chat message ID of the
   * resource that is being deleted.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'liveChat/messages';

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
   * Adds a message to a live chat.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes. It identifies the
   * properties that the write operation will set as well as the properties that
   * the API response will include. Set the parameter value to snippet.
   *
   * Completes with a [LiveChatMessage].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveChatMessage> insert(LiveChatMessage request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'liveChat/messages';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveChatMessage.fromJson(data));
  }

  /**
   * Lists live chat messages for a specific chat.
   *
   * Request parameters:
   *
   * [liveChatId] - The liveChatId parameter specifies the ID of the chat whose
   * messages will be returned.
   *
   * [part] - The part parameter specifies the liveChatComment resource parts
   * that the API response will include. Supported values are id and snippet.
   *
   * [hl] - The hl parameter instructs the API to retrieve localized resource
   * metadata for a specific application language that the YouTube website
   * supports. The parameter value must be a language code included in the list
   * returned by the i18nLanguages.list method.
   *
   * If localized resource details are available in that language, the
   * resource's snippet.localized object will contain the localized values.
   * However, if localized details are not available, the snippet.localized
   * object will contain resource details in the resource's default language.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * messages that should be returned in the result set.
   * Value must be between "200" and "2000".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * property identify other pages that could be retrieved.
   *
   * [profileImageSize] - The profileImageSize parameter specifies the size of
   * the user profile pictures that should be returned in the result set.
   * Default: 88.
   * Value must be between "16" and "720".
   *
   * Completes with a [LiveChatMessageListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveChatMessageListResponse> list(core.String liveChatId, core.String part, {core.String hl, core.int maxResults, core.String pageToken, core.int profileImageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (liveChatId == null) {
      throw new core.ArgumentError("Parameter liveChatId is required.");
    }
    _queryParams["liveChatId"] = [liveChatId];
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (profileImageSize != null) {
      _queryParams["profileImageSize"] = ["${profileImageSize}"];
    }

    _url = 'liveChat/messages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveChatMessageListResponse.fromJson(data));
  }

}


class LiveChatModeratorsResourceApi {
  final commons.ApiRequester _requester;

  LiveChatModeratorsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Removes a chat moderator.
   *
   * Request parameters:
   *
   * [id] - The id parameter identifies the chat moderator to remove. The value
   * uniquely identifies both the moderator and the chat.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'liveChat/moderators';

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
   * Adds a new moderator for the chat.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response returns. Set the parameter value to
   * snippet.
   *
   * Completes with a [LiveChatModerator].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveChatModerator> insert(LiveChatModerator request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'liveChat/moderators';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveChatModerator.fromJson(data));
  }

  /**
   * Lists moderators for a live chat.
   *
   * Request parameters:
   *
   * [liveChatId] - The liveChatId parameter specifies the YouTube live chat for
   * which the API should return moderators.
   *
   * [part] - The part parameter specifies the liveChatModerator resource parts
   * that the API response will include. Supported values are id and snippet.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [LiveChatModeratorListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveChatModeratorListResponse> list(core.String liveChatId, core.String part, {core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (liveChatId == null) {
      throw new core.ArgumentError("Parameter liveChatId is required.");
    }
    _queryParams["liveChatId"] = [liveChatId];
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'liveChat/moderators';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveChatModeratorListResponse.fromJson(data));
  }

}


class LiveStreamsResourceApi {
  final commons.ApiRequester _requester;

  LiveStreamsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a video stream.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube live stream ID for the
   * resource that is being deleted.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _downloadOptions = null;

    _url = 'liveStreams';

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
   * Creates a video stream. The stream enables you to send your video to
   * YouTube, which can then broadcast the video to your audience.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part properties that you can include in the parameter value are id,
   * snippet, cdn, and status.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [LiveStream].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveStream> insert(LiveStream request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'liveStreams';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveStream.fromJson(data));
  }

  /**
   * Returns a list of video streams that match the API request parameters.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * liveStream resource properties that the API response will include. The part
   * names that you can include in the parameter value are id, snippet, cdn, and
   * status.
   *
   * [id] - The id parameter specifies a comma-separated list of YouTube stream
   * IDs that identify the streams being retrieved. In a liveStream resource,
   * the id property specifies the stream's ID.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - The mine parameter can be used to instruct the API to only return
   * streams owned by the authenticated user. Set the parameter value to true to
   * only retrieve your own streams.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [LiveStreamListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveStreamListResponse> list(core.String part, {core.String id, core.int maxResults, core.bool mine, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'liveStreams';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveStreamListResponse.fromJson(data));
  }

  /**
   * Updates a video stream. If the properties that you want to change cannot be
   * updated, then you need to create a new stream with the proper settings.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * The part properties that you can include in the parameter value are id,
   * snippet, cdn, and status.
   *
   * Note that this method will override the existing values for all of the
   * mutable properties that are contained in any parts that the parameter value
   * specifies. If the request body does not specify a value for a mutable
   * property, the existing value for that property will be removed.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [LiveStream].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LiveStream> update(LiveStream request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'liveStreams';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LiveStream.fromJson(data));
  }

}


class PlaylistItemsResourceApi {
  final commons.ApiRequester _requester;

  PlaylistItemsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a playlist item.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube playlist item ID for the
   * playlist item that is being deleted. In a playlistItem resource, the id
   * property specifies the playlist item's ID.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'playlistItems';

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
   * Adds a resource to a playlist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [PlaylistItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlaylistItem> insert(PlaylistItem request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'playlistItems';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlaylistItem.fromJson(data));
  }

  /**
   * Returns a collection of playlist items that match the API request
   * parameters. You can retrieve all of the playlist items in a specified
   * playlist or retrieve one or more playlist items by their unique IDs.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * playlistItem resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a
   * playlistItem resource, the snippet property contains numerous fields,
   * including the title, description, position, and resourceId properties. As
   * such, if you set part=snippet, the API response will contain all of those
   * properties.
   *
   * [id] - The id parameter specifies a comma-separated list of one or more
   * unique playlist item IDs.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * [playlistId] - The playlistId parameter specifies the unique ID of the
   * playlist for which you want to retrieve playlist items. Note that even
   * though this is an optional parameter, every request to retrieve playlist
   * items must specify a value for either the id parameter or the playlistId
   * parameter.
   *
   * [videoId] - The videoId parameter specifies that the request should return
   * only the playlist items that contain the specified video.
   *
   * Completes with a [PlaylistItemListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlaylistItemListResponse> list(core.String part, {core.String id, core.int maxResults, core.String onBehalfOfContentOwner, core.String pageToken, core.String playlistId, core.String videoId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (playlistId != null) {
      _queryParams["playlistId"] = [playlistId];
    }
    if (videoId != null) {
      _queryParams["videoId"] = [videoId];
    }

    _url = 'playlistItems';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlaylistItemListResponse.fromJson(data));
  }

  /**
   * Modifies a playlist item. For example, you could update the item's position
   * in the playlist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Note that this method will override the existing values for all of the
   * mutable properties that are contained in any parts that the parameter value
   * specifies. For example, a playlist item can specify a start time and end
   * time, which identify the times portion of the video that should play when
   * users watch the video in the playlist. If your request is updating a
   * playlist item that sets these values, and the request's part parameter
   * value includes the contentDetails part, the playlist item's start and end
   * times will be updated to whatever value the request body specifies. If the
   * request body does not specify values, the existing start and end times will
   * be removed and replaced with the default settings.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [PlaylistItem].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlaylistItem> update(PlaylistItem request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'playlistItems';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlaylistItem.fromJson(data));
  }

}


class PlaylistsResourceApi {
  final commons.ApiRequester _requester;

  PlaylistsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a playlist.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube playlist ID for the playlist
   * that is being deleted. In a playlist resource, the id property specifies
   * the playlist's ID.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'playlists';

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
   * Creates a playlist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * Completes with a [Playlist].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Playlist> insert(Playlist request, core.String part, {core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }

    _url = 'playlists';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Playlist.fromJson(data));
  }

  /**
   * Returns a collection of playlists that match the API request parameters.
   * For example, you can retrieve all playlists that the authenticated user
   * owns, or you can retrieve one or more playlists by their unique IDs.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * playlist resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a
   * playlist resource, the snippet property contains properties like author,
   * title, description, tags, and timeCreated. As such, if you set
   * part=snippet, the API response will contain all of those properties.
   *
   * [channelId] - This value indicates that the API should only return the
   * specified channel's playlists.
   *
   * [hl] - The hl parameter should be used for filter out the properties that
   * are not in the given language. Used for the snippet part.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * playlist ID(s) for the resource(s) that are being retrieved. In a playlist
   * resource, the id property specifies the playlist's YouTube playlist ID.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - Set this parameter's value to true to instruct the API to only
   * return playlists owned by the authenticated user.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [PlaylistListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PlaylistListResponse> list(core.String part, {core.String channelId, core.String hl, core.String id, core.int maxResults, core.bool mine, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'playlists';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PlaylistListResponse.fromJson(data));
  }

  /**
   * Modifies a playlist. For example, you could change a playlist's title,
   * description, or privacy status.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Note that this method will override the existing values for mutable
   * properties that are contained in any parts that the request body specifies.
   * For example, a playlist's description is contained in the snippet part,
   * which must be included in the request body. If the request does not specify
   * a value for the snippet.description property, the playlist's existing
   * description will be deleted.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [Playlist].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Playlist> update(Playlist request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'playlists';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Playlist.fromJson(data));
  }

}


class SearchResourceApi {
  final commons.ApiRequester _requester;

  SearchResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a collection of search results that match the query parameters
   * specified in the API request. By default, a search result set identifies
   * matching video, channel, and playlist resources, but you can also configure
   * queries to only retrieve a specific type of resource.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * search resource properties that the API response will include. Set the
   * parameter value to snippet.
   *
   * [channelId] - The channelId parameter indicates that the API response
   * should only contain resources created by the channel
   *
   * [channelType] - The channelType parameter lets you restrict a search to a
   * particular type of channel.
   * Possible string values are:
   * - "any" : Return all channels.
   * - "show" : Only retrieve shows.
   *
   * [eventType] - The eventType parameter restricts a search to broadcast
   * events. If you specify a value for this parameter, you must also set the
   * type parameter's value to video.
   * Possible string values are:
   * - "completed" : Only include completed broadcasts.
   * - "live" : Only include active broadcasts.
   * - "upcoming" : Only include upcoming broadcasts.
   *
   * [forContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The forContentOwner parameter restricts the search to only retrieve
   * resources owned by the content owner specified by the
   * onBehalfOfContentOwner parameter. The user must be authenticated using a
   * CMS account linked to the specified content owner and
   * onBehalfOfContentOwner must be provided.
   *
   * [forDeveloper] - The forDeveloper parameter restricts the search to only
   * retrieve videos uploaded via the developer's application or website. The
   * API server uses the request's authorization credentials to identify the
   * developer. Therefore, a developer can restrict results to videos uploaded
   * through the developer's own app or website but not to videos uploaded
   * through other apps or sites.
   *
   * [forMine] - The forMine parameter restricts the search to only retrieve
   * videos owned by the authenticated user. If you set this parameter to true,
   * then the type parameter's value must also be set to video.
   *
   * [location] - The location parameter, in conjunction with the locationRadius
   * parameter, defines a circular geographic area and also restricts a search
   * to videos that specify, in their metadata, a geographic location that falls
   * within that area. The parameter value is a string that specifies
   * latitude/longitude coordinates e.g. (37.42307,-122.08427).
   *
   *
   * - The location parameter value identifies the point at the center of the
   * area.
   * - The locationRadius parameter specifies the maximum distance that the
   * location associated with a video can be from that point for the video to
   * still be included in the search results.The API returns an error if your
   * request specifies a value for the location parameter but does not also
   * specify a value for the locationRadius parameter.
   *
   * [locationRadius] - The locationRadius parameter, in conjunction with the
   * location parameter, defines a circular geographic area.
   *
   * The parameter value must be a floating point number followed by a
   * measurement unit. Valid measurement units are m, km, ft, and mi. For
   * example, valid parameter values include 1500m, 5km, 10000ft, and 0.75mi.
   * The API does not support locationRadius parameter values larger than 1000
   * kilometers.
   *
   * Note: See the definition of the location parameter for more information.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [order] - The order parameter specifies the method that will be used to
   * order resources in the API response.
   * Possible string values are:
   * - "date" : Resources are sorted in reverse chronological order based on the
   * date they were created.
   * - "rating" : Resources are sorted from highest to lowest rating.
   * - "relevance" : Resources are sorted based on their relevance to the search
   * query. This is the default value for this parameter.
   * - "title" : Resources are sorted alphabetically by title.
   * - "videoCount" : Channels are sorted in descending order of their number of
   * uploaded videos.
   * - "viewCount" : Resources are sorted from highest to lowest number of
   * views.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * [publishedAfter] - The publishedAfter parameter indicates that the API
   * response should only contain resources created after the specified time.
   * The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).
   *
   * [publishedBefore] - The publishedBefore parameter indicates that the API
   * response should only contain resources created before the specified time.
   * The value is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).
   *
   * [q] - The q parameter specifies the query term to search for.
   *
   * Your request can also use the Boolean NOT (-) and OR (|) operators to
   * exclude videos or to find videos that are associated with one of several
   * search terms. For example, to search for videos matching either "boating"
   * or "sailing", set the q parameter value to boating|sailing. Similarly, to
   * search for videos matching either "boating" or "sailing" but not "fishing",
   * set the q parameter value to boating|sailing -fishing. Note that the pipe
   * character must be URL-escaped when it is sent in your API request. The
   * URL-escaped value for the pipe character is %7C.
   *
   * [regionCode] - The regionCode parameter instructs the API to return search
   * results for the specified country. The parameter value is an ISO 3166-1
   * alpha-2 country code.
   *
   * [relatedToVideoId] - The relatedToVideoId parameter retrieves a list of
   * videos that are related to the video that the parameter value identifies.
   * The parameter value must be set to a YouTube video ID and, if you are using
   * this parameter, the type parameter must be set to video.
   *
   * [relevanceLanguage] - The relevanceLanguage parameter instructs the API to
   * return search results that are most relevant to the specified language. The
   * parameter value is typically an ISO 639-1 two-letter language code.
   * However, you should use the values zh-Hans for simplified Chinese and
   * zh-Hant for traditional Chinese. Please note that results in other
   * languages will still be returned if they are highly relevant to the search
   * query term.
   *
   * [safeSearch] - The safeSearch parameter indicates whether the search
   * results should include restricted content as well as standard content.
   * Possible string values are:
   * - "moderate" : YouTube will filter some content from search results and, at
   * the least, will filter content that is restricted in your locale. Based on
   * their content, search results could be removed from search results or
   * demoted in search results. This is the default parameter value.
   * - "none" : YouTube will not filter the search result set.
   * - "strict" : YouTube will try to exclude all restricted content from the
   * search result set. Based on their content, search results could be removed
   * from search results or demoted in search results.
   *
   * [topicId] - The topicId parameter indicates that the API response should
   * only contain resources associated with the specified topic. The value
   * identifies a Freebase topic ID.
   *
   * [type] - The type parameter restricts a search query to only retrieve a
   * particular type of resource. The value is a comma-separated list of
   * resource types.
   *
   * [videoCaption] - The videoCaption parameter indicates whether the API
   * should filter video search results based on whether they have captions. If
   * you specify a value for this parameter, you must also set the type
   * parameter's value to video.
   * Possible string values are:
   * - "any" : Do not filter results based on caption availability.
   * - "closedCaption" : Only include videos that have captions.
   * - "none" : Only include videos that do not have captions.
   *
   * [videoCategoryId] - The videoCategoryId parameter filters video search
   * results based on their category. If you specify a value for this parameter,
   * you must also set the type parameter's value to video.
   *
   * [videoDefinition] - The videoDefinition parameter lets you restrict a
   * search to only include either high definition (HD) or standard definition
   * (SD) videos. HD videos are available for playback in at least 720p, though
   * higher resolutions, like 1080p, might also be available. If you specify a
   * value for this parameter, you must also set the type parameter's value to
   * video.
   * Possible string values are:
   * - "any" : Return all videos, regardless of their resolution.
   * - "high" : Only retrieve HD videos.
   * - "standard" : Only retrieve videos in standard definition.
   *
   * [videoDimension] - The videoDimension parameter lets you restrict a search
   * to only retrieve 2D or 3D videos. If you specify a value for this
   * parameter, you must also set the type parameter's value to video.
   * Possible string values are:
   * - "2d" : Restrict search results to exclude 3D videos.
   * - "3d" : Restrict search results to only include 3D videos.
   * - "any" : Include both 3D and non-3D videos in returned results. This is
   * the default value.
   *
   * [videoDuration] - The videoDuration parameter filters video search results
   * based on their duration. If you specify a value for this parameter, you
   * must also set the type parameter's value to video.
   * Possible string values are:
   * - "any" : Do not filter video search results based on their duration. This
   * is the default value.
   * - "long" : Only include videos longer than 20 minutes.
   * - "medium" : Only include videos that are between four and 20 minutes long
   * (inclusive).
   * - "short" : Only include videos that are less than four minutes long.
   *
   * [videoEmbeddable] - The videoEmbeddable parameter lets you to restrict a
   * search to only videos that can be embedded into a webpage. If you specify a
   * value for this parameter, you must also set the type parameter's value to
   * video.
   * Possible string values are:
   * - "any" : Return all videos, embeddable or not.
   * - "true" : Only retrieve embeddable videos.
   *
   * [videoLicense] - The videoLicense parameter filters search results to only
   * include videos with a particular license. YouTube lets video uploaders
   * choose to attach either the Creative Commons license or the standard
   * YouTube license to each of their videos. If you specify a value for this
   * parameter, you must also set the type parameter's value to video.
   * Possible string values are:
   * - "any" : Return all videos, regardless of which license they have, that
   * match the query parameters.
   * - "creativeCommon" : Only return videos that have a Creative Commons
   * license. Users can reuse videos with this license in other videos that they
   * create. Learn more.
   * - "youtube" : Only return videos that have the standard YouTube license.
   *
   * [videoSyndicated] - The videoSyndicated parameter lets you to restrict a
   * search to only videos that can be played outside youtube.com. If you
   * specify a value for this parameter, you must also set the type parameter's
   * value to video.
   * Possible string values are:
   * - "any" : Return all videos, syndicated or not.
   * - "true" : Only retrieve syndicated videos.
   *
   * [videoType] - The videoType parameter lets you restrict a search to a
   * particular type of videos. If you specify a value for this parameter, you
   * must also set the type parameter's value to video.
   * Possible string values are:
   * - "any" : Return all videos.
   * - "episode" : Only retrieve episodes of shows.
   * - "movie" : Only retrieve movies.
   *
   * Completes with a [SearchListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchListResponse> list(core.String part, {core.String channelId, core.String channelType, core.String eventType, core.bool forContentOwner, core.bool forDeveloper, core.bool forMine, core.String location, core.String locationRadius, core.int maxResults, core.String onBehalfOfContentOwner, core.String order, core.String pageToken, core.DateTime publishedAfter, core.DateTime publishedBefore, core.String q, core.String regionCode, core.String relatedToVideoId, core.String relevanceLanguage, core.String safeSearch, core.String topicId, core.String type, core.String videoCaption, core.String videoCategoryId, core.String videoDefinition, core.String videoDimension, core.String videoDuration, core.String videoEmbeddable, core.String videoLicense, core.String videoSyndicated, core.String videoType}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (channelType != null) {
      _queryParams["channelType"] = [channelType];
    }
    if (eventType != null) {
      _queryParams["eventType"] = [eventType];
    }
    if (forContentOwner != null) {
      _queryParams["forContentOwner"] = ["${forContentOwner}"];
    }
    if (forDeveloper != null) {
      _queryParams["forDeveloper"] = ["${forDeveloper}"];
    }
    if (forMine != null) {
      _queryParams["forMine"] = ["${forMine}"];
    }
    if (location != null) {
      _queryParams["location"] = [location];
    }
    if (locationRadius != null) {
      _queryParams["locationRadius"] = [locationRadius];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (order != null) {
      _queryParams["order"] = [order];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (publishedAfter != null) {
      _queryParams["publishedAfter"] = [(publishedAfter).toIso8601String()];
    }
    if (publishedBefore != null) {
      _queryParams["publishedBefore"] = [(publishedBefore).toIso8601String()];
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (regionCode != null) {
      _queryParams["regionCode"] = [regionCode];
    }
    if (relatedToVideoId != null) {
      _queryParams["relatedToVideoId"] = [relatedToVideoId];
    }
    if (relevanceLanguage != null) {
      _queryParams["relevanceLanguage"] = [relevanceLanguage];
    }
    if (safeSearch != null) {
      _queryParams["safeSearch"] = [safeSearch];
    }
    if (topicId != null) {
      _queryParams["topicId"] = [topicId];
    }
    if (type != null) {
      _queryParams["type"] = [type];
    }
    if (videoCaption != null) {
      _queryParams["videoCaption"] = [videoCaption];
    }
    if (videoCategoryId != null) {
      _queryParams["videoCategoryId"] = [videoCategoryId];
    }
    if (videoDefinition != null) {
      _queryParams["videoDefinition"] = [videoDefinition];
    }
    if (videoDimension != null) {
      _queryParams["videoDimension"] = [videoDimension];
    }
    if (videoDuration != null) {
      _queryParams["videoDuration"] = [videoDuration];
    }
    if (videoEmbeddable != null) {
      _queryParams["videoEmbeddable"] = [videoEmbeddable];
    }
    if (videoLicense != null) {
      _queryParams["videoLicense"] = [videoLicense];
    }
    if (videoSyndicated != null) {
      _queryParams["videoSyndicated"] = [videoSyndicated];
    }
    if (videoType != null) {
      _queryParams["videoType"] = [videoType];
    }

    _url = 'search';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchListResponse.fromJson(data));
  }

}


class SponsorsResourceApi {
  final commons.ApiRequester _requester;

  SponsorsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists sponsors for a channel.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the sponsor resource parts that the
   * API response will include. Supported values are id and snippet.
   *
   * [filter] - The filter parameter specifies which channel sponsors to return.
   * Possible string values are:
   * - "all" : Return all sponsors, from newest to oldest.
   * - "newest" : Return the most recent sponsors, from newest to oldest.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [SponsorListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SponsorListResponse> list(core.String part, {core.String filter, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'sponsors';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SponsorListResponse.fromJson(data));
  }

}


class SubscriptionsResourceApi {
  final commons.ApiRequester _requester;

  SubscriptionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a subscription.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube subscription ID for the
   * resource that is being deleted. In a subscription resource, the id property
   * specifies the YouTube subscription ID.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];

    _downloadOptions = null;

    _url = 'subscriptions';

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
   * Adds a subscription for the authenticated user's channel.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Completes with a [Subscription].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Subscription> insert(Subscription request, core.String part) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];

    _url = 'subscriptions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Subscription.fromJson(data));
  }

  /**
   * Returns subscription resources that match the API request criteria.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * subscription resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a
   * subscription resource, the snippet property contains other properties, such
   * as a display title for the subscription. If you set part=snippet, the API
   * response will also contain all of those nested properties.
   *
   * [channelId] - The channelId parameter specifies a YouTube channel ID. The
   * API will only return that channel's subscriptions.
   *
   * [forChannelId] - The forChannelId parameter specifies a comma-separated
   * list of channel IDs. The API response will then only contain subscriptions
   * matching those channels.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * subscription ID(s) for the resource(s) that are being retrieved. In a
   * subscription resource, the id property specifies the YouTube subscription
   * ID.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [mine] - Set this parameter's value to true to retrieve a feed of the
   * authenticated user's subscriptions.
   *
   * [myRecentSubscribers] - Set this parameter's value to true to retrieve a
   * feed of the subscribers of the authenticated user in reverse chronological
   * order (newest first).
   *
   * [mySubscribers] - Set this parameter's value to true to retrieve a feed of
   * the subscribers of the authenticated user in no particular order.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [order] - The order parameter specifies the method that will be used to
   * sort resources in the API response.
   * Possible string values are:
   * - "alphabetical" : Sort alphabetically.
   * - "relevance" : Sort by relevance.
   * - "unread" : Sort by order of activity.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [SubscriptionListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SubscriptionListResponse> list(core.String part, {core.String channelId, core.String forChannelId, core.String id, core.int maxResults, core.bool mine, core.bool myRecentSubscribers, core.bool mySubscribers, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.String order, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (channelId != null) {
      _queryParams["channelId"] = [channelId];
    }
    if (forChannelId != null) {
      _queryParams["forChannelId"] = [forChannelId];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (mine != null) {
      _queryParams["mine"] = ["${mine}"];
    }
    if (myRecentSubscribers != null) {
      _queryParams["myRecentSubscribers"] = ["${myRecentSubscribers}"];
    }
    if (mySubscribers != null) {
      _queryParams["mySubscribers"] = ["${mySubscribers}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (order != null) {
      _queryParams["order"] = [order];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'subscriptions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SubscriptionListResponse.fromJson(data));
  }

}


class SuperChatEventsResourceApi {
  final commons.ApiRequester _requester;

  SuperChatEventsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists Super Chat events for a channel.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the superChatEvent resource parts
   * that the API response will include. Supported values are id and snippet.
   *
   * [hl] - The hl parameter instructs the API to retrieve localized resource
   * metadata for a specific application language that the YouTube website
   * supports. The parameter value must be a language code included in the list
   * returned by the i18nLanguages.list method.
   *
   * If localized resource details are available in that language, the
   * resource's snippet.localized object will contain the localized values.
   * However, if localized details are not available, the snippet.localized
   * object will contain resource details in the resource's default language.
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   * Value must be between "0" and "50".
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Completes with a [SuperChatEventListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SuperChatEventListResponse> list(core.String part, {core.String hl, core.int maxResults, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'superChatEvents';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SuperChatEventListResponse.fromJson(data));
  }

}


class ThumbnailsResourceApi {
  final commons.ApiRequester _requester;

  ThumbnailsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Uploads a custom video thumbnail to YouTube and sets it for a video.
   *
   * Request parameters:
   *
   * [videoId] - The videoId parameter specifies a YouTube video ID for which
   * the custom video thumbnail is being provided.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [ThumbnailSetResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ThumbnailSetResponse> set(core.String videoId, {core.String onBehalfOfContentOwner, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (videoId == null) {
      throw new core.ArgumentError("Parameter videoId is required.");
    }
    _queryParams["videoId"] = [videoId];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'thumbnails/set';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/thumbnails/set';
    } else {
      _url = '/upload/youtube/v3/thumbnails/set';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ThumbnailSetResponse.fromJson(data));
  }

}


class VideoAbuseReportReasonsResourceApi {
  final commons.ApiRequester _requester;

  VideoAbuseReportReasonsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of abuse reasons that can be used for reporting abusive
   * videos.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the videoCategory resource parts that
   * the API response will include. Supported values are id and snippet.
   *
   * [hl] - The hl parameter specifies the language that should be used for text
   * values in the API response.
   *
   * Completes with a [VideoAbuseReportReasonListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoAbuseReportReasonListResponse> list(core.String part, {core.String hl}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }

    _url = 'videoAbuseReportReasons';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoAbuseReportReasonListResponse.fromJson(data));
  }

}


class VideoCategoriesResourceApi {
  final commons.ApiRequester _requester;

  VideoCategoriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of categories that can be associated with YouTube videos.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies the videoCategory resource properties
   * that the API response will include. Set the parameter value to snippet.
   *
   * [hl] - The hl parameter specifies the language that should be used for text
   * values in the API response.
   *
   * [id] - The id parameter specifies a comma-separated list of video category
   * IDs for the resources that you are retrieving.
   *
   * [regionCode] - The regionCode parameter instructs the API to return the
   * list of video categories available in the specified country. The parameter
   * value is an ISO 3166-1 alpha-2 country code.
   *
   * Completes with a [VideoCategoryListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoCategoryListResponse> list(core.String part, {core.String hl, core.String id, core.String regionCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (regionCode != null) {
      _queryParams["regionCode"] = [regionCode];
    }

    _url = 'videoCategories';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoCategoryListResponse.fromJson(data));
  }

}


class VideosResourceApi {
  final commons.ApiRequester _requester;

  VideosResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a YouTube video.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube video ID for the resource
   * that is being deleted. In a video resource, the id property specifies the
   * video's ID.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'videos';

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
   * Retrieves the ratings that the authorized user gave to a list of specified
   * videos.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * video ID(s) for the resource(s) for which you are retrieving rating data.
   * In a video resource, the id property specifies the video's ID.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [VideoGetRatingResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoGetRatingResponse> getRating(core.String id, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'videos/getRating';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoGetRatingResponse.fromJson(data));
  }

  /**
   * Uploads a video to YouTube and optionally sets the video's metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Note that not all parts contain properties that can be set when inserting
   * or updating a video. For example, the statistics object encapsulates
   * statistics that YouTube calculates for a video and does not contain values
   * that you can set or modify. If the parameter value specifies a part that
   * does not contain mutable values, that part will still be included in the
   * API response.
   *
   * [autoLevels] - The autoLevels parameter indicates whether YouTube should
   * automatically enhance the video's lighting and color.
   *
   * [notifySubscribers] - The notifySubscribers parameter indicates whether
   * YouTube should send a notification about the new video to users who
   * subscribe to the video's channel. A parameter value of True indicates that
   * subscribers will be notified of newly uploaded videos. However, a channel
   * owner who is uploading many videos might prefer to set the value to False
   * to avoid sending a notification about each new video to the channel's
   * subscribers.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [onBehalfOfContentOwnerChannel] - This parameter can only be used in a
   * properly authorized request. Note: This parameter is intended exclusively
   * for YouTube content partners.
   *
   * The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
   * ID of the channel to which a video is being added. This parameter is
   * required when a request specifies a value for the onBehalfOfContentOwner
   * parameter, and it can only be used in conjunction with that parameter. In
   * addition, the request must be authorized using a CMS account that is linked
   * to the content owner that the onBehalfOfContentOwner parameter specifies.
   * Finally, the channel that the onBehalfOfContentOwnerChannel parameter value
   * specifies must be linked to the content owner that the
   * onBehalfOfContentOwner parameter specifies.
   *
   * This parameter is intended for YouTube content partners that own and manage
   * many different YouTube channels. It allows content owners to authenticate
   * once and perform actions on behalf of the channel specified in the
   * parameter value, without having to provide authentication credentials for
   * each separate channel.
   *
   * [stabilize] - The stabilize parameter indicates whether YouTube should
   * adjust the video to remove shaky camera motions.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [Video].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Video> insert(Video request, core.String part, {core.bool autoLevels, core.bool notifySubscribers, core.String onBehalfOfContentOwner, core.String onBehalfOfContentOwnerChannel, core.bool stabilize, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (autoLevels != null) {
      _queryParams["autoLevels"] = ["${autoLevels}"];
    }
    if (notifySubscribers != null) {
      _queryParams["notifySubscribers"] = ["${notifySubscribers}"];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (onBehalfOfContentOwnerChannel != null) {
      _queryParams["onBehalfOfContentOwnerChannel"] = [onBehalfOfContentOwnerChannel];
    }
    if (stabilize != null) {
      _queryParams["stabilize"] = ["${stabilize}"];
    }

    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;

    if (_uploadMedia == null) {
      _url = 'videos';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/videos';
    } else {
      _url = '/upload/youtube/v3/videos';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Video.fromJson(data));
  }

  /**
   * Returns a list of videos that match the API request parameters.
   *
   * Request parameters:
   *
   * [part] - The part parameter specifies a comma-separated list of one or more
   * video resource properties that the API response will include.
   *
   * If the parameter identifies a property that contains child properties, the
   * child properties will be included in the response. For example, in a video
   * resource, the snippet property contains the channelId, title, description,
   * tags, and categoryId properties. As such, if you set part=snippet, the API
   * response will contain all of those properties.
   *
   * [chart] - The chart parameter identifies the chart that you want to
   * retrieve.
   * Possible string values are:
   * - "mostPopular" : Return the most popular videos for the specified content
   * region and video category.
   *
   * [hl] - The hl parameter instructs the API to retrieve localized resource
   * metadata for a specific application language that the YouTube website
   * supports. The parameter value must be a language code included in the list
   * returned by the i18nLanguages.list method.
   *
   * If localized resource details are available in that language, the
   * resource's snippet.localized object will contain the localized values.
   * However, if localized details are not available, the snippet.localized
   * object will contain resource details in the resource's default language.
   *
   * [id] - The id parameter specifies a comma-separated list of the YouTube
   * video ID(s) for the resource(s) that are being retrieved. In a video
   * resource, the id property specifies the video's ID.
   *
   * [locale] - DEPRECATED
   *
   * [maxHeight] - The maxHeight parameter specifies a maximum height of the
   * embedded player. If maxWidth is provided, maxHeight may not be reached in
   * order to not violate the width request.
   * Value must be between "72" and "8192".
   *
   * [maxResults] - The maxResults parameter specifies the maximum number of
   * items that should be returned in the result set.
   *
   * Note: This parameter is supported for use in conjunction with the myRating
   * and chart parameters, but it is not supported for use in conjunction with
   * the id parameter.
   * Value must be between "1" and "50".
   *
   * [maxWidth] - The maxWidth parameter specifies a maximum width of the
   * embedded player. If maxHeight is provided, maxWidth may not be reached in
   * order to not violate the height request.
   * Value must be between "72" and "8192".
   *
   * [myRating] - Set this parameter's value to like or dislike to instruct the
   * API to only return videos liked or disliked by the authenticated user.
   * Possible string values are:
   * - "dislike" : Returns only videos disliked by the authenticated user.
   * - "like" : Returns only video liked by the authenticated user.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [pageToken] - The pageToken parameter identifies a specific page in the
   * result set that should be returned. In an API response, the nextPageToken
   * and prevPageToken properties identify other pages that could be retrieved.
   *
   * Note: This parameter is supported for use in conjunction with the myRating
   * and chart parameters, but it is not supported for use in conjunction with
   * the id parameter.
   *
   * [regionCode] - The regionCode parameter instructs the API to select a video
   * chart available in the specified region. This parameter can only be used in
   * conjunction with the chart parameter. The parameter value is an ISO 3166-1
   * alpha-2 country code.
   *
   * [videoCategoryId] - The videoCategoryId parameter identifies the video
   * category for which the chart should be retrieved. This parameter can only
   * be used in conjunction with the chart parameter. By default, charts are not
   * restricted to a particular category.
   *
   * Completes with a [VideoListResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VideoListResponse> list(core.String part, {core.String chart, core.String hl, core.String id, core.String locale, core.int maxHeight, core.int maxResults, core.int maxWidth, core.String myRating, core.String onBehalfOfContentOwner, core.String pageToken, core.String regionCode, core.String videoCategoryId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (chart != null) {
      _queryParams["chart"] = [chart];
    }
    if (hl != null) {
      _queryParams["hl"] = [hl];
    }
    if (id != null) {
      _queryParams["id"] = [id];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxHeight != null) {
      _queryParams["maxHeight"] = ["${maxHeight}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (maxWidth != null) {
      _queryParams["maxWidth"] = ["${maxWidth}"];
    }
    if (myRating != null) {
      _queryParams["myRating"] = [myRating];
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (regionCode != null) {
      _queryParams["regionCode"] = [regionCode];
    }
    if (videoCategoryId != null) {
      _queryParams["videoCategoryId"] = [videoCategoryId];
    }

    _url = 'videos';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VideoListResponse.fromJson(data));
  }

  /**
   * Add a like or dislike rating to a video or remove a rating from a video.
   *
   * Request parameters:
   *
   * [id] - The id parameter specifies the YouTube video ID of the video that is
   * being rated or having its rating removed.
   *
   * [rating] - Specifies the rating to record.
   * Possible string values are:
   * - "dislike" : Records that the authenticated user disliked the video.
   * - "like" : Records that the authenticated user liked the video.
   * - "none" : Removes any rating that the authenticated user had previously
   * set for the video.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future rate(core.String id, core.String rating) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    _queryParams["id"] = [id];
    if (rating == null) {
      throw new core.ArgumentError("Parameter rating is required.");
    }
    _queryParams["rating"] = [rating];

    _downloadOptions = null;

    _url = 'videos/rate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Report abuse for a video.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future reportAbuse(VideoAbuseReport request, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'videos/reportAbuse';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Updates a video's metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [part] - The part parameter serves two purposes in this operation. It
   * identifies the properties that the write operation will set as well as the
   * properties that the API response will include.
   *
   * Note that this method will override the existing values for all of the
   * mutable properties that are contained in any parts that the parameter value
   * specifies. For example, a video's privacy setting is contained in the
   * status part. As such, if your request is updating a private video, and the
   * request's part parameter value includes the status part, the video's
   * privacy setting will be updated to whatever value the request body
   * specifies. If the request body does not specify a value, the existing
   * privacy setting will be removed and the video will revert to the default
   * privacy setting.
   *
   * In addition, not all parts contain properties that can be set when
   * inserting or updating a video. For example, the statistics object
   * encapsulates statistics that YouTube calculates for a video and does not
   * contain values that you can set or modify. If the parameter value specifies
   * a part that does not contain mutable values, that part will still be
   * included in the API response.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The actual
   * CMS account that the user authenticates with must be linked to the
   * specified YouTube content owner.
   *
   * Completes with a [Video].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Video> update(Video request, core.String part, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (part == null) {
      throw new core.ArgumentError("Parameter part is required.");
    }
    _queryParams["part"] = [part];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _url = 'videos';

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Video.fromJson(data));
  }

}


class WatermarksResourceApi {
  final commons.ApiRequester _requester;

  WatermarksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Uploads a watermark image to YouTube and sets it for a channel.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [channelId] - The channelId parameter specifies the YouTube channel ID for
   * which the watermark is being provided.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future set(InvideoBranding request, core.String channelId, {core.String onBehalfOfContentOwner, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (channelId == null) {
      throw new core.ArgumentError("Parameter channelId is required.");
    }
    _queryParams["channelId"] = [channelId];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }


    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;
    _downloadOptions = null;

    if (_uploadMedia == null) {
      _url = 'watermarks/set';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/youtube/v3/watermarks/set';
    } else {
      _url = '/upload/youtube/v3/watermarks/set';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Deletes a channel's watermark image.
   *
   * Request parameters:
   *
   * [channelId] - The channelId parameter specifies the YouTube channel ID for
   * which the watermark is being unset.
   *
   * [onBehalfOfContentOwner] - Note: This parameter is intended exclusively for
   * YouTube content partners.
   *
   * The onBehalfOfContentOwner parameter indicates that the request's
   * authorization credentials identify a YouTube CMS user who is acting on
   * behalf of the content owner specified in the parameter value. This
   * parameter is intended for YouTube content partners that own and manage many
   * different YouTube channels. It allows content owners to authenticate once
   * and get access to all their video and channel data, without having to
   * provide authentication credentials for each individual channel. The CMS
   * account that the user authenticates with must be linked to the specified
   * YouTube content owner.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future unset(core.String channelId, {core.String onBehalfOfContentOwner}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (channelId == null) {
      throw new core.ArgumentError("Parameter channelId is required.");
    }
    _queryParams["channelId"] = [channelId];
    if (onBehalfOfContentOwner != null) {
      _queryParams["onBehalfOfContentOwner"] = [onBehalfOfContentOwner];
    }

    _downloadOptions = null;

    _url = 'watermarks/unset';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}



/** Rights management policy for YouTube resources. */
class AccessPolicy {
  /**
   * The value of allowed indicates whether the access to the policy is allowed
   * or denied by default.
   */
  core.bool allowed;
  /**
   * A list of region codes that identify countries where the default policy do
   * not apply.
   */
  core.List<core.String> exception;

  AccessPolicy();

  AccessPolicy.fromJson(core.Map _json) {
    if (_json.containsKey("allowed")) {
      allowed = _json["allowed"];
    }
    if (_json.containsKey("exception")) {
      exception = _json["exception"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowed != null) {
      _json["allowed"] = allowed;
    }
    if (exception != null) {
      _json["exception"] = exception;
    }
    return _json;
  }
}

/**
 * An activity resource contains information about an action that a particular
 * channel, or user, has taken on YouTube.The actions reported in activity feeds
 * include rating a video, sharing a video, marking a video as a favorite,
 * commenting on a video, uploading a video, and so forth. Each activity
 * resource identifies the type of action, the channel associated with the
 * action, and the resource(s) associated with the action, such as the video
 * that was rated or uploaded.
 */
class Activity {
  /**
   * The contentDetails object contains information about the content associated
   * with the activity. For example, if the snippet.type value is videoRated,
   * then the contentDetails object's content identifies the rated video.
   */
  ActivityContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the activity. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#activity".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the activity, including the
   * activity's type and group ID.
   */
  ActivitySnippet snippet;

  Activity();

  Activity.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new ActivityContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new ActivitySnippet.fromJson(_json["snippet"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

/**
 * Details about the content of an activity: the video that was shared, the
 * channel that was subscribed to, etc.
 */
class ActivityContentDetails {
  /**
   * The bulletin object contains details about a channel bulletin post. This
   * object is only present if the snippet.type is bulletin.
   */
  ActivityContentDetailsBulletin bulletin;
  /**
   * The channelItem object contains details about a resource which was added to
   * a channel. This property is only present if the snippet.type is
   * channelItem.
   */
  ActivityContentDetailsChannelItem channelItem;
  /**
   * The comment object contains information about a resource that received a
   * comment. This property is only present if the snippet.type is comment.
   */
  ActivityContentDetailsComment comment;
  /**
   * The favorite object contains information about a video that was marked as a
   * favorite video. This property is only present if the snippet.type is
   * favorite.
   */
  ActivityContentDetailsFavorite favorite;
  /**
   * The like object contains information about a resource that received a
   * positive (like) rating. This property is only present if the snippet.type
   * is like.
   */
  ActivityContentDetailsLike like;
  /**
   * The playlistItem object contains information about a new playlist item.
   * This property is only present if the snippet.type is playlistItem.
   */
  ActivityContentDetailsPlaylistItem playlistItem;
  /**
   * The promotedItem object contains details about a resource which is being
   * promoted. This property is only present if the snippet.type is
   * promotedItem.
   */
  ActivityContentDetailsPromotedItem promotedItem;
  /**
   * The recommendation object contains information about a recommended
   * resource. This property is only present if the snippet.type is
   * recommendation.
   */
  ActivityContentDetailsRecommendation recommendation;
  /**
   * The social object contains details about a social network post. This
   * property is only present if the snippet.type is social.
   */
  ActivityContentDetailsSocial social;
  /**
   * The subscription object contains information about a channel that a user
   * subscribed to. This property is only present if the snippet.type is
   * subscription.
   */
  ActivityContentDetailsSubscription subscription;
  /**
   * The upload object contains information about the uploaded video. This
   * property is only present if the snippet.type is upload.
   */
  ActivityContentDetailsUpload upload;

  ActivityContentDetails();

  ActivityContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("bulletin")) {
      bulletin = new ActivityContentDetailsBulletin.fromJson(_json["bulletin"]);
    }
    if (_json.containsKey("channelItem")) {
      channelItem = new ActivityContentDetailsChannelItem.fromJson(_json["channelItem"]);
    }
    if (_json.containsKey("comment")) {
      comment = new ActivityContentDetailsComment.fromJson(_json["comment"]);
    }
    if (_json.containsKey("favorite")) {
      favorite = new ActivityContentDetailsFavorite.fromJson(_json["favorite"]);
    }
    if (_json.containsKey("like")) {
      like = new ActivityContentDetailsLike.fromJson(_json["like"]);
    }
    if (_json.containsKey("playlistItem")) {
      playlistItem = new ActivityContentDetailsPlaylistItem.fromJson(_json["playlistItem"]);
    }
    if (_json.containsKey("promotedItem")) {
      promotedItem = new ActivityContentDetailsPromotedItem.fromJson(_json["promotedItem"]);
    }
    if (_json.containsKey("recommendation")) {
      recommendation = new ActivityContentDetailsRecommendation.fromJson(_json["recommendation"]);
    }
    if (_json.containsKey("social")) {
      social = new ActivityContentDetailsSocial.fromJson(_json["social"]);
    }
    if (_json.containsKey("subscription")) {
      subscription = new ActivityContentDetailsSubscription.fromJson(_json["subscription"]);
    }
    if (_json.containsKey("upload")) {
      upload = new ActivityContentDetailsUpload.fromJson(_json["upload"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bulletin != null) {
      _json["bulletin"] = (bulletin).toJson();
    }
    if (channelItem != null) {
      _json["channelItem"] = (channelItem).toJson();
    }
    if (comment != null) {
      _json["comment"] = (comment).toJson();
    }
    if (favorite != null) {
      _json["favorite"] = (favorite).toJson();
    }
    if (like != null) {
      _json["like"] = (like).toJson();
    }
    if (playlistItem != null) {
      _json["playlistItem"] = (playlistItem).toJson();
    }
    if (promotedItem != null) {
      _json["promotedItem"] = (promotedItem).toJson();
    }
    if (recommendation != null) {
      _json["recommendation"] = (recommendation).toJson();
    }
    if (social != null) {
      _json["social"] = (social).toJson();
    }
    if (subscription != null) {
      _json["subscription"] = (subscription).toJson();
    }
    if (upload != null) {
      _json["upload"] = (upload).toJson();
    }
    return _json;
  }
}

/** Details about a channel bulletin post. */
class ActivityContentDetailsBulletin {
  /**
   * The resourceId object contains information that identifies the resource
   * associated with a bulletin post.
   */
  ResourceId resourceId;

  ActivityContentDetailsBulletin();

  ActivityContentDetailsBulletin.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Details about a resource which was added to a channel. */
class ActivityContentDetailsChannelItem {
  /**
   * The resourceId object contains information that identifies the resource
   * that was added to the channel.
   */
  ResourceId resourceId;

  ActivityContentDetailsChannelItem();

  ActivityContentDetailsChannelItem.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Information about a resource that received a comment. */
class ActivityContentDetailsComment {
  /**
   * The resourceId object contains information that identifies the resource
   * associated with the comment.
   */
  ResourceId resourceId;

  ActivityContentDetailsComment();

  ActivityContentDetailsComment.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Information about a video that was marked as a favorite video. */
class ActivityContentDetailsFavorite {
  /**
   * The resourceId object contains information that identifies the resource
   * that was marked as a favorite.
   */
  ResourceId resourceId;

  ActivityContentDetailsFavorite();

  ActivityContentDetailsFavorite.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Information about a resource that received a positive (like) rating. */
class ActivityContentDetailsLike {
  /**
   * The resourceId object contains information that identifies the rated
   * resource.
   */
  ResourceId resourceId;

  ActivityContentDetailsLike();

  ActivityContentDetailsLike.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Information about a new playlist item. */
class ActivityContentDetailsPlaylistItem {
  /** The value that YouTube uses to uniquely identify the playlist. */
  core.String playlistId;
  /** ID of the item within the playlist. */
  core.String playlistItemId;
  /**
   * The resourceId object contains information about the resource that was
   * added to the playlist.
   */
  ResourceId resourceId;

  ActivityContentDetailsPlaylistItem();

  ActivityContentDetailsPlaylistItem.fromJson(core.Map _json) {
    if (_json.containsKey("playlistId")) {
      playlistId = _json["playlistId"];
    }
    if (_json.containsKey("playlistItemId")) {
      playlistItemId = _json["playlistItemId"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (playlistId != null) {
      _json["playlistId"] = playlistId;
    }
    if (playlistItemId != null) {
      _json["playlistItemId"] = playlistItemId;
    }
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Details about a resource which is being promoted. */
class ActivityContentDetailsPromotedItem {
  /** The URL the client should fetch to request a promoted item. */
  core.String adTag;
  /**
   * The URL the client should ping to indicate that the user clicked through on
   * this promoted item.
   */
  core.String clickTrackingUrl;
  /**
   * The URL the client should ping to indicate that the user was shown this
   * promoted item.
   */
  core.String creativeViewUrl;
  /**
   * The type of call-to-action, a message to the user indicating action that
   * can be taken.
   * Possible string values are:
   * - "unspecified"
   * - "visitAdvertiserSite"
   */
  core.String ctaType;
  /**
   * The custom call-to-action button text. If specified, it will override the
   * default button text for the cta_type.
   */
  core.String customCtaButtonText;
  /** The text description to accompany the promoted item. */
  core.String descriptionText;
  /**
   * The URL the client should direct the user to, if the user chooses to visit
   * the advertiser's website.
   */
  core.String destinationUrl;
  /**
   * The list of forecasting URLs. The client should ping all of these URLs when
   * a promoted item is not available, to indicate that a promoted item could
   * have been shown.
   */
  core.List<core.String> forecastingUrl;
  /**
   * The list of impression URLs. The client should ping all of these URLs to
   * indicate that the user was shown this promoted item.
   */
  core.List<core.String> impressionUrl;
  /** The ID that YouTube uses to uniquely identify the promoted video. */
  core.String videoId;

  ActivityContentDetailsPromotedItem();

  ActivityContentDetailsPromotedItem.fromJson(core.Map _json) {
    if (_json.containsKey("adTag")) {
      adTag = _json["adTag"];
    }
    if (_json.containsKey("clickTrackingUrl")) {
      clickTrackingUrl = _json["clickTrackingUrl"];
    }
    if (_json.containsKey("creativeViewUrl")) {
      creativeViewUrl = _json["creativeViewUrl"];
    }
    if (_json.containsKey("ctaType")) {
      ctaType = _json["ctaType"];
    }
    if (_json.containsKey("customCtaButtonText")) {
      customCtaButtonText = _json["customCtaButtonText"];
    }
    if (_json.containsKey("descriptionText")) {
      descriptionText = _json["descriptionText"];
    }
    if (_json.containsKey("destinationUrl")) {
      destinationUrl = _json["destinationUrl"];
    }
    if (_json.containsKey("forecastingUrl")) {
      forecastingUrl = _json["forecastingUrl"];
    }
    if (_json.containsKey("impressionUrl")) {
      impressionUrl = _json["impressionUrl"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (adTag != null) {
      _json["adTag"] = adTag;
    }
    if (clickTrackingUrl != null) {
      _json["clickTrackingUrl"] = clickTrackingUrl;
    }
    if (creativeViewUrl != null) {
      _json["creativeViewUrl"] = creativeViewUrl;
    }
    if (ctaType != null) {
      _json["ctaType"] = ctaType;
    }
    if (customCtaButtonText != null) {
      _json["customCtaButtonText"] = customCtaButtonText;
    }
    if (descriptionText != null) {
      _json["descriptionText"] = descriptionText;
    }
    if (destinationUrl != null) {
      _json["destinationUrl"] = destinationUrl;
    }
    if (forecastingUrl != null) {
      _json["forecastingUrl"] = forecastingUrl;
    }
    if (impressionUrl != null) {
      _json["impressionUrl"] = impressionUrl;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/** Information that identifies the recommended resource. */
class ActivityContentDetailsRecommendation {
  /**
   * The reason that the resource is recommended to the user.
   * Possible string values are:
   * - "unspecified"
   * - "videoFavorited"
   * - "videoLiked"
   * - "videoWatched"
   */
  core.String reason;
  /**
   * The resourceId object contains information that identifies the recommended
   * resource.
   */
  ResourceId resourceId;
  /**
   * The seedResourceId object contains information about the resource that
   * caused the recommendation.
   */
  ResourceId seedResourceId;

  ActivityContentDetailsRecommendation();

  ActivityContentDetailsRecommendation.fromJson(core.Map _json) {
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
    if (_json.containsKey("seedResourceId")) {
      seedResourceId = new ResourceId.fromJson(_json["seedResourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    if (seedResourceId != null) {
      _json["seedResourceId"] = (seedResourceId).toJson();
    }
    return _json;
  }
}

/** Details about a social network post. */
class ActivityContentDetailsSocial {
  /** The author of the social network post. */
  core.String author;
  /** An image of the post's author. */
  core.String imageUrl;
  /** The URL of the social network post. */
  core.String referenceUrl;
  /**
   * The resourceId object encapsulates information that identifies the resource
   * associated with a social network post.
   */
  ResourceId resourceId;
  /**
   * The name of the social network.
   * Possible string values are:
   * - "facebook"
   * - "googlePlus"
   * - "twitter"
   * - "unspecified"
   */
  core.String type;

  ActivityContentDetailsSocial();

  ActivityContentDetailsSocial.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("imageUrl")) {
      imageUrl = _json["imageUrl"];
    }
    if (_json.containsKey("referenceUrl")) {
      referenceUrl = _json["referenceUrl"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = author;
    }
    if (imageUrl != null) {
      _json["imageUrl"] = imageUrl;
    }
    if (referenceUrl != null) {
      _json["referenceUrl"] = referenceUrl;
    }
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Information about a channel that a user subscribed to. */
class ActivityContentDetailsSubscription {
  /**
   * The resourceId object contains information that identifies the resource
   * that the user subscribed to.
   */
  ResourceId resourceId;

  ActivityContentDetailsSubscription();

  ActivityContentDetailsSubscription.fromJson(core.Map _json) {
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    return _json;
  }
}

/** Information about the uploaded video. */
class ActivityContentDetailsUpload {
  /** The ID that YouTube uses to uniquely identify the uploaded video. */
  core.String videoId;

  ActivityContentDetailsUpload();

  ActivityContentDetailsUpload.fromJson(core.Map _json) {
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

class ActivityListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of activities, or events, that match the request criteria. */
  core.List<Activity> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#activityListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  ActivityListResponse();

  ActivityListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Activity.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * Basic details about an activity, including title, description, thumbnails,
 * activity type and group.
 */
class ActivitySnippet {
  /**
   * The ID that YouTube uses to uniquely identify the channel associated with
   * the activity.
   */
  core.String channelId;
  /** Channel title for the channel responsible for this activity */
  core.String channelTitle;
  /**
   * The description of the resource primarily associated with the activity.
   */
  core.String description;
  /**
   * The group ID associated with the activity. A group ID identifies user
   * events that are associated with the same user and resource. For example, if
   * a user rates a video and marks the same video as a favorite, the entries
   * for those events would have the same group ID in the user's activity feed.
   * In your user interface, you can avoid repetition by grouping events with
   * the same groupId value.
   */
  core.String groupId;
  /**
   * The date and time that the video was uploaded. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * A map of thumbnail images associated with the resource that is primarily
   * associated with the activity. For each object in the map, the key is the
   * name of the thumbnail image, and the value is an object that contains other
   * information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The title of the resource primarily associated with the activity. */
  core.String title;
  /**
   * The type of activity that the resource describes.
   * Possible string values are:
   * - "bulletin"
   * - "channelItem"
   * - "comment"
   * - "favorite"
   * - "like"
   * - "playlistItem"
   * - "promotedItem"
   * - "recommendation"
   * - "social"
   * - "subscription"
   * - "upload"
   */
  core.String type;

  ActivitySnippet();

  ActivitySnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("groupId")) {
      groupId = _json["groupId"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
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
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (groupId != null) {
      _json["groupId"] = groupId;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
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
 * A caption resource represents a YouTube caption track. A caption track is
 * associated with exactly one YouTube video.
 */
class Caption {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the caption track. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#caption".
   */
  core.String kind;
  /** The snippet object contains basic details about the caption. */
  CaptionSnippet snippet;

  Caption();

  Caption.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new CaptionSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class CaptionListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of captions that match the request criteria. */
  core.List<Caption> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#captionListResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  CaptionListResponse();

  CaptionListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Caption.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Basic details about a caption track, such as its language and name. */
class CaptionSnippet {
  /**
   * The type of audio track associated with the caption track.
   * Possible string values are:
   * - "commentary"
   * - "descriptive"
   * - "primary"
   * - "unknown"
   */
  core.String audioTrackType;
  /**
   * The reason that YouTube failed to process the caption track. This property
   * is only present if the state property's value is failed.
   * Possible string values are:
   * - "processingFailed"
   * - "unknownFormat"
   * - "unsupportedFormat"
   */
  core.String failureReason;
  /**
   * Indicates whether YouTube synchronized the caption track to the audio track
   * in the video. The value will be true if a sync was explicitly requested
   * when the caption track was uploaded. For example, when calling the
   * captions.insert or captions.update methods, you can set the sync parameter
   * to true to instruct YouTube to sync the uploaded track to the video. If the
   * value is false, YouTube uses the time codes in the uploaded caption track
   * to determine when to display captions.
   */
  core.bool isAutoSynced;
  /**
   * Indicates whether the track contains closed captions for the deaf and hard
   * of hearing. The default value is false.
   */
  core.bool isCC;
  /**
   * Indicates whether the caption track is a draft. If the value is true, then
   * the track is not publicly visible. The default value is false.
   */
  core.bool isDraft;
  /**
   * Indicates whether caption track is formatted for "easy reader," meaning it
   * is at a third-grade level for language learners. The default value is
   * false.
   */
  core.bool isEasyReader;
  /**
   * Indicates whether the caption track uses large text for the
   * vision-impaired. The default value is false.
   */
  core.bool isLarge;
  /**
   * The language of the caption track. The property value is a BCP-47 language
   * tag.
   */
  core.String language;
  /**
   * The date and time when the caption track was last updated. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime lastUpdated;
  /**
   * The name of the caption track. The name is intended to be visible to the
   * user as an option during playback.
   */
  core.String name;
  /**
   * The caption track's status.
   * Possible string values are:
   * - "failed"
   * - "serving"
   * - "syncing"
   */
  core.String status;
  /**
   * The caption track's type.
   * Possible string values are:
   * - "ASR"
   * - "forced"
   * - "standard"
   */
  core.String trackKind;
  /**
   * The ID that YouTube uses to uniquely identify the video associated with the
   * caption track.
   */
  core.String videoId;

  CaptionSnippet();

  CaptionSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("audioTrackType")) {
      audioTrackType = _json["audioTrackType"];
    }
    if (_json.containsKey("failureReason")) {
      failureReason = _json["failureReason"];
    }
    if (_json.containsKey("isAutoSynced")) {
      isAutoSynced = _json["isAutoSynced"];
    }
    if (_json.containsKey("isCC")) {
      isCC = _json["isCC"];
    }
    if (_json.containsKey("isDraft")) {
      isDraft = _json["isDraft"];
    }
    if (_json.containsKey("isEasyReader")) {
      isEasyReader = _json["isEasyReader"];
    }
    if (_json.containsKey("isLarge")) {
      isLarge = _json["isLarge"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("lastUpdated")) {
      lastUpdated = core.DateTime.parse(_json["lastUpdated"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("trackKind")) {
      trackKind = _json["trackKind"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audioTrackType != null) {
      _json["audioTrackType"] = audioTrackType;
    }
    if (failureReason != null) {
      _json["failureReason"] = failureReason;
    }
    if (isAutoSynced != null) {
      _json["isAutoSynced"] = isAutoSynced;
    }
    if (isCC != null) {
      _json["isCC"] = isCC;
    }
    if (isDraft != null) {
      _json["isDraft"] = isDraft;
    }
    if (isEasyReader != null) {
      _json["isEasyReader"] = isEasyReader;
    }
    if (isLarge != null) {
      _json["isLarge"] = isLarge;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (lastUpdated != null) {
      _json["lastUpdated"] = (lastUpdated).toIso8601String();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (trackKind != null) {
      _json["trackKind"] = trackKind;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/** Brief description of the live stream cdn settings. */
class CdnSettings {
  /** The format of the video stream that you are sending to Youtube. */
  core.String format;
  /**
   * The frame rate of the inbound video data.
   * Possible string values are:
   * - "30fps"
   * - "60fps"
   */
  core.String frameRate;
  /**
   * The ingestionInfo object contains information that YouTube provides that
   * you need to transmit your RTMP or HTTP stream to YouTube.
   */
  IngestionInfo ingestionInfo;
  /**
   * The method or protocol used to transmit the video stream.
   * Possible string values are:
   * - "dash"
   * - "rtmp"
   */
  core.String ingestionType;
  /**
   * The resolution of the inbound video data.
   * Possible string values are:
   * - "1080p"
   * - "1440p"
   * - "2160p"
   * - "240p"
   * - "360p"
   * - "480p"
   * - "720p"
   */
  core.String resolution;

  CdnSettings();

  CdnSettings.fromJson(core.Map _json) {
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("frameRate")) {
      frameRate = _json["frameRate"];
    }
    if (_json.containsKey("ingestionInfo")) {
      ingestionInfo = new IngestionInfo.fromJson(_json["ingestionInfo"]);
    }
    if (_json.containsKey("ingestionType")) {
      ingestionType = _json["ingestionType"];
    }
    if (_json.containsKey("resolution")) {
      resolution = _json["resolution"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (format != null) {
      _json["format"] = format;
    }
    if (frameRate != null) {
      _json["frameRate"] = frameRate;
    }
    if (ingestionInfo != null) {
      _json["ingestionInfo"] = (ingestionInfo).toJson();
    }
    if (ingestionType != null) {
      _json["ingestionType"] = ingestionType;
    }
    if (resolution != null) {
      _json["resolution"] = resolution;
    }
    return _json;
  }
}

/** A channel resource contains information about a YouTube channel. */
class Channel {
  /**
   * The auditionDetails object encapsulates channel data that is relevant for
   * YouTube Partners during the audition process.
   */
  ChannelAuditDetails auditDetails;
  /**
   * The brandingSettings object encapsulates information about the branding of
   * the channel.
   */
  ChannelBrandingSettings brandingSettings;
  /**
   * The contentDetails object encapsulates information about the channel's
   * content.
   */
  ChannelContentDetails contentDetails;
  /**
   * The contentOwnerDetails object encapsulates channel data that is relevant
   * for YouTube Partners linked with the channel.
   */
  ChannelContentOwnerDetails contentOwnerDetails;
  /**
   * The conversionPings object encapsulates information about conversion pings
   * that need to be respected by the channel.
   */
  ChannelConversionPings conversionPings;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the channel. */
  core.String id;
  /**
   * The invideoPromotion object encapsulates information about promotion
   * campaign associated with the channel.
   */
  InvideoPromotion invideoPromotion;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#channel".
   */
  core.String kind;
  /** Localizations for different languages */
  core.Map<core.String, ChannelLocalization> localizations;
  /**
   * The snippet object contains basic details about the channel, such as its
   * title, description, and thumbnail images.
   */
  ChannelSnippet snippet;
  /** The statistics object encapsulates statistics for the channel. */
  ChannelStatistics statistics;
  /**
   * The status object encapsulates information about the privacy status of the
   * channel.
   */
  ChannelStatus status;
  /**
   * The topicDetails object encapsulates information about Freebase topics
   * associated with the channel.
   */
  ChannelTopicDetails topicDetails;

  Channel();

  Channel.fromJson(core.Map _json) {
    if (_json.containsKey("auditDetails")) {
      auditDetails = new ChannelAuditDetails.fromJson(_json["auditDetails"]);
    }
    if (_json.containsKey("brandingSettings")) {
      brandingSettings = new ChannelBrandingSettings.fromJson(_json["brandingSettings"]);
    }
    if (_json.containsKey("contentDetails")) {
      contentDetails = new ChannelContentDetails.fromJson(_json["contentDetails"]);
    }
    if (_json.containsKey("contentOwnerDetails")) {
      contentOwnerDetails = new ChannelContentOwnerDetails.fromJson(_json["contentOwnerDetails"]);
    }
    if (_json.containsKey("conversionPings")) {
      conversionPings = new ChannelConversionPings.fromJson(_json["conversionPings"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("invideoPromotion")) {
      invideoPromotion = new InvideoPromotion.fromJson(_json["invideoPromotion"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("localizations")) {
      localizations = commons.mapMap(_json["localizations"], (item) => new ChannelLocalization.fromJson(item));
    }
    if (_json.containsKey("snippet")) {
      snippet = new ChannelSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("statistics")) {
      statistics = new ChannelStatistics.fromJson(_json["statistics"]);
    }
    if (_json.containsKey("status")) {
      status = new ChannelStatus.fromJson(_json["status"]);
    }
    if (_json.containsKey("topicDetails")) {
      topicDetails = new ChannelTopicDetails.fromJson(_json["topicDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (auditDetails != null) {
      _json["auditDetails"] = (auditDetails).toJson();
    }
    if (brandingSettings != null) {
      _json["brandingSettings"] = (brandingSettings).toJson();
    }
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
    }
    if (contentOwnerDetails != null) {
      _json["contentOwnerDetails"] = (contentOwnerDetails).toJson();
    }
    if (conversionPings != null) {
      _json["conversionPings"] = (conversionPings).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (invideoPromotion != null) {
      _json["invideoPromotion"] = (invideoPromotion).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (localizations != null) {
      _json["localizations"] = commons.mapMap(localizations, (item) => (item).toJson());
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (topicDetails != null) {
      _json["topicDetails"] = (topicDetails).toJson();
    }
    return _json;
  }
}

/**
 * The auditDetails object encapsulates channel data that is relevant for
 * YouTube Partners during the audit process.
 */
class ChannelAuditDetails {
  /** Whether or not the channel respects the community guidelines. */
  core.bool communityGuidelinesGoodStanding;
  /** Whether or not the channel has any unresolved claims. */
  core.bool contentIdClaimsGoodStanding;
  /** Whether or not the channel has any copyright strikes. */
  core.bool copyrightStrikesGoodStanding;
  /**
   * Describes the general state of the channel. This field will always show if
   * there are any issues whatsoever with the channel. Currently this field
   * represents the result of the logical and operation over the community
   * guidelines good standing, the copyright strikes good standing and the
   * content ID claims good standing, but this may change in the future.
   */
  core.bool overallGoodStanding;

  ChannelAuditDetails();

  ChannelAuditDetails.fromJson(core.Map _json) {
    if (_json.containsKey("communityGuidelinesGoodStanding")) {
      communityGuidelinesGoodStanding = _json["communityGuidelinesGoodStanding"];
    }
    if (_json.containsKey("contentIdClaimsGoodStanding")) {
      contentIdClaimsGoodStanding = _json["contentIdClaimsGoodStanding"];
    }
    if (_json.containsKey("copyrightStrikesGoodStanding")) {
      copyrightStrikesGoodStanding = _json["copyrightStrikesGoodStanding"];
    }
    if (_json.containsKey("overallGoodStanding")) {
      overallGoodStanding = _json["overallGoodStanding"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (communityGuidelinesGoodStanding != null) {
      _json["communityGuidelinesGoodStanding"] = communityGuidelinesGoodStanding;
    }
    if (contentIdClaimsGoodStanding != null) {
      _json["contentIdClaimsGoodStanding"] = contentIdClaimsGoodStanding;
    }
    if (copyrightStrikesGoodStanding != null) {
      _json["copyrightStrikesGoodStanding"] = copyrightStrikesGoodStanding;
    }
    if (overallGoodStanding != null) {
      _json["overallGoodStanding"] = overallGoodStanding;
    }
    return _json;
  }
}

/**
 * A channel banner returned as the response to a channel_banner.insert call.
 */
class ChannelBannerResource {
  /** Etag of this resource. */
  core.String etag;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#channelBannerResource".
   */
  core.String kind;
  /** The URL of this banner image. */
  core.String url;

  ChannelBannerResource();

  ChannelBannerResource.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Branding properties of a YouTube channel. */
class ChannelBrandingSettings {
  /** Branding properties for the channel view. */
  ChannelSettings channel;
  /** Additional experimental branding properties. */
  core.List<PropertyValue> hints;
  /** Branding properties for branding images. */
  ImageSettings image;
  /** Branding properties for the watch page. */
  WatchSettings watch;

  ChannelBrandingSettings();

  ChannelBrandingSettings.fromJson(core.Map _json) {
    if (_json.containsKey("channel")) {
      channel = new ChannelSettings.fromJson(_json["channel"]);
    }
    if (_json.containsKey("hints")) {
      hints = _json["hints"].map((value) => new PropertyValue.fromJson(value)).toList();
    }
    if (_json.containsKey("image")) {
      image = new ImageSettings.fromJson(_json["image"]);
    }
    if (_json.containsKey("watch")) {
      watch = new WatchSettings.fromJson(_json["watch"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channel != null) {
      _json["channel"] = (channel).toJson();
    }
    if (hints != null) {
      _json["hints"] = hints.map((value) => (value).toJson()).toList();
    }
    if (image != null) {
      _json["image"] = (image).toJson();
    }
    if (watch != null) {
      _json["watch"] = (watch).toJson();
    }
    return _json;
  }
}

class ChannelContentDetailsRelatedPlaylists {
  /**
   * The ID of the playlist that contains the channel"s favorite videos. Use the
   * playlistItems.insert and  playlistItems.delete to add or remove items from
   * that list.
   */
  core.String favorites;
  /**
   * The ID of the playlist that contains the channel"s liked videos. Use the
   * playlistItems.insert and  playlistItems.delete to add or remove items from
   * that list.
   */
  core.String likes;
  /**
   * The ID of the playlist that contains the channel"s uploaded videos. Use the
   * videos.insert method to upload new videos and the videos.delete method to
   * delete previously uploaded videos.
   */
  core.String uploads;
  /**
   * The ID of the playlist that contains the channel"s watch history. Use the
   * playlistItems.insert and  playlistItems.delete to add or remove items from
   * that list.
   */
  core.String watchHistory;
  /**
   * The ID of the playlist that contains the channel"s watch later playlist.
   * Use the playlistItems.insert and  playlistItems.delete to add or remove
   * items from that list.
   */
  core.String watchLater;

  ChannelContentDetailsRelatedPlaylists();

  ChannelContentDetailsRelatedPlaylists.fromJson(core.Map _json) {
    if (_json.containsKey("favorites")) {
      favorites = _json["favorites"];
    }
    if (_json.containsKey("likes")) {
      likes = _json["likes"];
    }
    if (_json.containsKey("uploads")) {
      uploads = _json["uploads"];
    }
    if (_json.containsKey("watchHistory")) {
      watchHistory = _json["watchHistory"];
    }
    if (_json.containsKey("watchLater")) {
      watchLater = _json["watchLater"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (favorites != null) {
      _json["favorites"] = favorites;
    }
    if (likes != null) {
      _json["likes"] = likes;
    }
    if (uploads != null) {
      _json["uploads"] = uploads;
    }
    if (watchHistory != null) {
      _json["watchHistory"] = watchHistory;
    }
    if (watchLater != null) {
      _json["watchLater"] = watchLater;
    }
    return _json;
  }
}

/** Details about the content of a channel. */
class ChannelContentDetails {
  ChannelContentDetailsRelatedPlaylists relatedPlaylists;

  ChannelContentDetails();

  ChannelContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("relatedPlaylists")) {
      relatedPlaylists = new ChannelContentDetailsRelatedPlaylists.fromJson(_json["relatedPlaylists"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (relatedPlaylists != null) {
      _json["relatedPlaylists"] = (relatedPlaylists).toJson();
    }
    return _json;
  }
}

/**
 * The contentOwnerDetails object encapsulates channel data that is relevant for
 * YouTube Partners linked with the channel.
 */
class ChannelContentOwnerDetails {
  /** The ID of the content owner linked to the channel. */
  core.String contentOwner;
  /**
   * The date and time of when the channel was linked to the content owner. The
   * value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime timeLinked;

  ChannelContentOwnerDetails();

  ChannelContentOwnerDetails.fromJson(core.Map _json) {
    if (_json.containsKey("contentOwner")) {
      contentOwner = _json["contentOwner"];
    }
    if (_json.containsKey("timeLinked")) {
      timeLinked = core.DateTime.parse(_json["timeLinked"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentOwner != null) {
      _json["contentOwner"] = contentOwner;
    }
    if (timeLinked != null) {
      _json["timeLinked"] = (timeLinked).toIso8601String();
    }
    return _json;
  }
}

/**
 * Pings that the app shall fire (authenticated by biscotti cookie). Each ping
 * has a context, in which the app must fire the ping, and a url identifying the
 * ping.
 */
class ChannelConversionPing {
  /**
   * Defines the context of the ping.
   * Possible string values are:
   * - "cview"
   * - "subscribe"
   * - "unsubscribe"
   */
  core.String context;
  /**
   * The url (without the schema) that the player shall send the ping to. It's
   * at caller's descretion to decide which schema to use (http vs https)
   * Example of a returned url: //googleads.g.doubleclick.net/pagead/
   * viewthroughconversion/962985656/?data=path%3DtHe_path%3Btype%3D
   * cview%3Butuid%3DGISQtTNGYqaYl4sKxoVvKA&labe=default The caller must append
   * biscotti authentication (ms param in case of mobile, for example) to this
   * ping.
   */
  core.String conversionUrl;

  ChannelConversionPing();

  ChannelConversionPing.fromJson(core.Map _json) {
    if (_json.containsKey("context")) {
      context = _json["context"];
    }
    if (_json.containsKey("conversionUrl")) {
      conversionUrl = _json["conversionUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (context != null) {
      _json["context"] = context;
    }
    if (conversionUrl != null) {
      _json["conversionUrl"] = conversionUrl;
    }
    return _json;
  }
}

/**
 * The conversionPings object encapsulates information about conversion pings
 * that need to be respected by the channel.
 */
class ChannelConversionPings {
  /**
   * Pings that the app shall fire (authenticated by biscotti cookie). Each ping
   * has a context, in which the app must fire the ping, and a url identifying
   * the ping.
   */
  core.List<ChannelConversionPing> pings;

  ChannelConversionPings();

  ChannelConversionPings.fromJson(core.Map _json) {
    if (_json.containsKey("pings")) {
      pings = _json["pings"].map((value) => new ChannelConversionPing.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pings != null) {
      _json["pings"] = pings.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ChannelListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of channels that match the request criteria. */
  core.List<Channel> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#channelListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  ChannelListResponse();

  ChannelListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Channel.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Channel localization setting */
class ChannelLocalization {
  /** The localized strings for channel's description. */
  core.String description;
  /** The localized strings for channel's title. */
  core.String title;

  ChannelLocalization();

  ChannelLocalization.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class ChannelProfileDetails {
  /** The YouTube channel ID. */
  core.String channelId;
  /** The channel's URL. */
  core.String channelUrl;
  /** The channel's display name. */
  core.String displayName;
  /** The channels's avatar URL. */
  core.String profileImageUrl;

  ChannelProfileDetails();

  ChannelProfileDetails.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelUrl")) {
      channelUrl = _json["channelUrl"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("profileImageUrl")) {
      profileImageUrl = _json["profileImageUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelUrl != null) {
      _json["channelUrl"] = channelUrl;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (profileImageUrl != null) {
      _json["profileImageUrl"] = profileImageUrl;
    }
    return _json;
  }
}

class ChannelSection {
  /**
   * The contentDetails object contains details about the channel section
   * content, such as a list of playlists or channels featured in the section.
   */
  ChannelSectionContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the channel section. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#channelSection".
   */
  core.String kind;
  /** Localizations for different languages */
  core.Map<core.String, ChannelSectionLocalization> localizations;
  /**
   * The snippet object contains basic details about the channel section, such
   * as its type, style and title.
   */
  ChannelSectionSnippet snippet;
  /**
   * The targeting object contains basic targeting settings about the channel
   * section.
   */
  ChannelSectionTargeting targeting;

  ChannelSection();

  ChannelSection.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new ChannelSectionContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("localizations")) {
      localizations = commons.mapMap(_json["localizations"], (item) => new ChannelSectionLocalization.fromJson(item));
    }
    if (_json.containsKey("snippet")) {
      snippet = new ChannelSectionSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("targeting")) {
      targeting = new ChannelSectionTargeting.fromJson(_json["targeting"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (localizations != null) {
      _json["localizations"] = commons.mapMap(localizations, (item) => (item).toJson());
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (targeting != null) {
      _json["targeting"] = (targeting).toJson();
    }
    return _json;
  }
}

/** Details about a channelsection, including playlists and channels. */
class ChannelSectionContentDetails {
  /** The channel ids for type multiple_channels. */
  core.List<core.String> channels;
  /**
   * The playlist ids for type single_playlist and multiple_playlists. For
   * singlePlaylist, only one playlistId is allowed.
   */
  core.List<core.String> playlists;

  ChannelSectionContentDetails();

  ChannelSectionContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("channels")) {
      channels = _json["channels"];
    }
    if (_json.containsKey("playlists")) {
      playlists = _json["playlists"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channels != null) {
      _json["channels"] = channels;
    }
    if (playlists != null) {
      _json["playlists"] = playlists;
    }
    return _json;
  }
}

class ChannelSectionListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of ChannelSections that match the request criteria. */
  core.List<ChannelSection> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#channelSectionListResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  ChannelSectionListResponse();

  ChannelSectionListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ChannelSection.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** ChannelSection localization setting */
class ChannelSectionLocalization {
  /** The localized strings for channel section's title. */
  core.String title;

  ChannelSectionLocalization();

  ChannelSectionLocalization.fromJson(core.Map _json) {
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

/**
 * Basic details about a channel section, including title, style and position.
 */
class ChannelSectionSnippet {
  /**
   * The ID that YouTube uses to uniquely identify the channel that published
   * the channel section.
   */
  core.String channelId;
  /** The language of the channel section's default title and description. */
  core.String defaultLanguage;
  /** Localized title, read-only. */
  ChannelSectionLocalization localized;
  /** The position of the channel section in the channel. */
  core.int position;
  /**
   * The style of the channel section.
   * Possible string values are:
   * - "channelsectionStyleUndefined"
   * - "horizontalRow"
   * - "verticalList"
   */
  core.String style;
  /**
   * The channel section's title for multiple_playlists and multiple_channels.
   */
  core.String title;
  /**
   * The type of the channel section.
   * Possible string values are:
   * - "allPlaylists"
   * - "channelsectionTypeUndefined"
   * - "completedEvents"
   * - "likedPlaylists"
   * - "likes"
   * - "liveEvents"
   * - "multipleChannels"
   * - "multiplePlaylists"
   * - "popularUploads"
   * - "postedPlaylists"
   * - "postedVideos"
   * - "recentActivity"
   * - "recentPosts"
   * - "recentUploads"
   * - "singlePlaylist"
   * - "subscriptions"
   * - "upcomingEvents"
   */
  core.String type;

  ChannelSectionSnippet();

  ChannelSectionSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("localized")) {
      localized = new ChannelSectionLocalization.fromJson(_json["localized"]);
    }
    if (_json.containsKey("position")) {
      position = _json["position"];
    }
    if (_json.containsKey("style")) {
      style = _json["style"];
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
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (localized != null) {
      _json["localized"] = (localized).toJson();
    }
    if (position != null) {
      _json["position"] = position;
    }
    if (style != null) {
      _json["style"] = style;
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

/** ChannelSection targeting setting. */
class ChannelSectionTargeting {
  /** The country the channel section is targeting. */
  core.List<core.String> countries;
  /** The language the channel section is targeting. */
  core.List<core.String> languages;
  /** The region the channel section is targeting. */
  core.List<core.String> regions;

  ChannelSectionTargeting();

  ChannelSectionTargeting.fromJson(core.Map _json) {
    if (_json.containsKey("countries")) {
      countries = _json["countries"];
    }
    if (_json.containsKey("languages")) {
      languages = _json["languages"];
    }
    if (_json.containsKey("regions")) {
      regions = _json["regions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (countries != null) {
      _json["countries"] = countries;
    }
    if (languages != null) {
      _json["languages"] = languages;
    }
    if (regions != null) {
      _json["regions"] = regions;
    }
    return _json;
  }
}

/** Branding properties for the channel view. */
class ChannelSettings {
  /** The country of the channel. */
  core.String country;
  core.String defaultLanguage;
  /** Which content tab users should see when viewing the channel. */
  core.String defaultTab;
  /** Specifies the channel description. */
  core.String description;
  /** Title for the featured channels tab. */
  core.String featuredChannelsTitle;
  /** The list of featured channels. */
  core.List<core.String> featuredChannelsUrls;
  /** Lists keywords associated with the channel, comma-separated. */
  core.String keywords;
  /**
   * Whether user-submitted comments left on the channel page need to be
   * approved by the channel owner to be publicly visible.
   */
  core.bool moderateComments;
  /** A prominent color that can be rendered on this channel page. */
  core.String profileColor;
  /** Whether the tab to browse the videos should be displayed. */
  core.bool showBrowseView;
  /** Whether related channels should be proposed. */
  core.bool showRelatedChannels;
  /** Specifies the channel title. */
  core.String title;
  /**
   * The ID for a Google Analytics account to track and measure traffic to the
   * channels.
   */
  core.String trackingAnalyticsAccountId;
  /** The trailer of the channel, for users that are not subscribers. */
  core.String unsubscribedTrailer;

  ChannelSettings();

  ChannelSettings.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("defaultTab")) {
      defaultTab = _json["defaultTab"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("featuredChannelsTitle")) {
      featuredChannelsTitle = _json["featuredChannelsTitle"];
    }
    if (_json.containsKey("featuredChannelsUrls")) {
      featuredChannelsUrls = _json["featuredChannelsUrls"];
    }
    if (_json.containsKey("keywords")) {
      keywords = _json["keywords"];
    }
    if (_json.containsKey("moderateComments")) {
      moderateComments = _json["moderateComments"];
    }
    if (_json.containsKey("profileColor")) {
      profileColor = _json["profileColor"];
    }
    if (_json.containsKey("showBrowseView")) {
      showBrowseView = _json["showBrowseView"];
    }
    if (_json.containsKey("showRelatedChannels")) {
      showRelatedChannels = _json["showRelatedChannels"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("trackingAnalyticsAccountId")) {
      trackingAnalyticsAccountId = _json["trackingAnalyticsAccountId"];
    }
    if (_json.containsKey("unsubscribedTrailer")) {
      unsubscribedTrailer = _json["unsubscribedTrailer"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (defaultTab != null) {
      _json["defaultTab"] = defaultTab;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (featuredChannelsTitle != null) {
      _json["featuredChannelsTitle"] = featuredChannelsTitle;
    }
    if (featuredChannelsUrls != null) {
      _json["featuredChannelsUrls"] = featuredChannelsUrls;
    }
    if (keywords != null) {
      _json["keywords"] = keywords;
    }
    if (moderateComments != null) {
      _json["moderateComments"] = moderateComments;
    }
    if (profileColor != null) {
      _json["profileColor"] = profileColor;
    }
    if (showBrowseView != null) {
      _json["showBrowseView"] = showBrowseView;
    }
    if (showRelatedChannels != null) {
      _json["showRelatedChannels"] = showRelatedChannels;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (trackingAnalyticsAccountId != null) {
      _json["trackingAnalyticsAccountId"] = trackingAnalyticsAccountId;
    }
    if (unsubscribedTrailer != null) {
      _json["unsubscribedTrailer"] = unsubscribedTrailer;
    }
    return _json;
  }
}

/**
 * Basic details about a channel, including title, description and thumbnails.
 * Next available id: 15.
 */
class ChannelSnippet {
  /** The country of the channel. */
  core.String country;
  /** The custom url of the channel. */
  core.String customUrl;
  /** The language of the channel's default title and description. */
  core.String defaultLanguage;
  /** The description of the channel. */
  core.String description;
  /** Localized title and description, read-only. */
  ChannelLocalization localized;
  /**
   * The date and time that the channel was created. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * A map of thumbnail images associated with the channel. For each object in
   * the map, the key is the name of the thumbnail image, and the value is an
   * object that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The channel's title. */
  core.String title;

  ChannelSnippet();

  ChannelSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("customUrl")) {
      customUrl = _json["customUrl"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("localized")) {
      localized = new ChannelLocalization.fromJson(_json["localized"]);
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (customUrl != null) {
      _json["customUrl"] = customUrl;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (localized != null) {
      _json["localized"] = (localized).toJson();
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * Statistics about a channel: number of subscribers, number of videos in the
 * channel, etc.
 */
class ChannelStatistics {
  /** The number of comments for the channel. */
  core.String commentCount;
  /** Whether or not the number of subscribers is shown for this user. */
  core.bool hiddenSubscriberCount;
  /** The number of subscribers that the channel has. */
  core.String subscriberCount;
  /** The number of videos uploaded to the channel. */
  core.String videoCount;
  /** The number of times the channel has been viewed. */
  core.String viewCount;

  ChannelStatistics();

  ChannelStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("commentCount")) {
      commentCount = _json["commentCount"];
    }
    if (_json.containsKey("hiddenSubscriberCount")) {
      hiddenSubscriberCount = _json["hiddenSubscriberCount"];
    }
    if (_json.containsKey("subscriberCount")) {
      subscriberCount = _json["subscriberCount"];
    }
    if (_json.containsKey("videoCount")) {
      videoCount = _json["videoCount"];
    }
    if (_json.containsKey("viewCount")) {
      viewCount = _json["viewCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commentCount != null) {
      _json["commentCount"] = commentCount;
    }
    if (hiddenSubscriberCount != null) {
      _json["hiddenSubscriberCount"] = hiddenSubscriberCount;
    }
    if (subscriberCount != null) {
      _json["subscriberCount"] = subscriberCount;
    }
    if (videoCount != null) {
      _json["videoCount"] = videoCount;
    }
    if (viewCount != null) {
      _json["viewCount"] = viewCount;
    }
    return _json;
  }
}

/** JSON template for the status part of a channel. */
class ChannelStatus {
  /**
   * If true, then the user is linked to either a YouTube username or G+
   * account. Otherwise, the user doesn't have a public YouTube identity.
   */
  core.bool isLinked;
  /**
   * The long uploads status of this channel. See
   * Possible string values are:
   * - "allowed"
   * - "disallowed"
   * - "eligible"
   * - "longUploadsUnspecified"
   */
  core.String longUploadsStatus;
  /**
   * Privacy status of the channel.
   * Possible string values are:
   * - "private"
   * - "public"
   * - "unlisted"
   */
  core.String privacyStatus;

  ChannelStatus();

  ChannelStatus.fromJson(core.Map _json) {
    if (_json.containsKey("isLinked")) {
      isLinked = _json["isLinked"];
    }
    if (_json.containsKey("longUploadsStatus")) {
      longUploadsStatus = _json["longUploadsStatus"];
    }
    if (_json.containsKey("privacyStatus")) {
      privacyStatus = _json["privacyStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (isLinked != null) {
      _json["isLinked"] = isLinked;
    }
    if (longUploadsStatus != null) {
      _json["longUploadsStatus"] = longUploadsStatus;
    }
    if (privacyStatus != null) {
      _json["privacyStatus"] = privacyStatus;
    }
    return _json;
  }
}

/** Freebase topic information related to the channel. */
class ChannelTopicDetails {
  /** A list of Wikipedia URLs that describe the channel's content. */
  core.List<core.String> topicCategories;
  /**
   * A list of Freebase topic IDs associated with the channel. You can retrieve
   * information about each topic using the Freebase Topic API.
   */
  core.List<core.String> topicIds;

  ChannelTopicDetails();

  ChannelTopicDetails.fromJson(core.Map _json) {
    if (_json.containsKey("topicCategories")) {
      topicCategories = _json["topicCategories"];
    }
    if (_json.containsKey("topicIds")) {
      topicIds = _json["topicIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (topicCategories != null) {
      _json["topicCategories"] = topicCategories;
    }
    if (topicIds != null) {
      _json["topicIds"] = topicIds;
    }
    return _json;
  }
}

/** A comment represents a single YouTube comment. */
class Comment {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the comment. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#comment".
   */
  core.String kind;
  /** The snippet object contains basic details about the comment. */
  CommentSnippet snippet;

  Comment();

  Comment.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new CommentSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class CommentListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of comments that match the request criteria. */
  core.List<Comment> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#commentListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  CommentListResponse();

  CommentListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Comment.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Basic details about a comment, such as its author and text. */
class CommentSnippet {
  /**
   * The id of the author's YouTube channel, if any.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Object authorChannelId;
  /** Link to the author's YouTube channel, if any. */
  core.String authorChannelUrl;
  /** The name of the user who posted the comment. */
  core.String authorDisplayName;
  /** The URL for the avatar of the user who posted the comment. */
  core.String authorProfileImageUrl;
  /** Whether the current viewer can rate this comment. */
  core.bool canRate;
  /**
   * The id of the corresponding YouTube channel. In case of a channel comment
   * this is the channel the comment refers to. In case of a video comment it's
   * the video's channel.
   */
  core.String channelId;
  /** The total number of likes this comment has received. */
  core.int likeCount;
  /**
   * The comment's moderation status. Will not be set if the comments were
   * requested through the id filter.
   * Possible string values are:
   * - "heldForReview"
   * - "likelySpam"
   * - "published"
   * - "rejected"
   */
  core.String moderationStatus;
  /** The unique id of the parent comment, only set for replies. */
  core.String parentId;
  /**
   * The date and time when the comment was orignally published. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * The comment's text. The format is either plain text or HTML dependent on
   * what has been requested. Even the plain text representation may differ from
   * the text originally posted in that it may replace video links with video
   * titles etc.
   */
  core.String textDisplay;
  /**
   * The comment's original raw text as initially posted or last updated. The
   * original text will only be returned if it is accessible to the viewer,
   * which is only guaranteed if the viewer is the comment's author.
   */
  core.String textOriginal;
  /**
   * The date and time when was last updated . The value is specified in ISO
   * 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime updatedAt;
  /** The ID of the video the comment refers to, if any. */
  core.String videoId;
  /**
   * The rating the viewer has given to this comment. For the time being this
   * will never return RATE_TYPE_DISLIKE and instead return RATE_TYPE_NONE. This
   * may change in the future.
   * Possible string values are:
   * - "dislike"
   * - "like"
   * - "none"
   * - "unspecified"
   */
  core.String viewerRating;

  CommentSnippet();

  CommentSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("authorChannelId")) {
      authorChannelId = _json["authorChannelId"];
    }
    if (_json.containsKey("authorChannelUrl")) {
      authorChannelUrl = _json["authorChannelUrl"];
    }
    if (_json.containsKey("authorDisplayName")) {
      authorDisplayName = _json["authorDisplayName"];
    }
    if (_json.containsKey("authorProfileImageUrl")) {
      authorProfileImageUrl = _json["authorProfileImageUrl"];
    }
    if (_json.containsKey("canRate")) {
      canRate = _json["canRate"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("likeCount")) {
      likeCount = _json["likeCount"];
    }
    if (_json.containsKey("moderationStatus")) {
      moderationStatus = _json["moderationStatus"];
    }
    if (_json.containsKey("parentId")) {
      parentId = _json["parentId"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("textDisplay")) {
      textDisplay = _json["textDisplay"];
    }
    if (_json.containsKey("textOriginal")) {
      textOriginal = _json["textOriginal"];
    }
    if (_json.containsKey("updatedAt")) {
      updatedAt = core.DateTime.parse(_json["updatedAt"]);
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
    if (_json.containsKey("viewerRating")) {
      viewerRating = _json["viewerRating"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorChannelId != null) {
      _json["authorChannelId"] = authorChannelId;
    }
    if (authorChannelUrl != null) {
      _json["authorChannelUrl"] = authorChannelUrl;
    }
    if (authorDisplayName != null) {
      _json["authorDisplayName"] = authorDisplayName;
    }
    if (authorProfileImageUrl != null) {
      _json["authorProfileImageUrl"] = authorProfileImageUrl;
    }
    if (canRate != null) {
      _json["canRate"] = canRate;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (likeCount != null) {
      _json["likeCount"] = likeCount;
    }
    if (moderationStatus != null) {
      _json["moderationStatus"] = moderationStatus;
    }
    if (parentId != null) {
      _json["parentId"] = parentId;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (textDisplay != null) {
      _json["textDisplay"] = textDisplay;
    }
    if (textOriginal != null) {
      _json["textOriginal"] = textOriginal;
    }
    if (updatedAt != null) {
      _json["updatedAt"] = (updatedAt).toIso8601String();
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    if (viewerRating != null) {
      _json["viewerRating"] = viewerRating;
    }
    return _json;
  }
}

/**
 * A comment thread represents information that applies to a top level comment
 * and all its replies. It can also include the top level comment itself and
 * some of the replies.
 */
class CommentThread {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the comment thread. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#commentThread".
   */
  core.String kind;
  /**
   * The replies object contains a limited number of replies (if any) to the top
   * level comment found in the snippet.
   */
  CommentThreadReplies replies;
  /**
   * The snippet object contains basic details about the comment thread and also
   * the top level comment.
   */
  CommentThreadSnippet snippet;

  CommentThread();

  CommentThread.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("replies")) {
      replies = new CommentThreadReplies.fromJson(_json["replies"]);
    }
    if (_json.containsKey("snippet")) {
      snippet = new CommentThreadSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (replies != null) {
      _json["replies"] = (replies).toJson();
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class CommentThreadListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of comment threads that match the request criteria. */
  core.List<CommentThread> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#commentThreadListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  CommentThreadListResponse();

  CommentThreadListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CommentThread.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Comments written in (direct or indirect) reply to the top level comment. */
class CommentThreadReplies {
  /**
   * A limited number of replies. Unless the number of replies returned equals
   * total_reply_count in the snippet the returned replies are only a subset of
   * the total number of replies.
   */
  core.List<Comment> comments;

  CommentThreadReplies();

  CommentThreadReplies.fromJson(core.Map _json) {
    if (_json.containsKey("comments")) {
      comments = _json["comments"].map((value) => new Comment.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comments != null) {
      _json["comments"] = comments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Basic details about a comment thread. */
class CommentThreadSnippet {
  /**
   * Whether the current viewer of the thread can reply to it. This is viewer
   * specific - other viewers may see a different value for this field.
   */
  core.bool canReply;
  /**
   * The YouTube channel the comments in the thread refer to or the channel with
   * the video the comments refer to. If video_id isn't set the comments refer
   * to the channel itself.
   */
  core.String channelId;
  /**
   * Whether the thread (and therefore all its comments) is visible to all
   * YouTube users.
   */
  core.bool isPublic;
  /** The top level comment of this thread. */
  Comment topLevelComment;
  /** The total number of replies (not including the top level comment). */
  core.int totalReplyCount;
  /**
   * The ID of the video the comments refer to, if any. No video_id implies a
   * channel discussion comment.
   */
  core.String videoId;

  CommentThreadSnippet();

  CommentThreadSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("canReply")) {
      canReply = _json["canReply"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("isPublic")) {
      isPublic = _json["isPublic"];
    }
    if (_json.containsKey("topLevelComment")) {
      topLevelComment = new Comment.fromJson(_json["topLevelComment"]);
    }
    if (_json.containsKey("totalReplyCount")) {
      totalReplyCount = _json["totalReplyCount"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (canReply != null) {
      _json["canReply"] = canReply;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (isPublic != null) {
      _json["isPublic"] = isPublic;
    }
    if (topLevelComment != null) {
      _json["topLevelComment"] = (topLevelComment).toJson();
    }
    if (totalReplyCount != null) {
      _json["totalReplyCount"] = totalReplyCount;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/**
 * Ratings schemes. The country-specific ratings are mostly for movies and
 * shows. NEXT_ID: 69
 */
class ContentRating {
  /**
   * The video's Australian Classification Board (ACB) or Australian
   * Communications and Media Authority (ACMA) rating. ACMA ratings are used to
   * classify children's television programming.
   * Possible string values are:
   * - "acbC"
   * - "acbE"
   * - "acbG"
   * - "acbM"
   * - "acbMa15plus"
   * - "acbP"
   * - "acbPg"
   * - "acbR18plus"
   * - "acbUnrated"
   */
  core.String acbRating;
  /**
   * The video's rating from Italy's Autorità per le Garanzie nelle
   * Comunicazioni (AGCOM).
   * Possible string values are:
   * - "agcomT"
   * - "agcomUnrated"
   * - "agcomVm14"
   * - "agcomVm18"
   */
  core.String agcomRating;
  /**
   * The video's Anatel (Asociación Nacional de Televisión) rating for Chilean
   * television.
   * Possible string values are:
   * - "anatelA"
   * - "anatelF"
   * - "anatelI"
   * - "anatelI10"
   * - "anatelI12"
   * - "anatelI7"
   * - "anatelR"
   * - "anatelUnrated"
   */
  core.String anatelRating;
  /**
   * The video's British Board of Film Classification (BBFC) rating.
   * Possible string values are:
   * - "bbfc12"
   * - "bbfc12a"
   * - "bbfc15"
   * - "bbfc18"
   * - "bbfcPg"
   * - "bbfcR18"
   * - "bbfcU"
   * - "bbfcUnrated"
   */
  core.String bbfcRating;
  /**
   * The video's rating from Thailand's Board of Film and Video Censors.
   * Possible string values are:
   * - "bfvc13"
   * - "bfvc15"
   * - "bfvc18"
   * - "bfvc20"
   * - "bfvcB"
   * - "bfvcE"
   * - "bfvcG"
   * - "bfvcUnrated"
   */
  core.String bfvcRating;
  /**
   * The video's rating from the Austrian Board of Media Classification
   * (Bundesministerium für Unterricht, Kunst und Kultur).
   * Possible string values are:
   * - "bmukk10"
   * - "bmukk12"
   * - "bmukk14"
   * - "bmukk16"
   * - "bmukk6"
   * - "bmukk8"
   * - "bmukkAa"
   * - "bmukkUnrated"
   */
  core.String bmukkRating;
  /**
   * Rating system for Canadian TV - Canadian TV Classification System The
   * video's rating from the Canadian Radio-Television and Telecommunications
   * Commission (CRTC) for Canadian English-language broadcasts. For more
   * information, see the Canadian Broadcast Standards Council website.
   * Possible string values are:
   * - "catv14plus"
   * - "catv18plus"
   * - "catvC"
   * - "catvC8"
   * - "catvG"
   * - "catvPg"
   * - "catvUnrated"
   */
  core.String catvRating;
  /**
   * The video's rating from the Canadian Radio-Television and
   * Telecommunications Commission (CRTC) for Canadian French-language
   * broadcasts. For more information, see the Canadian Broadcast Standards
   * Council website.
   * Possible string values are:
   * - "catvfr13plus"
   * - "catvfr16plus"
   * - "catvfr18plus"
   * - "catvfr8plus"
   * - "catvfrG"
   * - "catvfrUnrated"
   */
  core.String catvfrRating;
  /**
   * The video's Central Board of Film Certification (CBFC - India) rating.
   * Possible string values are:
   * - "cbfcA"
   * - "cbfcS"
   * - "cbfcU"
   * - "cbfcUA"
   * - "cbfcUnrated"
   */
  core.String cbfcRating;
  /**
   * The video's Consejo de Calificación Cinematográfica (Chile) rating.
   * Possible string values are:
   * - "ccc14"
   * - "ccc18"
   * - "ccc18s"
   * - "ccc18v"
   * - "ccc6"
   * - "cccTe"
   * - "cccUnrated"
   */
  core.String cccRating;
  /**
   * The video's rating from Portugal's Comissão de Classificação de
   * Espect´culos.
   * Possible string values are:
   * - "cceM12"
   * - "cceM14"
   * - "cceM16"
   * - "cceM18"
   * - "cceM4"
   * - "cceM6"
   * - "cceUnrated"
   */
  core.String cceRating;
  /**
   * The video's rating in Switzerland.
   * Possible string values are:
   * - "chfilm0"
   * - "chfilm12"
   * - "chfilm16"
   * - "chfilm18"
   * - "chfilm6"
   * - "chfilmUnrated"
   */
  core.String chfilmRating;
  /**
   * The video's Canadian Home Video Rating System (CHVRS) rating.
   * Possible string values are:
   * - "chvrs14a"
   * - "chvrs18a"
   * - "chvrsE"
   * - "chvrsG"
   * - "chvrsPg"
   * - "chvrsR"
   * - "chvrsUnrated"
   */
  core.String chvrsRating;
  /**
   * The video's rating from the Commission de Contrôle des Films (Belgium).
   * Possible string values are:
   * - "cicfE"
   * - "cicfKntEna"
   * - "cicfKtEa"
   * - "cicfUnrated"
   */
  core.String cicfRating;
  /**
   * The video's rating from Romania's CONSILIUL NATIONAL AL AUDIOVIZUALULUI
   * (CNA).
   * Possible string values are:
   * - "cna12"
   * - "cna15"
   * - "cna18"
   * - "cna18plus"
   * - "cnaAp"
   * - "cnaUnrated"
   */
  core.String cnaRating;
  /**
   * Rating system in France - Commission de classification cinematographique
   * Possible string values are:
   * - "cnc10"
   * - "cnc12"
   * - "cnc16"
   * - "cnc18"
   * - "cncE"
   * - "cncT"
   * - "cncUnrated"
   */
  core.String cncRating;
  /**
   * The video's rating from France's Conseil supérieur de l?audiovisuel, which
   * rates broadcast content.
   * Possible string values are:
   * - "csa10"
   * - "csa12"
   * - "csa16"
   * - "csa18"
   * - "csaInterdiction"
   * - "csaT"
   * - "csaUnrated"
   */
  core.String csaRating;
  /**
   * The video's rating from Luxembourg's Commission de surveillance de la
   * classification des films (CSCF).
   * Possible string values are:
   * - "cscf12"
   * - "cscf16"
   * - "cscf18"
   * - "cscf6"
   * - "cscf9"
   * - "cscfA"
   * - "cscfAl"
   * - "cscfUnrated"
   */
  core.String cscfRating;
  /**
   * The video's rating in the Czech Republic.
   * Possible string values are:
   * - "czfilm12"
   * - "czfilm14"
   * - "czfilm18"
   * - "czfilmU"
   * - "czfilmUnrated"
   */
  core.String czfilmRating;
  /**
   * The video's Departamento de Justiça, Classificação, Qualificação e Títulos
   * (DJCQT - Brazil) rating.
   * Possible string values are:
   * - "djctq10"
   * - "djctq12"
   * - "djctq14"
   * - "djctq16"
   * - "djctq18"
   * - "djctqL"
   * - "djctqUnrated"
   */
  core.String djctqRating;
  /** Reasons that explain why the video received its DJCQT (Brazil) rating. */
  core.List<core.String> djctqRatingReasons;
  /**
   * Rating system in Turkey - Evaluation and Classification Board of the
   * Ministry of Culture and Tourism
   * Possible string values are:
   * - "ecbmct13a"
   * - "ecbmct13plus"
   * - "ecbmct15a"
   * - "ecbmct15plus"
   * - "ecbmct18plus"
   * - "ecbmct7a"
   * - "ecbmct7plus"
   * - "ecbmctG"
   * - "ecbmctUnrated"
   */
  core.String ecbmctRating;
  /**
   * The video's rating in Estonia.
   * Possible string values are:
   * - "eefilmK12"
   * - "eefilmK14"
   * - "eefilmK16"
   * - "eefilmK6"
   * - "eefilmL"
   * - "eefilmMs12"
   * - "eefilmMs6"
   * - "eefilmPere"
   * - "eefilmUnrated"
   */
  core.String eefilmRating;
  /**
   * The video's rating in Egypt.
   * Possible string values are:
   * - "egfilm18"
   * - "egfilmBn"
   * - "egfilmGn"
   * - "egfilmUnrated"
   */
  core.String egfilmRating;
  /**
   * The video's Eirin (映倫) rating. Eirin is the Japanese rating system.
   * Possible string values are:
   * - "eirinG"
   * - "eirinPg12"
   * - "eirinR15plus"
   * - "eirinR18plus"
   * - "eirinUnrated"
   */
  core.String eirinRating;
  /**
   * The video's rating from Malaysia's Film Censorship Board.
   * Possible string values are:
   * - "fcbm18"
   * - "fcbm18pa"
   * - "fcbm18pl"
   * - "fcbm18sg"
   * - "fcbm18sx"
   * - "fcbmP13"
   * - "fcbmPg13"
   * - "fcbmU"
   * - "fcbmUnrated"
   */
  core.String fcbmRating;
  /**
   * The video's rating from Hong Kong's Office for Film, Newspaper and Article
   * Administration.
   * Possible string values are:
   * - "fcoI"
   * - "fcoIi"
   * - "fcoIia"
   * - "fcoIib"
   * - "fcoIii"
   * - "fcoUnrated"
   */
  core.String fcoRating;
  /**
   * This property has been deprecated. Use the
   * contentDetails.contentRating.cncRating instead.
   * Possible string values are:
   * - "fmoc10"
   * - "fmoc12"
   * - "fmoc16"
   * - "fmoc18"
   * - "fmocE"
   * - "fmocU"
   * - "fmocUnrated"
   */
  core.String fmocRating;
  /**
   * The video's rating from South Africa's Film and Publication Board.
   * Possible string values are:
   * - "fpb10"
   * - "fpb1012Pg"
   * - "fpb13"
   * - "fpb16"
   * - "fpb18"
   * - "fpb79Pg"
   * - "fpbA"
   * - "fpbPg"
   * - "fpbUnrated"
   * - "fpbX18"
   * - "fpbXx"
   */
  core.String fpbRating;
  /**
   * Reasons that explain why the video received its FPB (South Africa) rating.
   */
  core.List<core.String> fpbRatingReasons;
  /**
   * The video's Freiwillige Selbstkontrolle der Filmwirtschaft (FSK - Germany)
   * rating.
   * Possible string values are:
   * - "fsk0"
   * - "fsk12"
   * - "fsk16"
   * - "fsk18"
   * - "fsk6"
   * - "fskUnrated"
   */
  core.String fskRating;
  /**
   * The video's rating in Greece.
   * Possible string values are:
   * - "grfilmE"
   * - "grfilmK"
   * - "grfilmK12"
   * - "grfilmK13"
   * - "grfilmK15"
   * - "grfilmK17"
   * - "grfilmK18"
   * - "grfilmUnrated"
   */
  core.String grfilmRating;
  /**
   * The video's Instituto de la Cinematografía y de las Artes Audiovisuales
   * (ICAA - Spain) rating.
   * Possible string values are:
   * - "icaa12"
   * - "icaa13"
   * - "icaa16"
   * - "icaa18"
   * - "icaa7"
   * - "icaaApta"
   * - "icaaUnrated"
   * - "icaaX"
   */
  core.String icaaRating;
  /**
   * The video's Irish Film Classification Office (IFCO - Ireland) rating. See
   * the IFCO website for more information.
   * Possible string values are:
   * - "ifco12"
   * - "ifco12a"
   * - "ifco15"
   * - "ifco15a"
   * - "ifco16"
   * - "ifco18"
   * - "ifcoG"
   * - "ifcoPg"
   * - "ifcoUnrated"
   */
  core.String ifcoRating;
  /**
   * The video's rating in Israel.
   * Possible string values are:
   * - "ilfilm12"
   * - "ilfilm16"
   * - "ilfilm18"
   * - "ilfilmAa"
   * - "ilfilmUnrated"
   */
  core.String ilfilmRating;
  /**
   * The video's INCAA (Instituto Nacional de Cine y Artes Audiovisuales -
   * Argentina) rating.
   * Possible string values are:
   * - "incaaAtp"
   * - "incaaC"
   * - "incaaSam13"
   * - "incaaSam16"
   * - "incaaSam18"
   * - "incaaUnrated"
   */
  core.String incaaRating;
  /**
   * The video's rating from the Kenya Film Classification Board.
   * Possible string values are:
   * - "kfcb16plus"
   * - "kfcbG"
   * - "kfcbPg"
   * - "kfcbR"
   * - "kfcbUnrated"
   */
  core.String kfcbRating;
  /**
   * voor de Classificatie van Audiovisuele Media (Netherlands).
   * Possible string values are:
   * - "kijkwijzer12"
   * - "kijkwijzer16"
   * - "kijkwijzer18"
   * - "kijkwijzer6"
   * - "kijkwijzer9"
   * - "kijkwijzerAl"
   * - "kijkwijzerUnrated"
   */
  core.String kijkwijzerRating;
  /**
   * The video's Korea Media Rating Board (영상물등급위원회) rating. The KMRB rates
   * videos in South Korea.
   * Possible string values are:
   * - "kmrb12plus"
   * - "kmrb15plus"
   * - "kmrbAll"
   * - "kmrbR"
   * - "kmrbTeenr"
   * - "kmrbUnrated"
   */
  core.String kmrbRating;
  /**
   * The video's rating from Indonesia's Lembaga Sensor Film.
   * Possible string values are:
   * - "lsf13"
   * - "lsf17"
   * - "lsf21"
   * - "lsfA"
   * - "lsfBo"
   * - "lsfD"
   * - "lsfR"
   * - "lsfSu"
   * - "lsfUnrated"
   */
  core.String lsfRating;
  /**
   * The video's rating from Malta's Film Age-Classification Board.
   * Possible string values are:
   * - "mccaa12"
   * - "mccaa12a"
   * - "mccaa14"
   * - "mccaa15"
   * - "mccaa16"
   * - "mccaa18"
   * - "mccaaPg"
   * - "mccaaU"
   * - "mccaaUnrated"
   */
  core.String mccaaRating;
  /**
   * The video's rating from the Danish Film Institute's (Det Danske
   * Filminstitut) Media Council for Children and Young People.
   * Possible string values are:
   * - "mccyp11"
   * - "mccyp15"
   * - "mccyp7"
   * - "mccypA"
   * - "mccypUnrated"
   */
  core.String mccypRating;
  /**
   * The video's rating system for Vietnam - MCST
   * Possible string values are:
   * - "mcst0"
   * - "mcst16plus"
   * - "mcstC13"
   * - "mcstC16"
   * - "mcstC18"
   * - "mcstGPg"
   * - "mcstP"
   * - "mcstUnrated"
   */
  core.String mcstRating;
  /**
   * The video's rating from Singapore's Media Development Authority (MDA) and,
   * specifically, it's Board of Film Censors (BFC).
   * Possible string values are:
   * - "mdaG"
   * - "mdaM18"
   * - "mdaNc16"
   * - "mdaPg"
   * - "mdaPg13"
   * - "mdaR21"
   * - "mdaUnrated"
   */
  core.String mdaRating;
  /**
   * The video's rating from Medietilsynet, the Norwegian Media Authority.
   * Possible string values are:
   * - "medietilsynet11"
   * - "medietilsynet12"
   * - "medietilsynet15"
   * - "medietilsynet18"
   * - "medietilsynet6"
   * - "medietilsynet7"
   * - "medietilsynet9"
   * - "medietilsynetA"
   * - "medietilsynetUnrated"
   */
  core.String medietilsynetRating;
  /**
   * The video's rating from Finland's Kansallinen Audiovisuaalinen Instituutti
   * (National Audiovisual Institute).
   * Possible string values are:
   * - "meku12"
   * - "meku16"
   * - "meku18"
   * - "meku7"
   * - "mekuS"
   * - "mekuUnrated"
   */
  core.String mekuRating;
  /**
   * The video's rating from the Ministero dei Beni e delle Attività Culturali e
   * del Turismo (Italy).
   * Possible string values are:
   * - "mibacT"
   * - "mibacUnrated"
   * - "mibacVap"
   * - "mibacVm12"
   * - "mibacVm14"
   * - "mibacVm18"
   */
  core.String mibacRating;
  /**
   * The video's Ministerio de Cultura (Colombia) rating.
   * Possible string values are:
   * - "moc12"
   * - "moc15"
   * - "moc18"
   * - "moc7"
   * - "mocBanned"
   * - "mocE"
   * - "mocT"
   * - "mocUnrated"
   * - "mocX"
   */
  core.String mocRating;
  /**
   * The video's rating from Taiwan's Ministry of Culture (文化部).
   * Possible string values are:
   * - "moctwG"
   * - "moctwP"
   * - "moctwPg"
   * - "moctwR"
   * - "moctwR12"
   * - "moctwR15"
   * - "moctwUnrated"
   */
  core.String moctwRating;
  /**
   * The video's Motion Picture Association of America (MPAA) rating.
   * Possible string values are:
   * - "mpaaG"
   * - "mpaaNc17"
   * - "mpaaPg"
   * - "mpaaPg13"
   * - "mpaaR"
   * - "mpaaUnrated"
   */
  core.String mpaaRating;
  /**
   * The video's rating from the Movie and Television Review and Classification
   * Board (Philippines).
   * Possible string values are:
   * - "mtrcbG"
   * - "mtrcbPg"
   * - "mtrcbR13"
   * - "mtrcbR16"
   * - "mtrcbR18"
   * - "mtrcbUnrated"
   * - "mtrcbX"
   */
  core.String mtrcbRating;
  /**
   * The video's rating from the Maldives National Bureau of Classification.
   * Possible string values are:
   * - "nbc12plus"
   * - "nbc15plus"
   * - "nbc18plus"
   * - "nbc18plusr"
   * - "nbcG"
   * - "nbcPg"
   * - "nbcPu"
   * - "nbcUnrated"
   */
  core.String nbcRating;
  /**
   * The video's rating in Poland.
   * Possible string values are:
   * - "nbcpl18plus"
   * - "nbcplI"
   * - "nbcplIi"
   * - "nbcplIii"
   * - "nbcplIv"
   * - "nbcplUnrated"
   */
  core.String nbcplRating;
  /**
   * The video's rating from the Bulgarian National Film Center.
   * Possible string values are:
   * - "nfrcA"
   * - "nfrcB"
   * - "nfrcC"
   * - "nfrcD"
   * - "nfrcUnrated"
   * - "nfrcX"
   */
  core.String nfrcRating;
  /**
   * The video's rating from Nigeria's National Film and Video Censors Board.
   * Possible string values are:
   * - "nfvcb12"
   * - "nfvcb12a"
   * - "nfvcb15"
   * - "nfvcb18"
   * - "nfvcbG"
   * - "nfvcbPg"
   * - "nfvcbRe"
   * - "nfvcbUnrated"
   */
  core.String nfvcbRating;
  /**
   * The video's rating from the Nacionãlais Kino centrs (National Film Centre
   * of Latvia).
   * Possible string values are:
   * - "nkclv12plus"
   * - "nkclv18plus"
   * - "nkclv7plus"
   * - "nkclvU"
   * - "nkclvUnrated"
   */
  core.String nkclvRating;
  /**
   * The video's Office of Film and Literature Classification (OFLC - New
   * Zealand) rating.
   * Possible string values are:
   * - "oflcG"
   * - "oflcM"
   * - "oflcPg"
   * - "oflcR13"
   * - "oflcR15"
   * - "oflcR16"
   * - "oflcR18"
   * - "oflcRp13"
   * - "oflcRp16"
   * - "oflcUnrated"
   */
  core.String oflcRating;
  /**
   * The video's rating in Peru.
   * Possible string values are:
   * - "pefilm14"
   * - "pefilm18"
   * - "pefilmPg"
   * - "pefilmPt"
   * - "pefilmUnrated"
   */
  core.String pefilmRating;
  /**
   * The video's rating from the Hungarian Nemzeti Filmiroda, the Rating
   * Committee of the National Office of Film.
   * Possible string values are:
   * - "rcnofI"
   * - "rcnofIi"
   * - "rcnofIii"
   * - "rcnofIv"
   * - "rcnofUnrated"
   * - "rcnofV"
   * - "rcnofVi"
   */
  core.String rcnofRating;
  /**
   * The video's rating in Venezuela.
   * Possible string values are:
   * - "resorteviolenciaA"
   * - "resorteviolenciaB"
   * - "resorteviolenciaC"
   * - "resorteviolenciaD"
   * - "resorteviolenciaE"
   * - "resorteviolenciaUnrated"
   */
  core.String resorteviolenciaRating;
  /**
   * The video's General Directorate of Radio, Television and Cinematography
   * (Mexico) rating.
   * Possible string values are:
   * - "rtcA"
   * - "rtcAa"
   * - "rtcB"
   * - "rtcB15"
   * - "rtcC"
   * - "rtcD"
   * - "rtcUnrated"
   */
  core.String rtcRating;
  /**
   * The video's rating from Ireland's Raidió Teilifís Éireann.
   * Possible string values are:
   * - "rteCh"
   * - "rteGa"
   * - "rteMa"
   * - "rtePs"
   * - "rteUnrated"
   */
  core.String rteRating;
  /**
   * The video's National Film Registry of the Russian Federation (MKRF -
   * Russia) rating.
   * Possible string values are:
   * - "russia0"
   * - "russia12"
   * - "russia16"
   * - "russia18"
   * - "russia6"
   * - "russiaUnrated"
   */
  core.String russiaRating;
  /**
   * The video's rating in Slovakia.
   * Possible string values are:
   * - "skfilmG"
   * - "skfilmP2"
   * - "skfilmP5"
   * - "skfilmP8"
   * - "skfilmUnrated"
   */
  core.String skfilmRating;
  /**
   * The video's rating in Iceland.
   * Possible string values are:
   * - "smais12"
   * - "smais14"
   * - "smais16"
   * - "smais18"
   * - "smais7"
   * - "smaisL"
   * - "smaisUnrated"
   */
  core.String smaisRating;
  /**
   * The video's rating from Statens medieråd (Sweden's National Media Council).
   * Possible string values are:
   * - "smsa11"
   * - "smsa15"
   * - "smsa7"
   * - "smsaA"
   * - "smsaUnrated"
   */
  core.String smsaRating;
  /**
   * The video's TV Parental Guidelines (TVPG) rating.
   * Possible string values are:
   * - "pg14"
   * - "tvpgG"
   * - "tvpgMa"
   * - "tvpgPg"
   * - "tvpgUnrated"
   * - "tvpgY"
   * - "tvpgY7"
   * - "tvpgY7Fv"
   */
  core.String tvpgRating;
  /**
   * A rating that YouTube uses to identify age-restricted content.
   * Possible string values are:
   * - "ytAgeRestricted"
   */
  core.String ytRating;

  ContentRating();

  ContentRating.fromJson(core.Map _json) {
    if (_json.containsKey("acbRating")) {
      acbRating = _json["acbRating"];
    }
    if (_json.containsKey("agcomRating")) {
      agcomRating = _json["agcomRating"];
    }
    if (_json.containsKey("anatelRating")) {
      anatelRating = _json["anatelRating"];
    }
    if (_json.containsKey("bbfcRating")) {
      bbfcRating = _json["bbfcRating"];
    }
    if (_json.containsKey("bfvcRating")) {
      bfvcRating = _json["bfvcRating"];
    }
    if (_json.containsKey("bmukkRating")) {
      bmukkRating = _json["bmukkRating"];
    }
    if (_json.containsKey("catvRating")) {
      catvRating = _json["catvRating"];
    }
    if (_json.containsKey("catvfrRating")) {
      catvfrRating = _json["catvfrRating"];
    }
    if (_json.containsKey("cbfcRating")) {
      cbfcRating = _json["cbfcRating"];
    }
    if (_json.containsKey("cccRating")) {
      cccRating = _json["cccRating"];
    }
    if (_json.containsKey("cceRating")) {
      cceRating = _json["cceRating"];
    }
    if (_json.containsKey("chfilmRating")) {
      chfilmRating = _json["chfilmRating"];
    }
    if (_json.containsKey("chvrsRating")) {
      chvrsRating = _json["chvrsRating"];
    }
    if (_json.containsKey("cicfRating")) {
      cicfRating = _json["cicfRating"];
    }
    if (_json.containsKey("cnaRating")) {
      cnaRating = _json["cnaRating"];
    }
    if (_json.containsKey("cncRating")) {
      cncRating = _json["cncRating"];
    }
    if (_json.containsKey("csaRating")) {
      csaRating = _json["csaRating"];
    }
    if (_json.containsKey("cscfRating")) {
      cscfRating = _json["cscfRating"];
    }
    if (_json.containsKey("czfilmRating")) {
      czfilmRating = _json["czfilmRating"];
    }
    if (_json.containsKey("djctqRating")) {
      djctqRating = _json["djctqRating"];
    }
    if (_json.containsKey("djctqRatingReasons")) {
      djctqRatingReasons = _json["djctqRatingReasons"];
    }
    if (_json.containsKey("ecbmctRating")) {
      ecbmctRating = _json["ecbmctRating"];
    }
    if (_json.containsKey("eefilmRating")) {
      eefilmRating = _json["eefilmRating"];
    }
    if (_json.containsKey("egfilmRating")) {
      egfilmRating = _json["egfilmRating"];
    }
    if (_json.containsKey("eirinRating")) {
      eirinRating = _json["eirinRating"];
    }
    if (_json.containsKey("fcbmRating")) {
      fcbmRating = _json["fcbmRating"];
    }
    if (_json.containsKey("fcoRating")) {
      fcoRating = _json["fcoRating"];
    }
    if (_json.containsKey("fmocRating")) {
      fmocRating = _json["fmocRating"];
    }
    if (_json.containsKey("fpbRating")) {
      fpbRating = _json["fpbRating"];
    }
    if (_json.containsKey("fpbRatingReasons")) {
      fpbRatingReasons = _json["fpbRatingReasons"];
    }
    if (_json.containsKey("fskRating")) {
      fskRating = _json["fskRating"];
    }
    if (_json.containsKey("grfilmRating")) {
      grfilmRating = _json["grfilmRating"];
    }
    if (_json.containsKey("icaaRating")) {
      icaaRating = _json["icaaRating"];
    }
    if (_json.containsKey("ifcoRating")) {
      ifcoRating = _json["ifcoRating"];
    }
    if (_json.containsKey("ilfilmRating")) {
      ilfilmRating = _json["ilfilmRating"];
    }
    if (_json.containsKey("incaaRating")) {
      incaaRating = _json["incaaRating"];
    }
    if (_json.containsKey("kfcbRating")) {
      kfcbRating = _json["kfcbRating"];
    }
    if (_json.containsKey("kijkwijzerRating")) {
      kijkwijzerRating = _json["kijkwijzerRating"];
    }
    if (_json.containsKey("kmrbRating")) {
      kmrbRating = _json["kmrbRating"];
    }
    if (_json.containsKey("lsfRating")) {
      lsfRating = _json["lsfRating"];
    }
    if (_json.containsKey("mccaaRating")) {
      mccaaRating = _json["mccaaRating"];
    }
    if (_json.containsKey("mccypRating")) {
      mccypRating = _json["mccypRating"];
    }
    if (_json.containsKey("mcstRating")) {
      mcstRating = _json["mcstRating"];
    }
    if (_json.containsKey("mdaRating")) {
      mdaRating = _json["mdaRating"];
    }
    if (_json.containsKey("medietilsynetRating")) {
      medietilsynetRating = _json["medietilsynetRating"];
    }
    if (_json.containsKey("mekuRating")) {
      mekuRating = _json["mekuRating"];
    }
    if (_json.containsKey("mibacRating")) {
      mibacRating = _json["mibacRating"];
    }
    if (_json.containsKey("mocRating")) {
      mocRating = _json["mocRating"];
    }
    if (_json.containsKey("moctwRating")) {
      moctwRating = _json["moctwRating"];
    }
    if (_json.containsKey("mpaaRating")) {
      mpaaRating = _json["mpaaRating"];
    }
    if (_json.containsKey("mtrcbRating")) {
      mtrcbRating = _json["mtrcbRating"];
    }
    if (_json.containsKey("nbcRating")) {
      nbcRating = _json["nbcRating"];
    }
    if (_json.containsKey("nbcplRating")) {
      nbcplRating = _json["nbcplRating"];
    }
    if (_json.containsKey("nfrcRating")) {
      nfrcRating = _json["nfrcRating"];
    }
    if (_json.containsKey("nfvcbRating")) {
      nfvcbRating = _json["nfvcbRating"];
    }
    if (_json.containsKey("nkclvRating")) {
      nkclvRating = _json["nkclvRating"];
    }
    if (_json.containsKey("oflcRating")) {
      oflcRating = _json["oflcRating"];
    }
    if (_json.containsKey("pefilmRating")) {
      pefilmRating = _json["pefilmRating"];
    }
    if (_json.containsKey("rcnofRating")) {
      rcnofRating = _json["rcnofRating"];
    }
    if (_json.containsKey("resorteviolenciaRating")) {
      resorteviolenciaRating = _json["resorteviolenciaRating"];
    }
    if (_json.containsKey("rtcRating")) {
      rtcRating = _json["rtcRating"];
    }
    if (_json.containsKey("rteRating")) {
      rteRating = _json["rteRating"];
    }
    if (_json.containsKey("russiaRating")) {
      russiaRating = _json["russiaRating"];
    }
    if (_json.containsKey("skfilmRating")) {
      skfilmRating = _json["skfilmRating"];
    }
    if (_json.containsKey("smaisRating")) {
      smaisRating = _json["smaisRating"];
    }
    if (_json.containsKey("smsaRating")) {
      smsaRating = _json["smsaRating"];
    }
    if (_json.containsKey("tvpgRating")) {
      tvpgRating = _json["tvpgRating"];
    }
    if (_json.containsKey("ytRating")) {
      ytRating = _json["ytRating"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acbRating != null) {
      _json["acbRating"] = acbRating;
    }
    if (agcomRating != null) {
      _json["agcomRating"] = agcomRating;
    }
    if (anatelRating != null) {
      _json["anatelRating"] = anatelRating;
    }
    if (bbfcRating != null) {
      _json["bbfcRating"] = bbfcRating;
    }
    if (bfvcRating != null) {
      _json["bfvcRating"] = bfvcRating;
    }
    if (bmukkRating != null) {
      _json["bmukkRating"] = bmukkRating;
    }
    if (catvRating != null) {
      _json["catvRating"] = catvRating;
    }
    if (catvfrRating != null) {
      _json["catvfrRating"] = catvfrRating;
    }
    if (cbfcRating != null) {
      _json["cbfcRating"] = cbfcRating;
    }
    if (cccRating != null) {
      _json["cccRating"] = cccRating;
    }
    if (cceRating != null) {
      _json["cceRating"] = cceRating;
    }
    if (chfilmRating != null) {
      _json["chfilmRating"] = chfilmRating;
    }
    if (chvrsRating != null) {
      _json["chvrsRating"] = chvrsRating;
    }
    if (cicfRating != null) {
      _json["cicfRating"] = cicfRating;
    }
    if (cnaRating != null) {
      _json["cnaRating"] = cnaRating;
    }
    if (cncRating != null) {
      _json["cncRating"] = cncRating;
    }
    if (csaRating != null) {
      _json["csaRating"] = csaRating;
    }
    if (cscfRating != null) {
      _json["cscfRating"] = cscfRating;
    }
    if (czfilmRating != null) {
      _json["czfilmRating"] = czfilmRating;
    }
    if (djctqRating != null) {
      _json["djctqRating"] = djctqRating;
    }
    if (djctqRatingReasons != null) {
      _json["djctqRatingReasons"] = djctqRatingReasons;
    }
    if (ecbmctRating != null) {
      _json["ecbmctRating"] = ecbmctRating;
    }
    if (eefilmRating != null) {
      _json["eefilmRating"] = eefilmRating;
    }
    if (egfilmRating != null) {
      _json["egfilmRating"] = egfilmRating;
    }
    if (eirinRating != null) {
      _json["eirinRating"] = eirinRating;
    }
    if (fcbmRating != null) {
      _json["fcbmRating"] = fcbmRating;
    }
    if (fcoRating != null) {
      _json["fcoRating"] = fcoRating;
    }
    if (fmocRating != null) {
      _json["fmocRating"] = fmocRating;
    }
    if (fpbRating != null) {
      _json["fpbRating"] = fpbRating;
    }
    if (fpbRatingReasons != null) {
      _json["fpbRatingReasons"] = fpbRatingReasons;
    }
    if (fskRating != null) {
      _json["fskRating"] = fskRating;
    }
    if (grfilmRating != null) {
      _json["grfilmRating"] = grfilmRating;
    }
    if (icaaRating != null) {
      _json["icaaRating"] = icaaRating;
    }
    if (ifcoRating != null) {
      _json["ifcoRating"] = ifcoRating;
    }
    if (ilfilmRating != null) {
      _json["ilfilmRating"] = ilfilmRating;
    }
    if (incaaRating != null) {
      _json["incaaRating"] = incaaRating;
    }
    if (kfcbRating != null) {
      _json["kfcbRating"] = kfcbRating;
    }
    if (kijkwijzerRating != null) {
      _json["kijkwijzerRating"] = kijkwijzerRating;
    }
    if (kmrbRating != null) {
      _json["kmrbRating"] = kmrbRating;
    }
    if (lsfRating != null) {
      _json["lsfRating"] = lsfRating;
    }
    if (mccaaRating != null) {
      _json["mccaaRating"] = mccaaRating;
    }
    if (mccypRating != null) {
      _json["mccypRating"] = mccypRating;
    }
    if (mcstRating != null) {
      _json["mcstRating"] = mcstRating;
    }
    if (mdaRating != null) {
      _json["mdaRating"] = mdaRating;
    }
    if (medietilsynetRating != null) {
      _json["medietilsynetRating"] = medietilsynetRating;
    }
    if (mekuRating != null) {
      _json["mekuRating"] = mekuRating;
    }
    if (mibacRating != null) {
      _json["mibacRating"] = mibacRating;
    }
    if (mocRating != null) {
      _json["mocRating"] = mocRating;
    }
    if (moctwRating != null) {
      _json["moctwRating"] = moctwRating;
    }
    if (mpaaRating != null) {
      _json["mpaaRating"] = mpaaRating;
    }
    if (mtrcbRating != null) {
      _json["mtrcbRating"] = mtrcbRating;
    }
    if (nbcRating != null) {
      _json["nbcRating"] = nbcRating;
    }
    if (nbcplRating != null) {
      _json["nbcplRating"] = nbcplRating;
    }
    if (nfrcRating != null) {
      _json["nfrcRating"] = nfrcRating;
    }
    if (nfvcbRating != null) {
      _json["nfvcbRating"] = nfvcbRating;
    }
    if (nkclvRating != null) {
      _json["nkclvRating"] = nkclvRating;
    }
    if (oflcRating != null) {
      _json["oflcRating"] = oflcRating;
    }
    if (pefilmRating != null) {
      _json["pefilmRating"] = pefilmRating;
    }
    if (rcnofRating != null) {
      _json["rcnofRating"] = rcnofRating;
    }
    if (resorteviolenciaRating != null) {
      _json["resorteviolenciaRating"] = resorteviolenciaRating;
    }
    if (rtcRating != null) {
      _json["rtcRating"] = rtcRating;
    }
    if (rteRating != null) {
      _json["rteRating"] = rteRating;
    }
    if (russiaRating != null) {
      _json["russiaRating"] = russiaRating;
    }
    if (skfilmRating != null) {
      _json["skfilmRating"] = skfilmRating;
    }
    if (smaisRating != null) {
      _json["smaisRating"] = smaisRating;
    }
    if (smsaRating != null) {
      _json["smsaRating"] = smsaRating;
    }
    if (tvpgRating != null) {
      _json["tvpgRating"] = tvpgRating;
    }
    if (ytRating != null) {
      _json["ytRating"] = ytRating;
    }
    return _json;
  }
}

/**
 * A fanFundingEvent resource represents a fan funding event on a YouTube
 * channel. Fan funding events occur when a user gives one-time monetary support
 * to the channel owner.
 */
class FanFundingEvent {
  /** Etag of this resource. */
  core.String etag;
  /**
   * The ID that YouTube assigns to uniquely identify the fan funding event.
   */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#fanFundingEvent".
   */
  core.String kind;
  /** The snippet object contains basic details about the fan funding event. */
  FanFundingEventSnippet snippet;

  FanFundingEvent();

  FanFundingEvent.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new FanFundingEventSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class FanFundingEventListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of fan funding events that match the request criteria. */
  core.List<FanFundingEvent> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#fanFundingEventListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  FanFundingEventListResponse();

  FanFundingEventListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new FanFundingEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class FanFundingEventSnippet {
  /**
   * The amount of funding in micros of fund_currency. e.g., 1 is represented
   */
  core.String amountMicros;
  /** Channel id where the funding event occurred. */
  core.String channelId;
  /** The text contents of the comment left by the user. */
  core.String commentText;
  /**
   * The date and time when the funding occurred. The value is specified in ISO
   * 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime createdAt;
  /** The currency in which the fund was made. ISO 4217. */
  core.String currency;
  /**
   * A rendered string that displays the fund amount and currency (e.g.,
   * "$1.00"). The string is rendered for the given language.
   */
  core.String displayString;
  /**
   * Details about the supporter. Only filled if the event was made public by
   * the user.
   */
  ChannelProfileDetails supporterDetails;

  FanFundingEventSnippet();

  FanFundingEventSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("amountMicros")) {
      amountMicros = _json["amountMicros"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("commentText")) {
      commentText = _json["commentText"];
    }
    if (_json.containsKey("createdAt")) {
      createdAt = core.DateTime.parse(_json["createdAt"]);
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("displayString")) {
      displayString = _json["displayString"];
    }
    if (_json.containsKey("supporterDetails")) {
      supporterDetails = new ChannelProfileDetails.fromJson(_json["supporterDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountMicros != null) {
      _json["amountMicros"] = amountMicros;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (commentText != null) {
      _json["commentText"] = commentText;
    }
    if (createdAt != null) {
      _json["createdAt"] = (createdAt).toIso8601String();
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (displayString != null) {
      _json["displayString"] = displayString;
    }
    if (supporterDetails != null) {
      _json["supporterDetails"] = (supporterDetails).toJson();
    }
    return _json;
  }
}

/** Geographical coordinates of a point, in WGS84. */
class GeoPoint {
  /** Altitude above the reference ellipsoid, in meters. */
  core.double altitude;
  /** Latitude in degrees. */
  core.double latitude;
  /** Longitude in degrees. */
  core.double longitude;

  GeoPoint();

  GeoPoint.fromJson(core.Map _json) {
    if (_json.containsKey("altitude")) {
      altitude = _json["altitude"];
    }
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (altitude != null) {
      _json["altitude"] = altitude;
    }
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/**
 * A guideCategory resource identifies a category that YouTube algorithmically
 * assigns based on a channel's content or other indicators, such as the
 * channel's popularity. The list is similar to video categories, with the
 * difference being that a video's uploader can assign a video category but only
 * YouTube can assign a channel category.
 */
class GuideCategory {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the guide category. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#guideCategory".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the category, such as its
   * title.
   */
  GuideCategorySnippet snippet;

  GuideCategory();

  GuideCategory.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new GuideCategorySnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class GuideCategoryListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /**
   * A list of categories that can be associated with YouTube channels. In this
   * map, the category ID is the map key, and its value is the corresponding
   * guideCategory resource.
   */
  core.List<GuideCategory> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#guideCategoryListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  GuideCategoryListResponse();

  GuideCategoryListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new GuideCategory.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Basic details about a guide category. */
class GuideCategorySnippet {
  core.String channelId;
  /** Description of the guide category. */
  core.String title;

  GuideCategorySnippet();

  GuideCategorySnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * An i18nLanguage resource identifies a UI language currently supported by
 * YouTube.
 */
class I18nLanguage {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the i18n language. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#i18nLanguage".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the i18n language, such as
   * language code and human-readable name.
   */
  I18nLanguageSnippet snippet;

  I18nLanguage();

  I18nLanguage.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new I18nLanguageSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class I18nLanguageListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /**
   * A list of supported i18n languages. In this map, the i18n language ID is
   * the map key, and its value is the corresponding i18nLanguage resource.
   */
  core.List<I18nLanguage> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#i18nLanguageListResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  I18nLanguageListResponse();

  I18nLanguageListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new I18nLanguage.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * Basic details about an i18n language, such as language code and
 * human-readable name.
 */
class I18nLanguageSnippet {
  /** A short BCP-47 code that uniquely identifies a language. */
  core.String hl;
  /** The human-readable name of the language in the language itself. */
  core.String name;

  I18nLanguageSnippet();

  I18nLanguageSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("hl")) {
      hl = _json["hl"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hl != null) {
      _json["hl"] = hl;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** A i18nRegion resource identifies a region where YouTube is available. */
class I18nRegion {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the i18n region. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#i18nRegion".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the i18n region, such as
   * region code and human-readable name.
   */
  I18nRegionSnippet snippet;

  I18nRegion();

  I18nRegion.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new I18nRegionSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class I18nRegionListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /**
   * A list of regions where YouTube is available. In this map, the i18n region
   * ID is the map key, and its value is the corresponding i18nRegion resource.
   */
  core.List<I18nRegion> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#i18nRegionListResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  I18nRegionListResponse();

  I18nRegionListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new I18nRegion.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * Basic details about an i18n region, such as region code and human-readable
 * name.
 */
class I18nRegionSnippet {
  /** The region code as a 2-letter ISO country code. */
  core.String gl;
  /** The human-readable name of the region. */
  core.String name;

  I18nRegionSnippet();

  I18nRegionSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("gl")) {
      gl = _json["gl"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (gl != null) {
      _json["gl"] = gl;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Branding properties for images associated with the channel. */
class ImageSettings {
  /**
   * The URL for the background image shown on the video watch page. The image
   * should be 1200px by 615px, with a maximum file size of 128k.
   */
  LocalizedProperty backgroundImageUrl;
  /**
   * This is used only in update requests; if it's set, we use this URL to
   * generate all of the above banner URLs.
   */
  core.String bannerExternalUrl;
  /** Banner image. Desktop size (1060x175). */
  core.String bannerImageUrl;
  /** Banner image. Mobile size high resolution (1440x395). */
  core.String bannerMobileExtraHdImageUrl;
  /** Banner image. Mobile size high resolution (1280x360). */
  core.String bannerMobileHdImageUrl;
  /** Banner image. Mobile size (640x175). */
  core.String bannerMobileImageUrl;
  /** Banner image. Mobile size low resolution (320x88). */
  core.String bannerMobileLowImageUrl;
  /** Banner image. Mobile size medium/high resolution (960x263). */
  core.String bannerMobileMediumHdImageUrl;
  /** Banner image. Tablet size extra high resolution (2560x424). */
  core.String bannerTabletExtraHdImageUrl;
  /** Banner image. Tablet size high resolution (2276x377). */
  core.String bannerTabletHdImageUrl;
  /** Banner image. Tablet size (1707x283). */
  core.String bannerTabletImageUrl;
  /** Banner image. Tablet size low resolution (1138x188). */
  core.String bannerTabletLowImageUrl;
  /** Banner image. TV size high resolution (1920x1080). */
  core.String bannerTvHighImageUrl;
  /** Banner image. TV size extra high resolution (2120x1192). */
  core.String bannerTvImageUrl;
  /** Banner image. TV size low resolution (854x480). */
  core.String bannerTvLowImageUrl;
  /** Banner image. TV size medium resolution (1280x720). */
  core.String bannerTvMediumImageUrl;
  /** The image map script for the large banner image. */
  LocalizedProperty largeBrandedBannerImageImapScript;
  /**
   * The URL for the 854px by 70px image that appears below the video player in
   * the expanded video view of the video watch page.
   */
  LocalizedProperty largeBrandedBannerImageUrl;
  /** The image map script for the small banner image. */
  LocalizedProperty smallBrandedBannerImageImapScript;
  /**
   * The URL for the 640px by 70px banner image that appears below the video
   * player in the default view of the video watch page.
   */
  LocalizedProperty smallBrandedBannerImageUrl;
  /**
   * The URL for a 1px by 1px tracking pixel that can be used to collect
   * statistics for views of the channel or video pages.
   */
  core.String trackingImageUrl;
  /**
   * The URL for the image that appears above the top-left corner of the video
   * player. This is a 25-pixel-high image with a flexible width that cannot
   * exceed 170 pixels.
   */
  core.String watchIconImageUrl;

  ImageSettings();

  ImageSettings.fromJson(core.Map _json) {
    if (_json.containsKey("backgroundImageUrl")) {
      backgroundImageUrl = new LocalizedProperty.fromJson(_json["backgroundImageUrl"]);
    }
    if (_json.containsKey("bannerExternalUrl")) {
      bannerExternalUrl = _json["bannerExternalUrl"];
    }
    if (_json.containsKey("bannerImageUrl")) {
      bannerImageUrl = _json["bannerImageUrl"];
    }
    if (_json.containsKey("bannerMobileExtraHdImageUrl")) {
      bannerMobileExtraHdImageUrl = _json["bannerMobileExtraHdImageUrl"];
    }
    if (_json.containsKey("bannerMobileHdImageUrl")) {
      bannerMobileHdImageUrl = _json["bannerMobileHdImageUrl"];
    }
    if (_json.containsKey("bannerMobileImageUrl")) {
      bannerMobileImageUrl = _json["bannerMobileImageUrl"];
    }
    if (_json.containsKey("bannerMobileLowImageUrl")) {
      bannerMobileLowImageUrl = _json["bannerMobileLowImageUrl"];
    }
    if (_json.containsKey("bannerMobileMediumHdImageUrl")) {
      bannerMobileMediumHdImageUrl = _json["bannerMobileMediumHdImageUrl"];
    }
    if (_json.containsKey("bannerTabletExtraHdImageUrl")) {
      bannerTabletExtraHdImageUrl = _json["bannerTabletExtraHdImageUrl"];
    }
    if (_json.containsKey("bannerTabletHdImageUrl")) {
      bannerTabletHdImageUrl = _json["bannerTabletHdImageUrl"];
    }
    if (_json.containsKey("bannerTabletImageUrl")) {
      bannerTabletImageUrl = _json["bannerTabletImageUrl"];
    }
    if (_json.containsKey("bannerTabletLowImageUrl")) {
      bannerTabletLowImageUrl = _json["bannerTabletLowImageUrl"];
    }
    if (_json.containsKey("bannerTvHighImageUrl")) {
      bannerTvHighImageUrl = _json["bannerTvHighImageUrl"];
    }
    if (_json.containsKey("bannerTvImageUrl")) {
      bannerTvImageUrl = _json["bannerTvImageUrl"];
    }
    if (_json.containsKey("bannerTvLowImageUrl")) {
      bannerTvLowImageUrl = _json["bannerTvLowImageUrl"];
    }
    if (_json.containsKey("bannerTvMediumImageUrl")) {
      bannerTvMediumImageUrl = _json["bannerTvMediumImageUrl"];
    }
    if (_json.containsKey("largeBrandedBannerImageImapScript")) {
      largeBrandedBannerImageImapScript = new LocalizedProperty.fromJson(_json["largeBrandedBannerImageImapScript"]);
    }
    if (_json.containsKey("largeBrandedBannerImageUrl")) {
      largeBrandedBannerImageUrl = new LocalizedProperty.fromJson(_json["largeBrandedBannerImageUrl"]);
    }
    if (_json.containsKey("smallBrandedBannerImageImapScript")) {
      smallBrandedBannerImageImapScript = new LocalizedProperty.fromJson(_json["smallBrandedBannerImageImapScript"]);
    }
    if (_json.containsKey("smallBrandedBannerImageUrl")) {
      smallBrandedBannerImageUrl = new LocalizedProperty.fromJson(_json["smallBrandedBannerImageUrl"]);
    }
    if (_json.containsKey("trackingImageUrl")) {
      trackingImageUrl = _json["trackingImageUrl"];
    }
    if (_json.containsKey("watchIconImageUrl")) {
      watchIconImageUrl = _json["watchIconImageUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (backgroundImageUrl != null) {
      _json["backgroundImageUrl"] = (backgroundImageUrl).toJson();
    }
    if (bannerExternalUrl != null) {
      _json["bannerExternalUrl"] = bannerExternalUrl;
    }
    if (bannerImageUrl != null) {
      _json["bannerImageUrl"] = bannerImageUrl;
    }
    if (bannerMobileExtraHdImageUrl != null) {
      _json["bannerMobileExtraHdImageUrl"] = bannerMobileExtraHdImageUrl;
    }
    if (bannerMobileHdImageUrl != null) {
      _json["bannerMobileHdImageUrl"] = bannerMobileHdImageUrl;
    }
    if (bannerMobileImageUrl != null) {
      _json["bannerMobileImageUrl"] = bannerMobileImageUrl;
    }
    if (bannerMobileLowImageUrl != null) {
      _json["bannerMobileLowImageUrl"] = bannerMobileLowImageUrl;
    }
    if (bannerMobileMediumHdImageUrl != null) {
      _json["bannerMobileMediumHdImageUrl"] = bannerMobileMediumHdImageUrl;
    }
    if (bannerTabletExtraHdImageUrl != null) {
      _json["bannerTabletExtraHdImageUrl"] = bannerTabletExtraHdImageUrl;
    }
    if (bannerTabletHdImageUrl != null) {
      _json["bannerTabletHdImageUrl"] = bannerTabletHdImageUrl;
    }
    if (bannerTabletImageUrl != null) {
      _json["bannerTabletImageUrl"] = bannerTabletImageUrl;
    }
    if (bannerTabletLowImageUrl != null) {
      _json["bannerTabletLowImageUrl"] = bannerTabletLowImageUrl;
    }
    if (bannerTvHighImageUrl != null) {
      _json["bannerTvHighImageUrl"] = bannerTvHighImageUrl;
    }
    if (bannerTvImageUrl != null) {
      _json["bannerTvImageUrl"] = bannerTvImageUrl;
    }
    if (bannerTvLowImageUrl != null) {
      _json["bannerTvLowImageUrl"] = bannerTvLowImageUrl;
    }
    if (bannerTvMediumImageUrl != null) {
      _json["bannerTvMediumImageUrl"] = bannerTvMediumImageUrl;
    }
    if (largeBrandedBannerImageImapScript != null) {
      _json["largeBrandedBannerImageImapScript"] = (largeBrandedBannerImageImapScript).toJson();
    }
    if (largeBrandedBannerImageUrl != null) {
      _json["largeBrandedBannerImageUrl"] = (largeBrandedBannerImageUrl).toJson();
    }
    if (smallBrandedBannerImageImapScript != null) {
      _json["smallBrandedBannerImageImapScript"] = (smallBrandedBannerImageImapScript).toJson();
    }
    if (smallBrandedBannerImageUrl != null) {
      _json["smallBrandedBannerImageUrl"] = (smallBrandedBannerImageUrl).toJson();
    }
    if (trackingImageUrl != null) {
      _json["trackingImageUrl"] = trackingImageUrl;
    }
    if (watchIconImageUrl != null) {
      _json["watchIconImageUrl"] = watchIconImageUrl;
    }
    return _json;
  }
}

/** Describes information necessary for ingesting an RTMP or an HTTP stream. */
class IngestionInfo {
  /**
   * The backup ingestion URL that you should use to stream video to YouTube.
   * You have the option of simultaneously streaming the content that you are
   * sending to the ingestionAddress to this URL.
   */
  core.String backupIngestionAddress;
  /**
   * The primary ingestion URL that you should use to stream video to YouTube.
   * You must stream video to this URL.
   *
   * Depending on which application or tool you use to encode your video stream,
   * you may need to enter the stream URL and stream name separately or you may
   * need to concatenate them in the following format:
   *
   * STREAM_URL/STREAM_NAME
   */
  core.String ingestionAddress;
  /** The HTTP or RTMP stream name that YouTube assigns to the video stream. */
  core.String streamName;

  IngestionInfo();

  IngestionInfo.fromJson(core.Map _json) {
    if (_json.containsKey("backupIngestionAddress")) {
      backupIngestionAddress = _json["backupIngestionAddress"];
    }
    if (_json.containsKey("ingestionAddress")) {
      ingestionAddress = _json["ingestionAddress"];
    }
    if (_json.containsKey("streamName")) {
      streamName = _json["streamName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (backupIngestionAddress != null) {
      _json["backupIngestionAddress"] = backupIngestionAddress;
    }
    if (ingestionAddress != null) {
      _json["ingestionAddress"] = ingestionAddress;
    }
    if (streamName != null) {
      _json["streamName"] = streamName;
    }
    return _json;
  }
}

class InvideoBranding {
  core.String imageBytes;
  core.List<core.int> get imageBytesAsBytes {
    return convert.BASE64.decode(imageBytes);
  }

  void set imageBytesAsBytes(core.List<core.int> _bytes) {
    imageBytes = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  core.String imageUrl;
  InvideoPosition position;
  core.String targetChannelId;
  InvideoTiming timing;

  InvideoBranding();

  InvideoBranding.fromJson(core.Map _json) {
    if (_json.containsKey("imageBytes")) {
      imageBytes = _json["imageBytes"];
    }
    if (_json.containsKey("imageUrl")) {
      imageUrl = _json["imageUrl"];
    }
    if (_json.containsKey("position")) {
      position = new InvideoPosition.fromJson(_json["position"]);
    }
    if (_json.containsKey("targetChannelId")) {
      targetChannelId = _json["targetChannelId"];
    }
    if (_json.containsKey("timing")) {
      timing = new InvideoTiming.fromJson(_json["timing"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (imageBytes != null) {
      _json["imageBytes"] = imageBytes;
    }
    if (imageUrl != null) {
      _json["imageUrl"] = imageUrl;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (targetChannelId != null) {
      _json["targetChannelId"] = targetChannelId;
    }
    if (timing != null) {
      _json["timing"] = (timing).toJson();
    }
    return _json;
  }
}

/**
 * Describes the spatial position of a visual widget inside a video. It is a
 * union of various position types, out of which only will be set one.
 */
class InvideoPosition {
  /**
   * Describes in which corner of the video the visual widget will appear.
   * Possible string values are:
   * - "bottomLeft"
   * - "bottomRight"
   * - "topLeft"
   * - "topRight"
   */
  core.String cornerPosition;
  /**
   * Defines the position type.
   * Possible string values are:
   * - "corner"
   */
  core.String type;

  InvideoPosition();

  InvideoPosition.fromJson(core.Map _json) {
    if (_json.containsKey("cornerPosition")) {
      cornerPosition = _json["cornerPosition"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cornerPosition != null) {
      _json["cornerPosition"] = cornerPosition;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Describes an invideo promotion campaign consisting of multiple promoted
 * items. A campaign belongs to a single channel_id.
 */
class InvideoPromotion {
  /**
   * The default temporal position within the video where the promoted item will
   * be displayed. Can be overriden by more specific timing in the item.
   */
  InvideoTiming defaultTiming;
  /** List of promoted items in decreasing priority. */
  core.List<PromotedItem> items;
  /**
   * The spatial position within the video where the promoted item will be
   * displayed.
   */
  InvideoPosition position;
  /**
   * Indicates whether the channel's promotional campaign uses "smart timing."
   * This feature attempts to show promotions at a point in the video when they
   * are more likely to be clicked and less likely to disrupt the viewing
   * experience. This feature also picks up a single promotion to show on each
   * video.
   */
  core.bool useSmartTiming;

  InvideoPromotion();

  InvideoPromotion.fromJson(core.Map _json) {
    if (_json.containsKey("defaultTiming")) {
      defaultTiming = new InvideoTiming.fromJson(_json["defaultTiming"]);
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PromotedItem.fromJson(value)).toList();
    }
    if (_json.containsKey("position")) {
      position = new InvideoPosition.fromJson(_json["position"]);
    }
    if (_json.containsKey("useSmartTiming")) {
      useSmartTiming = _json["useSmartTiming"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (defaultTiming != null) {
      _json["defaultTiming"] = (defaultTiming).toJson();
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    if (useSmartTiming != null) {
      _json["useSmartTiming"] = useSmartTiming;
    }
    return _json;
  }
}

/** Describes a temporal position of a visual widget inside a video. */
class InvideoTiming {
  /**
   * Defines the duration in milliseconds for which the promotion should be
   * displayed. If missing, the client should use the default.
   */
  core.String durationMs;
  /**
   * Defines the time at which the promotion will appear. Depending on the value
   * of type the value of the offsetMs field will represent a time offset from
   * the start or from the end of the video, expressed in milliseconds.
   */
  core.String offsetMs;
  /**
   * Describes a timing type. If the value is offsetFromStart, then the offsetMs
   * field represents an offset from the start of the video. If the value is
   * offsetFromEnd, then the offsetMs field represents an offset from the end of
   * the video.
   * Possible string values are:
   * - "offsetFromEnd"
   * - "offsetFromStart"
   */
  core.String type;

  InvideoTiming();

  InvideoTiming.fromJson(core.Map _json) {
    if (_json.containsKey("durationMs")) {
      durationMs = _json["durationMs"];
    }
    if (_json.containsKey("offsetMs")) {
      offsetMs = _json["offsetMs"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (durationMs != null) {
      _json["durationMs"] = durationMs;
    }
    if (offsetMs != null) {
      _json["offsetMs"] = offsetMs;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class LanguageTag {
  core.String value;

  LanguageTag();

  LanguageTag.fromJson(core.Map _json) {
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * A liveBroadcast resource represents an event that will be streamed, via live
 * video, on YouTube.
 */
class LiveBroadcast {
  /**
   * The contentDetails object contains information about the event's video
   * content, such as whether the content can be shown in an embedded video
   * player or if it will be archived and therefore available for viewing after
   * the event has concluded.
   */
  LiveBroadcastContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the broadcast. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveBroadcast".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the event, including its
   * title, description, start time, and end time.
   */
  LiveBroadcastSnippet snippet;
  /**
   * The statistics object contains info about the event's current stats. These
   * include concurrent viewers and total chat count. Statistics can change (in
   * either direction) during the lifetime of an event. Statistics are only
   * returned while the event is live.
   */
  LiveBroadcastStatistics statistics;
  /** The status object contains information about the event's status. */
  LiveBroadcastStatus status;
  LiveBroadcastTopicDetails topicDetails;

  LiveBroadcast();

  LiveBroadcast.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new LiveBroadcastContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new LiveBroadcastSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("statistics")) {
      statistics = new LiveBroadcastStatistics.fromJson(_json["statistics"]);
    }
    if (_json.containsKey("status")) {
      status = new LiveBroadcastStatus.fromJson(_json["status"]);
    }
    if (_json.containsKey("topicDetails")) {
      topicDetails = new LiveBroadcastTopicDetails.fromJson(_json["topicDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (topicDetails != null) {
      _json["topicDetails"] = (topicDetails).toJson();
    }
    return _json;
  }
}

/** Detailed settings of a broadcast. */
class LiveBroadcastContentDetails {
  /** This value uniquely identifies the live stream bound to the broadcast. */
  core.String boundStreamId;
  /**
   * The date and time that the live stream referenced by boundStreamId was last
   * updated.
   */
  core.DateTime boundStreamLastUpdateTimeMs;
  /**
   *
   * Possible string values are:
   * - "closedCaptionsDisabled"
   * - "closedCaptionsEmbedded"
   * - "closedCaptionsHttpPost"
   */
  core.String closedCaptionsType;
  /**
   * This setting indicates whether HTTP POST closed captioning is enabled for
   * this broadcast. The ingestion URL of the closed captions is returned
   * through the liveStreams API. This is mutually exclusive with using the
   * closed_captions_type property, and is equivalent to setting
   * closed_captions_type to CLOSED_CAPTIONS_HTTP_POST.
   */
  core.bool enableClosedCaptions;
  /**
   * This setting indicates whether YouTube should enable content encryption for
   * the broadcast.
   */
  core.bool enableContentEncryption;
  /**
   * This setting determines whether viewers can access DVR controls while
   * watching the video. DVR controls enable the viewer to control the video
   * playback experience by pausing, rewinding, or fast forwarding content. The
   * default value for this property is true.
   *
   *
   *
   * Important: You must set the value to true and also set the enableArchive
   * property's value to true if you want to make playback available immediately
   * after the broadcast ends.
   */
  core.bool enableDvr;
  /**
   * This setting indicates whether the broadcast video can be played in an
   * embedded player. If you choose to archive the video (using the
   * enableArchive property), this setting will also apply to the archived
   * video.
   */
  core.bool enableEmbed;
  /** Indicates whether this broadcast has low latency enabled. */
  core.bool enableLowLatency;
  /**
   * The monitorStream object contains information about the monitor stream,
   * which the broadcaster can use to review the event content before the
   * broadcast stream is shown publicly.
   */
  MonitorStreamInfo monitorStream;
  /**
   * The projection format of this broadcast. This defaults to rectangular.
   * Possible string values are:
   * - "360"
   * - "rectangular"
   */
  core.String projection;
  /**
   * Automatically start recording after the event goes live. The default value
   * for this property is true.
   *
   *
   *
   * Important: You must also set the enableDvr property's value to true if you
   * want the playback to be available immediately after the broadcast ends. If
   * you set this property's value to true but do not also set the enableDvr
   * property to true, there may be a delay of around one day before the
   * archived video will be available for playback.
   */
  core.bool recordFromStart;
  /**
   * This setting indicates whether the broadcast should automatically begin
   * with an in-stream slate when you update the broadcast's status to live.
   * After updating the status, you then need to send a liveCuepoints.insert
   * request that sets the cuepoint's eventState to end to remove the in-stream
   * slate and make your broadcast stream visible to viewers.
   */
  core.bool startWithSlate;

  LiveBroadcastContentDetails();

  LiveBroadcastContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("boundStreamId")) {
      boundStreamId = _json["boundStreamId"];
    }
    if (_json.containsKey("boundStreamLastUpdateTimeMs")) {
      boundStreamLastUpdateTimeMs = core.DateTime.parse(_json["boundStreamLastUpdateTimeMs"]);
    }
    if (_json.containsKey("closedCaptionsType")) {
      closedCaptionsType = _json["closedCaptionsType"];
    }
    if (_json.containsKey("enableClosedCaptions")) {
      enableClosedCaptions = _json["enableClosedCaptions"];
    }
    if (_json.containsKey("enableContentEncryption")) {
      enableContentEncryption = _json["enableContentEncryption"];
    }
    if (_json.containsKey("enableDvr")) {
      enableDvr = _json["enableDvr"];
    }
    if (_json.containsKey("enableEmbed")) {
      enableEmbed = _json["enableEmbed"];
    }
    if (_json.containsKey("enableLowLatency")) {
      enableLowLatency = _json["enableLowLatency"];
    }
    if (_json.containsKey("monitorStream")) {
      monitorStream = new MonitorStreamInfo.fromJson(_json["monitorStream"]);
    }
    if (_json.containsKey("projection")) {
      projection = _json["projection"];
    }
    if (_json.containsKey("recordFromStart")) {
      recordFromStart = _json["recordFromStart"];
    }
    if (_json.containsKey("startWithSlate")) {
      startWithSlate = _json["startWithSlate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundStreamId != null) {
      _json["boundStreamId"] = boundStreamId;
    }
    if (boundStreamLastUpdateTimeMs != null) {
      _json["boundStreamLastUpdateTimeMs"] = (boundStreamLastUpdateTimeMs).toIso8601String();
    }
    if (closedCaptionsType != null) {
      _json["closedCaptionsType"] = closedCaptionsType;
    }
    if (enableClosedCaptions != null) {
      _json["enableClosedCaptions"] = enableClosedCaptions;
    }
    if (enableContentEncryption != null) {
      _json["enableContentEncryption"] = enableContentEncryption;
    }
    if (enableDvr != null) {
      _json["enableDvr"] = enableDvr;
    }
    if (enableEmbed != null) {
      _json["enableEmbed"] = enableEmbed;
    }
    if (enableLowLatency != null) {
      _json["enableLowLatency"] = enableLowLatency;
    }
    if (monitorStream != null) {
      _json["monitorStream"] = (monitorStream).toJson();
    }
    if (projection != null) {
      _json["projection"] = projection;
    }
    if (recordFromStart != null) {
      _json["recordFromStart"] = recordFromStart;
    }
    if (startWithSlate != null) {
      _json["startWithSlate"] = startWithSlate;
    }
    return _json;
  }
}

class LiveBroadcastListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of broadcasts that match the request criteria. */
  core.List<LiveBroadcast> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveBroadcastListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  LiveBroadcastListResponse();

  LiveBroadcastListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveBroadcast.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class LiveBroadcastSnippet {
  /**
   * The date and time that the broadcast actually ended. This information is
   * only available once the broadcast's state is complete. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime actualEndTime;
  /**
   * The date and time that the broadcast actually started. This information is
   * only available once the broadcast's state is live. The value is specified
   * in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime actualStartTime;
  /**
   * The ID that YouTube uses to uniquely identify the channel that is
   * publishing the broadcast.
   */
  core.String channelId;
  /**
   * The broadcast's description. As with the title, you can set this field by
   * modifying the broadcast resource or by setting the description field of the
   * corresponding video resource.
   */
  core.String description;
  core.bool isDefaultBroadcast;
  /** The id of the live chat for this broadcast. */
  core.String liveChatId;
  /**
   * The date and time that the broadcast was added to YouTube's live broadcast
   * schedule. The value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ)
   * format.
   */
  core.DateTime publishedAt;
  /**
   * The date and time that the broadcast is scheduled to end. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime scheduledEndTime;
  /**
   * The date and time that the broadcast is scheduled to start. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime scheduledStartTime;
  /**
   * A map of thumbnail images associated with the broadcast. For each nested
   * object in this object, the key is the name of the thumbnail image, and the
   * value is an object that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /**
   * The broadcast's title. Note that the broadcast represents exactly one
   * YouTube video. You can set this field by modifying the broadcast resource
   * or by setting the title field of the corresponding video resource.
   */
  core.String title;

  LiveBroadcastSnippet();

  LiveBroadcastSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("actualEndTime")) {
      actualEndTime = core.DateTime.parse(_json["actualEndTime"]);
    }
    if (_json.containsKey("actualStartTime")) {
      actualStartTime = core.DateTime.parse(_json["actualStartTime"]);
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("isDefaultBroadcast")) {
      isDefaultBroadcast = _json["isDefaultBroadcast"];
    }
    if (_json.containsKey("liveChatId")) {
      liveChatId = _json["liveChatId"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("scheduledEndTime")) {
      scheduledEndTime = core.DateTime.parse(_json["scheduledEndTime"]);
    }
    if (_json.containsKey("scheduledStartTime")) {
      scheduledStartTime = core.DateTime.parse(_json["scheduledStartTime"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (actualEndTime != null) {
      _json["actualEndTime"] = (actualEndTime).toIso8601String();
    }
    if (actualStartTime != null) {
      _json["actualStartTime"] = (actualStartTime).toIso8601String();
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (isDefaultBroadcast != null) {
      _json["isDefaultBroadcast"] = isDefaultBroadcast;
    }
    if (liveChatId != null) {
      _json["liveChatId"] = liveChatId;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (scheduledEndTime != null) {
      _json["scheduledEndTime"] = (scheduledEndTime).toIso8601String();
    }
    if (scheduledStartTime != null) {
      _json["scheduledStartTime"] = (scheduledStartTime).toIso8601String();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * Statistics about the live broadcast. These represent a snapshot of the values
 * at the time of the request. Statistics are only returned for live broadcasts.
 */
class LiveBroadcastStatistics {
  /**
   * The number of viewers currently watching the broadcast. The property and
   * its value will be present if the broadcast has current viewers and the
   * broadcast owner has not hidden the viewcount for the video. Note that
   * YouTube stops tracking the number of concurrent viewers for a broadcast
   * when the broadcast ends. So, this property would not identify the number of
   * viewers watching an archived video of a live broadcast that already ended.
   */
  core.String concurrentViewers;
  /**
   * The total number of live chat messages currently on the broadcast. The
   * property and its value will be present if the broadcast is public, has the
   * live chat feature enabled, and has at least one message. Note that this
   * field will not be filled after the broadcast ends. So this property would
   * not identify the number of chat messages for an archived video of a
   * completed live broadcast.
   */
  core.String totalChatCount;

  LiveBroadcastStatistics();

  LiveBroadcastStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("concurrentViewers")) {
      concurrentViewers = _json["concurrentViewers"];
    }
    if (_json.containsKey("totalChatCount")) {
      totalChatCount = _json["totalChatCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (concurrentViewers != null) {
      _json["concurrentViewers"] = concurrentViewers;
    }
    if (totalChatCount != null) {
      _json["totalChatCount"] = totalChatCount;
    }
    return _json;
  }
}

class LiveBroadcastStatus {
  /**
   * The broadcast's status. The status can be updated using the API's
   * liveBroadcasts.transition method.
   * Possible string values are:
   * - "abandoned"
   * - "complete"
   * - "completeStarting"
   * - "created"
   * - "live"
   * - "liveStarting"
   * - "ready"
   * - "reclaimed"
   * - "revoked"
   * - "testStarting"
   * - "testing"
   */
  core.String lifeCycleStatus;
  /**
   * Priority of the live broadcast event (internal state).
   * Possible string values are:
   * - "high"
   * - "low"
   * - "normal"
   */
  core.String liveBroadcastPriority;
  /**
   * The broadcast's privacy status. Note that the broadcast represents exactly
   * one YouTube video, so the privacy settings are identical to those supported
   * for videos. In addition, you can set this field by modifying the broadcast
   * resource or by setting the privacyStatus field of the corresponding video
   * resource.
   * Possible string values are:
   * - "private"
   * - "public"
   * - "unlisted"
   */
  core.String privacyStatus;
  /**
   * The broadcast's recording status.
   * Possible string values are:
   * - "notRecording"
   * - "recorded"
   * - "recording"
   */
  core.String recordingStatus;

  LiveBroadcastStatus();

  LiveBroadcastStatus.fromJson(core.Map _json) {
    if (_json.containsKey("lifeCycleStatus")) {
      lifeCycleStatus = _json["lifeCycleStatus"];
    }
    if (_json.containsKey("liveBroadcastPriority")) {
      liveBroadcastPriority = _json["liveBroadcastPriority"];
    }
    if (_json.containsKey("privacyStatus")) {
      privacyStatus = _json["privacyStatus"];
    }
    if (_json.containsKey("recordingStatus")) {
      recordingStatus = _json["recordingStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lifeCycleStatus != null) {
      _json["lifeCycleStatus"] = lifeCycleStatus;
    }
    if (liveBroadcastPriority != null) {
      _json["liveBroadcastPriority"] = liveBroadcastPriority;
    }
    if (privacyStatus != null) {
      _json["privacyStatus"] = privacyStatus;
    }
    if (recordingStatus != null) {
      _json["recordingStatus"] = recordingStatus;
    }
    return _json;
  }
}

class LiveBroadcastTopic {
  /** Information about the topic matched. */
  LiveBroadcastTopicSnippet snippet;
  /**
   * The type of the topic.
   * Possible string values are:
   * - "videoGame"
   */
  core.String type;
  /**
   * If this flag is set it means that we have not been able to match the topic
   * title and type provided to a known entity.
   */
  core.bool unmatched;

  LiveBroadcastTopic();

  LiveBroadcastTopic.fromJson(core.Map _json) {
    if (_json.containsKey("snippet")) {
      snippet = new LiveBroadcastTopicSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("unmatched")) {
      unmatched = _json["unmatched"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (unmatched != null) {
      _json["unmatched"] = unmatched;
    }
    return _json;
  }
}

class LiveBroadcastTopicDetails {
  core.List<LiveBroadcastTopic> topics;

  LiveBroadcastTopicDetails();

  LiveBroadcastTopicDetails.fromJson(core.Map _json) {
    if (_json.containsKey("topics")) {
      topics = _json["topics"].map((value) => new LiveBroadcastTopic.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (topics != null) {
      _json["topics"] = topics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LiveBroadcastTopicSnippet {
  /** The name of the topic. */
  core.String name;
  /** The date at which the topic was released. Filled for types: videoGame */
  core.String releaseDate;

  LiveBroadcastTopicSnippet();

  LiveBroadcastTopicSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("releaseDate")) {
      releaseDate = _json["releaseDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (releaseDate != null) {
      _json["releaseDate"] = releaseDate;
    }
    return _json;
  }
}

/** A liveChatBan resource represents a ban for a YouTube live chat. */
class LiveChatBan {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the ban. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveChatBan".
   */
  core.String kind;
  /** The snippet object contains basic details about the ban. */
  LiveChatBanSnippet snippet;

  LiveChatBan();

  LiveChatBan.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new LiveChatBanSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class LiveChatBanSnippet {
  /** The duration of a ban, only filled if the ban has type TEMPORARY. */
  core.String banDurationSeconds;
  ChannelProfileDetails bannedUserDetails;
  /** The chat this ban is pertinent to. */
  core.String liveChatId;
  /**
   * The type of ban.
   * Possible string values are:
   * - "permanent"
   * - "temporary"
   */
  core.String type;

  LiveChatBanSnippet();

  LiveChatBanSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("banDurationSeconds")) {
      banDurationSeconds = _json["banDurationSeconds"];
    }
    if (_json.containsKey("bannedUserDetails")) {
      bannedUserDetails = new ChannelProfileDetails.fromJson(_json["bannedUserDetails"]);
    }
    if (_json.containsKey("liveChatId")) {
      liveChatId = _json["liveChatId"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (banDurationSeconds != null) {
      _json["banDurationSeconds"] = banDurationSeconds;
    }
    if (bannedUserDetails != null) {
      _json["bannedUserDetails"] = (bannedUserDetails).toJson();
    }
    if (liveChatId != null) {
      _json["liveChatId"] = liveChatId;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class LiveChatFanFundingEventDetails {
  /**
   * A rendered string that displays the fund amount and currency to the user.
   */
  core.String amountDisplayString;
  /** The amount of the fund. */
  core.String amountMicros;
  /** The currency in which the fund was made. */
  core.String currency;
  /** The comment added by the user to this fan funding event. */
  core.String userComment;

  LiveChatFanFundingEventDetails();

  LiveChatFanFundingEventDetails.fromJson(core.Map _json) {
    if (_json.containsKey("amountDisplayString")) {
      amountDisplayString = _json["amountDisplayString"];
    }
    if (_json.containsKey("amountMicros")) {
      amountMicros = _json["amountMicros"];
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("userComment")) {
      userComment = _json["userComment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountDisplayString != null) {
      _json["amountDisplayString"] = amountDisplayString;
    }
    if (amountMicros != null) {
      _json["amountMicros"] = amountMicros;
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (userComment != null) {
      _json["userComment"] = userComment;
    }
    return _json;
  }
}

/**
 * A liveChatMessage resource represents a chat message in a YouTube Live Chat.
 */
class LiveChatMessage {
  /**
   * The authorDetails object contains basic details about the user that posted
   * this message.
   */
  LiveChatMessageAuthorDetails authorDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the message. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveChatMessage".
   */
  core.String kind;
  /** The snippet object contains basic details about the message. */
  LiveChatMessageSnippet snippet;

  LiveChatMessage();

  LiveChatMessage.fromJson(core.Map _json) {
    if (_json.containsKey("authorDetails")) {
      authorDetails = new LiveChatMessageAuthorDetails.fromJson(_json["authorDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new LiveChatMessageSnippet.fromJson(_json["snippet"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorDetails != null) {
      _json["authorDetails"] = (authorDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class LiveChatMessageAuthorDetails {
  /** The YouTube channel ID. */
  core.String channelId;
  /** The channel's URL. */
  core.String channelUrl;
  /** The channel's display name. */
  core.String displayName;
  /** Whether the author is a moderator of the live chat. */
  core.bool isChatModerator;
  /** Whether the author is the owner of the live chat. */
  core.bool isChatOwner;
  /** Whether the author is a sponsor of the live chat. */
  core.bool isChatSponsor;
  /** Whether the author's identity has been verified by YouTube. */
  core.bool isVerified;
  /** The channels's avatar URL. */
  core.String profileImageUrl;

  LiveChatMessageAuthorDetails();

  LiveChatMessageAuthorDetails.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelUrl")) {
      channelUrl = _json["channelUrl"];
    }
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("isChatModerator")) {
      isChatModerator = _json["isChatModerator"];
    }
    if (_json.containsKey("isChatOwner")) {
      isChatOwner = _json["isChatOwner"];
    }
    if (_json.containsKey("isChatSponsor")) {
      isChatSponsor = _json["isChatSponsor"];
    }
    if (_json.containsKey("isVerified")) {
      isVerified = _json["isVerified"];
    }
    if (_json.containsKey("profileImageUrl")) {
      profileImageUrl = _json["profileImageUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelUrl != null) {
      _json["channelUrl"] = channelUrl;
    }
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    if (isChatModerator != null) {
      _json["isChatModerator"] = isChatModerator;
    }
    if (isChatOwner != null) {
      _json["isChatOwner"] = isChatOwner;
    }
    if (isChatSponsor != null) {
      _json["isChatSponsor"] = isChatSponsor;
    }
    if (isVerified != null) {
      _json["isVerified"] = isVerified;
    }
    if (profileImageUrl != null) {
      _json["profileImageUrl"] = profileImageUrl;
    }
    return _json;
  }
}

class LiveChatMessageDeletedDetails {
  core.String deletedMessageId;

  LiveChatMessageDeletedDetails();

  LiveChatMessageDeletedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("deletedMessageId")) {
      deletedMessageId = _json["deletedMessageId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deletedMessageId != null) {
      _json["deletedMessageId"] = deletedMessageId;
    }
    return _json;
  }
}

class LiveChatMessageListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of live chat messages. */
  core.List<LiveChatMessage> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveChatMessageListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  /**
   * The date and time when the underlying stream went offline. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime offlineAt;
  PageInfo pageInfo;
  /** The amount of time the client should wait before polling again. */
  core.int pollingIntervalMillis;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  LiveChatMessageListResponse();

  LiveChatMessageListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveChatMessage.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("offlineAt")) {
      offlineAt = core.DateTime.parse(_json["offlineAt"]);
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("pollingIntervalMillis")) {
      pollingIntervalMillis = _json["pollingIntervalMillis"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (offlineAt != null) {
      _json["offlineAt"] = (offlineAt).toIso8601String();
    }
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (pollingIntervalMillis != null) {
      _json["pollingIntervalMillis"] = pollingIntervalMillis;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class LiveChatMessageRetractedDetails {
  core.String retractedMessageId;

  LiveChatMessageRetractedDetails();

  LiveChatMessageRetractedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("retractedMessageId")) {
      retractedMessageId = _json["retractedMessageId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (retractedMessageId != null) {
      _json["retractedMessageId"] = retractedMessageId;
    }
    return _json;
  }
}

class LiveChatMessageSnippet {
  /**
   * The ID of the user that authored this message, this field is not always
   * filled. textMessageEvent - the user that wrote the message fanFundingEvent
   * - the user that funded the broadcast newSponsorEvent - the user that just
   * became a sponsor messageDeletedEvent - the moderator that took the action
   * messageRetractedEvent - the author that retracted their message
   * userBannedEvent - the moderator that took the action superChatEvent - the
   * user that made the purchase
   */
  core.String authorChannelId;
  /**
   * Contains a string that can be displayed to the user. If this field is not
   * present the message is silent, at the moment only messages of type
   * TOMBSTONE and CHAT_ENDED_EVENT are silent.
   */
  core.String displayMessage;
  /**
   * Details about the funding event, this is only set if the type is
   * 'fanFundingEvent'.
   */
  LiveChatFanFundingEventDetails fanFundingEventDetails;
  /**
   * Whether the message has display content that should be displayed to users.
   */
  core.bool hasDisplayContent;
  core.String liveChatId;
  LiveChatMessageDeletedDetails messageDeletedDetails;
  LiveChatMessageRetractedDetails messageRetractedDetails;
  LiveChatPollClosedDetails pollClosedDetails;
  LiveChatPollEditedDetails pollEditedDetails;
  LiveChatPollOpenedDetails pollOpenedDetails;
  LiveChatPollVotedDetails pollVotedDetails;
  /**
   * The date and time when the message was orignally published. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * Details about the Super Chat event, this is only set if the type is
   * 'superChatEvent'.
   */
  LiveChatSuperChatDetails superChatDetails;
  /**
   * Details about the text message, this is only set if the type is
   * 'textMessageEvent'.
   */
  LiveChatTextMessageDetails textMessageDetails;
  /**
   * The type of message, this will always be present, it determines the
   * contents of the message as well as which fields will be present.
   * Possible string values are:
   * - "chatEndedEvent"
   * - "fanFundingEvent"
   * - "messageDeletedEvent"
   * - "messageRetractedEvent"
   * - "newSponsorEvent"
   * - "pollClosedEvent"
   * - "pollEditedEvent"
   * - "pollOpenedEvent"
   * - "pollVotedEvent"
   * - "sponsorOnlyModeEndedEvent"
   * - "sponsorOnlyModeStartedEvent"
   * - "superChatEvent"
   * - "textMessageEvent"
   * - "tombstone"
   * - "userBannedEvent"
   */
  core.String type;
  LiveChatUserBannedMessageDetails userBannedDetails;

  LiveChatMessageSnippet();

  LiveChatMessageSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("authorChannelId")) {
      authorChannelId = _json["authorChannelId"];
    }
    if (_json.containsKey("displayMessage")) {
      displayMessage = _json["displayMessage"];
    }
    if (_json.containsKey("fanFundingEventDetails")) {
      fanFundingEventDetails = new LiveChatFanFundingEventDetails.fromJson(_json["fanFundingEventDetails"]);
    }
    if (_json.containsKey("hasDisplayContent")) {
      hasDisplayContent = _json["hasDisplayContent"];
    }
    if (_json.containsKey("liveChatId")) {
      liveChatId = _json["liveChatId"];
    }
    if (_json.containsKey("messageDeletedDetails")) {
      messageDeletedDetails = new LiveChatMessageDeletedDetails.fromJson(_json["messageDeletedDetails"]);
    }
    if (_json.containsKey("messageRetractedDetails")) {
      messageRetractedDetails = new LiveChatMessageRetractedDetails.fromJson(_json["messageRetractedDetails"]);
    }
    if (_json.containsKey("pollClosedDetails")) {
      pollClosedDetails = new LiveChatPollClosedDetails.fromJson(_json["pollClosedDetails"]);
    }
    if (_json.containsKey("pollEditedDetails")) {
      pollEditedDetails = new LiveChatPollEditedDetails.fromJson(_json["pollEditedDetails"]);
    }
    if (_json.containsKey("pollOpenedDetails")) {
      pollOpenedDetails = new LiveChatPollOpenedDetails.fromJson(_json["pollOpenedDetails"]);
    }
    if (_json.containsKey("pollVotedDetails")) {
      pollVotedDetails = new LiveChatPollVotedDetails.fromJson(_json["pollVotedDetails"]);
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("superChatDetails")) {
      superChatDetails = new LiveChatSuperChatDetails.fromJson(_json["superChatDetails"]);
    }
    if (_json.containsKey("textMessageDetails")) {
      textMessageDetails = new LiveChatTextMessageDetails.fromJson(_json["textMessageDetails"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("userBannedDetails")) {
      userBannedDetails = new LiveChatUserBannedMessageDetails.fromJson(_json["userBannedDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (authorChannelId != null) {
      _json["authorChannelId"] = authorChannelId;
    }
    if (displayMessage != null) {
      _json["displayMessage"] = displayMessage;
    }
    if (fanFundingEventDetails != null) {
      _json["fanFundingEventDetails"] = (fanFundingEventDetails).toJson();
    }
    if (hasDisplayContent != null) {
      _json["hasDisplayContent"] = hasDisplayContent;
    }
    if (liveChatId != null) {
      _json["liveChatId"] = liveChatId;
    }
    if (messageDeletedDetails != null) {
      _json["messageDeletedDetails"] = (messageDeletedDetails).toJson();
    }
    if (messageRetractedDetails != null) {
      _json["messageRetractedDetails"] = (messageRetractedDetails).toJson();
    }
    if (pollClosedDetails != null) {
      _json["pollClosedDetails"] = (pollClosedDetails).toJson();
    }
    if (pollEditedDetails != null) {
      _json["pollEditedDetails"] = (pollEditedDetails).toJson();
    }
    if (pollOpenedDetails != null) {
      _json["pollOpenedDetails"] = (pollOpenedDetails).toJson();
    }
    if (pollVotedDetails != null) {
      _json["pollVotedDetails"] = (pollVotedDetails).toJson();
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (superChatDetails != null) {
      _json["superChatDetails"] = (superChatDetails).toJson();
    }
    if (textMessageDetails != null) {
      _json["textMessageDetails"] = (textMessageDetails).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (userBannedDetails != null) {
      _json["userBannedDetails"] = (userBannedDetails).toJson();
    }
    return _json;
  }
}

/**
 * A liveChatModerator resource represents a moderator for a YouTube live chat.
 * A chat moderator has the ability to ban/unban users from a chat, remove
 * message, etc.
 */
class LiveChatModerator {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the moderator. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveChatModerator".
   */
  core.String kind;
  /** The snippet object contains basic details about the moderator. */
  LiveChatModeratorSnippet snippet;

  LiveChatModerator();

  LiveChatModerator.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new LiveChatModeratorSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class LiveChatModeratorListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of moderators that match the request criteria. */
  core.List<LiveChatModerator> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveChatModeratorListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  LiveChatModeratorListResponse();

  LiveChatModeratorListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveChatModerator.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class LiveChatModeratorSnippet {
  /** The ID of the live chat this moderator can act on. */
  core.String liveChatId;
  /** Details about the moderator. */
  ChannelProfileDetails moderatorDetails;

  LiveChatModeratorSnippet();

  LiveChatModeratorSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("liveChatId")) {
      liveChatId = _json["liveChatId"];
    }
    if (_json.containsKey("moderatorDetails")) {
      moderatorDetails = new ChannelProfileDetails.fromJson(_json["moderatorDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (liveChatId != null) {
      _json["liveChatId"] = liveChatId;
    }
    if (moderatorDetails != null) {
      _json["moderatorDetails"] = (moderatorDetails).toJson();
    }
    return _json;
  }
}

class LiveChatPollClosedDetails {
  /** The id of the poll that was closed. */
  core.String pollId;

  LiveChatPollClosedDetails();

  LiveChatPollClosedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("pollId")) {
      pollId = _json["pollId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pollId != null) {
      _json["pollId"] = pollId;
    }
    return _json;
  }
}

class LiveChatPollEditedDetails {
  core.String id;
  core.List<LiveChatPollItem> items;
  core.String prompt;

  LiveChatPollEditedDetails();

  LiveChatPollEditedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveChatPollItem.fromJson(value)).toList();
    }
    if (_json.containsKey("prompt")) {
      prompt = _json["prompt"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (prompt != null) {
      _json["prompt"] = prompt;
    }
    return _json;
  }
}

class LiveChatPollItem {
  /** Plain text description of the item. */
  core.String description;
  core.String itemId;

  LiveChatPollItem();

  LiveChatPollItem.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    return _json;
  }
}

class LiveChatPollOpenedDetails {
  core.String id;
  core.List<LiveChatPollItem> items;
  core.String prompt;

  LiveChatPollOpenedDetails();

  LiveChatPollOpenedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveChatPollItem.fromJson(value)).toList();
    }
    if (_json.containsKey("prompt")) {
      prompt = _json["prompt"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (prompt != null) {
      _json["prompt"] = prompt;
    }
    return _json;
  }
}

class LiveChatPollVotedDetails {
  /** The poll item the user chose. */
  core.String itemId;
  /** The poll the user voted on. */
  core.String pollId;

  LiveChatPollVotedDetails();

  LiveChatPollVotedDetails.fromJson(core.Map _json) {
    if (_json.containsKey("itemId")) {
      itemId = _json["itemId"];
    }
    if (_json.containsKey("pollId")) {
      pollId = _json["pollId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (itemId != null) {
      _json["itemId"] = itemId;
    }
    if (pollId != null) {
      _json["pollId"] = pollId;
    }
    return _json;
  }
}

class LiveChatSuperChatDetails {
  /**
   * A rendered string that displays the fund amount and currency to the user.
   */
  core.String amountDisplayString;
  /** The amount purchased by the user, in micros (1,750,000 micros = 1.75). */
  core.String amountMicros;
  /** The currency in which the purchase was made. */
  core.String currency;
  /**
   * The tier in which the amount belongs to. Lower amounts belong to lower
   * tiers. Starts at 1.
   */
  core.int tier;
  /** The comment added by the user to this Super Chat event. */
  core.String userComment;

  LiveChatSuperChatDetails();

  LiveChatSuperChatDetails.fromJson(core.Map _json) {
    if (_json.containsKey("amountDisplayString")) {
      amountDisplayString = _json["amountDisplayString"];
    }
    if (_json.containsKey("amountMicros")) {
      amountMicros = _json["amountMicros"];
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("tier")) {
      tier = _json["tier"];
    }
    if (_json.containsKey("userComment")) {
      userComment = _json["userComment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountDisplayString != null) {
      _json["amountDisplayString"] = amountDisplayString;
    }
    if (amountMicros != null) {
      _json["amountMicros"] = amountMicros;
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (tier != null) {
      _json["tier"] = tier;
    }
    if (userComment != null) {
      _json["userComment"] = userComment;
    }
    return _json;
  }
}

class LiveChatTextMessageDetails {
  /** The user's message. */
  core.String messageText;

  LiveChatTextMessageDetails();

  LiveChatTextMessageDetails.fromJson(core.Map _json) {
    if (_json.containsKey("messageText")) {
      messageText = _json["messageText"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (messageText != null) {
      _json["messageText"] = messageText;
    }
    return _json;
  }
}

class LiveChatUserBannedMessageDetails {
  /**
   * The duration of the ban. This property is only present if the banType is
   * temporary.
   */
  core.String banDurationSeconds;
  /**
   * The type of ban.
   * Possible string values are:
   * - "permanent"
   * - "temporary"
   */
  core.String banType;
  /** The details of the user that was banned. */
  ChannelProfileDetails bannedUserDetails;

  LiveChatUserBannedMessageDetails();

  LiveChatUserBannedMessageDetails.fromJson(core.Map _json) {
    if (_json.containsKey("banDurationSeconds")) {
      banDurationSeconds = _json["banDurationSeconds"];
    }
    if (_json.containsKey("banType")) {
      banType = _json["banType"];
    }
    if (_json.containsKey("bannedUserDetails")) {
      bannedUserDetails = new ChannelProfileDetails.fromJson(_json["bannedUserDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (banDurationSeconds != null) {
      _json["banDurationSeconds"] = banDurationSeconds;
    }
    if (banType != null) {
      _json["banType"] = banType;
    }
    if (bannedUserDetails != null) {
      _json["bannedUserDetails"] = (bannedUserDetails).toJson();
    }
    return _json;
  }
}

/** A live stream describes a live ingestion point. */
class LiveStream {
  /**
   * The cdn object defines the live stream's content delivery network (CDN)
   * settings. These settings provide details about the manner in which you
   * stream your content to YouTube.
   */
  CdnSettings cdn;
  /**
   * The content_details object contains information about the stream, including
   * the closed captions ingestion URL.
   */
  LiveStreamContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the stream. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveStream".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the stream, including its
   * channel, title, and description.
   */
  LiveStreamSnippet snippet;
  /** The status object contains information about live stream's status. */
  LiveStreamStatus status;

  LiveStream();

  LiveStream.fromJson(core.Map _json) {
    if (_json.containsKey("cdn")) {
      cdn = new CdnSettings.fromJson(_json["cdn"]);
    }
    if (_json.containsKey("contentDetails")) {
      contentDetails = new LiveStreamContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new LiveStreamSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("status")) {
      status = new LiveStreamStatus.fromJson(_json["status"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cdn != null) {
      _json["cdn"] = (cdn).toJson();
    }
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

class LiveStreamConfigurationIssue {
  /** The long-form description of the issue and how to resolve it. */
  core.String description;
  /** The short-form reason for this issue. */
  core.String reason;
  /**
   * How severe this issue is to the stream.
   * Possible string values are:
   * - "error"
   * - "info"
   * - "warning"
   */
  core.String severity;
  /**
   * The kind of error happening.
   * Possible string values are:
   * - "audioBitrateHigh"
   * - "audioBitrateLow"
   * - "audioBitrateMismatch"
   * - "audioCodec"
   * - "audioCodecMismatch"
   * - "audioSampleRate"
   * - "audioSampleRateMismatch"
   * - "audioStereoMismatch"
   * - "audioTooManyChannels"
   * - "badContainer"
   * - "bitrateHigh"
   * - "bitrateLow"
   * - "frameRateHigh"
   * - "framerateMismatch"
   * - "gopMismatch"
   * - "gopSizeLong"
   * - "gopSizeOver"
   * - "gopSizeShort"
   * - "interlacedVideo"
   * - "multipleAudioStreams"
   * - "multipleVideoStreams"
   * - "noAudioStream"
   * - "noVideoStream"
   * - "openGop"
   * - "resolutionMismatch"
   * - "videoBitrateMismatch"
   * - "videoCodec"
   * - "videoCodecMismatch"
   * - "videoIngestionStarved"
   * - "videoInterlaceMismatch"
   * - "videoProfileMismatch"
   * - "videoResolutionSuboptimal"
   * - "videoResolutionUnsupported"
   */
  core.String type;

  LiveStreamConfigurationIssue();

  LiveStreamConfigurationIssue.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("severity")) {
      severity = _json["severity"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (severity != null) {
      _json["severity"] = severity;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Detailed settings of a stream. */
class LiveStreamContentDetails {
  /** The ingestion URL where the closed captions of this stream are sent. */
  core.String closedCaptionsIngestionUrl;
  /**
   * Indicates whether the stream is reusable, which means that it can be bound
   * to multiple broadcasts. It is common for broadcasters to reuse the same
   * stream for many different broadcasts if those broadcasts occur at different
   * times.
   *
   * If you set this value to false, then the stream will not be reusable, which
   * means that it can only be bound to one broadcast. Non-reusable streams
   * differ from reusable streams in the following ways:
   * - A non-reusable stream can only be bound to one broadcast.
   * - A non-reusable stream might be deleted by an automated process after the
   * broadcast ends.
   * - The  liveStreams.list method does not list non-reusable streams if you
   * call the method and set the mine parameter to true. The only way to use
   * that method to retrieve the resource for a non-reusable stream is to use
   * the id parameter to identify the stream.
   */
  core.bool isReusable;

  LiveStreamContentDetails();

  LiveStreamContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("closedCaptionsIngestionUrl")) {
      closedCaptionsIngestionUrl = _json["closedCaptionsIngestionUrl"];
    }
    if (_json.containsKey("isReusable")) {
      isReusable = _json["isReusable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (closedCaptionsIngestionUrl != null) {
      _json["closedCaptionsIngestionUrl"] = closedCaptionsIngestionUrl;
    }
    if (isReusable != null) {
      _json["isReusable"] = isReusable;
    }
    return _json;
  }
}

class LiveStreamHealthStatus {
  /** The configurations issues on this stream */
  core.List<LiveStreamConfigurationIssue> configurationIssues;
  /** The last time this status was updated (in seconds) */
  core.String lastUpdateTimeSeconds;
  /**
   * The status code of this stream
   * Possible string values are:
   * - "bad"
   * - "good"
   * - "noData"
   * - "ok"
   * - "revoked"
   */
  core.String status;

  LiveStreamHealthStatus();

  LiveStreamHealthStatus.fromJson(core.Map _json) {
    if (_json.containsKey("configurationIssues")) {
      configurationIssues = _json["configurationIssues"].map((value) => new LiveStreamConfigurationIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("lastUpdateTimeSeconds")) {
      lastUpdateTimeSeconds = _json["lastUpdateTimeSeconds"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (configurationIssues != null) {
      _json["configurationIssues"] = configurationIssues.map((value) => (value).toJson()).toList();
    }
    if (lastUpdateTimeSeconds != null) {
      _json["lastUpdateTimeSeconds"] = lastUpdateTimeSeconds;
    }
    if (status != null) {
      _json["status"] = status;
    }
    return _json;
  }
}

class LiveStreamListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of live streams that match the request criteria. */
  core.List<LiveStream> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#liveStreamListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  LiveStreamListResponse();

  LiveStreamListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new LiveStream.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class LiveStreamSnippet {
  /**
   * The ID that YouTube uses to uniquely identify the channel that is
   * transmitting the stream.
   */
  core.String channelId;
  /**
   * The stream's description. The value cannot be longer than 10000 characters.
   */
  core.String description;
  core.bool isDefaultStream;
  /**
   * The date and time that the stream was created. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * The stream's title. The value must be between 1 and 128 characters long.
   */
  core.String title;

  LiveStreamSnippet();

  LiveStreamSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("isDefaultStream")) {
      isDefaultStream = _json["isDefaultStream"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (isDefaultStream != null) {
      _json["isDefaultStream"] = isDefaultStream;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Brief description of the live stream status. */
class LiveStreamStatus {
  /** The health status of the stream. */
  LiveStreamHealthStatus healthStatus;
  /**
   *
   * Possible string values are:
   * - "active"
   * - "created"
   * - "error"
   * - "inactive"
   * - "ready"
   */
  core.String streamStatus;

  LiveStreamStatus();

  LiveStreamStatus.fromJson(core.Map _json) {
    if (_json.containsKey("healthStatus")) {
      healthStatus = new LiveStreamHealthStatus.fromJson(_json["healthStatus"]);
    }
    if (_json.containsKey("streamStatus")) {
      streamStatus = _json["streamStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (healthStatus != null) {
      _json["healthStatus"] = (healthStatus).toJson();
    }
    if (streamStatus != null) {
      _json["streamStatus"] = streamStatus;
    }
    return _json;
  }
}

class LocalizedProperty {
  core.String default_;
  /** The language of the default property. */
  LanguageTag defaultLanguage;
  core.List<LocalizedString> localized;

  LocalizedProperty();

  LocalizedProperty.fromJson(core.Map _json) {
    if (_json.containsKey("default")) {
      default_ = _json["default"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = new LanguageTag.fromJson(_json["defaultLanguage"]);
    }
    if (_json.containsKey("localized")) {
      localized = _json["localized"].map((value) => new LocalizedString.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (default_ != null) {
      _json["default"] = default_;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = (defaultLanguage).toJson();
    }
    if (localized != null) {
      _json["localized"] = localized.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class LocalizedString {
  core.String language;
  core.String value;

  LocalizedString();

  LocalizedString.fromJson(core.Map _json) {
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (language != null) {
      _json["language"] = language;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/** Settings and Info of the monitor stream */
class MonitorStreamInfo {
  /**
   * If you have set the enableMonitorStream property to true, then this
   * property determines the length of the live broadcast delay.
   */
  core.int broadcastStreamDelayMs;
  /** HTML code that embeds a player that plays the monitor stream. */
  core.String embedHtml;
  /**
   * This value determines whether the monitor stream is enabled for the
   * broadcast. If the monitor stream is enabled, then YouTube will broadcast
   * the event content on a special stream intended only for the broadcaster's
   * consumption. The broadcaster can use the stream to review the event content
   * and also to identify the optimal times to insert cuepoints.
   *
   * You need to set this value to true if you intend to have a broadcast delay
   * for your event.
   *
   * Note: This property cannot be updated once the broadcast is in the testing
   * or live state.
   */
  core.bool enableMonitorStream;

  MonitorStreamInfo();

  MonitorStreamInfo.fromJson(core.Map _json) {
    if (_json.containsKey("broadcastStreamDelayMs")) {
      broadcastStreamDelayMs = _json["broadcastStreamDelayMs"];
    }
    if (_json.containsKey("embedHtml")) {
      embedHtml = _json["embedHtml"];
    }
    if (_json.containsKey("enableMonitorStream")) {
      enableMonitorStream = _json["enableMonitorStream"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (broadcastStreamDelayMs != null) {
      _json["broadcastStreamDelayMs"] = broadcastStreamDelayMs;
    }
    if (embedHtml != null) {
      _json["embedHtml"] = embedHtml;
    }
    if (enableMonitorStream != null) {
      _json["enableMonitorStream"] = enableMonitorStream;
    }
    return _json;
  }
}

/**
 * Paging details for lists of resources, including total number of items
 * available and number of resources returned in a single page.
 */
class PageInfo {
  /** The number of results included in the API response. */
  core.int resultsPerPage;
  /** The total number of results in the result set. */
  core.int totalResults;

  PageInfo();

  PageInfo.fromJson(core.Map _json) {
    if (_json.containsKey("resultsPerPage")) {
      resultsPerPage = _json["resultsPerPage"];
    }
    if (_json.containsKey("totalResults")) {
      totalResults = _json["totalResults"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (resultsPerPage != null) {
      _json["resultsPerPage"] = resultsPerPage;
    }
    if (totalResults != null) {
      _json["totalResults"] = totalResults;
    }
    return _json;
  }
}

/**
 * A playlist resource represents a YouTube playlist. A playlist is a collection
 * of videos that can be viewed sequentially and shared with other users. A
 * playlist can contain up to 200 videos, and YouTube does not limit the number
 * of playlists that each user creates. By default, playlists are publicly
 * visible to other users, but playlists can be public or private.
 *
 * YouTube also uses playlists to identify special collections of videos for a
 * channel, such as:
 * - uploaded videos
 * - favorite videos
 * - positively rated (liked) videos
 * - watch history
 * - watch later  To be more specific, these lists are associated with a
 * channel, which is a collection of a person, group, or company's videos,
 * playlists, and other YouTube information. You can retrieve the playlist IDs
 * for each of these lists from the  channel resource for a given channel.
 *
 * You can then use the   playlistItems.list method to retrieve any of those
 * lists. You can also add or remove items from those lists by calling the
 * playlistItems.insert and   playlistItems.delete methods.
 */
class Playlist {
  /** The contentDetails object contains information like video count. */
  PlaylistContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the playlist. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#playlist".
   */
  core.String kind;
  /** Localizations for different languages */
  core.Map<core.String, PlaylistLocalization> localizations;
  /**
   * The player object contains information that you would use to play the
   * playlist in an embedded player.
   */
  PlaylistPlayer player;
  /**
   * The snippet object contains basic details about the playlist, such as its
   * title and description.
   */
  PlaylistSnippet snippet;
  /** The status object contains status information for the playlist. */
  PlaylistStatus status;

  Playlist();

  Playlist.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new PlaylistContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("localizations")) {
      localizations = commons.mapMap(_json["localizations"], (item) => new PlaylistLocalization.fromJson(item));
    }
    if (_json.containsKey("player")) {
      player = new PlaylistPlayer.fromJson(_json["player"]);
    }
    if (_json.containsKey("snippet")) {
      snippet = new PlaylistSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("status")) {
      status = new PlaylistStatus.fromJson(_json["status"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (localizations != null) {
      _json["localizations"] = commons.mapMap(localizations, (item) => (item).toJson());
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

class PlaylistContentDetails {
  /** The number of videos in the playlist. */
  core.int itemCount;

  PlaylistContentDetails();

  PlaylistContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("itemCount")) {
      itemCount = _json["itemCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (itemCount != null) {
      _json["itemCount"] = itemCount;
    }
    return _json;
  }
}

/**
 * A playlistItem resource identifies another resource, such as a video, that is
 * included in a playlist. In addition, the playlistItem  resource contains
 * details about the included resource that pertain specifically to how that
 * resource is used in that playlist.
 *
 * YouTube uses playlists to identify special collections of videos for a
 * channel, such as:
 * - uploaded videos
 * - favorite videos
 * - positively rated (liked) videos
 * - watch history
 * - watch later  To be more specific, these lists are associated with a
 * channel, which is a collection of a person, group, or company's videos,
 * playlists, and other YouTube information.
 *
 * You can retrieve the playlist IDs for each of these lists from the  channel
 * resource  for a given channel. You can then use the   playlistItems.list
 * method to retrieve any of those lists. You can also add or remove items from
 * those lists by calling the   playlistItems.insert and   playlistItems.delete
 * methods. For example, if a user gives a positive rating to a video, you would
 * insert that video into the liked videos playlist for that user's channel.
 */
class PlaylistItem {
  /**
   * The contentDetails object is included in the resource if the included item
   * is a YouTube video. The object contains additional information about the
   * video.
   */
  PlaylistItemContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the playlist item. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#playlistItem".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the playlist item, such as
   * its title and position in the playlist.
   */
  PlaylistItemSnippet snippet;
  /**
   * The status object contains information about the playlist item's privacy
   * status.
   */
  PlaylistItemStatus status;

  PlaylistItem();

  PlaylistItem.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new PlaylistItemContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new PlaylistItemSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("status")) {
      status = new PlaylistItemStatus.fromJson(_json["status"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

class PlaylistItemContentDetails {
  /**
   * The time, measured in seconds from the start of the video, when the video
   * should stop playing. (The playlist owner can specify the times when the
   * video should start and stop playing when the video is played in the context
   * of the playlist.) By default, assume that the video.endTime is the end of
   * the video.
   */
  core.String endAt;
  /** A user-generated note for this item. */
  core.String note;
  /**
   * The time, measured in seconds from the start of the video, when the video
   * should start playing. (The playlist owner can specify the times when the
   * video should start and stop playing when the video is played in the context
   * of the playlist.) The default value is 0.
   */
  core.String startAt;
  /**
   * The ID that YouTube uses to uniquely identify a video. To retrieve the
   * video resource, set the id query parameter to this value in your API
   * request.
   */
  core.String videoId;
  /**
   * The date and time that the video was published to YouTube. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime videoPublishedAt;

  PlaylistItemContentDetails();

  PlaylistItemContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("endAt")) {
      endAt = _json["endAt"];
    }
    if (_json.containsKey("note")) {
      note = _json["note"];
    }
    if (_json.containsKey("startAt")) {
      startAt = _json["startAt"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
    if (_json.containsKey("videoPublishedAt")) {
      videoPublishedAt = core.DateTime.parse(_json["videoPublishedAt"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endAt != null) {
      _json["endAt"] = endAt;
    }
    if (note != null) {
      _json["note"] = note;
    }
    if (startAt != null) {
      _json["startAt"] = startAt;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    if (videoPublishedAt != null) {
      _json["videoPublishedAt"] = (videoPublishedAt).toIso8601String();
    }
    return _json;
  }
}

class PlaylistItemListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of playlist items that match the request criteria. */
  core.List<PlaylistItem> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#playlistItemListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  PlaylistItemListResponse();

  PlaylistItemListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PlaylistItem.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * Basic details about a playlist, including title, description and thumbnails.
 */
class PlaylistItemSnippet {
  /**
   * The ID that YouTube uses to uniquely identify the user that added the item
   * to the playlist.
   */
  core.String channelId;
  /** Channel title for the channel that the playlist item belongs to. */
  core.String channelTitle;
  /** The item's description. */
  core.String description;
  /**
   * The ID that YouTube uses to uniquely identify the playlist that the
   * playlist item is in.
   */
  core.String playlistId;
  /**
   * The order in which the item appears in the playlist. The value uses a
   * zero-based index, so the first item has a position of 0, the second item
   * has a position of 1, and so forth.
   */
  core.int position;
  /**
   * The date and time that the item was added to the playlist. The value is
   * specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * The id object contains information that can be used to uniquely identify
   * the resource that is included in the playlist as the playlist item.
   */
  ResourceId resourceId;
  /**
   * A map of thumbnail images associated with the playlist item. For each
   * object in the map, the key is the name of the thumbnail image, and the
   * value is an object that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The item's title. */
  core.String title;

  PlaylistItemSnippet();

  PlaylistItemSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("playlistId")) {
      playlistId = _json["playlistId"];
    }
    if (_json.containsKey("position")) {
      position = _json["position"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (playlistId != null) {
      _json["playlistId"] = playlistId;
    }
    if (position != null) {
      _json["position"] = position;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Information about the playlist item's privacy status. */
class PlaylistItemStatus {
  /**
   * This resource's privacy status.
   * Possible string values are:
   * - "private"
   * - "public"
   * - "unlisted"
   */
  core.String privacyStatus;

  PlaylistItemStatus();

  PlaylistItemStatus.fromJson(core.Map _json) {
    if (_json.containsKey("privacyStatus")) {
      privacyStatus = _json["privacyStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (privacyStatus != null) {
      _json["privacyStatus"] = privacyStatus;
    }
    return _json;
  }
}

class PlaylistListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of playlists that match the request criteria. */
  core.List<Playlist> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#playlistListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  PlaylistListResponse();

  PlaylistListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Playlist.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Playlist localization setting */
class PlaylistLocalization {
  /** The localized strings for playlist's description. */
  core.String description;
  /** The localized strings for playlist's title. */
  core.String title;

  PlaylistLocalization();

  PlaylistLocalization.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class PlaylistPlayer {
  /** An <iframe> tag that embeds a player that will play the playlist. */
  core.String embedHtml;

  PlaylistPlayer();

  PlaylistPlayer.fromJson(core.Map _json) {
    if (_json.containsKey("embedHtml")) {
      embedHtml = _json["embedHtml"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (embedHtml != null) {
      _json["embedHtml"] = embedHtml;
    }
    return _json;
  }
}

/**
 * Basic details about a playlist, including title, description and thumbnails.
 */
class PlaylistSnippet {
  /**
   * The ID that YouTube uses to uniquely identify the channel that published
   * the playlist.
   */
  core.String channelId;
  /** The channel title of the channel that the video belongs to. */
  core.String channelTitle;
  /** The language of the playlist's default title and description. */
  core.String defaultLanguage;
  /** The playlist's description. */
  core.String description;
  /** Localized title and description, read-only. */
  PlaylistLocalization localized;
  /**
   * The date and time that the playlist was created. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /** Keyword tags associated with the playlist. */
  core.List<core.String> tags;
  /**
   * A map of thumbnail images associated with the playlist. For each object in
   * the map, the key is the name of the thumbnail image, and the value is an
   * object that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The playlist's title. */
  core.String title;

  PlaylistSnippet();

  PlaylistSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("localized")) {
      localized = new PlaylistLocalization.fromJson(_json["localized"]);
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("tags")) {
      tags = _json["tags"];
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (localized != null) {
      _json["localized"] = (localized).toJson();
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (tags != null) {
      _json["tags"] = tags;
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class PlaylistStatus {
  /**
   * The playlist's privacy status.
   * Possible string values are:
   * - "private"
   * - "public"
   * - "unlisted"
   */
  core.String privacyStatus;

  PlaylistStatus();

  PlaylistStatus.fromJson(core.Map _json) {
    if (_json.containsKey("privacyStatus")) {
      privacyStatus = _json["privacyStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (privacyStatus != null) {
      _json["privacyStatus"] = privacyStatus;
    }
    return _json;
  }
}

/** Describes a single promoted item. */
class PromotedItem {
  /**
   * A custom message to display for this promotion. This field is currently
   * ignored unless the promoted item is a website.
   */
  core.String customMessage;
  /** Identifies the promoted item. */
  PromotedItemId id;
  /**
   * If true, the content owner's name will be used when displaying the
   * promotion. This field can only be set when the update is made on behalf of
   * the content owner.
   */
  core.bool promotedByContentOwner;
  /**
   * The temporal position within the video where the promoted item will be
   * displayed. If present, it overrides the default timing.
   */
  InvideoTiming timing;

  PromotedItem();

  PromotedItem.fromJson(core.Map _json) {
    if (_json.containsKey("customMessage")) {
      customMessage = _json["customMessage"];
    }
    if (_json.containsKey("id")) {
      id = new PromotedItemId.fromJson(_json["id"]);
    }
    if (_json.containsKey("promotedByContentOwner")) {
      promotedByContentOwner = _json["promotedByContentOwner"];
    }
    if (_json.containsKey("timing")) {
      timing = new InvideoTiming.fromJson(_json["timing"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customMessage != null) {
      _json["customMessage"] = customMessage;
    }
    if (id != null) {
      _json["id"] = (id).toJson();
    }
    if (promotedByContentOwner != null) {
      _json["promotedByContentOwner"] = promotedByContentOwner;
    }
    if (timing != null) {
      _json["timing"] = (timing).toJson();
    }
    return _json;
  }
}

/**
 * Describes a single promoted item id. It is a union of various possible types.
 */
class PromotedItemId {
  /**
   * If type is recentUpload, this field identifies the channel from which to
   * take the recent upload. If missing, the channel is assumed to be the same
   * channel for which the invideoPromotion is set.
   */
  core.String recentlyUploadedBy;
  /**
   * Describes the type of the promoted item.
   * Possible string values are:
   * - "recentUpload"
   * - "video"
   * - "website"
   */
  core.String type;
  /**
   * If the promoted item represents a video, this field represents the unique
   * YouTube ID identifying it. This field will be present only if type has the
   * value video.
   */
  core.String videoId;
  /**
   * If the promoted item represents a website, this field represents the url
   * pointing to the website. This field will be present only if type has the
   * value website.
   */
  core.String websiteUrl;

  PromotedItemId();

  PromotedItemId.fromJson(core.Map _json) {
    if (_json.containsKey("recentlyUploadedBy")) {
      recentlyUploadedBy = _json["recentlyUploadedBy"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
    if (_json.containsKey("websiteUrl")) {
      websiteUrl = _json["websiteUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (recentlyUploadedBy != null) {
      _json["recentlyUploadedBy"] = recentlyUploadedBy;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    if (websiteUrl != null) {
      _json["websiteUrl"] = websiteUrl;
    }
    return _json;
  }
}

/** A pair Property / Value. */
class PropertyValue {
  /** A property. */
  core.String property;
  /** The property's value. */
  core.String value;

  PropertyValue();

  PropertyValue.fromJson(core.Map _json) {
    if (_json.containsKey("property")) {
      property = _json["property"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (property != null) {
      _json["property"] = property;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

/**
 * A resource id is a generic reference that points to another YouTube resource.
 */
class ResourceId {
  /**
   * The ID that YouTube uses to uniquely identify the referred resource, if
   * that resource is a channel. This property is only present if the
   * resourceId.kind value is youtube#channel.
   */
  core.String channelId;
  /** The type of the API resource. */
  core.String kind;
  /**
   * The ID that YouTube uses to uniquely identify the referred resource, if
   * that resource is a playlist. This property is only present if the
   * resourceId.kind value is youtube#playlist.
   */
  core.String playlistId;
  /**
   * The ID that YouTube uses to uniquely identify the referred resource, if
   * that resource is a video. This property is only present if the
   * resourceId.kind value is youtube#video.
   */
  core.String videoId;

  ResourceId();

  ResourceId.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("playlistId")) {
      playlistId = _json["playlistId"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (playlistId != null) {
      _json["playlistId"] = playlistId;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

class SearchListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of results that match the search criteria. */
  core.List<SearchResult> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#searchListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  core.String regionCode;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  SearchListResponse();

  SearchListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new SearchResult.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("regionCode")) {
      regionCode = _json["regionCode"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (regionCode != null) {
      _json["regionCode"] = regionCode;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * A search result contains information about a YouTube video, channel, or
 * playlist that matches the search parameters specified in an API request.
 * While a search result points to a uniquely identifiable resource, like a
 * video, it does not have its own persistent data.
 */
class SearchResult {
  /** Etag of this resource. */
  core.String etag;
  /**
   * The id object contains information that can be used to uniquely identify
   * the resource that matches the search request.
   */
  ResourceId id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#searchResult".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about a search result, such as
   * its title or description. For example, if the search result is a video,
   * then the title will be the video's title and the description will be the
   * video's description.
   */
  SearchResultSnippet snippet;

  SearchResult();

  SearchResult.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = new ResourceId.fromJson(_json["id"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new SearchResultSnippet.fromJson(_json["snippet"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = (id).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

/**
 * Basic details about a search result, including title, description and
 * thumbnails of the item referenced by the search result.
 */
class SearchResultSnippet {
  /**
   * The value that YouTube uses to uniquely identify the channel that published
   * the resource that the search result identifies.
   */
  core.String channelId;
  /**
   * The title of the channel that published the resource that the search result
   * identifies.
   */
  core.String channelTitle;
  /** A description of the search result. */
  core.String description;
  /**
   * It indicates if the resource (video or channel) has upcoming/active live
   * broadcast content. Or it's "none" if there is not any upcoming/active live
   * broadcasts.
   * Possible string values are:
   * - "live"
   * - "none"
   * - "upcoming"
   */
  core.String liveBroadcastContent;
  /**
   * The creation date and time of the resource that the search result
   * identifies. The value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ)
   * format.
   */
  core.DateTime publishedAt;
  /**
   * A map of thumbnail images associated with the search result. For each
   * object in the map, the key is the name of the thumbnail image, and the
   * value is an object that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The title of the search result. */
  core.String title;

  SearchResultSnippet();

  SearchResultSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("liveBroadcastContent")) {
      liveBroadcastContent = _json["liveBroadcastContent"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (liveBroadcastContent != null) {
      _json["liveBroadcastContent"] = liveBroadcastContent;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * A sponsor resource represents a sponsor for a YouTube channel. A sponsor
 * provides recurring monetary support to a creator and receives special
 * benefits.
 */
class Sponsor {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the sponsor. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#sponsor".
   */
  core.String kind;
  /** The snippet object contains basic details about the sponsor. */
  SponsorSnippet snippet;

  Sponsor();

  Sponsor.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new SponsorSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class SponsorListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of sponsors that match the request criteria. */
  core.List<Sponsor> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#sponsorListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  SponsorListResponse();

  SponsorListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Sponsor.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class SponsorSnippet {
  /** The id of the channel being sponsored. */
  core.String channelId;
  /** Details about the sponsor. */
  ChannelProfileDetails sponsorDetails;
  /**
   * The date and time when the user became a sponsor. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime sponsorSince;

  SponsorSnippet();

  SponsorSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("sponsorDetails")) {
      sponsorDetails = new ChannelProfileDetails.fromJson(_json["sponsorDetails"]);
    }
    if (_json.containsKey("sponsorSince")) {
      sponsorSince = core.DateTime.parse(_json["sponsorSince"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (sponsorDetails != null) {
      _json["sponsorDetails"] = (sponsorDetails).toJson();
    }
    if (sponsorSince != null) {
      _json["sponsorSince"] = (sponsorSince).toIso8601String();
    }
    return _json;
  }
}

/**
 * A subscription resource contains information about a YouTube user
 * subscription. A subscription notifies a user when new videos are added to a
 * channel or when another user takes one of several actions on YouTube, such as
 * uploading a video, rating a video, or commenting on a video.
 */
class Subscription {
  /**
   * The contentDetails object contains basic statistics about the subscription.
   */
  SubscriptionContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the subscription. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#subscription".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the subscription, including
   * its title and the channel that the user subscribed to.
   */
  SubscriptionSnippet snippet;
  /**
   * The subscriberSnippet object contains basic details about the sbuscriber.
   */
  SubscriptionSubscriberSnippet subscriberSnippet;

  Subscription();

  Subscription.fromJson(core.Map _json) {
    if (_json.containsKey("contentDetails")) {
      contentDetails = new SubscriptionContentDetails.fromJson(_json["contentDetails"]);
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
    if (_json.containsKey("snippet")) {
      snippet = new SubscriptionSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("subscriberSnippet")) {
      subscriberSnippet = new SubscriptionSubscriberSnippet.fromJson(_json["subscriberSnippet"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
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
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (subscriberSnippet != null) {
      _json["subscriberSnippet"] = (subscriberSnippet).toJson();
    }
    return _json;
  }
}

/** Details about the content to witch a subscription refers. */
class SubscriptionContentDetails {
  /**
   * The type of activity this subscription is for (only uploads, everything).
   * Possible string values are:
   * - "all"
   * - "uploads"
   */
  core.String activityType;
  /**
   * The number of new items in the subscription since its content was last
   * read.
   */
  core.int newItemCount;
  /** The approximate number of items that the subscription points to. */
  core.int totalItemCount;

  SubscriptionContentDetails();

  SubscriptionContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("activityType")) {
      activityType = _json["activityType"];
    }
    if (_json.containsKey("newItemCount")) {
      newItemCount = _json["newItemCount"];
    }
    if (_json.containsKey("totalItemCount")) {
      totalItemCount = _json["totalItemCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activityType != null) {
      _json["activityType"] = activityType;
    }
    if (newItemCount != null) {
      _json["newItemCount"] = newItemCount;
    }
    if (totalItemCount != null) {
      _json["totalItemCount"] = totalItemCount;
    }
    return _json;
  }
}

class SubscriptionListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of subscriptions that match the request criteria. */
  core.List<Subscription> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#subscriptionListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  SubscriptionListResponse();

  SubscriptionListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Subscription.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/**
 * Basic details about a subscription, including title, description and
 * thumbnails of the subscribed item.
 */
class SubscriptionSnippet {
  /**
   * The ID that YouTube uses to uniquely identify the subscriber's channel.
   */
  core.String channelId;
  /** Channel title for the channel that the subscription belongs to. */
  core.String channelTitle;
  /** The subscription's details. */
  core.String description;
  /**
   * The date and time that the subscription was created. The value is specified
   * in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * The id object contains information about the channel that the user
   * subscribed to.
   */
  ResourceId resourceId;
  /**
   * A map of thumbnail images associated with the video. For each object in the
   * map, the key is the name of the thumbnail image, and the value is an object
   * that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The subscription's title. */
  core.String title;

  SubscriptionSnippet();

  SubscriptionSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("resourceId")) {
      resourceId = new ResourceId.fromJson(_json["resourceId"]);
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (resourceId != null) {
      _json["resourceId"] = (resourceId).toJson();
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * Basic details about a subscription's subscriber including title, description,
 * channel ID and thumbnails.
 */
class SubscriptionSubscriberSnippet {
  /** The channel ID of the subscriber. */
  core.String channelId;
  /** The description of the subscriber. */
  core.String description;
  /** Thumbnails for this subscriber. */
  ThumbnailDetails thumbnails;
  /** The title of the subscriber. */
  core.String title;

  SubscriptionSubscriberSnippet();

  SubscriptionSubscriberSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * A superChatEvent resource represents a Super Chat purchase on a YouTube
 * channel.
 */
class SuperChatEvent {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube assigns to uniquely identify the Super Chat event. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#superChatEvent".
   */
  core.String kind;
  /** The snippet object contains basic details about the Super Chat event. */
  SuperChatEventSnippet snippet;

  SuperChatEvent();

  SuperChatEvent.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new SuperChatEventSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class SuperChatEventListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of Super Chat purchases that match the request criteria. */
  core.List<SuperChatEvent> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#superChatEventListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  SuperChatEventListResponse();

  SuperChatEventListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new SuperChatEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class SuperChatEventSnippet {
  /**
   * The purchase amount, in micros of the purchase currency. e.g., 1 is
   * represented as 1000000.
   */
  core.String amountMicros;
  /** Channel id where the event occurred. */
  core.String channelId;
  /** The text contents of the comment left by the user. */
  core.String commentText;
  /**
   * The date and time when the event occurred. The value is specified in ISO
   * 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime createdAt;
  /** The currency in which the purchase was made. ISO 4217. */
  core.String currency;
  /**
   * A rendered string that displays the purchase amount and currency (e.g.,
   * "$1.00"). The string is rendered for the given language.
   */
  core.String displayString;
  /**
   * The tier for the paid message, which is based on the amount of money spent
   * to purchase the message.
   */
  core.int messageType;
  /** Details about the supporter. */
  ChannelProfileDetails supporterDetails;

  SuperChatEventSnippet();

  SuperChatEventSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("amountMicros")) {
      amountMicros = _json["amountMicros"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("commentText")) {
      commentText = _json["commentText"];
    }
    if (_json.containsKey("createdAt")) {
      createdAt = core.DateTime.parse(_json["createdAt"]);
    }
    if (_json.containsKey("currency")) {
      currency = _json["currency"];
    }
    if (_json.containsKey("displayString")) {
      displayString = _json["displayString"];
    }
    if (_json.containsKey("messageType")) {
      messageType = _json["messageType"];
    }
    if (_json.containsKey("supporterDetails")) {
      supporterDetails = new ChannelProfileDetails.fromJson(_json["supporterDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountMicros != null) {
      _json["amountMicros"] = amountMicros;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (commentText != null) {
      _json["commentText"] = commentText;
    }
    if (createdAt != null) {
      _json["createdAt"] = (createdAt).toIso8601String();
    }
    if (currency != null) {
      _json["currency"] = currency;
    }
    if (displayString != null) {
      _json["displayString"] = displayString;
    }
    if (messageType != null) {
      _json["messageType"] = messageType;
    }
    if (supporterDetails != null) {
      _json["supporterDetails"] = (supporterDetails).toJson();
    }
    return _json;
  }
}

/** A thumbnail is an image representing a YouTube resource. */
class Thumbnail {
  /** (Optional) Height of the thumbnail image. */
  core.int height;
  /** The thumbnail image's URL. */
  core.String url;
  /** (Optional) Width of the thumbnail image. */
  core.int width;

  Thumbnail();

  Thumbnail.fromJson(core.Map _json) {
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

/** Internal representation of thumbnails for a YouTube resource. */
class ThumbnailDetails {
  /** The default image for this resource. */
  Thumbnail default_;
  /** The high quality image for this resource. */
  Thumbnail high;
  /** The maximum resolution quality image for this resource. */
  Thumbnail maxres;
  /** The medium quality image for this resource. */
  Thumbnail medium;
  /** The standard quality image for this resource. */
  Thumbnail standard;

  ThumbnailDetails();

  ThumbnailDetails.fromJson(core.Map _json) {
    if (_json.containsKey("default")) {
      default_ = new Thumbnail.fromJson(_json["default"]);
    }
    if (_json.containsKey("high")) {
      high = new Thumbnail.fromJson(_json["high"]);
    }
    if (_json.containsKey("maxres")) {
      maxres = new Thumbnail.fromJson(_json["maxres"]);
    }
    if (_json.containsKey("medium")) {
      medium = new Thumbnail.fromJson(_json["medium"]);
    }
    if (_json.containsKey("standard")) {
      standard = new Thumbnail.fromJson(_json["standard"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (default_ != null) {
      _json["default"] = (default_).toJson();
    }
    if (high != null) {
      _json["high"] = (high).toJson();
    }
    if (maxres != null) {
      _json["maxres"] = (maxres).toJson();
    }
    if (medium != null) {
      _json["medium"] = (medium).toJson();
    }
    if (standard != null) {
      _json["standard"] = (standard).toJson();
    }
    return _json;
  }
}

class ThumbnailSetResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of thumbnails. */
  core.List<ThumbnailDetails> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#thumbnailSetResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  ThumbnailSetResponse();

  ThumbnailSetResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ThumbnailDetails.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Stub token pagination template to suppress results. */
class TokenPagination {

  TokenPagination();

  TokenPagination.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** A video resource represents a YouTube video. */
class Video {
  /**
   * Age restriction details related to a video. This data can only be retrieved
   * by the video owner.
   */
  VideoAgeGating ageGating;
  /**
   * The contentDetails object contains information about the video content,
   * including the length of the video and its aspect ratio.
   */
  VideoContentDetails contentDetails;
  /** Etag of this resource. */
  core.String etag;
  /**
   * The fileDetails object encapsulates information about the video file that
   * was uploaded to YouTube, including the file's resolution, duration, audio
   * and video codecs, stream bitrates, and more. This data can only be
   * retrieved by the video owner.
   */
  VideoFileDetails fileDetails;
  /** The ID that YouTube uses to uniquely identify the video. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#video".
   */
  core.String kind;
  /**
   * The liveStreamingDetails object contains metadata about a live video
   * broadcast. The object will only be present in a video resource if the video
   * is an upcoming, live, or completed live broadcast.
   */
  VideoLiveStreamingDetails liveStreamingDetails;
  /** List with all localizations. */
  core.Map<core.String, VideoLocalization> localizations;
  /**
   * The monetizationDetails object encapsulates information about the
   * monetization status of the video.
   */
  VideoMonetizationDetails monetizationDetails;
  /**
   * The player object contains information that you would use to play the video
   * in an embedded player.
   */
  VideoPlayer player;
  /**
   * The processingProgress object encapsulates information about YouTube's
   * progress in processing the uploaded video file. The properties in the
   * object identify the current processing status and an estimate of the time
   * remaining until YouTube finishes processing the video. This part also
   * indicates whether different types of data or content, such as file details
   * or thumbnail images, are available for the video.
   *
   * The processingProgress object is designed to be polled so that the video
   * uploaded can track the progress that YouTube has made in processing the
   * uploaded video file. This data can only be retrieved by the video owner.
   */
  VideoProcessingDetails processingDetails;
  /**
   * The projectDetails object contains information about the project specific
   * video metadata.
   */
  VideoProjectDetails projectDetails;
  /**
   * The recordingDetails object encapsulates information about the location,
   * date and address where the video was recorded.
   */
  VideoRecordingDetails recordingDetails;
  /**
   * The snippet object contains basic details about the video, such as its
   * title, description, and category.
   */
  VideoSnippet snippet;
  /** The statistics object contains statistics about the video. */
  VideoStatistics statistics;
  /**
   * The status object contains information about the video's uploading,
   * processing, and privacy statuses.
   */
  VideoStatus status;
  /**
   * The suggestions object encapsulates suggestions that identify opportunities
   * to improve the video quality or the metadata for the uploaded video. This
   * data can only be retrieved by the video owner.
   */
  VideoSuggestions suggestions;
  /**
   * The topicDetails object encapsulates information about Freebase topics
   * associated with the video.
   */
  VideoTopicDetails topicDetails;

  Video();

  Video.fromJson(core.Map _json) {
    if (_json.containsKey("ageGating")) {
      ageGating = new VideoAgeGating.fromJson(_json["ageGating"]);
    }
    if (_json.containsKey("contentDetails")) {
      contentDetails = new VideoContentDetails.fromJson(_json["contentDetails"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("fileDetails")) {
      fileDetails = new VideoFileDetails.fromJson(_json["fileDetails"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("liveStreamingDetails")) {
      liveStreamingDetails = new VideoLiveStreamingDetails.fromJson(_json["liveStreamingDetails"]);
    }
    if (_json.containsKey("localizations")) {
      localizations = commons.mapMap(_json["localizations"], (item) => new VideoLocalization.fromJson(item));
    }
    if (_json.containsKey("monetizationDetails")) {
      monetizationDetails = new VideoMonetizationDetails.fromJson(_json["monetizationDetails"]);
    }
    if (_json.containsKey("player")) {
      player = new VideoPlayer.fromJson(_json["player"]);
    }
    if (_json.containsKey("processingDetails")) {
      processingDetails = new VideoProcessingDetails.fromJson(_json["processingDetails"]);
    }
    if (_json.containsKey("projectDetails")) {
      projectDetails = new VideoProjectDetails.fromJson(_json["projectDetails"]);
    }
    if (_json.containsKey("recordingDetails")) {
      recordingDetails = new VideoRecordingDetails.fromJson(_json["recordingDetails"]);
    }
    if (_json.containsKey("snippet")) {
      snippet = new VideoSnippet.fromJson(_json["snippet"]);
    }
    if (_json.containsKey("statistics")) {
      statistics = new VideoStatistics.fromJson(_json["statistics"]);
    }
    if (_json.containsKey("status")) {
      status = new VideoStatus.fromJson(_json["status"]);
    }
    if (_json.containsKey("suggestions")) {
      suggestions = new VideoSuggestions.fromJson(_json["suggestions"]);
    }
    if (_json.containsKey("topicDetails")) {
      topicDetails = new VideoTopicDetails.fromJson(_json["topicDetails"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ageGating != null) {
      _json["ageGating"] = (ageGating).toJson();
    }
    if (contentDetails != null) {
      _json["contentDetails"] = (contentDetails).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (fileDetails != null) {
      _json["fileDetails"] = (fileDetails).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (liveStreamingDetails != null) {
      _json["liveStreamingDetails"] = (liveStreamingDetails).toJson();
    }
    if (localizations != null) {
      _json["localizations"] = commons.mapMap(localizations, (item) => (item).toJson());
    }
    if (monetizationDetails != null) {
      _json["monetizationDetails"] = (monetizationDetails).toJson();
    }
    if (player != null) {
      _json["player"] = (player).toJson();
    }
    if (processingDetails != null) {
      _json["processingDetails"] = (processingDetails).toJson();
    }
    if (projectDetails != null) {
      _json["projectDetails"] = (projectDetails).toJson();
    }
    if (recordingDetails != null) {
      _json["recordingDetails"] = (recordingDetails).toJson();
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    if (statistics != null) {
      _json["statistics"] = (statistics).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    if (suggestions != null) {
      _json["suggestions"] = (suggestions).toJson();
    }
    if (topicDetails != null) {
      _json["topicDetails"] = (topicDetails).toJson();
    }
    return _json;
  }
}

class VideoAbuseReport {
  /** Additional comments regarding the abuse report. */
  core.String comments;
  /** The language that the content was viewed in. */
  core.String language;
  /**
   * The high-level, or primary, reason that the content is abusive. The value
   * is an abuse report reason ID.
   */
  core.String reasonId;
  /**
   * The specific, or secondary, reason that this content is abusive (if
   * available). The value is an abuse report reason ID that is a valid
   * secondary reason for the primary reason.
   */
  core.String secondaryReasonId;
  /** The ID that YouTube uses to uniquely identify the video. */
  core.String videoId;

  VideoAbuseReport();

  VideoAbuseReport.fromJson(core.Map _json) {
    if (_json.containsKey("comments")) {
      comments = _json["comments"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("reasonId")) {
      reasonId = _json["reasonId"];
    }
    if (_json.containsKey("secondaryReasonId")) {
      secondaryReasonId = _json["secondaryReasonId"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comments != null) {
      _json["comments"] = comments;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (reasonId != null) {
      _json["reasonId"] = reasonId;
    }
    if (secondaryReasonId != null) {
      _json["secondaryReasonId"] = secondaryReasonId;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/**
 * A videoAbuseReportReason resource identifies a reason that a video could be
 * reported as abusive. Video abuse report reasons are used with
 * video.ReportAbuse.
 */
class VideoAbuseReportReason {
  /** Etag of this resource. */
  core.String etag;
  /** The ID of this abuse report reason. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoAbuseReportReason".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the abuse report reason.
   */
  VideoAbuseReportReasonSnippet snippet;

  VideoAbuseReportReason();

  VideoAbuseReportReason.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new VideoAbuseReportReasonSnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class VideoAbuseReportReasonListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of valid abuse reasons that are used with video.ReportAbuse. */
  core.List<VideoAbuseReportReason> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoAbuseReportReasonListResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  VideoAbuseReportReasonListResponse();

  VideoAbuseReportReasonListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new VideoAbuseReportReason.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Basic details about a video category, such as its localized title. */
class VideoAbuseReportReasonSnippet {
  /** The localized label belonging to this abuse report reason. */
  core.String label;
  /**
   * The secondary reasons associated with this reason, if any are available.
   * (There might be 0 or more.)
   */
  core.List<VideoAbuseReportSecondaryReason> secondaryReasons;

  VideoAbuseReportReasonSnippet();

  VideoAbuseReportReasonSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
    if (_json.containsKey("secondaryReasons")) {
      secondaryReasons = _json["secondaryReasons"].map((value) => new VideoAbuseReportSecondaryReason.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (label != null) {
      _json["label"] = label;
    }
    if (secondaryReasons != null) {
      _json["secondaryReasons"] = secondaryReasons.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class VideoAbuseReportSecondaryReason {
  /** The ID of this abuse report secondary reason. */
  core.String id;
  /** The localized label for this abuse report secondary reason. */
  core.String label;

  VideoAbuseReportSecondaryReason();

  VideoAbuseReportSecondaryReason.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("label")) {
      label = _json["label"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (label != null) {
      _json["label"] = label;
    }
    return _json;
  }
}

class VideoAgeGating {
  /**
   * Indicates whether or not the video has alcoholic beverage content. Only
   * users of legal purchasing age in a particular country, as identified by
   * ICAP, can view the content.
   */
  core.bool alcoholContent;
  /**
   * Age-restricted trailers. For redband trailers and adult-rated video-games.
   * Only users aged 18+ can view the content. The the field is true the content
   * is restricted to viewers aged 18+. Otherwise The field won't be present.
   */
  core.bool restricted;
  /**
   * Video game rating, if any.
   * Possible string values are:
   * - "anyone"
   * - "m15Plus"
   * - "m16Plus"
   * - "m17Plus"
   */
  core.String videoGameRating;

  VideoAgeGating();

  VideoAgeGating.fromJson(core.Map _json) {
    if (_json.containsKey("alcoholContent")) {
      alcoholContent = _json["alcoholContent"];
    }
    if (_json.containsKey("restricted")) {
      restricted = _json["restricted"];
    }
    if (_json.containsKey("videoGameRating")) {
      videoGameRating = _json["videoGameRating"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alcoholContent != null) {
      _json["alcoholContent"] = alcoholContent;
    }
    if (restricted != null) {
      _json["restricted"] = restricted;
    }
    if (videoGameRating != null) {
      _json["videoGameRating"] = videoGameRating;
    }
    return _json;
  }
}

/**
 * A videoCategory resource identifies a category that has been or could be
 * associated with uploaded videos.
 */
class VideoCategory {
  /** Etag of this resource. */
  core.String etag;
  /** The ID that YouTube uses to uniquely identify the video category. */
  core.String id;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoCategory".
   */
  core.String kind;
  /**
   * The snippet object contains basic details about the video category,
   * including its title.
   */
  VideoCategorySnippet snippet;

  VideoCategory();

  VideoCategory.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("snippet")) {
      snippet = new VideoCategorySnippet.fromJson(_json["snippet"]);
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
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (snippet != null) {
      _json["snippet"] = (snippet).toJson();
    }
    return _json;
  }
}

class VideoCategoryListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /**
   * A list of video categories that can be associated with YouTube videos. In
   * this map, the video category ID is the map key, and its value is the
   * corresponding videoCategory resource.
   */
  core.List<VideoCategory> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoCategoryListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  VideoCategoryListResponse();

  VideoCategoryListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new VideoCategory.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Basic details about a video category, such as its localized title. */
class VideoCategorySnippet {
  core.bool assignable;
  /** The YouTube channel that created the video category. */
  core.String channelId;
  /** The video category's title. */
  core.String title;

  VideoCategorySnippet();

  VideoCategorySnippet.fromJson(core.Map _json) {
    if (_json.containsKey("assignable")) {
      assignable = _json["assignable"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (assignable != null) {
      _json["assignable"] = assignable;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Details about the content of a YouTube Video. */
class VideoContentDetails {
  /**
   * The value of captions indicates whether the video has captions or not.
   * Possible string values are:
   * - "false"
   * - "true"
   */
  core.String caption;
  /**
   * Specifies the ratings that the video received under various rating schemes.
   */
  ContentRating contentRating;
  /**
   * The countryRestriction object contains information about the countries
   * where a video is (or is not) viewable.
   */
  AccessPolicy countryRestriction;
  /**
   * The value of definition indicates whether the video is available in high
   * definition or only in standard definition.
   * Possible string values are:
   * - "hd"
   * - "sd"
   */
  core.String definition;
  /**
   * The value of dimension indicates whether the video is available in 3D or in
   * 2D.
   */
  core.String dimension;
  /**
   * The length of the video. The tag value is an ISO 8601 duration in the
   * format PT#M#S, in which the letters PT indicate that the value specifies a
   * period of time, and the letters M and S refer to length in minutes and
   * seconds, respectively. The # characters preceding the M and S letters are
   * both integers that specify the number of minutes (or seconds) of the video.
   * For example, a value of PT15M51S indicates that the video is 15 minutes and
   * 51 seconds long.
   */
  core.String duration;
  /**
   * Indicates whether the video uploader has provided a custom thumbnail image
   * for the video. This property is only visible to the video uploader.
   */
  core.bool hasCustomThumbnail;
  /**
   * The value of is_license_content indicates whether the video is licensed
   * content.
   */
  core.bool licensedContent;
  /**
   * Specifies the projection format of the video.
   * Possible string values are:
   * - "360"
   * - "rectangular"
   */
  core.String projection;
  /**
   * The regionRestriction object contains information about the countries where
   * a video is (or is not) viewable. The object will contain either the
   * contentDetails.regionRestriction.allowed property or the
   * contentDetails.regionRestriction.blocked property.
   */
  VideoContentDetailsRegionRestriction regionRestriction;

  VideoContentDetails();

  VideoContentDetails.fromJson(core.Map _json) {
    if (_json.containsKey("caption")) {
      caption = _json["caption"];
    }
    if (_json.containsKey("contentRating")) {
      contentRating = new ContentRating.fromJson(_json["contentRating"]);
    }
    if (_json.containsKey("countryRestriction")) {
      countryRestriction = new AccessPolicy.fromJson(_json["countryRestriction"]);
    }
    if (_json.containsKey("definition")) {
      definition = _json["definition"];
    }
    if (_json.containsKey("dimension")) {
      dimension = _json["dimension"];
    }
    if (_json.containsKey("duration")) {
      duration = _json["duration"];
    }
    if (_json.containsKey("hasCustomThumbnail")) {
      hasCustomThumbnail = _json["hasCustomThumbnail"];
    }
    if (_json.containsKey("licensedContent")) {
      licensedContent = _json["licensedContent"];
    }
    if (_json.containsKey("projection")) {
      projection = _json["projection"];
    }
    if (_json.containsKey("regionRestriction")) {
      regionRestriction = new VideoContentDetailsRegionRestriction.fromJson(_json["regionRestriction"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caption != null) {
      _json["caption"] = caption;
    }
    if (contentRating != null) {
      _json["contentRating"] = (contentRating).toJson();
    }
    if (countryRestriction != null) {
      _json["countryRestriction"] = (countryRestriction).toJson();
    }
    if (definition != null) {
      _json["definition"] = definition;
    }
    if (dimension != null) {
      _json["dimension"] = dimension;
    }
    if (duration != null) {
      _json["duration"] = duration;
    }
    if (hasCustomThumbnail != null) {
      _json["hasCustomThumbnail"] = hasCustomThumbnail;
    }
    if (licensedContent != null) {
      _json["licensedContent"] = licensedContent;
    }
    if (projection != null) {
      _json["projection"] = projection;
    }
    if (regionRestriction != null) {
      _json["regionRestriction"] = (regionRestriction).toJson();
    }
    return _json;
  }
}

/** DEPRECATED Region restriction of the video. */
class VideoContentDetailsRegionRestriction {
  /**
   * A list of region codes that identify countries where the video is viewable.
   * If this property is present and a country is not listed in its value, then
   * the video is blocked from appearing in that country. If this property is
   * present and contains an empty list, the video is blocked in all countries.
   */
  core.List<core.String> allowed;
  /**
   * A list of region codes that identify countries where the video is blocked.
   * If this property is present and a country is not listed in its value, then
   * the video is viewable in that country. If this property is present and
   * contains an empty list, the video is viewable in all countries.
   */
  core.List<core.String> blocked;

  VideoContentDetailsRegionRestriction();

  VideoContentDetailsRegionRestriction.fromJson(core.Map _json) {
    if (_json.containsKey("allowed")) {
      allowed = _json["allowed"];
    }
    if (_json.containsKey("blocked")) {
      blocked = _json["blocked"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowed != null) {
      _json["allowed"] = allowed;
    }
    if (blocked != null) {
      _json["blocked"] = blocked;
    }
    return _json;
  }
}

/**
 * Describes original video file properties, including technical details about
 * audio and video streams, but also metadata information like content length,
 * digitization time, or geotagging information.
 */
class VideoFileDetails {
  /**
   * A list of audio streams contained in the uploaded video file. Each item in
   * the list contains detailed metadata about an audio stream.
   */
  core.List<VideoFileDetailsAudioStream> audioStreams;
  /**
   * The uploaded video file's combined (video and audio) bitrate in bits per
   * second.
   */
  core.String bitrateBps;
  /** The uploaded video file's container format. */
  core.String container;
  /**
   * The date and time when the uploaded video file was created. The value is
   * specified in ISO 8601 format. Currently, the following ISO 8601 formats are
   * supported:
   * - Date only: YYYY-MM-DD
   * - Naive time: YYYY-MM-DDTHH:MM:SS
   * - Time with timezone: YYYY-MM-DDTHH:MM:SS+HH:MM
   */
  core.String creationTime;
  /** The length of the uploaded video in milliseconds. */
  core.String durationMs;
  /**
   * The uploaded file's name. This field is present whether a video file or
   * another type of file was uploaded.
   */
  core.String fileName;
  /**
   * The uploaded file's size in bytes. This field is present whether a video
   * file or another type of file was uploaded.
   */
  core.String fileSize;
  /**
   * The uploaded file's type as detected by YouTube's video processing engine.
   * Currently, YouTube only processes video files, but this field is present
   * whether a video file or another type of file was uploaded.
   * Possible string values are:
   * - "archive"
   * - "audio"
   * - "document"
   * - "image"
   * - "other"
   * - "project"
   * - "video"
   */
  core.String fileType;
  /**
   * A list of video streams contained in the uploaded video file. Each item in
   * the list contains detailed metadata about a video stream.
   */
  core.List<VideoFileDetailsVideoStream> videoStreams;

  VideoFileDetails();

  VideoFileDetails.fromJson(core.Map _json) {
    if (_json.containsKey("audioStreams")) {
      audioStreams = _json["audioStreams"].map((value) => new VideoFileDetailsAudioStream.fromJson(value)).toList();
    }
    if (_json.containsKey("bitrateBps")) {
      bitrateBps = _json["bitrateBps"];
    }
    if (_json.containsKey("container")) {
      container = _json["container"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("durationMs")) {
      durationMs = _json["durationMs"];
    }
    if (_json.containsKey("fileName")) {
      fileName = _json["fileName"];
    }
    if (_json.containsKey("fileSize")) {
      fileSize = _json["fileSize"];
    }
    if (_json.containsKey("fileType")) {
      fileType = _json["fileType"];
    }
    if (_json.containsKey("videoStreams")) {
      videoStreams = _json["videoStreams"].map((value) => new VideoFileDetailsVideoStream.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (audioStreams != null) {
      _json["audioStreams"] = audioStreams.map((value) => (value).toJson()).toList();
    }
    if (bitrateBps != null) {
      _json["bitrateBps"] = bitrateBps;
    }
    if (container != null) {
      _json["container"] = container;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (durationMs != null) {
      _json["durationMs"] = durationMs;
    }
    if (fileName != null) {
      _json["fileName"] = fileName;
    }
    if (fileSize != null) {
      _json["fileSize"] = fileSize;
    }
    if (fileType != null) {
      _json["fileType"] = fileType;
    }
    if (videoStreams != null) {
      _json["videoStreams"] = videoStreams.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Information about an audio stream. */
class VideoFileDetailsAudioStream {
  /** The audio stream's bitrate, in bits per second. */
  core.String bitrateBps;
  /** The number of audio channels that the stream contains. */
  core.int channelCount;
  /** The audio codec that the stream uses. */
  core.String codec;
  /**
   * A value that uniquely identifies a video vendor. Typically, the value is a
   * four-letter vendor code.
   */
  core.String vendor;

  VideoFileDetailsAudioStream();

  VideoFileDetailsAudioStream.fromJson(core.Map _json) {
    if (_json.containsKey("bitrateBps")) {
      bitrateBps = _json["bitrateBps"];
    }
    if (_json.containsKey("channelCount")) {
      channelCount = _json["channelCount"];
    }
    if (_json.containsKey("codec")) {
      codec = _json["codec"];
    }
    if (_json.containsKey("vendor")) {
      vendor = _json["vendor"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bitrateBps != null) {
      _json["bitrateBps"] = bitrateBps;
    }
    if (channelCount != null) {
      _json["channelCount"] = channelCount;
    }
    if (codec != null) {
      _json["codec"] = codec;
    }
    if (vendor != null) {
      _json["vendor"] = vendor;
    }
    return _json;
  }
}

/** Information about a video stream. */
class VideoFileDetailsVideoStream {
  /**
   * The video content's display aspect ratio, which specifies the aspect ratio
   * in which the video should be displayed.
   */
  core.double aspectRatio;
  /** The video stream's bitrate, in bits per second. */
  core.String bitrateBps;
  /** The video codec that the stream uses. */
  core.String codec;
  /** The video stream's frame rate, in frames per second. */
  core.double frameRateFps;
  /** The encoded video content's height in pixels. */
  core.int heightPixels;
  /**
   * The amount that YouTube needs to rotate the original source content to
   * properly display the video.
   * Possible string values are:
   * - "clockwise"
   * - "counterClockwise"
   * - "none"
   * - "other"
   * - "upsideDown"
   */
  core.String rotation;
  /**
   * A value that uniquely identifies a video vendor. Typically, the value is a
   * four-letter vendor code.
   */
  core.String vendor;
  /**
   * The encoded video content's width in pixels. You can calculate the video's
   * encoding aspect ratio as width_pixels / height_pixels.
   */
  core.int widthPixels;

  VideoFileDetailsVideoStream();

  VideoFileDetailsVideoStream.fromJson(core.Map _json) {
    if (_json.containsKey("aspectRatio")) {
      aspectRatio = _json["aspectRatio"];
    }
    if (_json.containsKey("bitrateBps")) {
      bitrateBps = _json["bitrateBps"];
    }
    if (_json.containsKey("codec")) {
      codec = _json["codec"];
    }
    if (_json.containsKey("frameRateFps")) {
      frameRateFps = _json["frameRateFps"];
    }
    if (_json.containsKey("heightPixels")) {
      heightPixels = _json["heightPixels"];
    }
    if (_json.containsKey("rotation")) {
      rotation = _json["rotation"];
    }
    if (_json.containsKey("vendor")) {
      vendor = _json["vendor"];
    }
    if (_json.containsKey("widthPixels")) {
      widthPixels = _json["widthPixels"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aspectRatio != null) {
      _json["aspectRatio"] = aspectRatio;
    }
    if (bitrateBps != null) {
      _json["bitrateBps"] = bitrateBps;
    }
    if (codec != null) {
      _json["codec"] = codec;
    }
    if (frameRateFps != null) {
      _json["frameRateFps"] = frameRateFps;
    }
    if (heightPixels != null) {
      _json["heightPixels"] = heightPixels;
    }
    if (rotation != null) {
      _json["rotation"] = rotation;
    }
    if (vendor != null) {
      _json["vendor"] = vendor;
    }
    if (widthPixels != null) {
      _json["widthPixels"] = widthPixels;
    }
    return _json;
  }
}

class VideoGetRatingResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of ratings that match the request criteria. */
  core.List<VideoRating> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoGetRatingResponse".
   */
  core.String kind;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  VideoGetRatingResponse();

  VideoGetRatingResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new VideoRating.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

class VideoListResponse {
  /** Etag of this resource. */
  core.String etag;
  /** Serialized EventId of the request which produced this response. */
  core.String eventId;
  /** A list of videos that match the request criteria. */
  core.List<Video> items;
  /**
   * Identifies what kind of resource this is. Value: the fixed string
   * "youtube#videoListResponse".
   */
  core.String kind;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the next page in the result set.
   */
  core.String nextPageToken;
  PageInfo pageInfo;
  /**
   * The token that can be used as the value of the pageToken parameter to
   * retrieve the previous page in the result set.
   */
  core.String prevPageToken;
  TokenPagination tokenPagination;
  /** The visitorId identifies the visitor. */
  core.String visitorId;

  VideoListResponse();

  VideoListResponse.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("eventId")) {
      eventId = _json["eventId"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Video.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("pageInfo")) {
      pageInfo = new PageInfo.fromJson(_json["pageInfo"]);
    }
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
    }
    if (_json.containsKey("tokenPagination")) {
      tokenPagination = new TokenPagination.fromJson(_json["tokenPagination"]);
    }
    if (_json.containsKey("visitorId")) {
      visitorId = _json["visitorId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (eventId != null) {
      _json["eventId"] = eventId;
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
    if (pageInfo != null) {
      _json["pageInfo"] = (pageInfo).toJson();
    }
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    if (tokenPagination != null) {
      _json["tokenPagination"] = (tokenPagination).toJson();
    }
    if (visitorId != null) {
      _json["visitorId"] = visitorId;
    }
    return _json;
  }
}

/** Details about the live streaming metadata. */
class VideoLiveStreamingDetails {
  /**
   * The ID of the currently active live chat attached to this video. This field
   * is filled only if the video is a currently live broadcast that has live
   * chat. Once the broadcast transitions to complete this field will be removed
   * and the live chat closed down. For persistent broadcasts that live chat id
   * will no longer be tied to this video but rather to the new video being
   * displayed at the persistent page.
   */
  core.String activeLiveChatId;
  /**
   * The time that the broadcast actually ended. The value is specified in ISO
   * 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. This value will not be available
   * until the broadcast is over.
   */
  core.DateTime actualEndTime;
  /**
   * The time that the broadcast actually started. The value is specified in ISO
   * 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. This value will not be available
   * until the broadcast begins.
   */
  core.DateTime actualStartTime;
  /**
   * The number of viewers currently watching the broadcast. The property and
   * its value will be present if the broadcast has current viewers and the
   * broadcast owner has not hidden the viewcount for the video. Note that
   * YouTube stops tracking the number of concurrent viewers for a broadcast
   * when the broadcast ends. So, this property would not identify the number of
   * viewers watching an archived video of a live broadcast that already ended.
   */
  core.String concurrentViewers;
  /**
   * The time that the broadcast is scheduled to end. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. If the value is empty or the
   * property is not present, then the broadcast is scheduled to continue
   * indefinitely.
   */
  core.DateTime scheduledEndTime;
  /**
   * The time that the broadcast is scheduled to begin. The value is specified
   * in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime scheduledStartTime;

  VideoLiveStreamingDetails();

  VideoLiveStreamingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("activeLiveChatId")) {
      activeLiveChatId = _json["activeLiveChatId"];
    }
    if (_json.containsKey("actualEndTime")) {
      actualEndTime = core.DateTime.parse(_json["actualEndTime"]);
    }
    if (_json.containsKey("actualStartTime")) {
      actualStartTime = core.DateTime.parse(_json["actualStartTime"]);
    }
    if (_json.containsKey("concurrentViewers")) {
      concurrentViewers = _json["concurrentViewers"];
    }
    if (_json.containsKey("scheduledEndTime")) {
      scheduledEndTime = core.DateTime.parse(_json["scheduledEndTime"]);
    }
    if (_json.containsKey("scheduledStartTime")) {
      scheduledStartTime = core.DateTime.parse(_json["scheduledStartTime"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activeLiveChatId != null) {
      _json["activeLiveChatId"] = activeLiveChatId;
    }
    if (actualEndTime != null) {
      _json["actualEndTime"] = (actualEndTime).toIso8601String();
    }
    if (actualStartTime != null) {
      _json["actualStartTime"] = (actualStartTime).toIso8601String();
    }
    if (concurrentViewers != null) {
      _json["concurrentViewers"] = concurrentViewers;
    }
    if (scheduledEndTime != null) {
      _json["scheduledEndTime"] = (scheduledEndTime).toIso8601String();
    }
    if (scheduledStartTime != null) {
      _json["scheduledStartTime"] = (scheduledStartTime).toIso8601String();
    }
    return _json;
  }
}

/** Localized versions of certain video properties (e.g. title). */
class VideoLocalization {
  /** Localized version of the video's description. */
  core.String description;
  /** Localized version of the video's title. */
  core.String title;

  VideoLocalization();

  VideoLocalization.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Details about monetization of a YouTube Video. */
class VideoMonetizationDetails {
  /**
   * The value of access indicates whether the video can be monetized or not.
   */
  AccessPolicy access;

  VideoMonetizationDetails();

  VideoMonetizationDetails.fromJson(core.Map _json) {
    if (_json.containsKey("access")) {
      access = new AccessPolicy.fromJson(_json["access"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (access != null) {
      _json["access"] = (access).toJson();
    }
    return _json;
  }
}

/** Player to be used for a video playback. */
class VideoPlayer {
  core.String embedHeight;
  /** An <iframe> tag that embeds a player that will play the video. */
  core.String embedHtml;
  /** The embed width */
  core.String embedWidth;

  VideoPlayer();

  VideoPlayer.fromJson(core.Map _json) {
    if (_json.containsKey("embedHeight")) {
      embedHeight = _json["embedHeight"];
    }
    if (_json.containsKey("embedHtml")) {
      embedHtml = _json["embedHtml"];
    }
    if (_json.containsKey("embedWidth")) {
      embedWidth = _json["embedWidth"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (embedHeight != null) {
      _json["embedHeight"] = embedHeight;
    }
    if (embedHtml != null) {
      _json["embedHtml"] = embedHtml;
    }
    if (embedWidth != null) {
      _json["embedWidth"] = embedWidth;
    }
    return _json;
  }
}

/**
 * Describes processing status and progress and availability of some other Video
 * resource parts.
 */
class VideoProcessingDetails {
  /**
   * This value indicates whether video editing suggestions, which might improve
   * video quality or the playback experience, are available for the video. You
   * can retrieve these suggestions by requesting the suggestions part in your
   * videos.list() request.
   */
  core.String editorSuggestionsAvailability;
  /**
   * This value indicates whether file details are available for the uploaded
   * video. You can retrieve a video's file details by requesting the
   * fileDetails part in your videos.list() request.
   */
  core.String fileDetailsAvailability;
  /**
   * The reason that YouTube failed to process the video. This property will
   * only have a value if the processingStatus property's value is failed.
   * Possible string values are:
   * - "other"
   * - "streamingFailed"
   * - "transcodeFailed"
   * - "uploadFailed"
   */
  core.String processingFailureReason;
  /**
   * This value indicates whether the video processing engine has generated
   * suggestions that might improve YouTube's ability to process the the video,
   * warnings that explain video processing problems, or errors that cause video
   * processing problems. You can retrieve these suggestions by requesting the
   * suggestions part in your videos.list() request.
   */
  core.String processingIssuesAvailability;
  /**
   * The processingProgress object contains information about the progress
   * YouTube has made in processing the video. The values are really only
   * relevant if the video's processing status is processing.
   */
  VideoProcessingDetailsProcessingProgress processingProgress;
  /**
   * The video's processing status. This value indicates whether YouTube was
   * able to process the video or if the video is still being processed.
   * Possible string values are:
   * - "failed"
   * - "processing"
   * - "succeeded"
   * - "terminated"
   */
  core.String processingStatus;
  /**
   * This value indicates whether keyword (tag) suggestions are available for
   * the video. Tags can be added to a video's metadata to make it easier for
   * other users to find the video. You can retrieve these suggestions by
   * requesting the suggestions part in your videos.list() request.
   */
  core.String tagSuggestionsAvailability;
  /**
   * This value indicates whether thumbnail images have been generated for the
   * video.
   */
  core.String thumbnailsAvailability;

  VideoProcessingDetails();

  VideoProcessingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("editorSuggestionsAvailability")) {
      editorSuggestionsAvailability = _json["editorSuggestionsAvailability"];
    }
    if (_json.containsKey("fileDetailsAvailability")) {
      fileDetailsAvailability = _json["fileDetailsAvailability"];
    }
    if (_json.containsKey("processingFailureReason")) {
      processingFailureReason = _json["processingFailureReason"];
    }
    if (_json.containsKey("processingIssuesAvailability")) {
      processingIssuesAvailability = _json["processingIssuesAvailability"];
    }
    if (_json.containsKey("processingProgress")) {
      processingProgress = new VideoProcessingDetailsProcessingProgress.fromJson(_json["processingProgress"]);
    }
    if (_json.containsKey("processingStatus")) {
      processingStatus = _json["processingStatus"];
    }
    if (_json.containsKey("tagSuggestionsAvailability")) {
      tagSuggestionsAvailability = _json["tagSuggestionsAvailability"];
    }
    if (_json.containsKey("thumbnailsAvailability")) {
      thumbnailsAvailability = _json["thumbnailsAvailability"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (editorSuggestionsAvailability != null) {
      _json["editorSuggestionsAvailability"] = editorSuggestionsAvailability;
    }
    if (fileDetailsAvailability != null) {
      _json["fileDetailsAvailability"] = fileDetailsAvailability;
    }
    if (processingFailureReason != null) {
      _json["processingFailureReason"] = processingFailureReason;
    }
    if (processingIssuesAvailability != null) {
      _json["processingIssuesAvailability"] = processingIssuesAvailability;
    }
    if (processingProgress != null) {
      _json["processingProgress"] = (processingProgress).toJson();
    }
    if (processingStatus != null) {
      _json["processingStatus"] = processingStatus;
    }
    if (tagSuggestionsAvailability != null) {
      _json["tagSuggestionsAvailability"] = tagSuggestionsAvailability;
    }
    if (thumbnailsAvailability != null) {
      _json["thumbnailsAvailability"] = thumbnailsAvailability;
    }
    return _json;
  }
}

/** Video processing progress and completion time estimate. */
class VideoProcessingDetailsProcessingProgress {
  /**
   * The number of parts of the video that YouTube has already processed. You
   * can estimate the percentage of the video that YouTube has already processed
   * by calculating:
   * 100 * parts_processed / parts_total
   *
   * Note that since the estimated number of parts could increase without a
   * corresponding increase in the number of parts that have already been
   * processed, it is possible that the calculated progress could periodically
   * decrease while YouTube processes a video.
   */
  core.String partsProcessed;
  /**
   * An estimate of the total number of parts that need to be processed for the
   * video. The number may be updated with more precise estimates while YouTube
   * processes the video.
   */
  core.String partsTotal;
  /**
   * An estimate of the amount of time, in millseconds, that YouTube needs to
   * finish processing the video.
   */
  core.String timeLeftMs;

  VideoProcessingDetailsProcessingProgress();

  VideoProcessingDetailsProcessingProgress.fromJson(core.Map _json) {
    if (_json.containsKey("partsProcessed")) {
      partsProcessed = _json["partsProcessed"];
    }
    if (_json.containsKey("partsTotal")) {
      partsTotal = _json["partsTotal"];
    }
    if (_json.containsKey("timeLeftMs")) {
      timeLeftMs = _json["timeLeftMs"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (partsProcessed != null) {
      _json["partsProcessed"] = partsProcessed;
    }
    if (partsTotal != null) {
      _json["partsTotal"] = partsTotal;
    }
    if (timeLeftMs != null) {
      _json["timeLeftMs"] = timeLeftMs;
    }
    return _json;
  }
}

/** Project specific details about the content of a YouTube Video. */
class VideoProjectDetails {
  /** A list of project tags associated with the video during the upload. */
  core.List<core.String> tags;

  VideoProjectDetails();

  VideoProjectDetails.fromJson(core.Map _json) {
    if (_json.containsKey("tags")) {
      tags = _json["tags"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (tags != null) {
      _json["tags"] = tags;
    }
    return _json;
  }
}

class VideoRating {
  /**
   *
   * Possible string values are:
   * - "dislike"
   * - "like"
   * - "none"
   * - "unspecified"
   */
  core.String rating;
  core.String videoId;

  VideoRating();

  VideoRating.fromJson(core.Map _json) {
    if (_json.containsKey("rating")) {
      rating = _json["rating"];
    }
    if (_json.containsKey("videoId")) {
      videoId = _json["videoId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rating != null) {
      _json["rating"] = rating;
    }
    if (videoId != null) {
      _json["videoId"] = videoId;
    }
    return _json;
  }
}

/** Recording information associated with the video. */
class VideoRecordingDetails {
  /** The geolocation information associated with the video. */
  GeoPoint location;
  /** The text description of the location where the video was recorded. */
  core.String locationDescription;
  /**
   * The date and time when the video was recorded. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sssZ) format.
   */
  core.DateTime recordingDate;

  VideoRecordingDetails();

  VideoRecordingDetails.fromJson(core.Map _json) {
    if (_json.containsKey("location")) {
      location = new GeoPoint.fromJson(_json["location"]);
    }
    if (_json.containsKey("locationDescription")) {
      locationDescription = _json["locationDescription"];
    }
    if (_json.containsKey("recordingDate")) {
      recordingDate = core.DateTime.parse(_json["recordingDate"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (locationDescription != null) {
      _json["locationDescription"] = locationDescription;
    }
    if (recordingDate != null) {
      _json["recordingDate"] = (recordingDate).toIso8601String();
    }
    return _json;
  }
}

/**
 * Basic details about a video, including title, description, uploader,
 * thumbnails and category.
 */
class VideoSnippet {
  /** The YouTube video category associated with the video. */
  core.String categoryId;
  /**
   * The ID that YouTube uses to uniquely identify the channel that the video
   * was uploaded to.
   */
  core.String channelId;
  /** Channel title for the channel that the video belongs to. */
  core.String channelTitle;
  /**
   * The default_audio_language property specifies the language spoken in the
   * video's default audio track.
   */
  core.String defaultAudioLanguage;
  /** The language of the videos's default snippet. */
  core.String defaultLanguage;
  /** The video's description. */
  core.String description;
  /**
   * Indicates if the video is an upcoming/active live broadcast. Or it's "none"
   * if the video is not an upcoming/active live broadcast.
   * Possible string values are:
   * - "live"
   * - "none"
   * - "upcoming"
   */
  core.String liveBroadcastContent;
  /**
   * Localized snippet selected with the hl parameter. If no such localization
   * exists, this field is populated with the default snippet. (Read-only)
   */
  VideoLocalization localized;
  /**
   * The date and time that the video was uploaded. The value is specified in
   * ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishedAt;
  /**
   * A list of keyword tags associated with the video. Tags may contain spaces.
   */
  core.List<core.String> tags;
  /**
   * A map of thumbnail images associated with the video. For each object in the
   * map, the key is the name of the thumbnail image, and the value is an object
   * that contains other information about the thumbnail.
   */
  ThumbnailDetails thumbnails;
  /** The video's title. */
  core.String title;

  VideoSnippet();

  VideoSnippet.fromJson(core.Map _json) {
    if (_json.containsKey("categoryId")) {
      categoryId = _json["categoryId"];
    }
    if (_json.containsKey("channelId")) {
      channelId = _json["channelId"];
    }
    if (_json.containsKey("channelTitle")) {
      channelTitle = _json["channelTitle"];
    }
    if (_json.containsKey("defaultAudioLanguage")) {
      defaultAudioLanguage = _json["defaultAudioLanguage"];
    }
    if (_json.containsKey("defaultLanguage")) {
      defaultLanguage = _json["defaultLanguage"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("liveBroadcastContent")) {
      liveBroadcastContent = _json["liveBroadcastContent"];
    }
    if (_json.containsKey("localized")) {
      localized = new VideoLocalization.fromJson(_json["localized"]);
    }
    if (_json.containsKey("publishedAt")) {
      publishedAt = core.DateTime.parse(_json["publishedAt"]);
    }
    if (_json.containsKey("tags")) {
      tags = _json["tags"];
    }
    if (_json.containsKey("thumbnails")) {
      thumbnails = new ThumbnailDetails.fromJson(_json["thumbnails"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (categoryId != null) {
      _json["categoryId"] = categoryId;
    }
    if (channelId != null) {
      _json["channelId"] = channelId;
    }
    if (channelTitle != null) {
      _json["channelTitle"] = channelTitle;
    }
    if (defaultAudioLanguage != null) {
      _json["defaultAudioLanguage"] = defaultAudioLanguage;
    }
    if (defaultLanguage != null) {
      _json["defaultLanguage"] = defaultLanguage;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (liveBroadcastContent != null) {
      _json["liveBroadcastContent"] = liveBroadcastContent;
    }
    if (localized != null) {
      _json["localized"] = (localized).toJson();
    }
    if (publishedAt != null) {
      _json["publishedAt"] = (publishedAt).toIso8601String();
    }
    if (tags != null) {
      _json["tags"] = tags;
    }
    if (thumbnails != null) {
      _json["thumbnails"] = (thumbnails).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * Statistics about the video, such as the number of times the video was viewed
 * or liked.
 */
class VideoStatistics {
  /** The number of comments for the video. */
  core.String commentCount;
  /**
   * The number of users who have indicated that they disliked the video by
   * giving it a negative rating.
   */
  core.String dislikeCount;
  /**
   * The number of users who currently have the video marked as a favorite
   * video.
   */
  core.String favoriteCount;
  /**
   * The number of users who have indicated that they liked the video by giving
   * it a positive rating.
   */
  core.String likeCount;
  /** The number of times the video has been viewed. */
  core.String viewCount;

  VideoStatistics();

  VideoStatistics.fromJson(core.Map _json) {
    if (_json.containsKey("commentCount")) {
      commentCount = _json["commentCount"];
    }
    if (_json.containsKey("dislikeCount")) {
      dislikeCount = _json["dislikeCount"];
    }
    if (_json.containsKey("favoriteCount")) {
      favoriteCount = _json["favoriteCount"];
    }
    if (_json.containsKey("likeCount")) {
      likeCount = _json["likeCount"];
    }
    if (_json.containsKey("viewCount")) {
      viewCount = _json["viewCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commentCount != null) {
      _json["commentCount"] = commentCount;
    }
    if (dislikeCount != null) {
      _json["dislikeCount"] = dislikeCount;
    }
    if (favoriteCount != null) {
      _json["favoriteCount"] = favoriteCount;
    }
    if (likeCount != null) {
      _json["likeCount"] = likeCount;
    }
    if (viewCount != null) {
      _json["viewCount"] = viewCount;
    }
    return _json;
  }
}

/** Basic details about a video category, such as its localized title. */
class VideoStatus {
  /** This value indicates if the video can be embedded on another website. */
  core.bool embeddable;
  /**
   * This value explains why a video failed to upload. This property is only
   * present if the uploadStatus property indicates that the upload failed.
   * Possible string values are:
   * - "codec"
   * - "conversion"
   * - "emptyFile"
   * - "invalidFile"
   * - "tooSmall"
   * - "uploadAborted"
   */
  core.String failureReason;
  /**
   * The video's license.
   * Possible string values are:
   * - "creativeCommon"
   * - "youtube"
   */
  core.String license;
  /**
   * The video's privacy status.
   * Possible string values are:
   * - "private"
   * - "public"
   * - "unlisted"
   */
  core.String privacyStatus;
  /**
   * This value indicates if the extended video statistics on the watch page can
   * be viewed by everyone. Note that the view count, likes, etc will still be
   * visible if this is disabled.
   */
  core.bool publicStatsViewable;
  /**
   * The date and time when the video is scheduled to publish. It can be set
   * only if the privacy status of the video is private. The value is specified
   * in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
   */
  core.DateTime publishAt;
  /**
   * This value explains why YouTube rejected an uploaded video. This property
   * is only present if the uploadStatus property indicates that the upload was
   * rejected.
   * Possible string values are:
   * - "claim"
   * - "copyright"
   * - "duplicate"
   * - "inappropriate"
   * - "legal"
   * - "length"
   * - "termsOfUse"
   * - "trademark"
   * - "uploaderAccountClosed"
   * - "uploaderAccountSuspended"
   */
  core.String rejectionReason;
  /**
   * The status of the uploaded video.
   * Possible string values are:
   * - "deleted"
   * - "failed"
   * - "processed"
   * - "rejected"
   * - "uploaded"
   */
  core.String uploadStatus;

  VideoStatus();

  VideoStatus.fromJson(core.Map _json) {
    if (_json.containsKey("embeddable")) {
      embeddable = _json["embeddable"];
    }
    if (_json.containsKey("failureReason")) {
      failureReason = _json["failureReason"];
    }
    if (_json.containsKey("license")) {
      license = _json["license"];
    }
    if (_json.containsKey("privacyStatus")) {
      privacyStatus = _json["privacyStatus"];
    }
    if (_json.containsKey("publicStatsViewable")) {
      publicStatsViewable = _json["publicStatsViewable"];
    }
    if (_json.containsKey("publishAt")) {
      publishAt = core.DateTime.parse(_json["publishAt"]);
    }
    if (_json.containsKey("rejectionReason")) {
      rejectionReason = _json["rejectionReason"];
    }
    if (_json.containsKey("uploadStatus")) {
      uploadStatus = _json["uploadStatus"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (embeddable != null) {
      _json["embeddable"] = embeddable;
    }
    if (failureReason != null) {
      _json["failureReason"] = failureReason;
    }
    if (license != null) {
      _json["license"] = license;
    }
    if (privacyStatus != null) {
      _json["privacyStatus"] = privacyStatus;
    }
    if (publicStatsViewable != null) {
      _json["publicStatsViewable"] = publicStatsViewable;
    }
    if (publishAt != null) {
      _json["publishAt"] = (publishAt).toIso8601String();
    }
    if (rejectionReason != null) {
      _json["rejectionReason"] = rejectionReason;
    }
    if (uploadStatus != null) {
      _json["uploadStatus"] = uploadStatus;
    }
    return _json;
  }
}

/**
 * Specifies suggestions on how to improve video content, including encoding
 * hints, tag suggestions, and editor suggestions.
 */
class VideoSuggestions {
  /**
   * A list of video editing operations that might improve the video quality or
   * playback experience of the uploaded video.
   */
  core.List<core.String> editorSuggestions;
  /**
   * A list of errors that will prevent YouTube from successfully processing the
   * uploaded video video. These errors indicate that, regardless of the video's
   * current processing status, eventually, that status will almost certainly be
   * failed.
   */
  core.List<core.String> processingErrors;
  /**
   * A list of suggestions that may improve YouTube's ability to process the
   * video.
   */
  core.List<core.String> processingHints;
  /**
   * A list of reasons why YouTube may have difficulty transcoding the uploaded
   * video or that might result in an erroneous transcoding. These warnings are
   * generated before YouTube actually processes the uploaded video file. In
   * addition, they identify issues that are unlikely to cause the video
   * processing to fail but that might cause problems such as sync issues, video
   * artifacts, or a missing audio track.
   */
  core.List<core.String> processingWarnings;
  /**
   * A list of keyword tags that could be added to the video's metadata to
   * increase the likelihood that users will locate your video when searching or
   * browsing on YouTube.
   */
  core.List<VideoSuggestionsTagSuggestion> tagSuggestions;

  VideoSuggestions();

  VideoSuggestions.fromJson(core.Map _json) {
    if (_json.containsKey("editorSuggestions")) {
      editorSuggestions = _json["editorSuggestions"];
    }
    if (_json.containsKey("processingErrors")) {
      processingErrors = _json["processingErrors"];
    }
    if (_json.containsKey("processingHints")) {
      processingHints = _json["processingHints"];
    }
    if (_json.containsKey("processingWarnings")) {
      processingWarnings = _json["processingWarnings"];
    }
    if (_json.containsKey("tagSuggestions")) {
      tagSuggestions = _json["tagSuggestions"].map((value) => new VideoSuggestionsTagSuggestion.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (editorSuggestions != null) {
      _json["editorSuggestions"] = editorSuggestions;
    }
    if (processingErrors != null) {
      _json["processingErrors"] = processingErrors;
    }
    if (processingHints != null) {
      _json["processingHints"] = processingHints;
    }
    if (processingWarnings != null) {
      _json["processingWarnings"] = processingWarnings;
    }
    if (tagSuggestions != null) {
      _json["tagSuggestions"] = tagSuggestions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A single tag suggestion with it's relevance information. */
class VideoSuggestionsTagSuggestion {
  /**
   * A set of video categories for which the tag is relevant. You can use this
   * information to display appropriate tag suggestions based on the video
   * category that the video uploader associates with the video. By default, tag
   * suggestions are relevant for all categories if there are no restricts
   * defined for the keyword.
   */
  core.List<core.String> categoryRestricts;
  /** The keyword tag suggested for the video. */
  core.String tag;

  VideoSuggestionsTagSuggestion();

  VideoSuggestionsTagSuggestion.fromJson(core.Map _json) {
    if (_json.containsKey("categoryRestricts")) {
      categoryRestricts = _json["categoryRestricts"];
    }
    if (_json.containsKey("tag")) {
      tag = _json["tag"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (categoryRestricts != null) {
      _json["categoryRestricts"] = categoryRestricts;
    }
    if (tag != null) {
      _json["tag"] = tag;
    }
    return _json;
  }
}

/** Freebase topic information related to the video. */
class VideoTopicDetails {
  /**
   * Similar to topic_id, except that these topics are merely relevant to the
   * video. These are topics that may be mentioned in, or appear in the video.
   * You can retrieve information about each topic using Freebase Topic API.
   */
  core.List<core.String> relevantTopicIds;
  /**
   * A list of Wikipedia URLs that provide a high-level description of the
   * video's content.
   */
  core.List<core.String> topicCategories;
  /**
   * A list of Freebase topic IDs that are centrally associated with the video.
   * These are topics that are centrally featured in the video, and it can be
   * said that the video is mainly about each of these. You can retrieve
   * information about each topic using the Freebase Topic API.
   */
  core.List<core.String> topicIds;

  VideoTopicDetails();

  VideoTopicDetails.fromJson(core.Map _json) {
    if (_json.containsKey("relevantTopicIds")) {
      relevantTopicIds = _json["relevantTopicIds"];
    }
    if (_json.containsKey("topicCategories")) {
      topicCategories = _json["topicCategories"];
    }
    if (_json.containsKey("topicIds")) {
      topicIds = _json["topicIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (relevantTopicIds != null) {
      _json["relevantTopicIds"] = relevantTopicIds;
    }
    if (topicCategories != null) {
      _json["topicCategories"] = topicCategories;
    }
    if (topicIds != null) {
      _json["topicIds"] = topicIds;
    }
    return _json;
  }
}

/** Branding properties for the watch. All deprecated. */
class WatchSettings {
  /** The text color for the video watch page's branded area. */
  core.String backgroundColor;
  /**
   * An ID that uniquely identifies a playlist that displays next to the video
   * player.
   */
  core.String featuredPlaylistId;
  /** The background color for the video watch page's branded area. */
  core.String textColor;

  WatchSettings();

  WatchSettings.fromJson(core.Map _json) {
    if (_json.containsKey("backgroundColor")) {
      backgroundColor = _json["backgroundColor"];
    }
    if (_json.containsKey("featuredPlaylistId")) {
      featuredPlaylistId = _json["featuredPlaylistId"];
    }
    if (_json.containsKey("textColor")) {
      textColor = _json["textColor"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (backgroundColor != null) {
      _json["backgroundColor"] = backgroundColor;
    }
    if (featuredPlaylistId != null) {
      _json["featuredPlaylistId"] = featuredPlaylistId;
    }
    if (textColor != null) {
      _json["textColor"] = textColor;
    }
    return _json;
  }
}
