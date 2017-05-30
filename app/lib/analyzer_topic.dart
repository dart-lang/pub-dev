// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/pubsub.dart';
import 'package:gcloud/service_scope.dart' as ss;

/// The active [AnalyzerTopic] service.
AnalyzerTopic get analyzerTopic => ss.lookup(#_analyzerTopic);

/// Sets the [AnalyzerTopic] service.
void registerAnalyzeTopic(AnalyzerTopic value) =>
    ss.register(#_analyzerTopic, value);

/// Handles sending and receiving analyze requests through PubSub.
class AnalyzerTopic {
  final PubSub _pubSub;
  final String _topicName;
  final String _subscriptionName;
  Topic _topic;
  Subscription _subscription;

  AnalyzerTopic(
    this._pubSub, {
    String topic: 'analyzer',
    String subscription: 'analyzer_service',
  })
      : _topicName = topic,
        _subscriptionName = subscription;

  /// Sends a new [AnalyzeRequest].
  Future sendRequest(AnalyzeRequest rq) async {
    final Topic topic = await _getOrCreateTopic();
    await topic.publishString(rq.toMessage());
  }

  /// Pulls a new [Message] from the topic.
  Future<AnalyzeRequest> pullRequest() async {
    final Subscription subs = await _getOrCreateSubscription();
    final event = await subs.pull();
    // Immediate acknowledgement, because:
    // - don't analyze the same package in parallel
    // - don't have messages stuck in the queue in case of analyzer error
    // - should have a way to re-trigger analysis when analyzer service is idle
    await event.acknowledge();
    return new AnalyzeRequest.fromMessage(event.message.asString);
  }

  Future<Topic> _getOrCreateTopic() async {
    if (_topic == null) {
      try {
        _topic = await _pubSub.lookupTopic(_topicName);
      } catch (_) {
        // ignore if missing, will create in next step
      }
    }
    if (_topic == null) {
      try {
        _topic = await _pubSub.createTopic(_topicName);
      } catch (_) {
        // ignore race condition for create
      }
    }
    if (_topic == null) {
      _topic = await _pubSub.lookupTopic(_topicName);
    }
    return _topic;
  }

  // Returns the shared subscription which can be
  Future<Subscription> _getOrCreateSubscription() async {
    if (_subscription == null) {
      try {
        _subscription = await _pubSub.lookupSubscription(_subscriptionName);
      } catch (_) {
        // ignore if missing, will create in next step
      }
      try {
        _subscription =
            await _pubSub.createSubscription(_subscriptionName, _topicName);
      } catch (_) {
        // ignore race condition for create
      }
      _subscription = await _pubSub.lookupSubscription(_subscriptionName);
    }
    return _subscription;
  }
}

class AnalyzeRequest {
  final String package;
  final String version;

  AnalyzeRequest(this.package, this.version);

  factory AnalyzeRequest.fromMessage(String message) {
    final Map map = JSON.decode(message);
    return new AnalyzeRequest(map['package'], map['version']);
  }

  String toMessage() => JSON.encode({'package': package, 'version': version});
}
