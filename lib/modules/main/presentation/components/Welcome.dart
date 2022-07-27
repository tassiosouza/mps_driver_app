import 'package:flutter/material.dart';

import '../../../../models/Driver.dart';

class Welcome extends StatelessWidget {
  final Driver? currentDriver;
  const Welcome(this.currentDriver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Expanded(
              child: Image(image: AssetImage('assets/images/onBoarding1.png'))),
          const SizedBox(height: 20),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              child: const Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Poppings',
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              )),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Row(children: [
                const Text(
                  'to Meal Prep Sunday, ',
                  style: TextStyle(
                      color: Color(0xff363636),
                      fontFamily: 'Poppings',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  currentDriver!.name.split(' ')[0],
                  style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'Poppings',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ])),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
