import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
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
                        Icon(Icons.person, size: 50),
                        Flexible(child: Column(
                          children: <Widget>[
                            Text(client.name,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
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
                          IconButton(
                            icon: const Icon(Icons.phone),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.sms),
                            onPressed: () {
                              sendSms();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_bag),
                            onPressed: () {
                            },
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(onPressed: (){
                            _launchMapsUrl();
                            }, child: Row(children: [
                            Text("Start"),
                            Icon(Icons.route)
                          ],
                          ),
                          )
                        ],
                      ),
                    ],
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
                        Text("#45758"),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined)),
                        Text("Deliver")
                      ],
                    )
                  ]),
                )
              ]
          ),
        )
    );
  }
}
