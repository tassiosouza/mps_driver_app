import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/main/presentation/MainViewModel.dart';
import '../../../theme/app_colors.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final viewModel = Modular.get<MainViewModel>();

  @override
  Widget build(BuildContext context) {
    Modular.to.navigate('/history/');
    return Scaffold(
        body: const RouterOutlet(),
        bottomNavigationBar: Observer(builder: (_) {
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
            currentIndex: viewModel.currentIndex.value,
            onTap: (index) {
              viewModel.setCurrentIndex(index);
              switch (index) {
                case 0:
                  Modular.to.navigate('/prepnews/');
                  break;
                case 1:
                  Modular.to.navigate('/history/');
                  break;
                case 2:
                  Modular.to.navigate('/route/');
                  break;
                case 3:
                  Modular.to.navigate('/rating/');
                  break;
                case 4:
                  Modular.to.navigate('/profile/');
                  break;
              }
            },
            selectedItemColor: App_Colors.primary_color.value,
            unselectedItemColor: App_Colors.grey_dark.value,
          );
        }));
  }
}
