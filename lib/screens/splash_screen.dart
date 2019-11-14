import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final Text bottomText;
  final ImageProvider backgroundImage;
  final Gradient backgroundGradient;
  SplashScreen(
      {this.loaderColor,
      @required this.seconds,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText,
      this.bottomText,
      this.backgroundImage,
      this.backgroundGradient});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), () async {
      if (widget.navigateAfterSeconds is String) {
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
      } else {
        throw ArgumentError('widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: widget.onClick,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: widget.backgroundImage == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.backgroundImage,
                      ),
                gradient: widget.backgroundGradient,
                color: widget.backgroundColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                widget.image != null ? Padding(padding: const EdgeInsets.all(16), child: widget.image) : Container(),
                Spacer(),
                widget.title != null ? Padding(padding: const EdgeInsets.all(16), child: widget.title) : Container(),
                Spacer(),
                widget.loadingText != null ? Padding(padding: const EdgeInsets.all(16), child: widget.loadingText) : Container(),
                Spacer(),
                widget.bottomText != null
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: widget.bottomText,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
