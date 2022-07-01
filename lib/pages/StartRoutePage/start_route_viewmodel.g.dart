// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_route_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StartRouteViewModel on _StartRouteViewModel, Store {
  late final _$screenStateAtom =
      Atom(name: '_StartRouteViewModel.screenState', context: context);

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
      Atom(name: '_StartRouteViewModel.firstOpen', context: context);

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
      Atom(name: '_StartRouteViewModel.clientList', context: context);

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

  late final _$checkinAtom =
      Atom(name: '_StartRouteViewModel.checkin', context: context);

  @override
  Observable<bool> get checkin {
    _$checkinAtom.reportRead();
    return super.checkin;
  }

  @override
  set checkin(Observable<bool> value) {
    _$checkinAtom.reportWrite(value, super.checkin, () {
      super.checkin = value;
    });
  }

  late final _$sentWelcomeMessageAtom =
      Atom(name: '_StartRouteViewModel.sentWelcomeMessage', context: context);

  @override
  Observable<bool> get sentWelcomeMessage {
    _$sentWelcomeMessageAtom.reportRead();
    return super.sentWelcomeMessage;
  }

  @override
  set sentWelcomeMessage(Observable<bool> value) {
    _$sentWelcomeMessageAtom.reportWrite(value, super.sentWelcomeMessage, () {
      super.sentWelcomeMessage = value;
    });
  }

  late final _$statusRouteBarAtom =
      Atom(name: '_StartRouteViewModel.statusRouteBar', context: context);

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
      AsyncAction('_StartRouteViewModel.getClientList', context: context);

  @override
  Future<void> getClientList() {
    return _$getClientListAsyncAction.run(() => super.getClientList());
  }

  late final _$_StartRouteViewModelActionController =
      ActionController(name: '_StartRouteViewModel', context: context);

  @override
  void setFirstOpen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.setFirstOpen');
    try {
      return super.setFirstOpen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckIn() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.setCheckIn');
    try {
      return super.setCheckIn();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToLoadingScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToLoadingScreen');
    try {
      return super.goToLoadingScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToRouteScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToRouteScreen');
    try {
      return super.goToRouteScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToBagsScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToBagsScreen');
    try {
      return super.goToBagsScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyBags() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.verifyBags');
    try {
      return super.verifyBags();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyPhotosSent() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.verifyPhotosSent');
    try {
      return super.verifyPhotosSent();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToInTransitScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToInTransitScreen');
    try {
      return super.goToInTransitScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToRouteDoneScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToRouteDoneScreen');
    try {
      return super.goToRouteDoneScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToInitScreen() {
    final _$actionInfo = _$_StartRouteViewModelActionController.startAction(
        name: '_StartRouteViewModel.goToInitScreen');
    try {
      return super.goToInitScreen();
    } finally {
      _$_StartRouteViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screenState: ${screenState},
firstOpen: ${firstOpen},
clientList: ${clientList},
checkin: ${checkin},
sentWelcomeMessage: ${sentWelcomeMessage},
statusRouteBar: ${statusRouteBar}
    ''';
  }
}
