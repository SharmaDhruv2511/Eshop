import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/controllers/auth_controller.dart';
import 'package:shoppingapp/views/home_screen/home.dart';
import 'package:shoppingapp/widgets_common/applogo_widgets.dart';
import 'package:shoppingapp/widgets_common/bg_widget.dart';
import 'package:shoppingapp/widgets_common/custom_textfield.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),

            15.heightBox,

            Obx(()=>Column(
                children: [
                  customTextField(name, nameHint, nameController, false),
                  customTextField(email, emailHint, emailController, false),
                  customTextField(password, passwordHint, passwordController, true),
                  customTextField(retypePassword, passwordHint, passwordRetypeController, true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: forgetPass.text.make()),
                  ),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                        value: isCheck,onChanged: (newValue){
                          setState(() {
                            isCheck = newValue;
                          });
                      }),
                      10.widthBox,
                      Expanded(child:
                      RichText(text: const TextSpan(
                          children: [
                            TextSpan(text: "I agree to the", style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                            TextSpan(text: termAndCond, style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                            TextSpan(text: " &", style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                            TextSpan(text: privacyPolicy, style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ))
                          ]
                      )))
                    ],
                  ),

                  5.heightBox,

                  controller.isLoading.value? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ) :
                  ourButton(isCheck == true? redColor : lightGrey, whiteColor, signup, () async{

                    if (isCheck != false){

                      controller.isLoading(true);

                      try{

                        await controller.signupMethod(emailController.text, passwordController.text, context)
                            .then((value){
                              return controller.storeUserData(nameController.text, passwordController.text, emailController.text);
                        }).then((value){
                          VxToast.show(context, msg: loggedIn);
                          Get.offAll(()=> const Home());
                        });

                      }catch (e){
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                        controller.isLoading(false);

                      }

                    }

                  }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  //wrapping it with gesture detector of velocity
                  RichText(text: const TextSpan(
                    children: [
                      TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(
                          fontFamily: bold,
                          color: fontGrey,
                        )
                      ),
                      TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          )
                      )
                    ]
                  )).onTap(() {
                    Get.back();
                  }),
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
            ),
          ],
        ),
      ),
    ));
  }
}
