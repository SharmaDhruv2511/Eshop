import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shoppingapp/consts/consts.dart';
import 'package:shoppingapp/models/category_model.dart';

class ProductController extends GetxController{

  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice =  0.obs;


  getSubCategoires(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);

    var s = decoded.categories.where((element) => element.name == title).toList();

    for(var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(index){
    colorIndex.value = index;
  }

  quantityIncrease(totalQuantity){
    if(quantity.value < totalQuantity){
      quantity.value++;
    }
  }

  quantityDecrease(){
    if(quantity.value > 0){
      quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellerName, color, qty, tPrice, context }) async{

    await firestore.collection(cartCollection).doc().set({

      'title' : title,
      'img' : img,
      'sellerName' : sellerName,
      'color' : color,
      'qty' : qty,
      'tPrice' : tPrice,
      'added_by' : currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }




}