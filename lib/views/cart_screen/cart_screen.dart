import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/controllers/cart_controller.dart';
import 'package:shoppingapp/services/firestore_services.dart';
import 'package:shoppingapp/widgets_common/loading_indicator.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold ).make(),
       ),

      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){

            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );

          }else{

            var data = snapshot.data!.docs;
            controller.calculate(data);


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: data.length ,
                      itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        title: "${data[index]['title']}".text.fontFamily(semibold).size(16).make(),
                        subtitle: "${data[index]['tPrice']}".numCurrency.text.size(14).color(redColor).fontFamily(semibold).make(),
                        trailing: const Icon(Icons.delete, color: redColor,).onTap(() {}),
                        leading: Image.network('${data[index]['img']}'),
                      );


                    })),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.color(darkFontGrey).fontFamily(semibold).make(),

                      Obx(()=> "${controller.totalP.value}".
                        numCurrency.
                        text.color(redColor).fontFamily(semibold).make(),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(12)).color(lightGolden).width(context.screenWidth-60).roundedSM.make(),

                  10.heightBox,

                  SizedBox(
                    width: context.screenWidth-60,
                    child: ourButton(redColor, whiteColor, "Proceed to Ship", (){}),

                  )

                ],
              ),
            );

          }
        },

      )
    );
  }
}
