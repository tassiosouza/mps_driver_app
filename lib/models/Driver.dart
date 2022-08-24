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


/** This is an auto generated class representing the Driver type in your schema. */
@immutable
class Driver extends Model {
  static const classType = const _DriverModelType();
  final String id;
  final String? _name;
  final String? _email;
  final String? _phone;
  final int? _carCapacity;
  final String? _owner;
  final bool? _onBoard;
  final bool? _status;
  final double? _latitude;
  final double? _longitude;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get phone {
    return _phone;
  }
  
  int? get carCapacity {
    return _carCapacity;
  }
  
  String get owner {
    try {
      return _owner!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get onBoard {
    return _onBoard;
  }
  
  bool? get status {
    return _status;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  double? get longitude {
    return _longitude;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Driver._internal({required this.id, required name, required email, phone, carCapacity, required owner, onBoard, status, latitude, longitude, createdAt, updatedAt}): _name = name, _email = email, _phone = phone, _carCapacity = carCapacity, _owner = owner, _onBoard = onBoard, _status = status, _latitude = latitude, _longitude = longitude, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Driver({String? id, required String name, required String email, String? phone, int? carCapacity, required String owner, bool? onBoard, bool? status, double? latitude, double? longitude}) {
    return Driver._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      email: email,
      phone: phone,
      carCapacity: carCapacity,
      owner: owner,
      onBoard: onBoard,
      status: status,
      latitude: latitude,
      longitude: longitude);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Driver &&
      id == other.id &&
      _name == other._name &&
      _email == other._email &&
      _phone == other._phone &&
      _carCapacity == other._carCapacity &&
      _owner == other._owner &&
      _onBoard == other._onBoard &&
      _status == other._status &&
      _latitude == other._latitude &&
      _longitude == other._longitude;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Driver {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("carCapacity=" + (_carCapacity != null ? _carCapacity!.toString() : "null") + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("onBoard=" + (_onBoard != null ? _onBoard!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? _status!.toString() : "null") + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Driver copyWith({String? id, String? name, String? email, String? phone, int? carCapacity, String? owner, bool? onBoard, bool? status, double? latitude, double? longitude}) {
    return Driver._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      carCapacity: carCapacity ?? this.carCapacity,
      owner: owner ?? this.owner,
      onBoard: onBoard ?? this.onBoard,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude);
  }
  
  Driver.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _email = json['email'],
      _phone = json['phone'],
      _carCapacity = (json['carCapacity'] as num?)?.toInt(),
      _owner = json['owner'],
      _onBoard = json['onBoard'],
      _status = json['status'],
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'email': _email, 'phone': _phone, 'carCapacity': _carCapacity, 'owner': _owner, 'onBoard': _onBoard, 'status': _status, 'latitude': _latitude, 'longitude': _longitude, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "driver.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField CARCAPACITY = QueryField(fieldName: "carCapacity");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField ONBOARD = QueryField(fieldName: "onBoard");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Driver";
    modelSchemaDefinition.pluralName = "Drivers";
    
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
      key: Driver.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.CARCAPACITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.OWNER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.ONBOARD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Driver.LONGITUDE,
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
  });
}

class _DriverModelType extends ModelType<Driver> {
  const _DriverModelType();
  
  @override
  Driver fromJson(Map<String, dynamic> jsonData) {
    return Driver.fromJson(jsonData);
  }
}