import 'package:flutter/material.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/continuecheckout.dart';

class checkout extends StatelessWidget{
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Full Name',
                labelText: 'Enter Your Full Name',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'E-Mail',
                labelText: 'Enter Your E-Mail',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Address',
                labelText: 'Enter Your Address',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'City',
                labelText: 'Enter Your City',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'State',
                labelText: 'Enter Your State',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pincode',
                labelText: 'Enter Your Pincode',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Mobile NO',
                labelText: 'Enter Your Mobile No',labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => continuecheckout())
                    );
                  },
                    child: Text('Continue to Checkout',style: TextStyle(fontSize: 18,color: Colors.white),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}