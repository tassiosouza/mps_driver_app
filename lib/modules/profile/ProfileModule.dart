import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/profile/presentation/ProfilePage.dart';
import 'package:mps_driver_app/modules/profile/presentation/ProfileViewModel.dart';

class ProfileModule extends Module{
  @override
  List<Bind<Object>> get binds => [
    Bind.singleton((i) => ProfileViewModel(), export: true)
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => ProfilePage())
  ];
}