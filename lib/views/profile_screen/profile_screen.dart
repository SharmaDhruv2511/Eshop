import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/consts/lists.dart';
import 'package:shoppingapp/controllers/auth_controller.dart';
import 'package:shoppingapp/controllers/profile_controller.dart';
import 'package:shoppingapp/views/auth_screen/login_screen.dart';
import 'package:shoppingapp/views/profile_screen/components/details_cart.dart';
import 'package:shoppingapp/views/profile_screen/edit_profile_screen.dart';
import 'package:shoppingapp/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:shoppingapp/services/firestore_services.dart';

//ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      body: StreamBuilder(

        stream: FirestoreServices.getUser(currentUser!.uid),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          if(!snapshot.hasData){
            return const Center(child:  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)));
          }
          else{

            var data = snapshot.data!.docs[0];

            return SafeArea(child:
            Column(
              children: [

                //edit profile button

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.edit, color: whiteColor,),
                  ).onTap(() {

                    controller.nameController.text = data['name'];

                    Get.to(()=>  EditProfileScreen(data: data,));
                  }),
                ),

                //users details section

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [

                      data['imageUrl'] == ''?

                      Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                          :Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}".text.fontFamily(semibold).white.make(),
                          "${data['email']}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(

                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: whiteColor,
                            ),
                          ),
                          onPressed: ()async{
                            await Get.put(AuthController()).signoutMethod(context);
                            Get.offAll(()=> const LoginScreen());
                          },
                          child: logOut.text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),

                20.heightBox,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(context.screenWidth / 3.4, data['cart_count'], "In Your Cart"),
                    detailsCard(context.screenWidth / 3.4, data['wishlist_count'], "In Your Wishlist"),
                    detailsCard(context.screenWidth / 3.4, data['order_count'], "Your Orders"),
                  ],
                ),

                //buttons section

                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index){
                    return const Divider(
                      color: lightGrey,
                    );
                  } ,
                  itemCount: profileButtonsList.length,
                  itemBuilder: (BuildContext context,  int index){
                    return ListTile(
                      leading: Image.asset(profileButtonsIcons[index], width: 22,),
                      title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                    );
                  },
                ).box.white.rounded.padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.make()

              ],
            ));
          }

        },


      )
    ));
  }
}
