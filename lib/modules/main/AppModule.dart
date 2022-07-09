import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/RouteBinds.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
    RouteBinds()
  ];

  @override
  List<ModularRoute> get routes => [];
}