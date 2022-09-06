// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              ''' Terms and ''',
              style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Conditions',
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Poppings',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ]),
          const SizedBox(height: 30),
          const Expanded(
              child: Image(image: AssetImage('assets/images/terms.png'))),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      // WidgetSpan(
                      //     child: Icon(
                      //   Icons.read_more,
                      //   size: 15,
                      //   color: Colors.green,
                      // )),
                      TextSpan(
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Poopings',
                            fontSize: 17),
                        text: " Click here to read the terms",
                      ),
                    ],
                  ),
                ),
                onTap: () => launch(
                    'https://app.websitepolicies.com/policies/view/vtxtkt3t')),
          ]),
        ],
      ),
    );
  }
}
