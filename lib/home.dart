import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/bannercarosel.dart';
import 'package:youmart/drawer.dart';
import 'package:youmart/essential-products.dart';
import 'package:youmart/home-category-subcategory.dart';
import 'package:youmart/newproducts.dart';
import 'package:youmart/shopwithcategory.dart';
import 'package:youmart/top-products.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override

  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {

    });

    return null;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: <Widget>[
            appbar(),
          ],
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              height: MediaQuery.of(context).size.height * 1 / 14,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search for products...",
                  hintText: 'Search for Products...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Drawerpage(),
      ),
      body:  RefreshIndicator(
        key:  refreshKey,
        child: Container(
            color: Colors.grey[100],
            child: ListView(
              primary: true,
              shrinkWrap: true,
              children: <Widget>[
                Bannercarosel(),
                Essentialproducts(),
                Padding(padding: EdgeInsets.only(top: 10)),
                shopwithcategory(),
                Topproduct(),
                Homecategorysubcategory(),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      height: MediaQuery.of(context).size.height * 1 / 2 -
                          (MediaQuery.of(context).size.height * 1 / 4),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/images/delivery.png'),
                    ),
                  ],
                ),
                Newproduct(),
              ],
            ),
          ),
        onRefresh: refreshList,
      ),
    );
  }
}
