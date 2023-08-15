 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/controllers/product_controller.dart';
import 'package:shoppingapp/services/firestore_services.dart';
import 'package:shoppingapp/views/category_screen/item_details.dart';
import 'package:shoppingapp/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:shoppingapp/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return bgWidget(Scaffold(
      appBar: AppBar(
        title: title!.text.white.fontFamily(bold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "NO PRODUCTS FOUND!".text.color(darkFontGrey).make(),
            );
          }else{

            var data = snapshot.data!.docs;


            return Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(controller.subcat.length, (index) =>
                          " ${controller.subcat[index]}".
                          text.
                          fontFamily(semibold).
                          size(12).
                          color(darkFontGrey).makeCentered().
                          box.white.rounded.
                          size(120, 60).
                          margin(const EdgeInsets.symmetric(horizontal: 4)).make()),
                    ),
                  ),

                  20.heightBox,

                  Expanded(child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8),
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(data[index]['p_imgs'][0], width: 200, height: 150, fit: BoxFit.fill,),
                            "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                          ],
                        ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadowSm.roundedSM.padding(const EdgeInsets.all(12))
                            .make().onTap(() {

                          Get.to(()=> ItemDetails(title: "${data[index]['p_name']}", data: data[index],));

                        });
                      }))
                ],
              ),
            );
          }
        },
      )
    ));
  }
}
