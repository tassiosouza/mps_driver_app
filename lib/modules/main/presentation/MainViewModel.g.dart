// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on _MainViewModel, Store {
  late final _$currentIndexAtom =
      Atom(name: '_MainViewModel.currentIndex', context: context);

  @override
  Observable<int> get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(Observable<int> value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$_MainViewModelActionController =
      ActionController(name: '_MainViewModel', context: context);

  @override
  dynamic setCurrentIndex(int index) {
    final _$actionInfo = _$_MainViewModelActionController.startAction(
        name: '_MainViewModel.setCurrentIndex');
    try {
      return super.setCurrentIndex(index);
    } finally {
      _$_MainViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
