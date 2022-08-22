// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RouteStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteStore on _RouteStore, Store {
  late final _$lastActivedRouteAtom =
      Atom(name: '_RouteStore.lastActivedRoute', context: context);

  @override
  MRoute? get lastActivedRoute {
    _$lastActivedRouteAtom.reportRead();
    return super.lastActivedRoute;
  }

  @override
  set lastActivedRoute(MRoute? value) {
    _$lastActivedRouteAtom.reportWrite(value, super.lastActivedRoute, () {
      super.lastActivedRoute = value;
    });
  }

  late final _$isRouteActivedAtom =
      Atom(name: '_RouteStore.isRouteActived', context: context);

  @override
  bool get isRouteActived {
    _$isRouteActivedAtom.reportRead();
    return super.isRouteActived;
  }

  @override
  set isRouteActived(bool value) {
    _$isRouteActivedAtom.reportWrite(value, super.isRouteActived, () {
      super.isRouteActived = value;
    });
  }

  late final _$endAddressAtom =
      Atom(name: '_RouteStore.endAddress', context: context);

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

  late final _$predictionsAtom =
      Atom(name: '_RouteStore.predictions', context: context);

  @override
  ObservableList<dynamic> get predictions {
    _$predictionsAtom.reportRead();
    return super.predictions;
  }

  @override
  set predictions(ObservableList<dynamic> value) {
    _$predictionsAtom.reportWrite(value, super.predictions, () {
      super.predictions = value;
    });
  }

  late final _$_RouteStoreActionController =
      ActionController(name: '_RouteStore', context: context);

  @override
  dynamic setlastActivedRoute(MRoute? route) {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.setlastActivedRoute');
    try {
      return super.setlastActivedRoute(route);
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanLocalData() {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.cleanLocalData');
    try {
      return super.cleanLocalData();
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsRouteActived(bool actived) {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.setIsRouteActived');
    try {
      return super.setIsRouteActived(actived);
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPredictions(List<AutocompletePrediction> predct) {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.addPredictions');
    try {
      return super.addPredictions(predct);
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearPredictions() {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.clearPredictions');
    try {
      return super.clearPredictions();
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEndAddress(String address) {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.setEndAddress');
    try {
      return super.setEndAddress(address);
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastActivedRoute: ${lastActivedRoute},
isRouteActived: ${isRouteActived},
endAddress: ${endAddress},
predictions: ${predictions}
    ''';
  }
}
