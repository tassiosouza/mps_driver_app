import 'package:flutter/material.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route.dart';

import 'pages/PrepNewsPage/amplify.dart';

void main() {
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
   MainPageState createState() =>  MainPageState();
}

class  MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    TodosPage(),
    StartRoutePage(),
    Icon(
      Icons.manage_accounts,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MPS Driver'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Prep News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Start Route',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}