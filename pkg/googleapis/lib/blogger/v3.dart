// This is a generated file (see the discoveryapis_generator project).

library googleapis.blogger.v3;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client blogger/v3';

/** API for access to the data within Blogger. */
class BloggerApi {
  /** Manage your Blogger account */
  static const BloggerScope = "https://www.googleapis.com/auth/blogger";

  /** View your Blogger account */
  static const BloggerReadonlyScope = "https://www.googleapis.com/auth/blogger.readonly";


  final commons.ApiRequester _requester;

  BlogUserInfosResourceApi get blogUserInfos => new BlogUserInfosResourceApi(_requester);
  BlogsResourceApi get blogs => new BlogsResourceApi(_requester);
  CommentsResourceApi get comments => new CommentsResourceApi(_requester);
  PageViewsResourceApi get pageViews => new PageViewsResourceApi(_requester);
  PagesResourceApi get pages => new PagesResourceApi(_requester);
  PostUserInfosResourceApi get postUserInfos => new PostUserInfosResourceApi(_requester);
  PostsResourceApi get posts => new PostsResourceApi(_requester);
  UsersResourceApi get users => new UsersResourceApi(_requester);

  BloggerApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "blogger/v3/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class BlogUserInfosResourceApi {
  final commons.ApiRequester _requester;

  BlogUserInfosResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one blog and user info pair by blogId and userId.
   *
   * Request parameters:
   *
   * [userId] - ID of the user whose blogs are to be fetched. Either the word
   * 'self' (sans quote marks) or the user's profile identifier.
   *
   * [blogId] - The ID of the blog to get.
   *
   * [maxPosts] - Maximum number of posts to pull back with the blog.
   *
   * Completes with a [BlogUserInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BlogUserInfo> get(core.String userId, core.String blogId, {core.int maxPosts}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (maxPosts != null) {
      _queryParams["maxPosts"] = ["${maxPosts}"];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/blogs/' + commons.Escaper.ecapeVariable('$blogId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BlogUserInfo.fromJson(data));
  }

}


class BlogsResourceApi {
  final commons.ApiRequester _requester;

  BlogsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one blog by ID.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the blog to get.
   *
   * [maxPosts] - Maximum number of posts to pull back with the blog.
   *
   * [view] - Access level with which to view the blog. Note that some fields
   * require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail.
   * - "AUTHOR" : Author level detail.
   * - "READER" : Reader level detail.
   *
   * Completes with a [Blog].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Blog> get(core.String blogId, {core.int maxPosts, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (maxPosts != null) {
      _queryParams["maxPosts"] = ["${maxPosts}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Blog.fromJson(data));
  }

  /**
   * Retrieve a Blog by URL.
   *
   * Request parameters:
   *
   * [url] - The URL of the blog to retrieve.
   *
   * [view] - Access level with which to view the blog. Note that some fields
   * require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail.
   * - "AUTHOR" : Author level detail.
   * - "READER" : Reader level detail.
   *
   * Completes with a [Blog].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Blog> getByUrl(core.String url, {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (url == null) {
      throw new core.ArgumentError("Parameter url is required.");
    }
    _queryParams["url"] = [url];
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/byurl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Blog.fromJson(data));
  }

  /**
   * Retrieves a list of blogs, possibly filtered.
   *
   * Request parameters:
   *
   * [userId] - ID of the user whose blogs are to be fetched. Either the word
   * 'self' (sans quote marks) or the user's profile identifier.
   *
   * [fetchUserInfo] - Whether the response is a list of blogs with per-user
   * information instead of just blogs.
   *
   * [role] - User access types for blogs to include in the results, e.g. AUTHOR
   * will return blogs where the user has author level access. If no roles are
   * specified, defaults to ADMIN and AUTHOR roles.
   *
   * [status] - Blog statuses to include in the result (default: Live blogs
   * only). Note that ADMIN access is required to view deleted blogs.
   *
   * [view] - Access level with which to view the blogs. Note that some fields
   * require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail.
   * - "AUTHOR" : Author level detail.
   * - "READER" : Reader level detail.
   *
   * Completes with a [BlogList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BlogList> listByUser(core.String userId, {core.bool fetchUserInfo, core.List<core.String> role, core.List<core.String> status, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (fetchUserInfo != null) {
      _queryParams["fetchUserInfo"] = ["${fetchUserInfo}"];
    }
    if (role != null) {
      _queryParams["role"] = role;
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/blogs';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BlogList.fromJson(data));
  }

}


class CommentsResourceApi {
  final commons.ApiRequester _requester;

  CommentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Marks a comment as not spam.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [commentId] - The ID of the comment to mark as not spam.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> approve(core.String blogId, core.String postId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/approve';

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
   * Delete a comment by ID.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [commentId] - The ID of the comment to delete.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String blogId, core.String postId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _downloadOptions = null;

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

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
   * Gets one comment by ID.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to containing the comment.
   *
   * [postId] - ID of the post to fetch posts from.
   *
   * [commentId] - The ID of the comment to get.
   *
   * [view] - Access level for the requested comment (default: READER). Note
   * that some comments will require elevated permissions, for example comments
   * where the parent posts which is in a draft state, or comments that are
   * pending moderation.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Admin level detail
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> get(core.String blogId, core.String postId, core.String commentId, {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId');

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
   * Retrieves the comments for a post, possibly filtered.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch comments from.
   *
   * [postId] - ID of the post to fetch posts from.
   *
   * [endDate] - Latest date of comment to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [fetchBodies] - Whether the body content of the comments is included.
   *
   * [maxResults] - Maximum number of comments to include in the result.
   *
   * [pageToken] - Continuation token if request is paged.
   *
   * [startDate] - Earliest date of comment to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [status] - null
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [CommentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentList> list(core.String blogId, core.String postId, {core.DateTime endDate, core.bool fetchBodies, core.int maxResults, core.String pageToken, core.DateTime startDate, core.List<core.String> status, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (endDate != null) {
      _queryParams["endDate"] = [(endDate).toIso8601String()];
    }
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startDate != null) {
      _queryParams["startDate"] = [(startDate).toIso8601String()];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentList.fromJson(data));
  }

  /**
   * Retrieves the comments for a blog, across all posts, possibly filtered.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch comments from.
   *
   * [endDate] - Latest date of comment to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [fetchBodies] - Whether the body content of the comments is included.
   *
   * [maxResults] - Maximum number of comments to include in the result.
   *
   * [pageToken] - Continuation token if request is paged.
   *
   * [startDate] - Earliest date of comment to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [status] - null
   *
   * Completes with a [CommentList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommentList> listByBlog(core.String blogId, {core.DateTime endDate, core.bool fetchBodies, core.int maxResults, core.String pageToken, core.DateTime startDate, core.List<core.String> status}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (endDate != null) {
      _queryParams["endDate"] = [(endDate).toIso8601String()];
    }
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startDate != null) {
      _queryParams["startDate"] = [(startDate).toIso8601String()];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/comments';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommentList.fromJson(data));
  }

  /**
   * Marks a comment as spam.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [commentId] - The ID of the comment to mark as spam.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> markAsSpam(core.String blogId, core.String postId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/spam';

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
   * Removes the content of a comment.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [commentId] - The ID of the comment to delete content from.
   *
   * Completes with a [Comment].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Comment> removeContent(core.String blogId, core.String postId, core.String commentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (commentId == null) {
      throw new core.ArgumentError("Parameter commentId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/comments/' + commons.Escaper.ecapeVariable('$commentId') + '/removecontent';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Comment.fromJson(data));
  }

}


class PageViewsResourceApi {
  final commons.ApiRequester _requester;

  PageViewsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieve pageview stats for a Blog.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the blog to get.
   *
   * [range] - null
   *
   * Completes with a [Pageviews].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Pageviews> get(core.String blogId, {core.List<core.String> range}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (range != null) {
      _queryParams["range"] = range;
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pageviews';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Pageviews.fromJson(data));
  }

}


class PagesResourceApi {
  final commons.ApiRequester _requester;

  PagesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete a page by ID.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [pageId] - The ID of the Page.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String blogId, core.String pageId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }

    _downloadOptions = null;

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId');

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
   * Gets one blog page by ID.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog containing the page.
   *
   * [pageId] - The ID of the page to get.
   *
   * [view] - null
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> get(core.String blogId, core.String pageId, {core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

  /**
   * Add a page.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to add the page to.
   *
   * [isDraft] - Whether to create the page as a draft (default: false).
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> insert(Page request, core.String blogId, {core.bool isDraft}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (isDraft != null) {
      _queryParams["isDraft"] = ["${isDraft}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

  /**
   * Retrieves the pages for a blog, optionally including non-LIVE statuses.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch Pages from.
   *
   * [fetchBodies] - Whether to retrieve the Page bodies.
   *
   * [maxResults] - Maximum number of Pages to fetch.
   *
   * [pageToken] - Continuation token if the request is paged.
   *
   * [status] - null
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [PageList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PageList> list(core.String blogId, {core.bool fetchBodies, core.int maxResults, core.String pageToken, core.List<core.String> status, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PageList.fromJson(data));
  }

  /**
   * Update a page. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [pageId] - The ID of the Page.
   *
   * [publish_1] - Whether a publish action should be performed when the page is
   * updated (default: false).
   *
   * [revert_1] - Whether a revert action should be performed when the page is
   * updated (default: false).
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> patch(Page request, core.String blogId, core.String pageId, {core.bool publish_1, core.bool revert_1}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }
    if (publish_1 != null) {
      _queryParams["publish"] = ["${publish_1}"];
    }
    if (revert_1 != null) {
      _queryParams["revert"] = ["${revert_1}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

  /**
   * Publishes a draft page.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the blog.
   *
   * [pageId] - The ID of the page.
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> publish(core.String blogId, core.String pageId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId') + '/publish';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

  /**
   * Revert a published or scheduled page to draft state.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the blog.
   *
   * [pageId] - The ID of the page.
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> revert(core.String blogId, core.String pageId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId') + '/revert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

  /**
   * Update a page.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [pageId] - The ID of the Page.
   *
   * [publish_1] - Whether a publish action should be performed when the page is
   * updated (default: false).
   *
   * [revert_1] - Whether a revert action should be performed when the page is
   * updated (default: false).
   *
   * Completes with a [Page].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Page> update(Page request, core.String blogId, core.String pageId, {core.bool publish_1, core.bool revert_1}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (pageId == null) {
      throw new core.ArgumentError("Parameter pageId is required.");
    }
    if (publish_1 != null) {
      _queryParams["publish"] = ["${publish_1}"];
    }
    if (revert_1 != null) {
      _queryParams["revert"] = ["${revert_1}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/pages/' + commons.Escaper.ecapeVariable('$pageId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Page.fromJson(data));
  }

}


class PostUserInfosResourceApi {
  final commons.ApiRequester _requester;

  PostUserInfosResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one post and user info pair, by post ID and user ID. The post user
   * info contains per-user information about the post, such as access rights,
   * specific to the user.
   *
   * Request parameters:
   *
   * [userId] - ID of the user for the per-user information to be fetched.
   * Either the word 'self' (sans quote marks) or the user's profile identifier.
   *
   * [blogId] - The ID of the blog.
   *
   * [postId] - The ID of the post to get.
   *
   * [maxComments] - Maximum number of comments to pull back on a post.
   *
   * Completes with a [PostUserInfo].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostUserInfo> get(core.String userId, core.String blogId, core.String postId, {core.int maxComments}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (maxComments != null) {
      _queryParams["maxComments"] = ["${maxComments}"];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostUserInfo.fromJson(data));
  }

  /**
   * Retrieves a list of post and post user info pairs, possibly filtered. The
   * post user info contains per-user information about the post, such as access
   * rights, specific to the user.
   *
   * Request parameters:
   *
   * [userId] - ID of the user for the per-user information to be fetched.
   * Either the word 'self' (sans quote marks) or the user's profile identifier.
   *
   * [blogId] - ID of the blog to fetch posts from.
   *
   * [endDate] - Latest post date to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [fetchBodies] - Whether the body content of posts is included. Default is
   * false.
   *
   * [labels] - Comma-separated list of labels to search for.
   *
   * [maxResults] - Maximum number of posts to fetch.
   *
   * [orderBy] - Sort order applied to search results. Default is published.
   * Possible string values are:
   * - "published" : Order by the date the post was published
   * - "updated" : Order by the date the post was last updated
   *
   * [pageToken] - Continuation token if the request is paged.
   *
   * [startDate] - Earliest post date to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [status] - null
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [PostUserInfosList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostUserInfosList> list(core.String userId, core.String blogId, {core.DateTime endDate, core.bool fetchBodies, core.String labels, core.int maxResults, core.String orderBy, core.String pageToken, core.DateTime startDate, core.List<core.String> status, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (endDate != null) {
      _queryParams["endDate"] = [(endDate).toIso8601String()];
    }
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (labels != null) {
      _queryParams["labels"] = [labels];
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
    if (startDate != null) {
      _queryParams["startDate"] = [(startDate).toIso8601String()];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostUserInfosList.fromJson(data));
  }

}


class PostsResourceApi {
  final commons.ApiRequester _requester;

  PostsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Delete a post by ID.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String blogId, core.String postId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }

    _downloadOptions = null;

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId');

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
   * Get a post by ID.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch the post from.
   *
   * [postId] - The ID of the post
   *
   * [fetchBody] - Whether the body content of the post is included (default:
   * true). This should be set to false when the post bodies are not required,
   * to help minimize traffic.
   *
   * [fetchImages] - Whether image URL metadata for each post is included
   * (default: false).
   *
   * [maxComments] - Maximum number of comments to pull back on a post.
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> get(core.String blogId, core.String postId, {core.bool fetchBody, core.bool fetchImages, core.int maxComments, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (fetchBody != null) {
      _queryParams["fetchBody"] = ["${fetchBody}"];
    }
    if (fetchImages != null) {
      _queryParams["fetchImages"] = ["${fetchImages}"];
    }
    if (maxComments != null) {
      _queryParams["maxComments"] = ["${maxComments}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Retrieve a Post by Path.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch the post from.
   *
   * [path] - Path of the Post to retrieve.
   *
   * [maxComments] - Maximum number of comments to pull back on a post.
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require elevated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> getByPath(core.String blogId, core.String path, {core.int maxComments, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (path == null) {
      throw new core.ArgumentError("Parameter path is required.");
    }
    _queryParams["path"] = [path];
    if (maxComments != null) {
      _queryParams["maxComments"] = ["${maxComments}"];
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/bypath';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Add a post.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to add the post to.
   *
   * [fetchBody] - Whether the body content of the post is included with the
   * result (default: true).
   *
   * [fetchImages] - Whether image URL metadata for each post is included in the
   * returned result (default: false).
   *
   * [isDraft] - Whether to create the post as a draft (default: false).
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> insert(Post request, core.String blogId, {core.bool fetchBody, core.bool fetchImages, core.bool isDraft}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (fetchBody != null) {
      _queryParams["fetchBody"] = ["${fetchBody}"];
    }
    if (fetchImages != null) {
      _queryParams["fetchImages"] = ["${fetchImages}"];
    }
    if (isDraft != null) {
      _queryParams["isDraft"] = ["${isDraft}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Retrieves a list of posts, possibly filtered.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch posts from.
   *
   * [endDate] - Latest post date to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [fetchBodies] - Whether the body content of posts is included (default:
   * true). This should be set to false when the post bodies are not required,
   * to help minimize traffic.
   *
   * [fetchImages] - Whether image URL metadata for each post is included.
   *
   * [labels] - Comma-separated list of labels to search for.
   *
   * [maxResults] - Maximum number of posts to fetch.
   *
   * [orderBy] - Sort search results
   * Possible string values are:
   * - "published" : Order by the date the post was published
   * - "updated" : Order by the date the post was last updated
   *
   * [pageToken] - Continuation token if the request is paged.
   *
   * [startDate] - Earliest post date to fetch, a date-time with RFC 3339
   * formatting.
   *
   * [status] - Statuses to include in the results.
   *
   * [view] - Access level with which to view the returned result. Note that
   * some fields require escalated access.
   * Possible string values are:
   * - "ADMIN" : Admin level detail
   * - "AUTHOR" : Author level detail
   * - "READER" : Reader level detail
   *
   * Completes with a [PostList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostList> list(core.String blogId, {core.DateTime endDate, core.bool fetchBodies, core.bool fetchImages, core.String labels, core.int maxResults, core.String orderBy, core.String pageToken, core.DateTime startDate, core.List<core.String> status, core.String view}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (endDate != null) {
      _queryParams["endDate"] = [(endDate).toIso8601String()];
    }
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (fetchImages != null) {
      _queryParams["fetchImages"] = ["${fetchImages}"];
    }
    if (labels != null) {
      _queryParams["labels"] = [labels];
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
    if (startDate != null) {
      _queryParams["startDate"] = [(startDate).toIso8601String()];
    }
    if (status != null) {
      _queryParams["status"] = status;
    }
    if (view != null) {
      _queryParams["view"] = [view];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostList.fromJson(data));
  }

  /**
   * Update a post. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [fetchBody] - Whether the body content of the post is included with the
   * result (default: true).
   *
   * [fetchImages] - Whether image URL metadata for each post is included in the
   * returned result (default: false).
   *
   * [maxComments] - Maximum number of comments to retrieve with the returned
   * post.
   *
   * [publish_1] - Whether a publish action should be performed when the post is
   * updated (default: false).
   *
   * [revert_1] - Whether a revert action should be performed when the post is
   * updated (default: false).
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> patch(Post request, core.String blogId, core.String postId, {core.bool fetchBody, core.bool fetchImages, core.int maxComments, core.bool publish_1, core.bool revert_1}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (fetchBody != null) {
      _queryParams["fetchBody"] = ["${fetchBody}"];
    }
    if (fetchImages != null) {
      _queryParams["fetchImages"] = ["${fetchImages}"];
    }
    if (maxComments != null) {
      _queryParams["maxComments"] = ["${maxComments}"];
    }
    if (publish_1 != null) {
      _queryParams["publish"] = ["${publish_1}"];
    }
    if (revert_1 != null) {
      _queryParams["revert"] = ["${revert_1}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Publishes a draft post, optionally at the specific time of the given
   * publishDate parameter.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [publishDate] - Optional date and time to schedule the publishing of the
   * Blog. If no publishDate parameter is given, the post is either published at
   * the a previously saved schedule date (if present), or the current time. If
   * a future date is given, the post will be scheduled to be published.
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> publish(core.String blogId, core.String postId, {core.DateTime publishDate}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (publishDate != null) {
      _queryParams["publishDate"] = [(publishDate).toIso8601String()];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/publish';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Revert a published or scheduled post to draft state.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> revert(core.String blogId, core.String postId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId') + '/revert';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

  /**
   * Search for a post.
   *
   * Request parameters:
   *
   * [blogId] - ID of the blog to fetch the post from.
   *
   * [q] - Query terms to search this blog for matching posts.
   *
   * [fetchBodies] - Whether the body content of posts is included (default:
   * true). This should be set to false when the post bodies are not required,
   * to help minimize traffic.
   *
   * [orderBy] - Sort search results
   * Possible string values are:
   * - "published" : Order by the date the post was published
   * - "updated" : Order by the date the post was last updated
   *
   * Completes with a [PostList].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<PostList> search(core.String blogId, core.String q, {core.bool fetchBodies, core.String orderBy}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (q == null) {
      throw new core.ArgumentError("Parameter q is required.");
    }
    _queryParams["q"] = [q];
    if (fetchBodies != null) {
      _queryParams["fetchBodies"] = ["${fetchBodies}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/search';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new PostList.fromJson(data));
  }

  /**
   * Update a post.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [blogId] - The ID of the Blog.
   *
   * [postId] - The ID of the Post.
   *
   * [fetchBody] - Whether the body content of the post is included with the
   * result (default: true).
   *
   * [fetchImages] - Whether image URL metadata for each post is included in the
   * returned result (default: false).
   *
   * [maxComments] - Maximum number of comments to retrieve with the returned
   * post.
   *
   * [publish_1] - Whether a publish action should be performed when the post is
   * updated (default: false).
   *
   * [revert_1] - Whether a revert action should be performed when the post is
   * updated (default: false).
   *
   * Completes with a [Post].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Post> update(Post request, core.String blogId, core.String postId, {core.bool fetchBody, core.bool fetchImages, core.int maxComments, core.bool publish_1, core.bool revert_1}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (blogId == null) {
      throw new core.ArgumentError("Parameter blogId is required.");
    }
    if (postId == null) {
      throw new core.ArgumentError("Parameter postId is required.");
    }
    if (fetchBody != null) {
      _queryParams["fetchBody"] = ["${fetchBody}"];
    }
    if (fetchImages != null) {
      _queryParams["fetchImages"] = ["${fetchImages}"];
    }
    if (maxComments != null) {
      _queryParams["maxComments"] = ["${maxComments}"];
    }
    if (publish_1 != null) {
      _queryParams["publish"] = ["${publish_1}"];
    }
    if (revert_1 != null) {
      _queryParams["revert"] = ["${revert_1}"];
    }

    _url = 'blogs/' + commons.Escaper.ecapeVariable('$blogId') + '/posts/' + commons.Escaper.ecapeVariable('$postId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Post.fromJson(data));
  }

}


class UsersResourceApi {
  final commons.ApiRequester _requester;

  UsersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets one user by ID.
   *
   * Request parameters:
   *
   * [userId] - The ID of the user to get.
   *
   * Completes with a [User].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<User> get(core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new User.fromJson(data));
  }

}



/** The locale this Blog is set to. */
class BlogLocale {
  /** The country this blog's locale is set to. */
  core.String country;
  /** The language this blog is authored in. */
  core.String language;
  /** The language variant this blog is authored in. */
  core.String variant;

  BlogLocale();

  BlogLocale.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    return _json;
  }
}

/** The container of pages in this blog. */
class BlogPages {
  /** The URL of the container for pages in this blog. */
  core.String selfLink;
  /** The count of pages in this blog. */
  core.int totalItems;

  BlogPages();

  BlogPages.fromJson(core.Map _json) {
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

/** The container of posts in this blog. */
class BlogPosts {
  /** The List of Posts for this Blog. */
  core.List<Post> items;
  /** The URL of the container for posts in this blog. */
  core.String selfLink;
  /** The count of posts in this blog. */
  core.int totalItems;

  BlogPosts();

  BlogPosts.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Post.fromJson(value)).toList();
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class Blog {
  /** The JSON custom meta-data for the Blog */
  core.String customMetaData;
  /** The description of this blog. This is displayed underneath the title. */
  core.String description;
  /** The identifier for this resource. */
  core.String id;
  /** The kind of this entry. Always blogger#blog */
  core.String kind;
  /** The locale this Blog is set to. */
  BlogLocale locale;
  /** The name of this blog. This is displayed as the title. */
  core.String name;
  /** The container of pages in this blog. */
  BlogPages pages;
  /** The container of posts in this blog. */
  BlogPosts posts;
  /** RFC 3339 date-time when this blog was published. */
  core.DateTime published;
  /** The API REST URL to fetch this resource from. */
  core.String selfLink;
  /** The status of the blog. */
  core.String status;
  /** RFC 3339 date-time when this blog was last updated. */
  core.DateTime updated;
  /** The URL where this blog is published. */
  core.String url;

  Blog();

  Blog.fromJson(core.Map _json) {
    if (_json.containsKey("customMetaData")) {
      customMetaData = _json["customMetaData"];
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
      locale = new BlogLocale.fromJson(_json["locale"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pages")) {
      pages = new BlogPages.fromJson(_json["pages"]);
    }
    if (_json.containsKey("posts")) {
      posts = new BlogPosts.fromJson(_json["posts"]);
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (customMetaData != null) {
      _json["customMetaData"] = customMetaData;
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
      _json["locale"] = (locale).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (pages != null) {
      _json["pages"] = (pages).toJson();
    }
    if (posts != null) {
      _json["posts"] = (posts).toJson();
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class BlogList {
  /** Admin level list of blog per-user information */
  core.List<BlogUserInfo> blogUserInfos;
  /** The list of Blogs this user has Authorship or Admin rights over. */
  core.List<Blog> items;
  /** The kind of this entity. Always blogger#blogList */
  core.String kind;

  BlogList();

  BlogList.fromJson(core.Map _json) {
    if (_json.containsKey("blogUserInfos")) {
      blogUserInfos = _json["blogUserInfos"].map((value) => new BlogUserInfo.fromJson(value)).toList();
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Blog.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blogUserInfos != null) {
      _json["blogUserInfos"] = blogUserInfos.map((value) => (value).toJson()).toList();
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

class BlogPerUserInfo {
  /** ID of the Blog resource */
  core.String blogId;
  /** True if the user has Admin level access to the blog. */
  core.bool hasAdminAccess;
  /** The kind of this entity. Always blogger#blogPerUserInfo */
  core.String kind;
  /** The Photo Album Key for the user when adding photos to the blog */
  core.String photosAlbumKey;
  /**
   * Access permissions that the user has for the blog (ADMIN, AUTHOR, or
   * READER).
   */
  core.String role;
  /** ID of the User */
  core.String userId;

  BlogPerUserInfo();

  BlogPerUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("blogId")) {
      blogId = _json["blogId"];
    }
    if (_json.containsKey("hasAdminAccess")) {
      hasAdminAccess = _json["hasAdminAccess"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("photosAlbumKey")) {
      photosAlbumKey = _json["photosAlbumKey"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blogId != null) {
      _json["blogId"] = blogId;
    }
    if (hasAdminAccess != null) {
      _json["hasAdminAccess"] = hasAdminAccess;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (photosAlbumKey != null) {
      _json["photosAlbumKey"] = photosAlbumKey;
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

class BlogUserInfo {
  /** The Blog resource. */
  Blog blog;
  /** Information about a User for the Blog. */
  BlogPerUserInfo blogUserInfo;
  /** The kind of this entity. Always blogger#blogUserInfo */
  core.String kind;

  BlogUserInfo();

  BlogUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("blog")) {
      blog = new Blog.fromJson(_json["blog"]);
    }
    if (_json.containsKey("blog_user_info")) {
      blogUserInfo = new BlogPerUserInfo.fromJson(_json["blog_user_info"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blog != null) {
      _json["blog"] = (blog).toJson();
    }
    if (blogUserInfo != null) {
      _json["blog_user_info"] = (blogUserInfo).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** The comment creator's avatar. */
class CommentAuthorImage {
  /** The comment creator's avatar URL. */
  core.String url;

  CommentAuthorImage();

  CommentAuthorImage.fromJson(core.Map _json) {
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

/** The author of this Comment. */
class CommentAuthor {
  /** The display name. */
  core.String displayName;
  /** The identifier of the Comment creator. */
  core.String id;
  /** The comment creator's avatar. */
  CommentAuthorImage image;
  /** The URL of the Comment creator's Profile page. */
  core.String url;

  CommentAuthor();

  CommentAuthor.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new CommentAuthorImage.fromJson(_json["image"]);
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

/** Data about the blog containing this comment. */
class CommentBlog {
  /** The identifier of the blog containing this comment. */
  core.String id;

  CommentBlog();

  CommentBlog.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

/** Data about the comment this is in reply to. */
class CommentInReplyTo {
  /** The identified of the parent of this comment. */
  core.String id;

  CommentInReplyTo();

  CommentInReplyTo.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

/** Data about the post containing this comment. */
class CommentPost {
  /** The identifier of the post containing this comment. */
  core.String id;

  CommentPost();

  CommentPost.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class Comment {
  /** The author of this Comment. */
  CommentAuthor author;
  /** Data about the blog containing this comment. */
  CommentBlog blog;
  /** The actual content of the comment. May include HTML markup. */
  core.String content;
  /** The identifier for this resource. */
  core.String id;
  /** Data about the comment this is in reply to. */
  CommentInReplyTo inReplyTo;
  /** The kind of this entry. Always blogger#comment */
  core.String kind;
  /** Data about the post containing this comment. */
  CommentPost post;
  /** RFC 3339 date-time when this comment was published. */
  core.DateTime published;
  /** The API REST URL to fetch this resource from. */
  core.String selfLink;
  /** The status of the comment (only populated for admin users) */
  core.String status;
  /** RFC 3339 date-time when this comment was last updated. */
  core.DateTime updated;

  Comment();

  Comment.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new CommentAuthor.fromJson(_json["author"]);
    }
    if (_json.containsKey("blog")) {
      blog = new CommentBlog.fromJson(_json["blog"]);
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("inReplyTo")) {
      inReplyTo = new CommentInReplyTo.fromJson(_json["inReplyTo"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("post")) {
      post = new CommentPost.fromJson(_json["post"]);
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (blog != null) {
      _json["blog"] = (blog).toJson();
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (inReplyTo != null) {
      _json["inReplyTo"] = (inReplyTo).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (post != null) {
      _json["post"] = (post).toJson();
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class CommentList {
  /** Etag of the response. */
  core.String etag;
  /** The List of Comments for a Post. */
  core.List<Comment> items;
  /** The kind of this entry. Always blogger#commentList */
  core.String kind;
  /** Pagination token to fetch the next page, if one exists. */
  core.String nextPageToken;
  /** Pagination token to fetch the previous page, if one exists. */
  core.String prevPageToken;

  CommentList();

  CommentList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
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
    if (_json.containsKey("prevPageToken")) {
      prevPageToken = _json["prevPageToken"];
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
    if (prevPageToken != null) {
      _json["prevPageToken"] = prevPageToken;
    }
    return _json;
  }
}

/** The page author's avatar. */
class PageAuthorImage {
  /** The page author's avatar URL. */
  core.String url;

  PageAuthorImage();

  PageAuthorImage.fromJson(core.Map _json) {
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

/** The author of this Page. */
class PageAuthor {
  /** The display name. */
  core.String displayName;
  /** The identifier of the Page creator. */
  core.String id;
  /** The page author's avatar. */
  PageAuthorImage image;
  /** The URL of the Page creator's Profile page. */
  core.String url;

  PageAuthor();

  PageAuthor.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new PageAuthorImage.fromJson(_json["image"]);
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

/** Data about the blog containing this Page. */
class PageBlog {
  /** The identifier of the blog containing this page. */
  core.String id;

  PageBlog();

  PageBlog.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class Page {
  /** The author of this Page. */
  PageAuthor author;
  /** Data about the blog containing this Page. */
  PageBlog blog;
  /** The body content of this Page, in HTML. */
  core.String content;
  /** Etag of the resource. */
  core.String etag;
  /** The identifier for this resource. */
  core.String id;
  /** The kind of this entity. Always blogger#page */
  core.String kind;
  /** RFC 3339 date-time when this Page was published. */
  core.DateTime published;
  /** The API REST URL to fetch this resource from. */
  core.String selfLink;
  /** The status of the page for admin resources (either LIVE or DRAFT). */
  core.String status;
  /**
   * The title of this entity. This is the name displayed in the Admin user
   * interface.
   */
  core.String title;
  /** RFC 3339 date-time when this Page was last updated. */
  core.DateTime updated;
  /** The URL that this Page is displayed at. */
  core.String url;

  Page();

  Page.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new PageAuthor.fromJson(_json["author"]);
    }
    if (_json.containsKey("blog")) {
      blog = new PageBlog.fromJson(_json["blog"]);
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
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
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
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
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (blog != null) {
      _json["blog"] = (blog).toJson();
    }
    if (content != null) {
      _json["content"] = content;
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
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
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
    return _json;
  }
}

class PageList {
  /** Etag of the response. */
  core.String etag;
  /** The list of Pages for a Blog. */
  core.List<Page> items;
  /** The kind of this entity. Always blogger#pageList */
  core.String kind;
  /** Pagination token to fetch the next page, if one exists. */
  core.String nextPageToken;

  PageList();

  PageList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Page.fromJson(value)).toList();
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

class PageviewsCounts {
  /** Count of page views for the given time range */
  core.String count;
  /** Time range the given count applies to */
  core.String timeRange;

  PageviewsCounts();

  PageviewsCounts.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("timeRange")) {
      timeRange = _json["timeRange"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (timeRange != null) {
      _json["timeRange"] = timeRange;
    }
    return _json;
  }
}

class Pageviews {
  /** Blog Id */
  core.String blogId;
  /** The container of posts in this blog. */
  core.List<PageviewsCounts> counts;
  /** The kind of this entry. Always blogger#page_views */
  core.String kind;

  Pageviews();

  Pageviews.fromJson(core.Map _json) {
    if (_json.containsKey("blogId")) {
      blogId = _json["blogId"];
    }
    if (_json.containsKey("counts")) {
      counts = _json["counts"].map((value) => new PageviewsCounts.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blogId != null) {
      _json["blogId"] = blogId;
    }
    if (counts != null) {
      _json["counts"] = counts.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** The Post author's avatar. */
class PostAuthorImage {
  /** The Post author's avatar URL. */
  core.String url;

  PostAuthorImage();

  PostAuthorImage.fromJson(core.Map _json) {
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

/** The author of this Post. */
class PostAuthor {
  /** The display name. */
  core.String displayName;
  /** The identifier of the Post creator. */
  core.String id;
  /** The Post author's avatar. */
  PostAuthorImage image;
  /** The URL of the Post creator's Profile page. */
  core.String url;

  PostAuthor();

  PostAuthor.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("image")) {
      image = new PostAuthorImage.fromJson(_json["image"]);
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

/** Data about the blog containing this Post. */
class PostBlog {
  /** The identifier of the Blog that contains this Post. */
  core.String id;

  PostBlog();

  PostBlog.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    return _json;
  }
}

class PostImages {
  core.String url;

  PostImages();

  PostImages.fromJson(core.Map _json) {
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

/** The location for geotagged posts. */
class PostLocation {
  /** Location's latitude. */
  core.double lat;
  /** Location's longitude. */
  core.double lng;
  /** Location name. */
  core.String name;
  /** Location's viewport span. Can be used when rendering a map preview. */
  core.String span;

  PostLocation();

  PostLocation.fromJson(core.Map _json) {
    if (_json.containsKey("lat")) {
      lat = _json["lat"];
    }
    if (_json.containsKey("lng")) {
      lng = _json["lng"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("span")) {
      span = _json["span"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lat != null) {
      _json["lat"] = lat;
    }
    if (lng != null) {
      _json["lng"] = lng;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (span != null) {
      _json["span"] = span;
    }
    return _json;
  }
}

/** The container of comments on this Post. */
class PostReplies {
  /** The List of Comments for this Post. */
  core.List<Comment> items;
  /** The URL of the comments on this post. */
  core.String selfLink;
  /** The count of comments on this post. */
  core.String totalItems;

  PostReplies();

  PostReplies.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Comment.fromJson(value)).toList();
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class Post {
  /** The author of this Post. */
  PostAuthor author;
  /** Data about the blog containing this Post. */
  PostBlog blog;
  /** The content of the Post. May contain HTML markup. */
  core.String content;
  /** The JSON meta-data for the Post. */
  core.String customMetaData;
  /** Etag of the resource. */
  core.String etag;
  /** The identifier of this Post. */
  core.String id;
  /** Display image for the Post. */
  core.List<PostImages> images;
  /** The kind of this entity. Always blogger#post */
  core.String kind;
  /** The list of labels this Post was tagged with. */
  core.List<core.String> labels;
  /** The location for geotagged posts. */
  PostLocation location;
  /** RFC 3339 date-time when this Post was published. */
  core.DateTime published;
  /** Comment control and display setting for readers of this post. */
  core.String readerComments;
  /** The container of comments on this Post. */
  PostReplies replies;
  /** The API REST URL to fetch this resource from. */
  core.String selfLink;
  /** Status of the post. Only set for admin-level requests */
  core.String status;
  /** The title of the Post. */
  core.String title;
  /** The title link URL, similar to atom's related link. */
  core.String titleLink;
  /** RFC 3339 date-time when this Post was last updated. */
  core.DateTime updated;
  /** The URL where this Post is displayed. */
  core.String url;

  Post();

  Post.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new PostAuthor.fromJson(_json["author"]);
    }
    if (_json.containsKey("blog")) {
      blog = new PostBlog.fromJson(_json["blog"]);
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("customMetaData")) {
      customMetaData = _json["customMetaData"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("images")) {
      images = _json["images"].map((value) => new PostImages.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("location")) {
      location = new PostLocation.fromJson(_json["location"]);
    }
    if (_json.containsKey("published")) {
      published = core.DateTime.parse(_json["published"]);
    }
    if (_json.containsKey("readerComments")) {
      readerComments = _json["readerComments"];
    }
    if (_json.containsKey("replies")) {
      replies = new PostReplies.fromJson(_json["replies"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("status")) {
      status = _json["status"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("titleLink")) {
      titleLink = _json["titleLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (blog != null) {
      _json["blog"] = (blog).toJson();
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (customMetaData != null) {
      _json["customMetaData"] = customMetaData;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (images != null) {
      _json["images"] = images.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (location != null) {
      _json["location"] = (location).toJson();
    }
    if (published != null) {
      _json["published"] = (published).toIso8601String();
    }
    if (readerComments != null) {
      _json["readerComments"] = readerComments;
    }
    if (replies != null) {
      _json["replies"] = (replies).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (status != null) {
      _json["status"] = status;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (titleLink != null) {
      _json["titleLink"] = titleLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class PostList {
  /** Etag of the response. */
  core.String etag;
  /** The list of Posts for this Blog. */
  core.List<Post> items;
  /** The kind of this entity. Always blogger#postList */
  core.String kind;
  /** Pagination token to fetch the next page, if one exists. */
  core.String nextPageToken;

  PostList();

  PostList.fromJson(core.Map _json) {
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Post.fromJson(value)).toList();
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

class PostPerUserInfo {
  /** ID of the Blog that the post resource belongs to. */
  core.String blogId;
  /** True if the user has Author level access to the post. */
  core.bool hasEditAccess;
  /** The kind of this entity. Always blogger#postPerUserInfo */
  core.String kind;
  /** ID of the Post resource. */
  core.String postId;
  /** ID of the User. */
  core.String userId;

  PostPerUserInfo();

  PostPerUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("blogId")) {
      blogId = _json["blogId"];
    }
    if (_json.containsKey("hasEditAccess")) {
      hasEditAccess = _json["hasEditAccess"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("postId")) {
      postId = _json["postId"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (blogId != null) {
      _json["blogId"] = blogId;
    }
    if (hasEditAccess != null) {
      _json["hasEditAccess"] = hasEditAccess;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (postId != null) {
      _json["postId"] = postId;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

class PostUserInfo {
  /** The kind of this entity. Always blogger#postUserInfo */
  core.String kind;
  /** The Post resource. */
  Post post;
  /** Information about a User for the Post. */
  PostPerUserInfo postUserInfo;

  PostUserInfo();

  PostUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("post")) {
      post = new Post.fromJson(_json["post"]);
    }
    if (_json.containsKey("post_user_info")) {
      postUserInfo = new PostPerUserInfo.fromJson(_json["post_user_info"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (post != null) {
      _json["post"] = (post).toJson();
    }
    if (postUserInfo != null) {
      _json["post_user_info"] = (postUserInfo).toJson();
    }
    return _json;
  }
}

class PostUserInfosList {
  /** The list of Posts with User information for the post, for this Blog. */
  core.List<PostUserInfo> items;
  /** The kind of this entity. Always blogger#postList */
  core.String kind;
  /** Pagination token to fetch the next page, if one exists. */
  core.String nextPageToken;

  PostUserInfosList();

  PostUserInfosList.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new PostUserInfo.fromJson(value)).toList();
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

/** The container of blogs for this user. */
class UserBlogs {
  /** The URL of the Blogs for this user. */
  core.String selfLink;

  UserBlogs();

  UserBlogs.fromJson(core.Map _json) {
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** This user's locale */
class UserLocale {
  /** The user's country setting. */
  core.String country;
  /** The user's language setting. */
  core.String language;
  /** The user's language variant setting. */
  core.String variant;

  UserLocale();

  UserLocale.fromJson(core.Map _json) {
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("variant")) {
      variant = _json["variant"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (country != null) {
      _json["country"] = country;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (variant != null) {
      _json["variant"] = variant;
    }
    return _json;
  }
}

class User {
  /** Profile summary information. */
  core.String about;
  /** The container of blogs for this user. */
  UserBlogs blogs;
  /**
   * The timestamp of when this profile was created, in seconds since epoch.
   */
  core.DateTime created;
  /** The display name. */
  core.String displayName;
  /** The identifier for this User. */
  core.String id;
  /** The kind of this entity. Always blogger#user */
  core.String kind;
  /** This user's locale */
  UserLocale locale;
  /** The API REST URL to fetch this resource from. */
  core.String selfLink;
  /** The user's profile page. */
  core.String url;

  User();

  User.fromJson(core.Map _json) {
    if (_json.containsKey("about")) {
      about = _json["about"];
    }
    if (_json.containsKey("blogs")) {
      blogs = new UserBlogs.fromJson(_json["blogs"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
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
    if (_json.containsKey("locale")) {
      locale = new UserLocale.fromJson(_json["locale"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (about != null) {
      _json["about"] = about;
    }
    if (blogs != null) {
      _json["blogs"] = (blogs).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
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
    if (locale != null) {
      _json["locale"] = (locale).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}
