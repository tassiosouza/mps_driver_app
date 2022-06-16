import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/pages/AccountPage/profile.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import '/amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../../models/ModelProvider.dart';
import 'pages/PrepNewsPage/amplify.dart';
import 'pages/AccountPage/account.dart';
import 'dart:developer';
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

  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  static const List<Widget> _pages = <Widget>[
    StartRoutePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // kick off app initialization
    _initializeApp();

    // to be filled in a later step
    super.initState();
  }

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // add Amplify plugins
    await Amplify.addPlugins([_dataStorePlugin, _apiPlugin, _authPlugin]);

    try {
      // configure Amplify
      await Amplify.configure(amplifyconfig);
      FlutterNativeSplash.remove(); //remove splash screen after amplify configuration
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

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins'
        ),
        builder: Authenticator.builder(),
        home: Scaffold(
          body: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'My route'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              )
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