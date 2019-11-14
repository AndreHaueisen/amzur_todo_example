
import 'dart:math';

import 'package:amzur_todo_example/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

//flutter packages pub run build_runner clean
//flutter packages pub run build_runner build

abstract class _LoginStore with Store {

  final Random randomGenerator = Random(5);
  SharedPreferences prefs;

  // in a normal case, this would hold the firebase user, which holds the login credentials
  @observable
  bool isLoggedIn;

  @action
  Future<void> initialize() async{
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(Constants.PREFERENCES_KEY_IS_LOGGED) ?? false;
  }

  // simulates a login
  @action
  Future<void> logIn() async {
    await Future.delayed(const Duration(seconds: 2));

    int randomNumber = randomGenerator.nextInt(9);
    isLoggedIn = randomNumber > 1; // this gives a 80% change that the login will succeed

    // this represents saving the user's credentials across sections
    // you can save it manually or use the fact that Firebase does that for you.
    // Here, I'm simply getting a bool
    await prefs.setBool(Constants.PREFERENCES_KEY_IS_LOGGED, isLoggedIn);
  }

  @action
  Future<void> logOut() async {
    isLoggedIn = false;
    await prefs.setBool(Constants.PREFERENCES_KEY_IS_LOGGED, isLoggedIn);
  }
}