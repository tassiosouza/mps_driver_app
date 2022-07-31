import 'dart:async';
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

  processRoutes(List<MpsRoute> routes) {
    if (routes.isEmpty) {
      _routeViewModel.setEmptyHistory();
      return;
    }

    MpsRoute routeProcessed;
    List<MpOrder> ordersProcessed = [];
    for (int i = 0; i < routes.length; i++) {
      routeProcessed = routes[i];
      Amplify.DataStore.query(MpOrder.classType,
              where: MpOrder.ROUTEID.eq(routeProcessed.getId()))
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
                              if (ordersProcessed.length == orders.length)
                                {
                                  if (routeProcessed.status == RouteStatus.DONE)
                                    {
                                      _routeViewModel.addToRoutesHistory(
                                          routeProcessed.copyWith(
                                              orders: ordersProcessed)),
                                    }
                                }
                            }),
                  },
              });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await _routeViewModel.syncAmplifyData();

      if (_routeViewModel.routesHistory == null) {
        var graphQLClient = initGqlClient(
            'https://27e6dnolwrdabfwawi2u5pfe4y.appsync-api.us-west-1.amazonaws.com/graphql');

        var result = await graphQLClient.query(QueryOptions(
          document: gql('''query MyQuery {
          listMpsRoutes(filter: {status: {eq: DONE}, mpsRouteDriverId: {eq: "721b705a-5799-4203-b62a-dea2a4b8cf0b"}}) {
            items {
              name
              distance
              mpsRouteDriverId
              id
              status
            }
          }
        }'''),
        ));

        Future.delayed(const Duration(milliseconds: 2000), () async {
// Here you can write your code

          await Amplify.DataStore.query(MpsRoute.classType,
                  where: MpsRoute.MPSROUTEDRIVERID
                      .eq(_routeViewModel.currentDriver!.id))
              .then((routes) async => {processRoutes(routes)});
        });
      }

      // //   //Build the list of routes with all the route information ready
      // Amplify.DataStore.query(MpsRoute.classType,
      //         where: MpsRoute.MPSROUTEDRIVERID
      //             .eq(_routeViewModel.currentDriver?.getId()))
      //     .the((QuerySnapshot<MpsRoute> snapshot) {
      //   for (int i = 0; i < snapshot.items.length; i++) {
      //     MpsRoute currentRoute = snapshot.items[i];
      //     List<MpOrder> currentOrders = [];
      //     Amplify.DataStore.query(MpOrder.classType,
      //             where: MpOrder.ROUTEID.eq(currentRoute.getId()))
      //         .then((orders) async => {
      //               for (int k = 0; k < orders.length; k++)
      //                 {
      //                   await Amplify.DataStore.query(Customer.classType,
      //                           where:
      //                               Customer.ID.eq(orders[k].mpOrderCustomerId))
      //                       .then((customer) => {
      //                             currentOrders.add(orders[k].copyWith(
      //                                 customer: customer[0],
      //                                 deliveryInstruction:
      //                                     orders[k].updatedAt.toString())),
      //                             if (currentOrders.length == orders.length)
      //                               {
      //                                 if (currentRoute.status ==
      //                                     RouteStatus.DONE)
      //                                   {
      //                                     _routesList.add(currentRoute.copyWith(
      //                                         orders: currentOrders)),
      //                                     //set orders state when retrieved the last list of orders from routes
      //                                     setState(() {
      //                                       _routesList = _routesList;
      //                                       _isLoading = false;
      //                                     }),
      //                                   }
      //                               }
      //                           }),
      //                 },
      //             });
      //   }
      // });

//       if (_routeViewModel.routesHistory == null) {
//         // await _routeViewModel.fetchRoutesHistory();
//         await _routeViewModel.syncAmplifyData();

//         var graphQLClient = initGqlClient(
//             'https://27e6dnolwrdabfwawi2u5pfe4y.appsync-api.us-west-1.amazonaws.com/graphql');

//         var result = await graphQLClient.query(QueryOptions(
//           document: gql('''query MyQuery {
//   listMpsRoutes(filter: {status: {eq: DONE}, mpsRouteDriverId: {eq: "721b705a-5799-4203-b62a-dea2a4b8cf0b"}}) {
//     items {
//       name
//       distance
//       mpsRouteDriverId
//       id
//       status
//     }
//   }
// }'''),
//         ));

//         if (!mounted) return;
//         setStateIfMounted(() {
//           _isLoading = false;
//         });
//       } else {
//         setStateIfMounted(() {
//           _isLoading = false;
//           _routesList = _routeViewModel.routesHistory!;
//         });
//       }
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
            child: _routeViewModel.routesHistory == null
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.green))
                : Column(children: [
                    const SizedBox(height: 70),
                    Row(children: const [
                      SizedBox(width: 20),
                      Text("History",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500))
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
