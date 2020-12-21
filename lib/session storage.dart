import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SharedPreferenceDemo extends StatefulWidget {
  var productid;
  SharedPreferenceDemo({this.productid}) : super();

  final String title = "Shared Preference Demo";

  @override
  SharedPreferenceDemoState createState() => SharedPreferenceDemoState(productid:productid);
}

class SharedPreferenceDemoState extends State<SharedPreferenceDemo> {
  //
    var productid;

    SharedPreferenceDemoState({this.productid});
  var data = [];
  String nameKey = "_key_name";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler(
          (MethodCall methodcall) async {
        if (methodcall.method == 'getAll') {
          return {"flutter." + nameKey: "[ No Name Saved ]"};
        }
        return null;
      },
    );
    setData();
  }

  Future<bool> saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, controller.text);
  }

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  setData() {
    loadData().then((value) {
      setState(() {
        for(var i=0;i<10;i++)
        data = productid[i]['product_id'];
      });
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}