import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/delegate/ext.dart';
import 'package:hospital/pages/home/search.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/MenuVO.dart';
import 'package:hospital/provider/ObjectUtil.dart';

import 'home/SwiperAd.dart';
import 'home/SwiperCategory.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<DataProvider> future;

  @override
  void initState() {
    future = getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: onDataReady,
    );
  }

  Future<DataProvider> getdata() async {
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/Category.json");

    var data = json.decode(jsonData.toString());

    var create = MenuVO();
    var provider = DataProvider();

    data.forEach((key, value) {
      var list = Factory.fromJson(value, create);
      provider.add(key, list);
    });
    return provider;
  }

  Widget onDataReady(
      BuildContext context, AsyncSnapshot<DataProvider> snapshot) {
    if (snapshot.connectionState == ConnectionState.active ||
        snapshot.connectionState == ConnectionState.waiting) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return new Center(
          child: new Text("ERROR"),
        );
      }

      if (snapshot.hasData == false) {
        return new Center(
          child: new Text("NONDATA"),
        );
      }
    }

    var data = snapshot.data;
    Widget ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          getTopSliver(),
        ];
      },
      body: ListView(
        children: <Widget>[
          SwiperAd(data),
          SwiperCategory(
            data,
          ),
        ],
      ),
    );
    return Container(color: Colors.white, child: SafeArea(child: ui));
  }

  Widget getTopSliver() {
    Widget headerUI = Column(children: <Widget>[
      SearchBar(),
    ]);
    var header = SliverPersistentHeaderDelegateEx(headerUI);
    header.maxHeight = 40;
    header.minHeight = 40;

    return SliverPersistentHeader(
      pinned: true,
      delegate: header,
    );
  }
}
