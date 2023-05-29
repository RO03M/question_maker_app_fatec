import 'package:flutter/material.dart';
import 'package:question_maker_app/screens/home/home_page.dart';
import 'package:question_maker_app/screens/login/login_page.dart';
import 'package:question_maker_app/screens/register/register_page.dart';

class RoutesManager {
  static String login = "/login";
  static String register = "/register";
  static String homepage = "/homepage";

  static Map<String, Widget> routes = {
    login: LoginPage(),
    register: RegisterPage(),
    homepage: HomePage()
  };

  static Route? controller(RouteSettings settings) {
    Widget? targetWidget = routes[settings.name];
    if (targetWidget != null) {
      return MaterialPageRoute(builder: (context) => targetWidget);
    }
  }  
}