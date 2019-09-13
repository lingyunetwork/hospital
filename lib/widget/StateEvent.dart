
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class StateEvent<T extends StatefulWidget> extends State<T> {
  @protected
  BuildContext innerContext;
  @protected
  bool isStage = false;

  @override
  void initState() {
    super.initState();
  }

  invalidate() {
    this.setState(_empty);
  }

  //不做任何事
  _empty() {}

  toast(String value) {
    var c = innerContext;
    if (c == null) {
      c = context;
    }
    Scaffold.of(c).showSnackBar(SnackBar(
      content: Text('$value'),
    ));
  }

   navigate(BuildContext context, dynamic value) async {
    if (value.url != null) {
      launch(value.url);
    }
  }

  navRepNamed(String uri) {
    Navigator.of(context).pushReplacementNamed(uri);
  }
  navNamed(String uri) {
    Navigator.of(context).pushNamed(uri);
  }
}
