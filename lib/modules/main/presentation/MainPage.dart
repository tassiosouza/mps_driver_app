import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../history/HistoryModule.dart';
import '../../prepnews/PrepNewsModule.dart';
import '../../profile/ProfileModule.dart';
import '../../rating/RatingModule.dart';
import '../../route/RouteModule.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>{

  final _pages = <Widget>[
    PrepNewsModule(),
    HistoryModule(),
    RouteModule(),
    RatingModule(),
    ProfileModule()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

}