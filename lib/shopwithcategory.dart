import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/subcategory.dart';

import 'api/api.dart';

class shopwithcategory extends StatefulWidget {
  @override
  _shopwithcategory createState() => _shopwithcategory();
}

class _shopwithcategory extends State<shopwithcategory> {
  List category;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _getCategory();
    _loading = true;
  }

  _getCategory() async {
    var res = await CallApi().getData('android/get_allcategory');
    var body = json.decode(res.body);

    setState(() {
      category = body;
      _loading = false;
    });
  }



  Widget build(BuildContext context) {
    var len = _loading ? 0 : category.length;
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Shop by Category',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1 / 3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: len,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Subcategory(
                                    catid: category[index]
                                        ['category_id'])));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width *
                                    1 /
                                    2.1 -
                                20,
                            height: MediaQuery.of(context).size.height *
                                1 /
                                3.6,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.black, width: 1),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            1 /
                                            5,
                                    width:
                                        MediaQuery.of(context).size.width *
                                            1 /
                                            2,
                                    child: Image.network(
                                        'http://waytofresh.store/Youmart/crm/' +
                                            category[index]
                                                ['category_img'])),
                                Text(
                                  category[index]['category_name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        )
      ],
    );
  }
}
