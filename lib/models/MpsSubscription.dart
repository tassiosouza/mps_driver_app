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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the MpsSubscription type in your schema. */
@immutable
class MpsSubscription extends Model {
  static const classType = const _MpsSubscriptionModelType();
  final String id;
  final String? _number;
  final String? _deliveryInstruction;
  final String? _mealPlan;
  final double? _subscriptionDate;
  final String? _address;
  final String? _status;
  final String? _name;
  final String? _email;
  final String? _phone;
  final double? _latitude;
  final double? _longitude;
  final String? _avatar;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  String? get mealPlan {
    return _mealPlan;
  }
  
  double? get subscriptionDate {
    return _subscriptionDate;
  }
  
  String? get address {
    return _address;
  }
  
  String? get status {
    return _status;
  }
  
  String? get name {
    return _name;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phone {
    return _phone;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  double? get longitude {
    return _longitude;
  }
  
  String? get avatar {
    return _avatar;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const MpsSubscription._internal({required this.id, required number, deliveryInstruction, mealPlan, subscriptionDate, address, status, name, email, phone, latitude, longitude, avatar, createdAt, updatedAt}): _number = number, _deliveryInstruction = deliveryInstruction, _mealPlan = mealPlan, _subscriptionDate = subscriptionDate, _address = address, _status = status, _name = name, _email = email, _phone = phone, _latitude = latitude, _longitude = longitude, _avatar = avatar, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MpsSubscription({String? id, required String number, String? deliveryInstruction, String? mealPlan, double? subscriptionDate, String? address, String? status, String? name, String? email, String? phone, double? latitude, double? longitude, String? avatar}) {
    return MpsSubscription._internal(
      id: id == null ? UUID.getUUID() : id,
      number: number,
      deliveryInstruction: deliveryInstruction,
      mealPlan: mealPlan,
      subscriptionDate: subscriptionDate,
      address: address,
      status: status,
      name: name,
      email: email,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
      avatar: avatar);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MpsSubscription &&
      id == other.id &&
      _number == other._number &&
      _deliveryInstruction == other._deliveryInstruction &&
      _mealPlan == other._mealPlan &&
      _subscriptionDate == other._subscriptionDate &&
      _address == other._address &&
      _status == other._status &&
      _name == other._name &&
      _email == other._email &&
      _phone == other._phone &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      _avatar == other._avatar;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MpsSubscription {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("deliveryInstruction=" + "$_deliveryInstruction" + ", ");
    buffer.write("mealPlan=" + "$_mealPlan" + ", ");
    buffer.write("subscriptionDate=" + (_subscriptionDate != null ? _subscriptionDate!.toString() : "null") + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("avatar=" + "$_avatar" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MpsSubscription copyWith({String? id, String? number, String? deliveryInstruction, String? mealPlan, double? subscriptionDate, String? address, String? status, String? name, String? email, String? phone, double? latitude, double? longitude, String? avatar}) {
    return MpsSubscription._internal(
      id: id ?? this.id,
      number: number ?? this.number,
      deliveryInstruction: deliveryInstruction ?? this.deliveryInstruction,
      mealPlan: mealPlan ?? this.mealPlan,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
      address: address ?? this.address,
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      avatar: avatar ?? this.avatar);
  }
  
  MpsSubscription.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _number = json['number'],
      _deliveryInstruction = json['deliveryInstruction'],
      _mealPlan = json['mealPlan'],
      _subscriptionDate = (json['subscriptionDate'] as num?)?.toDouble(),
      _address = json['address'],
      _status = json['status'],
      _name = json['name'],
      _email = json['email'],
      _phone = json['phone'],
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _avatar = json['avatar'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'number': _number, 'deliveryInstruction': _deliveryInstruction, 'mealPlan': _mealPlan, 'subscriptionDate': _subscriptionDate, 'address': _address, 'status': _status, 'name': _name, 'email': _email, 'phone': _phone, 'latitude': _latitude, 'longitude': _longitude, 'avatar': _avatar, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "mpsSubscription.id");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField DELIVERYINSTRUCTION = QueryField(fieldName: "deliveryInstruction");
  static final QueryField MEALPLAN = QueryField(fieldName: "mealPlan");
  static final QueryField SUBSCRIPTIONDATE = QueryField(fieldName: "subscriptionDate");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static final QueryField AVATAR = QueryField(fieldName: "avatar");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MpsSubscription";
    modelSchemaDefinition.pluralName = "MpsSubscriptions";
    
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
      key: MpsSubscription.NUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.DELIVERYINSTRUCTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.MEALPLAN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.SUBSCRIPTIONDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.LONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MpsSubscription.AVATAR,
      isRequired: false,
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
  });
}

class _MpsSubscriptionModelType extends ModelType<MpsSubscription> {
  const _MpsSubscriptionModelType();
  
  @override
  MpsSubscription fromJson(Map<String, dynamic> jsonData) {
    return MpsSubscription.fromJson(jsonData);
  }
}