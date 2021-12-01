import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/Dashboard.dart';
import 'package:foosball_mobile_app/widgets/Settings.dart';
import 'package:foosball_mobile_app/widgets/Single_game.dart';
import 'package:foosball_mobile_app/widgets/login.dart';
import 'models/other/dashboar_param.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case 'login':
        if (args is UserState) {
          return MaterialPageRoute(builder: (_) => Login(userState: args));
        } else {
          return _errorRoute();
        }
      case 'dashboard':
        if (args is DashboardParam) {
          return MaterialPageRoute(builder: (_) => Dashboard(param: args, danni: 'daniel'));
        } else {
          return _errorRoute();
        }
      case 'singlegame':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => SingleGame(test: 'test'));
        } else {
          return _errorRoute();
        }
      case 'settings':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Settings());
        } else {
          return _errorRoute();
        }
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        )
      );
    });
  }
}