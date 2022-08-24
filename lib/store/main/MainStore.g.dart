// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on _MainStore, Store {
  late final _$errorAtom = Atom(name: '_MainStore.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$currentDriverAtom =
      Atom(name: '_MainStore.currentDriver', context: context);

  @override
  Driver? get currentDriver {
    _$currentDriverAtom.reportRead();
    return super.currentDriver;
  }

  @override
  set currentDriver(Driver? value) {
    _$currentDriverAtom.reportWrite(value, super.currentDriver, () {
      super.currentDriver = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: '_MainStore.currentIndex', context: context);

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

  late final _$retrieveDriverInformationAsyncAction =
      AsyncAction('_MainStore.retrieveDriverInformation', context: context);

  @override
  Future retrieveDriverInformation() {
    return _$retrieveDriverInformationAsyncAction
        .run(() => super.retrieveDriverInformation());
  }

  late final _$clearCurrentDriverAsyncAction =
      AsyncAction('_MainStore.clearCurrentDriver', context: context);

  @override
  Future clearCurrentDriver() {
    return _$clearCurrentDriverAsyncAction
        .run(() => super.clearCurrentDriver());
  }

  late final _$updateDriverInformationAsyncAction =
      AsyncAction('_MainStore.updateDriverInformation', context: context);

  @override
  Future updateDriverInformation(Driver? updatedDriver) {
    return _$updateDriverInformationAsyncAction
        .run(() => super.updateDriverInformation(updatedDriver));
  }

  late final _$_MainStoreActionController =
      ActionController(name: '_MainStore', context: context);

  @override
  dynamic setCurrentIndex(int index) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.setCurrentIndex');
    try {
      return super.setCurrentIndex(index);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
currentDriver: ${currentDriver},
currentIndex: ${currentIndex}
    ''';
  }
}
