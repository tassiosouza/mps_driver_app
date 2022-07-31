import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/history/presentation/HistoryPage.dart';
import 'package:mps_driver_app/modules/history/presentation/HistoryRouteDetails.dart';

class HistoryModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => HistoryPage()),
        ChildRoute('/details',
            transition: TransitionType.rightToLeft,
            child: (context, args) => HistoryRouteDetails(args.data))
      ];
}
