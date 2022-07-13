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

/** This is an auto generated class representing the Order type in your schema. */
@immutable
class Order extends Model {
  static const classType = const _OrderModelType();
  final String id;
  final String? _number;
  final String? _deliveryInstruction;
  final String? _mealsInstruction;
  final OrderStatus? _status;
  final Customer? _customer;
  final String? _routeID;
  final int? _eta;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _orderCustomerId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String get number {
    try {
      return _number!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String? get deliveryInstruction {
    return _deliveryInstruction;
  }

  String? get mealsInstruction {
    return _mealsInstruction;
  }

  OrderStatus? get status {
    return _status;
  }

  Customer? get customer {
    return _customer;
  }

  String get routeID {
    try {
      return _routeID!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  int? get eta {
    return _eta;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get orderCustomerId {
    return _orderCustomerId;
  }

  const Order._internal(
      {required this.id,
      required number,
      deliveryInstruction,
      mealsInstruction,
      status,
      customer,
      required routeID,
      eta,
      createdAt,
      updatedAt,
      orderCustomerId})
      : _number = number,
        _deliveryInstruction = deliveryInstruction,
        _mealsInstruction = mealsInstruction,
        _status = status,
        _customer = customer,
        _routeID = routeID,
        _eta = eta,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _orderCustomerId = orderCustomerId;

  factory Order(
      {String? id,
      required String number,
      String? deliveryInstruction,
      String? mealsInstruction,
      OrderStatus? status,
      Customer? customer,
      required String routeID,
      int? eta,
      String? orderCustomerId}) {
    return Order._internal(
        id: id == null ? UUID.getUUID() : id,
        number: number,
        deliveryInstruction: deliveryInstruction,
        mealsInstruction: mealsInstruction,
        status: status,
        customer: customer,
        routeID: routeID,
        eta: eta,
        orderCustomerId: orderCustomerId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        id == other.id &&
        _number == other._number &&
        _deliveryInstruction == other._deliveryInstruction &&
        _mealsInstruction == other._mealsInstruction &&
        _status == other._status &&
        _customer == other._customer &&
        _routeID == other._routeID &&
        _eta == other._eta &&
        _orderCustomerId == other._orderCustomerId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Order {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("number=" + "$_number" + ", ");
    buffer.write("deliveryInstruction=" + "$_deliveryInstruction" + ", ");
    buffer.write("mealsInstruction=" + "$_mealsInstruction" + ", ");
    buffer.write(
        "status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("routeID=" + "$_routeID" + ", ");
    buffer.write("eta=" + (_eta != null ? _eta!.toString() : "null") + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("orderCustomerId=" + "$_orderCustomerId");
    buffer.write("}");

    return buffer.toString();
  }

  Order copyWith(
      {String? id,
      String? number,
      String? deliveryInstruction,
      String? mealsInstruction,
      OrderStatus? status,
      Customer? customer,
      String? routeID,
      int? eta,
      String? orderCustomerId}) {
    return Order._internal(
        id: id ?? this.id,
        number: number ?? this.number,
        deliveryInstruction: deliveryInstruction ?? this.deliveryInstruction,
        mealsInstruction: mealsInstruction ?? this.mealsInstruction,
        status: status ?? this.status,
        customer: customer ?? this.customer,
        routeID: routeID ?? this.routeID,
        eta: eta ?? this.eta,
        orderCustomerId: orderCustomerId ?? this.orderCustomerId);
  }

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _number = json['number'],
        _deliveryInstruction = json['deliveryInstruction'],
        _mealsInstruction = json['mealsInstruction'],
        _status =
            enumFromString<OrderStatus>(json['status'], OrderStatus.values),
        _customer = json['customer']?['serializedData'] != null
            ? Customer.fromJson(new Map<String, dynamic>.from(
                json['customer']['serializedData']))
            : null,
        _routeID = json['routeID'],
        _eta = (json['eta'] as num?)?.toInt(),
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _orderCustomerId = json['orderCustomerId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': _number,
        'deliveryInstruction': _deliveryInstruction,
        'mealsInstruction': _mealsInstruction,
        'status': enumToString(_status),
        'customer': _customer?.toJson(),
        'routeID': _routeID,
        'eta': _eta,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'orderCustomerId': _orderCustomerId
      };

  static final QueryField ID = QueryField(fieldName: "order.id");
  static final QueryField NUMBER = QueryField(fieldName: "number");
  static final QueryField DELIVERYINSTRUCTION =
      QueryField(fieldName: "deliveryInstruction");
  static final QueryField MEALSINSTRUCTION =
      QueryField(fieldName: "mealsInstruction");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CUSTOMER = QueryField(
      fieldName: "customer",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Customer).toString()));
  static final QueryField ROUTEID = QueryField(fieldName: "routeID");
  static final QueryField ETA = QueryField(fieldName: "eta");
  static final QueryField ORDERCUSTOMERID =
      QueryField(fieldName: "orderCustomerId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Order";
    modelSchemaDefinition.pluralName = "Orders";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.NUMBER,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.DELIVERYINSTRUCTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.MEALSINSTRUCTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.STATUS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: Order.CUSTOMER,
        isRequired: false,
        ofModelName: (Customer).toString(),
        associatedKey: Customer.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.ROUTEID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.ETA,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.ORDERCUSTOMERID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _OrderModelType extends ModelType<Order> {
  const _OrderModelType();

  @override
  Order fromJson(Map<String, dynamic> jsonData) {
    return Order.fromJson(jsonData);
  }
}
