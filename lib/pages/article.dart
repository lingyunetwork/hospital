import 'package:flutter/material.dart';
import 'package:hospital/provider/MenuVO.dart';

class ArticlePage extends StatelessWidget {
  final MenuVO vo;
  const ArticlePage(this.vo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = vo.url;

    var list = url.split(",");

    Widget ui = ListView.builder(
        shrinkWrap:true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var url = list[index];
          return Image.asset(
            url,
            fit: BoxFit.fitWidth,
          );
        });

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(vo.name),
        ),
        body: ui,
    );
  }
}
