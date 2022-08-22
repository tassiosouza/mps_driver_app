/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the MRoute type in your schema. */
@immutable
class MRoute extends Model {
  static const classType = const _MRouteModelType();
  final String id;
  final double? _cost;
  final double? _startTime;
  final double? _endTime;
  final RouteStatus? _status;
  final String? _name;
  final List<MOrder>? _orders;
  final Driver? _driver;
  final int? _distance;
  final int? _duration;
  final String? _location;
  final String? _routePlanName;
  final double? _routeDate;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _mRouteDriverId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  double? get cost {
    return _cost;
  }
  
  double? get startTime {
    return _startTime;
  }
  
  double? get endTime {
    return _endTime;
  }
  
  RouteStatus? get status {
    return _status;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<MOrder>? get orders {
    return _orders;
  }
  
  Driver? get driver {
    return _driver;
  }
  
  int? get distance {
    return _distance;
  }
  
  int? get duration {
    return _duration;
  }
  
  String? get location {
    return _location;
  }
  
  String? get routePlanName {
    return _routePlanName;
  }
  
  double? get routeDate {
    return _routeDate;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get mRouteDriverId {
    return _mRouteDriverId;
  }
  
  const MRoute._internal({required this.id, cost, startTime, endTime, status, required name, orders, driver, distance, duration, location, routePlanName, routeDate, createdAt, updatedAt, mRouteDriverId}): _cost = cost, _startTime = startTime, _endTime = endTime, _status = status, _name = name, _orders = orders, _driver = driver, _distance = distance, _duration = duration, _location = location, _routePlanName = routePlanName, _routeDate = routeDate, _createdAt = createdAt, _updatedAt = updatedAt, _mRouteDriverId = mRouteDriverId;
  
  factory MRoute({String? id, double? cost, double? startTime, double? endTime, RouteStatus? status, required String name, List<MOrder>? orders, Driver? driver, int? distance, int? duration, String? location, String? routePlanName, double? routeDate, String? mRouteDriverId}) {
    return MRoute._internal(
      id: id == null ? UUID.getUUID() : id,
      cost: cost,
      startTime: startTime,
      endTime: endTime,
      status: status,
      name: name,
      orders: orders != null ? List<MOrder>.unmodifiable(orders) : orders,
      driver: driver,
      distance: distance,
      duration: duration,
      location: location,
      routePlanName: routePlanName,
      routeDate: routeDate,
      mRouteDriverId: mRouteDriverId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MRoute &&
      id == other.id &&
      _cost == other._cost &&
      _startTime == other._startTime &&
      _endTime == other._endTime &&
      _status == other._status &&
      _name == other._name &&
      DeepCollectionEquality().equals(_orders, other._orders) &&
      _driver == other._driver &&
      _distance == other._distance &&
      _duration == other._duration &&
      _location == other._location &&
      _routePlanName == other._routePlanName &&
      _routeDate == other._routeDate &&
      _mRouteDriverId == other._mRouteDriverId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MRoute {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("cost=" + (_cost != null ? _cost!.toString() : "null") + ", ");
    buffer.write("startTime=" + (_startTime != null ? _startTime!.toString() : "null") + ", ");
    buffer.write("endTime=" + (_endTime != null ? _endTime!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("distance=" + (_distance != null ? _distance!.toString() : "null") + ", ");
    buffer.write("duration=" + (_duration != null ? _duration!.toString() : "null") + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("routePlanName=" + "$_routePlanName" + ", ");
    buffer.write("routeDate=" + (_routeDate != null ? _routeDate!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("mRouteDriverId=" + "$_mRouteDriverId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MRoute copyWith({String? id, double? cost, double? startTime, double? endTime, RouteStatus? status, String? name, List<MOrder>? orders, Driver? driver, int? distance, int? duration, String? location, String? routePlanName, double? routeDate, String? mRouteDriverId}) {
    return MRoute._internal(
      id: id ?? this.id,
      cost: cost ?? this.cost,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      name: name ?? this.name,
      orders: orders ?? this.orders,
      driver: driver ?? this.driver,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      routePlanName: routePlanName ?? this.routePlanName,
      routeDate: routeDate ?? this.routeDate,
      mRouteDriverId: mRouteDriverId ?? this.mRouteDriverId);
  }
  
  MRoute.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _cost = (json['cost'] as num?)?.toDouble(),
      _startTime = (json['startTime'] as num?)?.toDouble(),
      _endTime = (json['endTime'] as num?)?.toDouble(),
      _status = enumFromString<RouteStatus>(json['status'], RouteStatus.values),
      _name = json['name'],
      _orders = json['orders'] is List
        ? (json['orders'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => MOrder.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _driver = json['driver']?['serializedData'] != null
        ? Driver.fromJson(new Map<String, dynamic>.from(json['driver']['serializedData']))
        : null,
      _distance = (json['distance'] as num?)?.toInt(),
      _duration = (json['duration'] as num?)?.toInt(),
      _location = json['location'],
      _routePlanName = json['routePlanName'],
      _routeDate = (json['routeDate'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _mRouteDriverId = json['mRouteDriverId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'cost': _cost, 'startTime': _startTime, 'endTime': _endTime, 'status': enumToString(_status), 'name': _name, 'orders': _orders?.map((MOrder? e) => e?.toJson()).toList(), 'driver': _driver?.toJson(), 'distance': _distance, 'duration': _duration, 'location': _location, 'routePlanName': _routePlanName, 'routeDate': _routeDate, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'mRouteDriverId': _mRouteDriverId
  };

  static final QueryField ID = QueryField(fieldName: "mRoute.id");
  static final QueryField COST = QueryField(fieldName: "cost");
  static final QueryField STARTTIME = QueryField(fieldName: "startTime");
  static final QueryField ENDTIME = QueryField(fieldName: "endTime");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ORDERS = QueryField(
    fieldName: "orders",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (MOrder).toString()));
  static final QueryField DRIVER = QueryField(
    fieldName: "driver",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Driver).toString()));
  static final QueryField DISTANCE = QueryField(fieldName: "distance");
  static final QueryField DURATION = QueryField(fieldName: "duration");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField ROUTEPLANNAME = QueryField(fieldName: "routePlanName");
  static final QueryField ROUTEDATE = QueryField(fieldName: "routeDate");
  static final QueryField MROUTEDRIVERID = QueryField(fieldName: "mRouteDriverId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MRoute";
    modelSchemaDefinition.pluralName = "MRoutes";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.COST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.STARTTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.ENDTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: MRoute.ORDERS,
      isRequired: false,
      ofModelName: (MOrder).toString(),
      associatedKey: MOrder.ROUTEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: MRoute.DRIVER,
      isRequired: false,
      ofModelName: (Driver).toString(),
      associatedKey: Driver.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.DISTANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.DURATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.ROUTEPLANNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.ROUTEDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MRoute.MROUTEDRIVERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MRouteModelType extends ModelType<MRoute> {
  const _MRouteModelType();
  
  @override
  MRoute fromJson(Map<String, dynamic> jsonData) {
    return MRoute.fromJson(jsonData);
  }
}