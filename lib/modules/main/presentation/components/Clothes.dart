// ignore: file_names
import 'package:flutter/material.dart';

class Clothes extends StatelessWidget {
  const Clothes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              'Dress ',
              style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Code',
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ]),
          const SizedBox(height: 30),
          const Expanded(
              child: Image(
                  image: AssetImage('assets/images/clothes_onboarding.png'))),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
