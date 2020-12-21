import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youmart/api/api.dart';
import 'package:youmart/productpage.dart';
import 'package:youmart/productview.dart';
import 'package:youmart/subcategory.dart';

class Essentialproducts extends StatefulWidget {
  @override
  _Essentialproduct createState() => _Essentialproduct();
}

class _Essentialproduct extends State<Essentialproducts> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Productpage(type: 'essential',)));
          },
          child: Container(

            margin: EdgeInsets.only(left: 30, right: 30, top: 5),
            height: MediaQuery.of(context).size.height * 1 / 4,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 1 / 3 -
                      (MediaQuery.of(context).size.height * 1 / 7),
                  width: MediaQuery.of(context).size.width,
                  child: Image.network('http://waytofresh.store/Youmart/public/assets/img/essential.png'),
                ),
                Text('Essential',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
