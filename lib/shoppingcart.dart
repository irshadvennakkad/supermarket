import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/checkout.dart';
import 'package:youmart/home.dart';
import 'package:youmart/productview.dart';

class shoppingcart extends StatefulWidget {
  shoppingcart({Key key});
  @override
  _shoppingcart createState() => _shoppingcart();
}

class _shoppingcart extends State<shoppingcart> {
  int _counter = 1;
  List bbb = [1];
  bool loading = false;
  List cartitems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionstorage();
    loading = true;
  }

  adder() {
    setState(() {
      _counter++;
    });
  }

  void minus() {
    setState(() {
      if (_counter != 1) _counter--;
    });
  }

  void sessionstorage() async {
    dynamic cartproduct = await FlutterSession().get("producti");
    productcart(cartproduct);
  }

  productcart(cartid) async {
    print(cartid);
    var res = await CallApi()
        .getData('android/get_all_cart?product_id=' + cartid.toString());
    var body = json.decode(res.body);
    setState(() {
      cartitems = body;
      loading = false;
    });
    print(cartitems);
  }

  @override
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
      body: cartaction(),
    );
  }

  @override
  Widget cartaction() {
    var len = loading ? 0 : cartitems.length;
    if (len == 0) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text(
                'Continue Shopping',
                style: TextStyle(fontSize: 20, color: Colors.indigo[500]),
              ),
            ),
          ),
        ],
      );
    } else {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Column(
            children: <Widget>[
              for (var i = 0; i < len; i++)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 1 / 6,
                        width: MediaQuery.of(context).size.width * 1 / 4,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 1 / 9,
                                child: Image.network(
                                    'http://waytofresh.store/Youmart/crm/' +
                                        cartitems[i]['product_prim_img'])),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 1 / 7,
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      15,
                                  width:
                                      MediaQuery.of(context).size.width * .60,
                                  padding: EdgeInsets.only(left: 20),
                                  child: ListView(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            cartitems[i]['product_name_eng'],
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {}, child: Icon(Icons.delete)),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 25,
                                    width: 35,
                                    child: GestureDetector(
                                      onTap: minus,
                                      child: Icon(
                                        Icons.remove,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$_counter',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 35,
                                    child: GestureDetector(
                                        onTap: adder,
                                        child: Icon(
                                          Icons.add,
                                        )),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 30)),
                                  Text(
                                    '₹ ' +
                                        (_counter *
                                                int.parse(cartitems[i]
                                                    ['product_off_price']))
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Coupen Code(if any)',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  width: MediaQuery.of(context).size.width * 4 / 9,
                  child: TextField(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.black),
                  ),
                  height: MediaQuery.of(context).size.height * 1 / 16,
                  width: MediaQuery.of(context).size.width * 3 / 8,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Redeem Code',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  'Grand Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width - 200)),
              Text(
                '48',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => checkout()));
                      },
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
            ),
          ),
        ],
      );
    }
  }
}
