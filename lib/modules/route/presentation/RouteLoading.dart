import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:mps_driver_app/modules/route/presentation/route_viewmodel.dart';
import '../../../theme/app_colors.dart';

class RouteLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateRouteLoading();
}
  
class StateRouteLoading extends State<RouteLoading>{
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center,
            children:[
              Image.asset('assets/images/loading_backgroun.png',
              height: double.infinity, width: double.infinity,
              fit: BoxFit.cover),
              Column(children: [
                SizedBox(height: 250),
                Lottie.asset('assets/animations/loading_animation.json'),
                Container(child: Text("Please wait while we plan your route...",
                    style: TextStyle(fontSize: 18, color: App_Colors.grey_text.value,
                        decoration: TextDecoration.none), textAlign: TextAlign.center),
                  padding: EdgeInsets.all(30),)
              ],),
            ]);
  }
}
