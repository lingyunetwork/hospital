import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/ObjectUtil.dart';
import 'package:hospital/widget/Ux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<DataProvider> future;
  @override
  void initState() {
    future = getdata();
    super.initState();
  }

  Future<DataProvider> getdata() async {
    var jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/message.json");

    var data = json.decode(jsonData.toString());

    var create = MessageVO();
    var provider = DataProvider();

    data.forEach((key, value) {
      var list = Factory.fromJson(value, create);
      provider.add(key, list);
    });
    return provider;
  }

  @override
  Widget build(BuildContext context) {
    var ui = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          getTopSliver(innerBoxIsScrolled),
        ];
      },
      body: FutureBuilder(
        future: future,
        builder: onDataReady,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onPress,
        child: Icon(Icons.edit),
      ),
      body: ui,
    );
  }

  onPress() {
    loadAssets();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true
      );
    } catch (e) {}

    print(resultList);
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
    var list = data.get("message");
    if (list.length == 0) {
      return new Center(
        child: new Text("NONDATA"),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: (ctx, index) => itemBuilder(ctx, list[index]),
      itemCount: list.length,
    );
  }

  Widget getTopSliver(bool innerBoxIsScrolled) {
    var h = 255.0;
    var image = Container(
        padding: EdgeInsets.all(0),
        color: Colors.red,
        height: h,
        width: Ux.px(375),
        child: Image.asset(
          "assets/articles/woman3.jpg",
          fit: BoxFit.fitWidth,
        ));

    return SliverAppBar(
      pinned: true,
      floating: true,
      title: Text("留言"),
      expandedHeight: h,
      flexibleSpace: FlexibleSpaceBar(
        //title: Container(),
        background: image,
      ),
    );
  }

  Widget itemBuilder(BuildContext ctx, MessageVO vo) {
    var url = vo.icon;

    var icon = Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(url),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );

    var head = Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              vo.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              vo.time,
              style: TextStyle(
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );

    Widget ui = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        head,
        SizedBox(
          height: 5,
        ),
        Container(
          child: Text(
            vo.content,
            softWrap: true,
            //style: TextStyle(height: 1.5,letterSpacing: 0.2),
          ),
        ),
      ],
    );
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: ui,
      ),
    );
  }
}

class MessageVO extends IFromJSON {
  String name;
  String icon;
  String time;
  String content;
  @override
  newFromJSON(Map json) {
    var vo = MessageVO();
    vo.name = json["name"];
    vo.icon = json["icon"];

    vo.time = json["time"];
    vo.content = json["content"];
    return vo;
  }
}
