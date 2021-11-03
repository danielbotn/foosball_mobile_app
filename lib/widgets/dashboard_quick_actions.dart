import 'package:flutter/material.dart';

class QuicActions extends StatelessWidget {
  const QuicActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          height: 60,
          width: 50,
          color: Color.fromRGBO(127,211,29, .9),
          alignment: Alignment.center,
          child: Icon(Icons.play_circle_filled_rounded, color: Colors.white)
        ),
        Container(
          margin: const EdgeInsets.all(3.0),
          height: 60,
          width: 50,
          color: Color.fromRGBO(255,136,0, .9),
          alignment: Alignment.center,
          child: Icon(Icons.history, color: Colors.white)
        ),
        Container(
          margin: const EdgeInsets.all(3.0),
          height: 60,
          width: 50,
          color: Color.fromRGBO(112,193,255, .9),
          alignment: Alignment.center,
          child: Icon(Icons.email, color: Colors.white)
        ),
        Container(
          margin: const EdgeInsets.all(3.0),
          height: 60,
          width: 50,
          color: Color.fromRGBO(112,193,255, .9),
          alignment: Alignment.center,
          child: Icon(Icons.settings, color: Colors.white)
        )
      ],
    );
  }
}
