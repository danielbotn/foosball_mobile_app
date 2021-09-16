import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/widgets/Dashboard.dart';
import 'package:foosball_mobile_app/widgets/Login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      // case 'dashboard':
      //   return MaterialPageRoute(builder: (_) => Dashboard());
      
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