import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/rating/presentation/RatingPage.dart';

class RatingModule extends WidgetModule{
  @override
  List<Bind<Object>> get binds => [];

  @override
  Widget get view => RatingPage();
}