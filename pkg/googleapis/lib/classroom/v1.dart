// This is a generated file (see the discoveryapis_generator project).

library googleapis.classroom.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client classroom/v1';

/** Manages classes, rosters, and invitations in Google Classroom. */
class ClassroomApi {
  /**
   * View instructions for teacher-assigned work in your Google Classroom
   * classes
   */
  static const ClassroomCourseWorkReadonlyScope = "https://www.googleapis.com/auth/classroom.course-work.readonly";

  /** Manage your Google Classroom classes */
  static const ClassroomCoursesScope = "https://www.googleapis.com/auth/classroom.courses";

  /** View your Google Classroom classes */
  static const ClassroomCoursesReadonlyScope = "https://www.googleapis.com/auth/classroom.courses.readonly";

  /** Manage your course work and view your grades in Google Classroom */
  static const ClassroomCourseworkMeScope = "https://www.googleapis.com/auth/classroom.coursework.me";

  /** View your course work and grades in Google Classroom */
  static const ClassroomCourseworkMeReadonlyScope = "https://www.googleapis.com/auth/classroom.coursework.me.readonly";

  /**
   * Manage course work and grades for students in the Google Classroom classes
   * you teach and view the course work and grades for classes you administer
   */
  static const ClassroomCourseworkStudentsScope = "https://www.googleapis.com/auth/classroom.coursework.students";

  /**
   * View course work and grades for students in the Google Classroom classes
   * you teach or administer
   */
  static const ClassroomCourseworkStudentsReadonlyScope = "https://www.googleapis.com/auth/classroom.coursework.students.readonly";

  /** View the email addresses of people in your classes */
  static const ClassroomProfileEmailsScope = "https://www.googleapis.com/auth/classroom.profile.emails";

  /** View the profile photos of people in your classes */
  static const ClassroomProfilePhotosScope = "https://www.googleapis.com/auth/classroom.profile.photos";

  /** Manage your Google Classroom class rosters */
  static const ClassroomRostersScope = "https://www.googleapis.com/auth/classroom.rosters";

  /** View your Google Classroom class rosters */
  static const ClassroomRostersReadonlyScope = "https://www.googleapis.com/auth/classroom.rosters.readonly";

  /** View your course work and grades in Google Classroom */
  static const ClassroomStudentSubmissionsMeReadonlyScope = "https://www.googleapis.com/auth/classroom.student-submissions.me.readonly";

  /**
   * View course work and grades for students in the Google Classroom classes
   * you teach or administer
   */
  static const ClassroomStudentSubmissionsStudentsReadonlyScope = "https://www.googleapis.com/auth/classroom.student-submissions.students.readonly";


  final commons.ApiRequester _requester;

  CoursesResourceApi get courses => new CoursesResourceApi(_requester);
  InvitationsResourceApi get invitations => new InvitationsResourceApi(_requester);
  UserProfilesResourceApi get userProfiles => new UserProfilesResourceApi(_requester);

  ClassroomApi(http.Client client, {core.String rootUrl: "https://classroom.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class CoursesResourceApi {
  final commons.ApiRequester _requester;

  CoursesAliasesResourceApi get aliases => new CoursesAliasesResourceApi(_requester);
  CoursesCourseWorkResourceApi get courseWork => new CoursesCourseWorkResourceApi(_requester);
  CoursesStudentsResourceApi get students => new CoursesStudentsResourceApi(_requester);
  CoursesTeachersResourceApi get teachers => new CoursesTeachersResourceApi(_requester);

  CoursesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a course. The user specified in `ownerId` is the owner of the
   * created course and added as a teacher. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to create courses or for access errors. * `NOT_FOUND` if the primary
   * teacher is not a valid user. * `FAILED_PRECONDITION` if the course owner's
   * account is disabled or for the following request errors: *
   * UserGroupsMembershipLimitReached * `ALREADY_EXISTS` if an alias was
   * specified in the `id` and already exists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Course].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Course> create(Course request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/courses';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Course.fromJson(data));
  }

  /**
   * Deletes a course. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to delete the
   * requested course or for access errors. * `NOT_FOUND` if no course exists
   * with the requested ID.
   *
   * Request parameters:
   *
   * [id] - Identifier of the course to delete. This identifier can be either
   * the Classroom-assigned identifier or an alias.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a course. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to access the
   * requested course or for access errors. * `NOT_FOUND` if no course exists
   * with the requested ID.
   *
   * Request parameters:
   *
   * [id] - Identifier of the course to return. This identifier can be either
   * the Classroom-assigned identifier or an alias.
   *
   * Completes with a [Course].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Course> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Course.fromJson(data));
  }

  /**
   * Returns a list of courses that the requesting user is permitted to view,
   * restricted to those that match the request. This method returns the
   * following error codes: * `PERMISSION_DENIED` for access errors. *
   * `INVALID_ARGUMENT` if the query argument is malformed. * `NOT_FOUND` if any
   * users specified in the query arguments do not exist.
   *
   * Request parameters:
   *
   * [studentId] - Restricts returned courses to those having a student with the
   * specified identifier. The identifier can be one of the following: * the
   * numeric identifier for the user * the email address of the user * the
   * string literal `"me"`, indicating the requesting user
   *
   * [teacherId] - Restricts returned courses to those having a teacher with the
   * specified identifier. The identifier can be one of the following: * the
   * numeric identifier for the user * the email address of the user * the
   * string literal `"me"`, indicating the requesting user
   *
   * [courseStates] - Restricts returned courses to those in one of the
   * specified states
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListCoursesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListCoursesResponse> list({core.String studentId, core.String teacherId, core.List<core.String> courseStates, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId != null) {
      _queryParams["studentId"] = [studentId];
    }
    if (teacherId != null) {
      _queryParams["teacherId"] = [teacherId];
    }
    if (courseStates != null) {
      _queryParams["courseStates"] = courseStates;
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCoursesResponse.fromJson(data));
  }

  /**
   * Updates one or more fields in a course. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to modify the requested course or for access errors. * `NOT_FOUND` if no
   * course exists with the requested ID. * `INVALID_ARGUMENT` if invalid fields
   * are specified in the update mask or if no update mask is supplied. *
   * `FAILED_PRECONDITION` for the following request errors: *
   * CourseNotModifiable
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - Identifier of the course to update. This identifier can be either
   * the Classroom-assigned identifier or an alias.
   *
   * [updateMask] - Mask that identifies which fields on the course to update.
   * This field is required to do an update. The update will fail if invalid
   * fields are specified. The following fields are valid: * `name` * `section`
   * * `descriptionHeading` * `description` * `room` * `courseState` When set in
   * a query parameter, this field should be specified as `updateMask=,,...`
   *
   * Completes with a [Course].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Course> patch(Course request, core.String id, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Course.fromJson(data));
  }

  /**
   * Updates a course. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to modify the
   * requested course or for access errors. * `NOT_FOUND` if no course exists
   * with the requested ID. * `FAILED_PRECONDITION` for the following request
   * errors: * CourseNotModifiable
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [id] - Identifier of the course to update. This identifier can be either
   * the Classroom-assigned identifier or an alias.
   *
   * Completes with a [Course].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Course> update(Course request, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Course.fromJson(data));
  }

}


class CoursesAliasesResourceApi {
  final commons.ApiRequester _requester;

  CoursesAliasesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates an alias for a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * create the alias or for access errors. * `NOT_FOUND` if the course does not
   * exist. * `ALREADY_EXISTS` if the alias already exists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course to alias. This identifier can be
   * either the Classroom-assigned identifier or an alias.
   *
   * Completes with a [CourseAlias].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CourseAlias> create(CourseAlias request, core.String courseId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/aliases';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CourseAlias.fromJson(data));
  }

  /**
   * Deletes an alias of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * remove the alias or for access errors. * `NOT_FOUND` if the alias does not
   * exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course whose alias should be deleted. This
   * identifier can be either the Classroom-assigned identifier or an alias.
   *
   * [alias] - Alias to delete. This may not be the Classroom-assigned
   * identifier.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String courseId, core.String alias) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (alias == null) {
      throw new core.ArgumentError("Parameter alias is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/aliases/' + commons.Escaper.ecapeVariable('$alias');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a list of aliases for a course. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to access the course or for access errors. * `NOT_FOUND` if the course does
   * not exist.
   *
   * Request parameters:
   *
   * [courseId] - The identifier of the course. This identifier can be either
   * the Classroom-assigned identifier or an alias.
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListCourseAliasesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListCourseAliasesResponse> list(core.String courseId, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/aliases';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCourseAliasesResponse.fromJson(data));
  }

}


class CoursesCourseWorkResourceApi {
  final commons.ApiRequester _requester;

  CoursesCourseWorkStudentSubmissionsResourceApi get studentSubmissions => new CoursesCourseWorkStudentSubmissionsResourceApi(_requester);

  CoursesCourseWorkResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates course work. The resulting course work (and corresponding student
   * submissions) are associated with the Developer Console project of the
   * [OAuth client ID](https://support.google.com/cloud/answer/6158849) used to
   * make the request. Classroom API requests to modify course work and student
   * submissions must be made with an OAuth client ID from the associated
   * Developer Console project. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to access the
   * requested course, create course work in the requested course, share a Drive
   * attachment, or for access errors. * `INVALID_ARGUMENT` if the request is
   * malformed. * `NOT_FOUND` if the requested course does not exist. *
   * `FAILED_PRECONDITION` for the following request error: *
   * AttachmentNotVisible
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * Completes with a [CourseWork].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CourseWork> create(CourseWork request, core.String courseId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CourseWork.fromJson(data));
  }

  /**
   * Deletes a course work. This request must be made by the Developer Console
   * project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting developer project did not
   * create the corresponding course work, if the requesting user is not
   * permitted to delete the requested course or for access errors. *
   * `FAILED_PRECONDITION` if the requested course work has already been
   * deleted. * `NOT_FOUND` if no course exists with the requested ID.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [id] - Identifier of the course work to delete. This identifier is a
   * Classroom-assigned identifier.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String courseId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns course work. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to access the
   * requested course or course work, or for access errors. * `INVALID_ARGUMENT`
   * if the request is malformed. * `NOT_FOUND` if the requested course or
   * course work does not exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [id] - Identifier of the course work.
   *
   * Completes with a [CourseWork].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CourseWork> get(core.String courseId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CourseWork.fromJson(data));
  }

  /**
   * Returns a list of course work that the requester is permitted to view.
   * Course students may only view `PUBLISHED` course work. Course teachers and
   * domain administrators may view all course work. This method returns the
   * following error codes: * `PERMISSION_DENIED` if the requesting user is not
   * permitted to access the requested course or for access errors. *
   * `INVALID_ARGUMENT` if the request is malformed. * `NOT_FOUND` if the
   * requested course does not exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkStates] - Restriction on the work status to return. Only
   * courseWork that matches is returned. If unspecified, items with a work
   * status of `PUBLISHED` is returned.
   *
   * [orderBy] - Optional sort ordering for results. A comma-separated list of
   * fields with an optional sort direction keyword. Supported fields are
   * `updateTime` and `dueDate`. Supported direction keywords are `asc` and
   * `desc`. If not specified, `updateTime desc` is the default behavior.
   * Examples: `dueDate asc,updateTime desc`, `updateTime,dueDate desc`
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListCourseWorkResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListCourseWorkResponse> list(core.String courseId, {core.List<core.String> courseWorkStates, core.String orderBy, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkStates != null) {
      _queryParams["courseWorkStates"] = courseWorkStates;
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCourseWorkResponse.fromJson(data));
  }

  /**
   * Updates one or more fields of a course work. See
   * google.classroom.v1.CourseWork for details of which fields may be updated
   * and who may change them. This request must be made by the Developer Console
   * project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting developer project did not
   * create the corresponding course work, if the user is not permitted to make
   * the requested modification to the student submission, or for access errors.
   * * `INVALID_ARGUMENT` if the request is malformed. * `FAILED_PRECONDITION`
   * if the requested course work has already been deleted. * `NOT_FOUND` if the
   * requested course, course work, or student submission does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [id] - Identifier of the course work.
   *
   * [updateMask] - Mask that identifies which fields on the course work to
   * update. This field is required to do an update. The update fails if invalid
   * fields are specified. If a field supports empty values, it can be cleared
   * by specifying it in the update mask and not in the CourseWork object. If a
   * field that does not support empty values is included in the update mask and
   * not set in the CourseWork object, an `INVALID_ARGUMENT` error will be
   * returned. The following fields may be specified by teachers: * `title` *
   * `description` * `state` * `due_date` * `due_time` * `max_points` *
   * `submission_modification_mode`
   *
   * Completes with a [CourseWork].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CourseWork> patch(CourseWork request, core.String courseId, core.String id, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CourseWork.fromJson(data));
  }

}


class CoursesCourseWorkStudentSubmissionsResourceApi {
  final commons.ApiRequester _requester;

  CoursesCourseWorkStudentSubmissionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a student submission. * `PERMISSION_DENIED` if the requesting user
   * is not permitted to access the requested course, course work, or student
   * submission or for access errors. * `INVALID_ARGUMENT` if the request is
   * malformed. * `NOT_FOUND` if the requested course, course work, or student
   * submission does not exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * Completes with a [StudentSubmission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<StudentSubmission> get(core.String courseId, core.String courseWorkId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new StudentSubmission.fromJson(data));
  }

  /**
   * Returns a list of student submissions that the requester is permitted to
   * view, factoring in the OAuth scopes of the request. `-` may be specified as
   * the `course_work_id` to include student submissions for multiple course
   * work items. Course students may only view their own work. Course teachers
   * and domain administrators may view all student submissions. This method
   * returns the following error codes: * `PERMISSION_DENIED` if the requesting
   * user is not permitted to access the requested course or course work, or for
   * access errors. * `INVALID_ARGUMENT` if the request is malformed. *
   * `NOT_FOUND` if the requested course does not exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifer of the student work to request. This may be set
   * to the string literal `"-"` to request student work for all course work in
   * the specified course.
   *
   * [userId] - Optional argument to restrict returned student work to those
   * owned by the student with the specified identifier. The identifier can be
   * one of the following: * the numeric identifier for the user * the email
   * address of the user * the string literal `"me"`, indicating the requesting
   * user
   *
   * [states] - Requested submission states. If specified, returned student
   * submissions match one of the specified submission states.
   *
   * [late] - Requested lateness value. If specified, returned student
   * submissions are restricted by the requested value. If unspecified,
   * submissions are returned regardless of `late` value.
   * Possible string values are:
   * - "LATE_VALUES_UNSPECIFIED" : A LATE_VALUES_UNSPECIFIED.
   * - "LATE_ONLY" : A LATE_ONLY.
   * - "NOT_LATE_ONLY" : A NOT_LATE_ONLY.
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListStudentSubmissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListStudentSubmissionsResponse> list(core.String courseId, core.String courseWorkId, {core.String userId, core.List<core.String> states, core.String late, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (userId != null) {
      _queryParams["userId"] = [userId];
    }
    if (states != null) {
      _queryParams["states"] = states;
    }
    if (late != null) {
      _queryParams["late"] = [late];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListStudentSubmissionsResponse.fromJson(data));
  }

  /**
   * Modifies attachments of student submission. Attachments may only be added
   * to student submissions belonging to course work objects with a `workType`
   * of `ASSIGNMENT`. This request must be made by the Developer Console project
   * of the [OAuth client ID](https://support.google.com/cloud/answer/6158849)
   * used to create the corresponding course work item. This method returns the
   * following error codes: * `PERMISSION_DENIED` if the requesting user is not
   * permitted to access the requested course or course work, if the user is not
   * permitted to modify attachments on the requested student submission, or for
   * access errors. * `INVALID_ARGUMENT` if the request is malformed. *
   * `NOT_FOUND` if the requested course, course work, or student submission
   * does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * Completes with a [StudentSubmission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<StudentSubmission> modifyAttachments(ModifyAttachmentsRequest request, core.String courseId, core.String courseWorkId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id') + ':modifyAttachments';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new StudentSubmission.fromJson(data));
  }

  /**
   * Updates one or more fields of a student submission. See
   * google.classroom.v1.StudentSubmission for details of which fields may be
   * updated and who may change them. This request must be made by the Developer
   * Console project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting developer project did not
   * create the corresponding course work, if the user is not permitted to make
   * the requested modification to the student submission, or for access errors.
   * * `INVALID_ARGUMENT` if the request is malformed. * `NOT_FOUND` if the
   * requested course, course work, or student submission does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * [updateMask] - Mask that identifies which fields on the student submission
   * to update. This field is required to do an update. The update fails if
   * invalid fields are specified. The following fields may be specified by
   * teachers: * `draft_grade` * `assigned_grade`
   *
   * Completes with a [StudentSubmission].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<StudentSubmission> patch(StudentSubmission request, core.String courseId, core.String courseWorkId, core.String id, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new StudentSubmission.fromJson(data));
  }

  /**
   * Reclaims a student submission on behalf of the student that owns it.
   * Reclaiming a student submission transfers ownership of attached Drive files
   * to the student and update the submission state. Only the student that owns
   * the requested student submission may call this method, and only for a
   * student submission that has been turned in. This request must be made by
   * the Developer Console project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * access the requested course or course work, unsubmit the requested student
   * submission, or for access errors. * `FAILED_PRECONDITION` if the student
   * submission has not been turned in. * `INVALID_ARGUMENT` if the request is
   * malformed. * `NOT_FOUND` if the requested course, course work, or student
   * submission does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> reclaim(ReclaimStudentSubmissionRequest request, core.String courseId, core.String courseWorkId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id') + ':reclaim';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a student submission. Returning a student submission transfers
   * ownership of attached Drive files to the student and may also update the
   * submission state. Unlike the Classroom application, returning a student
   * submission does not set assignedGrade to the draftGrade value. Only a
   * teacher of the course that contains the requested student submission may
   * call this method. This request must be made by the Developer Console
   * project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * access the requested course or course work, return the requested student
   * submission, or for access errors. * `INVALID_ARGUMENT` if the request is
   * malformed. * `NOT_FOUND` if the requested course, course work, or student
   * submission does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> return_(ReturnStudentSubmissionRequest request, core.String courseId, core.String courseWorkId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id') + ':return';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Turns in a student submission. Turning in a student submission transfers
   * ownership of attached Drive files to the teacher and may also update the
   * submission state. This may only be called by the student that owns the
   * specified student submission. This request must be made by the Developer
   * Console project of the [OAuth client
   * ID](https://support.google.com/cloud/answer/6158849) used to create the
   * corresponding course work item. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * access the requested course or course work, turn in the requested student
   * submission, or for access errors. * `INVALID_ARGUMENT` if the request is
   * malformed. * `NOT_FOUND` if the requested course, course work, or student
   * submission does not exist.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [courseWorkId] - Identifier of the course work.
   *
   * [id] - Identifier of the student submission.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> turnIn(TurnInStudentSubmissionRequest request, core.String courseId, core.String courseWorkId, core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (courseWorkId == null) {
      throw new core.ArgumentError("Parameter courseWorkId is required.");
    }
    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/courseWork/' + commons.Escaper.ecapeVariable('$courseWorkId') + '/studentSubmissions/' + commons.Escaper.ecapeVariable('$id') + ':turnIn';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

}


class CoursesStudentsResourceApi {
  final commons.ApiRequester _requester;

  CoursesStudentsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Adds a user as a student of a course. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to create students in this course or for access errors. * `NOT_FOUND` if
   * the requested course ID does not exist. * `FAILED_PRECONDITION` if the
   * requested user's account is disabled, for the following request errors: *
   * CourseMemberLimitReached * CourseNotModifiable *
   * UserGroupsMembershipLimitReached * `ALREADY_EXISTS` if the user is already
   * a student or teacher in the course.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course to create the student in. This
   * identifier can be either the Classroom-assigned identifier or an alias.
   *
   * [enrollmentCode] - Enrollment code of the course to create the student in.
   * This code is required if userId corresponds to the requesting user; it may
   * be omitted if the requesting user has administrative permissions to create
   * students for any user.
   *
   * Completes with a [Student].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Student> create(Student request, core.String courseId, {core.String enrollmentCode}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (enrollmentCode != null) {
      _queryParams["enrollmentCode"] = [enrollmentCode];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/students';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Student.fromJson(data));
  }

  /**
   * Deletes a student of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * delete students of this course or for access errors. * `NOT_FOUND` if no
   * student of this course has the requested ID or if the course does not
   * exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [userId] - Identifier of the student to delete. The identifier can be one
   * of the following: * the numeric identifier for the user * the email address
   * of the user * the string literal `"me"`, indicating the requesting user
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String courseId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/students/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a student of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * view students of this course or for access errors. * `NOT_FOUND` if no
   * student of this course has the requested ID or if the course does not
   * exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [userId] - Identifier of the student to return. The identifier can be one
   * of the following: * the numeric identifier for the user * the email address
   * of the user * the string literal `"me"`, indicating the requesting user
   *
   * Completes with a [Student].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Student> get(core.String courseId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/students/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Student.fromJson(data));
  }

  /**
   * Returns a list of students of this course that the requester is permitted
   * to view. This method returns the following error codes: * `NOT_FOUND` if
   * the course does not exist. * `PERMISSION_DENIED` for access errors.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [pageSize] - Maximum number of items to return. Zero means no maximum. The
   * server may return fewer than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListStudentsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListStudentsResponse> list(core.String courseId, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/students';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListStudentsResponse.fromJson(data));
  }

}


class CoursesTeachersResourceApi {
  final commons.ApiRequester _requester;

  CoursesTeachersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a teacher of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * create teachers in this course or for access errors. * `NOT_FOUND` if the
   * requested course ID does not exist. * `FAILED_PRECONDITION` if the
   * requested user's account is disabled, for the following request errors: *
   * CourseMemberLimitReached * CourseNotModifiable * CourseTeacherLimitReached
   * * UserGroupsMembershipLimitReached * `ALREADY_EXISTS` if the user is
   * already a teacher or student in the course.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * Completes with a [Teacher].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Teacher> create(Teacher request, core.String courseId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/teachers';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Teacher.fromJson(data));
  }

  /**
   * Deletes a teacher of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * delete teachers of this course or for access errors. * `NOT_FOUND` if no
   * teacher of this course has the requested ID or if the course does not
   * exist. * `FAILED_PRECONDITION` if the requested ID belongs to the primary
   * teacher of this course.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [userId] - Identifier of the teacher to delete. The identifier can be one
   * of the following: * the numeric identifier for the user * the email address
   * of the user * the string literal `"me"`, indicating the requesting user
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String courseId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/teachers/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a teacher of a course. This method returns the following error
   * codes: * `PERMISSION_DENIED` if the requesting user is not permitted to
   * view teachers of this course or for access errors. * `NOT_FOUND` if no
   * teacher of this course has the requested ID or if the course does not
   * exist.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [userId] - Identifier of the teacher to return. The identifier can be one
   * of the following: * the numeric identifier for the user * the email address
   * of the user * the string literal `"me"`, indicating the requesting user
   *
   * Completes with a [Teacher].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Teacher> get(core.String courseId, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/teachers/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Teacher.fromJson(data));
  }

  /**
   * Returns a list of teachers of this course that the requester is permitted
   * to view. This method returns the following error codes: * `NOT_FOUND` if
   * the course does not exist. * `PERMISSION_DENIED` for access errors.
   *
   * Request parameters:
   *
   * [courseId] - Identifier of the course. This identifier can be either the
   * Classroom-assigned identifier or an alias.
   *
   * [pageSize] - Maximum number of items to return. Zero means no maximum. The
   * server may return fewer than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListTeachersResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListTeachersResponse> list(core.String courseId, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (courseId == null) {
      throw new core.ArgumentError("Parameter courseId is required.");
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/courses/' + commons.Escaper.ecapeVariable('$courseId') + '/teachers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListTeachersResponse.fromJson(data));
  }

}


class InvitationsResourceApi {
  final commons.ApiRequester _requester;

  InvitationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Accepts an invitation, removing it and adding the invited user to the
   * teachers or students (as appropriate) of the specified course. Only the
   * invited user may accept an invitation. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to accept the requested invitation or for access errors. *
   * `FAILED_PRECONDITION` for the following request errors: *
   * CourseMemberLimitReached * CourseNotModifiable * CourseTeacherLimitReached
   * * UserGroupsMembershipLimitReached * `NOT_FOUND` if no invitation exists
   * with the requested ID.
   *
   * Request parameters:
   *
   * [id] - Identifier of the invitation to accept.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> accept(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/invitations/' + commons.Escaper.ecapeVariable('$id') + ':accept';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Creates an invitation. Only one invitation for a user and course may exist
   * at a time. Delete and re-create an invitation to make changes. This method
   * returns the following error codes: * `PERMISSION_DENIED` if the requesting
   * user is not permitted to create invitations for this course or for access
   * errors. * `NOT_FOUND` if the course or the user does not exist. *
   * `FAILED_PRECONDITION` if the requested user's account is disabled or if the
   * user already has this role or a role with greater permissions. *
   * `ALREADY_EXISTS` if an invitation for the specified user and course already
   * exists.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Invitation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Invitation> create(Invitation request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/invitations';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Invitation.fromJson(data));
  }

  /**
   * Deletes an invitation. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to delete the
   * requested invitation or for access errors. * `NOT_FOUND` if no invitation
   * exists with the requested ID.
   *
   * Request parameters:
   *
   * [id] - Identifier of the invitation to delete.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/invitations/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns an invitation. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to view the
   * requested invitation or for access errors. * `NOT_FOUND` if no invitation
   * exists with the requested ID.
   *
   * Request parameters:
   *
   * [id] - Identifier of the invitation to return.
   *
   * Completes with a [Invitation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Invitation> get(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'v1/invitations/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Invitation.fromJson(data));
  }

  /**
   * Returns a list of invitations that the requesting user is permitted to
   * view, restricted to those that match the list request. *Note:* At least one
   * of `user_id` or `course_id` must be supplied. Both fields can be supplied.
   * This method returns the following error codes: * `PERMISSION_DENIED` for
   * access errors.
   *
   * Request parameters:
   *
   * [userId] - Restricts returned invitations to those for a specific user. The
   * identifier can be one of the following: * the numeric identifier for the
   * user * the email address of the user * the string literal `"me"`,
   * indicating the requesting user
   *
   * [courseId] - Restricts returned invitations to those for a course with the
   * specified identifier.
   *
   * [pageSize] - Maximum number of items to return. Zero means no maximum. The
   * server may return fewer than the specified number of results.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * Completes with a [ListInvitationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListInvitationsResponse> list({core.String userId, core.String courseId, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId != null) {
      _queryParams["userId"] = [userId];
    }
    if (courseId != null) {
      _queryParams["courseId"] = [courseId];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'v1/invitations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListInvitationsResponse.fromJson(data));
  }

}


class UserProfilesResourceApi {
  final commons.ApiRequester _requester;

  UserProfilesGuardianInvitationsResourceApi get guardianInvitations => new UserProfilesGuardianInvitationsResourceApi(_requester);
  UserProfilesGuardiansResourceApi get guardians => new UserProfilesGuardiansResourceApi(_requester);

  UserProfilesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a user profile. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the requesting user is not permitted to access this
   * user profile, if no profile exists with the requested ID, or for access
   * errors.
   *
   * Request parameters:
   *
   * [userId] - Identifier of the profile to return. The identifier can be one
   * of the following: * the numeric identifier for the user * the email address
   * of the user * the string literal `"me"`, indicating the requesting user
   *
   * Completes with a [UserProfile].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<UserProfile> get(core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new UserProfile.fromJson(data));
  }

}


class UserProfilesGuardianInvitationsResourceApi {
  final commons.ApiRequester _requester;

  UserProfilesGuardianInvitationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a guardian invitation, and sends an email to the guardian asking
   * them to confirm that they are the student's guardian. Once the guardian
   * accepts the invitation, their `state` will change to `COMPLETED` and they
   * will start receiving guardian notifications. A `Guardian` resource will
   * also be created to represent the active guardian. The request object must
   * have the `student_id` and `invited_email_address` fields set. Failing to
   * set these fields, or setting any other fields in the request, will result
   * in an error. This method returns the following error codes: *
   * `PERMISSION_DENIED` if the current user does not have permission to manage
   * guardians, if the guardian in question has already rejected too many
   * requests for that student, if guardians are not enabled for the domain in
   * question, or for other access errors. * `RESOURCE_EXHAUSTED` if the student
   * or guardian has exceeded the guardian link limit. * `INVALID_ARGUMENT` if
   * the guardian email address is not valid (for example, if it is too long),
   * or if the format of the student ID provided cannot be recognized (it is not
   * an email address, nor a `user_id` from this API). This error will also be
   * returned if read-only fields are set, or if the `state` field is set to to
   * a value other than `PENDING`. * `NOT_FOUND` if the student ID provided is a
   * valid student ID, but Classroom has no record of that student. *
   * `ALREADY_EXISTS` if there is already a pending guardian invitation for the
   * student and `invited_email_address` provided, or if the provided
   * `invited_email_address` matches the Google account of an existing
   * `Guardian` for this user.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [studentId] - ID of the student (in standard format)
   *
   * Completes with a [GuardianInvitation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GuardianInvitation> create(GuardianInvitation request, core.String studentId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardianInvitations';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GuardianInvitation.fromJson(data));
  }

  /**
   * Returns a specific guardian invitation. This method returns the following
   * error codes: * `PERMISSION_DENIED` if the requesting user is not permitted
   * to view guardian invitations for the student identified by the
   * `student_id`, if guardians are not enabled for the domain in question, or
   * for other access errors. * `INVALID_ARGUMENT` if a `student_id` is
   * specified, but its format cannot be recognized (it is not an email address,
   * nor a `student_id` from the API, nor the literal string `me`). *
   * `NOT_FOUND` if Classroom cannot find any record of the given student or
   * `invitation_id`. May also be returned if the student exists, but the
   * requesting user does not have access to see that student.
   *
   * Request parameters:
   *
   * [studentId] - The ID of the student whose guardian invitation is being
   * requested.
   *
   * [invitationId] - The `id` field of the `GuardianInvitation` being
   * requested.
   *
   * Completes with a [GuardianInvitation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GuardianInvitation> get(core.String studentId, core.String invitationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (invitationId == null) {
      throw new core.ArgumentError("Parameter invitationId is required.");
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardianInvitations/' + commons.Escaper.ecapeVariable('$invitationId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GuardianInvitation.fromJson(data));
  }

  /**
   * Returns a list of guardian invitations that the requesting user is
   * permitted to view, filtered by the parameters provided. This method returns
   * the following error codes: * `PERMISSION_DENIED` if a `student_id` is
   * specified, and the requesting user is not permitted to view guardian
   * invitations for that student, if `"-"` is specified as the `student_id` and
   * the user is not a domain administrator, if guardians are not enabled for
   * the domain in question, or for other access errors. * `INVALID_ARGUMENT` if
   * a `student_id` is specified, but its format cannot be recognized (it is not
   * an email address, nor a `student_id` from the API, nor the literal string
   * `me`). May also be returned if an invalid `page_token` or `state` is
   * provided. * `NOT_FOUND` if a `student_id` is specified, and its format can
   * be recognized, but Classroom has no record of that student.
   *
   * Request parameters:
   *
   * [studentId] - The ID of the student whose guardian invitations are to be
   * returned. The identifier can be one of the following: * the numeric
   * identifier for the user * the email address of the user * the string
   * literal `"me"`, indicating the requesting user * the string literal `"-"`,
   * indicating that results should be returned for all students that the
   * requesting user is permitted to view guardian invitations.
   *
   * [invitedEmailAddress] - If specified, only results with the specified
   * `invited_email_address` will be returned.
   *
   * [states] - If specified, only results with the specified `state` values
   * will be returned. Otherwise, results with a `state` of `PENDING` will be
   * returned.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * Completes with a [ListGuardianInvitationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListGuardianInvitationsResponse> list(core.String studentId, {core.String invitedEmailAddress, core.List<core.String> states, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (invitedEmailAddress != null) {
      _queryParams["invitedEmailAddress"] = [invitedEmailAddress];
    }
    if (states != null) {
      _queryParams["states"] = states;
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardianInvitations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListGuardianInvitationsResponse.fromJson(data));
  }

  /**
   * Modifies a guardian invitation. Currently, the only valid modification is
   * to change the `state` from `PENDING` to `COMPLETE`. This has the effect of
   * withdrawing the invitation. This method returns the following error codes:
   * * `PERMISSION_DENIED` if the current user does not have permission to
   * manage guardians, if guardians are not enabled for the domain in question
   * or for other access errors. * `FAILED_PRECONDITION` if the guardian link is
   * not in the `PENDING` state. * `INVALID_ARGUMENT` if the format of the
   * student ID provided cannot be recognized (it is not an email address, nor a
   * `user_id` from this API), or if the passed `GuardianInvitation` has a
   * `state` other than `COMPLETE`, or if it modifies fields other than `state`.
   * * `NOT_FOUND` if the student ID provided is a valid student ID, but
   * Classroom has no record of that student, or if the `id` field does not
   * refer to a guardian invitation known to Classroom.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [studentId] - The ID of the student whose guardian invitation is to be
   * modified.
   *
   * [invitationId] - The `id` field of the `GuardianInvitation` to be modified.
   *
   * [updateMask] - Mask that identifies which fields on the course to update.
   * This field is required to do an update. The update will fail if invalid
   * fields are specified. The following fields are valid: * `state` When set in
   * a query parameter, this field should be specified as `updateMask=,,...`
   *
   * Completes with a [GuardianInvitation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GuardianInvitation> patch(GuardianInvitation request, core.String studentId, core.String invitationId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (invitationId == null) {
      throw new core.ArgumentError("Parameter invitationId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardianInvitations/' + commons.Escaper.ecapeVariable('$invitationId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GuardianInvitation.fromJson(data));
  }

}


class UserProfilesGuardiansResourceApi {
  final commons.ApiRequester _requester;

  UserProfilesGuardiansResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a guardian. The guardian will no longer receive guardian
   * notifications and the guardian will no longer be accessible via the API.
   * This method returns the following error codes: * `PERMISSION_DENIED` if no
   * user that matches the provided `student_id` is visible to the requesting
   * user, if the requesting user is not permitted to manage guardians for the
   * student identified by the `student_id`, if guardians are not enabled for
   * the domain in question, or for other access errors. * `INVALID_ARGUMENT` if
   * a `student_id` is specified, but its format cannot be recognized (it is not
   * an email address, nor a `student_id` from the API). * `NOT_FOUND` if the
   * requesting user is permitted to modify guardians for the requested
   * `student_id`, but no `Guardian` record exists for that student with the
   * provided `guardian_id`.
   *
   * Request parameters:
   *
   * [studentId] - The student whose guardian is to be deleted. One of the
   * following: * the numeric identifier for the user * the email address of the
   * user * the string literal `"me"`, indicating the requesting user
   *
   * [guardianId] - The `id` field from a `Guardian`.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String studentId, core.String guardianId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (guardianId == null) {
      throw new core.ArgumentError("Parameter guardianId is required.");
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardians/' + commons.Escaper.ecapeVariable('$guardianId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Returns a specific guardian. This method returns the following error codes:
   * * `PERMISSION_DENIED` if no user that matches the provided `student_id` is
   * visible to the requesting user, if the requesting user is not permitted to
   * view guardian information for the student identified by the `student_id`,
   * if guardians are not enabled for the domain in question, or for other
   * access errors. * `INVALID_ARGUMENT` if a `student_id` is specified, but its
   * format cannot be recognized (it is not an email address, nor a `student_id`
   * from the API, nor the literal string `me`). * `NOT_FOUND` if the requesting
   * user is permitted to view guardians for the requested `student_id`, but no
   * `Guardian` record exists for that student that matches the provided
   * `guardian_id`.
   *
   * Request parameters:
   *
   * [studentId] - The student whose guardian is being requested. One of the
   * following: * the numeric identifier for the user * the email address of the
   * user * the string literal `"me"`, indicating the requesting user
   *
   * [guardianId] - The `id` field from a `Guardian`.
   *
   * Completes with a [Guardian].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Guardian> get(core.String studentId, core.String guardianId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (guardianId == null) {
      throw new core.ArgumentError("Parameter guardianId is required.");
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardians/' + commons.Escaper.ecapeVariable('$guardianId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Guardian.fromJson(data));
  }

  /**
   * Returns a list of guardians that the requesting user is permitted to view,
   * restricted to those that match the request. To list guardians for any
   * student that the requesting user may view guardians for, use the literal
   * character `-` for the student ID. This method returns the following error
   * codes: * `PERMISSION_DENIED` if a `student_id` is specified, and the
   * requesting user is not permitted to view guardian information for that
   * student, if `"-"` is specified as the `student_id` and the user is not a
   * domain administrator, if guardians are not enabled for the domain in
   * question, if the `invited_email_address` filter is set by a user who is not
   * a domain administrator, or for other access errors. * `INVALID_ARGUMENT` if
   * a `student_id` is specified, but its format cannot be recognized (it is not
   * an email address, nor a `student_id` from the API, nor the literal string
   * `me`). May also be returned if an invalid `page_token` is provided. *
   * `NOT_FOUND` if a `student_id` is specified, and its format can be
   * recognized, but Classroom has no record of that student.
   *
   * Request parameters:
   *
   * [studentId] - Filter results by the student who the guardian is linked to.
   * The identifier can be one of the following: * the numeric identifier for
   * the user * the email address of the user * the string literal `"me"`,
   * indicating the requesting user * the string literal `"-"`, indicating that
   * results should be returned for all students that the requesting user has
   * access to view.
   *
   * [invitedEmailAddress] - Filter results by the email address that the
   * original invitation was sent to, resulting in this guardian link. This
   * filter can only be used by domain administrators.
   *
   * [pageToken] - nextPageToken value returned from a previous list call,
   * indicating that the subsequent page of results should be returned. The list
   * request must be otherwise identical to the one that resulted in this token.
   *
   * [pageSize] - Maximum number of items to return. Zero or unspecified
   * indicates that the server may assign a maximum. The server may return fewer
   * than the specified number of results.
   *
   * Completes with a [ListGuardiansResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListGuardiansResponse> list(core.String studentId, {core.String invitedEmailAddress, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (studentId == null) {
      throw new core.ArgumentError("Parameter studentId is required.");
    }
    if (invitedEmailAddress != null) {
      _queryParams["invitedEmailAddress"] = [invitedEmailAddress];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/userProfiles/' + commons.Escaper.ecapeVariable('$studentId') + '/guardians';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListGuardiansResponse.fromJson(data));
  }

}



/** Additional details for assignments. */
class Assignment {
  /**
   * Drive folder where attachments from student submissions are placed. This is
   * only populated for course teachers.
   */
  DriveFolder studentWorkFolder;

  Assignment();

  Assignment.fromJson(core.Map _json) {
    if (_json.containsKey("studentWorkFolder")) {
      studentWorkFolder = new DriveFolder.fromJson(_json["studentWorkFolder"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (studentWorkFolder != null) {
      _json["studentWorkFolder"] = (studentWorkFolder).toJson();
    }
    return _json;
  }
}

/** Student work for an assignment. */
class AssignmentSubmission {
  /**
   * Attachments added by the student. Drive files that correspond to materials
   * with a share mode of STUDENT_COPY may not exist yet if the student has not
   * accessed the assignment in Classroom. Some attachment metadata is only
   * populated if the requesting user has permission to access it. Identifier
   * and alternate_link fields are always available, but others (e.g. title) may
   * not be.
   */
  core.List<Attachment> attachments;

  AssignmentSubmission();

  AssignmentSubmission.fromJson(core.Map _json) {
    if (_json.containsKey("attachments")) {
      attachments = _json["attachments"].map((value) => new Attachment.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attachments != null) {
      _json["attachments"] = attachments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Attachment added to student assignment work. When creating attachments,
 * setting the `form` field is not supported.
 */
class Attachment {
  /** Google Drive file attachment. */
  DriveFile driveFile;
  /** Google Forms attachment. */
  Form form;
  /** Link attachment. */
  Link link;
  /** Youtube video attachment. */
  YouTubeVideo youTubeVideo;

  Attachment();

  Attachment.fromJson(core.Map _json) {
    if (_json.containsKey("driveFile")) {
      driveFile = new DriveFile.fromJson(_json["driveFile"]);
    }
    if (_json.containsKey("form")) {
      form = new Form.fromJson(_json["form"]);
    }
    if (_json.containsKey("link")) {
      link = new Link.fromJson(_json["link"]);
    }
    if (_json.containsKey("youTubeVideo")) {
      youTubeVideo = new YouTubeVideo.fromJson(_json["youTubeVideo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (driveFile != null) {
      _json["driveFile"] = (driveFile).toJson();
    }
    if (form != null) {
      _json["form"] = (form).toJson();
    }
    if (link != null) {
      _json["link"] = (link).toJson();
    }
    if (youTubeVideo != null) {
      _json["youTubeVideo"] = (youTubeVideo).toJson();
    }
    return _json;
  }
}

/** A Course in Classroom. */
class Course {
  /** Absolute link to this course in the Classroom web UI. Read-only. */
  core.String alternateLink;
  /**
   * The email address of a Google group containing all members of the course.
   * This group does not accept email and can only be used for permissions.
   * Read-only.
   */
  core.String courseGroupEmail;
  /**
   * Sets of materials that appear on the "about" page of this course.
   * Read-only.
   */
  core.List<CourseMaterialSet> courseMaterialSets;
  /**
   * State of the course. If unspecified, the default state is `PROVISIONED`.
   * Possible string values are:
   * - "COURSE_STATE_UNSPECIFIED" : A COURSE_STATE_UNSPECIFIED.
   * - "ACTIVE" : A ACTIVE.
   * - "ARCHIVED" : A ARCHIVED.
   * - "PROVISIONED" : A PROVISIONED.
   * - "DECLINED" : A DECLINED.
   */
  core.String courseState;
  /**
   * Creation time of the course. Specifying this field in a course update mask
   * results in an error. Read-only.
   */
  core.String creationTime;
  /**
   * Optional description. For example, "We'll be learning about the structure
   * of living creatures from a combination of textbooks, guest lectures, and
   * lab work. Expect to be excited!" If set, this field must be a valid UTF-8
   * string and no longer than 30,000 characters.
   */
  core.String description;
  /**
   * Optional heading for the description. For example, "Welcome to 10th Grade
   * Biology." If set, this field must be a valid UTF-8 string and no longer
   * than 3600 characters.
   */
  core.String descriptionHeading;
  /**
   * Enrollment code to use when joining this course. Specifying this field in a
   * course update mask results in an error. Read-only.
   */
  core.String enrollmentCode;
  /**
   * Whether or not guardian notifications are enabled for this course.
   * Read-only.
   */
  core.bool guardiansEnabled;
  /**
   * Identifier for this course assigned by Classroom. When creating a course,
   * you may optionally set this identifier to an alias string in the request to
   * create a corresponding alias. The `id` is still assigned by Classroom and
   * cannot be updated after the course is created. Specifying this field in a
   * course update mask results in an error.
   */
  core.String id;
  /**
   * Name of the course. For example, "10th Grade Biology". The name is
   * required. It must be between 1 and 750 characters and a valid UTF-8 string.
   */
  core.String name;
  /**
   * The identifier of the owner of a course. When specified as a parameter of a
   * create course request, this field is required. The identifier can be one of
   * the following: * the numeric identifier for the user * the email address of
   * the user * the string literal `"me"`, indicating the requesting user This
   * must be set in a create request. Specifying this field in a course update
   * mask results in an `INVALID_ARGUMENT` error.
   */
  core.String ownerId;
  /**
   * Optional room location. For example, "301". If set, this field must be a
   * valid UTF-8 string and no longer than 650 characters.
   */
  core.String room;
  /**
   * Section of the course. For example, "Period 2". If set, this field must be
   * a valid UTF-8 string and no longer than 2800 characters.
   */
  core.String section;
  /**
   * Information about a Drive Folder that is shared with all teachers of the
   * course. This field will only be set for teachers of the course and domain
   * administrators. Read-only.
   */
  DriveFolder teacherFolder;
  /**
   * The email address of a Google group containing all teachers of the course.
   * This group does not accept email and can only be used for permissions.
   * Read-only.
   */
  core.String teacherGroupEmail;
  /**
   * Time of the most recent update to this course. Specifying this field in a
   * course update mask results in an error. Read-only.
   */
  core.String updateTime;

  Course();

  Course.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("courseGroupEmail")) {
      courseGroupEmail = _json["courseGroupEmail"];
    }
    if (_json.containsKey("courseMaterialSets")) {
      courseMaterialSets = _json["courseMaterialSets"].map((value) => new CourseMaterialSet.fromJson(value)).toList();
    }
    if (_json.containsKey("courseState")) {
      courseState = _json["courseState"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("descriptionHeading")) {
      descriptionHeading = _json["descriptionHeading"];
    }
    if (_json.containsKey("enrollmentCode")) {
      enrollmentCode = _json["enrollmentCode"];
    }
    if (_json.containsKey("guardiansEnabled")) {
      guardiansEnabled = _json["guardiansEnabled"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ownerId")) {
      ownerId = _json["ownerId"];
    }
    if (_json.containsKey("room")) {
      room = _json["room"];
    }
    if (_json.containsKey("section")) {
      section = _json["section"];
    }
    if (_json.containsKey("teacherFolder")) {
      teacherFolder = new DriveFolder.fromJson(_json["teacherFolder"]);
    }
    if (_json.containsKey("teacherGroupEmail")) {
      teacherGroupEmail = _json["teacherGroupEmail"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (courseGroupEmail != null) {
      _json["courseGroupEmail"] = courseGroupEmail;
    }
    if (courseMaterialSets != null) {
      _json["courseMaterialSets"] = courseMaterialSets.map((value) => (value).toJson()).toList();
    }
    if (courseState != null) {
      _json["courseState"] = courseState;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (descriptionHeading != null) {
      _json["descriptionHeading"] = descriptionHeading;
    }
    if (enrollmentCode != null) {
      _json["enrollmentCode"] = enrollmentCode;
    }
    if (guardiansEnabled != null) {
      _json["guardiansEnabled"] = guardiansEnabled;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ownerId != null) {
      _json["ownerId"] = ownerId;
    }
    if (room != null) {
      _json["room"] = room;
    }
    if (section != null) {
      _json["section"] = section;
    }
    if (teacherFolder != null) {
      _json["teacherFolder"] = (teacherFolder).toJson();
    }
    if (teacherGroupEmail != null) {
      _json["teacherGroupEmail"] = teacherGroupEmail;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    return _json;
  }
}

/**
 * Alternative identifier for a course. An alias uniquely identifies a course.
 * It must be unique within one of the following scopes: * domain: A
 * domain-scoped alias is visible to all users within the alias creator's domain
 * and can be created only by a domain admin. A domain-scoped alias is often
 * used when a course has an identifier external to Classroom. * project: A
 * project-scoped alias is visible to any request from an application using the
 * Developer Console project ID that created the alias and can be created by any
 * project. A project-scoped alias is often used when an application has
 * alternative identifiers. A random value can also be used to avoid duplicate
 * courses in the event of transmission failures, as retrying a request will
 * return `ALREADY_EXISTS` if a previous one has succeeded.
 */
class CourseAlias {
  /**
   * Alias string. The format of the string indicates the desired alias scoping.
   * * `d:` indicates a domain-scoped alias. Example: `d:math_101` * `p:`
   * indicates a project-scoped alias. Example: `p:abc123` This field has a
   * maximum length of 256 characters.
   */
  core.String alias;

  CourseAlias();

  CourseAlias.fromJson(core.Map _json) {
    if (_json.containsKey("alias")) {
      alias = _json["alias"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alias != null) {
      _json["alias"] = alias;
    }
    return _json;
  }
}

/** A material attached to a course as part of a material set. */
class CourseMaterial {
  /** Google Drive file attachment. */
  DriveFile driveFile;
  /** Google Forms attachment. */
  Form form;
  /** Link atatchment. */
  Link link;
  /** Youtube video attachment. */
  YouTubeVideo youTubeVideo;

  CourseMaterial();

  CourseMaterial.fromJson(core.Map _json) {
    if (_json.containsKey("driveFile")) {
      driveFile = new DriveFile.fromJson(_json["driveFile"]);
    }
    if (_json.containsKey("form")) {
      form = new Form.fromJson(_json["form"]);
    }
    if (_json.containsKey("link")) {
      link = new Link.fromJson(_json["link"]);
    }
    if (_json.containsKey("youTubeVideo")) {
      youTubeVideo = new YouTubeVideo.fromJson(_json["youTubeVideo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (driveFile != null) {
      _json["driveFile"] = (driveFile).toJson();
    }
    if (form != null) {
      _json["form"] = (form).toJson();
    }
    if (link != null) {
      _json["link"] = (link).toJson();
    }
    if (youTubeVideo != null) {
      _json["youTubeVideo"] = (youTubeVideo).toJson();
    }
    return _json;
  }
}

/**
 * A set of materials that appears on the "About" page of the course. These
 * materials might include a syllabus, schedule, or other background information
 * relating to the course as a whole.
 */
class CourseMaterialSet {
  /** Materials attached to this set. */
  core.List<CourseMaterial> materials;
  /** Title for this set. */
  core.String title;

  CourseMaterialSet();

  CourseMaterialSet.fromJson(core.Map _json) {
    if (_json.containsKey("materials")) {
      materials = _json["materials"].map((value) => new CourseMaterial.fromJson(value)).toList();
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (materials != null) {
      _json["materials"] = materials.map((value) => (value).toJson()).toList();
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Course work created by a teacher for students of the course. */
class CourseWork {
  /**
   * Absolute link to this course work in the Classroom web UI. This is only
   * populated if `state` is `PUBLISHED`. Read-only.
   */
  core.String alternateLink;
  /**
   * Assignment details. This is populated only when `work_type` is
   * `ASSIGNMENT`. Read-only.
   */
  Assignment assignment;
  /**
   * Whether this course work item is associated with the Developer Console
   * project making the request. See google.classroom.Work.CreateCourseWork for
   * more details. Read-only.
   */
  core.bool associatedWithDeveloper;
  /** Identifier of the course. Read-only. */
  core.String courseId;
  /** Timestamp when this course work was created. Read-only. */
  core.String creationTime;
  /**
   * Optional description of this course work. If set, the description must be a
   * valid UTF-8 string containing no more than 30,000 characters.
   */
  core.String description;
  /**
   * Optional date, in UTC, that submissions for this this course work are due.
   * This must be specified if `due_time` is specified.
   */
  Date dueDate;
  /**
   * Optional time of day, in UTC, that submissions for this this course work
   * are due. This must be specified if `due_date` is specified.
   */
  TimeOfDay dueTime;
  /**
   * Classroom-assigned identifier of this course work, unique per course.
   * Read-only.
   */
  core.String id;
  /**
   * Additional materials. CourseWork must have no more than 20 material items.
   */
  core.List<Material> materials;
  /**
   * Maximum grade for this course work. If zero or unspecified, this assignment
   * is considered ungraded. This must be a non-negative integer value.
   */
  core.double maxPoints;
  /**
   * Multiple choice question details. For read operations, this field is
   * populated only when `work_type` is `MULTIPLE_CHOICE_QUESTION`. For write
   * operations, this field must be specified when creating course work with a
   * `work_type` of `MULTIPLE_CHOICE_QUESTION`, and it must not be set
   * otherwise.
   */
  MultipleChoiceQuestion multipleChoiceQuestion;
  /**
   * Status of this course work. If unspecified, the default state is `DRAFT`.
   * Possible string values are:
   * - "COURSE_WORK_STATE_UNSPECIFIED" : A COURSE_WORK_STATE_UNSPECIFIED.
   * - "PUBLISHED" : A PUBLISHED.
   * - "DRAFT" : A DRAFT.
   * - "DELETED" : A DELETED.
   */
  core.String state;
  /**
   * Setting to determine when students are allowed to modify submissions. If
   * unspecified, the default value is `MODIFIABLE_UNTIL_TURNED_IN`.
   * Possible string values are:
   * - "SUBMISSION_MODIFICATION_MODE_UNSPECIFIED" : A
   * SUBMISSION_MODIFICATION_MODE_UNSPECIFIED.
   * - "MODIFIABLE_UNTIL_TURNED_IN" : A MODIFIABLE_UNTIL_TURNED_IN.
   * - "MODIFIABLE" : A MODIFIABLE.
   */
  core.String submissionModificationMode;
  /**
   * Title of this course work. The title must be a valid UTF-8 string
   * containing between 1 and 3000 characters.
   */
  core.String title;
  /** Timestamp of the most recent change to this course work. Read-only. */
  core.String updateTime;
  /**
   * Type of this course work. The type is set when the course work is created
   * and cannot be changed.
   * Possible string values are:
   * - "COURSE_WORK_TYPE_UNSPECIFIED" : A COURSE_WORK_TYPE_UNSPECIFIED.
   * - "ASSIGNMENT" : A ASSIGNMENT.
   * - "SHORT_ANSWER_QUESTION" : A SHORT_ANSWER_QUESTION.
   * - "MULTIPLE_CHOICE_QUESTION" : A MULTIPLE_CHOICE_QUESTION.
   */
  core.String workType;

  CourseWork();

  CourseWork.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("assignment")) {
      assignment = new Assignment.fromJson(_json["assignment"]);
    }
    if (_json.containsKey("associatedWithDeveloper")) {
      associatedWithDeveloper = _json["associatedWithDeveloper"];
    }
    if (_json.containsKey("courseId")) {
      courseId = _json["courseId"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("dueDate")) {
      dueDate = new Date.fromJson(_json["dueDate"]);
    }
    if (_json.containsKey("dueTime")) {
      dueTime = new TimeOfDay.fromJson(_json["dueTime"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("materials")) {
      materials = _json["materials"].map((value) => new Material.fromJson(value)).toList();
    }
    if (_json.containsKey("maxPoints")) {
      maxPoints = _json["maxPoints"];
    }
    if (_json.containsKey("multipleChoiceQuestion")) {
      multipleChoiceQuestion = new MultipleChoiceQuestion.fromJson(_json["multipleChoiceQuestion"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("submissionModificationMode")) {
      submissionModificationMode = _json["submissionModificationMode"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
    if (_json.containsKey("workType")) {
      workType = _json["workType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (assignment != null) {
      _json["assignment"] = (assignment).toJson();
    }
    if (associatedWithDeveloper != null) {
      _json["associatedWithDeveloper"] = associatedWithDeveloper;
    }
    if (courseId != null) {
      _json["courseId"] = courseId;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (dueDate != null) {
      _json["dueDate"] = (dueDate).toJson();
    }
    if (dueTime != null) {
      _json["dueTime"] = (dueTime).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (materials != null) {
      _json["materials"] = materials.map((value) => (value).toJson()).toList();
    }
    if (maxPoints != null) {
      _json["maxPoints"] = maxPoints;
    }
    if (multipleChoiceQuestion != null) {
      _json["multipleChoiceQuestion"] = (multipleChoiceQuestion).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (submissionModificationMode != null) {
      _json["submissionModificationMode"] = submissionModificationMode;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    if (workType != null) {
      _json["workType"] = workType;
    }
    return _json;
  }
}

/**
 * Represents a whole calendar date, e.g. date of birth. The time of day and
 * time zone are either specified elsewhere or are not significant. The date is
 * relative to the Proleptic Gregorian Calendar. The day may be 0 to represent a
 * year and month where the day is not significant, e.g. credit card expiration
 * date. The year may be 0 to represent a month and day independent of year,
 * e.g. anniversary date. Related types are google.type.TimeOfDay and
 * `google.protobuf.Timestamp`.
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
   * Year of date. Must be from 1 to 9999, or 0 if specifying a date without a
   * year.
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

/** Representation of a Google Drive file. */
class DriveFile {
  /** URL that can be used to access the Drive item. Read-only. */
  core.String alternateLink;
  /** Drive API resource ID. */
  core.String id;
  /** URL of a thumbnail image of the Drive item. Read-only. */
  core.String thumbnailUrl;
  /** Title of the Drive item. Read-only. */
  core.String title;

  DriveFile();

  DriveFile.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("thumbnailUrl")) {
      thumbnailUrl = _json["thumbnailUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (thumbnailUrl != null) {
      _json["thumbnailUrl"] = thumbnailUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Representation of a Google Drive folder. */
class DriveFolder {
  /** URL that can be used to access the Drive folder. Read-only. */
  core.String alternateLink;
  /** Drive API resource ID. */
  core.String id;
  /** Title of the Drive folder. Read-only. */
  core.String title;

  DriveFolder();

  DriveFolder.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/**
 * A generic empty message that you can re-use to avoid defining duplicated
 * empty messages in your APIs. A typical example is to use it as the request or
 * the response type of an API method. For instance: service Foo { rpc
 * Bar(google.protobuf.Empty) returns (google.protobuf.Empty); } The JSON
 * representation for `Empty` is empty JSON object `{}`.
 */
class Empty {

  Empty();

  Empty.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Google Forms item. */
class Form {
  /** URL of the form. */
  core.String formUrl;
  /**
   * URL of the form responses document. Only set if respsonses have been
   * recorded and only when the requesting user is an editor of the form.
   * Read-only.
   */
  core.String responseUrl;
  /** URL of a thumbnail image of the Form. Read-only. */
  core.String thumbnailUrl;
  /** Title of the Form. Read-only. */
  core.String title;

  Form();

  Form.fromJson(core.Map _json) {
    if (_json.containsKey("formUrl")) {
      formUrl = _json["formUrl"];
    }
    if (_json.containsKey("responseUrl")) {
      responseUrl = _json["responseUrl"];
    }
    if (_json.containsKey("thumbnailUrl")) {
      thumbnailUrl = _json["thumbnailUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (formUrl != null) {
      _json["formUrl"] = formUrl;
    }
    if (responseUrl != null) {
      _json["responseUrl"] = responseUrl;
    }
    if (thumbnailUrl != null) {
      _json["thumbnailUrl"] = thumbnailUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** Global user permission description. */
class GlobalPermission {
  /**
   * Permission value.
   * Possible string values are:
   * - "PERMISSION_UNSPECIFIED" : A PERMISSION_UNSPECIFIED.
   * - "CREATE_COURSE" : A CREATE_COURSE.
   */
  core.String permission;

  GlobalPermission();

  GlobalPermission.fromJson(core.Map _json) {
    if (_json.containsKey("permission")) {
      permission = _json["permission"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permission != null) {
      _json["permission"] = permission;
    }
    return _json;
  }
}

/**
 * Association between a student and a guardian of that student. The guardian
 * may receive information about the student's course work.
 */
class Guardian {
  /** Identifier for the guardian. */
  core.String guardianId;
  /** User profile for the guardian. */
  UserProfile guardianProfile;
  /**
   * The email address to which the initial guardian invitation was sent. This
   * field is only visible to domain administrators.
   */
  core.String invitedEmailAddress;
  /** Identifier for the student to whom the guardian relationship applies. */
  core.String studentId;

  Guardian();

  Guardian.fromJson(core.Map _json) {
    if (_json.containsKey("guardianId")) {
      guardianId = _json["guardianId"];
    }
    if (_json.containsKey("guardianProfile")) {
      guardianProfile = new UserProfile.fromJson(_json["guardianProfile"]);
    }
    if (_json.containsKey("invitedEmailAddress")) {
      invitedEmailAddress = _json["invitedEmailAddress"];
    }
    if (_json.containsKey("studentId")) {
      studentId = _json["studentId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (guardianId != null) {
      _json["guardianId"] = guardianId;
    }
    if (guardianProfile != null) {
      _json["guardianProfile"] = (guardianProfile).toJson();
    }
    if (invitedEmailAddress != null) {
      _json["invitedEmailAddress"] = invitedEmailAddress;
    }
    if (studentId != null) {
      _json["studentId"] = studentId;
    }
    return _json;
  }
}

/**
 * An invitation to become the guardian of a specified user, sent to a specified
 * email address.
 */
class GuardianInvitation {
  /** The time that this invitation was created. Read-only. */
  core.String creationTime;
  /** Unique identifier for this invitation. Read-only. */
  core.String invitationId;
  /**
   * Email address that the invitation was sent to. This field is only visible
   * to domain administrators.
   */
  core.String invitedEmailAddress;
  /**
   * The state that this invitation is in.
   * Possible string values are:
   * - "GUARDIAN_INVITATION_STATE_UNSPECIFIED" : A
   * GUARDIAN_INVITATION_STATE_UNSPECIFIED.
   * - "PENDING" : A PENDING.
   * - "COMPLETE" : A COMPLETE.
   */
  core.String state;
  /** ID of the student (in standard format) */
  core.String studentId;

  GuardianInvitation();

  GuardianInvitation.fromJson(core.Map _json) {
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("invitationId")) {
      invitationId = _json["invitationId"];
    }
    if (_json.containsKey("invitedEmailAddress")) {
      invitedEmailAddress = _json["invitedEmailAddress"];
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("studentId")) {
      studentId = _json["studentId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (invitationId != null) {
      _json["invitationId"] = invitationId;
    }
    if (invitedEmailAddress != null) {
      _json["invitedEmailAddress"] = invitedEmailAddress;
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (studentId != null) {
      _json["studentId"] = studentId;
    }
    return _json;
  }
}

/** An invitation to join a course. */
class Invitation {
  /** Identifier of the course to invite the user to. */
  core.String courseId;
  /** Identifier assigned by Classroom. Read-only. */
  core.String id;
  /**
   * Role to invite the user to have. Must not be `COURSE_ROLE_UNSPECIFIED`.
   * Possible string values are:
   * - "COURSE_ROLE_UNSPECIFIED" : A COURSE_ROLE_UNSPECIFIED.
   * - "STUDENT" : A STUDENT.
   * - "TEACHER" : A TEACHER.
   */
  core.String role;
  /**
   * Identifier of the invited user. When specified as a parameter of a request,
   * this identifier can be set to one of the following: * the numeric
   * identifier for the user * the email address of the user * the string
   * literal `"me"`, indicating the requesting user
   */
  core.String userId;

  Invitation();

  Invitation.fromJson(core.Map _json) {
    if (_json.containsKey("courseId")) {
      courseId = _json["courseId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
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
    if (courseId != null) {
      _json["courseId"] = courseId;
    }
    if (id != null) {
      _json["id"] = id;
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

/** URL item. */
class Link {
  /** URL of a thumbnail image of the target URL. Read-only. */
  core.String thumbnailUrl;
  /** Title of the target of the URL. Read-only. */
  core.String title;
  /**
   * URL to link to. This must be a valid UTF-8 string containing between 1 and
   * 2024 characters.
   */
  core.String url;

  Link();

  Link.fromJson(core.Map _json) {
    if (_json.containsKey("thumbnailUrl")) {
      thumbnailUrl = _json["thumbnailUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (thumbnailUrl != null) {
      _json["thumbnailUrl"] = thumbnailUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

/** Response when listing course aliases. */
class ListCourseAliasesResponse {
  /** The course aliases. */
  core.List<CourseAlias> aliases;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListCourseAliasesResponse();

  ListCourseAliasesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("aliases")) {
      aliases = _json["aliases"].map((value) => new CourseAlias.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aliases != null) {
      _json["aliases"] = aliases.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing course work. */
class ListCourseWorkResponse {
  /** Course work items that match the request. */
  core.List<CourseWork> courseWork;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListCourseWorkResponse();

  ListCourseWorkResponse.fromJson(core.Map _json) {
    if (_json.containsKey("courseWork")) {
      courseWork = _json["courseWork"].map((value) => new CourseWork.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (courseWork != null) {
      _json["courseWork"] = courseWork.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing courses. */
class ListCoursesResponse {
  /** Courses that match the list request. */
  core.List<Course> courses;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListCoursesResponse();

  ListCoursesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("courses")) {
      courses = _json["courses"].map((value) => new Course.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (courses != null) {
      _json["courses"] = courses.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing guardian invitations. */
class ListGuardianInvitationsResponse {
  /** Guardian invitations that matched the list request. */
  core.List<GuardianInvitation> guardianInvitations;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListGuardianInvitationsResponse();

  ListGuardianInvitationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("guardianInvitations")) {
      guardianInvitations = _json["guardianInvitations"].map((value) => new GuardianInvitation.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (guardianInvitations != null) {
      _json["guardianInvitations"] = guardianInvitations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing guardians. */
class ListGuardiansResponse {
  /**
   * Guardians on this page of results that met the criteria specified in the
   * request.
   */
  core.List<Guardian> guardians;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListGuardiansResponse();

  ListGuardiansResponse.fromJson(core.Map _json) {
    if (_json.containsKey("guardians")) {
      guardians = _json["guardians"].map((value) => new Guardian.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (guardians != null) {
      _json["guardians"] = guardians.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing invitations. */
class ListInvitationsResponse {
  /** Invitations that match the list request. */
  core.List<Invitation> invitations;
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;

  ListInvitationsResponse();

  ListInvitationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("invitations")) {
      invitations = _json["invitations"].map((value) => new Invitation.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (invitations != null) {
      _json["invitations"] = invitations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** Response when listing student submissions. */
class ListStudentSubmissionsResponse {
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;
  /** Student work that matches the request. */
  core.List<StudentSubmission> studentSubmissions;

  ListStudentSubmissionsResponse();

  ListStudentSubmissionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("studentSubmissions")) {
      studentSubmissions = _json["studentSubmissions"].map((value) => new StudentSubmission.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (studentSubmissions != null) {
      _json["studentSubmissions"] = studentSubmissions.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response when listing students. */
class ListStudentsResponse {
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;
  /** Students who match the list request. */
  core.List<Student> students;

  ListStudentsResponse();

  ListStudentsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("students")) {
      students = _json["students"].map((value) => new Student.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (students != null) {
      _json["students"] = students.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Response when listing teachers. */
class ListTeachersResponse {
  /**
   * Token identifying the next page of results to return. If empty, no further
   * results are available.
   */
  core.String nextPageToken;
  /** Teachers who match the list request. */
  core.List<Teacher> teachers;

  ListTeachersResponse();

  ListTeachersResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("teachers")) {
      teachers = _json["teachers"].map((value) => new Teacher.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (teachers != null) {
      _json["teachers"] = teachers.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Material attached to course work. When creating attachments, setting the
 * `form` field is not supported.
 */
class Material {
  /** Google Drive file material. */
  SharedDriveFile driveFile;
  /** Google Forms material. */
  Form form;
  /**
   * Link material. On creation, will be upgraded to a more appropriate type if
   * possible, and this will be reflected in the response.
   */
  Link link;
  /** YouTube video material. */
  YouTubeVideo youtubeVideo;

  Material();

  Material.fromJson(core.Map _json) {
    if (_json.containsKey("driveFile")) {
      driveFile = new SharedDriveFile.fromJson(_json["driveFile"]);
    }
    if (_json.containsKey("form")) {
      form = new Form.fromJson(_json["form"]);
    }
    if (_json.containsKey("link")) {
      link = new Link.fromJson(_json["link"]);
    }
    if (_json.containsKey("youtubeVideo")) {
      youtubeVideo = new YouTubeVideo.fromJson(_json["youtubeVideo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (driveFile != null) {
      _json["driveFile"] = (driveFile).toJson();
    }
    if (form != null) {
      _json["form"] = (form).toJson();
    }
    if (link != null) {
      _json["link"] = (link).toJson();
    }
    if (youtubeVideo != null) {
      _json["youtubeVideo"] = (youtubeVideo).toJson();
    }
    return _json;
  }
}

/** Request to modify the attachments of a student submission. */
class ModifyAttachmentsRequest {
  /**
   * Attachments to add. A student submission may not have more than 20
   * attachments. Form attachments are not supported.
   */
  core.List<Attachment> addAttachments;

  ModifyAttachmentsRequest();

  ModifyAttachmentsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("addAttachments")) {
      addAttachments = _json["addAttachments"].map((value) => new Attachment.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (addAttachments != null) {
      _json["addAttachments"] = addAttachments.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Additional details for multiple-choice questions. */
class MultipleChoiceQuestion {
  /** Possible choices. */
  core.List<core.String> choices;

  MultipleChoiceQuestion();

  MultipleChoiceQuestion.fromJson(core.Map _json) {
    if (_json.containsKey("choices")) {
      choices = _json["choices"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (choices != null) {
      _json["choices"] = choices;
    }
    return _json;
  }
}

/** Student work for a multiple-choice question. */
class MultipleChoiceSubmission {
  /** Student's select choice. */
  core.String answer;

  MultipleChoiceSubmission();

  MultipleChoiceSubmission.fromJson(core.Map _json) {
    if (_json.containsKey("answer")) {
      answer = _json["answer"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (answer != null) {
      _json["answer"] = answer;
    }
    return _json;
  }
}

/** Details of the user's name. */
class Name {
  /** The user's last name. Read-only. */
  core.String familyName;
  /**
   * The user's full name formed by concatenating the first and last name
   * values. Read-only.
   */
  core.String fullName;
  /** The user's first name. Read-only. */
  core.String givenName;

  Name();

  Name.fromJson(core.Map _json) {
    if (_json.containsKey("familyName")) {
      familyName = _json["familyName"];
    }
    if (_json.containsKey("fullName")) {
      fullName = _json["fullName"];
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
    if (fullName != null) {
      _json["fullName"] = fullName;
    }
    if (givenName != null) {
      _json["givenName"] = givenName;
    }
    return _json;
  }
}

/** Request to reclaim a student submission. */
class ReclaimStudentSubmissionRequest {

  ReclaimStudentSubmissionRequest();

  ReclaimStudentSubmissionRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Request to return a student submission. */
class ReturnStudentSubmissionRequest {

  ReturnStudentSubmissionRequest();

  ReturnStudentSubmissionRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Drive file that is used as material for course work. */
class SharedDriveFile {
  /** Drive file details. */
  DriveFile driveFile;
  /**
   * Mechanism by which students access the Drive item.
   * Possible string values are:
   * - "UNKNOWN_SHARE_MODE" : A UNKNOWN_SHARE_MODE.
   * - "VIEW" : A VIEW.
   * - "EDIT" : A EDIT.
   * - "STUDENT_COPY" : A STUDENT_COPY.
   */
  core.String shareMode;

  SharedDriveFile();

  SharedDriveFile.fromJson(core.Map _json) {
    if (_json.containsKey("driveFile")) {
      driveFile = new DriveFile.fromJson(_json["driveFile"]);
    }
    if (_json.containsKey("shareMode")) {
      shareMode = _json["shareMode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (driveFile != null) {
      _json["driveFile"] = (driveFile).toJson();
    }
    if (shareMode != null) {
      _json["shareMode"] = shareMode;
    }
    return _json;
  }
}

/** Student work for a short answer question. */
class ShortAnswerSubmission {
  /** Student response to a short-answer question. */
  core.String answer;

  ShortAnswerSubmission();

  ShortAnswerSubmission.fromJson(core.Map _json) {
    if (_json.containsKey("answer")) {
      answer = _json["answer"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (answer != null) {
      _json["answer"] = answer;
    }
    return _json;
  }
}

/** Student in a course. */
class Student {
  /** Identifier of the course. Read-only. */
  core.String courseId;
  /** Global user information for the student. Read-only. */
  UserProfile profile;
  /**
   * Information about a Drive Folder for this student's work in this course.
   * Only visible to the student and domain administrators. Read-only.
   */
  DriveFolder studentWorkFolder;
  /**
   * Identifier of the user. When specified as a parameter of a request, this
   * identifier can be one of the following: * the numeric identifier for the
   * user * the email address of the user * the string literal `"me"`,
   * indicating the requesting user
   */
  core.String userId;

  Student();

  Student.fromJson(core.Map _json) {
    if (_json.containsKey("courseId")) {
      courseId = _json["courseId"];
    }
    if (_json.containsKey("profile")) {
      profile = new UserProfile.fromJson(_json["profile"]);
    }
    if (_json.containsKey("studentWorkFolder")) {
      studentWorkFolder = new DriveFolder.fromJson(_json["studentWorkFolder"]);
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (courseId != null) {
      _json["courseId"] = courseId;
    }
    if (profile != null) {
      _json["profile"] = (profile).toJson();
    }
    if (studentWorkFolder != null) {
      _json["studentWorkFolder"] = (studentWorkFolder).toJson();
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/**
 * Student submission for course work. StudentSubmission items are generated
 * when a CourseWork item is created. StudentSubmissions that have never been
 * accessed (i.e. with `state` = NEW) may not have a creation time or update
 * time.
 */
class StudentSubmission {
  /** Absolute link to the submission in the Classroom web UI. Read-only. */
  core.String alternateLink;
  /**
   * Optional grade. If unset, no grade was set. This must be a non-negative
   * integer value. This may be modified only by course teachers.
   */
  core.double assignedGrade;
  /** Submission content when course_work_type is ASSIGNMENT . */
  AssignmentSubmission assignmentSubmission;
  /**
   * Whether this student submission is associated with the Developer Console
   * project making the request. See google.classroom.Work.CreateCourseWork for
   * more details. Read-only.
   */
  core.bool associatedWithDeveloper;
  /** Identifier of the course. Read-only. */
  core.String courseId;
  /** Identifier for the course work this corresponds to. Read-only. */
  core.String courseWorkId;
  /**
   * Type of course work this submission is for. Read-only.
   * Possible string values are:
   * - "COURSE_WORK_TYPE_UNSPECIFIED" : A COURSE_WORK_TYPE_UNSPECIFIED.
   * - "ASSIGNMENT" : A ASSIGNMENT.
   * - "SHORT_ANSWER_QUESTION" : A SHORT_ANSWER_QUESTION.
   * - "MULTIPLE_CHOICE_QUESTION" : A MULTIPLE_CHOICE_QUESTION.
   */
  core.String courseWorkType;
  /**
   * Creation time of this submission. This may be unset if the student has not
   * accessed this item. Read-only.
   */
  core.String creationTime;
  /**
   * Optional pending grade. If unset, no grade was set. This must be a
   * non-negative integer value. This is only visible to and modifiable by
   * course teachers.
   */
  core.double draftGrade;
  /**
   * Classroom-assigned Identifier for the student submission. This is unique
   * among submissions for the relevant course work. Read-only.
   */
  core.String id;
  /** Whether this submission is late. Read-only. */
  core.bool late;
  /** Submission content when course_work_type is MULTIPLE_CHOICE_QUESTION. */
  MultipleChoiceSubmission multipleChoiceSubmission;
  /** Submission content when course_work_type is SHORT_ANSWER_QUESTION. */
  ShortAnswerSubmission shortAnswerSubmission;
  /**
   * State of this submission. Read-only.
   * Possible string values are:
   * - "SUBMISSION_STATE_UNSPECIFIED" : A SUBMISSION_STATE_UNSPECIFIED.
   * - "NEW" : A NEW.
   * - "CREATED" : A CREATED.
   * - "TURNED_IN" : A TURNED_IN.
   * - "RETURNED" : A RETURNED.
   * - "RECLAIMED_BY_STUDENT" : A RECLAIMED_BY_STUDENT.
   */
  core.String state;
  /**
   * Last update time of this submission. This may be unset if the student has
   * not accessed this item. Read-only.
   */
  core.String updateTime;
  /** Identifier for the student that owns this submission. Read-only. */
  core.String userId;

  StudentSubmission();

  StudentSubmission.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("assignedGrade")) {
      assignedGrade = _json["assignedGrade"];
    }
    if (_json.containsKey("assignmentSubmission")) {
      assignmentSubmission = new AssignmentSubmission.fromJson(_json["assignmentSubmission"]);
    }
    if (_json.containsKey("associatedWithDeveloper")) {
      associatedWithDeveloper = _json["associatedWithDeveloper"];
    }
    if (_json.containsKey("courseId")) {
      courseId = _json["courseId"];
    }
    if (_json.containsKey("courseWorkId")) {
      courseWorkId = _json["courseWorkId"];
    }
    if (_json.containsKey("courseWorkType")) {
      courseWorkType = _json["courseWorkType"];
    }
    if (_json.containsKey("creationTime")) {
      creationTime = _json["creationTime"];
    }
    if (_json.containsKey("draftGrade")) {
      draftGrade = _json["draftGrade"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("late")) {
      late = _json["late"];
    }
    if (_json.containsKey("multipleChoiceSubmission")) {
      multipleChoiceSubmission = new MultipleChoiceSubmission.fromJson(_json["multipleChoiceSubmission"]);
    }
    if (_json.containsKey("shortAnswerSubmission")) {
      shortAnswerSubmission = new ShortAnswerSubmission.fromJson(_json["shortAnswerSubmission"]);
    }
    if (_json.containsKey("state")) {
      state = _json["state"];
    }
    if (_json.containsKey("updateTime")) {
      updateTime = _json["updateTime"];
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (assignedGrade != null) {
      _json["assignedGrade"] = assignedGrade;
    }
    if (assignmentSubmission != null) {
      _json["assignmentSubmission"] = (assignmentSubmission).toJson();
    }
    if (associatedWithDeveloper != null) {
      _json["associatedWithDeveloper"] = associatedWithDeveloper;
    }
    if (courseId != null) {
      _json["courseId"] = courseId;
    }
    if (courseWorkId != null) {
      _json["courseWorkId"] = courseWorkId;
    }
    if (courseWorkType != null) {
      _json["courseWorkType"] = courseWorkType;
    }
    if (creationTime != null) {
      _json["creationTime"] = creationTime;
    }
    if (draftGrade != null) {
      _json["draftGrade"] = draftGrade;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (late != null) {
      _json["late"] = late;
    }
    if (multipleChoiceSubmission != null) {
      _json["multipleChoiceSubmission"] = (multipleChoiceSubmission).toJson();
    }
    if (shortAnswerSubmission != null) {
      _json["shortAnswerSubmission"] = (shortAnswerSubmission).toJson();
    }
    if (state != null) {
      _json["state"] = state;
    }
    if (updateTime != null) {
      _json["updateTime"] = updateTime;
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/** Teacher of a course. */
class Teacher {
  /** Identifier of the course. Read-only. */
  core.String courseId;
  /** Global user information for the teacher. Read-only. */
  UserProfile profile;
  /**
   * Identifier of the user. When specified as a parameter of a request, this
   * identifier can be one of the following: * the numeric identifier for the
   * user * the email address of the user * the string literal `"me"`,
   * indicating the requesting user
   */
  core.String userId;

  Teacher();

  Teacher.fromJson(core.Map _json) {
    if (_json.containsKey("courseId")) {
      courseId = _json["courseId"];
    }
    if (_json.containsKey("profile")) {
      profile = new UserProfile.fromJson(_json["profile"]);
    }
    if (_json.containsKey("userId")) {
      userId = _json["userId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (courseId != null) {
      _json["courseId"] = courseId;
    }
    if (profile != null) {
      _json["profile"] = (profile).toJson();
    }
    if (userId != null) {
      _json["userId"] = userId;
    }
    return _json;
  }
}

/**
 * Represents a time of day. The date and time zone are either not significant
 * or are specified elsewhere. An API may chose to allow leap seconds. Related
 * types are google.type.Date and `google.protobuf.Timestamp`.
 */
class TimeOfDay {
  /**
   * Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
   * to allow the value "24:00:00" for scenarios like business closing time.
   */
  core.int hours;
  /** Minutes of hour of day. Must be from 0 to 59. */
  core.int minutes;
  /** Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. */
  core.int nanos;
  /**
   * Seconds of minutes of the time. Must normally be from 0 to 59. An API may
   * allow the value 60 if it allows leap-seconds.
   */
  core.int seconds;

  TimeOfDay();

  TimeOfDay.fromJson(core.Map _json) {
    if (_json.containsKey("hours")) {
      hours = _json["hours"];
    }
    if (_json.containsKey("minutes")) {
      minutes = _json["minutes"];
    }
    if (_json.containsKey("nanos")) {
      nanos = _json["nanos"];
    }
    if (_json.containsKey("seconds")) {
      seconds = _json["seconds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hours != null) {
      _json["hours"] = hours;
    }
    if (minutes != null) {
      _json["minutes"] = minutes;
    }
    if (nanos != null) {
      _json["nanos"] = nanos;
    }
    if (seconds != null) {
      _json["seconds"] = seconds;
    }
    return _json;
  }
}

/** Request to turn in a student submission. */
class TurnInStudentSubmissionRequest {

  TurnInStudentSubmissionRequest();

  TurnInStudentSubmissionRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** Global information for a user. */
class UserProfile {
  /** Email address of the user. Read-only. */
  core.String emailAddress;
  /** Identifier of the user. Read-only. */
  core.String id;
  /** Name of the user. Read-only. */
  Name name;
  /** Global permissions of the user. Read-only. */
  core.List<GlobalPermission> permissions;
  /** URL of user's profile photo. Read-only. */
  core.String photoUrl;

  UserProfile();

  UserProfile.fromJson(core.Map _json) {
    if (_json.containsKey("emailAddress")) {
      emailAddress = _json["emailAddress"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = new Name.fromJson(_json["name"]);
    }
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"].map((value) => new GlobalPermission.fromJson(value)).toList();
    }
    if (_json.containsKey("photoUrl")) {
      photoUrl = _json["photoUrl"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (emailAddress != null) {
      _json["emailAddress"] = emailAddress;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = (name).toJson();
    }
    if (permissions != null) {
      _json["permissions"] = permissions.map((value) => (value).toJson()).toList();
    }
    if (photoUrl != null) {
      _json["photoUrl"] = photoUrl;
    }
    return _json;
  }
}

/** YouTube video item. */
class YouTubeVideo {
  /** URL that can be used to view the YouTube video. Read-only. */
  core.String alternateLink;
  /** YouTube API resource ID. */
  core.String id;
  /** URL of a thumbnail image of the YouTube video. Read-only. */
  core.String thumbnailUrl;
  /** Title of the YouTube video. Read-only. */
  core.String title;

  YouTubeVideo();

  YouTubeVideo.fromJson(core.Map _json) {
    if (_json.containsKey("alternateLink")) {
      alternateLink = _json["alternateLink"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("thumbnailUrl")) {
      thumbnailUrl = _json["thumbnailUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateLink != null) {
      _json["alternateLink"] = alternateLink;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (thumbnailUrl != null) {
      _json["thumbnailUrl"] = thumbnailUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}
