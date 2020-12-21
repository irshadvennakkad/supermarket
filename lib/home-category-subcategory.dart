import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/productpage.dart';
import 'package:youmart/productview.dart';
import 'package:youmart/subcategory.dart';

class Homecategorysubcategory extends StatefulWidget {
  @override
  _Homecategorysubcategory createState() => _Homecategorysubcategory();
}

class _Homecategorysubcategory extends State<Homecategorysubcategory> {
  List category;
  List offbanner;
  var k = 0;
  bool isloading = false;
  bool loading = false;
  List subcategory;
  @override
  void initState() {
    super.initState();
    _getCategory();
    loading = true;
    _getoffbanner();
    isloading = true;
  }

  _getCategory() async {
    var res = await CallApi().getData('android/get_allcategory');
    var body = json.decode(res.body);

    setState(() {
      category = body;
      loading = false;
    });
  }

  _getoffbanner() async {
    var res = await CallApi().getData('android/get_offer_banner');
    var body = json.decode(res.body);
    setState(() {
      offbanner = body;
      isloading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = loading ? 0 : category.length;
    var olen = isloading ? 0 : offbanner.length;

    return Column(
      children: [
        for (int i = 0; i < len; i++)
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                height: MediaQuery.of(context).size.height * 1 / 4.3,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Subcategory(
                                catid: category[i]['category_id'])));
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 1 / 3 -
                            (MediaQuery.of(context).size.height * 1 / 5),
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                            'http://waytofresh.store/Youmart/crm/' +
                                category[i]['category_img']),
                      ),
                      Text(
                        category[i]['category_name'],
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              getSubcategory(catid: category[i]['category_id']),
              olen > i
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        'http://waytofresh.store/Youmart/crm/' +
                            offbanner[i]['offerbanner_img'],
                        fit: BoxFit.fill,
                      ),
                    )
                  : SizedBox(height: 0)
            ],
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

  getsubcategory(catid) async {
    var res = await CallApi()
        .getData('android/get_subcategory?cat_id=' + catid.toString());
    var body = json.decode(res.body);
    setState(() {
      subcategory = body;
      isloading = false;
    });
    print(subcategory);
  }

  Widget build(BuildContext context) {
    var length = isloading
        ? 0
        : subcategory.length > 4
            ? 4
            : subcategory.length;
    return length != 0
        ? Container(
            padding: EdgeInsets.only(top: 10),
            color: Colors.white,
            height: length > 2
                ? MediaQuery.of(context).size.height * 1 / 2
                : MediaQuery.of(context).size.height * 1 / 4,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 1 / 5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Productpage(
                                      subcatid: subcategory[index]
                                          ['subcategory_id'],
                                      catname: subcategory[index]
                                          ['subcategory_name'],
                                    )));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              height:
                                  MediaQuery.of(context).size.height * 1 / 8,
                              width: MediaQuery.of(context).size.width * 1 / 2,
                              child: Image.network(
                                  'http://waytofresh.store/Youmart/crm/' +
                                      subcategory[index]['subcategory_img'])),
                          Padding(padding: EdgeInsets.only(bottom: 20)),
                          Text(
                            subcategory[index]['subcategory_name'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : SizedBox(height: 20);
  }
}
