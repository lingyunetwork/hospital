import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import 'location/scale_layer_plugin_option.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key key}) : super(key: key);

  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var latlng = new LatLng(31.40527, 121.48941);
  var _zoom = 15.0;
  MapControllerImpl _controller;
  @override
  void initState() {
    _controller = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ui = FlutterMap(
      mapController: _controller,
      options: new MapOptions(
        center: latlng, //经纬度，注意前后顺序，用于展示中心
        zoom: _zoom,
        minZoom: 10,
        maxZoom: 18,
        plugins: [
          ScaleLayerPlugin(),
        ],
      ),
      layers: [
        // new TileLayerOptions(
        //   urlTemplate: "https://api.tiles.mapbox.com/v4/"
        //       "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",//瓦片地图的URL
        //   additionalOptions: {
        //     'accessToken': 'pk.eyJ1IjoiY3JsY2xyIiwiYSI6ImNrMGk0MXh1bDA2aGMzYm1paGtqZTlveG8ifQ.LxN5LLpMs2labGlrMHjiRg',
        //     'id': 'mapbox.streets',//其他附加内容
        //   },
        // ),
        TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c']),
        ScaleLayerPluginOption(
          lineColor: Colors.blue,
          lineWidth: 2,
          textStyle: TextStyle(color: Colors.blue, fontSize: 12),
          padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
        ),

        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: latlng, //经纬度注意顺序
              builder: (ctx) => new Container(
                child: Icon(
                  Icons.room,
                  color: Colors.red,
                ), // 在标记的位置加上标记
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onPress,
        child: Icon(Icons.my_location),
      ),
      body: ui,
    );
  }

  onPress() {
    _controller.move(latlng, _controller.zoom);
  }
}
