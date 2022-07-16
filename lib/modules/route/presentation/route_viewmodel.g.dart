// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteViewModel on _RouteViewModel, Store {
  late final _$screenStateAtom =
      Atom(name: '_RouteViewModel.screenState', context: context);

  @override
  Observable<RoutePageState> get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(Observable<RoutePageState> value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$checkingTimeAtom =
      Atom(name: '_RouteViewModel.checkingTime', context: context);

  @override
  Observable<String> get checkingTime {
    _$checkingTimeAtom.reportRead();
    return super.checkingTime;
  }

  @override
  set checkingTime(Observable<String> value) {
    _$checkingTimeAtom.reportWrite(value, super.checkingTime, () {
      super.checkingTime = value;
    });
  }

  late final _$isInRouteAtom =
      Atom(name: '_RouteViewModel.isInRoute', context: context);

  @override
  Observable<bool> get isInRoute {
    _$isInRouteAtom.reportRead();
    return super.isInRoute;
  }

  @override
  set isInRoute(Observable<bool> value) {
    _$isInRouteAtom.reportWrite(value, super.isInRoute, () {
      super.isInRoute = value;
    });
  }

  late final _$clientListAtom =
      Atom(name: '_RouteViewModel.clientList', context: context);

  @override
  ObservableList<Client> get clientList {
    _$clientListAtom.reportRead();
    return super.clientList;
  }

  @override
  set clientList(ObservableList<Client> value) {
    _$clientListAtom.reportWrite(value, super.clientList, () {
      super.clientList = value;
    });
  }

  late final _$orderListAtom =
      Atom(name: '_RouteViewModel.orderList', context: context);

  @override
  ObservableList<MpsOrder> get orderList {
    _$orderListAtom.reportRead();
    return super.orderList;
  }

  @override
  set orderList(ObservableList<MpsOrder> value) {
    _$orderListAtom.reportWrite(value, super.orderList, () {
      super.orderList = value;
    });
  }

  late final _$statusRouteBarAtom =
      Atom(name: '_RouteViewModel.statusRouteBar', context: context);

  @override
  Observable<int> get statusRouteBar {
    _$statusRouteBarAtom.reportRead();
    return super.statusRouteBar;
  }

  @override
  set statusRouteBar(Observable<int> value) {
    _$statusRouteBarAtom.reportWrite(value, super.statusRouteBar, () {
      super.statusRouteBar = value;
    });
  }

  late final _$getClientListAsyncAction =
      AsyncAction('_RouteViewModel.getClientList', context: context);

  @override
  Future<void> getClientList() {
    return _$getClientListAsyncAction.run(() => super.getClientList());
  }

  late final _$getOrderListAsyncAction =
      AsyncAction('_RouteViewModel.getOrderList', context: context);

  @override
  Future<void> getOrderList(Driver currentDriver) {
    return _$getOrderListAsyncAction
        .run(() => super.getOrderList(currentDriver));
  }

  late final _$_RouteViewModelActionController =
      ActionController(name: '_RouteViewModel', context: context);

  @override
  void backToFirstOpenState() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.backToFirstOpenState');
    try {
      return super.backToFirstOpenState();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToRoutePlan() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToRoutePlan');
    try {
      return super.goToRoutePlan();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToBagsChecking() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToBagsChecking');
    try {
      return super.goToBagsChecking();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToWelcomeMessageState() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToWelcomeMessageState');
    try {
      return super.goToWelcomeMessageState();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToInTransitScreen(
      Driver currentDriver, List<MpsOrder> orders, bool alreadySent) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToInTransitScreen');
    try {
      return super.goToInTransitScreen(currentDriver, orders, alreadySent);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToRouteDoneScreen() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToRouteDoneScreen');
    try {
      return super.goToRouteDoneScreen();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearClientList() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.clearClientList');
    try {
      return super.clearClientList();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckingTime(String time) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setCheckingTime');
    try {
      return super.setCheckingTime(time);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsInRoute(bool inRoute) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setIsInRoute');
    try {
      return super.setIsInRoute(inRoute);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderList(List<MpsOrder> orders) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setOrderList');
    try {
      return super.setOrderList(orders);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToBagsScreen() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToBagsScreen');
    try {
      return super.goToBagsScreen();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyBags(Driver currentDriver) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.verifyBags');
    try {
      return super.verifyBags(currentDriver);
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyPhotosSent() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.verifyPhotosSent');
    try {
      return super.verifyPhotosSent();
    } finally {
      _$_RouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screenState: ${screenState},
checkingTime: ${checkingTime},
isInRoute: ${isInRoute},
clientList: ${clientList},
orderList: ${orderList},
statusRouteBar: ${statusRouteBar}
    ''';
  }
}
