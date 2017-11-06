///
//  Generated code. Do not modify.
///
library google.api_monitored_resource;

import 'package:protobuf/protobuf.dart';

import 'label.pb.dart';

class MonitoredResourceDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MonitoredResourceDescriptor')
    ..a/*<String>*/(1, 'type', PbFieldType.OS)
    ..a/*<String>*/(2, 'displayName', PbFieldType.OS)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..pp/*<LabelDescriptor>*/(4, 'labels', PbFieldType.PM, LabelDescriptor.$checkItem, LabelDescriptor.create)
    ..a/*<String>*/(5, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MonitoredResourceDescriptor() : super();
  MonitoredResourceDescriptor.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MonitoredResourceDescriptor.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MonitoredResourceDescriptor clone() => new MonitoredResourceDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResourceDescriptor create() => new MonitoredResourceDescriptor();
  static PbList<MonitoredResourceDescriptor> createRepeated() => new PbList<MonitoredResourceDescriptor>();
  static MonitoredResourceDescriptor getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMonitoredResourceDescriptor();
    return _defaultInstance;
  }
  static MonitoredResourceDescriptor _defaultInstance;
  static void $checkItem(MonitoredResourceDescriptor v) {
    if (v is !MonitoredResourceDescriptor) checkItemFailed(v, 'MonitoredResourceDescriptor');
  }

  String get type => $_get(0, 1, '');
  void set type(String v) { $_setString(0, 1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  String get displayName => $_get(1, 2, '');
  void set displayName(String v) { $_setString(1, 2, v); }
  bool hasDisplayName() => $_has(1, 2);
  void clearDisplayName() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);

  List<LabelDescriptor> get labels => $_get(3, 4, null);

  String get name => $_get(4, 5, '');
  void set name(String v) { $_setString(4, 5, v); }
  bool hasName() => $_has(4, 5);
  void clearName() => clearField(5);
}

class _ReadonlyMonitoredResourceDescriptor extends MonitoredResourceDescriptor with ReadonlyMessageMixin {}

class MonitoredResource_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MonitoredResource_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  MonitoredResource_LabelsEntry() : super();
  MonitoredResource_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MonitoredResource_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MonitoredResource_LabelsEntry clone() => new MonitoredResource_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResource_LabelsEntry create() => new MonitoredResource_LabelsEntry();
  static PbList<MonitoredResource_LabelsEntry> createRepeated() => new PbList<MonitoredResource_LabelsEntry>();
  static MonitoredResource_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMonitoredResource_LabelsEntry();
    return _defaultInstance;
  }
  static MonitoredResource_LabelsEntry _defaultInstance;
  static void $checkItem(MonitoredResource_LabelsEntry v) {
    if (v is !MonitoredResource_LabelsEntry) checkItemFailed(v, 'MonitoredResource_LabelsEntry');
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

class _ReadonlyMonitoredResource_LabelsEntry extends MonitoredResource_LabelsEntry with ReadonlyMessageMixin {}

class MonitoredResource extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MonitoredResource')
    ..a/*<String>*/(1, 'type', PbFieldType.OS)
    ..pp/*<MonitoredResource_LabelsEntry>*/(2, 'labels', PbFieldType.PM, MonitoredResource_LabelsEntry.$checkItem, MonitoredResource_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  MonitoredResource() : super();
  MonitoredResource.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MonitoredResource.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MonitoredResource clone() => new MonitoredResource()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResource create() => new MonitoredResource();
  static PbList<MonitoredResource> createRepeated() => new PbList<MonitoredResource>();
  static MonitoredResource getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMonitoredResource();
    return _defaultInstance;
  }
  static MonitoredResource _defaultInstance;
  static void $checkItem(MonitoredResource v) {
    if (v is !MonitoredResource) checkItemFailed(v, 'MonitoredResource');
  }

  String get type => $_get(0, 1, '');
  void set type(String v) { $_setString(0, 1, v); }
  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  List<MonitoredResource_LabelsEntry> get labels => $_get(1, 2, null);
}

class _ReadonlyMonitoredResource extends MonitoredResource with ReadonlyMessageMixin {}

