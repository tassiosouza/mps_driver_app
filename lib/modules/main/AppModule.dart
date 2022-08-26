import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/history/HistoryModule.dart';
import 'package:mps_driver_app/modules/main/presentation/MainLoading.dart';
import 'package:mps_driver_app/modules/main/presentation/MainPage.dart';
import 'package:mps_driver_app/modules/main/presentation/OnBoarding.dart';
import 'package:mps_driver_app/modules/prepnews/PrepNewsModule.dart';
import 'package:mps_driver_app/modules/profile/ProfileModule.dart';
import 'package:mps_driver_app/modules/rating/RatingModule.dart';
import 'package:mps_driver_app/store/main/MainStore.dart';
import '../route/RouteModule.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => MainStore())];

  @override
  List<Module> get imports => [
    RouteModule(),
    ProfileModule(),
    HistoryModule()
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const MainLoading()),
        ChildRoute('/onboarding', child: (context, args) => OnBoarding()),
        ChildRoute('/main', child: (context, args) => MainPage(), children: [
          ModuleRoute('/prepnews/',
              module: PrepNewsModule(),
              transition: TransitionType.noTransition),
          ModuleRoute('/history/',
              module: HistoryModule(), transition: TransitionType.noTransition),
          ModuleRoute('/route/',
              module: RouteModule(), transition: TransitionType.noTransition),
          ModuleRoute('/rating/',
              module: RatingModule(), transition: TransitionType.noTransition),
          ModuleRoute('/profile/',
              module: ProfileModule(), transition: TransitionType.noTransition),
        ])
      ];
}
