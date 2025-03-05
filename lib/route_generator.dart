import 'package:dano_foosball/widgets/foosball_table/foosball_dashboard/foosball_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/Settings.dart';
import 'package:dano_foosball/widgets/Single_game.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:dano_foosball/widgets/freehand_history/freehand_match_detail.dart';
import 'package:dano_foosball/widgets/login.dart';

import 'models/other/TwoPlayersObject.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'login':
        if (args is UserState) {
          return MaterialPageRoute(builder: (_) => Login(userState: args));
        } else {
          return _errorRoute();
        }
      case 'foosball-dashboard':
        if (args is UserState) {
          return MaterialPageRoute(
              builder: (_) => FoosballDashboard(userState: args));
        } else {
          return _errorRoute();
        }
      case 'dashboard':
        if (args is UserState) {
          return MaterialPageRoute(
              builder: (_) => NewDashboard(userState: args));
        } else {
          return _errorRoute();
        }
      case 'singlegame':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => const SingleGame(test: 'test'));
        } else {
          return _errorRoute();
        }
      case 'settings':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => Settings(userState: userState));
        } else {
          return _errorRoute();
        }
      case 'matchDetailTwoPlayers':
        if (args is TwoPlayersObject) {
          return MaterialPageRoute(
              builder: (_) => FreehandMatchDetail(twoPlayersObject: args));
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
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Error'),
          ));
    });
  }
}
