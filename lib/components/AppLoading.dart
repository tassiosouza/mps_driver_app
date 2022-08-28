import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset("assets/images/mps_loading.png"),
      SizedBox(height: 20),
      CircularProgressIndicator()
    ], mainAxisAlignment: MainAxisAlignment.center,);
  }
}
