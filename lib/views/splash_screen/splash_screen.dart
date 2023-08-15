import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/views/auth_screen/login_screen.dart';
import 'package:shoppingapp/views/home_screen/home.dart';
import 'package:shoppingapp/widgets_common/applogo_widgets.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating method to change screen

  changeScreen(){
    
    Future.delayed(const Duration(seconds:3),(){
      // Get.to(()=> const LoginScreen());

      auth.authStateChanges().listen((User? user) {

        if(user == null && mounted){
          Get.to(()=>  const LoginScreen());
        }else{
          Get.to(()=> const Home());
        }

      });

    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: Image.asset(icSplashBg, width: 300,)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //our splash screen UI is completed
          ],
        ),
      ),
    );
  }
}
