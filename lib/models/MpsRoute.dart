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


/** This is an auto generated class representing the MpsRoute type in your schema. */
@immutable
class MpsRoute extends Model {
  static const classType = const _MpsRouteModelType();
  final String id;
  final double? _cost;
  final TemporalTimestamp? _startTime;
  final TemporalTimestamp? _endTime;
  final RouteStatus? _status;
  final String? _name;
  final List<MpsOrder>? _orders;
  final Driver? _driver;
  final int? _distance;
  final int? _duration;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _mpsRouteDriverId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  double? get cost {
    return _cost;
  }
  
  TemporalTimestamp? get startTime {
    return _startTime;
  }
  
  TemporalTimestamp? get endTime {
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
  
  List<MpsOrder>? get orders {
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
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get mpsRouteDriverId {
    return _mpsRouteDriverId;
  }
  
  const MpsRoute._internal({required this.id, cost, startTime, endTime, status, required name, orders, driver, distance, duration, createdAt, updatedAt, mpsRouteDriverId}): _cost = cost, _startTime = startTime, _endTime = endTime, _status = status, _name = name, _orders = orders, _driver = driver, _distance = distance, _duration = duration, _createdAt = createdAt, _updatedAt = updatedAt, _mpsRouteDriverId = mpsRouteDriverId;
  
  factory MpsRoute({String? id, double? cost, TemporalTimestamp? startTime, TemporalTimestamp? endTime, RouteStatus? status, required String name, List<MpsOrder>? orders, Driver? driver, int? distance, int? duration, String? mpsRouteDriverId}) {
    return MpsRoute._internal(
      id: id == null ? UUID.getUUID() : id,
      cost: cost,
      startTime: startTime,
      endTime: endTime,
      status: status,
      name: name,
      orders: orders != null ? List<MpsOrder>.unmodifiable(orders) : orders,
      driver: driver,
      distance: distance,
      duration: duration,
      mpsRouteDriverId: mpsRouteDriverId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MpsRoute &&
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
      _mpsRouteDriverId == other._mpsRouteDriverId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MpsRoute {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("cost=" + (_cost != null ? _cost!.toString() : "null") + ", ");
    buffer.write("startTime=" + (_startTime != null ? _startTime!.toString() : "null") + ", ");
    buffer.write("endTime=" + (_endTime != null ? _endTime!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("distance=" + (_distance != null ? _distance!.toString() : "null") + ", ");
    buffer.write("duration=" + (_duration != null ? _duration!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("mpsRouteDriverId=" + "$_mpsRouteDriverId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MpsRoute copyWith({String? id, double? cost, TemporalTimestamp? startTime, TemporalTimestamp? endTime, RouteStatus? status, String? name, List<MpsOrder>? orders, Driver? driver, int? distance, int? duration, String? mpsRouteDriverId}) {
    return MpsRoute._internal(
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
      mpsRouteDriverId: mpsRouteDriverId ?? this.mpsRouteDriverId);
  }
  
  MpsRoute.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _cost = (json['cost'] as num?)?.toDouble(),
      _startTime = json['startTime'] != null ? TemporalTimestamp.fromSeconds(json['startTime']) : null,
      _endTime = json['endTime'] != null ? TemporalTimestamp.fromSeconds(json['endTime']) : null,
      _status = enumFromString<RouteStatus>(json['status'], RouteStatus.values),
      _name = json['name'],
      _orders = json['orders'] is List
        ? (json['orders'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => MpsOrder.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _driver = json['driver']?['serializedData'] != null
        ? Driver.fromJson(new Map<String, dynamic>.from(json['driver']['serializedData']))
        : null,
      _distance = (json['distance'] as num?)?.toInt(),
      _duration = (json['duration'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _mpsRouteDriverId = json['mpsRouteDriverId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'cost': _cost, 'startTime': _startTime?.toSeconds(), 'endTime': _endTime?.toSeconds(), 'status': enumToString(_status), 'name': _name, 'orders': _orders?.map((MpsOrder? e) => e?.toJson()).toList(), 'driver': _driver?.toJson(), 'distance': _distance, 'duration': _duration, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'mpsRouteDriverId': _mpsRouteDriverId
  };

  static final QueryField ID = QueryField(fieldName: "mpsRoute.id");
  static final QueryField COST = QueryField(fieldName: "cost");
  static final QueryField STARTTIME = QueryField(fieldName: "startTime");
  static final QueryField ENDTIME = QueryField(fieldName: "endTime");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ORDERS = QueryField(
    fieldName: "orders",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (MpsOrder).toString()));
  static final QueryField DRIVER = QueryField(
    fieldName: "driver",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Driver).toString()));
  static final QueryField DISTANCE = QueryField(fieldName: "distance");
  static final QueryField DURATION = QueryField(fieldName: "duration");
  static final QueryField MPSROUTEDRIVERID = QueryField(fieldName: "mpsRouteDriverId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MpsRoute";
    modelSchemaDefinition.pluralName = "MpsRoutes";
    
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
      key: MpsRoute.COST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.STARTTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.ENDTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: MpsRoute.ORDERS,
      isRequired: false,
      ofModelName: (MpsOrder).toString(),
      associatedKey: MpsOrder.ROUTEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: MpsRoute.DRIVER,
      isRequired: false,
      ofModelName: (Driver).toString(),
      associatedKey: Driver.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.DISTANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsRoute.DURATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
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
      key: MpsRoute.MPSROUTEDRIVERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MpsRouteModelType extends ModelType<MpsRoute> {
  const _MpsRouteModelType();
  
  @override
  MpsRoute fromJson(Map<String, dynamic> jsonData) {
    return MpsRoute.fromJson(jsonData);
  }
}