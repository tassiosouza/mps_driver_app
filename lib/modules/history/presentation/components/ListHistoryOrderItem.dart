import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mps_driver_app/models/ModelProvider.dart';
import 'package:mps_driver_app/theme/app_colors.dart';

// ignore: must_be_immutable
class ListHistoryOrderItem extends StatelessWidget {
  MpsOrder order;
  ListHistoryOrderItem(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: App_Colors.grey_light.value,
        margin: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
        elevation: 0,
        child: Container(
          padding:
              const EdgeInsets.only(left: 30, right: 40, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(order.number),
                Text(order.deliveryInstruction.toString())
              ]),
              const SizedBox(height: 10),
              Text(order.customer!.name),
              Text(order.customer!.address)
            ],
          ),
        ));
  }
}
