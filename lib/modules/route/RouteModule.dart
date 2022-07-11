import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/start_route_viewmodel.dart';

class RouteModule extends WidgetModule {
  @override
  Widget get view => StartRoutePage();

  @override
  List<Bind<Object>> get binds => [];
}

class RouteBinds extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => StartRouteViewModel(), export: true)
  ];
}