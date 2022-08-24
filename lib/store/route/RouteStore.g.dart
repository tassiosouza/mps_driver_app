// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RouteStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteStore on _RouteStore, Store {
  late final _$routesHistoryAtom =
      Atom(name: '_RouteStore.routesHistory', context: context);

  @override
  List<MRoute?>? get routesHistory {
    _$routesHistoryAtom.reportRead();
    return super.routesHistory;
  }

  @override
  set routesHistory(List<MRoute?>? value) {
    _$routesHistoryAtom.reportWrite(value, super.routesHistory, () {
      super.routesHistory = value;
    });
  }

  late final _$ordersHistoryAtom =
      Atom(name: '_RouteStore.ordersHistory', context: context);

  @override
  List<MOrder?>? get ordersHistory {
    _$ordersHistoryAtom.reportRead();
    return super.ordersHistory;
  }

  @override
  set ordersHistory(List<MOrder?>? value) {
    _$ordersHistoryAtom.reportWrite(value, super.ordersHistory, () {
      super.ordersHistory = value;
    });
  }

  late final _$currentDriverAtom =
      Atom(name: '_RouteStore.currentDriver', context: context);

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

  late final _$assignedRouteAtom =
      Atom(name: '_RouteStore.assignedRoute', context: context);

  @override
  MRoute? get assignedRoute {
    _$assignedRouteAtom.reportRead();
    return super.assignedRoute;
  }

  @override
  set assignedRoute(MRoute? value) {
    _$assignedRouteAtom.reportWrite(value, super.assignedRoute, () {
      super.assignedRoute = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_RouteStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$finishLoadingHistoryAtom =
      Atom(name: '_RouteStore.finishLoadingHistory', context: context);

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

  late final _$retrieveDriverInformationAsyncAction =
      AsyncAction('_RouteStore.retrieveDriverInformation', context: context);

  @override
  Future retrieveDriverInformation() {
    return _$retrieveDriverInformationAsyncAction
        .run(() => super.retrieveDriverInformation());
  }

  late final _$fetchRoutesAsyncAction =
      AsyncAction('_RouteStore.fetchRoutes', context: context);

  @override
  Future fetchRoutes() {
    return _$fetchRoutesAsyncAction.run(() => super.fetchRoutes());
  }

  late final _$fetchAssignedRouteAsyncAction =
      AsyncAction('_RouteStore.fetchAssignedRoute', context: context);

  @override
  Future fetchAssignedRoute() {
    return _$fetchAssignedRouteAsyncAction
        .run(() => super.fetchAssignedRoute());
  }

  late final _$fetchOrdersAsyncAction =
      AsyncAction('_RouteStore.fetchOrders', context: context);

  @override
  Future fetchOrders() {
    return _$fetchOrdersAsyncAction.run(() => super.fetchOrders());
  }

  late final _$_RouteStoreActionController =
      ActionController(name: '_RouteStore', context: context);

  @override
  dynamic setLoading(bool isLoading) {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.setLoading');
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_RouteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEmptyHistory() {
    final _$actionInfo = _$_RouteStoreActionController.startAction(
        name: '_RouteStore.setEmptyHistory');
    try {
      return super.setEmptyHistory();
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
  String toString() {
    return '''
routesHistory: ${routesHistory},
ordersHistory: ${ordersHistory},
currentDriver: ${currentDriver},
assignedRoute: ${assignedRoute},
loading: ${loading},
finishLoadingHistory: ${finishLoadingHistory}
    ''';
  }
}
