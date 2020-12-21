import 'package:flutter/material.dart';
import 'package:youmart/appbar.dart';

class forgotpassword extends StatelessWidget {
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Text('Reset Password',style: TextStyle(fontSize: 26),),
                Padding(padding: EdgeInsets.only(top: 40)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('E-Mail Address',style: TextStyle(fontSize: 22,),)
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: TextField(),
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black),
                    color: Colors.blue[500],
                  ),
                  child: Text('Send Password Reset Link',style: TextStyle(fontSize: 22,color: Colors.white),textAlign: TextAlign.center,
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}