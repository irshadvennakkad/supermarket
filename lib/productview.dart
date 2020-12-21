import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/cart%20model.dart';
import 'package:youmart/session%20storage.dart';

class productview extends StatefulWidget {
  var productid;
  productview({this.productid});
  @override
  _productview createState() => _productview(productid: productid);
}

class _productview extends State<productview> {
  var productid;
  _productview({this.productid});
  bool loading = false;
  bool isloading = false;
  List product;
  var gallery = [];
  var primeimage;
  var catid;
  List recommended;
  @override
  void initState() {
    super.initState();
    loading = true;
    _product(productid);
    _recommended(catid);
    isloading = true;
  }

  _product(productid) async {
    var res = await CallApi().getData(


        'android/get_product_details?product_id=' + productid.toString());
    var body = json.decode(res.body);
    setState(() {
      product = body;
      loading = false;

    });
    gallery = product[0]['product_img'].split('|');
    primeimage =
        'http://waytofresh.store/Youmart/crm/' + product[0]['product_prim_img'];
    _recommended(product[0]['product_cat']);

  }

  _recommended(catid) async {
    var res = await CallApi()
        .getData('android/recommended_product?cat_id=' + catid.toString());
    var body = json.decode(res.body);
    setState(() {
      recommended = body;
      isloading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = loading ? 0 : product.length;
    var reclen = isloading ? 0 : recommended.length;
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
      body: ListView.builder(
          itemCount: len,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 2,
                  child: Image.network(primeimage),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1 / 7,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            primeimage =
                                'http://waytofresh.store/Youmart/crm/' +
                                    product[0]['product_prim_img'];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          height: MediaQuery.of(context).size.height * 1 / 8,
                          width: MediaQuery.of(context).size.width * 1 / 4,
                          child: Image.network(
                              'http://waytofresh.store/Youmart/crm/' +
                                  product[0]['product_prim_img']),
                        ),
                      ),
                      for (var i = 0; i < gallery.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              primeimage =
                                  'http://waytofresh.store/Youmart/crm/' +
                                      gallery[i];
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      7,
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 4,
                                  child: Image.network(
                                      'http://waytofresh.store/Youmart/crm/' +
                                          gallery[i])),
                            ],
                          ),
                        ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product[index]['product_name_eng'],
                            style: TextStyle(color: Colors.green, fontSize: 30),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.green,
                            height: 30,
                            width: MediaQuery.of(context).size.width * 1 / 5,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  product[index]['product_off_perce'] + '% off',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '₹' + product[index]['product_price'] + '  ',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹' + product[index]['product_off_price'],
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Currently Stock Not Available',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Qty',
                            style: TextStyle(fontSize: 24),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                               SharedPreferenceDemo(productid: product[index]['product_id'],);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 1 / 15,
                              width: MediaQuery.of(context).size.width * 2 / 5,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  cartmodel(product[index]['product_id']);
                                },
                                child: Center(
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 1 / 15,
                            width: MediaQuery.of(context).size.width * 2 / 5,
                            decoration: BoxDecoration(
                              color: Colors.green[500],
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Services',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.money,
                            color: Colors.green[500],
                            size: 30,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            'Cash on delivery available',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )),
                      Padding(padding: EdgeInsets.all(5)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product[index]['product_spec'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      Padding(padding: EdgeInsets.all(10)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Recommended for you',
                            style: TextStyle(fontSize: 32, color: Colors.green),
                          )),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: reclen,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(20.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              product[0]['product_id'] ==
                                      recommended[index]['product_id']
                                  ? SizedBox(
                                      width: 0,
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(right: 20),
                                      width: MediaQuery.of(context).size.width *
                                              1 /
                                              2.1 -
                                          20,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          productview(
                                                            productid:
                                                                recommended[
                                                                        index][
                                                                    'product_id'],
                                                          )));
                                            },
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1 /
                                                    8,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1 /
                                                    2,
                                                child: Image.network(
                                                    'http://waytofresh.store/Youmart/crm/' +
                                                        recommended[index][
                                                            'product_prim_img'])),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20)),
                                          Column(
                                            children: [
                                              Text(
                                                recommended[index]
                                                    ['product_name_eng'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}


