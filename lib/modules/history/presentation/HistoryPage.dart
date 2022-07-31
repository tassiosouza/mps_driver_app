import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../models/MpsRoute.dart';
import '../../route/presentation/RouteViewModel.dart';
import 'components/HistoryRouteListItem.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  late StreamSubscription<QuerySnapshot<MpsRoute>> _routesSubscription;
  Driver? _currentDriver;
  List<MpsRoute> _routesList = [];
  List<List<MpOrder>> _ordersLists = [];
  bool _isLoading = true;
  bool _emptyList = false;
  final _routeViewModel = Modular.get<RouteViewModel>();

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      driver = _routeViewModel.currentDriver;

      //Build the list of routes with all the route information ready
      _routesSubscription = Amplify.DataStore.observeQuery(MpsRoute.classType,
              where: MpsRoute.MPSROUTEDRIVERID.eq(driver?.getId()))
          .listen((QuerySnapshot<MpsRoute> snapshot) {
        for (int i = 0; i < snapshot.items.length; i++) {
          MpsRoute currentRoute = snapshot.items[i];
          List<MpOrder> currentOrders = [];
          Amplify.DataStore.query(MpOrder.classType,
                  where: MpOrder.ROUTEID.eq(currentRoute.getId()))
              .then((orders) async => {
                    for (int k = 0; k < orders.length; k++)
                      {
                        await Amplify.DataStore.query(Customer.classType,
                                where:
                                    Customer.ID.eq(orders[k].mpOrderCustomerId))
                            .then((customer) => {
                                  currentOrders.add(orders[k].copyWith(
                                      customer: customer[0],
                                      deliveryInstruction:
                                          orders[k].updatedAt.toString())),
                                  if (currentOrders.length == orders.length)
                                    {
                                      if (currentRoute.status ==
                                          RouteStatus.DONE)
                                        {
                                          _routesList.add(currentRoute.copyWith(
                                              orders: currentOrders)),
                                          //set orders state when retrieved the last list of orders from routes
                                          setState(() {
                                            _routesList = _routesList;
                                            _isLoading = false;
                                          }),
                                        }
                                    }
                                }),
                      },
                  });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _routesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: _isLoading
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/images/no_route.png')),
                  SizedBox(height: 20),
                  Text('You have made any routes yet.')
                ],
              ))
            : Column(children: [
                const SizedBox(height: 70),
                Row(children: const [
                  SizedBox(width: 20),
                  Text("History",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                ]),
                const SizedBox(height: 20),
                Row(children: const [
                  SizedBox(width: 20),
                  Text("Trips",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
                ]),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        itemCount: _routesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HistoryRouteListItem(_routesList[index]);
                        }))
              ]));
  }
}
