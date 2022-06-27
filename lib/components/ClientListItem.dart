import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mps_driver_app/Services/TwilioService.dart';
import 'package:mps_driver_app/pages/StartRoutePage/start_route_viewmodel.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/Client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'AppDialogs.dart';

class ClientItem extends StatelessWidget {
  Client client;
  int clientIndex;
  StartRouteViewModel screenViewModel;

  ClientItem(this.client, this.screenViewModel, this.clientIndex, {Key? key})
      : super(key: key);
  late var availableMaps;

  final ImagePicker _picker = ImagePicker();

  TwilioSmsService smsService = new TwilioSmsService();
  XFile? _imageFile;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}h${twoDigitMinutes}m"
        .replaceAll('00h', '');
  }

  void _launchMapsUrl() async {
    availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(client.coordinates.latitude, client.coordinates.longitude),
      title: client.name,
      description: client.name,
    );
  }

  Future<void> deliveryInstructionsDialog(context) {
    return AppDialogs().showDialogJustMsg(
        context, "Delivery Instructions", client.deliveryInstructions);
  }

  Future<void> sendSms(XFile? photo) async {
    String url = await createAndUploadFile(photo!);
    smsService.sendSmsWithPhoto(client.phone, url);
  }

  void _setImageFileFromFile(XFile? value) {
    _imageFile = value;
  }

  dynamic _pickImageError;
  String? _retrieveDataError;

  Future<String> createAndUploadFile(XFile pickedFile) async {
    // Upload image with the current time as the key
    final key = DateTime.now().toString();
    final file = File(pickedFile.path);
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          onProgress: (progress) {
            print("Fraction completed: ${progress.getFractionCompleted()}");
          });
      print('Successfully uploaded image: ${result.key}');
      GetUrlResult urlResult = await Amplify.Storage.getUrl(key: result.key);
      return urlResult.url;
    } on StorageException catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 800,
        imageQuality: 100,
      );
      sendSms(pickedFile);
      // ignore: empty_catches
    } catch (e) {}
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  _launchCaller(String phone) async {
    var url = "tel:+1$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1.0, color: App_Colors.grey_light.value)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(width: 15),
        Expanded(
          child: IntrinsicWidth(
            child: Column(
              children: [
                Row(children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                            width: 1, color: App_Colors.grey_light.value)),
                    child: Icon(Icons.person,
                        size: 40, color: App_Colors.grey_light.value),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: client.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: App_Colors.black_text.value,
                                  fontFamily: 'Poppins'))),
                      Text(client.address,
                          style: TextStyle(
                              color: App_Colors.black_text.value,
                              fontFamily: 'Poppins',
                              fontSize: 12)),
                    ],
                  )),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () => deliveryInstructionsDialog(context),
                          child: Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.info_outline,
                                color: Colors.green,
                                size: 20,
                              ))),
                      const SizedBox(height: 40)
                    ],
                  )
                ]),
                Divider(color: App_Colors.grey_light.value, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getButtonIcon(CustomIcon.sms_driver_icon, client, false),
                    getButtonIcon(CustomIcon.call_driver_icon, client, true),
                    Observer(builder: (_) => bagIcon(client.check)),
                    const SizedBox(width: 1),
                    ElevatedButton(
                      onPressed: () {
                        _launchMapsUrl();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              App_Colors.primary_color.value),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)))),
                      child: Row(children: const [
                        Text("Start",
                            style:
                                TextStyle(fontSize: 13, fontFamily: 'Poppins')),
                        SizedBox(width: 10),
                        Icon(CustomIcon.start_driver_icon, size: 9)
                      ]),
                    ),
                    SizedBox(width: 1),
                  ],
                ),
              ],
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(children: [
            VerticalDivider(
                color: App_Colors.grey_light.value, thickness: 1, width: 0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.green,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                    child: Container(
                        child: Text(
                          "${clientIndex + 1}°",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        padding: EdgeInsets.only(
                            left: 35, right: 35, top: 8, bottom: 8))),
                getCameraIcon(
                    Icon(CustomIcon.camera_driver_icon,
                        size: 17, color: App_Colors.primary_color.value),
                    client,
                    () => _onImageButtonPressed(ImageSource.camera,
                        context: context),
                    context),
                Text(
                  "Deliver",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: 5),
                Text(
                  client.id,
                  style: TextStyle(
                      color: App_Colors.grey_text.value,
                      fontSize: 14,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: 5)
              ],
            )
          ]),
        )
      ]),
    );
  }

  bagIcon(bool check) {
    if (check) {
      return getButtonIcon(Icons.check, client, false);
    } else {
      return SizedBox(
          width: 30,
          height: 28,
          child: ElevatedButton(
            onPressed: () => client.setCheck(true),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(
                  App_Colors.white_background.value), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.lightGreen; // <-- Splash color
              }),
            ),
            child: Icon(CustomIcon.bag_driver_icon,
                size: 14, color: App_Colors.primary_color.value),
          ));
    }
  }

  getButtonIcon(IconData icon, Client client, bool isCall) {
    return SizedBox(
        width: 30,
        height: 28,
        child: ElevatedButton(
          onPressed: () => isCall
              ? _launchCaller(client.phone.replaceAll(' ', ''))
              : _sendSMS("", [client.phone]),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all(
                App_Colors.white_background.value), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed))
                return Colors.lightGreen; // <-- Splash color
            }),
          ),
          child: Icon(icon, size: 14, color: App_Colors.primary_color.value),
        ));
  }

  getCameraIcon(
      Icon icon, Client client, Function function, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: SizedBox(
            width: 38,
            height: 35,
            child: ElevatedButton(
              onPressed: () =>
                  _onImageButtonPressed(ImageSource.camera, context: context),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all(
                    App_Colors.white_background.value), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.lightGreen; // <-- Splash color
                }),
              ),
              child: icon,
            )));
  }
}
