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


/** This is an auto generated class representing the Route type in your schema. */
@immutable
class Route extends Model {
  static const classType = const _RouteModelType();
  final String id;
  final double? _cost;
  final TemporalTimestamp? _startTime;
  final TemporalTimestamp? _endTime;
  final RouteStatus? _status;
  final List<Order>? _Orders;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  List<Order>? get Orders {
    return _Orders;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Route._internal({required this.id, cost, startTime, endTime, status, Orders, createdAt, updatedAt}): _cost = cost, _startTime = startTime, _endTime = endTime, _status = status, _Orders = Orders, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Route({String? id, double? cost, TemporalTimestamp? startTime, TemporalTimestamp? endTime, RouteStatus? status, List<Order>? Orders}) {
    return Route._internal(
      id: id == null ? UUID.getUUID() : id,
      cost: cost,
      startTime: startTime,
      endTime: endTime,
      status: status,
      Orders: Orders != null ? List<Order>.unmodifiable(Orders) : Orders);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Route &&
      id == other.id &&
      _cost == other._cost &&
      _startTime == other._startTime &&
      _endTime == other._endTime &&
      _status == other._status &&
      DeepCollectionEquality().equals(_Orders, other._Orders);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Route {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("cost=" + (_cost != null ? _cost!.toString() : "null") + ", ");
    buffer.write("startTime=" + (_startTime != null ? _startTime!.toString() : "null") + ", ");
    buffer.write("endTime=" + (_endTime != null ? _endTime!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Route copyWith({String? id, double? cost, TemporalTimestamp? startTime, TemporalTimestamp? endTime, RouteStatus? status, List<Order>? Orders}) {
    return Route._internal(
      id: id ?? this.id,
      cost: cost ?? this.cost,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      Orders: Orders ?? this.Orders);
  }
  
  Route.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _cost = (json['cost'] as num?)?.toDouble(),
      _startTime = json['startTime'] != null ? TemporalTimestamp.fromSeconds(json['startTime']) : null,
      _endTime = json['endTime'] != null ? TemporalTimestamp.fromSeconds(json['endTime']) : null,
      _status = enumFromString<RouteStatus>(json['status'], RouteStatus.values),
      _Orders = json['Orders'] is List
        ? (json['Orders'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Order.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'cost': _cost, 'startTime': _startTime?.toSeconds(), 'endTime': _endTime?.toSeconds(), 'status': enumToString(_status), 'Orders': _Orders?.map((Order? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "route.id");
  static final QueryField COST = QueryField(fieldName: "cost");
  static final QueryField STARTTIME = QueryField(fieldName: "startTime");
  static final QueryField ENDTIME = QueryField(fieldName: "endTime");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField ORDERS = QueryField(
    fieldName: "Orders",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Order).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Route";
    modelSchemaDefinition.pluralName = "Routes";
    
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
      key: Route.COST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Route.STARTTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Route.ENDTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Route.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Route.ORDERS,
      isRequired: false,
      ofModelName: (Order).toString(),
      associatedKey: Order.ROUTEID
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
  });
}

class _RouteModelType extends ModelType<Route> {
  const _RouteModelType();
  
  @override
  Route fromJson(Map<String, dynamic> jsonData) {
    return Route.fromJson(jsonData);
  }
}