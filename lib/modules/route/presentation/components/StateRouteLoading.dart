import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../theme/app_colors.dart';

class StateRouteLoading extends StatelessWidget {
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
