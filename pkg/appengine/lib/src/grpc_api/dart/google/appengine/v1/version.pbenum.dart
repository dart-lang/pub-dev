///
//  Generated code. Do not modify.
///
library google.appengine.v1_version_pbenum;

import 'package:protobuf/protobuf.dart';

class InboundServiceType extends ProtobufEnum {
  static const InboundServiceType INBOUND_SERVICE_UNSPECIFIED = const InboundServiceType._(0, 'INBOUND_SERVICE_UNSPECIFIED');
  static const InboundServiceType INBOUND_SERVICE_MAIL = const InboundServiceType._(1, 'INBOUND_SERVICE_MAIL');
  static const InboundServiceType INBOUND_SERVICE_MAIL_BOUNCE = const InboundServiceType._(2, 'INBOUND_SERVICE_MAIL_BOUNCE');
  static const InboundServiceType INBOUND_SERVICE_XMPP_ERROR = const InboundServiceType._(3, 'INBOUND_SERVICE_XMPP_ERROR');
  static const InboundServiceType INBOUND_SERVICE_XMPP_MESSAGE = const InboundServiceType._(4, 'INBOUND_SERVICE_XMPP_MESSAGE');
  static const InboundServiceType INBOUND_SERVICE_XMPP_SUBSCRIBE = const InboundServiceType._(5, 'INBOUND_SERVICE_XMPP_SUBSCRIBE');
  static const InboundServiceType INBOUND_SERVICE_XMPP_PRESENCE = const InboundServiceType._(6, 'INBOUND_SERVICE_XMPP_PRESENCE');
  static const InboundServiceType INBOUND_SERVICE_CHANNEL_PRESENCE = const InboundServiceType._(7, 'INBOUND_SERVICE_CHANNEL_PRESENCE');
  static const InboundServiceType INBOUND_SERVICE_WARMUP = const InboundServiceType._(9, 'INBOUND_SERVICE_WARMUP');

  static const List<InboundServiceType> values = const <InboundServiceType> [
    INBOUND_SERVICE_UNSPECIFIED,
    INBOUND_SERVICE_MAIL,
    INBOUND_SERVICE_MAIL_BOUNCE,
    INBOUND_SERVICE_XMPP_ERROR,
    INBOUND_SERVICE_XMPP_MESSAGE,
    INBOUND_SERVICE_XMPP_SUBSCRIBE,
    INBOUND_SERVICE_XMPP_PRESENCE,
    INBOUND_SERVICE_CHANNEL_PRESENCE,
    INBOUND_SERVICE_WARMUP,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static InboundServiceType valueOf(int value) => _byValue[value] as InboundServiceType;
  static void $checkItem(InboundServiceType v) {
    if (v is !InboundServiceType) checkItemFailed(v, 'InboundServiceType');
  }

  const InboundServiceType._(int v, String n) : super(v, n);
}

class ServingStatus extends ProtobufEnum {
  static const ServingStatus SERVING_STATUS_UNSPECIFIED = const ServingStatus._(0, 'SERVING_STATUS_UNSPECIFIED');
  static const ServingStatus SERVING = const ServingStatus._(1, 'SERVING');
  static const ServingStatus STOPPED = const ServingStatus._(2, 'STOPPED');

  static const List<ServingStatus> values = const <ServingStatus> [
    SERVING_STATUS_UNSPECIFIED,
    SERVING,
    STOPPED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ServingStatus valueOf(int value) => _byValue[value] as ServingStatus;
  static void $checkItem(ServingStatus v) {
    if (v is !ServingStatus) checkItemFailed(v, 'ServingStatus');
  }

  const ServingStatus._(int v, String n) : super(v, n);
}

