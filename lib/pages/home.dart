import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/delegate/ext.dart';
import 'package:hospital/pages/home/search.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/MenuVO.dart';
import 'package:hospital/provider/ObjectUtil.dart';
import 'package:hospital/widget/Ux.dart';

import 'home/CartList.dart';
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

  Future<DataProvider> getdata() async {
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/category.json");

    var data = json.decode(jsonData.toString());

    var create = MenuVO();
    var provider = DataProvider();

    data.forEach((key, value) {
      var list = Factory.fromJson(value, create);
      provider.add(key, list);
    });
    return provider;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: onDataReady,
    );
  }

  Widget onDataReady(
      BuildContext context, AsyncSnapshot<DataProvider> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.waiting:
        return new Center(
          child: new CircularProgressIndicator(),
        );
        break;
      case ConnectionState.done:
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
        break;
      case ConnectionState.none:
        break;
    }

    var data = snapshot.data;
    Widget ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          getTopSliver(),
          getSwiperSlive(data),
        ];
      },
      body: CartList(data),
    );
    return Container(color: Colors.white, child: SafeArea(child: ui));
  }

  Widget getTopSliver() {
    Widget headerUI = Column(children: <Widget>[
      SearchBar(),
    ]);

    var h = Ux.px(60);
    var header = SliverPersistentHeaderDelegateEx(headerUI);
    header.maxHeight = h;
    header.minHeight = h;

    return SliverPersistentHeader(
      pinned: true,
      delegate: header,
    );
  }

  Widget getSwiperSlive(DataProvider value) {
    Widget ui = Column(
      children: <Widget>[
        SwiperAd(value),
        SwiperCategory(
          value,
        ),
      ],
    );

    return SliverToBoxAdapter(
      child: ui,
    );
  }
}
