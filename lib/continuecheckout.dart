import 'package:youmart/appbar.dart';
import 'package:flutter/material.dart';
import 'package:youmart/home.dart';

class continuecheckout extends StatefulWidget{
  continuecheckout({Key key});
  @override
  _continuecheckout createState() => _continuecheckout();
}

class _continuecheckout extends State<continuecheckout>{
  int selectedRadioTile;
  var payment;
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }
  setSelectedRadioTile(int val){
    setState(() {
      selectedRadioTile = val;
    });

  }

  @override
  Widget build(BuildContext context){
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
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.center,
                child: Text('Select Payment Method',style: TextStyle(fontSize: 25),)
            ),
            Padding(padding: EdgeInsets.only(top: 25)),
            RadioListTile(
              value: 1,
              groupValue: selectedRadioTile,
              title:Text('Cash on Delivery',style: TextStyle(fontSize: 18)),
              onChanged: (val){
                setState(() {
                  payment= val;
                });
                setSelectedRadioTile(val);
              },
            ),
            RadioListTile(
              value: 2,
              groupValue: selectedRadioTile,
              title:Text('Online Payment',style: TextStyle(fontSize: 18),),
              onChanged: (val){
                setState(() {
                  payment= val;
                });
                setSelectedRadioTile(val);
              },
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    child: Text('Place Order',style: TextStyle(fontSize: 20,color: Colors.white),),
                  onTap: (){
                      if(payment==1)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => successfully()));
                        }
                      else
                        {
                          print('op');
                        }
                      },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class successfully extends StatelessWidget{
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
            height: 100,
          ),
          Text('Order Submitted Successfully',style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text('Continue Shopping',style: TextStyle(fontSize: 18,color: Colors.blue[900]),textAlign: TextAlign.center,)),
        ],
      ),
    );
  }
}