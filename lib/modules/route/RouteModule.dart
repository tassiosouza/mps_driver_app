import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/InitRoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteLoading.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/route_viewmodel.dart';

class RouteModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => RouteViewModel(), export: true)
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => InitRoutePage()),
    ChildRoute('/loading', child: (context, args) => RouteLoading()),
    ChildRoute('/inroute', child: (context, args) => RoutePage()),
  ];
}