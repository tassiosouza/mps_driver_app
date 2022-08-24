// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryStore on _HistoryStore, Store {
  late final _$routesHistoryAtom =
      Atom(name: '_HistoryStore.routesHistory', context: context);

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
      Atom(name: '_HistoryStore.ordersHistory', context: context);

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

  late final _$finishLoadingHistoryAtom =
      Atom(name: '_HistoryStore.finishLoadingHistory', context: context);

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

  late final _$isRouteActivedAtom =
      Atom(name: '_HistoryStore.isRouteActived', context: context);

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

  late final _$fetchRoutesAsyncAction =
      AsyncAction('_HistoryStore.fetchRoutes', context: context);

  @override
  Future fetchRoutes() {
    return _$fetchRoutesAsyncAction.run(() => super.fetchRoutes());
  }

  late final _$fetchOrdersAsyncAction =
      AsyncAction('_HistoryStore.fetchOrders', context: context);

  @override
  Future fetchOrders() {
    return _$fetchOrdersAsyncAction.run(() => super.fetchOrders());
  }

  late final _$_HistoryStoreActionController =
      ActionController(name: '_HistoryStore', context: context);

  @override
  dynamic setEmptyHistory() {
    final _$actionInfo = _$_HistoryStoreActionController.startAction(
        name: '_HistoryStore.setEmptyHistory');
    try {
      return super.setEmptyHistory();
    } finally {
      _$_HistoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanLocalData() {
    final _$actionInfo = _$_HistoryStoreActionController.startAction(
        name: '_HistoryStore.cleanLocalData');
    try {
      return super.cleanLocalData();
    } finally {
      _$_HistoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsRouteActived(bool actived) {
    final _$actionInfo = _$_HistoryStoreActionController.startAction(
        name: '_HistoryStore.setIsRouteActived');
    try {
      return super.setIsRouteActived(actived);
    } finally {
      _$_HistoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
routesHistory: ${routesHistory},
ordersHistory: ${ordersHistory},
finishLoadingHistory: ${finishLoadingHistory},
isRouteActived: ${isRouteActived}
    ''';
  }
}
