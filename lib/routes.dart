import 'package:flutter/material.dart';

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    opaque: false,
  );
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1.0),
          end: Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500,),
    opaque: true,
  );
}

class RevealRoute extends PageRouteBuilder {
  final Widget page;


  RevealRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return ScaleTransition(
        scale: Tween<double>(
            begin: 0.0,
            end: 1.0
        ).chain(CurveTween(curve: Curves.ease)).animate(animation, ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300,),
    opaque: true,
  );
}
