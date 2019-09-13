import 'package:flutter/material.dart';

class WePage extends StatelessWidget {
  const WePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ui = Container(
      height: 300,
      width: double.infinity,
      child: Image.asset(
        "assets/articles/woman3.jpg",
        fit: BoxFit.cover,
      ),
    );

    Widget qr = Container(
      height: 300,
      width: double.infinity,
      child: Center(
        child: Image.asset(
        "assets/articles/qr.jpg",
        fit: BoxFit.cover,
      )),
    );

    ui=Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[ui,qr],);

    return Scaffold(
      body: SingleChildScrollView(
        child: ui,
      ),
    );
  }
}
