import 'package:flutter/material.dart';

class SingleGame extends StatefulWidget {
  final String test;
  SingleGame({Key? key, required this.test, String }) : super(key: key);

  @override
  _SingleGameState createState() => _SingleGameState();
}

class _SingleGameState extends State<SingleGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.widget.test),
    );
  }
}