import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/store/history/HistoryStore.dart';
import '../../../models/Driver.dart';
import '../../../models/MRoute.dart';
import 'components/HistoryRouteListItem.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final _historyStore = Modular.get<HistoryStore>();

  Future<void> fetchRoutesAndOrders() async {
    _historyStore.setFinishLoadingHistory(false);
    _historyStore.setEmptyHistory();
    await _historyStore.fetchRoutes();
    await _historyStore.fetchOrders();
    _historyStore.setFinishLoadingHistory(true);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_historyStore.routesHistory == null) {
        await fetchRoutesAndOrders();
        _historyStore.setFinishLoadingHistory(true);
      }
    });
    super.initState();
  }

  List<MOrder?>? getRouteOrders(MRoute? route) {
    return _historyStore.ordersHistory!
        .where((order) => order!.assignedRouteID == route!.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Material(
            child: !_historyStore.finishLoadingHistory
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.green))
                : Column(children: [
                    const SizedBox(height: 70),
                    Row(children: [
                      const SizedBox(width: 20),
                      const Text("History",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 200),
                      OutlinedButton(
                          onPressed: () {
                            fetchRoutesAndOrders();
                          },
                          child: const Icon(Icons.refresh))
                    ]),
                    const SizedBox(height: 20),
                    Row(children: const [
                      SizedBox(width: 20),
                      Text("Trips",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400))
                    ]),
                    const Divider(thickness: 1),
                    Observer(
                        builder: (_) => Container(
                            child: _historyStore.routesHistory!.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        itemCount:
                                            _historyStore.routesHistory!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Observer(
                                              builder: (_) =>
                                                  HistoryRouteListItem(
                                                      _historyStore
                                                              .routesHistory![
                                                          index],
                                                      getRouteOrders(_historyStore
                                                              .routesHistory![
                                                          index])));
                                        }))
                                : Center(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      SizedBox(height: 150),
                                      Image(
                                          image: AssetImage(
                                              'assets/images/no_route.png')),
                                      SizedBox(height: 20),
                                      Text('You have made any routes yet.')
                                    ],
                                  ))))
                  ])));
  }
}
