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


/** This is an auto generated class representing the Customer type in your schema. */
@immutable
class Customer extends Model {
  static const classType = const _CustomerModelType();
  final String id;
  final String? _name;
  final String? _address;
  final String? _plan;
  final String? _phone;
  final String? _owner;
  final Coordinates? _coordinates;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _customerCoordinatesId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  String get address {
    try {
      return _address!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get plan {
    return _plan;
  }
  
  String get phone {
    try {
      return _phone!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get owner {
    return _owner;
  }
  
  Coordinates? get coordinates {
    return _coordinates;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get customerCoordinatesId {
    return _customerCoordinatesId;
  }
  
  const Customer._internal({required this.id, required name, required address, plan, required phone, owner, coordinates, createdAt, updatedAt, customerCoordinatesId}): _name = name, _address = address, _plan = plan, _phone = phone, _owner = owner, _coordinates = coordinates, _createdAt = createdAt, _updatedAt = updatedAt, _customerCoordinatesId = customerCoordinatesId;
  
  factory Customer({String? id, required String name, required String address, String? plan, required String phone, String? owner, Coordinates? coordinates, String? customerCoordinatesId}) {
    return Customer._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      address: address,
      plan: plan,
      phone: phone,
      owner: owner,
      coordinates: coordinates,
      customerCoordinatesId: customerCoordinatesId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Customer &&
      id == other.id &&
      _name == other._name &&
      _address == other._address &&
      _plan == other._plan &&
      _phone == other._phone &&
      _owner == other._owner &&
      _coordinates == other._coordinates &&
      _customerCoordinatesId == other._customerCoordinatesId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Customer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("plan=" + "$_plan" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("customerCoordinatesId=" + "$_customerCoordinatesId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Customer copyWith({String? id, String? name, String? address, String? plan, String? phone, String? owner, Coordinates? coordinates, String? customerCoordinatesId}) {
    return Customer._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      plan: plan ?? this.plan,
      phone: phone ?? this.phone,
      owner: owner ?? this.owner,
      coordinates: coordinates ?? this.coordinates,
      customerCoordinatesId: customerCoordinatesId ?? this.customerCoordinatesId);
  }
  
  Customer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _address = json['address'],
      _plan = json['plan'],
      _phone = json['phone'],
      _owner = json['owner'],
      _coordinates = json['coordinates']?['serializedData'] != null
        ? Coordinates.fromJson(new Map<String, dynamic>.from(json['coordinates']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _customerCoordinatesId = json['customerCoordinatesId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'address': _address, 'plan': _plan, 'phone': _phone, 'owner': _owner, 'coordinates': _coordinates?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'customerCoordinatesId': _customerCoordinatesId
  };

  static final QueryField ID = QueryField(fieldName: "customer.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField PLAN = QueryField(fieldName: "plan");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField COORDINATES = QueryField(
    fieldName: "coordinates",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Coordinates).toString()));
  static final QueryField CUSTOMERCOORDINATESID = QueryField(fieldName: "customerCoordinatesId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Customer";
    modelSchemaDefinition.pluralName = "Customers";
    
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
      key: Customer.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.ADDRESS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.PLAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.PHONE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Customer.OWNER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Customer.COORDINATES,
      isRequired: false,
      ofModelName: (Coordinates).toString(),
      associatedKey: Coordinates.ID
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
      key: Customer.CUSTOMERCOORDINATESID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CustomerModelType extends ModelType<Customer> {
  const _CustomerModelType();
  
  @override
  Customer fromJson(Map<String, dynamic> jsonData) {
    return Customer.fromJson(jsonData);
  }
}