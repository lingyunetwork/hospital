import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/MenuVO.dart';
import 'package:hospital/widget/DotSwiper.dart';
import 'package:hospital/widget/StateEvent.dart';
import 'package:hospital/widget/Ux.dart';
import 'package:url_launcher/url_launcher.dart';

class SwiperCategory extends StatefulWidget {
  final DataProvider dataProvider;
  const SwiperCategory(this.dataProvider, {Key key}) : super(key: key);

  @override
  _SwiperCategoryState createState() => _SwiperCategoryState();
}

class _SwiperCategoryState extends StateEvent<SwiperCategory> {
  List<MenuVO> data;
  @override
  void initState() {
    data = widget.dataProvider.get("iconMenu");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Ux.px(220),
        color: Colors.white,
        child: Swiper(
          itemBuilder: _itemBuilder,
          itemCount: 1,
          pagination: new SwiperPagination(builder: DotSwiper()),
          autoplay: false,
          loop: false,
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    List<Widget> navigatorList = List();

    var column = 4;
    var len = column * 2;
    for (var i = 0; i < len; i++) {
      var item = data[index * len + i];
      if (item != null) {
        navigatorList.add(_getItem(context, item));
      }
    }

    return GridView.count(
      //padding: AppStyle.mainPaddingLR,
      mainAxisSpacing: 10,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: column,
      children: navigatorList,
    );
  }

  Widget _getItem(BuildContext context, MenuVO value) {
    //var icon=Image.network(value.icon,fit: BoxFit.fill,);

    var ui = Container(
        //color: Colors.redAccent,
        child: Column(children: <Widget>[
      Expanded(child: Image.asset(value.icon)),
      Text(
        value.name,
        style: TextStyle(
            fontSize: 14, color: Colors.black54, fontWeight: FontWeight.normal),
        softWrap: false,
      ),
    ]));

    return InkWell(
      onTap: () => _onItemTap(value),
      child: Center(child: ui),
    );
  }

  _onItemTap(MenuVO vo) {
    if (vo.url == "") {
      toast("开发中...");
      return;
    }

    if(vo.url.indexOf("http")==0){
      launch(vo.url);
      return;
    }
    cleanToast();
    navNamed("/article", vo);
  }
}
