import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/productpage.dart';

class Subcategory extends StatefulWidget {
  var catid;
  Subcategory({this.catid});
  @override
  _Subcategory createState() => _Subcategory(catid: catid);
}

class _Subcategory extends State<Subcategory>{
  var catid;
  _Subcategory({this.catid});
  List subcategory;
  bool loading = false;

  @override
  void initState(){
    super.initState();
    loading =true;
    _getsubcategory(catid);
  }

  _getsubcategory(catid) async {
    var res = await CallApi().getData('android/get_subcategory?cat_id='+ catid.toString());
    var body = json.decode(res.body);
    setState(() {
      subcategory = body;
      loading = false;
    });
  }


  Widget build(BuildContext context) {
    var len = loading ? 0 : subcategory.length;
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
              padding: EdgeInsets.only(left:15,right: 15, top: 5, bottom: 5),
              height: MediaQuery.of(context).size.height*1/14,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search for products...",
                  hintText: 'Search for Products...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: len,
          itemBuilder: (BuildContext context,int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Productpage(subcatid: subcategory[index]['subcategory_id'],catname: subcategory[index]['subcategory_name'],)),
                  );
                },
                child: Column(
                  children: [

                      Container(
                        margin: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height*1/3,
                        width: MediaQuery.of(context).size.width*.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height*1/4,
                              child: Image.network('http://waytofresh.store/Youmart/crm/' + subcategory[index]['subcategory_img']),
                            ),
                            Text(subcategory[index]['subcategory_name'], style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),

                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
            );
          }
        ),
      ),
    );
  }
}