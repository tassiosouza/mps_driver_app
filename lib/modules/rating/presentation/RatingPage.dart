import 'package:flutter/cupertino.dart';

class RatingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RatingPageState();
}

class RatingPageState extends State<RatingPage>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: const AssetImage('assets/images/wip.png')),
            const SizedBox(height: 30),
            const Text("Wait while we are working on this feature",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontFamily: 'Poppins')),
          ]),
    );
  }
}