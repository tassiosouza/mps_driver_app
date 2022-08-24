import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/InitRoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteLoading.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';
import 'package:mps_driver_app/store/route/RouteStore.dart';

class RouteModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => RouteStore())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const InitRoutePage()),
        ChildRoute('/loading', child: (context, args) => RouteLoading()),
        ChildRoute('/inroute',
            transition: TransitionType.rightToLeft,
            child: (context, args) => RoutePage()),
      ];
}
