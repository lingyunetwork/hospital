import 'package:flutter/material.dart';

class TelPage extends StatelessWidget {
  const TelPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Container(
      height: 300,
      width: double.infinity,
      child: Image.asset(
        "assets/articles/woman3.jpg",
        fit: BoxFit.cover,
      ),
    );

    Widget phone = ListTile(
      contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
      title: Text(
        "15000681615",
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text("电话号码"),
      leading: CircleAvatar(child: Icon(Icons.phone),),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
    //phone=Container(height: 100,child: phone,);

    phone=Card(child: Column(children: <Widget>[phone,Divider(),phone],),);

    var ui = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        image,
        SizedBox(
          height: 10,
        ),
        phone,
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: ui,
      ),
    );
  }
}
