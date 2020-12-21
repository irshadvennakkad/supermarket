import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:youmart/aboutus.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/contactus.dart';
import 'package:youmart/productpage.dart';

class Drawerpage extends StatefulWidget {
  @override
  _Drawerpage createState() => _Drawerpage();
}

class _Drawerpage extends State<Drawerpage> {
  bool loading = false;
  List category;
  @override
  void initState() {
    super.initState();
    loading = true;
    _getcategory();
  }

  _getcategory() async {
    var res = await CallApi().getData('android/get_allcategory');
    var body = json.decode(res.body);
    setState(() {
      category = body;
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = loading ? 0 : category.length;
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 1 / 6,
          width: MediaQuery.of(context).size.width,
          child: DrawerHeader(
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 1 / 15,
                      width: MediaQuery.of(context).size.width * 1 / 8,
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/images/user.png'),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 1 / 15,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Hi,guest',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            'Welcome to YouMart',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        Column(
          children: [
            for (var i = 0; i < len; i++)
              ExpansionTile(
                title: Row(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 1 / 15,
                        width: MediaQuery.of(context).size.width * 1 / 10,
                        child: Image.network(
                            'http://waytofresh.store/Youmart/crm/' +
                                category[i]['category_img'])),
                    Text(
                      category[i]['category_name'],
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                children: <Widget>[
                  getSubcategory(catid: category[i]['category_id']),
                ],
                trailing: Icon(Icons.arrow_forward_ios),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        ListTile(
          title: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1 / 20,
              width: MediaQuery.of(context).size.width * 1 / 3,
              child: Text(
                'Quick Links',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          title: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aboutus()));
              },
              child: Text(
                'About Us',
                style: TextStyle(fontSize: 19),
              )),
        ),
        ListTile(
          title: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => contactus()));
              },
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 19),
              )),
        ),
        ListTile(
          title: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1 / 20,
              width: MediaQuery.of(context).size.width * 1 / 3,
              child: Text(
                'Help',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            'Terms & Condition',
            style: TextStyle(fontSize: 19),
          ),
        ),
        ListTile(
          title: Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 19),
          ),
        ),
        ListTile(
          title: Text(
            'Cancellation & Returns',
            style: TextStyle(fontSize: 19),
          ),
        ),
        ListTile(
          title: Text(
            'FAQ',
            style: TextStyle(fontSize: 19),
          ),
        ),
      ],
    );
  }
}




class getSubcategory extends StatefulWidget {
  var catid;
  getSubcategory({this.catid});
  @override
  _getSubcategory createState() => _getSubcategory(catid: catid);
}
class _getSubcategory extends State<getSubcategory> {
  var catid;
  bool isloading = false;
  _getSubcategory({this.catid});
  List subcategory;
  @override
  void initState() {
    super.initState();
    getsubcategory(catid);
    isloading = true;
  }
  getsubcategory (catid)async{
    var res = await CallApi().getData('android/get_subcategory?cat_id='+ catid.toString());
    var body = json.decode(res.body);
    setState(() {
      subcategory =body;
      isloading = false;
    });
  }
  Widget build(BuildContext context) {
    var length = isloading ? 0 : subcategory.length;
    return Column(
      children: [
        for(var j=0;j<length;j++)
        ListTile(
          onTap: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Productpage(subcatid: subcategory[j]['subcategory_id'],catname: subcategory[j]['subcategory_name'],) ,
          ));
          },
          contentPadding: EdgeInsets.only(left: 30),
          title: Text(
            subcategory[j]['subcategory_name'],
            style: TextStyle(fontSize: 17),
          ),
    ),
      ],

    );
  }
}