import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'PrepNewsItem.dart';

class PrepNewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PrepNewsPageState();
}

class PrepNewsPageState extends State<PrepNewsPage>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      SizedBox(height: 80),
      Row(children: [
        Container(child: Text("Prep News", style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.w500)), padding: EdgeInsets.only(left: 20)),
        Container(padding: const EdgeInsets.all(2), margin: EdgeInsets.only(right: 40),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),
                border: Border.all(width: 1, color: App_Colors.grey_light.value)),
            child: Icon(Icons.person, size: 40, color: App_Colors.grey_light.value)),
      ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
      SizedBox(height: 20),
      Divider(thickness: 1, color: App_Colors.grey_light.value),
      Container(child: ListView.builder(itemBuilder: (context, args) => PrepNewsItem(),
        itemCount: 3, shrinkWrap: true, physics: NeverScrollableScrollPhysics()))
    ]));
  }

}