import 'dart:core';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:mps_driver_app/Services/DriverService.dart';
import 'package:mps_driver_app/components/Loading.dart';
import 'package:mps_driver_app/pages/AccountPage/ProfilePage.dart';
import 'package:mps_driver_app/pages/StartRoutePage/RoutePage.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import '/amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../../models/ModelProvider.dart';
import 'pages/PrepNewsPage/AmplifyPage.dart';
import 'dart:developer';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPS Driver',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // amplify plugins
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  static List<Widget> _pages = <Widget>[
    const MyAppTodos(),
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: const AssetImage('assets/images/wip.png')),
            const SizedBox(height: 30),
            const Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    ),
    const StartRoutePage(),
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: const AssetImage('assets/images/wip.png')),
            const SizedBox(height: 30),
            const Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    ),
    const ProfilePage(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // kick off app initialization
      _initializeApp();
    });

    // to be filled in a later step
    super.initState();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();
    // configure driver login
    // await DriverService.login();
    // remove splash screen
    FlutterNativeSplash.remove();
  }

  Future<void> _configureAmplify() async {
    // add Amplify plugins
    await Amplify.addPlugins(
        [_dataStorePlugin, _apiPlugin, _authPlugin, _storagePlugin]);

    try {
      // configure Amplify
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      print('An error occurred while configuring Amplify: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // light theme
  ThemeData customLightTheme = ThemeData(
    // app's colors scheme and brightness
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
    ),
    // tab bar indicator color
    indicatorColor: Colors.green,
    textTheme: const TextTheme(
      // text theme of the header on each step
      bodyText1: TextStyle(fontFamily: 'Poppins'),
      bodyText2: TextStyle(fontFamily: 'Poppins'),
      headline6: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 24, fontFamily: 'Poppins'),
    ),
    // theme of the form fields for each step
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(fontFamily: 'Poppins'),
      labelStyle: const TextStyle(fontFamily: 'Poppins'),
      hintStyle: const TextStyle(fontFamily: 'Poppins'),
      helperStyle: const TextStyle(fontFamily: 'Poppins'),
      contentPadding: const EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[200],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    // theme of the primary button for each step
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontFamily: 'Poppins')),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      // builder used to show a custom sign in and sign up experience
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        const padding =
            EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return Scaffold(
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      Center(
                          child: Image.asset('assets/images/logo.png',
                              width: 230)),
                      // prebuilt sign in form from amplify_authenticator package
                      SignInForm(),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign up
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signUp,
                      ),
                      child: const Text('Sign Up',
                          style: TextStyle(fontFamily: 'Poppins')),
                    ),
                  ],
                ),
              ],
            );
          case AuthenticatorStep.signUp:
            return Scaffold(
              body: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                              'Ready to join our team ? Register here :)',
                              style: TextStyle(fontFamily: 'Poppins'))),
                      // prebuilt sign up form from amplify_authenticator package
                      SignUpForm.custom(
                        fields: [
                          SignUpFormField.custom(
                            required: true,
                            title: 'Full Name',
                            attributeKey: CognitoUserAttributeKey.name,
                          ),
                          SignUpFormField.email(required: true),
                          SignUpFormField.phoneNumber(required: true),
                          SignUpFormField.password(),
                          SignUpFormField.passwordConfirmation(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign in
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signIn,
                      ),
                      child: const Text('Sign In',
                          style: TextStyle(fontFamily: 'Poppins')),
                    ),
                  ],
                ),
              ],
            );
          default:
            // returning null defaults to the prebuilt authenticator for all other steps
            return null;
        }
      },
      child: MaterialApp(
        theme: customLightTheme,
        themeMode: ThemeMode.system,
        builder: Authenticator.builder(),
        home: Scaffold(
          body: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: 'Prep News'),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'New Route',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Rating',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: App_Colors.primary_color.value,
            unselectedItemColor: App_Colors.grey_dark.value,
          ),
        ),
      ),
    );
  }
}
