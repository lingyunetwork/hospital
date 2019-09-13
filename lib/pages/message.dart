import 'package:flutter/material.dart';
import 'package:hospital/delegate/ext.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ui;

    ui = ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: itemBuilder,
      itemCount: 5,
    );

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          getTopSliver(innerBoxIsScrolled),
        ];
      },
      body: ui,
    );
  }

  Widget getTopSliver(bool innerBoxIsScrolled) {
    var h = 255.0;
    var image = Container(
        padding: EdgeInsets.all(0),
        color: Colors.red,
        height: h,
        width: 375,
        child: Image.asset(
          "assets/articles/woman3.jpg",
          fit: BoxFit.fitWidth,
        ));

    return SliverAppBar(
 
      pinned: false,
      floating: true,
      //title: ,
      expandedHeight: h,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(),
        background: image,
      ),
    );
  }

  Widget itemBuilder(BuildContext ctx, int index) {
    var url = "assets/articles/woman3.jpg";

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
              "crl",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "2019 Aug",
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
            "在开发过程中,屏幕适配是很重要的一件事.再RN中我们可以获取屏幕的像素,按照特定机型来适配屏幕大小.还要自己手写类...",
            softWrap: true,
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
