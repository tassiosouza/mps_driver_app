// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RouteViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteViewModel on _RouteViewModel, Store {
  late final _$lastActivedRouteAtom =
      Atom(name: '_RouteViewModel.lastActivedRoute', context: context);

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

  late final _$routesHistoryAtom =
      Atom(name: '_RouteViewModel.routesHistory', context: context);

  @override
  List<MRoute>? get routesHistory {
    _$routesHistoryAtom.reportRead();
    return super.routesHistory;
  }

  @override
  set routesHistory(List<MRoute>? value) {
    _$routesHistoryAtom.reportWrite(value, super.routesHistory, () {
      super.routesHistory = value;
    });
  }

  late final _$finishLoadingHistoryAtom =
      Atom(name: '_RouteViewModel.finishLoadingHistory', context: context);

  @override
  bool get finishLoadingHistory {
    _$finishLoadingHistoryAtom.reportRead();
    return super.finishLoadingHistory;
  }

  @override
  set finishLoadingHistory(bool value) {
    _$finishLoadingHistoryAtom.reportWrite(value, super.finishLoadingHistory,
        () {
      super.finishLoadingHistory = value;
    });
  }

  late final _$currentDriverAtom =
      Atom(name: '_RouteViewModel.currentDriver', context: context);

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

  late final _$isRouteActivedAtom =
      Atom(name: '_RouteViewModel.isRouteActived', context: context);

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

  late final _$predictionsAtom =
      Atom(name: '_RouteViewModel.predictions', context: context);

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

  late final _$fetchCurrentDriverAsyncAction =
      AsyncAction('_RouteViewModel.fetchCurrentDriver', context: context);

  @override
  Future fetchCurrentDriver() {
    return _$fetchCurrentDriverAsyncAction
        .run(() => super.fetchCurrentDriver());
  }

  late final _$updateDriverInformationAsyncAction =
      AsyncAction('_RouteViewModel.updateDriverInformation', context: context);

  @override
  Future updateDriverInformation(Driver? driver) {
    return _$updateDriverInformationAsyncAction
        .run(() => super.updateDriverInformation(driver));
  }

  late final _$_RouteViewModelActionController =
      ActionController(name: '_RouteViewModel', context: context);

  @override
  dynamic setlastActivedRoute(MRoute? route) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setlastActivedRoute');
    try {
      return super.setlastActivedRoute(route);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEmptyHistory() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setEmptyHistory');
    try {
      return super.setEmptyHistory();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addToRoutesHistory(MRoute? route) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.addToRoutesHistory');
    try {
      return super.addToRoutesHistory(route);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanLocalData() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.cleanLocalData');
    try {
      return super.cleanLocalData();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsRouteActived(bool actived) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setIsRouteActived');
    try {
      return super.setIsRouteActived(actived);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPredictions(List<AutocompletePrediction> predct) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.addPredictions');
    try {
      return super.addPredictions(predct);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearPredictions() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.clearPredictions');
    try {
      return super.clearPredictions();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

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
  String toString() {
    return '''
lastActivedRoute: ${lastActivedRoute},
routesHistory: ${routesHistory},
finishLoadingHistory: ${finishLoadingHistory},
currentDriver: ${currentDriver},
isRouteActived: ${isRouteActived},
endAddress: ${endAddress},
predictions: ${predictions}
    ''';
  }
}
