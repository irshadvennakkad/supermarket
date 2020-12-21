import 'package:flutter/material.dart';
import 'package:youmart/home.dart';
import 'package:youmart/login-page.dart';
import 'package:youmart/shoppingcart.dart';

class appbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:70),
          height: 50,
          width: 100,
          child: Row(
            children: <Widget>[
              GestureDetector(
                  child: Image.network('http://waytofresh.store/Youmart/public/assets/img/logo/logoyou.png'),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage())
                  );
                }
              ),
            ],
          ),
        ),
        PopupMenuButton(
          icon: Icon(Icons.store,size: 32.0, color: Colors.black,),

              itemBuilder: (_) => <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    child: GestureDetector(
                      onTap: (){
                        print('Branch A Selected');
                      },
                        child: Text('Branch A')),textStyle:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                new PopupMenuItem<String>(
                    child: GestureDetector(
                        onTap: (){
                          print('Branch B Selected');
                        },
                        child: new Text('Branch B')),textStyle:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18) ),
              ],
    ),


        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => shoppingcart())
                );
              },
              child: Icon(
                Icons.shopping_cart,
                size: 32.0,
                color: Colors.black,
              ),
            )
        ),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)  => loginpage()),
                );
              },
              child: Icon(
                Icons. person,
                size: 32.0,
                color: Colors.black,
              ),
            )
        ),
      ],
    );
  }
}