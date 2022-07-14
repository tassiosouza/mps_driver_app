import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/route/presentation/route_viewmodel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../theme/app_colors.dart';

class InitRoutePage extends StatefulWidget {
  RouteViewModel routeViewModel = Modular.get<RouteViewModel>();
  _InitRoutePage createState() => _InitRoutePage();
}

class _InitRoutePage extends State<InitRoutePage> {
  Driver? _currentDriver;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDriverInformation();
    });
    super.initState();
  }

  void loadDriverInformation() async {
    Driver? driver = await DriverService.getCurrentDriver();
    setState(() {
      _currentDriver = driver;
    });
  }

  Future<void> getClientList() async {
    Modular.to.pushNamed('./loading');
    // await widget.routeViewModel.getClientList();
    await widget.routeViewModel.getOrderList(_currentDriver!);
    Modular.to.navigate('./inroute');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.routeViewModel.clientList.isNotEmpty) {
      Modular.to.navigate('./inroute');
      return Center();
    } else {
      Future.delayed(Duration(seconds: 2),
      () => widget.routeViewModel.backToFirstOpenState());

    }
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Image(image: AssetImage('assets/images/initNewRouteScreen.png')),
          SizedBox(height: 48),
          Text(
            "Upload your route",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: App_Colors.black_text.value,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Please, upload the route you received from the logistics team",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: App_Colors.grey_text.value,
                    fontSize: 16,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 70,
          ),
          Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () => getClientList(),
                style: ElevatedButton.styleFrom(
                    primary: App_Colors.primary_color.value),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CustomIcon.upload_icon, size: 20),
                          SizedBox(width: 20),
                          Text("Upload route",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Poppins')),
                        ])),
              ))
        ],
      ),
    );
  }
}
