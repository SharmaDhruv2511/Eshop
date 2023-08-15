import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/consts/lists.dart';
import 'package:shoppingapp/views/home_screen/components/featured_button.dart';
import 'package:shoppingapp/widgets_common/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,

      child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnything,
                    hintStyle: TextStyle(color: textfieldGrey),
                  ),
                ),
              ),
              //swiper brands
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length, itemBuilder: (context, index){
                        return Image.asset(slidersList[index], fit: BoxFit.fitWidth,).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                      }),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(2, (index) => homeButtons(context.screenWidth / 2.5 , context.screenHeight * 0.15, index == 0 ? icTodaysDeal : icFlashDeal, index ==0 ? todayDeal : flashSale, (){})),
                      ),

                      //2nd slider
                      10.heightBox,

                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length, itemBuilder: (context, index){
                        return Image.asset(secondSlidersList[index], fit: BoxFit.fitWidth,).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                      }),

                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) => homeButtons(context.screenWidth / 3.5, context.screenHeight * 0.15, index==0? icTopCategories : index == 1 ? icBrands : icTopSeller , index==0? topCategories : index == 1 ? brand : topSellers, (){})),
                      ),

                      //featured Categories
                      20.heightBox,

                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),

                      20.heightBox,

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(3,
                                  (index) => Column(
                                    children: [
                                      featuredButton(featuredTitle1[index], featuredImages1[index]),
                                      10.heightBox,
                                      featuredButton(featuredTitle2[index], featuredImages2[index]),

                                    ],
                                  )).toList(),
                        ),
                      ),

                      //featured product

                      20.heightBox,

                      Container(

                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white.fontFamily(bold).size(18).make(),
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

                      //third slider
                      20.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length, itemBuilder: (context, index){
                        return Image.asset(secondSlidersList[index], fit: BoxFit.fitWidth,).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                      }),

                      //all product section
                      20.heightBox,
                      
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300),
                          itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1, width: 200, height: 200, fit: BoxFit.fill,),
                                const Spacer(),
                                "Laptop 8GB/512GB SSD".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "50000 ₹".text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make();
                      })



                    ],
                  ),
                ),
              )


            ],
          )
      ),
    );
  }
}
