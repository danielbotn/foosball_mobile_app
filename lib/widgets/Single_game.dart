import 'package:flutter/material.dart';

class SingleGame extends StatefulWidget {
  final String test;
  const SingleGame({Key? key, required this.test}) : super(key: key);

  @override
  State<SingleGame> createState() => _SingleGameState();
}

class _SingleGameState extends State<SingleGame> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.test);
  }
}
