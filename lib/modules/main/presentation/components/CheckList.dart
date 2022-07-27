// ignore: file_names
import 'package:flutter/material.dart';

class CheckList extends StatelessWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              ''' Driver's ''',
              style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Book',
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
                  image: AssetImage('assets/images/checklist_onboarding.png'))),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                      child: Icon(
                    Icons.download,
                    size: 15,
                    color: Colors.green,
                  )),
                  TextSpan(
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Poopings',
                        fontSize: 17),
                    text: "  Download complete guide",
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
