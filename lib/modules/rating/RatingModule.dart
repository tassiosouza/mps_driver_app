import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/rating/presentation/RatingPage.dart';

class RatingModule extends Module{
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => RatingPage())
  ];
}