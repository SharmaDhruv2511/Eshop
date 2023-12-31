import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/consts/lists.dart';
import 'package:shoppingapp/controllers/product_controller.dart';
import 'package:shoppingapp/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetValues();
            Get.back();
          }, icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline)),
          ],
        ),

        body: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section

                    VxSwiper.builder(
                        itemCount: data['p_imgs'].length,
                        autoPlay: true,
                        height: 350,
                        viewportFraction: 1.0,
                        aspectRatio: 16 / 9,
                        itemBuilder: (context, index){

                          return Image.network(data["p_imgs"][index], width: double.infinity, fit: BoxFit.cover);
                    }),

                    10.heightBox,
                    //title and details section

                    title!.text.size(16).fontFamily(semibold).color(darkFontGrey).make(),

                    10.heightBox,

                    VxRating(onRatingUpdate: (value){}
                      , value: double.parse(data["p_rating"])
                      , normalColor: textfieldGrey
                      ,  isSelectable: false
                      , selectionColor: golden
                      , count: 5
                      , size: 25
                      , stepInt: false
                      , maxRating: 5 ,),

                    10.heightBox,

                    "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),

                    10.heightBox,

                    Row(
                      children: [
                        Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                            ],
                        )),

                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded, color: darkFontGrey,),
                        ),
                      ],
                    ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                    //color section
                    20.heightBox,

                    Obx(()=> Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(data['p_colors'].length, (index) =>
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox().size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                        .margin(const EdgeInsets.symmetric(horizontal: 4)).make()
                                        .onTap(() {
                                          controller.changeColorIndex(index);
                                        }),

                                         Visibility(
                                            visible: index == controller.colorIndex.value,
                                            child: const Icon(Icons.done, color: Colors.white,)),

                                      ],
                                    ),
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //quantity section

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.color(textfieldGrey).make(),
                              ),
                              Obx(()=>
                                  Row(
                                 children: [
                                   IconButton(onPressed: (){
                                     controller.quantityDecrease();
                                     controller.calculateTotalPrice(int.parse(data['p_price']));
                                   }, icon: const Icon(Icons.remove),),
                                   controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                   IconButton(onPressed: (){
                                     controller.quantityIncrease(int.parse(data['p_quantity']));
                                     controller.calculateTotalPrice(int.parse(data['p_price']));
                                   }, icon: const Icon(Icons.add),),
                                   10.widthBox,
                                   "(${data['p_quantity']} Available)".text.color(textfieldGrey).make(),
                                 ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,

                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //button section
                    10.heightBox,

                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(itemDetailsButtonsList.length, (index) =>  ListTile(

                        title: itemDetailsButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                        trailing: const Icon(Icons.arrow_forward),


                      )),
                    ),

                    20.heightBox,

                    productYouMayLike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),

                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP1, width: 150, fit: BoxFit.fill,),
                            10.heightBox,
                            "Laptop 8GB/512GB SSD".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "50000 ₹".text.color(redColor).fontFamily(bold).size(16).make(),
                          ],
                        ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()),
                      ),
                    )

                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              child: ourButton( redColor, whiteColor, "Add to Cart", (){
                controller.addToCart(
                 color: data['p_colors'][controller.colorIndex.value],
                  context: context,
                  img: data['p_imgs'][0],
                  qty: controller.quantity.value,
                  sellerName: data['p_seller'],
                  title: data['p_name'],
                  tPrice: controller.totalPrice.value,
                );
                VxToast.show(context, msg: "Added to Cart");
              }),
            )
          ],
        ),

      ),
    );
  }
}
