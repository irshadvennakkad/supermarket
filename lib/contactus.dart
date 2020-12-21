import 'package:flutter/material.dart';
import 'package:youmart/appbar.dart';


class contactus extends StatelessWidget{
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Align(
              alignment: Alignment.center,
              child: Text('Contact us',style: TextStyle(fontSize: 32),)
          ),
        ],
      ),
    );
  }
}