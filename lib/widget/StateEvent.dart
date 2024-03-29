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


  cleanToast() {
    var c = innerContext;
    if (c == null) {
      c = context;
    }
    Scaffold.of(c).removeCurrentSnackBar();
  }

  toast(String value) {
    var c = innerContext;
    if (c == null) {
      c = context;
    }
    Scaffold.of(c).removeCurrentSnackBar();
    Scaffold.of(c).showSnackBar(SnackBar(
      content: Text('$value'),
    ));
  }

  navigate(BuildContext context, dynamic value) async {
    if (value.url != null) {
      launch(value.url);
    }
  }

  navRepNamed(String uri, [dynamic data]) {
    if (data != null) {
      Navigator.of(context).pushReplacementNamed(uri, arguments: data);
      return;
    }
    Navigator.of(context).pushReplacementNamed(uri);
  }

  navNamed(String uri, [dynamic data]) {
    if (data != null) {
      Navigator.of(context).pushNamed(uri, arguments: data);
      return;
    }
    Navigator.of(context).pushNamed(uri);
  }
}
