///
//  Generated code. Do not modify.
///
library google.pubsub.v1_pubsub_pbjson;

import '../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../protobuf/field_mask.pbjson.dart' as google$protobuf;
import '../../protobuf/empty.pbjson.dart' as google$protobuf;
import '../../protobuf/timestamp.pbjson.dart' as google$protobuf;

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
    const {'1': 'attributes', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1.PubsubMessage.AttributesEntry'},
    const {'1': 'message_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'publish_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
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
    const {'1': 'messages', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1.PubsubMessage'},
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
    const {'1': 'topics', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1.Topic'},
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
    const {'1': 'push_config', '3': 4, '4': 1, '5': 11, '6': '.google.pubsub.v1.PushConfig'},
    const {'1': 'ack_deadline_seconds', '3': 5, '4': 1, '5': 5},
    const {'1': 'retain_acked_messages', '3': 7, '4': 1, '5': 8},
    const {'1': 'message_retention_duration', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
  ],
};

const PushConfig$json = const {
  '1': 'PushConfig',
  '2': const [
    const {'1': 'push_endpoint', '3': 1, '4': 1, '5': 9},
    const {'1': 'attributes', '3': 2, '4': 3, '5': 11, '6': '.google.pubsub.v1.PushConfig.AttributesEntry'},
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
    const {'1': 'message', '3': 2, '4': 1, '5': 11, '6': '.google.pubsub.v1.PubsubMessage'},
  ],
};

const GetSubscriptionRequest$json = const {
  '1': 'GetSubscriptionRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
  ],
};

const UpdateSubscriptionRequest$json = const {
  '1': 'UpdateSubscriptionRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 11, '6': '.google.pubsub.v1.Subscription'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
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
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1.Subscription'},
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
    const {'1': 'push_config', '3': 2, '4': 1, '5': 11, '6': '.google.pubsub.v1.PushConfig'},
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
    const {'1': 'received_messages', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1.ReceivedMessage'},
  ],
};

const ModifyAckDeadlineRequest$json = const {
  '1': 'ModifyAckDeadlineRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'ack_ids', '3': 4, '4': 3, '5': 9},
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

const StreamingPullRequest$json = const {
  '1': 'StreamingPullRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'ack_ids', '3': 2, '4': 3, '5': 9},
    const {'1': 'modify_deadline_seconds', '3': 3, '4': 3, '5': 5},
    const {'1': 'modify_deadline_ack_ids', '3': 4, '4': 3, '5': 9},
    const {'1': 'stream_ack_deadline_seconds', '3': 5, '4': 1, '5': 5},
  ],
};

const StreamingPullResponse$json = const {
  '1': 'StreamingPullResponse',
  '2': const [
    const {'1': 'received_messages', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1.ReceivedMessage'},
  ],
};

const CreateSnapshotRequest$json = const {
  '1': 'CreateSnapshotRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'subscription', '3': 2, '4': 1, '5': 9},
  ],
};

const Snapshot$json = const {
  '1': 'Snapshot',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'topic', '3': 2, '4': 1, '5': 9},
    const {'1': 'expiration_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const ListSnapshotsRequest$json = const {
  '1': 'ListSnapshotsRequest',
  '2': const [
    const {'1': 'project', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListSnapshotsResponse$json = const {
  '1': 'ListSnapshotsResponse',
  '2': const [
    const {'1': 'snapshots', '3': 1, '4': 3, '5': 11, '6': '.google.pubsub.v1.Snapshot'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DeleteSnapshotRequest$json = const {
  '1': 'DeleteSnapshotRequest',
  '2': const [
    const {'1': 'snapshot', '3': 1, '4': 1, '5': 9},
  ],
};

const SeekRequest$json = const {
  '1': 'SeekRequest',
  '2': const [
    const {'1': 'subscription', '3': 1, '4': 1, '5': 9},
    const {'1': 'time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'snapshot', '3': 3, '4': 1, '5': 9},
  ],
};

const SeekResponse$json = const {
  '1': 'SeekResponse',
};

const Subscriber$json = const {
  '1': 'Subscriber',
  '2': const [
    const {'1': 'CreateSubscription', '2': '.google.pubsub.v1.Subscription', '3': '.google.pubsub.v1.Subscription', '4': const {}},
    const {'1': 'GetSubscription', '2': '.google.pubsub.v1.GetSubscriptionRequest', '3': '.google.pubsub.v1.Subscription', '4': const {}},
    const {'1': 'UpdateSubscription', '2': '.google.pubsub.v1.UpdateSubscriptionRequest', '3': '.google.pubsub.v1.Subscription', '4': const {}},
    const {'1': 'ListSubscriptions', '2': '.google.pubsub.v1.ListSubscriptionsRequest', '3': '.google.pubsub.v1.ListSubscriptionsResponse', '4': const {}},
    const {'1': 'DeleteSubscription', '2': '.google.pubsub.v1.DeleteSubscriptionRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ModifyAckDeadline', '2': '.google.pubsub.v1.ModifyAckDeadlineRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'Acknowledge', '2': '.google.pubsub.v1.AcknowledgeRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'Pull', '2': '.google.pubsub.v1.PullRequest', '3': '.google.pubsub.v1.PullResponse', '4': const {}},
    const {'1': 'StreamingPull', '2': '.google.pubsub.v1.StreamingPullRequest', '3': '.google.pubsub.v1.StreamingPullResponse'},
    const {'1': 'ModifyPushConfig', '2': '.google.pubsub.v1.ModifyPushConfigRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ListSnapshots', '2': '.google.pubsub.v1.ListSnapshotsRequest', '3': '.google.pubsub.v1.ListSnapshotsResponse', '4': const {}},
    const {'1': 'CreateSnapshot', '2': '.google.pubsub.v1.CreateSnapshotRequest', '3': '.google.pubsub.v1.Snapshot', '4': const {}},
    const {'1': 'DeleteSnapshot', '2': '.google.pubsub.v1.DeleteSnapshotRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'Seek', '2': '.google.pubsub.v1.SeekRequest', '3': '.google.pubsub.v1.SeekResponse', '4': const {}},
  ],
};

const Subscriber$messageJson = const {
  '.google.pubsub.v1.Subscription': Subscription$json,
  '.google.pubsub.v1.PushConfig': PushConfig$json,
  '.google.pubsub.v1.PushConfig.AttributesEntry': PushConfig_AttributesEntry$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.pubsub.v1.GetSubscriptionRequest': GetSubscriptionRequest$json,
  '.google.pubsub.v1.UpdateSubscriptionRequest': UpdateSubscriptionRequest$json,
  '.google.protobuf.FieldMask': google$protobuf.FieldMask$json,
  '.google.pubsub.v1.ListSubscriptionsRequest': ListSubscriptionsRequest$json,
  '.google.pubsub.v1.ListSubscriptionsResponse': ListSubscriptionsResponse$json,
  '.google.pubsub.v1.DeleteSubscriptionRequest': DeleteSubscriptionRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.pubsub.v1.ModifyAckDeadlineRequest': ModifyAckDeadlineRequest$json,
  '.google.pubsub.v1.AcknowledgeRequest': AcknowledgeRequest$json,
  '.google.pubsub.v1.PullRequest': PullRequest$json,
  '.google.pubsub.v1.PullResponse': PullResponse$json,
  '.google.pubsub.v1.ReceivedMessage': ReceivedMessage$json,
  '.google.pubsub.v1.PubsubMessage': PubsubMessage$json,
  '.google.pubsub.v1.PubsubMessage.AttributesEntry': PubsubMessage_AttributesEntry$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.pubsub.v1.StreamingPullRequest': StreamingPullRequest$json,
  '.google.pubsub.v1.StreamingPullResponse': StreamingPullResponse$json,
  '.google.pubsub.v1.ModifyPushConfigRequest': ModifyPushConfigRequest$json,
  '.google.pubsub.v1.ListSnapshotsRequest': ListSnapshotsRequest$json,
  '.google.pubsub.v1.ListSnapshotsResponse': ListSnapshotsResponse$json,
  '.google.pubsub.v1.Snapshot': Snapshot$json,
  '.google.pubsub.v1.CreateSnapshotRequest': CreateSnapshotRequest$json,
  '.google.pubsub.v1.DeleteSnapshotRequest': DeleteSnapshotRequest$json,
  '.google.pubsub.v1.SeekRequest': SeekRequest$json,
  '.google.pubsub.v1.SeekResponse': SeekResponse$json,
};

const Publisher$json = const {
  '1': 'Publisher',
  '2': const [
    const {'1': 'CreateTopic', '2': '.google.pubsub.v1.Topic', '3': '.google.pubsub.v1.Topic', '4': const {}},
    const {'1': 'Publish', '2': '.google.pubsub.v1.PublishRequest', '3': '.google.pubsub.v1.PublishResponse', '4': const {}},
    const {'1': 'GetTopic', '2': '.google.pubsub.v1.GetTopicRequest', '3': '.google.pubsub.v1.Topic', '4': const {}},
    const {'1': 'ListTopics', '2': '.google.pubsub.v1.ListTopicsRequest', '3': '.google.pubsub.v1.ListTopicsResponse', '4': const {}},
    const {'1': 'ListTopicSubscriptions', '2': '.google.pubsub.v1.ListTopicSubscriptionsRequest', '3': '.google.pubsub.v1.ListTopicSubscriptionsResponse', '4': const {}},
    const {'1': 'DeleteTopic', '2': '.google.pubsub.v1.DeleteTopicRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const Publisher$messageJson = const {
  '.google.pubsub.v1.Topic': Topic$json,
  '.google.pubsub.v1.PublishRequest': PublishRequest$json,
  '.google.pubsub.v1.PubsubMessage': PubsubMessage$json,
  '.google.pubsub.v1.PubsubMessage.AttributesEntry': PubsubMessage_AttributesEntry$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.pubsub.v1.PublishResponse': PublishResponse$json,
  '.google.pubsub.v1.GetTopicRequest': GetTopicRequest$json,
  '.google.pubsub.v1.ListTopicsRequest': ListTopicsRequest$json,
  '.google.pubsub.v1.ListTopicsResponse': ListTopicsResponse$json,
  '.google.pubsub.v1.ListTopicSubscriptionsRequest': ListTopicSubscriptionsRequest$json,
  '.google.pubsub.v1.ListTopicSubscriptionsResponse': ListTopicSubscriptionsResponse$json,
  '.google.pubsub.v1.DeleteTopicRequest': DeleteTopicRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

