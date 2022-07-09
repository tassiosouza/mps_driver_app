import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/route/start_route_viewmodel.dart';

class RouteBinds extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => StartRouteViewModel(), export: true)
  ];
}