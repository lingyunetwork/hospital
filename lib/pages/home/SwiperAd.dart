import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hospital/provider/DataProvider.dart';
import 'package:hospital/provider/MenuVO.dart';
import 'package:hospital/widget/DotSwiper.dart';
import 'package:hospital/widget/StateEvent.dart';
import 'package:hospital/widget/Ux.dart';

class SwiperAd extends StatefulWidget {
  final DataProvider dataProvider;
  const SwiperAd(this.dataProvider, {Key key}) : super(key: key);

  @override
  _SwiperAdState createState() => _SwiperAdState();
}

class _SwiperAdState extends StateEvent<SwiperAd> {
  List<MenuVO> data;

  @override
  void initState() {
    super.initState();
    data = widget.dataProvider.get("swipers");
  }

  @override
  Widget build(BuildContext context) {
    Widget ui;
    ui = Swiper(
      itemBuilder: _itemBuilder,
      itemCount: data.length,
      pagination: new SwiperPagination(
          margin: const EdgeInsets.all(3.0), builder: DotSwiper()),
      scale: 1.0,
      autoplay: true,
    );

    return Container(
        color: Colors.grey, width: Ux.px(375), height: Ux.px(200), child: ui);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var vo = data[index];
    String url = vo.icon;

    Widget ui;
    if (url.indexOf("assets") == 0) {
      ui = Image.asset(url,fit: BoxFit.cover,);
    } else {
      ui = CachedNetworkImage(
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          imageUrl: url,
          fit: BoxFit.fitWidth);
    }
    return InkWell(
      onTap: () => _onItemTap(vo),
      child: ui,
    );
  }

  _onItemTap(MenuVO vo) {
    if (vo.url == "") {
      toast("开发中...");
      return;
    }
    cleanToast();

    navNamed("/article", vo);
  }
}
