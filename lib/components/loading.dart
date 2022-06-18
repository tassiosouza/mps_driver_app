import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child:
    Padding(padding: EdgeInsets.only(bottom: 10.0),
      child: CircularProgressIndicator(),
    )));
  }

}


