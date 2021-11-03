import 'package:flutter/material.dart';

class Headline extends StatelessWidget {

  Headline({required this.headline});
  final String headline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 48,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                color: Colors.white,
                child: Text('$headline',  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.5))),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                color: Colors.white,
                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
              ),
            ),
          ),
        ],
      ),
    );
  }
}