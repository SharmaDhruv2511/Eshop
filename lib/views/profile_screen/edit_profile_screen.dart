import 'dart:io';

import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/controllers/profile_controller.dart';
import 'package:shoppingapp/widgets_common/bg_widget.dart';
import 'package:shoppingapp/widgets_common/custom_textfield.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();


    return bgWidget(Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(()=> Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            //if data imageurl  and controller path is empty
            data['imageUrl']== '' && controller.profileImgPath.isEmpty ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                :
            data['imageUrl'] != '' && controller.profileImgPath.isEmpty ? Image.network(data['imageUrl'], width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make() //if data is  not empty but controller path is empty
                : Image.file(File(controller.profileImgPath.value), width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(), //if both are empty

            10.heightBox,
            ourButton(redColor, whiteColor, "Change", (){
              controller.changeImage(context);
            }),
            const Divider(),
            20.heightBox,
            customTextField(name, nameHint, controller.nameController, false),
            10.heightBox,
            customTextField(oldPassword, passwordHint, controller.oldpassController, true),
            10.heightBox,
            customTextField(newPassword, passwordHint, controller.newpassController, true),
            20.heightBox,
            controller.isLoading.value ? const  CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ) : SizedBox(
                width: context.screenWidth - 60,
                child: ourButton(redColor, whiteColor, "Save", () async{

                  controller.isLoading(true);
                  //if image is not selected

                  if(controller.profileImgPath.value.isNotEmpty){
                    await controller.uploadProfileImage();
                  }else{
                    controller.profileImgLink = data['imageUrl'];
                  }

                  //if old password matches database

                  if(data['password'] == controller.oldpassController.text){

                    await controller.changeAuthPassowd(data['email'], controller.oldpassController.text, controller.newpassController.text);

                    await controller.updateProfile(controller.nameController.text, controller.newpassController.text, controller.profileImgLink);
                    VxToast.show(context, msg: "Updated");
                  }else{
                    VxToast.show(context, msg: "Wrong Old Passoword");
                    controller.isLoading(false);
                  }



                })),
          ],
        ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12)).rounded.make(),
      ),


    ));
  }
}
