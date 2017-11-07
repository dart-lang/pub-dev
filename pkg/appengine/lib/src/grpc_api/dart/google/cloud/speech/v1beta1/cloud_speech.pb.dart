///
//  Generated code. Do not modify.
///
library google.cloud.speech.v1beta1_cloud_speech;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../rpc/status.pb.dart' as google$rpc;
import '../../../longrunning/operations.pb.dart' as google$longrunning;

import 'cloud_speech.pbenum.dart';

export 'cloud_speech.pbenum.dart';

class SyncRecognizeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SyncRecognizeRequest')
    ..a/*<RecognitionConfig>*/(1, 'config', PbFieldType.OM, RecognitionConfig.getDefault, RecognitionConfig.create)
    ..a/*<RecognitionAudio>*/(2, 'audio', PbFieldType.OM, RecognitionAudio.getDefault, RecognitionAudio.create)
    ..hasRequiredFields = false
  ;

  SyncRecognizeRequest() : super();
  SyncRecognizeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SyncRecognizeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SyncRecognizeRequest clone() => new SyncRecognizeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SyncRecognizeRequest create() => new SyncRecognizeRequest();
  static PbList<SyncRecognizeRequest> createRepeated() => new PbList<SyncRecognizeRequest>();
  static SyncRecognizeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySyncRecognizeRequest();
    return _defaultInstance;
  }
  static SyncRecognizeRequest _defaultInstance;
  static void $checkItem(SyncRecognizeRequest v) {
    if (v is !SyncRecognizeRequest) checkItemFailed(v, 'SyncRecognizeRequest');
  }

  RecognitionConfig get config => $_get(0, 1, null);
  void set config(RecognitionConfig v) { setField(1, v); }
  bool hasConfig() => $_has(0, 1);
  void clearConfig() => clearField(1);

  RecognitionAudio get audio => $_get(1, 2, null);
  void set audio(RecognitionAudio v) { setField(2, v); }
  bool hasAudio() => $_has(1, 2);
  void clearAudio() => clearField(2);
}

class _ReadonlySyncRecognizeRequest extends SyncRecognizeRequest with ReadonlyMessageMixin {}

class AsyncRecognizeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AsyncRecognizeRequest')
    ..a/*<RecognitionConfig>*/(1, 'config', PbFieldType.OM, RecognitionConfig.getDefault, RecognitionConfig.create)
    ..a/*<RecognitionAudio>*/(2, 'audio', PbFieldType.OM, RecognitionAudio.getDefault, RecognitionAudio.create)
    ..hasRequiredFields = false
  ;

  AsyncRecognizeRequest() : super();
  AsyncRecognizeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AsyncRecognizeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AsyncRecognizeRequest clone() => new AsyncRecognizeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AsyncRecognizeRequest create() => new AsyncRecognizeRequest();
  static PbList<AsyncRecognizeRequest> createRepeated() => new PbList<AsyncRecognizeRequest>();
  static AsyncRecognizeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAsyncRecognizeRequest();
    return _defaultInstance;
  }
  static AsyncRecognizeRequest _defaultInstance;
  static void $checkItem(AsyncRecognizeRequest v) {
    if (v is !AsyncRecognizeRequest) checkItemFailed(v, 'AsyncRecognizeRequest');
  }

  RecognitionConfig get config => $_get(0, 1, null);
  void set config(RecognitionConfig v) { setField(1, v); }
  bool hasConfig() => $_has(0, 1);
  void clearConfig() => clearField(1);

  RecognitionAudio get audio => $_get(1, 2, null);
  void set audio(RecognitionAudio v) { setField(2, v); }
  bool hasAudio() => $_has(1, 2);
  void clearAudio() => clearField(2);
}

class _ReadonlyAsyncRecognizeRequest extends AsyncRecognizeRequest with ReadonlyMessageMixin {}

class StreamingRecognizeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingRecognizeRequest')
    ..a/*<StreamingRecognitionConfig>*/(1, 'streamingConfig', PbFieldType.OM, StreamingRecognitionConfig.getDefault, StreamingRecognitionConfig.create)
    ..a/*<List<int>>*/(2, 'audioContent', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  StreamingRecognizeRequest() : super();
  StreamingRecognizeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingRecognizeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingRecognizeRequest clone() => new StreamingRecognizeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingRecognizeRequest create() => new StreamingRecognizeRequest();
  static PbList<StreamingRecognizeRequest> createRepeated() => new PbList<StreamingRecognizeRequest>();
  static StreamingRecognizeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStreamingRecognizeRequest();
    return _defaultInstance;
  }
  static StreamingRecognizeRequest _defaultInstance;
  static void $checkItem(StreamingRecognizeRequest v) {
    if (v is !StreamingRecognizeRequest) checkItemFailed(v, 'StreamingRecognizeRequest');
  }

  StreamingRecognitionConfig get streamingConfig => $_get(0, 1, null);
  void set streamingConfig(StreamingRecognitionConfig v) { setField(1, v); }
  bool hasStreamingConfig() => $_has(0, 1);
  void clearStreamingConfig() => clearField(1);

  List<int> get audioContent => $_get(1, 2, null);
  void set audioContent(List<int> v) { $_setBytes(1, 2, v); }
  bool hasAudioContent() => $_has(1, 2);
  void clearAudioContent() => clearField(2);
}

class _ReadonlyStreamingRecognizeRequest extends StreamingRecognizeRequest with ReadonlyMessageMixin {}

class StreamingRecognitionConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingRecognitionConfig')
    ..a/*<RecognitionConfig>*/(1, 'config', PbFieldType.OM, RecognitionConfig.getDefault, RecognitionConfig.create)
    ..a/*<bool>*/(2, 'singleUtterance', PbFieldType.OB)
    ..a/*<bool>*/(3, 'interimResults', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  StreamingRecognitionConfig() : super();
  StreamingRecognitionConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingRecognitionConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingRecognitionConfig clone() => new StreamingRecognitionConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingRecognitionConfig create() => new StreamingRecognitionConfig();
  static PbList<StreamingRecognitionConfig> createRepeated() => new PbList<StreamingRecognitionConfig>();
  static StreamingRecognitionConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStreamingRecognitionConfig();
    return _defaultInstance;
  }
  static StreamingRecognitionConfig _defaultInstance;
  static void $checkItem(StreamingRecognitionConfig v) {
    if (v is !StreamingRecognitionConfig) checkItemFailed(v, 'StreamingRecognitionConfig');
  }

  RecognitionConfig get config => $_get(0, 1, null);
  void set config(RecognitionConfig v) { setField(1, v); }
  bool hasConfig() => $_has(0, 1);
  void clearConfig() => clearField(1);

  bool get singleUtterance => $_get(1, 2, false);
  void set singleUtterance(bool v) { $_setBool(1, 2, v); }
  bool hasSingleUtterance() => $_has(1, 2);
  void clearSingleUtterance() => clearField(2);

  bool get interimResults => $_get(2, 3, false);
  void set interimResults(bool v) { $_setBool(2, 3, v); }
  bool hasInterimResults() => $_has(2, 3);
  void clearInterimResults() => clearField(3);
}

class _ReadonlyStreamingRecognitionConfig extends StreamingRecognitionConfig with ReadonlyMessageMixin {}

class RecognitionConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RecognitionConfig')
    ..e/*<RecognitionConfig_AudioEncoding>*/(1, 'encoding', PbFieldType.OE, RecognitionConfig_AudioEncoding.ENCODING_UNSPECIFIED, RecognitionConfig_AudioEncoding.valueOf)
    ..a/*<int>*/(2, 'sampleRate', PbFieldType.O3)
    ..a/*<String>*/(3, 'languageCode', PbFieldType.OS)
    ..a/*<int>*/(4, 'maxAlternatives', PbFieldType.O3)
    ..a/*<bool>*/(5, 'profanityFilter', PbFieldType.OB)
    ..a/*<SpeechContext>*/(6, 'speechContext', PbFieldType.OM, SpeechContext.getDefault, SpeechContext.create)
    ..hasRequiredFields = false
  ;

  RecognitionConfig() : super();
  RecognitionConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RecognitionConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RecognitionConfig clone() => new RecognitionConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RecognitionConfig create() => new RecognitionConfig();
  static PbList<RecognitionConfig> createRepeated() => new PbList<RecognitionConfig>();
  static RecognitionConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRecognitionConfig();
    return _defaultInstance;
  }
  static RecognitionConfig _defaultInstance;
  static void $checkItem(RecognitionConfig v) {
    if (v is !RecognitionConfig) checkItemFailed(v, 'RecognitionConfig');
  }

  RecognitionConfig_AudioEncoding get encoding => $_get(0, 1, null);
  void set encoding(RecognitionConfig_AudioEncoding v) { setField(1, v); }
  bool hasEncoding() => $_has(0, 1);
  void clearEncoding() => clearField(1);

  int get sampleRate => $_get(1, 2, 0);
  void set sampleRate(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasSampleRate() => $_has(1, 2);
  void clearSampleRate() => clearField(2);

  String get languageCode => $_get(2, 3, '');
  void set languageCode(String v) { $_setString(2, 3, v); }
  bool hasLanguageCode() => $_has(2, 3);
  void clearLanguageCode() => clearField(3);

  int get maxAlternatives => $_get(3, 4, 0);
  void set maxAlternatives(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasMaxAlternatives() => $_has(3, 4);
  void clearMaxAlternatives() => clearField(4);

  bool get profanityFilter => $_get(4, 5, false);
  void set profanityFilter(bool v) { $_setBool(4, 5, v); }
  bool hasProfanityFilter() => $_has(4, 5);
  void clearProfanityFilter() => clearField(5);

  SpeechContext get speechContext => $_get(5, 6, null);
  void set speechContext(SpeechContext v) { setField(6, v); }
  bool hasSpeechContext() => $_has(5, 6);
  void clearSpeechContext() => clearField(6);
}

class _ReadonlyRecognitionConfig extends RecognitionConfig with ReadonlyMessageMixin {}

class SpeechContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SpeechContext')
    ..p/*<String>*/(1, 'phrases', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  SpeechContext() : super();
  SpeechContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SpeechContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SpeechContext clone() => new SpeechContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SpeechContext create() => new SpeechContext();
  static PbList<SpeechContext> createRepeated() => new PbList<SpeechContext>();
  static SpeechContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpeechContext();
    return _defaultInstance;
  }
  static SpeechContext _defaultInstance;
  static void $checkItem(SpeechContext v) {
    if (v is !SpeechContext) checkItemFailed(v, 'SpeechContext');
  }

  List<String> get phrases => $_get(0, 1, null);
}

class _ReadonlySpeechContext extends SpeechContext with ReadonlyMessageMixin {}

class RecognitionAudio extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RecognitionAudio')
    ..a/*<List<int>>*/(1, 'content', PbFieldType.OY)
    ..a/*<String>*/(2, 'uri', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RecognitionAudio() : super();
  RecognitionAudio.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RecognitionAudio.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RecognitionAudio clone() => new RecognitionAudio()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RecognitionAudio create() => new RecognitionAudio();
  static PbList<RecognitionAudio> createRepeated() => new PbList<RecognitionAudio>();
  static RecognitionAudio getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRecognitionAudio();
    return _defaultInstance;
  }
  static RecognitionAudio _defaultInstance;
  static void $checkItem(RecognitionAudio v) {
    if (v is !RecognitionAudio) checkItemFailed(v, 'RecognitionAudio');
  }

  List<int> get content => $_get(0, 1, null);
  void set content(List<int> v) { $_setBytes(0, 1, v); }
  bool hasContent() => $_has(0, 1);
  void clearContent() => clearField(1);

  String get uri => $_get(1, 2, '');
  void set uri(String v) { $_setString(1, 2, v); }
  bool hasUri() => $_has(1, 2);
  void clearUri() => clearField(2);
}

class _ReadonlyRecognitionAudio extends RecognitionAudio with ReadonlyMessageMixin {}

class SyncRecognizeResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SyncRecognizeResponse')
    ..pp/*<SpeechRecognitionResult>*/(2, 'results', PbFieldType.PM, SpeechRecognitionResult.$checkItem, SpeechRecognitionResult.create)
    ..hasRequiredFields = false
  ;

  SyncRecognizeResponse() : super();
  SyncRecognizeResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SyncRecognizeResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SyncRecognizeResponse clone() => new SyncRecognizeResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SyncRecognizeResponse create() => new SyncRecognizeResponse();
  static PbList<SyncRecognizeResponse> createRepeated() => new PbList<SyncRecognizeResponse>();
  static SyncRecognizeResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySyncRecognizeResponse();
    return _defaultInstance;
  }
  static SyncRecognizeResponse _defaultInstance;
  static void $checkItem(SyncRecognizeResponse v) {
    if (v is !SyncRecognizeResponse) checkItemFailed(v, 'SyncRecognizeResponse');
  }

  List<SpeechRecognitionResult> get results => $_get(0, 2, null);
}

class _ReadonlySyncRecognizeResponse extends SyncRecognizeResponse with ReadonlyMessageMixin {}

class AsyncRecognizeResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AsyncRecognizeResponse')
    ..pp/*<SpeechRecognitionResult>*/(2, 'results', PbFieldType.PM, SpeechRecognitionResult.$checkItem, SpeechRecognitionResult.create)
    ..hasRequiredFields = false
  ;

  AsyncRecognizeResponse() : super();
  AsyncRecognizeResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AsyncRecognizeResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AsyncRecognizeResponse clone() => new AsyncRecognizeResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AsyncRecognizeResponse create() => new AsyncRecognizeResponse();
  static PbList<AsyncRecognizeResponse> createRepeated() => new PbList<AsyncRecognizeResponse>();
  static AsyncRecognizeResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAsyncRecognizeResponse();
    return _defaultInstance;
  }
  static AsyncRecognizeResponse _defaultInstance;
  static void $checkItem(AsyncRecognizeResponse v) {
    if (v is !AsyncRecognizeResponse) checkItemFailed(v, 'AsyncRecognizeResponse');
  }

  List<SpeechRecognitionResult> get results => $_get(0, 2, null);
}

class _ReadonlyAsyncRecognizeResponse extends AsyncRecognizeResponse with ReadonlyMessageMixin {}

class AsyncRecognizeMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AsyncRecognizeMetadata')
    ..a/*<int>*/(1, 'progressPercent', PbFieldType.O3)
    ..a/*<google$protobuf.Timestamp>*/(2, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'lastUpdateTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  AsyncRecognizeMetadata() : super();
  AsyncRecognizeMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AsyncRecognizeMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AsyncRecognizeMetadata clone() => new AsyncRecognizeMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AsyncRecognizeMetadata create() => new AsyncRecognizeMetadata();
  static PbList<AsyncRecognizeMetadata> createRepeated() => new PbList<AsyncRecognizeMetadata>();
  static AsyncRecognizeMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAsyncRecognizeMetadata();
    return _defaultInstance;
  }
  static AsyncRecognizeMetadata _defaultInstance;
  static void $checkItem(AsyncRecognizeMetadata v) {
    if (v is !AsyncRecognizeMetadata) checkItemFailed(v, 'AsyncRecognizeMetadata');
  }

  int get progressPercent => $_get(0, 1, 0);
  void set progressPercent(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasProgressPercent() => $_has(0, 1);
  void clearProgressPercent() => clearField(1);

  google$protobuf.Timestamp get startTime => $_get(1, 2, null);
  void set startTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasStartTime() => $_has(1, 2);
  void clearStartTime() => clearField(2);

  google$protobuf.Timestamp get lastUpdateTime => $_get(2, 3, null);
  void set lastUpdateTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasLastUpdateTime() => $_has(2, 3);
  void clearLastUpdateTime() => clearField(3);
}

class _ReadonlyAsyncRecognizeMetadata extends AsyncRecognizeMetadata with ReadonlyMessageMixin {}

class StreamingRecognizeResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingRecognizeResponse')
    ..a/*<google$rpc.Status>*/(1, 'error', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..pp/*<StreamingRecognitionResult>*/(2, 'results', PbFieldType.PM, StreamingRecognitionResult.$checkItem, StreamingRecognitionResult.create)
    ..a/*<int>*/(3, 'resultIndex', PbFieldType.O3)
    ..e/*<StreamingRecognizeResponse_EndpointerType>*/(4, 'endpointerType', PbFieldType.OE, StreamingRecognizeResponse_EndpointerType.ENDPOINTER_EVENT_UNSPECIFIED, StreamingRecognizeResponse_EndpointerType.valueOf)
    ..hasRequiredFields = false
  ;

  StreamingRecognizeResponse() : super();
  StreamingRecognizeResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingRecognizeResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingRecognizeResponse clone() => new StreamingRecognizeResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingRecognizeResponse create() => new StreamingRecognizeResponse();
  static PbList<StreamingRecognizeResponse> createRepeated() => new PbList<StreamingRecognizeResponse>();
  static StreamingRecognizeResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStreamingRecognizeResponse();
    return _defaultInstance;
  }
  static StreamingRecognizeResponse _defaultInstance;
  static void $checkItem(StreamingRecognizeResponse v) {
    if (v is !StreamingRecognizeResponse) checkItemFailed(v, 'StreamingRecognizeResponse');
  }

  google$rpc.Status get error => $_get(0, 1, null);
  void set error(google$rpc.Status v) { setField(1, v); }
  bool hasError() => $_has(0, 1);
  void clearError() => clearField(1);

  List<StreamingRecognitionResult> get results => $_get(1, 2, null);

  int get resultIndex => $_get(2, 3, 0);
  void set resultIndex(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasResultIndex() => $_has(2, 3);
  void clearResultIndex() => clearField(3);

  StreamingRecognizeResponse_EndpointerType get endpointerType => $_get(3, 4, null);
  void set endpointerType(StreamingRecognizeResponse_EndpointerType v) { setField(4, v); }
  bool hasEndpointerType() => $_has(3, 4);
  void clearEndpointerType() => clearField(4);
}

class _ReadonlyStreamingRecognizeResponse extends StreamingRecognizeResponse with ReadonlyMessageMixin {}

class StreamingRecognitionResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingRecognitionResult')
    ..pp/*<SpeechRecognitionAlternative>*/(1, 'alternatives', PbFieldType.PM, SpeechRecognitionAlternative.$checkItem, SpeechRecognitionAlternative.create)
    ..a/*<bool>*/(2, 'isFinal', PbFieldType.OB)
    ..a/*<double>*/(3, 'stability', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  StreamingRecognitionResult() : super();
  StreamingRecognitionResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingRecognitionResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingRecognitionResult clone() => new StreamingRecognitionResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingRecognitionResult create() => new StreamingRecognitionResult();
  static PbList<StreamingRecognitionResult> createRepeated() => new PbList<StreamingRecognitionResult>();
  static StreamingRecognitionResult getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStreamingRecognitionResult();
    return _defaultInstance;
  }
  static StreamingRecognitionResult _defaultInstance;
  static void $checkItem(StreamingRecognitionResult v) {
    if (v is !StreamingRecognitionResult) checkItemFailed(v, 'StreamingRecognitionResult');
  }

  List<SpeechRecognitionAlternative> get alternatives => $_get(0, 1, null);

  bool get isFinal => $_get(1, 2, false);
  void set isFinal(bool v) { $_setBool(1, 2, v); }
  bool hasIsFinal() => $_has(1, 2);
  void clearIsFinal() => clearField(2);

  double get stability => $_get(2, 3, null);
  void set stability(double v) { $_setFloat(2, 3, v); }
  bool hasStability() => $_has(2, 3);
  void clearStability() => clearField(3);
}

class _ReadonlyStreamingRecognitionResult extends StreamingRecognitionResult with ReadonlyMessageMixin {}

class SpeechRecognitionResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SpeechRecognitionResult')
    ..pp/*<SpeechRecognitionAlternative>*/(1, 'alternatives', PbFieldType.PM, SpeechRecognitionAlternative.$checkItem, SpeechRecognitionAlternative.create)
    ..hasRequiredFields = false
  ;

  SpeechRecognitionResult() : super();
  SpeechRecognitionResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SpeechRecognitionResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SpeechRecognitionResult clone() => new SpeechRecognitionResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SpeechRecognitionResult create() => new SpeechRecognitionResult();
  static PbList<SpeechRecognitionResult> createRepeated() => new PbList<SpeechRecognitionResult>();
  static SpeechRecognitionResult getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpeechRecognitionResult();
    return _defaultInstance;
  }
  static SpeechRecognitionResult _defaultInstance;
  static void $checkItem(SpeechRecognitionResult v) {
    if (v is !SpeechRecognitionResult) checkItemFailed(v, 'SpeechRecognitionResult');
  }

  List<SpeechRecognitionAlternative> get alternatives => $_get(0, 1, null);
}

class _ReadonlySpeechRecognitionResult extends SpeechRecognitionResult with ReadonlyMessageMixin {}

class SpeechRecognitionAlternative extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SpeechRecognitionAlternative')
    ..a/*<String>*/(1, 'transcript', PbFieldType.OS)
    ..a/*<double>*/(2, 'confidence', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  SpeechRecognitionAlternative() : super();
  SpeechRecognitionAlternative.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SpeechRecognitionAlternative.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SpeechRecognitionAlternative clone() => new SpeechRecognitionAlternative()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SpeechRecognitionAlternative create() => new SpeechRecognitionAlternative();
  static PbList<SpeechRecognitionAlternative> createRepeated() => new PbList<SpeechRecognitionAlternative>();
  static SpeechRecognitionAlternative getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySpeechRecognitionAlternative();
    return _defaultInstance;
  }
  static SpeechRecognitionAlternative _defaultInstance;
  static void $checkItem(SpeechRecognitionAlternative v) {
    if (v is !SpeechRecognitionAlternative) checkItemFailed(v, 'SpeechRecognitionAlternative');
  }

  String get transcript => $_get(0, 1, '');
  void set transcript(String v) { $_setString(0, 1, v); }
  bool hasTranscript() => $_has(0, 1);
  void clearTranscript() => clearField(1);

  double get confidence => $_get(1, 2, null);
  void set confidence(double v) { $_setFloat(1, 2, v); }
  bool hasConfidence() => $_has(1, 2);
  void clearConfidence() => clearField(2);
}

class _ReadonlySpeechRecognitionAlternative extends SpeechRecognitionAlternative with ReadonlyMessageMixin {}

class SpeechApi {
  RpcClient _client;
  SpeechApi(this._client);

  Future<SyncRecognizeResponse> syncRecognize(ClientContext ctx, SyncRecognizeRequest request) {
    var emptyResponse = new SyncRecognizeResponse();
    return _client.invoke(ctx, 'Speech', 'SyncRecognize', request, emptyResponse);
  }
  Future<google$longrunning.Operation> asyncRecognize(ClientContext ctx, AsyncRecognizeRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'Speech', 'AsyncRecognize', request, emptyResponse);
  }
  Future<StreamingRecognizeResponse> streamingRecognize(ClientContext ctx, StreamingRecognizeRequest request) {
    var emptyResponse = new StreamingRecognizeResponse();
    return _client.invoke(ctx, 'Speech', 'StreamingRecognize', request, emptyResponse);
  }
}

