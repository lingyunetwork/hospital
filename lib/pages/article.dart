import 'package:flutter/material.dart';
import 'package:hospital/provider/MenuVO.dart';

class ArticlePage extends StatelessWidget {
  final MenuVO vo;
  const ArticlePage(this.vo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cancelBtn = Positioned(
      top: 50.0,
      left: 20.0,
      child: Container(
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          iconSize: 20.0,
        ),
      ),
    );

    Widget ui = Image.asset(
      vo.url,
      fit: BoxFit.fitWidth,
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(vo.name),
        ),
        body: SingleChildScrollView(child: ui));
  }
}
