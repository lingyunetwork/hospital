import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key);

  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var latlng=new LatLng(31.40527,121.48941);

    return FlutterMap(
      options: new MapOptions(
        center: latlng,//经纬度，注意前后顺序，用于展示中心
        zoom: 15.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",//瓦片地图的URL
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoiY3JsY2xyIiwiYSI6ImNrMGk0MXh1bDA2aGMzYm1paGtqZTlveG8ifQ.LxN5LLpMs2labGlrMHjiRg',
            'id': 'mapbox.streets',//其他附加内容
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: latlng,//经纬度注意顺序
              builder: (ctx) =>
              new Container(
                child: Icon(Icons.room,color: Colors.red,),// 在标记的位置加上标记
              ),
            ),
          ],
        ),
      ],
    );
  }
}