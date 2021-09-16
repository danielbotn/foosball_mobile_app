import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:foosball_mobile_app/models/other/dashboar_param.dart';

class Dashboard extends StatelessWidget {
  final DashboardParam param;
  Dashboard({required this.param});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gaur')
        ),
        body: Center(
          child: Observer(
              builder: (_) => Text(
                    '${param.userState.userId}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
            ),
        )
      )
    );
  }
}