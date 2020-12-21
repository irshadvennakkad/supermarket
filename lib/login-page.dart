import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youmart/appbar.dart';
import 'package:youmart/forgot-password.dart';
import 'package:youmart/home.dart';
import 'package:youmart/signuppage.dart';

import 'api/api.dart';



class loginpage extends StatefulWidget {
  @override
  _loginpage createState() => _loginpage();
}
class _loginpage extends State<loginpage>
{
  bool _isLoading =false;
  @override
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
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
              height: 50,
            ),

             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                  children: <Widget>[
                    Text('Login',style: TextStyle(fontSize: 32),),
                    Padding(padding: EdgeInsets.only(top: 20)),
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
                      child: TextField(controller: mailController,),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Password',style: TextStyle(fontSize: 22,),)
                    ),
                    Padding(padding: EdgeInsets.only(top: 10),),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextField(controller: passwordController,),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                              MaterialPageRoute(builder: (context) => forgotpassword())
                              );
                            },
                            child: Text('Forgot Password?',style: TextStyle(fontSize: 18,color: Colors.blue),))
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black),
                        color: Colors.blue[500],
                      ),
                      child: GestureDetector(
                        onTap: (){
                          _login();
                        },
                        child: Text('Login',style: TextStyle(fontSize: 22,color: Colors.white),textAlign: TextAlign.center,
                    ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                   GestureDetector(
                       onTap: (){
                         Navigator.push(
                             context,
                         MaterialPageRoute(builder: (context) => signup())
                         );
                       },
                       child: Text('Not yet a member? Signup',style: TextStyle(fontSize: 22),)
                   ),

                  ],
                ),
             ),
          ],
        ),
    );
  }
  void _login() async{

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);

    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => MyHomePage()));
    }else{
      Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow
      );

    }


    setState(() {
      _isLoading = false;
    });




  }
}


