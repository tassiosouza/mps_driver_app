import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds {
    return [
      Bind.singleton((i) => StartRouteViewModel())
    ];
  }
}