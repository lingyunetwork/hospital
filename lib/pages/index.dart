import 'package:flutter/material.dart';
import 'package:hospital/pages/tel.dart';
import 'package:hospital/pages/we.dart';

import 'home.dart';
import 'location.dart';
import 'message.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {
  List<BottomNavigationBarItem> _bars = [];
  List<Widget> _pages = [];

  TabController _tabController;

  @override
  void initState() {
    print("index init");
    
    addTabItem('首页', Icons.home,HomePage());
    addTabItem('电话', Icons.phone,TelPage());
    addTabItem('地址', Icons.room,LocationPage());
    addTabItem('留言', Icons.sms,MessagePage());
    addTabItem('微信', Icons.account_box,WePage());

    _tabController = TabController(length: _bars.length, vsync: this);

    super.initState();
  }


  

  addTabItem(String name, IconData icon, [Widget page]) {
    var ui = BottomNavigationBarItem(icon: Icon(icon), title: Text(name));
    _bars.add(ui);

    if (page == null) {
      page = Center(child: Text("hello empty"));
    }
    _pages.add(page);
  }

  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget ui = Scaffold(
      body: _pages[_tabController.index],
      bottomNavigationBar: BottomNavigationBar(
          items: _bars,
          onTap: _onBottomNavigationBarTap,
          iconSize: 24,
          currentIndex: _tabController.index,
          type: BottomNavigationBarType.fixed,
    ));

    return ui;
  }
}
