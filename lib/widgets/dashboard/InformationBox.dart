import 'package:flutter/material.dart';

class InformationBox extends StatelessWidget {
  final String headline;
  final String subheadline;
  final String logoUrl;

  const InformationBox({
    Key? key,
    required this.headline,
    required this.subheadline,
    required this.logoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headline,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            subheadline,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
