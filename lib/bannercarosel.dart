import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'api/api.dart';

class Bannercarosel extends StatefulWidget{
  @override
  _Bannercarousel createState() => _Bannercarousel();
}

class _Bannercarousel extends State<Bannercarosel>{
  List banner;
  bool loading = false;
  @override

  void initState() {
    super.initState();
    _getBanner();
    loading = true;
  }
  _getBanner() async {
    var res = await CallApi().getData('android/get_allslider');
    var body = json.decode(res.body);
    setState(() {
      banner = body;
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    var len = loading ? 0 : banner.length;
    return CarouselSlider(
      options: CarouselOptions(height: MediaQuery.of(context).size.height*1/4,autoPlay: true),
      items: [for(var j=0;j<len;j++) j].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network('http://waytofresh.store/Youmart/crm/' + banner[i]['banner_img_mob'],)
            );
          },
        );
      }).toList(),
    );
  }
}