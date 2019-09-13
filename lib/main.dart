import 'package:flutter/material.dart';
import 'package:hospital/pages/article.dart';
import 'package:hospital/pages/index.dart';

import 'widget/Ux.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    "/home": (ctx) => IndexPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Ux.init(375);
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var name = settings.name;
    switch (name) {
      case "/article":
        return MaterialPageRoute(
            builder: (context) => ArticlePage(settings.arguments));
        break;
      default:
        var builder = routes[name];
        if (builder == null) {
          name = "/home";
          builder = routes[name];
        }
        return MaterialPageRoute(builder: builder);
    }
  }
}
