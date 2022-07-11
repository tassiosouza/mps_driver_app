import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/history/presentation/HistoryPage.dart';

class HistoryModule extends WidgetModule{
  @override
  List<Bind<Object>> get binds => [];

  @override
  Widget get view => HistoryPage();
}