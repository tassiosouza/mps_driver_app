import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class PrepNewsItem extends StatefulWidget {
  const PrepNewsItem({Key? key}) : super(key: key);

  @override
  State<PrepNewsItem> createState() => _PrepNewsItemState();
}

class _PrepNewsItemState extends State<PrepNewsItem> {
  @override
  Widget build(BuildContext context) {
    return Card(margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
    side: BorderSide(width: 1.0, color: App_Colors.grey_light.value)),
        child: Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(2), margin: EdgeInsets.only(left: 10, right: 25),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),
                    border: Border.all(width: 1, color: App_Colors.grey_light.value)),
                child: Icon(Icons.person, size: 50, color: App_Colors.grey_light.value)),
            Column(children: [
              Text("Meal Prep Sunday", style: TextStyle(fontWeight: FontWeight.w500,
              fontSize: 14, color: App_Colors.black_text.value)),
              SizedBox(height: 2),
              Text("08:26 AM", style: TextStyle(color: App_Colors.grey_text.value))
            ], crossAxisAlignment: CrossAxisAlignment.start)
          ]),
          SizedBox(height: 20),
          Image.asset('assets/images/prepnewsimagedefault.png'),
          SizedBox(height: 20),
          Text("Meal Prep Sunday", style: TextStyle(color: App_Colors.primary_color.value,
          fontWeight: FontWeight.w500)),
          SizedBox(height: 7),
          Text("Welcome to our new colaborator! Joseph Allen! Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC"),
          SizedBox(height: 30)
        ]), padding: EdgeInsets.all(15)));
  }
}
