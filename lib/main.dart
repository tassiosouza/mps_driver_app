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
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/wip.png')),
            SizedBox(height: 30),
            Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    ),
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/wip.png')),
            SizedBox(height: 30),
            Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    ),
    StartRoutePage(),
    Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/wip.png')),
            SizedBox(height: 30),
            Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    ),
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

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
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
