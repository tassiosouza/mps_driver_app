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


/** This is an auto generated class representing the MpOrder type in your schema. */
@immutable
class MpOrder extends Model {
  static const classType = const _MpOrderModelType();
  final String id;
  final String? _number;
  final String? _deliveryInstruction;
  final String? _mealsInstruction;
  final MpsOrderStatus? _status;
  final Customer? _customer;
  final int? _eta;
  final String? _routeID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _mpOrderCustomerId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get number {
    try {
      return _number!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get deliveryInstruction {
    return _deliveryInstruction;
  }
  
  String? get mealsInstruction {
    return _mealsInstruction;
  }
  
  MpsOrderStatus? get status {
    return _status;
  }
  
  Customer? get customer {
    return _customer;
  }
  
  int? get eta {
    return _eta;
  }
  
  String get routeID {
    try {
      return _routeID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get mpOrderCustomerId {
    return _mpOrderCustomerId;
  }
  
  const MpOrder._internal({required this.id, required number, deliveryInstruction, mealsInstruction, status, customer, eta, required routeID, createdAt, updatedAt, mpOrderCustomerId}): _number = number, _deliveryInstruction = deliveryInstruction, _mealsInstruction = mealsInstruction, _status = status, _customer = customer, _eta = eta, _routeID = routeID, _createdAt = createdAt, _updatedAt = updatedAt, _mpOrderCustomerId = mpOrderCustomerId;
  
  factory MpOrder({String? id, required String number, String? deliveryInstruction, String? mealsInstruction, MpsOrderStatus? status, Customer? customer, int? eta, required String routeID, String? mpOrderCustomerId}) {
    return MpOrder._internal(
      id: id == null ? UUID.getUUID() : id,
      number: number,
      deliveryInstruction: deliveryInstruction,
      mealsInstruction: mealsInstruction,
      status: status,
      customer: customer,
      eta: eta,
      routeID: routeID,
      mpOrderCustomerId: mpOrderCustomerId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MpOrder &&
      id == other.id &&
      _number == other._number &&
      _deliveryInstruction == other._deliveryInstruction &&
      _mealsInstruction == other._mealsInstruction &&
      _status == other._status &&
      _customer == other._customer &&
      _eta == other._eta &&
      _routeID == other._routeID &&
      _mpOrderCustomerId == other._mpOrderCustomerId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MpOrder {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("deliveryInstruction=" + "$_deliveryInstruction" + ", ");
    buffer.write("mealsInstruction=" + "$_mealsInstruction" + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("eta=" + (_eta != null ? _eta!.toString() : "null") + ", ");
    buffer.write("routeID=" + "$_routeID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("mpOrderCustomerId=" + "$_mpOrderCustomerId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MpOrder copyWith({String? id, String? number, String? deliveryInstruction, String? mealsInstruction, MpsOrderStatus? status, Customer? customer, int? eta, String? routeID, String? mpOrderCustomerId}) {
    return MpOrder._internal(
      id: id ?? this.id,
      number: number ?? this.number,
      deliveryInstruction: deliveryInstruction ?? this.deliveryInstruction,
      mealsInstruction: mealsInstruction ?? this.mealsInstruction,
      status: status ?? this.status,
      customer: customer ?? this.customer,
      eta: eta ?? this.eta,
      routeID: routeID ?? this.routeID,
      mpOrderCustomerId: mpOrderCustomerId ?? this.mpOrderCustomerId);
  }
  
  MpOrder.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _number = json['number'],
      _deliveryInstruction = json['deliveryInstruction'],
      _mealsInstruction = json['mealsInstruction'],
      _status = enumFromString<MpsOrderStatus>(json['status'], MpsOrderStatus.values),
      _customer = json['customer']?['serializedData'] != null
        ? Customer.fromJson(new Map<String, dynamic>.from(json['customer']['serializedData']))
        : null,
      _eta = (json['eta'] as num?)?.toInt(),
      _routeID = json['routeID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _mpOrderCustomerId = json['mpOrderCustomerId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'number': _number, 'deliveryInstruction': _deliveryInstruction, 'mealsInstruction': _mealsInstruction, 'status': enumToString(_status), 'customer': _customer?.toJson(), 'eta': _eta, 'routeID': _routeID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'mpOrderCustomerId': _mpOrderCustomerId
  };

  static final QueryField ID = QueryField(fieldName: "mpOrder.id");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField DELIVERYINSTRUCTION = QueryField(fieldName: "deliveryInstruction");
  static final QueryField MEALSINSTRUCTION = QueryField(fieldName: "mealsInstruction");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CUSTOMER = QueryField(
    fieldName: "customer",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Customer).toString()));
  static final QueryField ETA = QueryField(fieldName: "eta");
  static final QueryField ROUTEID = QueryField(fieldName: "routeID");
  static final QueryField MPORDERCUSTOMERID = QueryField(fieldName: "mpOrderCustomerId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MpOrder";
    modelSchemaDefinition.pluralName = "MpOrders";
    
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
      key: MpOrder.NUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpOrder.DELIVERYINSTRUCTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpOrder.MEALSINSTRUCTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpOrder.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: MpOrder.CUSTOMER,
      isRequired: false,
      ofModelName: (Customer).toString(),
      associatedKey: Customer.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpOrder.ETA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpOrder.ROUTEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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
      key: MpOrder.MPORDERCUSTOMERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MpOrderModelType extends ModelType<MpOrder> {
  const _MpOrderModelType();
  
  @override
  MpOrder fromJson(Map<String, dynamic> jsonData) {
    return MpOrder.fromJson(jsonData);
  }
}