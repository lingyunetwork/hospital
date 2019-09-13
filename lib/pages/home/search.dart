import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;
  String hint = "大家都在搜";

  @override
  Widget build(BuildContext context) {
    Widget ui = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.room,
          color: Colors.grey,
        ),
        Text("全国"),
        SizedBox(
          width: 20,
        ),
        Expanded(child: getInput()),
      ],
    );

    ui = Container(
      //color: Colors.red,
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 30,
      child: ui,
    );
    ui = SafeArea(
      child: ui,
    );
    return ui;
  }

  Widget getInput() {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      //elevation: 8,
      color: Colors.grey[200],

      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
