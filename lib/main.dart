import 'package:amzur_todo_example/constants.dart';
import 'package:amzur_todo_example/screens/stations_screens.dart';
import 'package:amzur_todo_example/screens/login_screen.dart';
import 'package:amzur_todo_example/screens/splash_screen.dart';
import 'package:amzur_todo_example/stores/charging_hubs_store.dart';
import 'package:amzur_todo_example/stores/login_store.dart';
import 'package:amzur_todo_example/stores/todo_store.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Important line if you are going to hang app initialization
  await loginStore.initialize();
  String openingScreen;

  if (loginStore.isLoggedIn) {
    openingScreen = Constants.ROUTE_STATIONS;
  } else {
    openingScreen = Constants.ROUTE_LOGIN;
  }
  runApp(MyApp(
    openingScreen: openingScreen,
  ));
}

final TodoStore todoStore = TodoStore();
final LoginStore loginStore = LoginStore();
final ChargingHubsStore chargingHubsStore = ChargingHubsStore();

class MyApp extends StatelessWidget {
  final String openingScreen;

  MyApp({@required this.openingScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: accentColor,
        canvasColor: Colors.white,
        primaryColor: primaryColor,
      ),
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: openingScreen,
        title: Text(
          "EVoke",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundGradient: LinearGradient(
          colors: [textColorPrimaryDark, primaryColor, textColorPrimaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      routes: {
        Constants.ROUTE_LOGIN: (context) => LoginScreen(),
        Constants.ROUTE_STATIONS: (context) => StationsScreens(),
      },
    );
  }
}

const Color accentColor = const Color(0xFFFF6F20);
const Color primaryColor = const Color(0xFF5E5D75);

const Color textColorPrimaryLight = const Color(0xFFA9AEB3);
const Color textColorPrimary = const Color(0xFF5E5D75);
const Color textColorPrimaryDark = const Color(0xFF203149);
