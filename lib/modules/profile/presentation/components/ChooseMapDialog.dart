import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mps_driver_app/modules/profile/presentation/ProfileViewModel.dart';

import '../../../../theme/app_colors.dart';

class ChooseMapDialog{
  final viewModel = Modular.get<ProfileViewModel>();

  Future<void> call(BuildContext context) async {
    final width = MediaQuery.of(context).size.width;
    showDialog(context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              alignment: Alignment.center,
              insetPadding: EdgeInsets.only(
                  left: width / 10, right: width / 10),
              child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(child: Text("Choose map",
                        style: TextStyle(fontSize: 20, fontFamily: 'Poppins')),
                        padding: EdgeInsets.only(top: 15)),
                    SizedBox(height: 8),
                    Text("Select your favorite map it will be saved"),
                    SizedBox(height: 8),
                    getOptions()
                  ]));
        });
  }
  
  Widget getOptions(){
    var dialogHeight = (55*viewModel.chosenMapsList.length);
    if(dialogHeight > 200) dialogHeight = 200;
    return Container(height: dialogHeight.toDouble(), width: 300,
        alignment: Alignment.center,
        child: Observer(builder: (_) => ListView.builder(itemCount: viewModel.chosenMapsList.length,
            itemBuilder: (BuildContext context, int index){
              return Row(children: [
                SizedBox(width: 60),
                Observer(builder: (_) => Checkbox(
                  activeColor: App_Colors.primary_color.value,
                    value: viewModel.chosenMapsList[index].mapName == viewModel.chosenMap.value.mapName,
                    shape: CircleBorder(),
                    checkColor: App_Colors.primary_color.value,
                    onChanged: (bool? value){
                      viewModel.setChosenMap(viewModel.chosenMapsList[index]);
                    })),
                Observer(builder: (_) => GestureDetector(child: Text(
                    viewModel.chosenMapsList[index].mapName, style:
                    TextStyle(fontSize: 14, fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500, color: viewModel.chosenMapsList[index]
                    .mapName == viewModel.chosenMap.value.mapName ?
                    App_Colors.black_text.value : App_Colors.grey_dark.value)),
                onTap: () => viewModel.setChosenMap(viewModel.chosenMapsList[index])))
              ]);
            })));
  }
}