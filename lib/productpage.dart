import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/productview.dart';

import 'api/api.dart';

class Productpage extends StatefulWidget {
  var catname;
  String type;
  var subcatid;
  Productpage({this.type, this.subcatid, this.catname});
  @override
  _Productpage createState() =>
      _Productpage(type: type, subcatid: subcatid, catname: catname);
}

class _Productpage extends State<Productpage> {
  String type;
  var subcatid;
  var catname;
  _Productpage({this.type, this.subcatid, this.catname});
  List products;
  List essential;
  bool loading = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    isloading = true;

    if (type == 'essential') {
      getessential();
    }
    if (subcatid != null) {
      getproduct(subcatid);
    }
  }

  getessential() async {
    var res = await CallApi().getData('android/get_essential');
    var body = json.decode(res.body);
    setState(() {
      essential = body;
      loading = false;
    });
  }

  getproduct(subcatid) async {
    var res = await CallApi()
        .getData('android/get_product_by_subcat?subcat=' + subcatid.toString());
    var body = json.decode(res.body);
    setState(() {
      products = body;
      isloading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = type == 'essential'
        ? loading
            ? 0
            : essential.length
        : isloading
            ? 0
            : products.length;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 1 / 7),
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 40,
          ),
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 15,
                width: MediaQuery.of(context).size.width - 110,
                child: type == 'essential'
                    ? Text(
                        ('Search results for ') + 'Essential',
                        style: TextStyle(fontSize: 20),
                      )
                    : Text(
                        ('Search results for ') + catname,
                        style: TextStyle(fontSize: 20),
                      ),
              ),
              Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[900],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 40,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .70,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                    itemCount: len,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 1 / 4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            type == 'essential'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productview(
                                            productid: essential[index]
                                                ['product_id'])))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productview(
                                            productid: products[index]
                                                ['product_id'])));
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      8,
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 2,
                                  child: type == 'essential'
                                      ? Image.network(
                                          'http://waytofresh.store/Youmart/crm/' +
                                              essential[index]
                                                  ['product_prim_img'])
                                      : Image.network(
                                          'http://waytofresh.store/Youmart/crm/' +
                                              products[index]
                                                  ['product_prim_img'])),
                              Padding(padding: EdgeInsets.only(bottom: 20)),
                              Text(
                                type == 'essential'
                                    ? essential[index]['product_name_eng']
                                    : products[index]['product_name_eng'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
