import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/MenuVO.dart';
import 'package:hospital/widget/StateEvent.dart';
import 'package:hospital/widget/Ux.dart';

class CartList extends StatefulWidget {
  final DataProvider dataProvider;
  CartList(this.dataProvider, {Key key}) : super(key: key);

  _CartListState createState() => _CartListState();
}

class _CartListState extends StateEvent<CartList> {
  List<MenuVO> data;
  @override
  void initState() {
    data = widget.dataProvider.get("article");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //shrinkWrap:true,
      itemBuilder: (BuildContext context, int index) {
        var vo = data[index];
        return _cardItem(vo);
      },
      itemCount: data.length,
    );
  }

  Widget _cardItem(MenuVO vo) {
    var url = vo.icon;
    Widget ui;

    if (url.indexOf("assets") == 0) {
      ui = Image.asset(url,fit: BoxFit.cover,);
      ui=Container(width: Ux.px(335),child: ui,);
    } else {
      ui = CachedNetworkImage(
          width: Ux.px(335),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          imageUrl: url,
          fit: BoxFit.cover);
    }

    ui = Stack(
      children: <Widget>[
        ui,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            color: Colors.black54,
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  vo.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        )
      ],
    );

    ui = Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2.0),
              blurRadius: 2.0,
              spreadRadius: 0),
        ],
      ),
      child: ui,
    );

    ui = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      height: Ux.px(180),
      width: Ux.px(335),
      child: ui,
    );

    ui = InkWell(
      onTap: () => _onItemTap(vo),
      child: ui,
    );
    return ui;
  }

  _onItemTap(MenuVO vo) {
    if (vo.url == "") {
      toast("开发中...");
      return;
    }
    navNamed("/article", vo);
  }
}
