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
  Observable<ScreenState> get screenState {
    _$screenStateAtom.reportRead();
    return super.screenState;
  }

  @override
  set screenState(Observable<ScreenState> value) {
    _$screenStateAtom.reportWrite(value, super.screenState, () {
      super.screenState = value;
    });
  }

  late final _$_StartRouteViewModelActionController =
      ActionController(name: '_StartRouteViewModel', context: context);

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
screenState: ${screenState}
    ''';
  }
}
