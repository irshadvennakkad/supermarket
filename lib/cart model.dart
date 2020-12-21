import 'dart:convert';
import 'dart:core';

import 'package:flutter_session/flutter_session.dart';
List usercart = [0];
 cartmodel(productid) async{
   usercart.add(productid);
  var session = FlutterSession();
  await session.set("producti", json.encode(usercart));


}



