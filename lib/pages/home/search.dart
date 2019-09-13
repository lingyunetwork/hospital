import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:hospital/widget/StateEvent.dart';
import 'package:hospital/widget/Ux.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends StateEvent<SearchBar> {
  TextEditingController _controller;
  String hint = "大家都在搜";
  String city = "全国";

  onCity(BuildContext context) async {
    Result result = await CityPickers.showCitiesSelector(
      context: context,
    );

    if(result==null){
      return;
    }

    city=result.cityName;

    //print(result.toString());

    invalidate();
  }

  @override
  Widget build(BuildContext context) {
    Widget address = Row(
      children: <Widget>[
        Icon(
          Icons.room,
          color: Colors.grey,
        ),
        Text(city),
      ],
    );

    address = InkWell(
      onTap: () => onCity(context),
      child: address,
    );

    Widget ui = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        address,
        SizedBox(
          width: Ux.px(10),
        ),
        Expanded(child: getInput()),
      ],
    );

    ui = Container(
      padding: EdgeInsets.all(10),
      height: Ux.px(50),
      child: ui,
    );
    return ui;
  }

  Widget getInput() {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      //elevation: 8,
      color: Colors.grey[100],

      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
