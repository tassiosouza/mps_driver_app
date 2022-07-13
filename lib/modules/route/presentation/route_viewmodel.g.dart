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

  late final _$firstOpenAtom =
      Atom(name: '_RouteViewModel.firstOpen', context: context);

  @override
  Observable<bool> get firstOpen {
    _$firstOpenAtom.reportRead();
    return super.firstOpen;
  }

  @override
  set firstOpen(Observable<bool> value) {
    _$firstOpenAtom.reportWrite(value, super.firstOpen, () {
      super.firstOpen = value;
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

  late final _$_RouteViewModelActionController =
      ActionController(name: '_RouteViewModel', context: context);

  @override
  void setFirstOpen() {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.setFirstOpen');
    try {
      return super.setFirstOpen();
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
  void goToInTransitScreen(Driver currentDriver) {
    final _$actionInfo = _$_RouteViewModelActionController.startAction(
        name: '_RouteViewModel.goToInTransitScreen');
    try {
      return super.goToInTransitScreen(currentDriver);
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
  String toString() {
    return '''
screenState: ${screenState},
firstOpen: ${firstOpen},
clientList: ${clientList},
statusRouteBar: ${statusRouteBar}
    ''';
  }
}
