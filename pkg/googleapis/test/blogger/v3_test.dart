library googleapis.blogger.v3.test;

import "dart:core" as core;
import "dart:collection" as collection;
import "dart:async" as async;
import "dart:convert" as convert;

import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:unittest/unittest.dart' as unittest;

import 'package:googleapis/blogger/v3.dart' as api;

class HttpServerMock extends http.BaseClient {
  core.Function _callback;
  core.bool _expectJson;

  void register(core.Function callback, core.bool expectJson) {
    _callback = callback;
    _expectJson = expectJson;
  }

  async.Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (_expectJson) {
      return request.finalize()
          .transform(convert.UTF8.decoder)
          .join('')
          .then((core.String jsonString) {
        if (jsonString.isEmpty) {
          return _callback(request, null);
        } else {
          return _callback(request, convert.JSON.decode(jsonString));
        }
      });
    } else {
      var stream = request.finalize();
      if (stream == null) {
        return _callback(request, []);
      } else {
        return stream.toBytes().then((data) {
          return _callback(request, data);
        });
      }
    }
  }
}

http.StreamedResponse stringResponse(
    core.int status, core.Map headers, core.String body) {
  var stream = new async.Stream.fromIterable([convert.UTF8.encode(body)]);
  return new http.StreamedResponse(stream, status, headers: headers);
}

core.int buildCounterBlogLocale = 0;
buildBlogLocale() {
  var o = new api.BlogLocale();
  buildCounterBlogLocale++;
  if (buildCounterBlogLocale < 3) {
    o.country = "foo";
    o.language = "foo";
    o.variant = "foo";
  }
  buildCounterBlogLocale--;
  return o;
}

checkBlogLocale(api.BlogLocale o) {
  buildCounterBlogLocale++;
  if (buildCounterBlogLocale < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals('foo'));
  }
  buildCounterBlogLocale--;
}

core.int buildCounterBlogPages = 0;
buildBlogPages() {
  var o = new api.BlogPages();
  buildCounterBlogPages++;
  if (buildCounterBlogPages < 3) {
    o.selfLink = "foo";
    o.totalItems = 42;
  }
  buildCounterBlogPages--;
  return o;
}

checkBlogPages(api.BlogPages o) {
  buildCounterBlogPages++;
  if (buildCounterBlogPages < 3) {
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterBlogPages--;
}

buildUnnamed1158() {
  var o = new core.List<api.Post>();
  o.add(buildPost());
  o.add(buildPost());
  return o;
}

checkUnnamed1158(core.List<api.Post> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPost(o[0]);
  checkPost(o[1]);
}

core.int buildCounterBlogPosts = 0;
buildBlogPosts() {
  var o = new api.BlogPosts();
  buildCounterBlogPosts++;
  if (buildCounterBlogPosts < 3) {
    o.items = buildUnnamed1158();
    o.selfLink = "foo";
    o.totalItems = 42;
  }
  buildCounterBlogPosts--;
  return o;
}

checkBlogPosts(api.BlogPosts o) {
  buildCounterBlogPosts++;
  if (buildCounterBlogPosts < 3) {
    checkUnnamed1158(o.items);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals(42));
  }
  buildCounterBlogPosts--;
}

core.int buildCounterBlog = 0;
buildBlog() {
  var o = new api.Blog();
  buildCounterBlog++;
  if (buildCounterBlog < 3) {
    o.customMetaData = "foo";
    o.description = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.locale = buildBlogLocale();
    o.name = "foo";
    o.pages = buildBlogPages();
    o.posts = buildBlogPosts();
    o.published = core.DateTime.parse("2002-02-27T14:01:02");
    o.selfLink = "foo";
    o.status = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.url = "foo";
  }
  buildCounterBlog--;
  return o;
}

checkBlog(api.Blog o) {
  buildCounterBlog++;
  if (buildCounterBlog < 3) {
    unittest.expect(o.customMetaData, unittest.equals('foo'));
    unittest.expect(o.description, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkBlogLocale(o.locale);
    unittest.expect(o.name, unittest.equals('foo'));
    checkBlogPages(o.pages);
    checkBlogPosts(o.posts);
    unittest.expect(o.published, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterBlog--;
}

buildUnnamed1159() {
  var o = new core.List<api.BlogUserInfo>();
  o.add(buildBlogUserInfo());
  o.add(buildBlogUserInfo());
  return o;
}

checkUnnamed1159(core.List<api.BlogUserInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBlogUserInfo(o[0]);
  checkBlogUserInfo(o[1]);
}

buildUnnamed1160() {
  var o = new core.List<api.Blog>();
  o.add(buildBlog());
  o.add(buildBlog());
  return o;
}

checkUnnamed1160(core.List<api.Blog> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkBlog(o[0]);
  checkBlog(o[1]);
}

core.int buildCounterBlogList = 0;
buildBlogList() {
  var o = new api.BlogList();
  buildCounterBlogList++;
  if (buildCounterBlogList < 3) {
    o.blogUserInfos = buildUnnamed1159();
    o.items = buildUnnamed1160();
    o.kind = "foo";
  }
  buildCounterBlogList--;
  return o;
}

checkBlogList(api.BlogList o) {
  buildCounterBlogList++;
  if (buildCounterBlogList < 3) {
    checkUnnamed1159(o.blogUserInfos);
    checkUnnamed1160(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterBlogList--;
}

core.int buildCounterBlogPerUserInfo = 0;
buildBlogPerUserInfo() {
  var o = new api.BlogPerUserInfo();
  buildCounterBlogPerUserInfo++;
  if (buildCounterBlogPerUserInfo < 3) {
    o.blogId = "foo";
    o.hasAdminAccess = true;
    o.kind = "foo";
    o.photosAlbumKey = "foo";
    o.role = "foo";
    o.userId = "foo";
  }
  buildCounterBlogPerUserInfo--;
  return o;
}

checkBlogPerUserInfo(api.BlogPerUserInfo o) {
  buildCounterBlogPerUserInfo++;
  if (buildCounterBlogPerUserInfo < 3) {
    unittest.expect(o.blogId, unittest.equals('foo'));
    unittest.expect(o.hasAdminAccess, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.photosAlbumKey, unittest.equals('foo'));
    unittest.expect(o.role, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterBlogPerUserInfo--;
}

core.int buildCounterBlogUserInfo = 0;
buildBlogUserInfo() {
  var o = new api.BlogUserInfo();
  buildCounterBlogUserInfo++;
  if (buildCounterBlogUserInfo < 3) {
    o.blog = buildBlog();
    o.blogUserInfo = buildBlogPerUserInfo();
    o.kind = "foo";
  }
  buildCounterBlogUserInfo--;
  return o;
}

checkBlogUserInfo(api.BlogUserInfo o) {
  buildCounterBlogUserInfo++;
  if (buildCounterBlogUserInfo < 3) {
    checkBlog(o.blog);
    checkBlogPerUserInfo(o.blogUserInfo);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterBlogUserInfo--;
}

core.int buildCounterCommentAuthorImage = 0;
buildCommentAuthorImage() {
  var o = new api.CommentAuthorImage();
  buildCounterCommentAuthorImage++;
  if (buildCounterCommentAuthorImage < 3) {
    o.url = "foo";
  }
  buildCounterCommentAuthorImage--;
  return o;
}

checkCommentAuthorImage(api.CommentAuthorImage o) {
  buildCounterCommentAuthorImage++;
  if (buildCounterCommentAuthorImage < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterCommentAuthorImage--;
}

core.int buildCounterCommentAuthor = 0;
buildCommentAuthor() {
  var o = new api.CommentAuthor();
  buildCounterCommentAuthor++;
  if (buildCounterCommentAuthor < 3) {
    o.displayName = "foo";
    o.id = "foo";
    o.image = buildCommentAuthorImage();
    o.url = "foo";
  }
  buildCounterCommentAuthor--;
  return o;
}

checkCommentAuthor(api.CommentAuthor o) {
  buildCounterCommentAuthor++;
  if (buildCounterCommentAuthor < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkCommentAuthorImage(o.image);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterCommentAuthor--;
}

core.int buildCounterCommentBlog = 0;
buildCommentBlog() {
  var o = new api.CommentBlog();
  buildCounterCommentBlog++;
  if (buildCounterCommentBlog < 3) {
    o.id = "foo";
  }
  buildCounterCommentBlog--;
  return o;
}

checkCommentBlog(api.CommentBlog o) {
  buildCounterCommentBlog++;
  if (buildCounterCommentBlog < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterCommentBlog--;
}

core.int buildCounterCommentInReplyTo = 0;
buildCommentInReplyTo() {
  var o = new api.CommentInReplyTo();
  buildCounterCommentInReplyTo++;
  if (buildCounterCommentInReplyTo < 3) {
    o.id = "foo";
  }
  buildCounterCommentInReplyTo--;
  return o;
}

checkCommentInReplyTo(api.CommentInReplyTo o) {
  buildCounterCommentInReplyTo++;
  if (buildCounterCommentInReplyTo < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterCommentInReplyTo--;
}

core.int buildCounterCommentPost = 0;
buildCommentPost() {
  var o = new api.CommentPost();
  buildCounterCommentPost++;
  if (buildCounterCommentPost < 3) {
    o.id = "foo";
  }
  buildCounterCommentPost--;
  return o;
}

checkCommentPost(api.CommentPost o) {
  buildCounterCommentPost++;
  if (buildCounterCommentPost < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterCommentPost--;
}

core.int buildCounterComment = 0;
buildComment() {
  var o = new api.Comment();
  buildCounterComment++;
  if (buildCounterComment < 3) {
    o.author = buildCommentAuthor();
    o.blog = buildCommentBlog();
    o.content = "foo";
    o.id = "foo";
    o.inReplyTo = buildCommentInReplyTo();
    o.kind = "foo";
    o.post = buildCommentPost();
    o.published = core.DateTime.parse("2002-02-27T14:01:02");
    o.selfLink = "foo";
    o.status = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
  }
  buildCounterComment--;
  return o;
}

checkComment(api.Comment o) {
  buildCounterComment++;
  if (buildCounterComment < 3) {
    checkCommentAuthor(o.author);
    checkCommentBlog(o.blog);
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkCommentInReplyTo(o.inReplyTo);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkCommentPost(o.post);
    unittest.expect(o.published, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
  }
  buildCounterComment--;
}

buildUnnamed1161() {
  var o = new core.List<api.Comment>();
  o.add(buildComment());
  o.add(buildComment());
  return o;
}

checkUnnamed1161(core.List<api.Comment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkComment(o[0]);
  checkComment(o[1]);
}

core.int buildCounterCommentList = 0;
buildCommentList() {
  var o = new api.CommentList();
  buildCounterCommentList++;
  if (buildCounterCommentList < 3) {
    o.etag = "foo";
    o.items = buildUnnamed1161();
    o.kind = "foo";
    o.nextPageToken = "foo";
    o.prevPageToken = "foo";
  }
  buildCounterCommentList--;
  return o;
}

checkCommentList(api.CommentList o) {
  buildCounterCommentList++;
  if (buildCounterCommentList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1161(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
    unittest.expect(o.prevPageToken, unittest.equals('foo'));
  }
  buildCounterCommentList--;
}

core.int buildCounterPageAuthorImage = 0;
buildPageAuthorImage() {
  var o = new api.PageAuthorImage();
  buildCounterPageAuthorImage++;
  if (buildCounterPageAuthorImage < 3) {
    o.url = "foo";
  }
  buildCounterPageAuthorImage--;
  return o;
}

checkPageAuthorImage(api.PageAuthorImage o) {
  buildCounterPageAuthorImage++;
  if (buildCounterPageAuthorImage < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPageAuthorImage--;
}

core.int buildCounterPageAuthor = 0;
buildPageAuthor() {
  var o = new api.PageAuthor();
  buildCounterPageAuthor++;
  if (buildCounterPageAuthor < 3) {
    o.displayName = "foo";
    o.id = "foo";
    o.image = buildPageAuthorImage();
    o.url = "foo";
  }
  buildCounterPageAuthor--;
  return o;
}

checkPageAuthor(api.PageAuthor o) {
  buildCounterPageAuthor++;
  if (buildCounterPageAuthor < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkPageAuthorImage(o.image);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPageAuthor--;
}

core.int buildCounterPageBlog = 0;
buildPageBlog() {
  var o = new api.PageBlog();
  buildCounterPageBlog++;
  if (buildCounterPageBlog < 3) {
    o.id = "foo";
  }
  buildCounterPageBlog--;
  return o;
}

checkPageBlog(api.PageBlog o) {
  buildCounterPageBlog++;
  if (buildCounterPageBlog < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterPageBlog--;
}

core.int buildCounterPage = 0;
buildPage() {
  var o = new api.Page();
  buildCounterPage++;
  if (buildCounterPage < 3) {
    o.author = buildPageAuthor();
    o.blog = buildPageBlog();
    o.content = "foo";
    o.etag = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.published = core.DateTime.parse("2002-02-27T14:01:02");
    o.selfLink = "foo";
    o.status = "foo";
    o.title = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.url = "foo";
  }
  buildCounterPage--;
  return o;
}

checkPage(api.Page o) {
  buildCounterPage++;
  if (buildCounterPage < 3) {
    checkPageAuthor(o.author);
    checkPageBlog(o.blog);
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.published, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPage--;
}

buildUnnamed1162() {
  var o = new core.List<api.Page>();
  o.add(buildPage());
  o.add(buildPage());
  return o;
}

checkUnnamed1162(core.List<api.Page> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPage(o[0]);
  checkPage(o[1]);
}

core.int buildCounterPageList = 0;
buildPageList() {
  var o = new api.PageList();
  buildCounterPageList++;
  if (buildCounterPageList < 3) {
    o.etag = "foo";
    o.items = buildUnnamed1162();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPageList--;
  return o;
}

checkPageList(api.PageList o) {
  buildCounterPageList++;
  if (buildCounterPageList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1162(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPageList--;
}

core.int buildCounterPageviewsCounts = 0;
buildPageviewsCounts() {
  var o = new api.PageviewsCounts();
  buildCounterPageviewsCounts++;
  if (buildCounterPageviewsCounts < 3) {
    o.count = "foo";
    o.timeRange = "foo";
  }
  buildCounterPageviewsCounts--;
  return o;
}

checkPageviewsCounts(api.PageviewsCounts o) {
  buildCounterPageviewsCounts++;
  if (buildCounterPageviewsCounts < 3) {
    unittest.expect(o.count, unittest.equals('foo'));
    unittest.expect(o.timeRange, unittest.equals('foo'));
  }
  buildCounterPageviewsCounts--;
}

buildUnnamed1163() {
  var o = new core.List<api.PageviewsCounts>();
  o.add(buildPageviewsCounts());
  o.add(buildPageviewsCounts());
  return o;
}

checkUnnamed1163(core.List<api.PageviewsCounts> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPageviewsCounts(o[0]);
  checkPageviewsCounts(o[1]);
}

core.int buildCounterPageviews = 0;
buildPageviews() {
  var o = new api.Pageviews();
  buildCounterPageviews++;
  if (buildCounterPageviews < 3) {
    o.blogId = "foo";
    o.counts = buildUnnamed1163();
    o.kind = "foo";
  }
  buildCounterPageviews--;
  return o;
}

checkPageviews(api.Pageviews o) {
  buildCounterPageviews++;
  if (buildCounterPageviews < 3) {
    unittest.expect(o.blogId, unittest.equals('foo'));
    checkUnnamed1163(o.counts);
    unittest.expect(o.kind, unittest.equals('foo'));
  }
  buildCounterPageviews--;
}

core.int buildCounterPostAuthorImage = 0;
buildPostAuthorImage() {
  var o = new api.PostAuthorImage();
  buildCounterPostAuthorImage++;
  if (buildCounterPostAuthorImage < 3) {
    o.url = "foo";
  }
  buildCounterPostAuthorImage--;
  return o;
}

checkPostAuthorImage(api.PostAuthorImage o) {
  buildCounterPostAuthorImage++;
  if (buildCounterPostAuthorImage < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPostAuthorImage--;
}

core.int buildCounterPostAuthor = 0;
buildPostAuthor() {
  var o = new api.PostAuthor();
  buildCounterPostAuthor++;
  if (buildCounterPostAuthor < 3) {
    o.displayName = "foo";
    o.id = "foo";
    o.image = buildPostAuthorImage();
    o.url = "foo";
  }
  buildCounterPostAuthor--;
  return o;
}

checkPostAuthor(api.PostAuthor o) {
  buildCounterPostAuthor++;
  if (buildCounterPostAuthor < 3) {
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkPostAuthorImage(o.image);
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPostAuthor--;
}

core.int buildCounterPostBlog = 0;
buildPostBlog() {
  var o = new api.PostBlog();
  buildCounterPostBlog++;
  if (buildCounterPostBlog < 3) {
    o.id = "foo";
  }
  buildCounterPostBlog--;
  return o;
}

checkPostBlog(api.PostBlog o) {
  buildCounterPostBlog++;
  if (buildCounterPostBlog < 3) {
    unittest.expect(o.id, unittest.equals('foo'));
  }
  buildCounterPostBlog--;
}

core.int buildCounterPostImages = 0;
buildPostImages() {
  var o = new api.PostImages();
  buildCounterPostImages++;
  if (buildCounterPostImages < 3) {
    o.url = "foo";
  }
  buildCounterPostImages--;
  return o;
}

checkPostImages(api.PostImages o) {
  buildCounterPostImages++;
  if (buildCounterPostImages < 3) {
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPostImages--;
}

buildUnnamed1164() {
  var o = new core.List<api.PostImages>();
  o.add(buildPostImages());
  o.add(buildPostImages());
  return o;
}

checkUnnamed1164(core.List<api.PostImages> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPostImages(o[0]);
  checkPostImages(o[1]);
}

buildUnnamed1165() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1165(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

core.int buildCounterPostLocation = 0;
buildPostLocation() {
  var o = new api.PostLocation();
  buildCounterPostLocation++;
  if (buildCounterPostLocation < 3) {
    o.lat = 42.0;
    o.lng = 42.0;
    o.name = "foo";
    o.span = "foo";
  }
  buildCounterPostLocation--;
  return o;
}

checkPostLocation(api.PostLocation o) {
  buildCounterPostLocation++;
  if (buildCounterPostLocation < 3) {
    unittest.expect(o.lat, unittest.equals(42.0));
    unittest.expect(o.lng, unittest.equals(42.0));
    unittest.expect(o.name, unittest.equals('foo'));
    unittest.expect(o.span, unittest.equals('foo'));
  }
  buildCounterPostLocation--;
}

buildUnnamed1166() {
  var o = new core.List<api.Comment>();
  o.add(buildComment());
  o.add(buildComment());
  return o;
}

checkUnnamed1166(core.List<api.Comment> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkComment(o[0]);
  checkComment(o[1]);
}

core.int buildCounterPostReplies = 0;
buildPostReplies() {
  var o = new api.PostReplies();
  buildCounterPostReplies++;
  if (buildCounterPostReplies < 3) {
    o.items = buildUnnamed1166();
    o.selfLink = "foo";
    o.totalItems = "foo";
  }
  buildCounterPostReplies--;
  return o;
}

checkPostReplies(api.PostReplies o) {
  buildCounterPostReplies++;
  if (buildCounterPostReplies < 3) {
    checkUnnamed1166(o.items);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.totalItems, unittest.equals('foo'));
  }
  buildCounterPostReplies--;
}

core.int buildCounterPost = 0;
buildPost() {
  var o = new api.Post();
  buildCounterPost++;
  if (buildCounterPost < 3) {
    o.author = buildPostAuthor();
    o.blog = buildPostBlog();
    o.content = "foo";
    o.customMetaData = "foo";
    o.etag = "foo";
    o.id = "foo";
    o.images = buildUnnamed1164();
    o.kind = "foo";
    o.labels = buildUnnamed1165();
    o.location = buildPostLocation();
    o.published = core.DateTime.parse("2002-02-27T14:01:02");
    o.readerComments = "foo";
    o.replies = buildPostReplies();
    o.selfLink = "foo";
    o.status = "foo";
    o.title = "foo";
    o.titleLink = "foo";
    o.updated = core.DateTime.parse("2002-02-27T14:01:02");
    o.url = "foo";
  }
  buildCounterPost--;
  return o;
}

checkPost(api.Post o) {
  buildCounterPost++;
  if (buildCounterPost < 3) {
    checkPostAuthor(o.author);
    checkPostBlog(o.blog);
    unittest.expect(o.content, unittest.equals('foo'));
    unittest.expect(o.customMetaData, unittest.equals('foo'));
    unittest.expect(o.etag, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    checkUnnamed1164(o.images);
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUnnamed1165(o.labels);
    checkPostLocation(o.location);
    unittest.expect(o.published, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.readerComments, unittest.equals('foo'));
    checkPostReplies(o.replies);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.status, unittest.equals('foo'));
    unittest.expect(o.title, unittest.equals('foo'));
    unittest.expect(o.titleLink, unittest.equals('foo'));
    unittest.expect(o.updated, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterPost--;
}

buildUnnamed1167() {
  var o = new core.List<api.Post>();
  o.add(buildPost());
  o.add(buildPost());
  return o;
}

checkUnnamed1167(core.List<api.Post> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPost(o[0]);
  checkPost(o[1]);
}

core.int buildCounterPostList = 0;
buildPostList() {
  var o = new api.PostList();
  buildCounterPostList++;
  if (buildCounterPostList < 3) {
    o.etag = "foo";
    o.items = buildUnnamed1167();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPostList--;
  return o;
}

checkPostList(api.PostList o) {
  buildCounterPostList++;
  if (buildCounterPostList < 3) {
    unittest.expect(o.etag, unittest.equals('foo'));
    checkUnnamed1167(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPostList--;
}

core.int buildCounterPostPerUserInfo = 0;
buildPostPerUserInfo() {
  var o = new api.PostPerUserInfo();
  buildCounterPostPerUserInfo++;
  if (buildCounterPostPerUserInfo < 3) {
    o.blogId = "foo";
    o.hasEditAccess = true;
    o.kind = "foo";
    o.postId = "foo";
    o.userId = "foo";
  }
  buildCounterPostPerUserInfo--;
  return o;
}

checkPostPerUserInfo(api.PostPerUserInfo o) {
  buildCounterPostPerUserInfo++;
  if (buildCounterPostPerUserInfo < 3) {
    unittest.expect(o.blogId, unittest.equals('foo'));
    unittest.expect(o.hasEditAccess, unittest.isTrue);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.postId, unittest.equals('foo'));
    unittest.expect(o.userId, unittest.equals('foo'));
  }
  buildCounterPostPerUserInfo--;
}

core.int buildCounterPostUserInfo = 0;
buildPostUserInfo() {
  var o = new api.PostUserInfo();
  buildCounterPostUserInfo++;
  if (buildCounterPostUserInfo < 3) {
    o.kind = "foo";
    o.post = buildPost();
    o.postUserInfo = buildPostPerUserInfo();
  }
  buildCounterPostUserInfo--;
  return o;
}

checkPostUserInfo(api.PostUserInfo o) {
  buildCounterPostUserInfo++;
  if (buildCounterPostUserInfo < 3) {
    unittest.expect(o.kind, unittest.equals('foo'));
    checkPost(o.post);
    checkPostPerUserInfo(o.postUserInfo);
  }
  buildCounterPostUserInfo--;
}

buildUnnamed1168() {
  var o = new core.List<api.PostUserInfo>();
  o.add(buildPostUserInfo());
  o.add(buildPostUserInfo());
  return o;
}

checkUnnamed1168(core.List<api.PostUserInfo> o) {
  unittest.expect(o, unittest.hasLength(2));
  checkPostUserInfo(o[0]);
  checkPostUserInfo(o[1]);
}

core.int buildCounterPostUserInfosList = 0;
buildPostUserInfosList() {
  var o = new api.PostUserInfosList();
  buildCounterPostUserInfosList++;
  if (buildCounterPostUserInfosList < 3) {
    o.items = buildUnnamed1168();
    o.kind = "foo";
    o.nextPageToken = "foo";
  }
  buildCounterPostUserInfosList--;
  return o;
}

checkPostUserInfosList(api.PostUserInfosList o) {
  buildCounterPostUserInfosList++;
  if (buildCounterPostUserInfosList < 3) {
    checkUnnamed1168(o.items);
    unittest.expect(o.kind, unittest.equals('foo'));
    unittest.expect(o.nextPageToken, unittest.equals('foo'));
  }
  buildCounterPostUserInfosList--;
}

core.int buildCounterUserBlogs = 0;
buildUserBlogs() {
  var o = new api.UserBlogs();
  buildCounterUserBlogs++;
  if (buildCounterUserBlogs < 3) {
    o.selfLink = "foo";
  }
  buildCounterUserBlogs--;
  return o;
}

checkUserBlogs(api.UserBlogs o) {
  buildCounterUserBlogs++;
  if (buildCounterUserBlogs < 3) {
    unittest.expect(o.selfLink, unittest.equals('foo'));
  }
  buildCounterUserBlogs--;
}

core.int buildCounterUserLocale = 0;
buildUserLocale() {
  var o = new api.UserLocale();
  buildCounterUserLocale++;
  if (buildCounterUserLocale < 3) {
    o.country = "foo";
    o.language = "foo";
    o.variant = "foo";
  }
  buildCounterUserLocale--;
  return o;
}

checkUserLocale(api.UserLocale o) {
  buildCounterUserLocale++;
  if (buildCounterUserLocale < 3) {
    unittest.expect(o.country, unittest.equals('foo'));
    unittest.expect(o.language, unittest.equals('foo'));
    unittest.expect(o.variant, unittest.equals('foo'));
  }
  buildCounterUserLocale--;
}

core.int buildCounterUser = 0;
buildUser() {
  var o = new api.User();
  buildCounterUser++;
  if (buildCounterUser < 3) {
    o.about = "foo";
    o.blogs = buildUserBlogs();
    o.created = core.DateTime.parse("2002-02-27T14:01:02");
    o.displayName = "foo";
    o.id = "foo";
    o.kind = "foo";
    o.locale = buildUserLocale();
    o.selfLink = "foo";
    o.url = "foo";
  }
  buildCounterUser--;
  return o;
}

checkUser(api.User o) {
  buildCounterUser++;
  if (buildCounterUser < 3) {
    unittest.expect(o.about, unittest.equals('foo'));
    checkUserBlogs(o.blogs);
    unittest.expect(o.created, unittest.equals(core.DateTime.parse("2002-02-27T14:01:02")));
    unittest.expect(o.displayName, unittest.equals('foo'));
    unittest.expect(o.id, unittest.equals('foo'));
    unittest.expect(o.kind, unittest.equals('foo'));
    checkUserLocale(o.locale);
    unittest.expect(o.selfLink, unittest.equals('foo'));
    unittest.expect(o.url, unittest.equals('foo'));
  }
  buildCounterUser--;
}

buildUnnamed1169() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1169(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1170() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1170(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1171() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1171(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1172() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1172(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1173() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1173(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1174() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1174(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1175() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1175(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}

buildUnnamed1176() {
  var o = new core.List<core.String>();
  o.add("foo");
  o.add("foo");
  return o;
}

checkUnnamed1176(core.List<core.String> o) {
  unittest.expect(o, unittest.hasLength(2));
  unittest.expect(o[0], unittest.equals('foo'));
  unittest.expect(o[1], unittest.equals('foo'));
}


main() {
  unittest.group("obj-schema-BlogLocale", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogLocale();
      var od = new api.BlogLocale.fromJson(o.toJson());
      checkBlogLocale(od);
    });
  });


  unittest.group("obj-schema-BlogPages", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogPages();
      var od = new api.BlogPages.fromJson(o.toJson());
      checkBlogPages(od);
    });
  });


  unittest.group("obj-schema-BlogPosts", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogPosts();
      var od = new api.BlogPosts.fromJson(o.toJson());
      checkBlogPosts(od);
    });
  });


  unittest.group("obj-schema-Blog", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlog();
      var od = new api.Blog.fromJson(o.toJson());
      checkBlog(od);
    });
  });


  unittest.group("obj-schema-BlogList", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogList();
      var od = new api.BlogList.fromJson(o.toJson());
      checkBlogList(od);
    });
  });


  unittest.group("obj-schema-BlogPerUserInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogPerUserInfo();
      var od = new api.BlogPerUserInfo.fromJson(o.toJson());
      checkBlogPerUserInfo(od);
    });
  });


  unittest.group("obj-schema-BlogUserInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildBlogUserInfo();
      var od = new api.BlogUserInfo.fromJson(o.toJson());
      checkBlogUserInfo(od);
    });
  });


  unittest.group("obj-schema-CommentAuthorImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentAuthorImage();
      var od = new api.CommentAuthorImage.fromJson(o.toJson());
      checkCommentAuthorImage(od);
    });
  });


  unittest.group("obj-schema-CommentAuthor", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentAuthor();
      var od = new api.CommentAuthor.fromJson(o.toJson());
      checkCommentAuthor(od);
    });
  });


  unittest.group("obj-schema-CommentBlog", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentBlog();
      var od = new api.CommentBlog.fromJson(o.toJson());
      checkCommentBlog(od);
    });
  });


  unittest.group("obj-schema-CommentInReplyTo", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentInReplyTo();
      var od = new api.CommentInReplyTo.fromJson(o.toJson());
      checkCommentInReplyTo(od);
    });
  });


  unittest.group("obj-schema-CommentPost", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentPost();
      var od = new api.CommentPost.fromJson(o.toJson());
      checkCommentPost(od);
    });
  });


  unittest.group("obj-schema-Comment", () {
    unittest.test("to-json--from-json", () {
      var o = buildComment();
      var od = new api.Comment.fromJson(o.toJson());
      checkComment(od);
    });
  });


  unittest.group("obj-schema-CommentList", () {
    unittest.test("to-json--from-json", () {
      var o = buildCommentList();
      var od = new api.CommentList.fromJson(o.toJson());
      checkCommentList(od);
    });
  });


  unittest.group("obj-schema-PageAuthorImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageAuthorImage();
      var od = new api.PageAuthorImage.fromJson(o.toJson());
      checkPageAuthorImage(od);
    });
  });


  unittest.group("obj-schema-PageAuthor", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageAuthor();
      var od = new api.PageAuthor.fromJson(o.toJson());
      checkPageAuthor(od);
    });
  });


  unittest.group("obj-schema-PageBlog", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageBlog();
      var od = new api.PageBlog.fromJson(o.toJson());
      checkPageBlog(od);
    });
  });


  unittest.group("obj-schema-Page", () {
    unittest.test("to-json--from-json", () {
      var o = buildPage();
      var od = new api.Page.fromJson(o.toJson());
      checkPage(od);
    });
  });


  unittest.group("obj-schema-PageList", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageList();
      var od = new api.PageList.fromJson(o.toJson());
      checkPageList(od);
    });
  });


  unittest.group("obj-schema-PageviewsCounts", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageviewsCounts();
      var od = new api.PageviewsCounts.fromJson(o.toJson());
      checkPageviewsCounts(od);
    });
  });


  unittest.group("obj-schema-Pageviews", () {
    unittest.test("to-json--from-json", () {
      var o = buildPageviews();
      var od = new api.Pageviews.fromJson(o.toJson());
      checkPageviews(od);
    });
  });


  unittest.group("obj-schema-PostAuthorImage", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostAuthorImage();
      var od = new api.PostAuthorImage.fromJson(o.toJson());
      checkPostAuthorImage(od);
    });
  });


  unittest.group("obj-schema-PostAuthor", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostAuthor();
      var od = new api.PostAuthor.fromJson(o.toJson());
      checkPostAuthor(od);
    });
  });


  unittest.group("obj-schema-PostBlog", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostBlog();
      var od = new api.PostBlog.fromJson(o.toJson());
      checkPostBlog(od);
    });
  });


  unittest.group("obj-schema-PostImages", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostImages();
      var od = new api.PostImages.fromJson(o.toJson());
      checkPostImages(od);
    });
  });


  unittest.group("obj-schema-PostLocation", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostLocation();
      var od = new api.PostLocation.fromJson(o.toJson());
      checkPostLocation(od);
    });
  });


  unittest.group("obj-schema-PostReplies", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostReplies();
      var od = new api.PostReplies.fromJson(o.toJson());
      checkPostReplies(od);
    });
  });


  unittest.group("obj-schema-Post", () {
    unittest.test("to-json--from-json", () {
      var o = buildPost();
      var od = new api.Post.fromJson(o.toJson());
      checkPost(od);
    });
  });


  unittest.group("obj-schema-PostList", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostList();
      var od = new api.PostList.fromJson(o.toJson());
      checkPostList(od);
    });
  });


  unittest.group("obj-schema-PostPerUserInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostPerUserInfo();
      var od = new api.PostPerUserInfo.fromJson(o.toJson());
      checkPostPerUserInfo(od);
    });
  });


  unittest.group("obj-schema-PostUserInfo", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostUserInfo();
      var od = new api.PostUserInfo.fromJson(o.toJson());
      checkPostUserInfo(od);
    });
  });


  unittest.group("obj-schema-PostUserInfosList", () {
    unittest.test("to-json--from-json", () {
      var o = buildPostUserInfosList();
      var od = new api.PostUserInfosList.fromJson(o.toJson());
      checkPostUserInfosList(od);
    });
  });


  unittest.group("obj-schema-UserBlogs", () {
    unittest.test("to-json--from-json", () {
      var o = buildUserBlogs();
      var od = new api.UserBlogs.fromJson(o.toJson());
      checkUserBlogs(od);
    });
  });


  unittest.group("obj-schema-UserLocale", () {
    unittest.test("to-json--from-json", () {
      var o = buildUserLocale();
      var od = new api.UserLocale.fromJson(o.toJson());
      checkUserLocale(od);
    });
  });


  unittest.group("obj-schema-User", () {
    unittest.test("to-json--from-json", () {
      var o = buildUser();
      var od = new api.User.fromJson(o.toJson());
      checkUser(od);
    });
  });


  unittest.group("resource-BlogUserInfosResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.BlogUserInfosResourceApi res = new api.BloggerApi(mock).blogUserInfos;
      var arg_userId = "foo";
      var arg_blogId = "foo";
      var arg_maxPosts = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/blogs/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/blogs/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["maxPosts"].first), unittest.equals(arg_maxPosts));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBlogUserInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_userId, arg_blogId, maxPosts: arg_maxPosts).then(unittest.expectAsync(((api.BlogUserInfo response) {
        checkBlogUserInfo(response);
      })));
    });

  });


  unittest.group("resource-BlogsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.BlogsResourceApi res = new api.BloggerApi(mock).blogs;
      var arg_blogId = "foo";
      var arg_maxPosts = 42;
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["maxPosts"].first), unittest.equals(arg_maxPosts));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBlog());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_blogId, maxPosts: arg_maxPosts, view: arg_view).then(unittest.expectAsync(((api.Blog response) {
        checkBlog(response);
      })));
    });

    unittest.test("method--getByUrl", () {

      var mock = new HttpServerMock();
      api.BlogsResourceApi res = new api.BloggerApi(mock).blogs;
      var arg_url = "foo";
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogs/byurl"));
        pathOffset += 11;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["url"].first, unittest.equals(arg_url));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBlog());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getByUrl(arg_url, view: arg_view).then(unittest.expectAsync(((api.Blog response) {
        checkBlog(response);
      })));
    });

    unittest.test("method--listByUser", () {

      var mock = new HttpServerMock();
      api.BlogsResourceApi res = new api.BloggerApi(mock).blogs;
      var arg_userId = "foo";
      var arg_fetchUserInfo = true;
      var arg_role = buildUnnamed1169();
      var arg_status = buildUnnamed1170();
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/blogs", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/blogs"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchUserInfo"].first, unittest.equals("$arg_fetchUserInfo"));
        unittest.expect(queryMap["role"], unittest.equals(arg_role));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildBlogList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listByUser(arg_userId, fetchUserInfo: arg_fetchUserInfo, role: arg_role, status: arg_status, view: arg_view).then(unittest.expectAsync(((api.BlogList response) {
        checkBlogList(response);
      })));
    });

  });


  unittest.group("resource-CommentsResourceApi", () {
    unittest.test("method--approve", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_commentId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/comments/"));
        pathOffset += 10;
        index = path.indexOf("/approve", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_commentId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/approve"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildComment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.approve(arg_blogId, arg_postId, arg_commentId).then(unittest.expectAsync(((api.Comment response) {
        checkComment(response);
      })));
    });

    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_commentId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/comments/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_commentId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_blogId, arg_postId, arg_commentId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_commentId = "foo";
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/comments/"));
        pathOffset += 10;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_commentId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildComment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_blogId, arg_postId, arg_commentId, view: arg_view).then(unittest.expectAsync(((api.Comment response) {
        checkComment(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_endDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_fetchBodies = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_startDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_status = buildUnnamed1171();
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/comments"));
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.DateTime.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.DateTime.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCommentList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_blogId, arg_postId, endDate: arg_endDate, fetchBodies: arg_fetchBodies, maxResults: arg_maxResults, pageToken: arg_pageToken, startDate: arg_startDate, status: arg_status, view: arg_view).then(unittest.expectAsync(((api.CommentList response) {
        checkCommentList(response);
      })));
    });

    unittest.test("method--listByBlog", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_endDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_fetchBodies = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_startDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_status = buildUnnamed1172();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/comments", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 9), unittest.equals("/comments"));
        pathOffset += 9;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.DateTime.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.DateTime.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildCommentList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.listByBlog(arg_blogId, endDate: arg_endDate, fetchBodies: arg_fetchBodies, maxResults: arg_maxResults, pageToken: arg_pageToken, startDate: arg_startDate, status: arg_status).then(unittest.expectAsync(((api.CommentList response) {
        checkCommentList(response);
      })));
    });

    unittest.test("method--markAsSpam", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_commentId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/comments/"));
        pathOffset += 10;
        index = path.indexOf("/spam", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_commentId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 5), unittest.equals("/spam"));
        pathOffset += 5;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildComment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.markAsSpam(arg_blogId, arg_postId, arg_commentId).then(unittest.expectAsync(((api.Comment response) {
        checkComment(response);
      })));
    });

    unittest.test("method--removeContent", () {

      var mock = new HttpServerMock();
      api.CommentsResourceApi res = new api.BloggerApi(mock).comments;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_commentId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/comments/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/comments/"));
        pathOffset += 10;
        index = path.indexOf("/removecontent", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_commentId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 14), unittest.equals("/removecontent"));
        pathOffset += 14;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildComment());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.removeContent(arg_blogId, arg_postId, arg_commentId).then(unittest.expectAsync(((api.Comment response) {
        checkComment(response);
      })));
    });

  });


  unittest.group("resource-PageViewsResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PageViewsResourceApi res = new api.BloggerApi(mock).pageViews;
      var arg_blogId = "foo";
      var arg_range = buildUnnamed1173();
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pageviews", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 10), unittest.equals("/pageviews"));
        pathOffset += 10;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["range"], unittest.equals(arg_range));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPageviews());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_blogId, range: arg_range).then(unittest.expectAsync(((api.Pageviews response) {
        checkPageviews(response);
      })));
    });

  });


  unittest.group("resource-PagesResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_blogId, arg_pageId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_blogId, arg_pageId, view: arg_view).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_request = buildPage();
      var arg_blogId = "foo";
      var arg_isDraft = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Page.fromJson(json);
        checkPage(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/pages"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["isDraft"].first, unittest.equals("$arg_isDraft"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_blogId, isDraft: arg_isDraft).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_blogId = "foo";
      var arg_fetchBodies = true;
      var arg_maxResults = 42;
      var arg_pageToken = "foo";
      var arg_status = buildUnnamed1174();
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/pages"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPageList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_blogId, fetchBodies: arg_fetchBodies, maxResults: arg_maxResults, pageToken: arg_pageToken, status: arg_status, view: arg_view).then(unittest.expectAsync(((api.PageList response) {
        checkPageList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_request = buildPage();
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      var arg_publish_1 = true;
      var arg_revert_1 = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Page.fromJson(json);
        checkPage(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["publish"].first, unittest.equals("$arg_publish_1"));
        unittest.expect(queryMap["revert"].first, unittest.equals("$arg_revert_1"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_blogId, arg_pageId, publish_1: arg_publish_1, revert_1: arg_revert_1).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

    unittest.test("method--publish", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        index = path.indexOf("/publish", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/publish"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.publish(arg_blogId, arg_pageId).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

    unittest.test("method--revert", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        index = path.indexOf("/revert", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/revert"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.revert(arg_blogId, arg_pageId).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.PagesResourceApi res = new api.BloggerApi(mock).pages;
      var arg_request = buildPage();
      var arg_blogId = "foo";
      var arg_pageId = "foo";
      var arg_publish_1 = true;
      var arg_revert_1 = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Page.fromJson(json);
        checkPage(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/pages/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/pages/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_pageId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["publish"].first, unittest.equals("$arg_publish_1"));
        unittest.expect(queryMap["revert"].first, unittest.equals("$arg_revert_1"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPage());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_blogId, arg_pageId, publish_1: arg_publish_1, revert_1: arg_revert_1).then(unittest.expectAsync(((api.Page response) {
        checkPage(response);
      })));
    });

  });


  unittest.group("resource-PostUserInfosResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PostUserInfosResourceApi res = new api.BloggerApi(mock).postUserInfos;
      var arg_userId = "foo";
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_maxComments = 42;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/blogs/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/blogs/"));
        pathOffset += 7;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_postId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.int.parse(queryMap["maxComments"].first), unittest.equals(arg_maxComments));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPostUserInfo());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_userId, arg_blogId, arg_postId, maxComments: arg_maxComments).then(unittest.expectAsync(((api.PostUserInfo response) {
        checkPostUserInfo(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.PostUserInfosResourceApi res = new api.BloggerApi(mock).postUserInfos;
      var arg_userId = "foo";
      var arg_blogId = "foo";
      var arg_endDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_fetchBodies = true;
      var arg_labels = "foo";
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_pageToken = "foo";
      var arg_startDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_status = buildUnnamed1175();
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        index = path.indexOf("/blogs/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_userId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/blogs/"));
        pathOffset += 7;
        index = path.indexOf("/posts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/posts"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.DateTime.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(queryMap["labels"].first, unittest.equals(arg_labels));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.DateTime.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPostUserInfosList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_userId, arg_blogId, endDate: arg_endDate, fetchBodies: arg_fetchBodies, labels: arg_labels, maxResults: arg_maxResults, orderBy: arg_orderBy, pageToken: arg_pageToken, startDate: arg_startDate, status: arg_status, view: arg_view).then(unittest.expectAsync(((api.PostUserInfosList response) {
        checkPostUserInfosList(response);
      })));
    });

  });


  unittest.group("resource-PostsResourceApi", () {
    unittest.test("method--delete", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_postId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = "";
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.delete(arg_blogId, arg_postId).then(unittest.expectAsync((_) {}));
    });

    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_fetchBody = true;
      var arg_fetchImages = true;
      var arg_maxComments = 42;
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_postId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchBody"].first, unittest.equals("$arg_fetchBody"));
        unittest.expect(queryMap["fetchImages"].first, unittest.equals("$arg_fetchImages"));
        unittest.expect(core.int.parse(queryMap["maxComments"].first), unittest.equals(arg_maxComments));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_blogId, arg_postId, fetchBody: arg_fetchBody, fetchImages: arg_fetchImages, maxComments: arg_maxComments, view: arg_view).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--getByPath", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_path = "foo";
      var arg_maxComments = 42;
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/bypath", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/posts/bypath"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["path"].first, unittest.equals(arg_path));
        unittest.expect(core.int.parse(queryMap["maxComments"].first), unittest.equals(arg_maxComments));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.getByPath(arg_blogId, arg_path, maxComments: arg_maxComments, view: arg_view).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--insert", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_request = buildPost();
      var arg_blogId = "foo";
      var arg_fetchBody = true;
      var arg_fetchImages = true;
      var arg_isDraft = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Post.fromJson(json);
        checkPost(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/posts"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchBody"].first, unittest.equals("$arg_fetchBody"));
        unittest.expect(queryMap["fetchImages"].first, unittest.equals("$arg_fetchImages"));
        unittest.expect(queryMap["isDraft"].first, unittest.equals("$arg_isDraft"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.insert(arg_request, arg_blogId, fetchBody: arg_fetchBody, fetchImages: arg_fetchImages, isDraft: arg_isDraft).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--list", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_endDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_fetchBodies = true;
      var arg_fetchImages = true;
      var arg_labels = "foo";
      var arg_maxResults = 42;
      var arg_orderBy = "foo";
      var arg_pageToken = "foo";
      var arg_startDate = core.DateTime.parse("2002-02-27T14:01:02");
      var arg_status = buildUnnamed1176();
      var arg_view = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("/posts"));
        pathOffset += 6;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.DateTime.parse(queryMap["endDate"].first), unittest.equals(arg_endDate));
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(queryMap["fetchImages"].first, unittest.equals("$arg_fetchImages"));
        unittest.expect(queryMap["labels"].first, unittest.equals(arg_labels));
        unittest.expect(core.int.parse(queryMap["maxResults"].first), unittest.equals(arg_maxResults));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));
        unittest.expect(queryMap["pageToken"].first, unittest.equals(arg_pageToken));
        unittest.expect(core.DateTime.parse(queryMap["startDate"].first), unittest.equals(arg_startDate));
        unittest.expect(queryMap["status"], unittest.equals(arg_status));
        unittest.expect(queryMap["view"].first, unittest.equals(arg_view));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPostList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.list(arg_blogId, endDate: arg_endDate, fetchBodies: arg_fetchBodies, fetchImages: arg_fetchImages, labels: arg_labels, maxResults: arg_maxResults, orderBy: arg_orderBy, pageToken: arg_pageToken, startDate: arg_startDate, status: arg_status, view: arg_view).then(unittest.expectAsync(((api.PostList response) {
        checkPostList(response);
      })));
    });

    unittest.test("method--patch", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_request = buildPost();
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_fetchBody = true;
      var arg_fetchImages = true;
      var arg_maxComments = 42;
      var arg_publish_1 = true;
      var arg_revert_1 = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Post.fromJson(json);
        checkPost(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_postId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchBody"].first, unittest.equals("$arg_fetchBody"));
        unittest.expect(queryMap["fetchImages"].first, unittest.equals("$arg_fetchImages"));
        unittest.expect(core.int.parse(queryMap["maxComments"].first), unittest.equals(arg_maxComments));
        unittest.expect(queryMap["publish"].first, unittest.equals("$arg_publish_1"));
        unittest.expect(queryMap["revert"].first, unittest.equals("$arg_revert_1"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.patch(arg_request, arg_blogId, arg_postId, fetchBody: arg_fetchBody, fetchImages: arg_fetchImages, maxComments: arg_maxComments, publish_1: arg_publish_1, revert_1: arg_revert_1).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--publish", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_publishDate = core.DateTime.parse("2002-02-27T14:01:02");
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/publish", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 8), unittest.equals("/publish"));
        pathOffset += 8;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(core.DateTime.parse(queryMap["publishDate"].first), unittest.equals(arg_publishDate));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.publish(arg_blogId, arg_postId, publishDate: arg_publishDate).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--revert", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_postId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        index = path.indexOf("/revert", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_postId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/revert"));
        pathOffset += 7;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.revert(arg_blogId, arg_postId).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

    unittest.test("method--search", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_blogId = "foo";
      var arg_q = "foo";
      var arg_fetchBodies = true;
      var arg_orderBy = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/search", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 13), unittest.equals("/posts/search"));
        pathOffset += 13;

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["q"].first, unittest.equals(arg_q));
        unittest.expect(queryMap["fetchBodies"].first, unittest.equals("$arg_fetchBodies"));
        unittest.expect(queryMap["orderBy"].first, unittest.equals(arg_orderBy));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPostList());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.search(arg_blogId, arg_q, fetchBodies: arg_fetchBodies, orderBy: arg_orderBy).then(unittest.expectAsync(((api.PostList response) {
        checkPostList(response);
      })));
    });

    unittest.test("method--update", () {

      var mock = new HttpServerMock();
      api.PostsResourceApi res = new api.BloggerApi(mock).posts;
      var arg_request = buildPost();
      var arg_blogId = "foo";
      var arg_postId = "foo";
      var arg_fetchBody = true;
      var arg_fetchImages = true;
      var arg_maxComments = 42;
      var arg_publish_1 = true;
      var arg_revert_1 = true;
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var obj = new api.Post.fromJson(json);
        checkPost(obj);

        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("blogs/"));
        pathOffset += 6;
        index = path.indexOf("/posts/", pathOffset);
        unittest.expect(index >= 0, unittest.isTrue);
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset, index));
        pathOffset = index;
        unittest.expect(subPart, unittest.equals("$arg_blogId"));
        unittest.expect(path.substring(pathOffset, pathOffset + 7), unittest.equals("/posts/"));
        pathOffset += 7;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_postId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }
        unittest.expect(queryMap["fetchBody"].first, unittest.equals("$arg_fetchBody"));
        unittest.expect(queryMap["fetchImages"].first, unittest.equals("$arg_fetchImages"));
        unittest.expect(core.int.parse(queryMap["maxComments"].first), unittest.equals(arg_maxComments));
        unittest.expect(queryMap["publish"].first, unittest.equals("$arg_publish_1"));
        unittest.expect(queryMap["revert"].first, unittest.equals("$arg_revert_1"));


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildPost());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.update(arg_request, arg_blogId, arg_postId, fetchBody: arg_fetchBody, fetchImages: arg_fetchImages, maxComments: arg_maxComments, publish_1: arg_publish_1, revert_1: arg_revert_1).then(unittest.expectAsync(((api.Post response) {
        checkPost(response);
      })));
    });

  });


  unittest.group("resource-UsersResourceApi", () {
    unittest.test("method--get", () {

      var mock = new HttpServerMock();
      api.UsersResourceApi res = new api.BloggerApi(mock).users;
      var arg_userId = "foo";
      mock.register(unittest.expectAsync((http.BaseRequest req, json) {
        var path = (req.url).path;
        var pathOffset = 0;
        var index;
        var subPart;
        unittest.expect(path.substring(pathOffset, pathOffset + 1), unittest.equals("/"));
        pathOffset += 1;
        unittest.expect(path.substring(pathOffset, pathOffset + 11), unittest.equals("blogger/v3/"));
        pathOffset += 11;
        unittest.expect(path.substring(pathOffset, pathOffset + 6), unittest.equals("users/"));
        pathOffset += 6;
        subPart = core.Uri.decodeQueryComponent(path.substring(pathOffset));
        pathOffset = path.length;
        unittest.expect(subPart, unittest.equals("$arg_userId"));

        var query = (req.url).query;
        var queryOffset = 0;
        var queryMap = {};
        addQueryParam(n, v) => queryMap.putIfAbsent(n, () => []).add(v);
        parseBool(n) {
          if (n == "true") return true;
          if (n == "false") return false;
          if (n == null) return null;
          throw new core.ArgumentError("Invalid boolean: $n");
        }
        if (query.length > 0) {
          for (var part in query.split("&")) {
            var keyvalue = part.split("=");
            addQueryParam(core.Uri.decodeQueryComponent(keyvalue[0]), core.Uri.decodeQueryComponent(keyvalue[1]));
          }
        }


        var h = {
          "content-type" : "application/json; charset=utf-8",
        };
        var resp = convert.JSON.encode(buildUser());
        return new async.Future.value(stringResponse(200, h, resp));
      }), true);
      res.get(arg_userId).then(unittest.expectAsync(((api.User response) {
        checkUser(response);
      })));
    });

  });


}

