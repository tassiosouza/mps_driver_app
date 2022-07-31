// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:async';
import 'dart:typed_data';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/modules/route/presentation/RouteViewModel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import '../../../models/Driver.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql_http_link/gql_http_link.dart';
import '../services/PickRouteFile.dart';

class InitRoutePage extends StatefulWidget {
  const InitRoutePage({Key? key}) : super(key: key);

  @override
  createState() => _InitRoutePage();
}

class _InitRoutePage extends State<InitRoutePage> {
  Driver? _currentDriver;
  bool _isCustomSelected = false;
  String _customAddress = 'Custom';
  late GooglePlace googlePlace;
  late StreamSubscription<QuerySnapshot<MpsRoute>> _subscription;
  PickRouteFile pickRouteFile = PickRouteFile();
  Timer? _debounce;
  late MpsRoute? _createdRoute;
  final _routeViewModel = Modular.get<RouteViewModel>();

  StreamSubscription<GraphQLResponse<MpsRoute>>? subscription;

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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_routeViewModel.isRouteActived) {
        Modular.to.navigate('./inroute');
      }

      var graphQLClient = initGqlClient(
          'https://27e6dnolwrdabfwawi2u5pfe4y.appsync-api.us-west-1.amazonaws.com/graphql');

      final subscriptionRequest =
          ModelSubscriptions.onCreate(MpsRoute.classType);
      final Stream<GraphQLResponse<MpsRoute>> operation = Amplify.API.subscribe(
        subscriptionRequest,
        onEstablished: () => print('Subscription established'),
      );

      subscription = operation.listen(
        (event) async {
          print('Subscription event data received: ${event.data}');
          _routeViewModel.setlastActivedRoute(_createdRoute!);
          _routeViewModel.setIsRouteActived(true);
          Modular.to.navigate('./inroute');
        },
        onError: (Object e) => print('Error in subscription stream: $e'),
      );

      googlePlace = GooglePlace('AIzaSyBtiYdIofNKeq0cN4gRG7L1ngEgkjDQ0Lo');
    });

    super.initState();
  }

  Future<void> uploadRoute() async {
    Modular.to.pushNamed('./loading');
    MpsRoute route = MpsRoute(
        name: "Route - ${_currentDriver!.name}",
        mpsRouteDriverId: _currentDriver!.id,
        status: RouteStatus.PLANNED);

    var orderList = await pickRouteFile.readOrdersFromFile(
        route, _customAddress != 'Custom' ? _customAddress : '');

    route = route.copyWith(
        orders: orderList,
        name: pickRouteFile.getFileName(),
        distance: pickRouteFile.getLastRouteDistance(),
        duration: pickRouteFile.getLastRouteDuration());

    setState(() {
      _createdRoute = route;
    });
    uploadRouteToAmplify(route);
  }

  Future<void> chooseEndAddressDialog() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "Chose a correct address or check Meal Prep Sunday to load your route.");
  }

  Future<void> uploadRouteToAmplify(MpsRoute route) async {
    for (MpOrder order in route.orders!) {
      await Amplify.DataStore.save(order.customer!.coordinates!);
      await Amplify.DataStore.save(order.customer!);
      await Amplify.DataStore.save(order);
    }
    await Amplify.DataStore.save(route);
  }

  Future<void> getCustomAddress() {
    return AppDialogs().showSelectAddressDialog(
        context,
        googlePlace,
        (address) => {
              log('address set'),
              setState(() {
                _customAddress = address;
                _isCustomSelected = true;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        const Expanded(
          flex: 5,
          child:
              Image(image: AssetImage('assets/images/initNewRouteScreen.png')),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 1,
          child: Text(
            "Upload your route",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: App_Colors.black_text.value,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Please select your final destination and upload the route file.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: App_Colors.grey_text.value,
                    fontSize: 14,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              )),
        ),
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Checkbox(
                activeColor: App_Colors.primary_color.value,
                value: !_isCustomSelected,
                shape: const CircleBorder(),
                checkColor: App_Colors.primary_color.value,
                onChanged: (bool? value) {
                  setState(() {
                    _isCustomSelected = false;
                    _customAddress = 'Custom';
                  });
                }),
            GestureDetector(
                child: SizedBox(
                    width: 150,
                    child: Text('Meal Prep Sunday',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: App_Colors.grey_dark.value))),
                onTap: () => {})
          ]),
        ),
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Checkbox(
                activeColor: App_Colors.primary_color.value,
                value: _isCustomSelected,
                shape: const CircleBorder(),
                checkColor: App_Colors.primary_color.value,
                onChanged: (bool? value) {
                  if (value!) {
                    getCustomAddress();
                  }
                }),
            GestureDetector(
                child: SizedBox(
                    width: 150,
                    child: Text(_customAddress,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: App_Colors.grey_dark.value))),
                onTap: () => {})
          ]),
        ),
        const SizedBox(height: 30),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => uploadRoute(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        App_Colors.primary_color.value),
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        left: 80, right: 80, top: 10, bottom: 10)),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(CustomIcon.upload_icon, size: 20),
                        SizedBox(width: 20),
                        Text("Upload route",
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                      ]),
                ),
              ],
            )),
        const SizedBox(height: 10)
      ],
    );
  }
}
