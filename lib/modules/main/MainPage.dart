import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../theme/app_colors.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>{

  void _onItemTapped(int index) {
    setState(() {
      switch(index){
        case 0 : Modular.to.pushNamed('/');
        break;
        case 1 : Modular.to.pushNamed('/history');
        break;
        case 2 : Modular.to.pushNamed('/route');
        break;
        case 3 : Modular.to.pushNamed('/rating');
        break;
        case 4 : Modular.to.pushNamed('/profile');
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: Observer(builder: (_){
        return BottomNavigationBar(
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
          onTap: _onItemTapped,
          selectedItemColor: App_Colors.primary_color.value,
          unselectedItemColor: App_Colors.grey_dark.value,
        );
      }) ,
    );
  }

}