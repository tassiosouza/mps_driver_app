import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/Route.dart' as rt;
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import 'components/HistoryRouteListItem.dart';

class HistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage>{

  late StreamSubscription<QuerySnapshot<rt.Route>> _routesSubscription;
  Driver? _currentDriver;
  List<rt.Route> routesList = [];

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driver = await loadDriverInformation();

      _routesSubscription = Amplify.DataStore.observeQuery(
          rt.Route.classType,
          where: rt.Route.ROUTEDRIVERID.eq(driver?.getId()))
          .listen((QuerySnapshot<rt.Route> snapshot) {
            setState((){
              routesList = snapshot.items;
            });
      });
    });
    super.initState();
  }

  Future<Driver?> loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    setState(() {
      _currentDriver = driver;
    });
    return driver;
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Column(children: [
      SizedBox(height: 70),
      Row(children: [
        SizedBox(width: 20),
        Text("History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      ]),
      SizedBox(height: 20),
      Row(children: [
        SizedBox(width: 20),
        Text("Trips", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
      ]),
      Divider(thickness: 1),
      SizedBox(height: 20),
      Expanded(child: ListView.builder(itemCount: routesList.length,
          itemBuilder: (BuildContext context, int index){
            return HistoryRouteListItem(routesList[index]);
          }))
    ]));
  }
}