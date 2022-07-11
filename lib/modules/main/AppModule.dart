import 'package:flutter_modular/flutter_modular.dart';
import '../route/RouteModule.dart';

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