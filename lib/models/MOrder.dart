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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the MOrder type in your schema. */
@immutable
class MOrder extends Model {
  static const classType = const _MOrderModelType();
  final String id;
  final String? _number;
  final String? _deliveryInstruction;
  final String? _mealPlan;
  final OrderStatus? _status;
  final String? _customerName;
  final int? _eta;
  final String? _assignedRouteID;
  final String? _address;
  final double? _latitude;
  final double? _longitude;
  final double? _orderDate;
  final String? _phone;
  final String? _location;
  final int? _sort;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get number {
    return _number;
  }
  
  String? get deliveryInstruction {
    return _deliveryInstruction;
  }
  
  String? get mealPlan {
    return _mealPlan;
  }
  
  OrderStatus? get status {
    return _status;
  }
  
  String? get customerName {
    return _customerName;
  }
  
  int? get eta {
    return _eta;
  }
  
  String? get assignedRouteID {
    return _assignedRouteID;
  }
  
  String? get address {
    return _address;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  double? get longitude {
    return _longitude;
  }
  
  double? get orderDate {
    return _orderDate;
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get location {
    return _location;
  }
  
  int? get sort {
    return _sort;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const MOrder._internal({required this.id, number, deliveryInstruction, mealPlan, status, customerName, eta, assignedRouteID, address, latitude, longitude, orderDate, phone, location, sort, createdAt, updatedAt}): _number = number, _deliveryInstruction = deliveryInstruction, _mealPlan = mealPlan, _status = status, _customerName = customerName, _eta = eta, _assignedRouteID = assignedRouteID, _address = address, _latitude = latitude, _longitude = longitude, _orderDate = orderDate, _phone = phone, _location = location, _sort = sort, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MOrder({String? id, String? number, String? deliveryInstruction, String? mealPlan, OrderStatus? status, String? customerName, int? eta, String? assignedRouteID, String? address, double? latitude, double? longitude, double? orderDate, String? phone, String? location, int? sort}) {
    return MOrder._internal(
      id: id == null ? UUID.getUUID() : id,
      number: number,
      deliveryInstruction: deliveryInstruction,
      mealPlan: mealPlan,
      status: status,
      customerName: customerName,
      eta: eta,
      assignedRouteID: assignedRouteID,
      address: address,
      latitude: latitude,
      longitude: longitude,
      orderDate: orderDate,
      phone: phone,
      location: location,
      sort: sort);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MOrder &&
      id == other.id &&
      _number == other._number &&
      _deliveryInstruction == other._deliveryInstruction &&
      _mealPlan == other._mealPlan &&
      _status == other._status &&
      _customerName == other._customerName &&
      _eta == other._eta &&
      _assignedRouteID == other._assignedRouteID &&
      _address == other._address &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      _orderDate == other._orderDate &&
      _phone == other._phone &&
      _location == other._location &&
      _sort == other._sort;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MOrder {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("deliveryInstruction=" + "$_deliveryInstruction" + ", ");
    buffer.write("mealPlan=" + "$_mealPlan" + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("customerName=" + "$_customerName" + ", ");
    buffer.write("eta=" + (_eta != null ? _eta!.toString() : "null") + ", ");
    buffer.write("assignedRouteID=" + "$_assignedRouteID" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("orderDate=" + (_orderDate != null ? _orderDate!.toString() : "null") + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("sort=" + (_sort != null ? _sort!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MOrder copyWith({String? id, String? number, String? deliveryInstruction, String? mealPlan, OrderStatus? status, String? customerName, int? eta, String? assignedRouteID, String? address, double? latitude, double? longitude, double? orderDate, String? phone, String? location, int? sort}) {
    return MOrder._internal(
      id: id ?? this.id,
      number: number ?? this.number,
      deliveryInstruction: deliveryInstruction ?? this.deliveryInstruction,
      mealPlan: mealPlan ?? this.mealPlan,
      status: status ?? this.status,
      customerName: customerName ?? this.customerName,
      eta: eta ?? this.eta,
      assignedRouteID: assignedRouteID ?? this.assignedRouteID,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      orderDate: orderDate ?? this.orderDate,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      sort: sort ?? this.sort);
  }
  
  MOrder.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _number = json['number'],
      _deliveryInstruction = json['deliveryInstruction'],
      _mealPlan = json['mealPlan'],
      _status = enumFromString<OrderStatus>(json['status'], OrderStatus.values),
      _customerName = json['customerName'],
      _eta = (json['eta'] as num?)?.toInt(),
      _assignedRouteID = json['assignedRouteID'],
      _address = json['address'],
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _orderDate = (json['orderDate'] as num?)?.toDouble(),
      _phone = json['phone'],
      _location = json['location'],
      _sort = (json['sort'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'number': _number, 'deliveryInstruction': _deliveryInstruction, 'mealPlan': _mealPlan, 'status': enumToString(_status), 'customerName': _customerName, 'eta': _eta, 'assignedRouteID': _assignedRouteID, 'address': _address, 'latitude': _latitude, 'longitude': _longitude, 'orderDate': _orderDate, 'phone': _phone, 'location': _location, 'sort': _sort, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "mOrder.id");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField DELIVERYINSTRUCTION = QueryField(fieldName: "deliveryInstruction");
  static final QueryField MEALPLAN = QueryField(fieldName: "mealPlan");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CUSTOMERNAME = QueryField(fieldName: "customerName");
  static final QueryField ETA = QueryField(fieldName: "eta");
  static final QueryField ASSIGNEDROUTEID = QueryField(fieldName: "assignedRouteID");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static final QueryField ORDERDATE = QueryField(fieldName: "orderDate");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField SORT = QueryField(fieldName: "sort");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MOrder";
    modelSchemaDefinition.pluralName = "MOrders";
    
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
      key: MOrder.NUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.DELIVERYINSTRUCTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.MEALPLAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.CUSTOMERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.ETA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.ASSIGNEDROUTEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.LONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.ORDERDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MOrder.SORT,
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
  });
}

class _MOrderModelType extends ModelType<MOrder> {
  const _MOrderModelType();
  
  @override
  MOrder fromJson(Map<String, dynamic> jsonData) {
    return MOrder.fromJson(jsonData);
  }
}