// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RouteViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteViewModel on _RouteViewModel, Store {
  late final _$endAddressAtom =
      Atom(name: '_RouteViewModel.endAddress', context: context);

  @override
  Observable<String> get endAddress {
    _$endAddressAtom.reportRead();
    return super.endAddress;
  }

  @override
  set endAddress(Observable<String> value) {
    _$endAddressAtom.reportWrite(value, super.endAddress, () {
      super.endAddress = value;
    });
  }

  late final _$_RouteViewModelActionController =
      ActionController(name: '_RouteViewModel', context: context);

  @override
  dynamic setEndAddress(String address) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setEndAddress');
    try {
      return super.setEndAddress(address);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFirstEndAddress() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setFirstEndAddress');
    try {
      return super.setFirstEndAddress();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
endAddress: ${endAddress}
    ''';
  }
}
