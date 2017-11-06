///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_servicemanager_pbjson;

import 'resources.pbjson.dart';
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;
import '../../service.pbjson.dart' as google$api;
import '../../../protobuf/api.pbjson.dart' as google$protobuf;
import '../../../protobuf/type.pbjson.dart' as google$protobuf;
import '../../../protobuf/source_context.pbjson.dart' as google$protobuf;
import '../../documentation.pbjson.dart' as google$api;
import '../../backend.pbjson.dart' as google$api;
import '../../http.pbjson.dart' as google$api;
import '../../auth.pbjson.dart' as google$api;
import '../../context.pbjson.dart' as google$api;
import '../../usage.pbjson.dart' as google$api;
import '../../endpoint.pbjson.dart' as google$api;
import '../../../protobuf/wrappers.pbjson.dart' as google$protobuf;
import '../../control.pbjson.dart' as google$api;
import '../../log.pbjson.dart' as google$api;
import '../../label.pbjson.dart' as google$api;
import '../../metric.pbjson.dart' as google$api;
import '../../monitored_resource.pbjson.dart' as google$api;
import '../../logging.pbjson.dart' as google$api;
import '../../monitoring.pbjson.dart' as google$api;
import '../../system_parameter.pbjson.dart' as google$api;
import '../../experimental/experimental.pbjson.dart' as google$api;
import '../../experimental/authorization_config.pbjson.dart' as google$api;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../config_change.pbjson.dart' as google$api;

const ListServicesRequest$json = const {
  '1': 'ListServicesRequest',
  '2': const [
    const {'1': 'producer_project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 5, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 6, '4': 1, '5': 9},
  ],
};

const ListServicesResponse$json = const {
  '1': 'ListServicesResponse',
  '2': const [
    const {'1': 'services', '3': 1, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.ManagedService'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetServiceRequest$json = const {
  '1': 'GetServiceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateServiceRequest$json = const {
  '1': 'CreateServiceRequest',
  '2': const [
    const {'1': 'service', '3': 1, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.ManagedService'},
  ],
};

const DeleteServiceRequest$json = const {
  '1': 'DeleteServiceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
  ],
};

const UndeleteServiceRequest$json = const {
  '1': 'UndeleteServiceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
  ],
};

const UndeleteServiceResponse$json = const {
  '1': 'UndeleteServiceResponse',
  '2': const [
    const {'1': 'service', '3': 1, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.ManagedService'},
  ],
};

const GetServiceConfigRequest$json = const {
  '1': 'GetServiceConfigRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'config_id', '3': 2, '4': 1, '5': 9},
  ],
};

const ListServiceConfigsRequest$json = const {
  '1': 'ListServiceConfigsRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
  ],
};

const ListServiceConfigsResponse$json = const {
  '1': 'ListServiceConfigsResponse',
  '2': const [
    const {'1': 'service_configs', '3': 1, '4': 3, '5': 11, '6': '.google.api.Service'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateServiceConfigRequest$json = const {
  '1': 'CreateServiceConfigRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'service_config', '3': 2, '4': 1, '5': 11, '6': '.google.api.Service'},
  ],
};

const SubmitConfigSourceRequest$json = const {
  '1': 'SubmitConfigSourceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'config_source', '3': 2, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.ConfigSource'},
    const {'1': 'validate_only', '3': 3, '4': 1, '5': 8},
  ],
};

const SubmitConfigSourceResponse$json = const {
  '1': 'SubmitConfigSourceResponse',
  '2': const [
    const {'1': 'service_config', '3': 1, '4': 1, '5': 11, '6': '.google.api.Service'},
  ],
};

const CreateServiceRolloutRequest$json = const {
  '1': 'CreateServiceRolloutRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'rollout', '3': 2, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.Rollout'},
  ],
};

const ListServiceRolloutsRequest$json = const {
  '1': 'ListServiceRolloutsRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
  ],
};

const ListServiceRolloutsResponse$json = const {
  '1': 'ListServiceRolloutsResponse',
  '2': const [
    const {'1': 'rollouts', '3': 1, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.Rollout'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetServiceRolloutRequest$json = const {
  '1': 'GetServiceRolloutRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'rollout_id', '3': 2, '4': 1, '5': 9},
  ],
};

const EnableServiceRequest$json = const {
  '1': 'EnableServiceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'consumer_id', '3': 2, '4': 1, '5': 9},
  ],
};

const DisableServiceRequest$json = const {
  '1': 'DisableServiceRequest',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'consumer_id', '3': 2, '4': 1, '5': 9},
  ],
};

const GenerateConfigReportRequest$json = const {
  '1': 'GenerateConfigReportRequest',
  '2': const [
    const {'1': 'new_config', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
    const {'1': 'old_config', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
  ],
};

const GenerateConfigReportResponse$json = const {
  '1': 'GenerateConfigReportResponse',
  '2': const [
    const {'1': 'service_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'id', '3': 2, '4': 1, '5': 9},
    const {'1': 'change_reports', '3': 3, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.ChangeReport'},
    const {'1': 'diagnostics', '3': 4, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.Diagnostic'},
  ],
};

const ServiceManager$json = const {
  '1': 'ServiceManager',
  '2': const [
    const {'1': 'ListServices', '2': '.google.api.servicemanagement.v1.ListServicesRequest', '3': '.google.api.servicemanagement.v1.ListServicesResponse', '4': const {}},
    const {'1': 'GetService', '2': '.google.api.servicemanagement.v1.GetServiceRequest', '3': '.google.api.servicemanagement.v1.ManagedService', '4': const {}},
    const {'1': 'CreateService', '2': '.google.api.servicemanagement.v1.CreateServiceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteService', '2': '.google.api.servicemanagement.v1.DeleteServiceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'UndeleteService', '2': '.google.api.servicemanagement.v1.UndeleteServiceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'ListServiceConfigs', '2': '.google.api.servicemanagement.v1.ListServiceConfigsRequest', '3': '.google.api.servicemanagement.v1.ListServiceConfigsResponse', '4': const {}},
    const {'1': 'GetServiceConfig', '2': '.google.api.servicemanagement.v1.GetServiceConfigRequest', '3': '.google.api.Service', '4': const {}},
    const {'1': 'CreateServiceConfig', '2': '.google.api.servicemanagement.v1.CreateServiceConfigRequest', '3': '.google.api.Service', '4': const {}},
    const {'1': 'SubmitConfigSource', '2': '.google.api.servicemanagement.v1.SubmitConfigSourceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'ListServiceRollouts', '2': '.google.api.servicemanagement.v1.ListServiceRolloutsRequest', '3': '.google.api.servicemanagement.v1.ListServiceRolloutsResponse', '4': const {}},
    const {'1': 'GetServiceRollout', '2': '.google.api.servicemanagement.v1.GetServiceRolloutRequest', '3': '.google.api.servicemanagement.v1.Rollout', '4': const {}},
    const {'1': 'CreateServiceRollout', '2': '.google.api.servicemanagement.v1.CreateServiceRolloutRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GenerateConfigReport', '2': '.google.api.servicemanagement.v1.GenerateConfigReportRequest', '3': '.google.api.servicemanagement.v1.GenerateConfigReportResponse', '4': const {}},
    const {'1': 'EnableService', '2': '.google.api.servicemanagement.v1.EnableServiceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DisableService', '2': '.google.api.servicemanagement.v1.DisableServiceRequest', '3': '.google.longrunning.Operation', '4': const {}},
  ],
};

const ServiceManager$messageJson = const {
  '.google.api.servicemanagement.v1.ListServicesRequest': ListServicesRequest$json,
  '.google.api.servicemanagement.v1.ListServicesResponse': ListServicesResponse$json,
  '.google.api.servicemanagement.v1.ManagedService': ManagedService$json,
  '.google.api.servicemanagement.v1.GetServiceRequest': GetServiceRequest$json,
  '.google.api.servicemanagement.v1.CreateServiceRequest': CreateServiceRequest$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.api.servicemanagement.v1.DeleteServiceRequest': DeleteServiceRequest$json,
  '.google.api.servicemanagement.v1.UndeleteServiceRequest': UndeleteServiceRequest$json,
  '.google.api.servicemanagement.v1.ListServiceConfigsRequest': ListServiceConfigsRequest$json,
  '.google.api.servicemanagement.v1.ListServiceConfigsResponse': ListServiceConfigsResponse$json,
  '.google.api.Service': google$api.Service$json,
  '.google.protobuf.Api': google$protobuf.Api$json,
  '.google.protobuf.Method': google$protobuf.Method$json,
  '.google.protobuf.Option': google$protobuf.Option$json,
  '.google.protobuf.SourceContext': google$protobuf.SourceContext$json,
  '.google.protobuf.Mixin': google$protobuf.Mixin$json,
  '.google.protobuf.Type': google$protobuf.Type$json,
  '.google.protobuf.Field': google$protobuf.Field$json,
  '.google.protobuf.Enum': google$protobuf.Enum$json,
  '.google.protobuf.EnumValue': google$protobuf.EnumValue$json,
  '.google.api.Documentation': google$api.Documentation$json,
  '.google.api.DocumentationRule': google$api.DocumentationRule$json,
  '.google.api.Page': google$api.Page$json,
  '.google.api.Backend': google$api.Backend$json,
  '.google.api.BackendRule': google$api.BackendRule$json,
  '.google.api.Http': google$api.Http$json,
  '.google.api.HttpRule': google$api.HttpRule$json,
  '.google.api.CustomHttpPattern': google$api.CustomHttpPattern$json,
  '.google.api.Authentication': google$api.Authentication$json,
  '.google.api.AuthenticationRule': google$api.AuthenticationRule$json,
  '.google.api.OAuthRequirements': google$api.OAuthRequirements$json,
  '.google.api.AuthRequirement': google$api.AuthRequirement$json,
  '.google.api.AuthProvider': google$api.AuthProvider$json,
  '.google.api.Context': google$api.Context$json,
  '.google.api.ContextRule': google$api.ContextRule$json,
  '.google.api.Usage': google$api.Usage$json,
  '.google.api.UsageRule': google$api.UsageRule$json,
  '.google.api.Endpoint': google$api.Endpoint$json,
  '.google.protobuf.UInt32Value': google$protobuf.UInt32Value$json,
  '.google.api.Control': google$api.Control$json,
  '.google.api.LogDescriptor': google$api.LogDescriptor$json,
  '.google.api.LabelDescriptor': google$api.LabelDescriptor$json,
  '.google.api.MetricDescriptor': google$api.MetricDescriptor$json,
  '.google.api.MonitoredResourceDescriptor': google$api.MonitoredResourceDescriptor$json,
  '.google.api.Logging': google$api.Logging$json,
  '.google.api.Logging.LoggingDestination': google$api.Logging_LoggingDestination$json,
  '.google.api.Monitoring': google$api.Monitoring$json,
  '.google.api.Monitoring.MonitoringDestination': google$api.Monitoring_MonitoringDestination$json,
  '.google.api.SystemParameters': google$api.SystemParameters$json,
  '.google.api.SystemParameterRule': google$api.SystemParameterRule$json,
  '.google.api.SystemParameter': google$api.SystemParameter$json,
  '.google.api.Experimental': google$api.Experimental$json,
  '.google.api.AuthorizationConfig': google$api.AuthorizationConfig$json,
  '.google.api.servicemanagement.v1.GetServiceConfigRequest': GetServiceConfigRequest$json,
  '.google.api.servicemanagement.v1.CreateServiceConfigRequest': CreateServiceConfigRequest$json,
  '.google.api.servicemanagement.v1.SubmitConfigSourceRequest': SubmitConfigSourceRequest$json,
  '.google.api.servicemanagement.v1.ConfigSource': ConfigSource$json,
  '.google.api.servicemanagement.v1.ConfigFile': ConfigFile$json,
  '.google.api.servicemanagement.v1.ListServiceRolloutsRequest': ListServiceRolloutsRequest$json,
  '.google.api.servicemanagement.v1.ListServiceRolloutsResponse': ListServiceRolloutsResponse$json,
  '.google.api.servicemanagement.v1.Rollout': Rollout$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.api.servicemanagement.v1.Rollout.TrafficPercentStrategy': Rollout_TrafficPercentStrategy$json,
  '.google.api.servicemanagement.v1.Rollout.TrafficPercentStrategy.PercentagesEntry': Rollout_TrafficPercentStrategy_PercentagesEntry$json,
  '.google.api.servicemanagement.v1.Rollout.DeleteServiceStrategy': Rollout_DeleteServiceStrategy$json,
  '.google.api.servicemanagement.v1.GetServiceRolloutRequest': GetServiceRolloutRequest$json,
  '.google.api.servicemanagement.v1.CreateServiceRolloutRequest': CreateServiceRolloutRequest$json,
  '.google.api.servicemanagement.v1.GenerateConfigReportRequest': GenerateConfigReportRequest$json,
  '.google.api.servicemanagement.v1.GenerateConfigReportResponse': GenerateConfigReportResponse$json,
  '.google.api.servicemanagement.v1.ChangeReport': ChangeReport$json,
  '.google.api.ConfigChange': google$api.ConfigChange$json,
  '.google.api.Advice': google$api.Advice$json,
  '.google.api.servicemanagement.v1.Diagnostic': Diagnostic$json,
  '.google.api.servicemanagement.v1.EnableServiceRequest': EnableServiceRequest$json,
  '.google.api.servicemanagement.v1.DisableServiceRequest': DisableServiceRequest$json,
};

