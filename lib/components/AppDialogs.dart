import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

class AppDialogs {
  Future<void> showDialogJustMsg(
      BuildContext context, String title, String text) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      // ignore: unnecessary_const
                      const BorderRadius.all(const Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding: EdgeInsets.only(
                  top: height / 3.1,
                  bottom: height / 3.1,
                  left: width / 10,
                  right: width / 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Poppins')),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins'),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: App_Colors.primary_color.value),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ),
                  ]));
        });
  }

  Future<List<AutocompletePrediction>> getPredictions(
      GooglePlace googlePlace, String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      return result.predictions!;
    }
    return [];
  }

  Future<void> showSelectAddressDialog(
      BuildContext context, GooglePlace googlePlace, Function function) async {
    final width = MediaQuery.of(context).size.width;
    var address = 'fdgdfg';
    Timer? _debounce;
    List<AutocompletePrediction> _predictions = [];

    updatePredictions(
        StateSetter setState, List<AutocompletePrediction> value) {
      setState(() {
        _predictions = value;
      });
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                insetPadding:
                    EdgeInsets.only(left: width / 10, right: width / 10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 25),
                        child: const Text('Select destination',
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.location_pin),
                            ),
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false) {
                                _debounce!.cancel();
                              }

                              _debounce =
                                  Timer(const Duration(milliseconds: 10), () {
                                if (value.isNotEmpty) {
                                  getPredictions(googlePlace, value).then(
                                      (value) => {
                                            log(value.toString()),
                                            updatePredictions(setState, value)
                                          });
                                } else {
                                  updatePredictions(setState, []);
                                }
                              });
                            }),
                      ),
                      SingleChildScrollView(
                        child: _predictions.isEmpty
                            ? Container()
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: ListTile(
                                            title: Text(
                                                _predictions[index]
                                                        .description ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins')),
                                            onTap: () {
                                              function(_predictions[index]
                                                  .description);
                                              Navigator.pop(context);
                                            },
                                          )),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: const Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 30),
                    ]));
          });
        });
  }

  Future<void> showConfirmDialog(BuildContext context, Function function,
      String title, String? text) async {
    final width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding:
                  EdgeInsets.only(left: width / 10, right: width / 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'Poppins')),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(text!,
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Poppins', height: 0),
                          textAlign: TextAlign.justify),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: App_Colors.grey_light.value),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "CANCEL",
                              style:
                                  TextStyle(color: App_Colors.grey_dark.value),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: App_Colors.primary_color.value),
                            onPressed: () {
                              function();
                              Navigator.pop(context);
                            },
                            child: const Text("CONFIRM"),
                          ),
                        ),
                      ],
                    ),
                  ]));
        });
  }
}
