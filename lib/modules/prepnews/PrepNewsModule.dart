import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/prepnews/presentation/PrepNewsPage.dart';

import '../history/HistoryModule.dart';
import '../profile/ProfileModule.dart';
import '../rating/RatingModule.dart';
import '../route/RouteModule.dart';

class PrepNewsModule extends WidgetModule{
  @override
  List<Bind<Object>> get binds => [];

  @override
  Widget get view => PrepNewsPage();

}