// ignore_for_file: deprecated_member_use, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable, depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mps_driver_app/models/RouteStatus.dart';
import 'package:mps_driver_app/modules/route/presentation/RoutePage.dart';
import 'package:mps_driver_app/modules/route/services/TwilioService.dart';
import 'package:mps_driver_app/theme/CustomIcon.dart';
import 'package:mps_driver_app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../../../../models/Driver.dart';
import '../../../../models/MOrder.dart';
import '../../../../components/AppDialogs.dart';
import '../../../../models/OrderStatus.dart';
import '../../../profile/presentation/ProfileViewModel.dart';
import 'InstructionsDialog.dart';

class OrderItem extends StatelessWidget {
  MOrder? order;
  int orderIndex;
  Driver currentDriver;
  StateRoutePage routePageReference;
  TwilioSmsService? smsService;

  OrderItem(
      this.order, this.orderIndex, this.currentDriver, this.routePageReference,
      {Key? key})
      : super(key: key) {
    smsService = TwilioSmsService(currentDriver);
  }
  late var availableMaps;

  final ImagePicker _picker = ImagePicker();

  final profileViewModel = Modular.get<ProfileViewModel>();

  void _launchMapsUrl() async {
    if (profileViewModel.chosenMap.value.mapName == '') {
      await profileViewModel.getMapOptions();
      await profileViewModel.setDefaultMap();
    }
    await profileViewModel.chosenMap.value.showMarker(
      coords: Coords(order!.latitude!, order!.longitude!),
      title: order!.customerName!,
      description: order!.customerName!,
    );
  }

  Future<void> sendSms(XFile? photo) async {
    String url = await createAndUploadFile(photo!);
    if (url.isEmpty) {
      throw Exception('Photo exception');
    } else {
      // smsService?.sendSmsWithPhoto(order!.phone!, url);
      updateOrderStatusTo(OrderStatus.DELIVERED);
      routePageReference.verifyAllOrderStatusChanged(
          OrderStatus.DELIVERED, OrderStatus.CANCELED);
    }
  }

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
      return urlResult.url.replaceAll(' ', '');
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
    String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(result);
  }

  _launchCaller(String phone) async {
    var url = "tel:+1$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> updateOrderStatusTo(OrderStatus newStatus) async {
    await routePageReference.setOrderStatus(orderIndex, newStatus);
  }

  void verifyAll(OrderStatus status) {}

  Future<void> checkBagConfirmDialog(BuildContext context) {
    return AppDialogs().showConfirmDialog(
        context,
        () => {
              updateOrderStatusTo(OrderStatus.CHECKED),
              routePageReference
                  .verifyAllOrderStatusChanged(OrderStatus.CHECKED)
            },
        "Meal Instructions",
        order!.mealPlan);
  }

  Future<void> wrongCheckBagClickDialog(BuildContext context) {
    return AppDialogs()
        .showDialogJustMsg(context, "Attention", "Make checkin first.");
  }

  Future<void> wrongTakePhotoClickDialog(BuildContext context) {
    return AppDialogs().showDialogJustMsg(
        context, "Attention", "You need to be in transit to take photo.");
  }

  Future<void> wrongStartRouteClickDialog(BuildContext context) {
    return AppDialogs().showDialogJustMsg(
        context, "Attention", "You need to be in transit to start route.");
  }

  Color getStartButtonColor() {
    if (routePageReference.getRouteStatus() == RouteStatus.IN_TRANSIT) {
      return App_Colors.primary_color.value;
    } else {
      return App_Colors.grey_light.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Card(
              elevation: 0,
              margin: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      width: 1.0, color: App_Colors.grey_light.value)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        width: 1,
                                        color: App_Colors.grey_light.value)),
                                child: Icon(Icons.person,
                                    size: 40,
                                    color: App_Colors.grey_light.value),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          text: order!.customerName!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  App_Colors.black_text.value,
                                              fontFamily: 'Poppins'))),
                                  Text(order!.address!,
                                      style: TextStyle(
                                          color: App_Colors.black_text.value,
                                          fontFamily: 'Poppins',
                                          fontSize: 12)),
                                ],
                              )),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () => InstructionsDialog()
                                          .call(context, order!),
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: const Icon(
                                            Icons.info_outline,
                                            color: Colors.green,
                                            size: 20,
                                          ))),
                                  const SizedBox(height: 40)
                                ],
                              )
                            ]),
                            Divider(
                                color: App_Colors.grey_light.value,
                                thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                getButtonIcon(
                                    CustomIcon.sms_driver_icon, order!, false),
                                getButtonIcon(
                                    CustomIcon.call_driver_icon, order!, true),
                                bagIcon(order!.status, context),
                                const SizedBox(width: 1),
                                ElevatedButton(
                                  onPressed: () {
                                    if (routePageReference.getRouteStatus() ==
                                        RouteStatus.IN_TRANSIT) {
                                      _launchMapsUrl();
                                    } else {
                                      wrongStartRouteClickDialog(context);
                                    }
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.only(left: 20, right: 20)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              getStartButtonColor()),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.transparent)))),
                                  child: Row(children: const [
                                    Text("Start",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Poppins')),
                                    SizedBox(width: 10),
                                    Icon(CustomIcon.start_driver_icon, size: 9)
                                  ]),
                                ),
                                const SizedBox(width: 1),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(children: [
                        VerticalDivider(
                            color: App_Colors.grey_light.value,
                            thickness: 1,
                            width: 0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.green,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 35, right: 35, top: 8, bottom: 8),
                                    child: Text(
                                      "${orderIndex + 1}°",
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ))),
                            getCameraIcon(order!, context),
                            const Text(
                              "Deliver",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              order!.number!,
                              style: TextStyle(
                                  color: App_Colors.grey_text.value,
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 5)
                          ],
                        )
                      ]),
                    )
                  ]),
            ));
  }

  bagIcon(OrderStatus? status, BuildContext context) {
    Widget widget;
    if (order!.status != OrderStatus.CREATED) {
      widget = getButtonIcon(Icons.check, order!, false);
    } else {
      widget = SizedBox(
          width: 30,
          height: 28,
          child: ElevatedButton(
            onPressed: () {
              if (routePageReference.getRouteStatus() ==
                  RouteStatus.CHECKING_BAGS) {
                checkBagConfirmDialog(context);
              } else {
                wrongCheckBagClickDialog(context);
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(
                  App_Colors.white_background.value), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.lightGreen;
                } // <-- Splash color
              }),
            ),
            child: Icon(CustomIcon.bag_driver_icon,
                size: 14, color: App_Colors.primary_color.value),
          ));
    }
    return widget;
  }

  getButtonIcon(IconData icon, MOrder order, bool isCall) {
    return SizedBox(
        width: 30,
        height: 28,
        child: ElevatedButton(
          onPressed: () => isCall
              ? _launchCaller(order.phone!.replaceAll(' ', ''))
              : _sendSMS("", [order.phone!]),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all(
                App_Colors.white_background.value), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.lightGreen;
              } // <-- Splash color
            }),
          ),
          child: Icon(icon, size: 14, color: App_Colors.primary_color.value),
        ));
  }

  getCameraIcon(MOrder order, BuildContext context) {
    Icon icon;
    if (order.status == OrderStatus.DELIVERED) {
      icon = Icon(Icons.check, size: 17, color: App_Colors.primary_color.value);
    } else if (order.status == OrderStatus.CANCELED) {
      icon =
          Icon(Icons.cancel, size: 17, color: App_Colors.primary_color.value);
    } else {
      icon = Icon(CustomIcon.camera_driver_icon,
          size: 17, color: App_Colors.primary_color.value);
    }
    return Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: SizedBox(
            width: 38,
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                if (routePageReference.getRouteStatus() ==
                    RouteStatus.IN_TRANSIT) {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                } else {
                  wrongTakePhotoClickDialog(context);
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all(
                    App_Colors.white_background.value), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.lightGreen;
                  } // <-- Splash color
                }),
              ),
              child: icon,
            )));
  }
}
