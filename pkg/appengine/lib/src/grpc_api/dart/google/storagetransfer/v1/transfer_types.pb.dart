///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer_types;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/duration.pb.dart' as google$protobuf;
import '../../type/date.pb.dart' as google$type;
import '../../type/timeofday.pb.dart' as google$type;
import '../../protobuf/timestamp.pb.dart' as google$protobuf;

import 'transfer_types.pbenum.dart';
import '../../rpc/code.pbenum.dart' as google$rpc;

export 'transfer_types.pbenum.dart';

class GoogleServiceAccount extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GoogleServiceAccount')
    ..a/*<String>*/(1, 'accountEmail', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GoogleServiceAccount() : super();
  GoogleServiceAccount.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GoogleServiceAccount.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GoogleServiceAccount clone() => new GoogleServiceAccount()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GoogleServiceAccount create() => new GoogleServiceAccount();
  static PbList<GoogleServiceAccount> createRepeated() => new PbList<GoogleServiceAccount>();
  static GoogleServiceAccount getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGoogleServiceAccount();
    return _defaultInstance;
  }
  static GoogleServiceAccount _defaultInstance;
  static void $checkItem(GoogleServiceAccount v) {
    if (v is !GoogleServiceAccount) checkItemFailed(v, 'GoogleServiceAccount');
  }

  String get accountEmail => $_get(0, 1, '');
  void set accountEmail(String v) { $_setString(0, 1, v); }
  bool hasAccountEmail() => $_has(0, 1);
  void clearAccountEmail() => clearField(1);
}

class _ReadonlyGoogleServiceAccount extends GoogleServiceAccount with ReadonlyMessageMixin {}

class AwsAccessKey extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AwsAccessKey')
    ..a/*<String>*/(1, 'accessKeyId', PbFieldType.OS)
    ..a/*<String>*/(2, 'secretAccessKey', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AwsAccessKey() : super();
  AwsAccessKey.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AwsAccessKey.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AwsAccessKey clone() => new AwsAccessKey()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AwsAccessKey create() => new AwsAccessKey();
  static PbList<AwsAccessKey> createRepeated() => new PbList<AwsAccessKey>();
  static AwsAccessKey getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAwsAccessKey();
    return _defaultInstance;
  }
  static AwsAccessKey _defaultInstance;
  static void $checkItem(AwsAccessKey v) {
    if (v is !AwsAccessKey) checkItemFailed(v, 'AwsAccessKey');
  }

  String get accessKeyId => $_get(0, 1, '');
  void set accessKeyId(String v) { $_setString(0, 1, v); }
  bool hasAccessKeyId() => $_has(0, 1);
  void clearAccessKeyId() => clearField(1);

  String get secretAccessKey => $_get(1, 2, '');
  void set secretAccessKey(String v) { $_setString(1, 2, v); }
  bool hasSecretAccessKey() => $_has(1, 2);
  void clearSecretAccessKey() => clearField(2);
}

class _ReadonlyAwsAccessKey extends AwsAccessKey with ReadonlyMessageMixin {}

class ObjectConditions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ObjectConditions')
    ..a/*<google$protobuf.Duration>*/(1, 'minTimeElapsedSinceLastModification', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<google$protobuf.Duration>*/(2, 'maxTimeElapsedSinceLastModification', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..p/*<String>*/(3, 'includePrefixes', PbFieldType.PS)
    ..p/*<String>*/(4, 'excludePrefixes', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ObjectConditions() : super();
  ObjectConditions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ObjectConditions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ObjectConditions clone() => new ObjectConditions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ObjectConditions create() => new ObjectConditions();
  static PbList<ObjectConditions> createRepeated() => new PbList<ObjectConditions>();
  static ObjectConditions getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyObjectConditions();
    return _defaultInstance;
  }
  static ObjectConditions _defaultInstance;
  static void $checkItem(ObjectConditions v) {
    if (v is !ObjectConditions) checkItemFailed(v, 'ObjectConditions');
  }

  google$protobuf.Duration get minTimeElapsedSinceLastModification => $_get(0, 1, null);
  void set minTimeElapsedSinceLastModification(google$protobuf.Duration v) { setField(1, v); }
  bool hasMinTimeElapsedSinceLastModification() => $_has(0, 1);
  void clearMinTimeElapsedSinceLastModification() => clearField(1);

  google$protobuf.Duration get maxTimeElapsedSinceLastModification => $_get(1, 2, null);
  void set maxTimeElapsedSinceLastModification(google$protobuf.Duration v) { setField(2, v); }
  bool hasMaxTimeElapsedSinceLastModification() => $_has(1, 2);
  void clearMaxTimeElapsedSinceLastModification() => clearField(2);

  List<String> get includePrefixes => $_get(2, 3, null);

  List<String> get excludePrefixes => $_get(3, 4, null);
}

class _ReadonlyObjectConditions extends ObjectConditions with ReadonlyMessageMixin {}

class GcsData extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GcsData')
    ..a/*<String>*/(1, 'bucketName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GcsData() : super();
  GcsData.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GcsData.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GcsData clone() => new GcsData()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GcsData create() => new GcsData();
  static PbList<GcsData> createRepeated() => new PbList<GcsData>();
  static GcsData getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGcsData();
    return _defaultInstance;
  }
  static GcsData _defaultInstance;
  static void $checkItem(GcsData v) {
    if (v is !GcsData) checkItemFailed(v, 'GcsData');
  }

  String get bucketName => $_get(0, 1, '');
  void set bucketName(String v) { $_setString(0, 1, v); }
  bool hasBucketName() => $_has(0, 1);
  void clearBucketName() => clearField(1);
}

class _ReadonlyGcsData extends GcsData with ReadonlyMessageMixin {}

class AwsS3Data extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AwsS3Data')
    ..a/*<String>*/(1, 'bucketName', PbFieldType.OS)
    ..a/*<AwsAccessKey>*/(2, 'awsAccessKey', PbFieldType.OM, AwsAccessKey.getDefault, AwsAccessKey.create)
    ..hasRequiredFields = false
  ;

  AwsS3Data() : super();
  AwsS3Data.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AwsS3Data.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AwsS3Data clone() => new AwsS3Data()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AwsS3Data create() => new AwsS3Data();
  static PbList<AwsS3Data> createRepeated() => new PbList<AwsS3Data>();
  static AwsS3Data getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAwsS3Data();
    return _defaultInstance;
  }
  static AwsS3Data _defaultInstance;
  static void $checkItem(AwsS3Data v) {
    if (v is !AwsS3Data) checkItemFailed(v, 'AwsS3Data');
  }

  String get bucketName => $_get(0, 1, '');
  void set bucketName(String v) { $_setString(0, 1, v); }
  bool hasBucketName() => $_has(0, 1);
  void clearBucketName() => clearField(1);

  AwsAccessKey get awsAccessKey => $_get(1, 2, null);
  void set awsAccessKey(AwsAccessKey v) { setField(2, v); }
  bool hasAwsAccessKey() => $_has(1, 2);
  void clearAwsAccessKey() => clearField(2);
}

class _ReadonlyAwsS3Data extends AwsS3Data with ReadonlyMessageMixin {}

class HttpData extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpData')
    ..a/*<String>*/(1, 'listUrl', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  HttpData() : super();
  HttpData.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpData.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpData clone() => new HttpData()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpData create() => new HttpData();
  static PbList<HttpData> createRepeated() => new PbList<HttpData>();
  static HttpData getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpData();
    return _defaultInstance;
  }
  static HttpData _defaultInstance;
  static void $checkItem(HttpData v) {
    if (v is !HttpData) checkItemFailed(v, 'HttpData');
  }

  String get listUrl => $_get(0, 1, '');
  void set listUrl(String v) { $_setString(0, 1, v); }
  bool hasListUrl() => $_has(0, 1);
  void clearListUrl() => clearField(1);
}

class _ReadonlyHttpData extends HttpData with ReadonlyMessageMixin {}

class TransferOptions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TransferOptions')
    ..a/*<bool>*/(1, 'overwriteObjectsAlreadyExistingInSink', PbFieldType.OB)
    ..a/*<bool>*/(2, 'deleteObjectsUniqueInSink', PbFieldType.OB)
    ..a/*<bool>*/(3, 'deleteObjectsFromSourceAfterTransfer', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  TransferOptions() : super();
  TransferOptions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TransferOptions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TransferOptions clone() => new TransferOptions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TransferOptions create() => new TransferOptions();
  static PbList<TransferOptions> createRepeated() => new PbList<TransferOptions>();
  static TransferOptions getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTransferOptions();
    return _defaultInstance;
  }
  static TransferOptions _defaultInstance;
  static void $checkItem(TransferOptions v) {
    if (v is !TransferOptions) checkItemFailed(v, 'TransferOptions');
  }

  bool get overwriteObjectsAlreadyExistingInSink => $_get(0, 1, false);
  void set overwriteObjectsAlreadyExistingInSink(bool v) { $_setBool(0, 1, v); }
  bool hasOverwriteObjectsAlreadyExistingInSink() => $_has(0, 1);
  void clearOverwriteObjectsAlreadyExistingInSink() => clearField(1);

  bool get deleteObjectsUniqueInSink => $_get(1, 2, false);
  void set deleteObjectsUniqueInSink(bool v) { $_setBool(1, 2, v); }
  bool hasDeleteObjectsUniqueInSink() => $_has(1, 2);
  void clearDeleteObjectsUniqueInSink() => clearField(2);

  bool get deleteObjectsFromSourceAfterTransfer => $_get(2, 3, false);
  void set deleteObjectsFromSourceAfterTransfer(bool v) { $_setBool(2, 3, v); }
  bool hasDeleteObjectsFromSourceAfterTransfer() => $_has(2, 3);
  void clearDeleteObjectsFromSourceAfterTransfer() => clearField(3);
}

class _ReadonlyTransferOptions extends TransferOptions with ReadonlyMessageMixin {}

class TransferSpec extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TransferSpec')
    ..a/*<GcsData>*/(1, 'gcsDataSource', PbFieldType.OM, GcsData.getDefault, GcsData.create)
    ..a/*<AwsS3Data>*/(2, 'awsS3DataSource', PbFieldType.OM, AwsS3Data.getDefault, AwsS3Data.create)
    ..a/*<HttpData>*/(3, 'httpDataSource', PbFieldType.OM, HttpData.getDefault, HttpData.create)
    ..a/*<GcsData>*/(4, 'gcsDataSink', PbFieldType.OM, GcsData.getDefault, GcsData.create)
    ..a/*<ObjectConditions>*/(5, 'objectConditions', PbFieldType.OM, ObjectConditions.getDefault, ObjectConditions.create)
    ..a/*<TransferOptions>*/(6, 'transferOptions', PbFieldType.OM, TransferOptions.getDefault, TransferOptions.create)
    ..hasRequiredFields = false
  ;

  TransferSpec() : super();
  TransferSpec.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TransferSpec.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TransferSpec clone() => new TransferSpec()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TransferSpec create() => new TransferSpec();
  static PbList<TransferSpec> createRepeated() => new PbList<TransferSpec>();
  static TransferSpec getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTransferSpec();
    return _defaultInstance;
  }
  static TransferSpec _defaultInstance;
  static void $checkItem(TransferSpec v) {
    if (v is !TransferSpec) checkItemFailed(v, 'TransferSpec');
  }

  GcsData get gcsDataSource => $_get(0, 1, null);
  void set gcsDataSource(GcsData v) { setField(1, v); }
  bool hasGcsDataSource() => $_has(0, 1);
  void clearGcsDataSource() => clearField(1);

  AwsS3Data get awsS3DataSource => $_get(1, 2, null);
  void set awsS3DataSource(AwsS3Data v) { setField(2, v); }
  bool hasAwsS3DataSource() => $_has(1, 2);
  void clearAwsS3DataSource() => clearField(2);

  HttpData get httpDataSource => $_get(2, 3, null);
  void set httpDataSource(HttpData v) { setField(3, v); }
  bool hasHttpDataSource() => $_has(2, 3);
  void clearHttpDataSource() => clearField(3);

  GcsData get gcsDataSink => $_get(3, 4, null);
  void set gcsDataSink(GcsData v) { setField(4, v); }
  bool hasGcsDataSink() => $_has(3, 4);
  void clearGcsDataSink() => clearField(4);

  ObjectConditions get objectConditions => $_get(4, 5, null);
  void set objectConditions(ObjectConditions v) { setField(5, v); }
  bool hasObjectConditions() => $_has(4, 5);
  void clearObjectConditions() => clearField(5);

  TransferOptions get transferOptions => $_get(5, 6, null);
  void set transferOptions(TransferOptions v) { setField(6, v); }
  bool hasTransferOptions() => $_has(5, 6);
  void clearTransferOptions() => clearField(6);
}

class _ReadonlyTransferSpec extends TransferSpec with ReadonlyMessageMixin {}

class Schedule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Schedule')
    ..a/*<google$type.Date>*/(1, 'scheduleStartDate', PbFieldType.OM, google$type.Date.getDefault, google$type.Date.create)
    ..a/*<google$type.Date>*/(2, 'scheduleEndDate', PbFieldType.OM, google$type.Date.getDefault, google$type.Date.create)
    ..a/*<google$type.TimeOfDay>*/(3, 'startTimeOfDay', PbFieldType.OM, google$type.TimeOfDay.getDefault, google$type.TimeOfDay.create)
    ..hasRequiredFields = false
  ;

  Schedule() : super();
  Schedule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Schedule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Schedule clone() => new Schedule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Schedule create() => new Schedule();
  static PbList<Schedule> createRepeated() => new PbList<Schedule>();
  static Schedule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySchedule();
    return _defaultInstance;
  }
  static Schedule _defaultInstance;
  static void $checkItem(Schedule v) {
    if (v is !Schedule) checkItemFailed(v, 'Schedule');
  }

  google$type.Date get scheduleStartDate => $_get(0, 1, null);
  void set scheduleStartDate(google$type.Date v) { setField(1, v); }
  bool hasScheduleStartDate() => $_has(0, 1);
  void clearScheduleStartDate() => clearField(1);

  google$type.Date get scheduleEndDate => $_get(1, 2, null);
  void set scheduleEndDate(google$type.Date v) { setField(2, v); }
  bool hasScheduleEndDate() => $_has(1, 2);
  void clearScheduleEndDate() => clearField(2);

  google$type.TimeOfDay get startTimeOfDay => $_get(2, 3, null);
  void set startTimeOfDay(google$type.TimeOfDay v) { setField(3, v); }
  bool hasStartTimeOfDay() => $_has(2, 3);
  void clearStartTimeOfDay() => clearField(3);
}

class _ReadonlySchedule extends Schedule with ReadonlyMessageMixin {}

class TransferJob extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TransferJob')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<String>*/(3, 'projectId', PbFieldType.OS)
    ..a/*<TransferSpec>*/(4, 'transferSpec', PbFieldType.OM, TransferSpec.getDefault, TransferSpec.create)
    ..a/*<Schedule>*/(5, 'schedule', PbFieldType.OM, Schedule.getDefault, Schedule.create)
    ..e/*<TransferJob_Status>*/(6, 'status', PbFieldType.OE, TransferJob_Status.STATUS_UNSPECIFIED, TransferJob_Status.valueOf)
    ..a/*<google$protobuf.Timestamp>*/(7, 'creationTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(8, 'lastModificationTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(9, 'deletionTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TransferJob() : super();
  TransferJob.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TransferJob.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TransferJob clone() => new TransferJob()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TransferJob create() => new TransferJob();
  static PbList<TransferJob> createRepeated() => new PbList<TransferJob>();
  static TransferJob getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTransferJob();
    return _defaultInstance;
  }
  static TransferJob _defaultInstance;
  static void $checkItem(TransferJob v) {
    if (v is !TransferJob) checkItemFailed(v, 'TransferJob');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  String get projectId => $_get(2, 3, '');
  void set projectId(String v) { $_setString(2, 3, v); }
  bool hasProjectId() => $_has(2, 3);
  void clearProjectId() => clearField(3);

  TransferSpec get transferSpec => $_get(3, 4, null);
  void set transferSpec(TransferSpec v) { setField(4, v); }
  bool hasTransferSpec() => $_has(3, 4);
  void clearTransferSpec() => clearField(4);

  Schedule get schedule => $_get(4, 5, null);
  void set schedule(Schedule v) { setField(5, v); }
  bool hasSchedule() => $_has(4, 5);
  void clearSchedule() => clearField(5);

  TransferJob_Status get status => $_get(5, 6, null);
  void set status(TransferJob_Status v) { setField(6, v); }
  bool hasStatus() => $_has(5, 6);
  void clearStatus() => clearField(6);

  google$protobuf.Timestamp get creationTime => $_get(6, 7, null);
  void set creationTime(google$protobuf.Timestamp v) { setField(7, v); }
  bool hasCreationTime() => $_has(6, 7);
  void clearCreationTime() => clearField(7);

  google$protobuf.Timestamp get lastModificationTime => $_get(7, 8, null);
  void set lastModificationTime(google$protobuf.Timestamp v) { setField(8, v); }
  bool hasLastModificationTime() => $_has(7, 8);
  void clearLastModificationTime() => clearField(8);

  google$protobuf.Timestamp get deletionTime => $_get(8, 9, null);
  void set deletionTime(google$protobuf.Timestamp v) { setField(9, v); }
  bool hasDeletionTime() => $_has(8, 9);
  void clearDeletionTime() => clearField(9);
}

class _ReadonlyTransferJob extends TransferJob with ReadonlyMessageMixin {}

class ErrorLogEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorLogEntry')
    ..a/*<String>*/(1, 'url', PbFieldType.OS)
    ..p/*<String>*/(3, 'errorDetails', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ErrorLogEntry() : super();
  ErrorLogEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorLogEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorLogEntry clone() => new ErrorLogEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorLogEntry create() => new ErrorLogEntry();
  static PbList<ErrorLogEntry> createRepeated() => new PbList<ErrorLogEntry>();
  static ErrorLogEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorLogEntry();
    return _defaultInstance;
  }
  static ErrorLogEntry _defaultInstance;
  static void $checkItem(ErrorLogEntry v) {
    if (v is !ErrorLogEntry) checkItemFailed(v, 'ErrorLogEntry');
  }

  String get url => $_get(0, 1, '');
  void set url(String v) { $_setString(0, 1, v); }
  bool hasUrl() => $_has(0, 1);
  void clearUrl() => clearField(1);

  List<String> get errorDetails => $_get(1, 3, null);
}

class _ReadonlyErrorLogEntry extends ErrorLogEntry with ReadonlyMessageMixin {}

class ErrorSummary extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorSummary')
    ..e/*<google$rpc.Code>*/(1, 'errorCode', PbFieldType.OE, google$rpc.Code.OK, google$rpc.Code.valueOf)
    ..a/*<Int64>*/(2, 'errorCount', PbFieldType.O6, Int64.ZERO)
    ..pp/*<ErrorLogEntry>*/(3, 'errorLogEntries', PbFieldType.PM, ErrorLogEntry.$checkItem, ErrorLogEntry.create)
    ..hasRequiredFields = false
  ;

  ErrorSummary() : super();
  ErrorSummary.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorSummary.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorSummary clone() => new ErrorSummary()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorSummary create() => new ErrorSummary();
  static PbList<ErrorSummary> createRepeated() => new PbList<ErrorSummary>();
  static ErrorSummary getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorSummary();
    return _defaultInstance;
  }
  static ErrorSummary _defaultInstance;
  static void $checkItem(ErrorSummary v) {
    if (v is !ErrorSummary) checkItemFailed(v, 'ErrorSummary');
  }

  google$rpc.Code get errorCode => $_get(0, 1, null);
  void set errorCode(google$rpc.Code v) { setField(1, v); }
  bool hasErrorCode() => $_has(0, 1);
  void clearErrorCode() => clearField(1);

  Int64 get errorCount => $_get(1, 2, null);
  void set errorCount(Int64 v) { $_setInt64(1, 2, v); }
  bool hasErrorCount() => $_has(1, 2);
  void clearErrorCount() => clearField(2);

  List<ErrorLogEntry> get errorLogEntries => $_get(2, 3, null);
}

class _ReadonlyErrorSummary extends ErrorSummary with ReadonlyMessageMixin {}

class TransferCounters extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TransferCounters')
    ..a/*<Int64>*/(1, 'objectsFoundFromSource', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(2, 'bytesFoundFromSource', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(3, 'objectsFoundOnlyFromSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(4, 'bytesFoundOnlyFromSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(5, 'objectsFromSourceSkippedBySync', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(6, 'bytesFromSourceSkippedBySync', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(7, 'objectsCopiedToSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(8, 'bytesCopiedToSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(9, 'objectsDeletedFromSource', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(10, 'bytesDeletedFromSource', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(11, 'objectsDeletedFromSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(12, 'bytesDeletedFromSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(13, 'objectsFromSourceFailed', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(14, 'bytesFromSourceFailed', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(15, 'objectsFailedToDeleteFromSink', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(16, 'bytesFailedToDeleteFromSink', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  TransferCounters() : super();
  TransferCounters.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TransferCounters.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TransferCounters clone() => new TransferCounters()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TransferCounters create() => new TransferCounters();
  static PbList<TransferCounters> createRepeated() => new PbList<TransferCounters>();
  static TransferCounters getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTransferCounters();
    return _defaultInstance;
  }
  static TransferCounters _defaultInstance;
  static void $checkItem(TransferCounters v) {
    if (v is !TransferCounters) checkItemFailed(v, 'TransferCounters');
  }

  Int64 get objectsFoundFromSource => $_get(0, 1, null);
  void set objectsFoundFromSource(Int64 v) { $_setInt64(0, 1, v); }
  bool hasObjectsFoundFromSource() => $_has(0, 1);
  void clearObjectsFoundFromSource() => clearField(1);

  Int64 get bytesFoundFromSource => $_get(1, 2, null);
  void set bytesFoundFromSource(Int64 v) { $_setInt64(1, 2, v); }
  bool hasBytesFoundFromSource() => $_has(1, 2);
  void clearBytesFoundFromSource() => clearField(2);

  Int64 get objectsFoundOnlyFromSink => $_get(2, 3, null);
  void set objectsFoundOnlyFromSink(Int64 v) { $_setInt64(2, 3, v); }
  bool hasObjectsFoundOnlyFromSink() => $_has(2, 3);
  void clearObjectsFoundOnlyFromSink() => clearField(3);

  Int64 get bytesFoundOnlyFromSink => $_get(3, 4, null);
  void set bytesFoundOnlyFromSink(Int64 v) { $_setInt64(3, 4, v); }
  bool hasBytesFoundOnlyFromSink() => $_has(3, 4);
  void clearBytesFoundOnlyFromSink() => clearField(4);

  Int64 get objectsFromSourceSkippedBySync => $_get(4, 5, null);
  void set objectsFromSourceSkippedBySync(Int64 v) { $_setInt64(4, 5, v); }
  bool hasObjectsFromSourceSkippedBySync() => $_has(4, 5);
  void clearObjectsFromSourceSkippedBySync() => clearField(5);

  Int64 get bytesFromSourceSkippedBySync => $_get(5, 6, null);
  void set bytesFromSourceSkippedBySync(Int64 v) { $_setInt64(5, 6, v); }
  bool hasBytesFromSourceSkippedBySync() => $_has(5, 6);
  void clearBytesFromSourceSkippedBySync() => clearField(6);

  Int64 get objectsCopiedToSink => $_get(6, 7, null);
  void set objectsCopiedToSink(Int64 v) { $_setInt64(6, 7, v); }
  bool hasObjectsCopiedToSink() => $_has(6, 7);
  void clearObjectsCopiedToSink() => clearField(7);

  Int64 get bytesCopiedToSink => $_get(7, 8, null);
  void set bytesCopiedToSink(Int64 v) { $_setInt64(7, 8, v); }
  bool hasBytesCopiedToSink() => $_has(7, 8);
  void clearBytesCopiedToSink() => clearField(8);

  Int64 get objectsDeletedFromSource => $_get(8, 9, null);
  void set objectsDeletedFromSource(Int64 v) { $_setInt64(8, 9, v); }
  bool hasObjectsDeletedFromSource() => $_has(8, 9);
  void clearObjectsDeletedFromSource() => clearField(9);

  Int64 get bytesDeletedFromSource => $_get(9, 10, null);
  void set bytesDeletedFromSource(Int64 v) { $_setInt64(9, 10, v); }
  bool hasBytesDeletedFromSource() => $_has(9, 10);
  void clearBytesDeletedFromSource() => clearField(10);

  Int64 get objectsDeletedFromSink => $_get(10, 11, null);
  void set objectsDeletedFromSink(Int64 v) { $_setInt64(10, 11, v); }
  bool hasObjectsDeletedFromSink() => $_has(10, 11);
  void clearObjectsDeletedFromSink() => clearField(11);

  Int64 get bytesDeletedFromSink => $_get(11, 12, null);
  void set bytesDeletedFromSink(Int64 v) { $_setInt64(11, 12, v); }
  bool hasBytesDeletedFromSink() => $_has(11, 12);
  void clearBytesDeletedFromSink() => clearField(12);

  Int64 get objectsFromSourceFailed => $_get(12, 13, null);
  void set objectsFromSourceFailed(Int64 v) { $_setInt64(12, 13, v); }
  bool hasObjectsFromSourceFailed() => $_has(12, 13);
  void clearObjectsFromSourceFailed() => clearField(13);

  Int64 get bytesFromSourceFailed => $_get(13, 14, null);
  void set bytesFromSourceFailed(Int64 v) { $_setInt64(13, 14, v); }
  bool hasBytesFromSourceFailed() => $_has(13, 14);
  void clearBytesFromSourceFailed() => clearField(14);

  Int64 get objectsFailedToDeleteFromSink => $_get(14, 15, null);
  void set objectsFailedToDeleteFromSink(Int64 v) { $_setInt64(14, 15, v); }
  bool hasObjectsFailedToDeleteFromSink() => $_has(14, 15);
  void clearObjectsFailedToDeleteFromSink() => clearField(15);

  Int64 get bytesFailedToDeleteFromSink => $_get(15, 16, null);
  void set bytesFailedToDeleteFromSink(Int64 v) { $_setInt64(15, 16, v); }
  bool hasBytesFailedToDeleteFromSink() => $_has(15, 16);
  void clearBytesFailedToDeleteFromSink() => clearField(16);
}

class _ReadonlyTransferCounters extends TransferCounters with ReadonlyMessageMixin {}

class TransferOperation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TransferOperation')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'projectId', PbFieldType.OS)
    ..a/*<TransferSpec>*/(3, 'transferSpec', PbFieldType.OM, TransferSpec.getDefault, TransferSpec.create)
    ..a/*<google$protobuf.Timestamp>*/(4, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<TransferOperation_Status>*/(6, 'status', PbFieldType.OE, TransferOperation_Status.STATUS_UNSPECIFIED, TransferOperation_Status.valueOf)
    ..a/*<TransferCounters>*/(7, 'counters', PbFieldType.OM, TransferCounters.getDefault, TransferCounters.create)
    ..pp/*<ErrorSummary>*/(8, 'errorBreakdowns', PbFieldType.PM, ErrorSummary.$checkItem, ErrorSummary.create)
    ..a/*<String>*/(9, 'transferJobName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TransferOperation() : super();
  TransferOperation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TransferOperation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TransferOperation clone() => new TransferOperation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TransferOperation create() => new TransferOperation();
  static PbList<TransferOperation> createRepeated() => new PbList<TransferOperation>();
  static TransferOperation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTransferOperation();
    return _defaultInstance;
  }
  static TransferOperation _defaultInstance;
  static void $checkItem(TransferOperation v) {
    if (v is !TransferOperation) checkItemFailed(v, 'TransferOperation');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get projectId => $_get(1, 2, '');
  void set projectId(String v) { $_setString(1, 2, v); }
  bool hasProjectId() => $_has(1, 2);
  void clearProjectId() => clearField(2);

  TransferSpec get transferSpec => $_get(2, 3, null);
  void set transferSpec(TransferSpec v) { setField(3, v); }
  bool hasTransferSpec() => $_has(2, 3);
  void clearTransferSpec() => clearField(3);

  google$protobuf.Timestamp get startTime => $_get(3, 4, null);
  void set startTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasStartTime() => $_has(3, 4);
  void clearStartTime() => clearField(4);

  google$protobuf.Timestamp get endTime => $_get(4, 5, null);
  void set endTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasEndTime() => $_has(4, 5);
  void clearEndTime() => clearField(5);

  TransferOperation_Status get status => $_get(5, 6, null);
  void set status(TransferOperation_Status v) { setField(6, v); }
  bool hasStatus() => $_has(5, 6);
  void clearStatus() => clearField(6);

  TransferCounters get counters => $_get(6, 7, null);
  void set counters(TransferCounters v) { setField(7, v); }
  bool hasCounters() => $_has(6, 7);
  void clearCounters() => clearField(7);

  List<ErrorSummary> get errorBreakdowns => $_get(7, 8, null);

  String get transferJobName => $_get(8, 9, '');
  void set transferJobName(String v) { $_setString(8, 9, v); }
  bool hasTransferJobName() => $_has(8, 9);
  void clearTransferJobName() => clearField(9);
}

class _ReadonlyTransferOperation extends TransferOperation with ReadonlyMessageMixin {}

