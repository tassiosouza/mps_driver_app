import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(image: AssetImage('assets/images/wip.png')),
            SizedBox(height: 30),
            Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    );
  }
}