import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/productview.dart';

class Topproduct extends StatefulWidget {
  @override
  _Topproduct createState() => _Topproduct();
}

class _Topproduct extends State<Topproduct> {
  List topproduct;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    loading = true;
    gettopproduct();
  }

  gettopproduct() async {
    var res = await CallApi().getData('android/get_topproducts');
    var body = json.decode(res.body);
    setState(() {
      topproduct = body;
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = loading ? 0 : topproduct.length;
    return Column(
      children: <Widget>[
        Text(
          'Top Products',
          style: TextStyle(
              color: Colors.grey, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .33,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: len,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left:20.0),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          width:
                              MediaQuery.of(context).size.width * 1 / 2.1-20,
                         height: MediaQuery.of(context).size.height*.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => productview(productid: topproduct[index]['product_id'],)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(

                                        margin: EdgeInsets.only(top: 10),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                6,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1 /
                                                2,
                                        child: Image.network(
                                            'http://waytofresh.store/Youmart/crm/' +
                                                topproduct[index]
                                                    ['product_prim_img'])),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Column(
                                      children: [
                                        Text(
                                          topproduct[index]['product_name_eng'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
        ),
      ],
    );
  }
}
