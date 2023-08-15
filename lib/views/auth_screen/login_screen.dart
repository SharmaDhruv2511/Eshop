import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/consts/lists.dart';
import 'package:shoppingapp/controllers/auth_controller.dart';
import 'package:shoppingapp/views/auth_screen/signup_screen.dart';
import 'package:shoppingapp/views/home_screen/home.dart';
import 'package:shoppingapp/widgets_common/applogo_widgets.dart';
import 'package:shoppingapp/widgets_common/bg_widget.dart';
import 'package:shoppingapp/widgets_common/custom_textfield.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  const  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in $appname".text.fontFamily(bold).white.size(18).make(),

            15.heightBox,

            Obx(()=>Column(
                children: [
                  customTextField(email, emailHint,controller.emailController, false),
                  customTextField(password, passwordHint, controller.passwordController , true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: forgetPass.text.make()),
                  ),
                  5.heightBox,

                  controller.isLoading.value? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ) :
                  ourButton(redColor, whiteColor, login, ()async{
                    controller.isLoading(true);

                    await controller.loginMethod(context).then((value){
                      if(value!=null){
                        VxToast.show(context, msg: loggedIn);
                        Get.offAll(()=> const Home());
                      }else{
                        controller.isLoading(false);
                      }
                    });
                    // Get.to(()=>const Home());
                  }).box.width(context.screenWidth - 50).make(),

                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(lightGolden, redColor, signup, (){
                    Get.to(()=> const SignupScreen());
                  }).box.width(context.screenWidth - 50).make(),

                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index], width: 30,),
                      ),
                    )),
                  )

                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
      ),
    ));
  }
}
