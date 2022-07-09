import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/route/RoutePage.dart';
import 'package:mps_driver_app/modules/route/presentation/route/start_route_viewmodel.dart';

class RouteModule extends WidgetModule {

  @override
  Widget get view => StartRoutePage();

  @override
  List<Bind<Object>> get binds => [];
}