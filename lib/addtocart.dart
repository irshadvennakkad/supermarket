import 'dart:convert';

import 'package:youmart/api/api.dart';

addtocart(productid) async{
   var res = await CallApi().getData('android/get_product_details?product_id=' + productid.toString());
   var body = json.decode(res.body);
   setState(){

   }
}