// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Client on _Client, Store {
  late final _$checkAtom = Atom(name: '_Client.check', context: context);

  @override
  bool get check {
    _$checkAtom.reportRead();
    return super.check;
  }

  @override
  set check(bool value) {
    _$checkAtom.reportWrite(value, super.check, () {
      super.check = value;
    });
  }

  late final _$_ClientActionController =
      ActionController(name: '_Client', context: context);

  @override
  dynamic setCheck(bool isCheck) {
    final _$actionInfo =
        _$_ClientActionController.startAction(name: '_Client.setCheck');
    try {
      return super.setCheck(isCheck);
    } finally {
      _$_ClientActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
check: ${check}
    ''';
  }
}
