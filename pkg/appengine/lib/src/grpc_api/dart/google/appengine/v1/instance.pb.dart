///
//  Generated code. Do not modify.
///
library google.appengine.v1_instance;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;

import 'instance.pbenum.dart';

export 'instance.pbenum.dart';

class Instance extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Instance')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..a/*<String>*/(3, 'appEngineRelease', PbFieldType.OS)
    ..e/*<Instance_Availability>*/(4, 'availability', PbFieldType.OE, Instance_Availability.UNSPECIFIED, Instance_Availability.valueOf)
    ..a/*<String>*/(5, 'vmName', PbFieldType.OS)
    ..a/*<String>*/(6, 'vmZoneName', PbFieldType.OS)
    ..a/*<String>*/(7, 'vmId', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(8, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<int>*/(9, 'requests', PbFieldType.O3)
    ..a/*<int>*/(10, 'errors', PbFieldType.O3)
    ..a/*<double>*/(11, 'qps', PbFieldType.OF)
    ..a/*<int>*/(12, 'averageLatency', PbFieldType.O3)
    ..a/*<Int64>*/(13, 'memoryUsage', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(14, 'vmStatus', PbFieldType.OS)
    ..a/*<bool>*/(15, 'vmDebugEnabled', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Instance() : super();
  Instance.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Instance.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Instance clone() => new Instance()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Instance create() => new Instance();
  static PbList<Instance> createRepeated() => new PbList<Instance>();
  static Instance getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyInstance();
    return _defaultInstance;
  }
  static Instance _defaultInstance;
  static void $checkItem(Instance v) {
    if (v is !Instance) checkItemFailed(v, 'Instance');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  String get appEngineRelease => $_get(2, 3, '');
  void set appEngineRelease(String v) { $_setString(2, 3, v); }
  bool hasAppEngineRelease() => $_has(2, 3);
  void clearAppEngineRelease() => clearField(3);

  Instance_Availability get availability => $_get(3, 4, null);
  void set availability(Instance_Availability v) { setField(4, v); }
  bool hasAvailability() => $_has(3, 4);
  void clearAvailability() => clearField(4);

  String get vmName => $_get(4, 5, '');
  void set vmName(String v) { $_setString(4, 5, v); }
  bool hasVmName() => $_has(4, 5);
  void clearVmName() => clearField(5);

  String get vmZoneName => $_get(5, 6, '');
  void set vmZoneName(String v) { $_setString(5, 6, v); }
  bool hasVmZoneName() => $_has(5, 6);
  void clearVmZoneName() => clearField(6);

  String get vmId => $_get(6, 7, '');
  void set vmId(String v) { $_setString(6, 7, v); }
  bool hasVmId() => $_has(6, 7);
  void clearVmId() => clearField(7);

  google$protobuf.Timestamp get startTime => $_get(7, 8, null);
  void set startTime(google$protobuf.Timestamp v) { setField(8, v); }
  bool hasStartTime() => $_has(7, 8);
  void clearStartTime() => clearField(8);

  int get requests => $_get(8, 9, 0);
  void set requests(int v) { $_setUnsignedInt32(8, 9, v); }
  bool hasRequests() => $_has(8, 9);
  void clearRequests() => clearField(9);

  int get errors => $_get(9, 10, 0);
  void set errors(int v) { $_setUnsignedInt32(9, 10, v); }
  bool hasErrors() => $_has(9, 10);
  void clearErrors() => clearField(10);

  double get qps => $_get(10, 11, null);
  void set qps(double v) { $_setFloat(10, 11, v); }
  bool hasQps() => $_has(10, 11);
  void clearQps() => clearField(11);

  int get averageLatency => $_get(11, 12, 0);
  void set averageLatency(int v) { $_setUnsignedInt32(11, 12, v); }
  bool hasAverageLatency() => $_has(11, 12);
  void clearAverageLatency() => clearField(12);

  Int64 get memoryUsage => $_get(12, 13, null);
  void set memoryUsage(Int64 v) { $_setInt64(12, 13, v); }
  bool hasMemoryUsage() => $_has(12, 13);
  void clearMemoryUsage() => clearField(13);

  String get vmStatus => $_get(13, 14, '');
  void set vmStatus(String v) { $_setString(13, 14, v); }
  bool hasVmStatus() => $_has(13, 14);
  void clearVmStatus() => clearField(14);

  bool get vmDebugEnabled => $_get(14, 15, false);
  void set vmDebugEnabled(bool v) { $_setBool(14, 15, v); }
  bool hasVmDebugEnabled() => $_has(14, 15);
  void clearVmDebugEnabled() => clearField(15);
}

class _ReadonlyInstance extends Instance with ReadonlyMessageMixin {}

