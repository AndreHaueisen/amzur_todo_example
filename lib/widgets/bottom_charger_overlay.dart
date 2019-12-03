import 'dart:io';

import 'package:amzur_todo_example/constants.dart';
import 'package:amzur_todo_example/dialogs/edit_todo_dialog.dart';
import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/models/charge_point.dart';
import 'package:amzur_todo_example/routes.dart';
import 'package:amzur_todo_example/screens/login_screen.dart';
import 'package:flutter/material.dart';

class BottomChargerOverlay extends StatefulWidget {
  // Remember to watch the videos about keys.
  // https://www.youtube.com/watch?v=kn0EOS-ZiIc&t=
  // I will not be able to explain it better than the Flutter lady did.
  // I had to watch it several times to get it, and I still
  // have to watch it sometimes :)
  final Key key;

  BottomChargerOverlay({@required this.key}) : super(key: key);

  @override
  BottomChargerOverlayState createState() => BottomChargerOverlayState();
}

class BottomChargerOverlayState extends State<BottomChargerOverlay> {
  ChargePoint hub;

  @override
  Widget build(BuildContext context) {
    return hub != null
        ? Card(
            elevation: 10,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildAddressFavoriteRow(),
                  Text(
                    hub?.id ?? "",
                    style: TextStyle(
                        color: textColorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildDistanceInfo(),
                  ),
                  _buildSeparator(),
                  _buildStatus(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildDetailsButton(),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  void onHubChance(ChargePoint hub) {
    setState(() {
      this.hub = hub;
    });
  }

  Widget _buildAddressFavoriteRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            "Hub address",
            style: TextStyle(color: textColorPrimaryLight, fontSize: 18),
          ),
        ),
        Icon(
          Icons.favorite_border,
          color: textColorPrimaryLight,
        ),
      ],
    );
  }

  Widget _buildDistanceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: textColorPrimaryLight.withOpacity(0.6),
        ),
        Text(
          "3.2 miles / 15 mins",
          style: TextStyle(color: textColorPrimaryLight),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 16),
      height: 1,
      color: textColorPrimaryLight.withOpacity(0.5),
    );
  }

  Widget _buildStatus() {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.green,
          ),
          child: Text(
            "Available",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8.0),
          child: _buildLevelWidget("Level 1"),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _buildLevelWidget("Level 2"),
        ),
      ],
    );
  }

  Widget _buildLevelWidget(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: textColorPrimary),
        )
      ],
    );
  }

  Widget _buildDetailsButton() {
    return RaisedButton(
      onPressed: () {
        if (Platform.isAndroid) {
          Navigator.of(context).pushNamedAndRemoveUntil(Constants.ROUTE_LOGIN, (route){
            return false;
          });
        } else {
          // Guys, if you think about it, the IOS animation is going right to left by default because
          // you are pushing a new screen (the login screen). It would go in the other direction if you were popping it.
          // As development moves forward, you may be able to guarantee that the user is in the first screen when he logs out (depending on where you put the log out button).
          // In that case, you can use popAndPushNamed()
          // For now, the solution you have is to use a custom route transition. I created a SlideLeftRoute in the routes.dart file.
          // Notice that the only difference between it and SlideUpRoute is the presence of a route name and the begin & end parameters
          Navigator.of(context).pushAndRemoveUntil(
            SlideLeftRoute(page: LoginScreen(), routeName: Constants.ROUTE_LOGIN),
            (route) {
              return false; // returning false will dismiss every route below the one you are pushing
            },
          );
        }
      },
      color: accentColor,
      textColor: Colors.white,
      child: Text("View Details"),
    );
  }
}
