///
//  Generated code. Do not modify.
///
library google.pubsub.v1beta2_pubsub_pbjson;

import '../../protobuf/empty.pbjson.dart' as google$protobuf;

const Topic$json = const {
  '1': 'Topic',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const PubsubMessage$json = const {
  '1': 'PubsubMessage',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 12},
    const {'1': 'attributes', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.PubsubMessage.AttributesEntry'},
    const {'1': 'message_id', '3': 3, '4': 1, '5': 9},
  ],
  '3': const [PubsubMessage_AttributesEntry$json],
};

const PubsubMessage_AttributesEntry$json = const {
  '1': 'AttributesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const GetTopicRequest$json = const {
  '1': 'GetTopicRequest',
  '2': const [
    const {'1': 'topic', '3': 1, '4': 1, '5': 9},
  ],
};

const PublishRequest$json = const {
  '1': 'PublishRequest',
  '2': const [
    const {'1': 'topic', '3': 1, '4': 1, '5': 9},
    const {'1': 'messages', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.PubsubMessage'},
  ],
};

const PublishResponse$json = const {
  '1': 'PublishResponse',
  '2': const [
    const {'1': 'message_ids', '3': 1, '4': 3, '5': 9},
  ],
};

const ListTopicsRequest$json = const {
  '1': 'ListTopicsRequest',
  '2': const [
    const {'1': 'project', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListTopicsResponse$json = const {
  '1': 'ListTopicsResponse',
  '2': const [
    const {'1': 'topics', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.Topic'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const ListTopicSubscriptionsRequest$json = const {
  '1': 'ListTopicSubscriptionsRequest',
  '2': const [
    const {'1': 'topic', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListTopicSubscriptionsResponse$json = const {
  '1': 'ListTopicSubscriptionsResponse',
  '2': const [
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 9},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteTopicRequest$json = const {
  '1': 'DeleteTopicRequest',
  '2': const [
    const {'1': 'topic', '3': 1, '4': 1, '5': 9},
  ],
};

const Subscription$json = const {
  '1': 'Subscription',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'topic', '3': 2, '4': 1, '5': 9},
    const {'1': 'push_config', '3': 4, '4': 1, '5': 11, '6': '.google.pubsub.v1beta2.PushConfig'},
    const {'1': 'ack_deadline_seconds', '3': 5, '4': 1, '5': 5},
  ],
};

const PushConfig$json = const {
  '1': 'PushConfig',
  '2': const [
    const {'1': 'push_endpoint', '3': 1, '4': 1, '5': 9},
    const {'1': 'attributes', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.PushConfig.AttributesEntry'},
  ],
  '3': const [PushConfig_AttributesEntry$json],
};

const PushConfig_AttributesEntry$json = const {
  '1': 'AttributesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const ReceivedMessage$json = const {
  '1': 'ReceivedMessage',
  '2': const [
    const {'1': 'ack_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.google.pubsub.v1beta2.PubsubMessage'},
  ],
};

const GetSubscriptionRequest$json = const {
  '1': 'GetSubscriptionRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
  ],
};

const ListSubscriptionsRequest$json = const {
  '1': 'ListSubscriptionsRequest',
  '2': const [
    const {'1': 'project', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListSubscriptionsResponse$json = const {
  '1': 'ListSubscriptionsResponse',
  '2': const [
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.Subscription'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteSubscriptionRequest$json = const {
  '1': 'DeleteSubscriptionRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
  ],
};

const ModifyPushConfigRequest$json = const {
  '1': 'ModifyPushConfigRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'push_config', '3': 2, '4': 1, '5': 11, '6': '.google.pubsub.v1beta2.PushConfig'},
  ],
};

const PullRequest$json = const {
  '1': 'PullRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'return_immediately', '3': 2, '4': 1, '5': 8},
    const {'1': 'max_messages', '3': 3, '4': 1, '5': 5},
  ],
};

const PullResponse$json = const {
  '1': 'PullResponse',
  '2': const [
    const {'1': 'received_messages', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1beta2.ReceivedMessage'},
  ],
};

const ModifyAckDeadlineRequest$json = const {
  '1': 'ModifyAckDeadlineRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'ack_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'ack_deadline_seconds', '3': 3, '4': 1, '5': 5},
  ],
};

const AcknowledgeRequest$json = const {
  '1': 'AcknowledgeRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'ack_ids', '3': 2, '4': 3, '5': 9},
  ],
};

const Subscriber$json = const {
  '1': 'Subscriber',
  '2': const [
    const {'1': 'CreateSubscription', '2': '.google.pubsub.v1beta2.Subscription', '3': '.google.pubsub.v1beta2.Subscription'},
    const {'1': 'GetSubscription', '2': '.google.pubsub.v1beta2.GetSubscriptionRequest', '3': '.google.pubsub.v1beta2.Subscription'},
    const {'1': 'ListSubscriptions', '2': '.google.pubsub.v1beta2.ListSubscriptionsRequest', '3': '.google.pubsub.v1beta2.ListSubscriptionsResponse'},
    const {'1': 'DeleteSubscription', '2': '.google.pubsub.v1beta2.DeleteSubscriptionRequest', '3': '.google.protobuf.Empty'},
    const {'1': 'ModifyAckDeadline', '2': '.google.pubsub.v1beta2.ModifyAckDeadlineRequest', '3': '.google.protobuf.Empty'},
    const {'1': 'Acknowledge', '2': '.google.pubsub.v1beta2.AcknowledgeRequest', '3': '.google.protobuf.Empty'},
    const {'1': 'Pull', '2': '.google.pubsub.v1beta2.PullRequest', '3': '.google.pubsub.v1beta2.PullResponse'},
    const {'1': 'ModifyPushConfig', '2': '.google.pubsub.v1beta2.ModifyPushConfigRequest', '3': '.google.protobuf.Empty'},
  ],
};

const Subscriber$messageJson = const {
  '.google.pubsub.v1beta2.Subscription': Subscription$json,
  '.google.pubsub.v1beta2.PushConfig': PushConfig$json,
  '.google.pubsub.v1beta2.PushConfig.AttributesEntry': PushConfig_AttributesEntry$json,
  '.google.pubsub.v1beta2.GetSubscriptionRequest': GetSubscriptionRequest$json,
  '.google.pubsub.v1beta2.ListSubscriptionsRequest': ListSubscriptionsRequest$json,
  '.google.pubsub.v1beta2.ListSubscriptionsResponse': ListSubscriptionsResponse$json,
  '.google.pubsub.v1beta2.DeleteSubscriptionRequest': DeleteSubscriptionRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.pubsub.v1beta2.ModifyAckDeadlineRequest': ModifyAckDeadlineRequest$json,
  '.google.pubsub.v1beta2.AcknowledgeRequest': AcknowledgeRequest$json,
  '.google.pubsub.v1beta2.PullRequest': PullRequest$json,
  '.google.pubsub.v1beta2.PullResponse': PullResponse$json,
  '.google.pubsub.v1beta2.ReceivedMessage': ReceivedMessage$json,
  '.google.pubsub.v1beta2.PubsubMessage': PubsubMessage$json,
  '.google.pubsub.v1beta2.PubsubMessage.AttributesEntry': PubsubMessage_AttributesEntry$json,
  '.google.pubsub.v1beta2.ModifyPushConfigRequest': ModifyPushConfigRequest$json,
};

const Publisher$json = const {
  '1': 'Publisher',
  '2': const [
    const {'1': 'CreateTopic', '2': '.google.pubsub.v1beta2.Topic', '3': '.google.pubsub.v1beta2.Topic'},
    const {'1': 'Publish', '2': '.google.pubsub.v1beta2.PublishRequest', '3': '.google.pubsub.v1beta2.PublishResponse'},
    const {'1': 'GetTopic', '2': '.google.pubsub.v1beta2.GetTopicRequest', '3': '.google.pubsub.v1beta2.Topic'},
    const {'1': 'ListTopics', '2': '.google.pubsub.v1beta2.ListTopicsRequest', '3': '.google.pubsub.v1beta2.ListTopicsResponse'},
    const {'1': 'ListTopicSubscriptions', '2': '.google.pubsub.v1beta2.ListTopicSubscriptionsRequest', '3': '.google.pubsub.v1beta2.ListTopicSubscriptionsResponse'},
    const {'1': 'DeleteTopic', '2': '.google.pubsub.v1beta2.DeleteTopicRequest', '3': '.google.protobuf.Empty'},
  ],
};

const Publisher$messageJson = const {
  '.google.pubsub.v1beta2.Topic': Topic$json,
  '.google.pubsub.v1beta2.PublishRequest': PublishRequest$json,
  '.google.pubsub.v1beta2.PubsubMessage': PubsubMessage$json,
  '.google.pubsub.v1beta2.PubsubMessage.AttributesEntry': PubsubMessage_AttributesEntry$json,
  '.google.pubsub.v1beta2.PublishResponse': PublishResponse$json,
  '.google.pubsub.v1beta2.GetTopicRequest': GetTopicRequest$json,
  '.google.pubsub.v1beta2.ListTopicsRequest': ListTopicsRequest$json,
  '.google.pubsub.v1beta2.ListTopicsResponse': ListTopicsResponse$json,
  '.google.pubsub.v1beta2.ListTopicSubscriptionsRequest': ListTopicSubscriptionsRequest$json,
  '.google.pubsub.v1beta2.ListTopicSubscriptionsResponse': ListTopicSubscriptionsResponse$json,
  '.google.pubsub.v1beta2.DeleteTopicRequest': DeleteTopicRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

