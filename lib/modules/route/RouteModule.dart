import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/InitRoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteLoading.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';

class RouteModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const InitRoutePage()),
        ChildRoute('/loading', child: (context, args) => RouteLoading()),
        ChildRoute('/inroute', child: (context, args) => RoutePage()),
      ];
}
