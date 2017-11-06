///
//  Generated code. Do not modify.
///
library google.pubsub.v1beta2_pubsub;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../protobuf/empty.pb.dart' as google$protobuf;

class Topic extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Topic')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Topic() : super();
  Topic.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Topic.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Topic clone() => new Topic()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Topic create() => new Topic();
  static PbList<Topic> createRepeated() => new PbList<Topic>();
  static Topic getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTopic();
    return _defaultInstance;
  }
  static Topic _defaultInstance;
  static void $checkItem(Topic v) {
    if (v is !Topic) checkItemFailed(v, 'Topic');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyTopic extends Topic with ReadonlyMessageMixin {}

class PubsubMessage_AttributesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PubsubMessage_AttributesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PubsubMessage_AttributesEntry() : super();
  PubsubMessage_AttributesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PubsubMessage_AttributesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PubsubMessage_AttributesEntry clone() => new PubsubMessage_AttributesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PubsubMessage_AttributesEntry create() => new PubsubMessage_AttributesEntry();
  static PbList<PubsubMessage_AttributesEntry> createRepeated() => new PbList<PubsubMessage_AttributesEntry>();
  static PubsubMessage_AttributesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPubsubMessage_AttributesEntry();
    return _defaultInstance;
  }
  static PubsubMessage_AttributesEntry _defaultInstance;
  static void $checkItem(PubsubMessage_AttributesEntry v) {
    if (v is !PubsubMessage_AttributesEntry) checkItemFailed(v, 'PubsubMessage_AttributesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyPubsubMessage_AttributesEntry extends PubsubMessage_AttributesEntry with ReadonlyMessageMixin {}

class PubsubMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PubsubMessage')
    ..a/*<List<int>>*/(1, 'data', PbFieldType.OY)
    ..pp/*<PubsubMessage_AttributesEntry>*/(2, 'attributes', PbFieldType.PM, PubsubMessage_AttributesEntry.$checkItem, PubsubMessage_AttributesEntry.create)
    ..a/*<String>*/(3, 'messageId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PubsubMessage() : super();
  PubsubMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PubsubMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PubsubMessage clone() => new PubsubMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PubsubMessage create() => new PubsubMessage();
  static PbList<PubsubMessage> createRepeated() => new PbList<PubsubMessage>();
  static PubsubMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPubsubMessage();
    return _defaultInstance;
  }
  static PubsubMessage _defaultInstance;
  static void $checkItem(PubsubMessage v) {
    if (v is !PubsubMessage) checkItemFailed(v, 'PubsubMessage');
  }

  List<int> get data => $_get(0, 1, null);
  void set data(List<int> v) { $_setBytes(0, 1, v); }
  bool hasData() => $_has(0, 1);
  void clearData() => clearField(1);

  List<PubsubMessage_AttributesEntry> get attributes => $_get(1, 2, null);

  String get messageId => $_get(2, 3, '');
  void set messageId(String v) { $_setString(2, 3, v); }
  bool hasMessageId() => $_has(2, 3);
  void clearMessageId() => clearField(3);
}

class _ReadonlyPubsubMessage extends PubsubMessage with ReadonlyMessageMixin {}

class GetTopicRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetTopicRequest')
    ..a/*<String>*/(1, 'topic', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetTopicRequest() : super();
  GetTopicRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetTopicRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetTopicRequest clone() => new GetTopicRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetTopicRequest create() => new GetTopicRequest();
  static PbList<GetTopicRequest> createRepeated() => new PbList<GetTopicRequest>();
  static GetTopicRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetTopicRequest();
    return _defaultInstance;
  }
  static GetTopicRequest _defaultInstance;
  static void $checkItem(GetTopicRequest v) {
    if (v is !GetTopicRequest) checkItemFailed(v, 'GetTopicRequest');
  }

  String get topic => $_get(0, 1, '');
  void set topic(String v) { $_setString(0, 1, v); }
  bool hasTopic() => $_has(0, 1);
  void clearTopic() => clearField(1);
}

class _ReadonlyGetTopicRequest extends GetTopicRequest with ReadonlyMessageMixin {}

class PublishRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PublishRequest')
    ..a/*<String>*/(1, 'topic', PbFieldType.OS)
    ..pp/*<PubsubMessage>*/(2, 'messages', PbFieldType.PM, PubsubMessage.$checkItem, PubsubMessage.create)
    ..hasRequiredFields = false
  ;

  PublishRequest() : super();
  PublishRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PublishRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PublishRequest clone() => new PublishRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PublishRequest create() => new PublishRequest();
  static PbList<PublishRequest> createRepeated() => new PbList<PublishRequest>();
  static PublishRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPublishRequest();
    return _defaultInstance;
  }
  static PublishRequest _defaultInstance;
  static void $checkItem(PublishRequest v) {
    if (v is !PublishRequest) checkItemFailed(v, 'PublishRequest');
  }

  String get topic => $_get(0, 1, '');
  void set topic(String v) { $_setString(0, 1, v); }
  bool hasTopic() => $_has(0, 1);
  void clearTopic() => clearField(1);

  List<PubsubMessage> get messages => $_get(1, 2, null);
}

class _ReadonlyPublishRequest extends PublishRequest with ReadonlyMessageMixin {}

class PublishResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PublishResponse')
    ..p/*<String>*/(1, 'messageIds', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  PublishResponse() : super();
  PublishResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PublishResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PublishResponse clone() => new PublishResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PublishResponse create() => new PublishResponse();
  static PbList<PublishResponse> createRepeated() => new PbList<PublishResponse>();
  static PublishResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPublishResponse();
    return _defaultInstance;
  }
  static PublishResponse _defaultInstance;
  static void $checkItem(PublishResponse v) {
    if (v is !PublishResponse) checkItemFailed(v, 'PublishResponse');
  }

  List<String> get messageIds => $_get(0, 1, null);
}

class _ReadonlyPublishResponse extends PublishResponse with ReadonlyMessageMixin {}

class ListTopicsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTopicsRequest')
    ..a/*<String>*/(1, 'project', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTopicsRequest() : super();
  ListTopicsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTopicsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTopicsRequest clone() => new ListTopicsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTopicsRequest create() => new ListTopicsRequest();
  static PbList<ListTopicsRequest> createRepeated() => new PbList<ListTopicsRequest>();
  static ListTopicsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTopicsRequest();
    return _defaultInstance;
  }
  static ListTopicsRequest _defaultInstance;
  static void $checkItem(ListTopicsRequest v) {
    if (v is !ListTopicsRequest) checkItemFailed(v, 'ListTopicsRequest');
  }

  String get project => $_get(0, 1, '');
  void set project(String v) { $_setString(0, 1, v); }
  bool hasProject() => $_has(0, 1);
  void clearProject() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListTopicsRequest extends ListTopicsRequest with ReadonlyMessageMixin {}

class ListTopicsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTopicsResponse')
    ..pp/*<Topic>*/(1, 'topics', PbFieldType.PM, Topic.$checkItem, Topic.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTopicsResponse() : super();
  ListTopicsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTopicsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTopicsResponse clone() => new ListTopicsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTopicsResponse create() => new ListTopicsResponse();
  static PbList<ListTopicsResponse> createRepeated() => new PbList<ListTopicsResponse>();
  static ListTopicsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTopicsResponse();
    return _defaultInstance;
  }
  static ListTopicsResponse _defaultInstance;
  static void $checkItem(ListTopicsResponse v) {
    if (v is !ListTopicsResponse) checkItemFailed(v, 'ListTopicsResponse');
  }

  List<Topic> get topics => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTopicsResponse extends ListTopicsResponse with ReadonlyMessageMixin {}

class ListTopicSubscriptionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTopicSubscriptionsRequest')
    ..a/*<String>*/(1, 'topic', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTopicSubscriptionsRequest() : super();
  ListTopicSubscriptionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTopicSubscriptionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTopicSubscriptionsRequest clone() => new ListTopicSubscriptionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTopicSubscriptionsRequest create() => new ListTopicSubscriptionsRequest();
  static PbList<ListTopicSubscriptionsRequest> createRepeated() => new PbList<ListTopicSubscriptionsRequest>();
  static ListTopicSubscriptionsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTopicSubscriptionsRequest();
    return _defaultInstance;
  }
  static ListTopicSubscriptionsRequest _defaultInstance;
  static void $checkItem(ListTopicSubscriptionsRequest v) {
    if (v is !ListTopicSubscriptionsRequest) checkItemFailed(v, 'ListTopicSubscriptionsRequest');
  }

  String get topic => $_get(0, 1, '');
  void set topic(String v) { $_setString(0, 1, v); }
  bool hasTopic() => $_has(0, 1);
  void clearTopic() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListTopicSubscriptionsRequest extends ListTopicSubscriptionsRequest with ReadonlyMessageMixin {}

class ListTopicSubscriptionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTopicSubscriptionsResponse')
    ..p/*<String>*/(1, 'subscriptions', PbFieldType.PS)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTopicSubscriptionsResponse() : super();
  ListTopicSubscriptionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTopicSubscriptionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTopicSubscriptionsResponse clone() => new ListTopicSubscriptionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTopicSubscriptionsResponse create() => new ListTopicSubscriptionsResponse();
  static PbList<ListTopicSubscriptionsResponse> createRepeated() => new PbList<ListTopicSubscriptionsResponse>();
  static ListTopicSubscriptionsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTopicSubscriptionsResponse();
    return _defaultInstance;
  }
  static ListTopicSubscriptionsResponse _defaultInstance;
  static void $checkItem(ListTopicSubscriptionsResponse v) {
    if (v is !ListTopicSubscriptionsResponse) checkItemFailed(v, 'ListTopicSubscriptionsResponse');
  }

  List<String> get subscriptions => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTopicSubscriptionsResponse extends ListTopicSubscriptionsResponse with ReadonlyMessageMixin {}

class DeleteTopicRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteTopicRequest')
    ..a/*<String>*/(1, 'topic', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteTopicRequest() : super();
  DeleteTopicRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteTopicRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteTopicRequest clone() => new DeleteTopicRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteTopicRequest create() => new DeleteTopicRequest();
  static PbList<DeleteTopicRequest> createRepeated() => new PbList<DeleteTopicRequest>();
  static DeleteTopicRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteTopicRequest();
    return _defaultInstance;
  }
  static DeleteTopicRequest _defaultInstance;
  static void $checkItem(DeleteTopicRequest v) {
    if (v is !DeleteTopicRequest) checkItemFailed(v, 'DeleteTopicRequest');
  }

  String get topic => $_get(0, 1, '');
  void set topic(String v) { $_setString(0, 1, v); }
  bool hasTopic() => $_has(0, 1);
  void clearTopic() => clearField(1);
}

class _ReadonlyDeleteTopicRequest extends DeleteTopicRequest with ReadonlyMessageMixin {}

class Subscription extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Subscription')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'topic', PbFieldType.OS)
    ..a/*<PushConfig>*/(4, 'pushConfig', PbFieldType.OM, PushConfig.getDefault, PushConfig.create)
    ..a/*<int>*/(5, 'ackDeadlineSeconds', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Subscription() : super();
  Subscription.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Subscription.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Subscription clone() => new Subscription()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Subscription create() => new Subscription();
  static PbList<Subscription> createRepeated() => new PbList<Subscription>();
  static Subscription getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySubscription();
    return _defaultInstance;
  }
  static Subscription _defaultInstance;
  static void $checkItem(Subscription v) {
    if (v is !Subscription) checkItemFailed(v, 'Subscription');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get topic => $_get(1, 2, '');
  void set topic(String v) { $_setString(1, 2, v); }
  bool hasTopic() => $_has(1, 2);
  void clearTopic() => clearField(2);

  PushConfig get pushConfig => $_get(2, 4, null);
  void set pushConfig(PushConfig v) { setField(4, v); }
  bool hasPushConfig() => $_has(2, 4);
  void clearPushConfig() => clearField(4);

  int get ackDeadlineSeconds => $_get(3, 5, 0);
  void set ackDeadlineSeconds(int v) { $_setUnsignedInt32(3, 5, v); }
  bool hasAckDeadlineSeconds() => $_has(3, 5);
  void clearAckDeadlineSeconds() => clearField(5);
}

class _ReadonlySubscription extends Subscription with ReadonlyMessageMixin {}

class PushConfig_AttributesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PushConfig_AttributesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PushConfig_AttributesEntry() : super();
  PushConfig_AttributesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PushConfig_AttributesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PushConfig_AttributesEntry clone() => new PushConfig_AttributesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PushConfig_AttributesEntry create() => new PushConfig_AttributesEntry();
  static PbList<PushConfig_AttributesEntry> createRepeated() => new PbList<PushConfig_AttributesEntry>();
  static PushConfig_AttributesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPushConfig_AttributesEntry();
    return _defaultInstance;
  }
  static PushConfig_AttributesEntry _defaultInstance;
  static void $checkItem(PushConfig_AttributesEntry v) {
    if (v is !PushConfig_AttributesEntry) checkItemFailed(v, 'PushConfig_AttributesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyPushConfig_AttributesEntry extends PushConfig_AttributesEntry with ReadonlyMessageMixin {}

class PushConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PushConfig')
    ..a/*<String>*/(1, 'pushEndpoint', PbFieldType.OS)
    ..pp/*<PushConfig_AttributesEntry>*/(2, 'attributes', PbFieldType.PM, PushConfig_AttributesEntry.$checkItem, PushConfig_AttributesEntry.create)
    ..hasRequiredFields = false
  ;

  PushConfig() : super();
  PushConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PushConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PushConfig clone() => new PushConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PushConfig create() => new PushConfig();
  static PbList<PushConfig> createRepeated() => new PbList<PushConfig>();
  static PushConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPushConfig();
    return _defaultInstance;
  }
  static PushConfig _defaultInstance;
  static void $checkItem(PushConfig v) {
    if (v is !PushConfig) checkItemFailed(v, 'PushConfig');
  }

  String get pushEndpoint => $_get(0, 1, '');
  void set pushEndpoint(String v) { $_setString(0, 1, v); }
  bool hasPushEndpoint() => $_has(0, 1);
  void clearPushEndpoint() => clearField(1);

  List<PushConfig_AttributesEntry> get attributes => $_get(1, 2, null);
}

class _ReadonlyPushConfig extends PushConfig with ReadonlyMessageMixin {}

class ReceivedMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReceivedMessage')
    ..a/*<String>*/(1, 'ackId', PbFieldType.OS)
    ..a/*<PubsubMessage>*/(2, 'message', PbFieldType.OM, PubsubMessage.getDefault, PubsubMessage.create)
    ..hasRequiredFields = false
  ;

  ReceivedMessage() : super();
  ReceivedMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReceivedMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReceivedMessage clone() => new ReceivedMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReceivedMessage create() => new ReceivedMessage();
  static PbList<ReceivedMessage> createRepeated() => new PbList<ReceivedMessage>();
  static ReceivedMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReceivedMessage();
    return _defaultInstance;
  }
  static ReceivedMessage _defaultInstance;
  static void $checkItem(ReceivedMessage v) {
    if (v is !ReceivedMessage) checkItemFailed(v, 'ReceivedMessage');
  }

  String get ackId => $_get(0, 1, '');
  void set ackId(String v) { $_setString(0, 1, v); }
  bool hasAckId() => $_has(0, 1);
  void clearAckId() => clearField(1);

  PubsubMessage get message => $_get(1, 2, null);
  void set message(PubsubMessage v) { setField(2, v); }
  bool hasMessage() => $_has(1, 2);
  void clearMessage() => clearField(2);
}

class _ReadonlyReceivedMessage extends ReceivedMessage with ReadonlyMessageMixin {}

class GetSubscriptionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetSubscriptionRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetSubscriptionRequest() : super();
  GetSubscriptionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetSubscriptionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetSubscriptionRequest clone() => new GetSubscriptionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetSubscriptionRequest create() => new GetSubscriptionRequest();
  static PbList<GetSubscriptionRequest> createRepeated() => new PbList<GetSubscriptionRequest>();
  static GetSubscriptionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetSubscriptionRequest();
    return _defaultInstance;
  }
  static GetSubscriptionRequest _defaultInstance;
  static void $checkItem(GetSubscriptionRequest v) {
    if (v is !GetSubscriptionRequest) checkItemFailed(v, 'GetSubscriptionRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);
}

class _ReadonlyGetSubscriptionRequest extends GetSubscriptionRequest with ReadonlyMessageMixin {}

class ListSubscriptionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListSubscriptionsRequest')
    ..a/*<String>*/(1, 'project', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListSubscriptionsRequest() : super();
  ListSubscriptionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListSubscriptionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListSubscriptionsRequest clone() => new ListSubscriptionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListSubscriptionsRequest create() => new ListSubscriptionsRequest();
  static PbList<ListSubscriptionsRequest> createRepeated() => new PbList<ListSubscriptionsRequest>();
  static ListSubscriptionsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListSubscriptionsRequest();
    return _defaultInstance;
  }
  static ListSubscriptionsRequest _defaultInstance;
  static void $checkItem(ListSubscriptionsRequest v) {
    if (v is !ListSubscriptionsRequest) checkItemFailed(v, 'ListSubscriptionsRequest');
  }

  String get project => $_get(0, 1, '');
  void set project(String v) { $_setString(0, 1, v); }
  bool hasProject() => $_has(0, 1);
  void clearProject() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListSubscriptionsRequest extends ListSubscriptionsRequest with ReadonlyMessageMixin {}

class ListSubscriptionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListSubscriptionsResponse')
    ..pp/*<Subscription>*/(1, 'subscriptions', PbFieldType.PM, Subscription.$checkItem, Subscription.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListSubscriptionsResponse() : super();
  ListSubscriptionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListSubscriptionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListSubscriptionsResponse clone() => new ListSubscriptionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListSubscriptionsResponse create() => new ListSubscriptionsResponse();
  static PbList<ListSubscriptionsResponse> createRepeated() => new PbList<ListSubscriptionsResponse>();
  static ListSubscriptionsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListSubscriptionsResponse();
    return _defaultInstance;
  }
  static ListSubscriptionsResponse _defaultInstance;
  static void $checkItem(ListSubscriptionsResponse v) {
    if (v is !ListSubscriptionsResponse) checkItemFailed(v, 'ListSubscriptionsResponse');
  }

  List<Subscription> get subscriptions => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListSubscriptionsResponse extends ListSubscriptionsResponse with ReadonlyMessageMixin {}

class DeleteSubscriptionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteSubscriptionRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteSubscriptionRequest() : super();
  DeleteSubscriptionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteSubscriptionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteSubscriptionRequest clone() => new DeleteSubscriptionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteSubscriptionRequest create() => new DeleteSubscriptionRequest();
  static PbList<DeleteSubscriptionRequest> createRepeated() => new PbList<DeleteSubscriptionRequest>();
  static DeleteSubscriptionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteSubscriptionRequest();
    return _defaultInstance;
  }
  static DeleteSubscriptionRequest _defaultInstance;
  static void $checkItem(DeleteSubscriptionRequest v) {
    if (v is !DeleteSubscriptionRequest) checkItemFailed(v, 'DeleteSubscriptionRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);
}

class _ReadonlyDeleteSubscriptionRequest extends DeleteSubscriptionRequest with ReadonlyMessageMixin {}

class ModifyPushConfigRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ModifyPushConfigRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..a/*<PushConfig>*/(2, 'pushConfig', PbFieldType.OM, PushConfig.getDefault, PushConfig.create)
    ..hasRequiredFields = false
  ;

  ModifyPushConfigRequest() : super();
  ModifyPushConfigRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ModifyPushConfigRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ModifyPushConfigRequest clone() => new ModifyPushConfigRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ModifyPushConfigRequest create() => new ModifyPushConfigRequest();
  static PbList<ModifyPushConfigRequest> createRepeated() => new PbList<ModifyPushConfigRequest>();
  static ModifyPushConfigRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModifyPushConfigRequest();
    return _defaultInstance;
  }
  static ModifyPushConfigRequest _defaultInstance;
  static void $checkItem(ModifyPushConfigRequest v) {
    if (v is !ModifyPushConfigRequest) checkItemFailed(v, 'ModifyPushConfigRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);

  PushConfig get pushConfig => $_get(1, 2, null);
  void set pushConfig(PushConfig v) { setField(2, v); }
  bool hasPushConfig() => $_has(1, 2);
  void clearPushConfig() => clearField(2);
}

class _ReadonlyModifyPushConfigRequest extends ModifyPushConfigRequest with ReadonlyMessageMixin {}

class PullRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PullRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..a/*<bool>*/(2, 'returnImmediately', PbFieldType.OB)
    ..a/*<int>*/(3, 'maxMessages', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PullRequest() : super();
  PullRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PullRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PullRequest clone() => new PullRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PullRequest create() => new PullRequest();
  static PbList<PullRequest> createRepeated() => new PbList<PullRequest>();
  static PullRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPullRequest();
    return _defaultInstance;
  }
  static PullRequest _defaultInstance;
  static void $checkItem(PullRequest v) {
    if (v is !PullRequest) checkItemFailed(v, 'PullRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);

  bool get returnImmediately => $_get(1, 2, false);
  void set returnImmediately(bool v) { $_setBool(1, 2, v); }
  bool hasReturnImmediately() => $_has(1, 2);
  void clearReturnImmediately() => clearField(2);

  int get maxMessages => $_get(2, 3, 0);
  void set maxMessages(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasMaxMessages() => $_has(2, 3);
  void clearMaxMessages() => clearField(3);
}

class _ReadonlyPullRequest extends PullRequest with ReadonlyMessageMixin {}

class PullResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PullResponse')
    ..pp/*<ReceivedMessage>*/(1, 'receivedMessages', PbFieldType.PM, ReceivedMessage.$checkItem, ReceivedMessage.create)
    ..hasRequiredFields = false
  ;

  PullResponse() : super();
  PullResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PullResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PullResponse clone() => new PullResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PullResponse create() => new PullResponse();
  static PbList<PullResponse> createRepeated() => new PbList<PullResponse>();
  static PullResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPullResponse();
    return _defaultInstance;
  }
  static PullResponse _defaultInstance;
  static void $checkItem(PullResponse v) {
    if (v is !PullResponse) checkItemFailed(v, 'PullResponse');
  }

  List<ReceivedMessage> get receivedMessages => $_get(0, 1, null);
}

class _ReadonlyPullResponse extends PullResponse with ReadonlyMessageMixin {}

class ModifyAckDeadlineRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ModifyAckDeadlineRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..a/*<String>*/(2, 'ackId', PbFieldType.OS)
    ..a/*<int>*/(3, 'ackDeadlineSeconds', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ModifyAckDeadlineRequest() : super();
  ModifyAckDeadlineRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ModifyAckDeadlineRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ModifyAckDeadlineRequest clone() => new ModifyAckDeadlineRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ModifyAckDeadlineRequest create() => new ModifyAckDeadlineRequest();
  static PbList<ModifyAckDeadlineRequest> createRepeated() => new PbList<ModifyAckDeadlineRequest>();
  static ModifyAckDeadlineRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModifyAckDeadlineRequest();
    return _defaultInstance;
  }
  static ModifyAckDeadlineRequest _defaultInstance;
  static void $checkItem(ModifyAckDeadlineRequest v) {
    if (v is !ModifyAckDeadlineRequest) checkItemFailed(v, 'ModifyAckDeadlineRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);

  String get ackId => $_get(1, 2, '');
  void set ackId(String v) { $_setString(1, 2, v); }
  bool hasAckId() => $_has(1, 2);
  void clearAckId() => clearField(2);

  int get ackDeadlineSeconds => $_get(2, 3, 0);
  void set ackDeadlineSeconds(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasAckDeadlineSeconds() => $_has(2, 3);
  void clearAckDeadlineSeconds() => clearField(3);
}

class _ReadonlyModifyAckDeadlineRequest extends ModifyAckDeadlineRequest with ReadonlyMessageMixin {}

class AcknowledgeRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AcknowledgeRequest')
    ..a/*<String>*/(1, 'subscription', PbFieldType.OS)
    ..p/*<String>*/(2, 'ackIds', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  AcknowledgeRequest() : super();
  AcknowledgeRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AcknowledgeRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AcknowledgeRequest clone() => new AcknowledgeRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AcknowledgeRequest create() => new AcknowledgeRequest();
  static PbList<AcknowledgeRequest> createRepeated() => new PbList<AcknowledgeRequest>();
  static AcknowledgeRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAcknowledgeRequest();
    return _defaultInstance;
  }
  static AcknowledgeRequest _defaultInstance;
  static void $checkItem(AcknowledgeRequest v) {
    if (v is !AcknowledgeRequest) checkItemFailed(v, 'AcknowledgeRequest');
  }

  String get subscription => $_get(0, 1, '');
  void set subscription(String v) { $_setString(0, 1, v); }
  bool hasSubscription() => $_has(0, 1);
  void clearSubscription() => clearField(1);

  List<String> get ackIds => $_get(1, 2, null);
}

class _ReadonlyAcknowledgeRequest extends AcknowledgeRequest with ReadonlyMessageMixin {}

class SubscriberApi {
  RpcClient _client;
  SubscriberApi(this._client);

  Future<Subscription> createSubscription(ClientContext ctx, Subscription request) {
    var emptyResponse = new Subscription();
    return _client.invoke(ctx, 'Subscriber', 'CreateSubscription', request, emptyResponse);
  }
  Future<Subscription> getSubscription(ClientContext ctx, GetSubscriptionRequest request) {
    var emptyResponse = new Subscription();
    return _client.invoke(ctx, 'Subscriber', 'GetSubscription', request, emptyResponse);
  }
  Future<ListSubscriptionsResponse> listSubscriptions(ClientContext ctx, ListSubscriptionsRequest request) {
    var emptyResponse = new ListSubscriptionsResponse();
    return _client.invoke(ctx, 'Subscriber', 'ListSubscriptions', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteSubscription(ClientContext ctx, DeleteSubscriptionRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Subscriber', 'DeleteSubscription', request, emptyResponse);
  }
  Future<google$protobuf.Empty> modifyAckDeadline(ClientContext ctx, ModifyAckDeadlineRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Subscriber', 'ModifyAckDeadline', request, emptyResponse);
  }
  Future<google$protobuf.Empty> acknowledge(ClientContext ctx, AcknowledgeRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Subscriber', 'Acknowledge', request, emptyResponse);
  }
  Future<PullResponse> pull(ClientContext ctx, PullRequest request) {
    var emptyResponse = new PullResponse();
    return _client.invoke(ctx, 'Subscriber', 'Pull', request, emptyResponse);
  }
  Future<google$protobuf.Empty> modifyPushConfig(ClientContext ctx, ModifyPushConfigRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Subscriber', 'ModifyPushConfig', request, emptyResponse);
  }
}

class PublisherApi {
  RpcClient _client;
  PublisherApi(this._client);

  Future<Topic> createTopic(ClientContext ctx, Topic request) {
    var emptyResponse = new Topic();
    return _client.invoke(ctx, 'Publisher', 'CreateTopic', request, emptyResponse);
  }
  Future<PublishResponse> publish(ClientContext ctx, PublishRequest request) {
    var emptyResponse = new PublishResponse();
    return _client.invoke(ctx, 'Publisher', 'Publish', request, emptyResponse);
  }
  Future<Topic> getTopic(ClientContext ctx, GetTopicRequest request) {
    var emptyResponse = new Topic();
    return _client.invoke(ctx, 'Publisher', 'GetTopic', request, emptyResponse);
  }
  Future<ListTopicsResponse> listTopics(ClientContext ctx, ListTopicsRequest request) {
    var emptyResponse = new ListTopicsResponse();
    return _client.invoke(ctx, 'Publisher', 'ListTopics', request, emptyResponse);
  }
  Future<ListTopicSubscriptionsResponse> listTopicSubscriptions(ClientContext ctx, ListTopicSubscriptionsRequest request) {
    var emptyResponse = new ListTopicSubscriptionsResponse();
    return _client.invoke(ctx, 'Publisher', 'ListTopicSubscriptions', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteTopic(ClientContext ctx, DeleteTopicRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Publisher', 'DeleteTopic', request, emptyResponse);
  }
}

