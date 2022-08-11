import 'dart:async';
import 'dart:developer';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../models/MpsRoute.dart';
import '../../../utils/GetListRouteFromQuery.dart';
import '../../route/presentation/RouteViewModel.dart';
import 'components/HistoryRouteListItem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final _routeViewModel = Modular.get<RouteViewModel>();

  GraphQLClient initGqlClient(String url) {
    final link = HttpLink(
      url,
      defaultHeaders: {
        'x-api-key': 'da2-qhpgfyyngje3tmlbbf5na574sq',
        'Content-Type': 'application/json',
      },
    );

    final client = GraphQLClient(link: link, cache: GraphQLCache());

    return client;
  }

  processRoutes(List<MpsRoute> routes) async {
    if (routes.isEmpty) {
      _routeViewModel.setEmptyHistory();
      _routeViewModel.setFinishLoadingHistory(true);
      return;
    }

    List<MpOrder> ordersProcessed = [];
    for (int i = 0; i < routes.length; i++) {
      await Amplify.DataStore.query(MpOrder.classType,
              where: MpOrder.ROUTEID.eq(routes[i].getId()))
          .then((orders) async => {
                for (int k = 0; k < orders.length; k++)
                  {
                    await Amplify.DataStore.query(Customer.classType,
                            where: Customer.ID.eq(orders[k].mpOrderCustomerId))
                        .then((customer) => {
                              ordersProcessed.add(orders[k].copyWith(
                                  customer: customer[0],
                                  deliveryInstruction:
                                      orders[k].updatedAt.toString())),
                            }),
                  },
              });
      if (routes[i].status == RouteStatus.DONE) {
        _routeViewModel
            .addToRoutesHistory(routes[i].copyWith(orders: ordersProcessed));
        ordersProcessed = [];
        if (i == routes.length - 1) //last route added
        {
          _routeViewModel.setFinishLoadingHistory(true);
        }
      }
    }
  }

  Future<void> fetchRoutes() async {
    _routeViewModel.setFinishLoadingHistory(false);
    _routeViewModel.setEmptyHistory();
    String? driverId = _routeViewModel.currentDriver?.id;

    var graphQLClient = initGqlClient(
        'https://27e6dnolwrdabfwawi2u5pfe4y.appsync-api.us-west-1.amazonaws.com/graphql');

    String readRoute = """
  query MyQuery {
    listMpsRoutes(filter: {mpsRouteDriverId: {eq: "$driverId"}}) {
      items {
        name
        startTime
        status
        endTime
        cost
        id
        distance
        duration
        orders {
          items {
            number
            createdAt
            customer {
              address
              name
            }
            id
            status
          }
        }
      }
    }
  }
    """;
    var result = await graphQLClient.query(QueryOptions(
      document: gql(readRoute),
    ));
    final getListRouteFromQuery = GetListRouteFromQuery();
    processRoutes(getListRouteFromQuery(result.data?['listMpsRoutes']));
    print(result.data);
    print(_routeViewModel.currentDriver!.id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await _routeViewModel.syncAmplifyData();

      if (_routeViewModel.routesHistory == null) {
        await fetchRoutes();
      }
    });
    super.initState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Material(
            child: !_routeViewModel.finishLoadingHistory
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
                            fetchRoutes();
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
                            child: _routeViewModel.routesHistory!.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        itemCount: _routeViewModel
                                            .routesHistory!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Observer(
                                              builder: (_) =>
                                                  HistoryRouteListItem(
                                                      _routeViewModel
                                                              .routesHistory![
                                                          index]));
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
