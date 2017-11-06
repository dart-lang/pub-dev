// This is a generated file (see the discoveryapis_generator project).

library googleapis.analyticsreporting.v4;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client analyticsreporting/v4';

/** Accesses Analytics report data. */
class AnalyticsreportingApi {
  /** View and manage your Google Analytics data */
  static const AnalyticsScope = "https://www.googleapis.com/auth/analytics";

  /** View your Google Analytics data */
  static const AnalyticsReadonlyScope = "https://www.googleapis.com/auth/analytics.readonly";


  final commons.ApiRequester _requester;

  ReportsResourceApi get reports => new ReportsResourceApi(_requester);

  AnalyticsreportingApi(http.Client client, {core.String rootUrl: "https://analyticsreporting.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ReportsResourceApi {
  final commons.ApiRequester _requester;

  ReportsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns the Analytics data.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [GetReportsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<GetReportsResponse> batchGet(GetReportsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v4/reports:batchGet';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new GetReportsResponse.fromJson(data));
  }

}



/**
 * Defines a cohort. A cohort is a group of users who share a common
 * characteristic. For example, all users with the same acquisition date
 * belong to the same cohort.
 */
class Cohort {
  /**
   * This is used for `FIRST_VISIT_DATE` cohort, the cohort selects users
   * whose first visit date is between start date and end date defined in the
   * DateRange. The date ranges should be aligned for cohort requests. If the
   * request contains `ga:cohortNthDay` it should be exactly one day long,
   * if `ga:cohortNthWeek` it should be aligned to the week boundary (starting
   * at Sunday and ending Saturday), and for `ga:cohortNthMonth` the date range
   * should be aligned to the month (starting at the first and ending on the
   * last day of the month).
   * For LTV requests there are no such restrictions.
   * You do not need to supply a date range for the
   * `reportsRequest.dateRanges` field.
   */
  DateRange dateRange;
  /**
   * A unique name for the cohort. If not defined name will be auto-generated
   * with values cohort_[1234...].
   */
  core.String name;
  /**
   * Type of the cohort. The only supported type as of now is
   * `FIRST_VISIT_DATE`. If this field is unspecified the cohort is treated
   * as `FIRST_VISIT_DATE` type cohort.
   * Possible string values are:
   * - "UNSPECIFIED_COHORT_TYPE" : If unspecified it's treated as
   * `FIRST_VISIT_DATE`.
   * - "FIRST_VISIT_DATE" : Cohorts that are selected based on first visit date.
   */
  core.String type;

  Cohort();

  Cohort.fromJson(core.Map _json) {
    if (_json.containsKey("dateRange")) {
      dateRange = new DateRange.fromJson(_json["dateRange"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dateRange != null) {
      _json["dateRange"] = (dateRange).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * Defines a cohort group.
 * For example:
 *
 *     "cohortGroup": {
 *       "cohorts": [{
 *         "name": "cohort 1",
 *         "type": "FIRST_VISIT_DATE",
 *         "dateRange": { "startDate": "2015-08-01", "endDate": "2015-08-01" }
 *       },{
 *         "name": "cohort 2"
 *          "type": "FIRST_VISIT_DATE"
 *          "dateRange": { "startDate": "2015-07-01", "endDate": "2015-07-01" }
 *       }]
 *     }
 */
class CohortGroup {
  /** The definition for the cohort. */
  core.List<Cohort> cohorts;
  /**
   * Enable Life Time Value (LTV).  LTV measures lifetime value for users
   * acquired through different channels.
   * Please see:
   * [Cohort Analysis](https://support.google.com/analytics/answer/6074676) and
   * [Lifetime Value](https://support.google.com/analytics/answer/6182550)
   * If the value of lifetimeValue is false:
   *
   * - The metric values are similar to the values in the web interface cohort
   *   report.
   * - The cohort definition date ranges must be aligned to the calendar week
   *   and month. i.e. while requesting `ga:cohortNthWeek` the `startDate` in
   *   the cohort definition should be a Sunday and the `endDate` should be the
   *   following Saturday, and for `ga:cohortNthMonth`, the `startDate`
   *   should be the 1st of the month and `endDate` should be the last day
   *   of the month.
   *
   * When the lifetimeValue is true:
   *
   * - The metric values will correspond to the values in the web interface
   *   LifeTime value report.
   * - The Lifetime Value report shows you how user value (Revenue) and
   *   engagement (Appviews, Goal Completions, Sessions, and Session Duration)
   *   grow during the 90 days after a user is acquired.
   * - The metrics are calculated as a cumulative average per user per the time
   *   increment.
   * - The cohort definition date ranges need not be aligned to the calendar
   *   week and month boundaries.
   * - The `viewId` must be an
   * [app view
   * ID](https://support.google.com/analytics/answer/2649553#WebVersusAppViews)
   */
  core.bool lifetimeValue;

  CohortGroup();

  CohortGroup.fromJson(core.Map _json) {
    if (_json.containsKey("cohorts")) {
      cohorts = _json["cohorts"].map((value) => new Cohort.fromJson(value)).toList();
    }
    if (_json.containsKey("lifetimeValue")) {
      lifetimeValue = _json["lifetimeValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cohorts != null) {
      _json["cohorts"] = cohorts.map((value) => (value).toJson()).toList();
    }
    if (lifetimeValue != null) {
      _json["lifetimeValue"] = lifetimeValue;
    }
    return _json;
  }
}

/** Column headers. */
class ColumnHeader {
  /** The dimension names in the response. */
  core.List<core.String> dimensions;
  /** Metric headers for the metrics in the response. */
  MetricHeader metricHeader;

  ColumnHeader();

  ColumnHeader.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("metricHeader")) {
      metricHeader = new MetricHeader.fromJson(_json["metricHeader"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (metricHeader != null) {
      _json["metricHeader"] = (metricHeader).toJson();
    }
    return _json;
  }
}

/**
 * A contiguous set of days: startDate, startDate + 1 day, ..., endDate.
 * The start and end dates are specified in
 * [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) date format `YYYY-MM-DD`.
 */
class DateRange {
  /** The end date for the query in the format `YYYY-MM-DD`. */
  core.String endDate;
  /** The start date for the query in the format `YYYY-MM-DD`. */
  core.String startDate;

  DateRange();

  DateRange.fromJson(core.Map _json) {
    if (_json.containsKey("endDate")) {
      endDate = _json["endDate"];
    }
    if (_json.containsKey("startDate")) {
      startDate = _json["startDate"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endDate != null) {
      _json["endDate"] = endDate;
    }
    if (startDate != null) {
      _json["startDate"] = startDate;
    }
    return _json;
  }
}

/**
 * Used to return a list of metrics for a single DateRange / dimension
 * combination
 */
class DateRangeValues {
  /** The values of each pivot region. */
  core.List<PivotValueRegion> pivotValueRegions;
  /** Each value corresponds to each Metric in the request. */
  core.List<core.String> values;

  DateRangeValues();

  DateRangeValues.fromJson(core.Map _json) {
    if (_json.containsKey("pivotValueRegions")) {
      pivotValueRegions = _json["pivotValueRegions"].map((value) => new PivotValueRegion.fromJson(value)).toList();
    }
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pivotValueRegions != null) {
      _json["pivotValueRegions"] = pivotValueRegions.map((value) => (value).toJson()).toList();
    }
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/**
 * [Dimensions](https://support.google.com/analytics/answer/1033861)
 * are attributes of your data. For example, the dimension `ga:city`
 * indicates the city, for example, "Paris" or "New York", from which
 * a session originates.
 */
class Dimension {
  /**
   * If non-empty, we place dimension values into buckets after string to
   * int64. Dimension values that are not the string representation of an
   * integral value will be converted to zero.  The bucket values have to be in
   * increasing order.  Each bucket is closed on the lower end, and open on the
   * upper end. The "first" bucket includes all values less than the first
   * boundary, the "last" bucket includes all values up to infinity. Dimension
   * values that fall in a bucket get transformed to a new dimension value. For
   * example, if one gives a list of "0, 1, 3, 4, 7", then we return the
   * following buckets:
   *
   * - bucket #1: values < 0, dimension value "<0"
   * - bucket #2: values in [0,1), dimension value "0"
   * - bucket #3: values in [1,3), dimension value "1-2"
   * - bucket #4: values in [3,4), dimension value "3"
   * - bucket #5: values in [4,7), dimension value "4-6"
   * - bucket #6: values >= 7, dimension value "7+"
   *
   * NOTE: If you are applying histogram mutation on any dimension, and using
   * that dimension in sort, you will want to use the sort type
   * `HISTOGRAM_BUCKET` for that purpose. Without that the dimension values
   * will be sorted according to dictionary
   * (lexicographic) order. For example the ascending dictionary order is:
   *
   *    "<50", "1001+", "121-1000", "50-120"
   *
   * And the ascending `HISTOGRAM_BUCKET` order is:
   *
   *    "<50", "50-120", "121-1000", "1001+"
   *
   * The client has to explicitly request `"orderType": "HISTOGRAM_BUCKET"`
   * for a histogram-mutated dimension.
   */
  core.List<core.String> histogramBuckets;
  /** Name of the dimension to fetch, for example `ga:browser`. */
  core.String name;

  Dimension();

  Dimension.fromJson(core.Map _json) {
    if (_json.containsKey("histogramBuckets")) {
      histogramBuckets = _json["histogramBuckets"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (histogramBuckets != null) {
      _json["histogramBuckets"] = histogramBuckets;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** Dimension filter specifies the filtering options on a dimension. */
class DimensionFilter {
  /** Should the match be case sensitive? Default is false. */
  core.bool caseSensitive;
  /**
   * The dimension to filter on. A DimensionFilter must contain a dimension.
   */
  core.String dimensionName;
  /**
   * Strings or regular expression to match against. Only the first value of
   * the list is used for comparison unless the operator is `IN_LIST`.
   * If `IN_LIST` operator, then the entire list is used to filter the
   * dimensions as explained in the description of the `IN_LIST` operator.
   */
  core.List<core.String> expressions;
  /**
   * Logical `NOT` operator. If this boolean is set to true, then the matching
   * dimension values will be excluded in the report. The default is false.
   */
  core.bool not;
  /**
   * How to match the dimension to the expression. The default is REGEXP.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : If the match type is unspecified, it is treated
   * as a `REGEXP`.
   * - "REGEXP" : The match expression is treated as a regular expression. All
   * match types
   * are not treated as regular expressions.
   * - "BEGINS_WITH" : Matches the value which begin with the match expression
   * provided.
   * - "ENDS_WITH" : Matches the values which end with the match expression
   * provided.
   * - "PARTIAL" : Substring match.
   * - "EXACT" : The value should match the match expression entirely.
   * - "NUMERIC_EQUAL" : Integer comparison filters.
   * case sensitivity is ignored for these and the expression
   * is assumed to be a string representing an integer.
   * Failure conditions:
   *
   * - If expression is not a valid int64, the client should expect
   *   an error.
   * - Input dimensions that are not valid int64 values will never match the
   *   filter.
   * - "NUMERIC_GREATER_THAN" : Checks if the dimension is numerically greater
   * than the match
   * expression. Read the description for `NUMERIC_EQUALS` for restrictions.
   * - "NUMERIC_LESS_THAN" : Checks if the dimension is numerically less than
   * the match expression.
   * Read the description for `NUMERIC_EQUALS` for restrictions.
   * - "IN_LIST" : This option is used to specify a dimension filter whose
   * expression can
   * take any value from a selected list of values. This helps avoiding
   * evaluating multiple exact match dimension filters which are OR'ed for
   * every single response row. For example:
   *
   *     expressions: ["A", "B", "C"]
   *
   * Any response row whose dimension has it is value as A, B or C, matches
   * this DimensionFilter.
   */
  core.String operator;

  DimensionFilter();

  DimensionFilter.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("dimensionName")) {
      dimensionName = _json["dimensionName"];
    }
    if (_json.containsKey("expressions")) {
      expressions = _json["expressions"];
    }
    if (_json.containsKey("not")) {
      not = _json["not"];
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (dimensionName != null) {
      _json["dimensionName"] = dimensionName;
    }
    if (expressions != null) {
      _json["expressions"] = expressions;
    }
    if (not != null) {
      _json["not"] = not;
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    return _json;
  }
}

/**
 * A group of dimension filters. Set the operator value to specify how
 * the filters are logically combined.
 */
class DimensionFilterClause {
  /**
   * The repeated set of filters. They are logically combined based on the
   * operator specified.
   */
  core.List<DimensionFilter> filters;
  /**
   * The operator for combining multiple dimension filters. If unspecified, it
   * is treated as an `OR`.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : Unspecified operator. It is treated as an `OR`.
   * - "OR" : The logical `OR` operator.
   * - "AND" : The logical `AND` operator.
   */
  core.String operator;

  DimensionFilterClause();

  DimensionFilterClause.fromJson(core.Map _json) {
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new DimensionFilter.fromJson(value)).toList();
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    return _json;
  }
}

/**
 * Dynamic segment definition for defining the segment within the request.
 * A segment can select users, sessions or both.
 */
class DynamicSegment {
  /** The name of the dynamic segment. */
  core.String name;
  /** Session Segment to select sessions to include in the segment. */
  SegmentDefinition sessionSegment;
  /** User Segment to select users to include in the segment. */
  SegmentDefinition userSegment;

  DynamicSegment();

  DynamicSegment.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sessionSegment")) {
      sessionSegment = new SegmentDefinition.fromJson(_json["sessionSegment"]);
    }
    if (_json.containsKey("userSegment")) {
      userSegment = new SegmentDefinition.fromJson(_json["userSegment"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (sessionSegment != null) {
      _json["sessionSegment"] = (sessionSegment).toJson();
    }
    if (userSegment != null) {
      _json["userSegment"] = (userSegment).toJson();
    }
    return _json;
  }
}

/** The batch request containing multiple report request. */
class GetReportsRequest {
  /**
   * Requests, each request will have a separate response.
   * There can be a maximum of 5 requests. All requests should have the same
   * `dateRanges`, `viewId`, `segments`, `samplingLevel`, and `cohortGroup`.
   */
  core.List<ReportRequest> reportRequests;

  GetReportsRequest();

  GetReportsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("reportRequests")) {
      reportRequests = _json["reportRequests"].map((value) => new ReportRequest.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (reportRequests != null) {
      _json["reportRequests"] = reportRequests.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * The main response class which holds the reports from the Reporting API
 * `batchGet` call.
 */
class GetReportsResponse {
  /** Responses corresponding to each of the request. */
  core.List<Report> reports;

  GetReportsResponse();

  GetReportsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("reports")) {
      reports = _json["reports"].map((value) => new Report.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (reports != null) {
      _json["reports"] = reports.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * [Metrics](https://support.google.com/analytics/answer/1033861)
 * are the quantitative measurements. For example, the metric `ga:users`
 * indicates the total number of users for the requested time period.
 */
class Metric {
  /**
   * An alias for the metric expression is an alternate name for the
   * expression. The alias can be used for filtering and sorting. This field
   * is optional and is useful if the expression is not a single metric but
   * a complex expression which cannot be used in filtering and sorting.
   * The alias is also used in the response column header.
   */
  core.String alias;
  /**
   * A metric expression in the request. An expression is constructed from one
   * or more metrics and numbers. Accepted operators include: Plus (+), Minus
   * (-), Negation (Unary -), Divided by (/), Multiplied by (*), Parenthesis,
   * Positive cardinal numbers (0-9), can include decimals and is limited to
   * 1024 characters. Example `ga:totalRefunds/ga:users`, in most cases the
   * metric expression is just a single metric name like `ga:users`.
   * Adding mixed `MetricType` (E.g., `CURRENCY` + `PERCENTAGE`) metrics
   * will result in unexpected results.
   */
  core.String expression;
  /**
   * Specifies how the metric expression should be formatted, for example
   * `INTEGER`.
   * Possible string values are:
   * - "METRIC_TYPE_UNSPECIFIED" : Metric type is unspecified.
   * - "INTEGER" : Integer metric.
   * - "FLOAT" : Float metric.
   * - "CURRENCY" : Currency metric.
   * - "PERCENT" : Percentage metric.
   * - "TIME" : Time metric in `HH:MM:SS` format.
   */
  core.String formattingType;

  Metric();

  Metric.fromJson(core.Map _json) {
    if (_json.containsKey("alias")) {
      alias = _json["alias"];
    }
    if (_json.containsKey("expression")) {
      expression = _json["expression"];
    }
    if (_json.containsKey("formattingType")) {
      formattingType = _json["formattingType"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alias != null) {
      _json["alias"] = alias;
    }
    if (expression != null) {
      _json["expression"] = expression;
    }
    if (formattingType != null) {
      _json["formattingType"] = formattingType;
    }
    return _json;
  }
}

/** MetricFilter specifies the filter on a metric. */
class MetricFilter {
  /** The value to compare against. */
  core.String comparisonValue;
  /**
   * The metric that will be filtered on. A metricFilter must contain a metric
   * name. A metric name can be an alias earlier defined as a metric or it can
   * also be a metric expression.
   */
  core.String metricName;
  /**
   * Logical `NOT` operator. If this boolean is set to true, then the matching
   * metric values will be excluded in the report. The default is false.
   */
  core.bool not;
  /**
   * Is the metric `EQUAL`, `LESS_THAN` or `GREATER_THAN` the
   * comparisonValue, the default is `EQUAL`. If the operator is
   * `IS_MISSING`, checks if the metric is missing and would ignore the
   * comparisonValue.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : If the operator is not specified, it is treated
   * as `EQUAL`.
   * - "EQUAL" : Should the value of the metric be exactly equal to the
   * comparison value.
   * - "LESS_THAN" : Should the value of the metric be less than to the
   * comparison value.
   * - "GREATER_THAN" : Should the value of the metric be greater than to the
   * comparison value.
   * - "IS_MISSING" : Validates if the metric is missing.
   * Doesn't take comparisonValue into account.
   */
  core.String operator;

  MetricFilter();

  MetricFilter.fromJson(core.Map _json) {
    if (_json.containsKey("comparisonValue")) {
      comparisonValue = _json["comparisonValue"];
    }
    if (_json.containsKey("metricName")) {
      metricName = _json["metricName"];
    }
    if (_json.containsKey("not")) {
      not = _json["not"];
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comparisonValue != null) {
      _json["comparisonValue"] = comparisonValue;
    }
    if (metricName != null) {
      _json["metricName"] = metricName;
    }
    if (not != null) {
      _json["not"] = not;
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    return _json;
  }
}

/**
 * Represents a group of metric filters.
 * Set the operator value to specify how the filters are logically combined.
 */
class MetricFilterClause {
  /**
   * The repeated set of filters. They are logically combined based on the
   * operator specified.
   */
  core.List<MetricFilter> filters;
  /**
   * The operator for combining multiple metric filters. If unspecified, it is
   * treated as an `OR`.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : Unspecified operator. It is treated as an `OR`.
   * - "OR" : The logical `OR` operator.
   * - "AND" : The logical `AND` operator.
   */
  core.String operator;

  MetricFilterClause();

  MetricFilterClause.fromJson(core.Map _json) {
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new MetricFilter.fromJson(value)).toList();
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    return _json;
  }
}

/** The headers for the metrics. */
class MetricHeader {
  /** Headers for the metrics in the response. */
  core.List<MetricHeaderEntry> metricHeaderEntries;
  /** Headers for the pivots in the response. */
  core.List<PivotHeader> pivotHeaders;

  MetricHeader();

  MetricHeader.fromJson(core.Map _json) {
    if (_json.containsKey("metricHeaderEntries")) {
      metricHeaderEntries = _json["metricHeaderEntries"].map((value) => new MetricHeaderEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("pivotHeaders")) {
      pivotHeaders = _json["pivotHeaders"].map((value) => new PivotHeader.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (metricHeaderEntries != null) {
      _json["metricHeaderEntries"] = metricHeaderEntries.map((value) => (value).toJson()).toList();
    }
    if (pivotHeaders != null) {
      _json["pivotHeaders"] = pivotHeaders.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Header for the metrics. */
class MetricHeaderEntry {
  /** The name of the header. */
  core.String name;
  /**
   * The type of the metric, for example `INTEGER`.
   * Possible string values are:
   * - "METRIC_TYPE_UNSPECIFIED" : Metric type is unspecified.
   * - "INTEGER" : Integer metric.
   * - "FLOAT" : Float metric.
   * - "CURRENCY" : Currency metric.
   * - "PERCENT" : Percentage metric.
   * - "TIME" : Time metric in `HH:MM:SS` format.
   */
  core.String type;

  MetricHeaderEntry();

  MetricHeaderEntry.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A list of segment filters in the `OR` group are combined with the logical OR
 * operator.
 */
class OrFiltersForSegment {
  /** List of segment filters to be combined with a `OR` operator. */
  core.List<SegmentFilterClause> segmentFilterClauses;

  OrFiltersForSegment();

  OrFiltersForSegment.fromJson(core.Map _json) {
    if (_json.containsKey("segmentFilterClauses")) {
      segmentFilterClauses = _json["segmentFilterClauses"].map((value) => new SegmentFilterClause.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (segmentFilterClauses != null) {
      _json["segmentFilterClauses"] = segmentFilterClauses.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Specifies the sorting options. */
class OrderBy {
  /**
   * The field which to sort by. The default sort order is ascending. Example:
   * `ga:browser`.
   * Note, that you can only specify one field for sort here. For example,
   * `ga:browser, ga:city` is not valid.
   */
  core.String fieldName;
  /**
   * The order type. The default orderType is `VALUE`.
   * Possible string values are:
   * - "ORDER_TYPE_UNSPECIFIED" : Unspecified order type will be treated as sort
   * based on value.
   * - "VALUE" : The sort order is based on the value of the chosen column;
   * looks only at
   * the first date range.
   * - "DELTA" : The sort order is based on the difference of the values of the
   * chosen
   * column between the first two date ranges.  Usable only if there are
   * exactly two date ranges.
   * - "SMART" : The sort order is based on weighted value of the chosen column.
   * If
   * column has n/d format, then weighted value of this ratio will
   * be `(n + totals.n)/(d + totals.d)` Usable only for metrics that
   * represent ratios.
   * - "HISTOGRAM_BUCKET" : Histogram order type is applicable only to dimension
   * columns with
   * non-empty histogram-buckets.
   * - "DIMENSION_AS_INTEGER" : If the dimensions are fixed length numbers,
   * ordinary sort would just
   * work fine. `DIMENSION_AS_INTEGER` can be used if the dimensions are
   * variable length numbers.
   */
  core.String orderType;
  /**
   * The sorting order for the field.
   * Possible string values are:
   * - "SORT_ORDER_UNSPECIFIED" : If the sort order is unspecified, the default
   * is ascending.
   * - "ASCENDING" : Ascending sort. The field will be sorted in an ascending
   * manner.
   * - "DESCENDING" : Descending sort. The field will be sorted in a descending
   * manner.
   */
  core.String sortOrder;

  OrderBy();

  OrderBy.fromJson(core.Map _json) {
    if (_json.containsKey("fieldName")) {
      fieldName = _json["fieldName"];
    }
    if (_json.containsKey("orderType")) {
      orderType = _json["orderType"];
    }
    if (_json.containsKey("sortOrder")) {
      sortOrder = _json["sortOrder"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fieldName != null) {
      _json["fieldName"] = fieldName;
    }
    if (orderType != null) {
      _json["orderType"] = orderType;
    }
    if (sortOrder != null) {
      _json["sortOrder"] = sortOrder;
    }
    return _json;
  }
}

/**
 * The Pivot describes the pivot section in the request.
 * The Pivot helps rearrange the information in the table for certain reports
 * by pivoting your data on a second dimension.
 */
class Pivot {
  /**
   * DimensionFilterClauses are logically combined with an `AND` operator: only
   * data that is included by all these DimensionFilterClauses contributes to
   * the values in this pivot region. Dimension filters can be used to restrict
   * the columns shown in the pivot region. For example if you have
   * `ga:browser` as the requested dimension in the pivot region, and you
   * specify key filters to restrict `ga:browser` to only "IE" or "Firefox",
   * then only those two browsers would show up as columns.
   */
  core.List<DimensionFilterClause> dimensionFilterClauses;
  /**
   * A list of dimensions to show as pivot columns. A Pivot can have a maximum
   * of 4 dimensions. Pivot dimensions are part of the restriction on the
   * total number of dimensions allowed in the request.
   */
  core.List<Dimension> dimensions;
  /**
   * Specifies the maximum number of groups to return.
   * The default value is 10, also the maximum value is 1,000.
   */
  core.int maxGroupCount;
  /**
   * The pivot metrics. Pivot metrics are part of the
   * restriction on total number of metrics allowed in the request.
   */
  core.List<Metric> metrics;
  /**
   * If k metrics were requested, then the response will contain some
   * data-dependent multiple of k columns in the report.  E.g., if you pivoted
   * on the dimension `ga:browser` then you'd get k columns for "Firefox", k
   * columns for "IE", k columns for "Chrome", etc. The ordering of the groups
   * of columns is determined by descending order of "total" for the first of
   * the k values.  Ties are broken by lexicographic ordering of the first
   * pivot dimension, then lexicographic ordering of the second pivot
   * dimension, and so on.  E.g., if the totals for the first value for
   * Firefox, IE, and Chrome were 8, 2, 8, respectively, the order of columns
   * would be Chrome, Firefox, IE.
   *
   * The following let you choose which of the groups of k columns are
   * included in the response.
   */
  core.int startGroup;

  Pivot();

  Pivot.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionFilterClauses")) {
      dimensionFilterClauses = _json["dimensionFilterClauses"].map((value) => new DimensionFilterClause.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("maxGroupCount")) {
      maxGroupCount = _json["maxGroupCount"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("startGroup")) {
      startGroup = _json["startGroup"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionFilterClauses != null) {
      _json["dimensionFilterClauses"] = dimensionFilterClauses.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (maxGroupCount != null) {
      _json["maxGroupCount"] = maxGroupCount;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (startGroup != null) {
      _json["startGroup"] = startGroup;
    }
    return _json;
  }
}

/** The headers for each of the pivot sections defined in the request. */
class PivotHeader {
  /** A single pivot section header. */
  core.List<PivotHeaderEntry> pivotHeaderEntries;
  /** The total number of groups for this pivot. */
  core.int totalPivotGroupsCount;

  PivotHeader();

  PivotHeader.fromJson(core.Map _json) {
    if (_json.containsKey("pivotHeaderEntries")) {
      pivotHeaderEntries = _json["pivotHeaderEntries"].map((value) => new PivotHeaderEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("totalPivotGroupsCount")) {
      totalPivotGroupsCount = _json["totalPivotGroupsCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (pivotHeaderEntries != null) {
      _json["pivotHeaderEntries"] = pivotHeaderEntries.map((value) => (value).toJson()).toList();
    }
    if (totalPivotGroupsCount != null) {
      _json["totalPivotGroupsCount"] = totalPivotGroupsCount;
    }
    return _json;
  }
}

/**
 * The headers for the each of the metric column corresponding to the metrics
 * requested in the pivots section of the response.
 */
class PivotHeaderEntry {
  /** The name of the dimensions in the pivot response. */
  core.List<core.String> dimensionNames;
  /** The values for the dimensions in the pivot. */
  core.List<core.String> dimensionValues;
  /** The metric header for the metric in the pivot. */
  MetricHeaderEntry metric;

  PivotHeaderEntry();

  PivotHeaderEntry.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionNames")) {
      dimensionNames = _json["dimensionNames"];
    }
    if (_json.containsKey("dimensionValues")) {
      dimensionValues = _json["dimensionValues"];
    }
    if (_json.containsKey("metric")) {
      metric = new MetricHeaderEntry.fromJson(_json["metric"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionNames != null) {
      _json["dimensionNames"] = dimensionNames;
    }
    if (dimensionValues != null) {
      _json["dimensionValues"] = dimensionValues;
    }
    if (metric != null) {
      _json["metric"] = (metric).toJson();
    }
    return _json;
  }
}

/** The metric values in the pivot region. */
class PivotValueRegion {
  /** The values of the metrics in each of the pivot regions. */
  core.List<core.String> values;

  PivotValueRegion();

  PivotValueRegion.fromJson(core.Map _json) {
    if (_json.containsKey("values")) {
      values = _json["values"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (values != null) {
      _json["values"] = values;
    }
    return _json;
  }
}

/** The data response corresponding to the request. */
class Report {
  /** The column headers. */
  ColumnHeader columnHeader;
  /** Response data. */
  ReportData data;
  /** Page token to retrieve the next page of results in the list. */
  core.String nextPageToken;

  Report();

  Report.fromJson(core.Map _json) {
    if (_json.containsKey("columnHeader")) {
      columnHeader = new ColumnHeader.fromJson(_json["columnHeader"]);
    }
    if (_json.containsKey("data")) {
      data = new ReportData.fromJson(_json["data"]);
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (columnHeader != null) {
      _json["columnHeader"] = (columnHeader).toJson();
    }
    if (data != null) {
      _json["data"] = (data).toJson();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The data part of the report. */
class ReportData {
  /**
   * The last time the data in the report was refreshed. All the hits received
   * before this timestamp are included in the calculation of the report.
   */
  core.String dataLastRefreshed;
  /**
   * Indicates if response to this request is golden or not. Data is
   * golden when the exact same request will not produce any new results if
   * asked at a later point in time.
   */
  core.bool isDataGolden;
  /**
   * Minimum and maximum values seen over all matching rows. These are both
   * empty when `hideValueRanges` in the request is false, or when
   * rowCount is zero.
   */
  core.List<DateRangeValues> maximums;
  /**
   * Minimum and maximum values seen over all matching rows. These are both
   * empty when `hideValueRanges` in the request is false, or when
   * rowCount is zero.
   */
  core.List<DateRangeValues> minimums;
  /** Total number of matching rows for this query. */
  core.int rowCount;
  /** There's one ReportRow for every unique combination of dimensions. */
  core.List<ReportRow> rows;
  /**
   * If the results are
   * [sampled](https://support.google.com/analytics/answer/2637192),
   * this returns the total number of samples read, one entry per date range.
   * If the results are not sampled this field will not be defined. See
   * [developer guide](/analytics/devguides/reporting/core/v4/basics#sampling)
   * for details.
   */
  core.List<core.String> samplesReadCounts;
  /**
   * If the results are
   * [sampled](https://support.google.com/analytics/answer/2637192),
   * this returns the total number of
   * samples present, one entry per date range. If the results are not sampled
   * this field will not be defined. See
   * [developer guide](/analytics/devguides/reporting/core/v4/basics#sampling)
   * for details.
   */
  core.List<core.String> samplingSpaceSizes;
  /**
   * For each requested date range, for the set of all rows that match
   * the query, every requested value format gets a total. The total
   * for a value format is computed by first totaling the metrics
   * mentioned in the value format and then evaluating the value
   * format as a scalar expression.  E.g., The "totals" for
   * `3 / (ga:sessions + 2)` we compute
   * `3 / ((sum of all relevant ga:sessions) + 2)`.
   * Totals are computed before pagination.
   */
  core.List<DateRangeValues> totals;

  ReportData();

  ReportData.fromJson(core.Map _json) {
    if (_json.containsKey("dataLastRefreshed")) {
      dataLastRefreshed = _json["dataLastRefreshed"];
    }
    if (_json.containsKey("isDataGolden")) {
      isDataGolden = _json["isDataGolden"];
    }
    if (_json.containsKey("maximums")) {
      maximums = _json["maximums"].map((value) => new DateRangeValues.fromJson(value)).toList();
    }
    if (_json.containsKey("minimums")) {
      minimums = _json["minimums"].map((value) => new DateRangeValues.fromJson(value)).toList();
    }
    if (_json.containsKey("rowCount")) {
      rowCount = _json["rowCount"];
    }
    if (_json.containsKey("rows")) {
      rows = _json["rows"].map((value) => new ReportRow.fromJson(value)).toList();
    }
    if (_json.containsKey("samplesReadCounts")) {
      samplesReadCounts = _json["samplesReadCounts"];
    }
    if (_json.containsKey("samplingSpaceSizes")) {
      samplingSpaceSizes = _json["samplingSpaceSizes"];
    }
    if (_json.containsKey("totals")) {
      totals = _json["totals"].map((value) => new DateRangeValues.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataLastRefreshed != null) {
      _json["dataLastRefreshed"] = dataLastRefreshed;
    }
    if (isDataGolden != null) {
      _json["isDataGolden"] = isDataGolden;
    }
    if (maximums != null) {
      _json["maximums"] = maximums.map((value) => (value).toJson()).toList();
    }
    if (minimums != null) {
      _json["minimums"] = minimums.map((value) => (value).toJson()).toList();
    }
    if (rowCount != null) {
      _json["rowCount"] = rowCount;
    }
    if (rows != null) {
      _json["rows"] = rows.map((value) => (value).toJson()).toList();
    }
    if (samplesReadCounts != null) {
      _json["samplesReadCounts"] = samplesReadCounts;
    }
    if (samplingSpaceSizes != null) {
      _json["samplingSpaceSizes"] = samplingSpaceSizes;
    }
    if (totals != null) {
      _json["totals"] = totals.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The main request class which specifies the Reporting API request. */
class ReportRequest {
  /**
   * Cohort group associated with this request. If there is a cohort group
   * in the request the `ga:cohort` dimension must be present.
   * Every [ReportRequest](#ReportRequest) within a `batchGet` method must
   * contain the same `cohortGroup` definition.
   */
  CohortGroup cohortGroup;
  /**
   * Date ranges in the request. The request can have a maximum of 2 date
   * ranges. The response will contain a set of metric values for each
   * combination of the dimensions for each date range in the request. So, if
   * there are two date ranges, there will be two set of metric values, one for
   * the original date range and one for the second date range.
   * The `reportRequest.dateRanges` field should not be specified for cohorts
   * or Lifetime value requests.
   * If a date range is not provided, the default date range is (startDate:
   * current date - 7 days, endDate: current date - 1 day). Every
   * [ReportRequest](#ReportRequest) within a `batchGet` method must
   * contain the same `dateRanges` definition.
   */
  core.List<DateRange> dateRanges;
  /**
   * The dimension filter clauses for filtering Dimension Values. They are
   * logically combined with the `AND` operator. Note that filtering occurs
   * before any dimensions are aggregated, so that the returned metrics
   * represent the total for only the relevant dimensions.
   */
  core.List<DimensionFilterClause> dimensionFilterClauses;
  /**
   * The dimensions requested.
   * Requests can have a total of 7 dimensions.
   */
  core.List<Dimension> dimensions;
  /**
   * Dimension or metric filters that restrict the data returned for your
   * request. To use the `filtersExpression`, supply a dimension or metric on
   * which to filter, followed by the filter expression. For example, the
   * following expression selects `ga:browser` dimension which starts with
   * Firefox; `ga:browser=~^Firefox`. For more information on dimensions
   * and metric filters, see
   * [Filters
   * reference](https://developers.google.com/analytics/devguides/reporting/core/v3/reference#filters).
   */
  core.String filtersExpression;
  /**
   * If set to true, hides the total of all metrics for all the matching rows,
   * for every date range. The default false and will return the totals.
   */
  core.bool hideTotals;
  /**
   * If set to true, hides the minimum and maximum across all matching rows.
   * The default is false and the value ranges are returned.
   */
  core.bool hideValueRanges;
  /**
   * If set to false, the response does not include rows if all the retrieved
   * metrics are equal to zero. The default is false which will exclude these
   * rows.
   */
  core.bool includeEmptyRows;
  /**
   * The metric filter clauses. They are logically combined with the `AND`
   * operator.  Metric filters look at only the first date range and not the
   * comparing date range. Note that filtering on metrics occurs after the
   * metrics are aggregated.
   */
  core.List<MetricFilterClause> metricFilterClauses;
  /**
   * The metrics requested.
   * Requests must specify at least one metric. Requests can have a
   * total of 10 metrics.
   */
  core.List<Metric> metrics;
  /**
   * Sort order on output rows. To compare two rows, the elements of the
   * following are applied in order until a difference is found.  All date
   * ranges in the output get the same row order.
   */
  core.List<OrderBy> orderBys;
  /**
   * Page size is for paging and specifies the maximum number of returned rows.
   * Page size should be >= 0. A query returns the default of 1,000 rows.
   * The Analytics Core Reporting API returns a maximum of 10,000 rows per
   * request, no matter how many you ask for. It can also return fewer rows
   * than requested, if there aren't as many dimension segments as you expect.
   * For instance, there are fewer than 300 possible values for `ga:country`,
   * so when segmenting only by country, you can't get more than 300 rows,
   * even if you set `pageSize` to a higher value.
   */
  core.int pageSize;
  /**
   * A continuation token to get the next page of the results. Adding this to
   * the request will return the rows after the pageToken. The pageToken should
   * be the value returned in the nextPageToken parameter in the response to
   * the GetReports request.
   */
  core.String pageToken;
  /** The pivot definitions. Requests can have a maximum of 2 pivots. */
  core.List<Pivot> pivots;
  /**
   * The desired report
   * [sample](https://support.google.com/analytics/answer/2637192) size.
   * If the the `samplingLevel` field is unspecified the `DEFAULT` sampling
   * level is used. Every [ReportRequest](#ReportRequest) within a
   * `batchGet` method must contain the same `samplingLevel` definition. See
   * [developer guide](/analytics/devguides/reporting/core/v4/basics#sampling)
   *  for details.
   * Possible string values are:
   * - "SAMPLING_UNSPECIFIED" : If the `samplingLevel` field is unspecified the
   * `DEFAULT` sampling level
   * is used.
   * - "DEFAULT" : Returns response with a sample size that balances speed and
   * accuracy.
   * - "SMALL" : It returns a fast response with a smaller sampling size.
   * - "LARGE" : Returns a more accurate response using a large sampling size.
   * But this
   * may result in response being slower.
   */
  core.String samplingLevel;
  /**
   * Segment the data returned for the request. A segment definition helps look
   * at a subset of the segment request. A request can contain up to four
   * segments. Every [ReportRequest](#ReportRequest) within a
   * `batchGet` method must contain the same `segments` definition. Requests
   * with segments must have the `ga:segment` dimension.
   */
  core.List<Segment> segments;
  /**
   * The Analytics
   * [view ID](https://support.google.com/analytics/answer/1009618)
   * from which to retrieve data. Every [ReportRequest](#ReportRequest)
   * within a `batchGet` method must contain the same `viewId`.
   */
  core.String viewId;

  ReportRequest();

  ReportRequest.fromJson(core.Map _json) {
    if (_json.containsKey("cohortGroup")) {
      cohortGroup = new CohortGroup.fromJson(_json["cohortGroup"]);
    }
    if (_json.containsKey("dateRanges")) {
      dateRanges = _json["dateRanges"].map((value) => new DateRange.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensionFilterClauses")) {
      dimensionFilterClauses = _json["dimensionFilterClauses"].map((value) => new DimensionFilterClause.fromJson(value)).toList();
    }
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"].map((value) => new Dimension.fromJson(value)).toList();
    }
    if (_json.containsKey("filtersExpression")) {
      filtersExpression = _json["filtersExpression"];
    }
    if (_json.containsKey("hideTotals")) {
      hideTotals = _json["hideTotals"];
    }
    if (_json.containsKey("hideValueRanges")) {
      hideValueRanges = _json["hideValueRanges"];
    }
    if (_json.containsKey("includeEmptyRows")) {
      includeEmptyRows = _json["includeEmptyRows"];
    }
    if (_json.containsKey("metricFilterClauses")) {
      metricFilterClauses = _json["metricFilterClauses"].map((value) => new MetricFilterClause.fromJson(value)).toList();
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new Metric.fromJson(value)).toList();
    }
    if (_json.containsKey("orderBys")) {
      orderBys = _json["orderBys"].map((value) => new OrderBy.fromJson(value)).toList();
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("pivots")) {
      pivots = _json["pivots"].map((value) => new Pivot.fromJson(value)).toList();
    }
    if (_json.containsKey("samplingLevel")) {
      samplingLevel = _json["samplingLevel"];
    }
    if (_json.containsKey("segments")) {
      segments = _json["segments"].map((value) => new Segment.fromJson(value)).toList();
    }
    if (_json.containsKey("viewId")) {
      viewId = _json["viewId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cohortGroup != null) {
      _json["cohortGroup"] = (cohortGroup).toJson();
    }
    if (dateRanges != null) {
      _json["dateRanges"] = dateRanges.map((value) => (value).toJson()).toList();
    }
    if (dimensionFilterClauses != null) {
      _json["dimensionFilterClauses"] = dimensionFilterClauses.map((value) => (value).toJson()).toList();
    }
    if (dimensions != null) {
      _json["dimensions"] = dimensions.map((value) => (value).toJson()).toList();
    }
    if (filtersExpression != null) {
      _json["filtersExpression"] = filtersExpression;
    }
    if (hideTotals != null) {
      _json["hideTotals"] = hideTotals;
    }
    if (hideValueRanges != null) {
      _json["hideValueRanges"] = hideValueRanges;
    }
    if (includeEmptyRows != null) {
      _json["includeEmptyRows"] = includeEmptyRows;
    }
    if (metricFilterClauses != null) {
      _json["metricFilterClauses"] = metricFilterClauses.map((value) => (value).toJson()).toList();
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    if (orderBys != null) {
      _json["orderBys"] = orderBys.map((value) => (value).toJson()).toList();
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (pivots != null) {
      _json["pivots"] = pivots.map((value) => (value).toJson()).toList();
    }
    if (samplingLevel != null) {
      _json["samplingLevel"] = samplingLevel;
    }
    if (segments != null) {
      _json["segments"] = segments.map((value) => (value).toJson()).toList();
    }
    if (viewId != null) {
      _json["viewId"] = viewId;
    }
    return _json;
  }
}

/** A row in the report. */
class ReportRow {
  /** List of requested dimensions. */
  core.List<core.String> dimensions;
  /** List of metrics for each requested DateRange. */
  core.List<DateRangeValues> metrics;

  ReportRow();

  ReportRow.fromJson(core.Map _json) {
    if (_json.containsKey("dimensions")) {
      dimensions = _json["dimensions"];
    }
    if (_json.containsKey("metrics")) {
      metrics = _json["metrics"].map((value) => new DateRangeValues.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensions != null) {
      _json["dimensions"] = dimensions;
    }
    if (metrics != null) {
      _json["metrics"] = metrics.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * The segment definition, if the report needs to be segmented.
 * A Segment is a subset of the Analytics data. For example, of the entire
 * set of users, one Segment might be users from a particular country or city.
 */
class Segment {
  /** A dynamic segment definition in the request. */
  DynamicSegment dynamicSegment;
  /**
   * The segment ID of a built-in or custom segment, for example `gaid::-3`.
   */
  core.String segmentId;

  Segment();

  Segment.fromJson(core.Map _json) {
    if (_json.containsKey("dynamicSegment")) {
      dynamicSegment = new DynamicSegment.fromJson(_json["dynamicSegment"]);
    }
    if (_json.containsKey("segmentId")) {
      segmentId = _json["segmentId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dynamicSegment != null) {
      _json["dynamicSegment"] = (dynamicSegment).toJson();
    }
    if (segmentId != null) {
      _json["segmentId"] = segmentId;
    }
    return _json;
  }
}

/**
 * SegmentDefinition defines the segment to be a set of SegmentFilters which
 * are combined together with a logical `AND` operation.
 */
class SegmentDefinition {
  /**
   * A segment is defined by a set of segment filters which are combined
   * together with a logical `AND` operation.
   */
  core.List<SegmentFilter> segmentFilters;

  SegmentDefinition();

  SegmentDefinition.fromJson(core.Map _json) {
    if (_json.containsKey("segmentFilters")) {
      segmentFilters = _json["segmentFilters"].map((value) => new SegmentFilter.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (segmentFilters != null) {
      _json["segmentFilters"] = segmentFilters.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Dimension filter specifies the filtering options on a dimension. */
class SegmentDimensionFilter {
  /** Should the match be case sensitive, ignored for `IN_LIST` operator. */
  core.bool caseSensitive;
  /** Name of the dimension for which the filter is being applied. */
  core.String dimensionName;
  /**
   * The list of expressions, only the first element is used for all operators
   */
  core.List<core.String> expressions;
  /** Maximum comparison values for `BETWEEN` match type. */
  core.String maxComparisonValue;
  /** Minimum comparison values for `BETWEEN` match type. */
  core.String minComparisonValue;
  /**
   * The operator to use to match the dimension with the expressions.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : If the match type is unspecified, it is treated
   * as a REGEXP.
   * - "REGEXP" : The match expression is treated as a regular expression. All
   * other match
   * types are not treated as regular expressions.
   * - "BEGINS_WITH" : Matches the values which begin with the match expression
   * provided.
   * - "ENDS_WITH" : Matches the values which end with the match expression
   * provided.
   * - "PARTIAL" : Substring match.
   * - "EXACT" : The value should match the match expression entirely.
   * - "IN_LIST" : This option is used to specify a dimension filter whose
   * expression can
   * take any value from a selected list of values. This helps avoiding
   * evaluating multiple exact match dimension filters which are OR'ed for
   * every single response row. For example:
   *
   *     expressions: ["A", "B", "C"]
   *
   * Any response row whose dimension has it is value as A, B or C, matches
   * this DimensionFilter.
   * - "NUMERIC_LESS_THAN" : Integer comparison filters.
   * case sensitivity is ignored for these and the expression
   * is assumed to be a string representing an integer.
   * Failure conditions:
   *
   * - if expression is not a valid int64, the client should expect
   *   an error.
   * - input dimensions that are not valid int64 values will never match the
   *   filter.
   *
   * Checks if the dimension is numerically less than the match expression.
   * - "NUMERIC_GREATER_THAN" : Checks if the dimension is numerically greater
   * than the match
   * expression.
   * - "NUMERIC_BETWEEN" : Checks if the dimension is numerically between the
   * minimum and maximum
   * of the match expression, boundaries excluded.
   */
  core.String operator;

  SegmentDimensionFilter();

  SegmentDimensionFilter.fromJson(core.Map _json) {
    if (_json.containsKey("caseSensitive")) {
      caseSensitive = _json["caseSensitive"];
    }
    if (_json.containsKey("dimensionName")) {
      dimensionName = _json["dimensionName"];
    }
    if (_json.containsKey("expressions")) {
      expressions = _json["expressions"];
    }
    if (_json.containsKey("maxComparisonValue")) {
      maxComparisonValue = _json["maxComparisonValue"];
    }
    if (_json.containsKey("minComparisonValue")) {
      minComparisonValue = _json["minComparisonValue"];
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (caseSensitive != null) {
      _json["caseSensitive"] = caseSensitive;
    }
    if (dimensionName != null) {
      _json["dimensionName"] = dimensionName;
    }
    if (expressions != null) {
      _json["expressions"] = expressions;
    }
    if (maxComparisonValue != null) {
      _json["maxComparisonValue"] = maxComparisonValue;
    }
    if (minComparisonValue != null) {
      _json["minComparisonValue"] = minComparisonValue;
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    return _json;
  }
}

/**
 * SegmentFilter defines the segment to be either a simple or a sequence
 * segment. A simple segment condition contains dimension and metric conditions
 * to select the sessions or users. A sequence segment condition can be used to
 * select users or sessions based on sequential conditions.
 */
class SegmentFilter {
  /**
   * If true, match the complement of simple or sequence segment.
   * For example, to match all visits not from "New York", we can define the
   * segment as follows:
   *
   *       "sessionSegment": {
   *         "segmentFilters": [{
   *           "simpleSegment" :{
   *             "orFiltersForSegment": [{
   *               "segmentFilterClauses":[{
   *                 "dimensionFilter": {
   *                   "dimensionName": "ga:city",
   *                   "expressions": ["New York"]
   *                 }
   *               }]
   *             }]
   *           },
   *           "not": "True"
   *         }]
   *       },
   */
  core.bool not;
  /**
   * Sequence conditions consist of one or more steps, where each step is
   * defined by one or more dimension/metric conditions. Multiple steps can
   * be combined with special sequence operators.
   */
  SequenceSegment sequenceSegment;
  /**
   * A Simple segment conditions consist of one or more dimension/metric
   * conditions that can be combined
   */
  SimpleSegment simpleSegment;

  SegmentFilter();

  SegmentFilter.fromJson(core.Map _json) {
    if (_json.containsKey("not")) {
      not = _json["not"];
    }
    if (_json.containsKey("sequenceSegment")) {
      sequenceSegment = new SequenceSegment.fromJson(_json["sequenceSegment"]);
    }
    if (_json.containsKey("simpleSegment")) {
      simpleSegment = new SimpleSegment.fromJson(_json["simpleSegment"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (not != null) {
      _json["not"] = not;
    }
    if (sequenceSegment != null) {
      _json["sequenceSegment"] = (sequenceSegment).toJson();
    }
    if (simpleSegment != null) {
      _json["simpleSegment"] = (simpleSegment).toJson();
    }
    return _json;
  }
}

/**
 * Filter Clause to be used in a segment definition, can be wither a metric or
 * a dimension filter.
 */
class SegmentFilterClause {
  /** Dimension Filter for the segment definition. */
  SegmentDimensionFilter dimensionFilter;
  /** Metric Filter for the segment definition. */
  SegmentMetricFilter metricFilter;
  /** Matches the complement (`!`) of the filter. */
  core.bool not;

  SegmentFilterClause();

  SegmentFilterClause.fromJson(core.Map _json) {
    if (_json.containsKey("dimensionFilter")) {
      dimensionFilter = new SegmentDimensionFilter.fromJson(_json["dimensionFilter"]);
    }
    if (_json.containsKey("metricFilter")) {
      metricFilter = new SegmentMetricFilter.fromJson(_json["metricFilter"]);
    }
    if (_json.containsKey("not")) {
      not = _json["not"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dimensionFilter != null) {
      _json["dimensionFilter"] = (dimensionFilter).toJson();
    }
    if (metricFilter != null) {
      _json["metricFilter"] = (metricFilter).toJson();
    }
    if (not != null) {
      _json["not"] = not;
    }
    return _json;
  }
}

/** Metric filter to be used in a segment filter clause. */
class SegmentMetricFilter {
  /**
   * The value to compare against. If the operator is `BETWEEN`, this value is
   * treated as minimum comparison value.
   */
  core.String comparisonValue;
  /** Max comparison value is only used for `BETWEEN` operator. */
  core.String maxComparisonValue;
  /**
   * The metric that will be filtered on. A `metricFilter` must contain a
   * metric name.
   */
  core.String metricName;
  /**
   * Specifies is the operation to perform to compare the metric. The default
   * is `EQUAL`.
   * Possible string values are:
   * - "UNSPECIFIED_OPERATOR" : Unspecified operator is treated as `LESS_THAN`
   * operator.
   * - "LESS_THAN" : Checks if the metric value is less than comparison value.
   * - "GREATER_THAN" : Checks if the metric value is greater than comparison
   * value.
   * - "EQUAL" : Equals operator.
   * - "BETWEEN" : For between operator, both the minimum and maximum are
   * exclusive.
   * We will use `LT` and `GT` for comparison.
   */
  core.String operator;
  /**
   * Scope for a metric defines the level at which that metric is defined.  The
   * specified metric scope must be equal to or greater than its primary scope
   * as defined in the data model. The primary scope is defined by if the
   * segment is selecting users or sessions.
   * Possible string values are:
   * - "UNSPECIFIED_SCOPE" : If the scope is unspecified, it defaults to the
   * condition scope,
   * `USER` or `SESSION` depending on if the segment is trying to choose
   * users or sessions.
   * - "PRODUCT" : Product scope.
   * - "HIT" : Hit scope.
   * - "SESSION" : Session scope.
   * - "USER" : User scope.
   */
  core.String scope;

  SegmentMetricFilter();

  SegmentMetricFilter.fromJson(core.Map _json) {
    if (_json.containsKey("comparisonValue")) {
      comparisonValue = _json["comparisonValue"];
    }
    if (_json.containsKey("maxComparisonValue")) {
      maxComparisonValue = _json["maxComparisonValue"];
    }
    if (_json.containsKey("metricName")) {
      metricName = _json["metricName"];
    }
    if (_json.containsKey("operator")) {
      operator = _json["operator"];
    }
    if (_json.containsKey("scope")) {
      scope = _json["scope"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (comparisonValue != null) {
      _json["comparisonValue"] = comparisonValue;
    }
    if (maxComparisonValue != null) {
      _json["maxComparisonValue"] = maxComparisonValue;
    }
    if (metricName != null) {
      _json["metricName"] = metricName;
    }
    if (operator != null) {
      _json["operator"] = operator;
    }
    if (scope != null) {
      _json["scope"] = scope;
    }
    return _json;
  }
}

/** A segment sequence definition. */
class SegmentSequenceStep {
  /**
   * Specifies if the step immediately precedes or can be any time before the
   * next step.
   * Possible string values are:
   * - "UNSPECIFIED_MATCH_TYPE" : Unspecified match type is treated as precedes.
   * - "PRECEDES" : Operator indicates that the previous step precedes the next
   * step.
   * - "IMMEDIATELY_PRECEDES" : Operator indicates that the previous step
   * immediately precedes the next
   * step.
   */
  core.String matchType;
  /**
   * A sequence is specified with a list of Or grouped filters which are
   * combined with `AND` operator.
   */
  core.List<OrFiltersForSegment> orFiltersForSegment;

  SegmentSequenceStep();

  SegmentSequenceStep.fromJson(core.Map _json) {
    if (_json.containsKey("matchType")) {
      matchType = _json["matchType"];
    }
    if (_json.containsKey("orFiltersForSegment")) {
      orFiltersForSegment = _json["orFiltersForSegment"].map((value) => new OrFiltersForSegment.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (matchType != null) {
      _json["matchType"] = matchType;
    }
    if (orFiltersForSegment != null) {
      _json["orFiltersForSegment"] = orFiltersForSegment.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Sequence conditions consist of one or more steps, where each step is defined
 * by one or more dimension/metric conditions. Multiple steps can be combined
 * with special sequence operators.
 */
class SequenceSegment {
  /**
   * If set, first step condition must match the first hit of the visitor (in
   * the date range).
   */
  core.bool firstStepShouldMatchFirstHit;
  /** The list of steps in the sequence. */
  core.List<SegmentSequenceStep> segmentSequenceSteps;

  SequenceSegment();

  SequenceSegment.fromJson(core.Map _json) {
    if (_json.containsKey("firstStepShouldMatchFirstHit")) {
      firstStepShouldMatchFirstHit = _json["firstStepShouldMatchFirstHit"];
    }
    if (_json.containsKey("segmentSequenceSteps")) {
      segmentSequenceSteps = _json["segmentSequenceSteps"].map((value) => new SegmentSequenceStep.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (firstStepShouldMatchFirstHit != null) {
      _json["firstStepShouldMatchFirstHit"] = firstStepShouldMatchFirstHit;
    }
    if (segmentSequenceSteps != null) {
      _json["segmentSequenceSteps"] = segmentSequenceSteps.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * A Simple segment conditions consist of one or more dimension/metric
 * conditions that can be combined.
 */
class SimpleSegment {
  /**
   * A list of segment filters groups which are combined with logical `AND`
   * operator.
   */
  core.List<OrFiltersForSegment> orFiltersForSegment;

  SimpleSegment();

  SimpleSegment.fromJson(core.Map _json) {
    if (_json.containsKey("orFiltersForSegment")) {
      orFiltersForSegment = _json["orFiltersForSegment"].map((value) => new OrFiltersForSegment.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (orFiltersForSegment != null) {
      _json["orFiltersForSegment"] = orFiltersForSegment.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
