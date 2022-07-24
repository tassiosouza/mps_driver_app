import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/main/presentation/MainViewModel.dart';
import '../../../Services/DriverService.dart';
import '../../../models/Driver.dart';
import '../../../theme/app_colors.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  bool _isLoading = true;
  Driver? _currentDriver;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Amplify.DataStore.start();
      _currentDriver = await DriverService.getCurrentDriver();
      if (_currentDriver!.onBoard == true) {
        Modular.to.navigate('/main');
      }
      setState(() {
        _currentDriver = _currentDriver;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 32),
                      alignment: Alignment.topRight,
                      child: const Text('',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          )),
                    ),
                    const Expanded(
                      flex: 3,
                      child: Image(
                          image: AssetImage('assets/images/onBoarding1.png')),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Poppings',
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30, top: 10),
                        child: Row(children: [
                          const Text(
                            'to Meal Prep Sunday, ',
                            style: const TextStyle(
                                color: const Color(0xff363636),
                                fontFamily: 'Poppings',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _currentDriver!.name.split(' ')[0],
                            style: const TextStyle(
                                color: Colors.green,
                                fontFamily: 'Poppings',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ])),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        color: Colors.green,
                      ),
                      height: 200,
                      child: Column(children: [
                        Container(
                            padding: const EdgeInsets.all(25),
                            child: const Text(
                              'Here you can view your optimized route and get directions to your destinations, along with interact with customers quickly and easily.',
                              style: TextStyle(color: Color(0xffF2F2F2)),
                            )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Colors.white),
                              fixedSize: const Size(300, 40),
                            ),
                            onPressed: () {
                              Modular.to.navigate('/main');
                            },
                            child: const Text(
                              'Get Started',
                              style: const TextStyle(
                                  color: Color(0xffF2F2F2),
                                  fontFamily: 'Poppings'),
                            ))
                      ]),
                    ),
                  ],
                )));
  }
}
