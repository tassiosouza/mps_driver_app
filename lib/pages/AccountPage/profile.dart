import 'package:flutter/material.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../models/Driver.dart';
import '../../theme/app_colors.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return ProfilePageState();
  }
}

class ProfilePageState extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageState>{

  Driver mark = Driver(
    "marklarson",
    "Mark",
    "Larson",
    "marklarson@gmail.com",
    196,
    2,
    348,
    4.8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(image:
                  AssetImage('assets/images/background_profile_img.png'),
                      fit: BoxFit.cover)
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 85),
                    Column(children: [
                      SizedBox(height: 70),
                      Icon(Icons.person_outline, size: 120, color: App_Colors.primary_color.value,),
                      Text(mark.firstName + " " + mark.lastName,
                        style: TextStyle(fontSize: 18, color: Colors.white),),
                      SizedBox(height: 5),
                      Text("Driver", style: TextStyle(fontSize: 12,
                          color: App_Colors.grey_light.value))
                      ],
                    ),
                    Column(children: [
                      SizedBox(height: 60),
                        GestureDetector(
                        onTap: () => {},
                          child: Container(
                            margin: EdgeInsets.all(30),
                            child: Icon(CustomIcon.config_driver_icon, size: 23,
                                color: App_Colors.grey_light.value)
                          ))
                    ],
                    )
                  ])
            ),
            SizedBox(height: 22),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              getInfoColumn(mark.trips.toString(), "Trips"),
              getInfoColumn(mark.month.toString(), "Month"),
              getInfoColumn(mark.deliveries.toString(), "Deliveries"),
              getInfoColumn(mark.rating.toString(), "Rating"),
            ],),
            Row(),
            Row(),
            Row(),
            Row(),
            Row(),
            Column()
          ])
    );
  }
  getInfoColumn(String value, String label){
    return Column(children: [
      Text(value, style: TextStyle(
          color: App_Colors.black_text.value, fontFamily: 'Poppins',
          fontWeight: FontWeight.w500, fontSize: 20
      ),),
      SizedBox(height: 17),
      Text(label, style: TextStyle(fontSize: 14, fontFamily: 'Poppins'))
    ]);
  }
}


