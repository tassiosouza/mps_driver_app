// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModel, Store {
  late final _$chosenMapAtom =
      Atom(name: '_ProfileViewModel.chosenMap', context: context);

  @override
  Observable<AvailableMap> get chosenMap {
    _$chosenMapAtom.reportRead();
    return super.chosenMap;
  }

  @override
  set chosenMap(Observable<AvailableMap> value) {
    _$chosenMapAtom.reportWrite(value, super.chosenMap, () {
      super.chosenMap = value;
    });
  }

  late final _$chosenMapsListAtom =
      Atom(name: '_ProfileViewModel.chosenMapsList', context: context);

  @override
  ObservableList<dynamic> get chosenMapsList {
    _$chosenMapsListAtom.reportRead();
    return super.chosenMapsList;
  }

  @override
  set chosenMapsList(ObservableList<dynamic> value) {
    _$chosenMapsListAtom.reportWrite(value, super.chosenMapsList, () {
      super.chosenMapsList = value;
    });
  }

  late final _$setDefaultMapAsyncAction =
      AsyncAction('_ProfileViewModel.setDefaultMap', context: context);

  @override
  Future setDefaultMap() {
    return _$setDefaultMapAsyncAction.run(() => super.setDefaultMap());
  }

  late final _$getMapOptionsAsyncAction =
      AsyncAction('_ProfileViewModel.getMapOptions', context: context);

  @override
  Future getMapOptions() {
    return _$getMapOptionsAsyncAction.run(() => super.getMapOptions());
  }

  late final _$_ProfileViewModelActionController =
      ActionController(name: '_ProfileViewModel', context: context);

  @override
  dynamic setChosenMap(AvailableMap map) {
    final _$actionInfo = _$_ProfileViewModelActionController.startAction(
        name: '_ProfileViewModel.setChosenMap');
    try {
      return super.setChosenMap(map);
    } finally {
      _$_ProfileViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chosenMap: ${chosenMap},
chosenMapsList: ${chosenMapsList}
    ''';
  }
}
