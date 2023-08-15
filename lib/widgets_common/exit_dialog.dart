import 'package:flutter/services.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min ,
      children: [
        "Confirm".text.fontFamily(semibold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(redColor, whiteColor, "Yes", (){
              SystemNavigator.pop();
            }),

            ourButton(redColor, whiteColor, "No", (){
              Navigator.pop(context);
            })
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}