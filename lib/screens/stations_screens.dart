import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StationsScreens extends StatefulWidget {
  @override
  _StationsScreensState createState() => _StationsScreensState();
}

class _StationsScreensState extends State<StationsScreens>
    with SingleTickerProviderStateMixin {
  TabController _tabBarController;

  @override
  void initState() {
    super.initState();
    chargingHubsStore.getChargingHubs();
    _tabBarController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "EVoke",
          style: TextStyle(color: textColorPrimary),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.filter, color: textColorPrimary),
            iconSize: 24,
          ),
        ],
        bottom: _buildTabBar(),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabBarController,
        children: <Widget>[
            MapScreen(),
          Container(),
          Container(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabBarController,
      onTap: (index) {
        switch (index) {
          case 0:
            _tabBarController.animateTo(0,
                duration: const Duration(
                  microseconds: 150,
                ),
                curve: Curves.easeInOutCirc);
            break;

          default:
            break;
        }
      },
      tabs: <Widget>[
        Tab(
          icon: Icon(
            Icons.map,
            color: textColorPrimary,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.format_list_bulleted,
            color: textColorPrimary,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.favorite_border,
            color: textColorPrimary,
          ),
        ),
      ],
    );
  }
}
