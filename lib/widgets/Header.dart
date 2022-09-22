import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, @required this.index, required this.onPress});

  // ignore: prefer_typing_uninitialized_variables
  final index;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Text('Card $index'),
        TextButton(
          onPressed: onPress,
          child: const Text('Press'),
        ),
      ],
    ));
  }
}
