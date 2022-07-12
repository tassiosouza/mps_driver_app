import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/history/HistoryModule.dart';
import 'package:mps_driver_app/modules/main/presentation/MainPage.dart';
import 'package:mps_driver_app/modules/main/presentation/MainViewModel.dart';
import 'package:mps_driver_app/modules/prepnews/PrepNewsModule.dart';
import 'package:mps_driver_app/modules/profile/ProfileModule.dart';
import 'package:mps_driver_app/modules/rating/RatingModule.dart';
import '../route/RouteModule.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => MainViewModel())
  ];

  @override
  List<Module> get imports => [
    RouteModule()
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => MainPage(),
    children: [
      ModuleRoute('/prepnews', module: PrepNewsModule()),
      ModuleRoute('/history', module: HistoryModule()),
      ModuleRoute('/route', module: RouteModule()),
      ModuleRoute('/prepnews', module: RatingModule()),
      ModuleRoute('/prepnews', module: ProfileModule()),
    ])
  ];
}