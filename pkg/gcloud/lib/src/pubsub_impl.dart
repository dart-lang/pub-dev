// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of gcloud.pubsub;

class _PubSubImpl implements PubSub {
  final String project;
  final pubsub.PubsubApi _api;
  final String _topicPrefix;
  final String _subscriptionPrefix;

  _PubSubImpl(http.Client client, this.project)
      : _api = new pubsub.PubsubApi(client),
        _topicPrefix = 'projects/$project/topics/',
        _subscriptionPrefix = 'projects/$project/subscriptions/';

  String _fullTopicName(String name) {
    return name.startsWith('projects/') ? name : '${_topicPrefix}$name';
  }

  String _fullSubscriptionName(name) {
    return name.startsWith('projects/') ? name : '${_subscriptionPrefix}$name';
  }

  Future<pubsub.Topic> _createTopic(String name) {
    return _api.projects.topics.create(new pubsub.Topic()..name = name, name);
  }

  Future _deleteTopic(String name) {
    // The Pub/Sub delete API returns an instance of Empty.
    return _api.projects.topics.delete(name).then((_) => null);
  }

  Future<pubsub.Topic> _getTopic(String name) {
    return _api.projects.topics.get(name);
  }

  Future<pubsub.ListTopicsResponse> _listTopics(
      int pageSize, String nextPageToken) {
    return _api.projects.topics.list('projects/$project',
        pageSize: pageSize, pageToken: nextPageToken);
  }

  Future<pubsub.Subscription> _createSubscription(
      String name, String topic, Uri endpoint) {
    var subscription = new pubsub.Subscription()
      ..name = name
      ..topic = topic;
    if (endpoint != null) {
      var pushConfig = new pubsub.PushConfig()
        ..pushEndpoint = endpoint.toString();
      subscription.pushConfig = pushConfig;
    }
    return _api.projects.subscriptions.create(subscription, name);
  }

  Future _deleteSubscription(String name) {
    // The Pub/Sub delete API returns an instance of Empty.
    return _api.projects.subscriptions
        .delete(_fullSubscriptionName(name))
        .then((_) => null);
  }

  Future<pubsub.Subscription> _getSubscription(String name) {
    return _api.projects.subscriptions.get(name);
  }

  Future<pubsub.ListSubscriptionsResponse> _listSubscriptions(
      String topic, int pageSize, String nextPageToken) {
    return _api.projects.subscriptions.list('projects/$project',
        pageSize: pageSize, pageToken: nextPageToken);
  }

  Future _modifyPushConfig(String subscription, Uri endpoint) {
    var pushConfig = new pubsub.PushConfig()
      ..pushEndpoint = endpoint != null ? endpoint.toString() : null;
    var request = new pubsub.ModifyPushConfigRequest()..pushConfig = pushConfig;
    return _api.projects.subscriptions.modifyPushConfig(request, subscription);
  }

  Future _publish(
      String topic, List<int> message, Map<String, String> attributes) {
    var request = new pubsub.PublishRequest()
      ..messages = [
        (new pubsub.PubsubMessage()
          ..dataAsBytes = message
          ..attributes = attributes)
      ];
    // TODO(sgjesse): Handle PublishResponse containing message ids.
    return _api.projects.topics.publish(request, topic).then((_) => null);
  }

  Future<pubsub.PullResponse> _pull(
      String subscription, bool returnImmediately) {
    var request = new pubsub.PullRequest()
      ..maxMessages = 1
      ..returnImmediately = returnImmediately;
    return _api.projects.subscriptions.pull(request, subscription);
  }

  Future _ack(String ackId, String subscription) {
    var request = new pubsub.AcknowledgeRequest()..ackIds = [ackId];
    // The Pub/Sub acknowledge API returns an instance of Empty.
    return _api.projects.subscriptions
        .acknowledge(request, subscription)
        .then((_) => null);
  }

  void _checkTopicName(name) {
    if (name.startsWith('projects/') && !name.contains('/topics/')) {
      throw new ArgumentError(
          "Illegal topic name. Absolute topic names must have the form "
          "'projects/[project-id]/topics/[topic-name]");
    }
    if (name.endsWith('/topics/')) {
      throw new ArgumentError(
          'Illegal topic name. Relative part of the name cannot be empty');
    }
  }

  void _checkSubscriptionName(name) {
    if (name.startsWith('projects/') && !name.contains('/subscriptions/')) {
      throw new ArgumentError(
          "Illegal subscription name. Absolute subscription names must have "
          "the form 'projects/[project-id]/subscriptions/[subscription-name]");
    }
    if (name.endsWith('/subscriptions/')) {
      throw new ArgumentError(
          'Illegal subscription name. Relative part of the name cannot be '
          'empty');
    }
  }

  Future<Topic> createTopic(String name) {
    _checkTopicName(name);
    return _createTopic(_fullTopicName(name))
        .then((top) => new _TopicImpl(this, top));
  }

  Future deleteTopic(String name) {
    _checkTopicName(name);
    return _deleteTopic(_fullTopicName(name));
  }

  Future<Topic> lookupTopic(String name) {
    _checkTopicName(name);
    return _getTopic(_fullTopicName(name))
        .then((top) => new _TopicImpl(this, top));
  }

  Stream<Topic> listTopics() {
    Future<Page<Topic>> firstPage(pageSize) {
      return _listTopics(pageSize, null)
          .then((response) => new _TopicPageImpl(this, pageSize, response));
    }

    return new StreamFromPages<Topic>(firstPage).stream;
  }

  Future<Page<Topic>> pageTopics({int pageSize: 50}) {
    return _listTopics(pageSize, null).then((response) {
      return new _TopicPageImpl(this, pageSize, response);
    });
  }

  Future<Subscription> createSubscription(String name, String topic,
      {Uri endpoint}) {
    _checkSubscriptionName(name);
    _checkTopicName(topic);
    return _createSubscription(
            _fullSubscriptionName(name), _fullTopicName(topic), endpoint)
        .then((sub) => new _SubscriptionImpl(this, sub));
  }

  Future deleteSubscription(String name) {
    _checkSubscriptionName(name);
    return _deleteSubscription(_fullSubscriptionName(name));
  }

  Future<Subscription> lookupSubscription(String name) {
    _checkSubscriptionName(name);
    return _getSubscription(_fullSubscriptionName(name))
        .then((sub) => new _SubscriptionImpl(this, sub));
  }

  Stream<Subscription> listSubscriptions([String query]) {
    Future<Page<Subscription>> firstPage(pageSize) {
      return _listSubscriptions(query, pageSize, null).then((response) =>
          new _SubscriptionPageImpl(this, query, pageSize, response));
    }

    return new StreamFromPages<Subscription>(firstPage).stream;
  }

  Future<Page<Subscription>> pageSubscriptions(
      {String topic, int pageSize: 50}) {
    return _listSubscriptions(topic, pageSize, null).then((response) {
      return new _SubscriptionPageImpl(this, topic, pageSize, response);
    });
  }
}

/// Message class for messages constructed through 'new Message()'. It stores
/// the user supplied body as either String or bytes.
class _MessageImpl implements Message {
  // The message body, if it is a `String`. In that case, [bytesMessage] is
  // null.
  final String _stringMessage;

  // The message body, if it is a byte list. In that case, [stringMessage] is
  // null.
  final List<int> _bytesMessage;

  final Map<String, String> attributes;

  _MessageImpl.withString(this._stringMessage, {this.attributes})
      : _bytesMessage = null;

  _MessageImpl.withBytes(this._bytesMessage, {this.attributes})
      : _stringMessage = null;

  List<int> get asBytes =>
      _bytesMessage != null ? _bytesMessage : UTF8.encode(_stringMessage);

  String get asString =>
      _stringMessage != null ? _stringMessage : UTF8.decode(_bytesMessage);
}

/// Message received using [Subscription.pull].
///
/// Contains the [pubsub.PubsubMessage] received from Pub/Sub, and
/// makes the message body and labels available on request.
///
/// The labels map is lazily created when first accessed.
class _PullMessage implements Message {
  final pubsub.PubsubMessage _message;
  List<int> _bytes;
  String _string;

  _PullMessage(this._message);

  List<int> get asBytes {
    if (_bytes == null) _bytes = _message.dataAsBytes;
    return _bytes;
  }

  String get asString {
    if (_string == null) _string = UTF8.decode(_message.dataAsBytes);
    return _string;
  }

  Map<String, String> get attributes => _message.attributes;
}

/// Message received through Pub/Sub push delivery.
///
/// Stores the message body received from Pub/Sub as the Base64 encoded string
/// from the wire protocol.
///
/// The labels have been decoded into a Map.
class _PushMessage implements Message {
  final String _base64Message;
  final Map<String, String> attributes;

  _PushMessage(this._base64Message, this.attributes);

  List<int> get asBytes => BASE64.decode(_base64Message);

  String get asString => UTF8.decode(asBytes);
}

/// Pull event received from Pub/Sub pull delivery.
///
/// Stores the pull response received from Pub/Sub.
class _PullEventImpl implements PullEvent {
  /// Pub/Sub API object.
  final _PubSubImpl _api;

  /// Subscription this was received from.
  final String _subscriptionName;

  /// Low level response received from Pub/Sub.
  final pubsub.PullResponse _response;
  final Message message;

  _PullEventImpl(
      this._api, this._subscriptionName, pubsub.PullResponse response)
      : this._response = response,
        message = new _PullMessage(response.receivedMessages[0].message);

  Future acknowledge() {
    return _api._ack(_response.receivedMessages[0].ackId, _subscriptionName);
  }
}

/// Push event received from Pub/Sub push delivery.
///
/// decoded from JSON encoded push HTTP request body.
class _PushEventImpl implements PushEvent {
  static const PREFIX = '/subscriptions/';
  final Message _message;
  final String _subscriptionName;

  Message get message => _message;

  String get subscriptionName => _subscriptionName;

  _PushEventImpl(this._message, this._subscriptionName);

  factory _PushEventImpl.fromJson(String json) {
    Map body = JSON.decode(json);
    String data = body['message']['data'];
    Map labels = new HashMap();
    body['message']['labels'].forEach((label) {
      var key = label['key'];
      var value = label['strValue'];
      if (value == null) value = label['numValue'];
      labels[key] = value;
    });
    String subscription = body['subscription'];
    // TODO(#1): Remove this when the push event subscription name is prefixed
    // with '/subscriptions/'.
    if (!subscription.startsWith(PREFIX)) {
      subscription = PREFIX + subscription;
    }
    return new _PushEventImpl(new _PushMessage(data, labels), subscription);
  }
}

class _TopicImpl implements Topic {
  final _PubSubImpl _api;
  final pubsub.Topic _topic;

  _TopicImpl(this._api, this._topic);

  String get name {
    assert(_topic.name.startsWith(_api._topicPrefix));
    return _topic.name.substring(_api._topicPrefix.length);
  }

  String get project {
    assert(_topic.name.startsWith(_api._topicPrefix));
    return _api.project;
  }

  String get absoluteName => _topic.name;

  Future publish(Message message) {
    return _api._publish(_topic.name, message.asBytes, message.attributes);
  }

  Future delete() => _api._deleteTopic(_topic.name);

  Future publishString(String message, {Map<String, String> attributes}) {
    return _api._publish(_topic.name, UTF8.encode(message), attributes);
  }

  Future publishBytes(List<int> message, {Map<String, String> attributes}) {
    return _api._publish(_topic.name, message, attributes);
  }
}

class _SubscriptionImpl implements Subscription {
  final _PubSubImpl _api;
  final pubsub.Subscription _subscription;

  _SubscriptionImpl(this._api, this._subscription);

  String get name {
    assert(_subscription.name.startsWith(_api._subscriptionPrefix));
    return _subscription.name.substring(_api._subscriptionPrefix.length);
  }

  String get project {
    assert(_subscription.name.startsWith(_api._subscriptionPrefix));
    return _api.project;
  }

  String get absoluteName => _subscription.name;

  Topic get topic {
    var topic = new pubsub.Topic()..name = _subscription.topic;
    return new _TopicImpl(_api, topic);
  }

  Future delete() => _api._deleteSubscription(_subscription.name);

  Future<PullEvent> pull({bool wait: true}) {
    return _api._pull(_subscription.name, !wait).then((response) {
      // The documentation says 'Returns an empty list if there are no
      // messages available in the backlog'. However the receivedMessages
      // property can also be null in that case.
      if (response.receivedMessages == null ||
          response.receivedMessages.length == 0) {
        return null;
      }
      return new _PullEventImpl(_api, _subscription.name, response);
    }).catchError((e) => null,
        test: (e) => e is pubsub.DetailedApiRequestError && e.status == 400);
  }

  Uri get endpoint => null;

  bool get isPull => endpoint == null;

  bool get isPush => endpoint != null;

  Future updatePushConfiguration(Uri endpoint) {
    return _api._modifyPushConfig(_subscription.name, endpoint);
  }
}

class _TopicPageImpl implements Page<Topic> {
  final _PubSubImpl _api;
  final int _pageSize;
  final String _nextPageToken;
  final List<Topic> items;

  _TopicPageImpl(this._api, this._pageSize, pubsub.ListTopicsResponse response)
      : items = new List(response.topics.length),
        _nextPageToken = response.nextPageToken {
    for (int i = 0; i < response.topics.length; i++) {
      items[i] = new _TopicImpl(_api, response.topics[i]);
    }
  }

  bool get isLast => _nextPageToken == null;

  Future<Page<Topic>> next({int pageSize}) {
    if (isLast) return new Future.value(null);
    if (pageSize == null) pageSize = this._pageSize;

    return _api._listTopics(pageSize, _nextPageToken).then((response) {
      return new _TopicPageImpl(_api, pageSize, response);
    });
  }
}

class _SubscriptionPageImpl implements Page<Subscription> {
  final _PubSubImpl _api;
  final String _topic;
  final int _pageSize;
  final String _nextPageToken;
  final List<Subscription> items;

  _SubscriptionPageImpl(this._api, this._topic, this._pageSize,
      pubsub.ListSubscriptionsResponse response)
      : items = new List(
            response.subscriptions != null ? response.subscriptions.length : 0),
        _nextPageToken = response.nextPageToken {
    if (response.subscriptions != null) {
      for (int i = 0; i < response.subscriptions.length; i++) {
        items[i] = new _SubscriptionImpl(_api, response.subscriptions[i]);
      }
    }
  }

  bool get isLast => _nextPageToken == null;

  Future<Page<Subscription>> next({int pageSize}) {
    if (_nextPageToken == null) return new Future.value(null);
    if (pageSize == null) pageSize = this._pageSize;

    return _api
        ._listSubscriptions(_topic, pageSize, _nextPageToken)
        .then((response) {
      return new _SubscriptionPageImpl(_api, _topic, pageSize, response);
    });
  }
}
