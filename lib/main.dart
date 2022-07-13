import 'dart:core';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/main/AppModule.dart';
import 'package:mps_driver_app/modules/main/service/AmplifyInit.dart';
import 'package:mps_driver_app/theme/CustomTheme.dart';
import 'modules/main/presentation/MainPage.dart';
import 'modules/main/presentation/SingInPage.dart';
import 'modules/main/presentation/SingUpPage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(ModularApp(module: AppModule(), child: MainWidget()));
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initializeApp();
    });
    super.initState();
  }
  Future<void> _initializeApp() async {
    await AmplifyInit().configureAmplify();
    FlutterNativeSplash.remove();
  }
  final customTheme = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return SingInPage(state);
          case AuthenticatorStep.signUp:
            return SingUpPage(state);
          default:
            return null;
        }
      },
      child: MaterialApp.router(
        theme: customTheme.customLightTheme,
        themeMode: ThemeMode.system,
        builder: Authenticator.builder(),
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
      ));
  }
}
