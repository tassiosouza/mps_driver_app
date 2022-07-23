// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_place/google_place.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../../Services/DriverService.dart';
import '../../../components/AppDialogs.dart';
import '../../../models/Driver.dart';
import '../../../models/MpsOrder.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../../models/Route.dart' as route_model;
import '../services/PickRouteFile.dart';
import 'RouteViewModel.dart';

class InitRoutePage extends StatefulWidget {
  const InitRoutePage({Key? key}) : super(key: key);

  @override
  createState() => _InitRoutePage();
}

class _InitRoutePage extends State<InitRoutePage> {
  Driver? _currentDriver;
  late StreamSubscription<QuerySnapshot<route_model.Route>> _subscription;
  PickRouteFile pickRouteFile = PickRouteFile();
  final viewModel = Modular.get<RouteViewModel>();
  late GooglePlace googlePlace;
  Timer? _debounce;

  @override
  void initState() {
    Driver? driver;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Amplify.DataStore.start();
      driver = await loadDriverInformation();

      _subscription =
          Amplify.DataStore.observeQuery(route_model.Route.classType)
              .listen((QuerySnapshot<route_model.Route> snapshot) {
        for (route_model.Route route in snapshot.items) {
          if (route.routeDriverId == driver!.id &&
              (route.status != RouteStatus.DONE &&
                  route.status != RouteStatus.ABORTED)) {
            Modular.to.navigate('./inroute');
            _subscription.cancel();
          }
        }
      });
      googlePlace = GooglePlace('AIzaSyBtiYdIofNKeq0cN4gRG7L1ngEgkjDQ0Lo');
    });

    viewModel.setFirstEndAddress();

    super.initState();
  }

  Future<Driver?> loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentDriver = driver;
      });
    });
    return driver;
  }

  Future<void> uploadRoute() async {
    Modular.to.pushNamed('./loading');
    route_model.Route route = route_model.Route(
        name: "R100 - ${_currentDriver!.name}",
        routeDriverId: _currentDriver!.id,
        status: RouteStatus.PLANNED,
        driver: _currentDriver);

    var orderList = await pickRouteFile.readOrdersFromFile(route);

    route =
        route.copyWith(orders: orderList, name: pickRouteFile.getFileName());

    uploadRouteToAmplify(route);
  }

  Future<void> chooseEndAddressDialog() {
    return AppDialogs().showDialogJustMsg(context, "Attention",
        "Chose a correct address or check Meal Prep Sunday to load your route.");
  }

  Future<void> uploadRouteToAmplify(route_model.Route route) async {
    for (MpsOrder order in route.orders!) {
      await Amplify.DataStore.save(order.customer!.coordinates!);
      await Amplify.DataStore.save(order.customer!);
      await Amplify.DataStore.save(order);
    }
    await Amplify.DataStore.save(route);
  }

  Color getOptionsTextColor(bool isChecked){
    if(isChecked){
      return App_Colors.black_text.value;
    } else {
      return App_Colors.grey_text.value;
    }
  }

  void getPredictions(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if(result != null && result.predictions != null && mounted){
      viewModel.addPredictions(result.predictions!);
    }
  }

  final _autocompleteController = TextEditingController();
  final focusNode = FocusNode();
  DetailsResult? detailsResult;

  Widget getTextFieldCustomEndAddress(){
    if(viewModel.endAddress.value == 'Meal Prep Sunday'){
      return const SizedBox(height: 90);
    } else {
      return Container(padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
          child: TextField(decoration: InputDecoration(icon: Icon(Icons.location_on_outlined,
          color: App_Colors.primary_color.value)),
          controller: _autocompleteController, style: const TextStyle(fontSize: 14),
          focusNode: focusNode,
          onChanged: (value){
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(const Duration(milliseconds: 1000), () {
            if(value.isNotEmpty){
              viewModel.clearPredictions();
              getPredictions(value);
            } else {
              viewModel.clearPredictions();
              detailsResult = null;
            }});
          }));
    }
  }

  chooseEndAddress(int index) async {
    viewModel.setEndAddress(viewModel.predictions[index].description.toString());
    _autocompleteController.text = viewModel.predictions[index].description.toString();
    final details = await googlePlace.details.get(viewModel.predictions[index].placeId);
    detailsResult = details?.result;
    viewModel.clearPredictions();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Image(
              image: AssetImage('assets/images/initNewRouteScreen.png')),
          const SizedBox(height: 30),
          Text(
            "Upload your route",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: App_Colors.black_text.value,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Please select your final destination and upload the route you received from the logistics team",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: App_Colors.grey_text.value,
                    fontSize: 16,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 20),
          Row(children: [
            SizedBox(width: 60),
            Observer(builder: (_) => Checkbox(
                activeColor: App_Colors.primary_color.value,
                value: viewModel.endAddress.value == 'Meal Prep Sunday',
                shape: CircleBorder(),
                checkColor: App_Colors.primary_color.value,
                onChanged: (bool? value){
                  viewModel.setEndAddress('Meal Prep Sunday');
                  viewModel.clearPredictions();
                  _autocompleteController.clear();
                })),
            Observer(builder: (_) => GestureDetector(child: Text(
                'Meal Prep Sunday', style:
            TextStyle(fontSize: 14, fontFamily: 'Poppins',
                fontWeight: FontWeight.w500, color:
                getOptionsTextColor(viewModel.endAddress.value == 'Meal Prep Sunday'))),
                onTap: () => {}))
          ]),
          Row(children: [
            SizedBox(width: 60),
            Observer(builder: (_) => Checkbox(
                activeColor: App_Colors.primary_color.value,
                value: viewModel.endAddress.value != 'Meal Prep Sunday',
                shape: CircleBorder(),
                checkColor: App_Colors.primary_color.value,
                onChanged: (bool? value){
                  viewModel.setEndAddress('');
                })),
            Observer(builder: (_) => GestureDetector(child: Text(
                'Custom', style:
            TextStyle(fontSize: 14, fontFamily: 'Poppins',
                fontWeight: FontWeight.w500, color:
            getOptionsTextColor(viewModel.endAddress.value != 'Meal Prep Sunday'))),
                onTap: () => {}))
          ]),
          Observer(builder: (_) => getTextFieldCustomEndAddress()),
          Observer(builder: (_) => Container(height: viewModel.predictions.length*50,
              child: Observer(builder: (_){
                return ListView.builder(itemCount: viewModel.predictions.length,
                    itemBuilder: (context, index){
                      return ListTile(title: Text(viewModel.predictions[index].description.toString()),
                          onTap: () async {
                            chooseEndAddress(index);
                          },
                          leading: Icon(Icons.location_on_outlined));
                    });
              },))),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(child: ElevatedButton(
              onPressed: (){
                if((viewModel.endAddress.value != '' &&
                    viewModel.endAddress.value == _autocompleteController.text) ||
                    viewModel.endAddress.value == 'Meal Prep Sunday'){
                  uploadRoute();
                } else {
                  chooseEndAddressDialog();
                }
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                  App_Colors.primary_color.value), padding: MaterialStateProperty.all(
                  EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10)
              ),
              ),
              child: Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CustomIcon.upload_icon, size: 20),
                    SizedBox(width: 20), Text("Upload route",
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                  ])),
            ))],)
        ],
      ),
    );
  }
}
