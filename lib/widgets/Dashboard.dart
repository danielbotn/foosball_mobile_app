import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gaur')
        ),
        body: Center(
          child: Text('Dahsboard child'),
        )
      )
    );
  }
}