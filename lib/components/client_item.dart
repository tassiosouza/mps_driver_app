import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import '../../models/Client.dart';

class ClientItem extends StatelessWidget {
  final Function sendSms;
  Client client;

  ClientItem(this.client, this.sendSms, {Key? key}) : super(key: key);
  late var availableMaps;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}h${twoDigitMinutes}m"
        .replaceAll('00h', '');
  }

  void _launchMapsUrl() async {
    availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(client.coordinates.latitude, client.coordinates.longitude),
      title: client.name,
      description: client.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
      side: BorderSide(width: 1.0, color: Colors.grey)
      ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Expanded(child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(width: 1, color: Colors.grey)
                          ),
                          child: Icon(Icons.person, size: 40, color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        Flexible(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(overflow: TextOverflow.ellipsis,
                                text: TextSpan(text: client.name,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black))
                            ),
                            RichText( overflow: TextOverflow.ellipsis,
                            text: TextSpan(text: client.address,
                            style: TextStyle(color: Colors.black))),
                            Text('ETA: ' +
                                _printDuration(Duration(seconds: client.eta)))
                          ],
                        ))
                      ]),
                      const Divider(color: Colors.grey, thickness: 1),
                      Row(
                        children: [
                          getButtonIcon(CustomIcon.sms_driver_icon, (){}),
                          getButtonIcon(CustomIcon.call_driver_icon, sendSms),
                          getButtonIcon(CustomIcon.bag_driver_icon, (){}),
                          SizedBox(width: 10),
                          ElevatedButton(onPressed: (){
                            _launchMapsUrl();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: App_Colors.primary_color.value
                            ),
                            child: Row(children: [
                            Text("Start", style: TextStyle(fontSize: 15)),
                            SizedBox(width: 10),
                            Icon(CustomIcon.start_driver_icon, size: 10)]
                          ),
                          )
                        ],),],
                  ),
                ),
                ),
                const VerticalDivider(color: Colors.grey, thickness: 2),
                IntrinsicHeight(
                  child: Row(children: [
                    const VerticalDivider(color: Colors.grey, thickness: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("#45758", style: TextStyle(fontSize: 14),),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20, left: 10,right: 10),
                      padding: EdgeInsets.only(top: 7, bottom: 7, left: 6, right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: Icon(CustomIcon.camera_driver_icon, size: 20,
                          color: App_Colors.primary_color.value),
                    ),
                  ),
                        Text("Deliver", style: TextStyle(fontSize: 12),)
                      ],
                    )
                  ]),
                )]
          ),
        )
    );
  }
  getButtonIcon(IconData icon, Function function){
    return GestureDetector(
      onTap: () => function,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(width: 1, color: Colors.grey)
        ),
        child: Icon(icon, size: 20, color: App_Colors.primary_color.value),
      ),
    );
  }
}