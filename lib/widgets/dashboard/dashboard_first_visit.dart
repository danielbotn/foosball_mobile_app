import 'package:flutter/material.dart';

class DashBoardFirstVisit extends StatefulWidget {
  const DashBoardFirstVisit({Key? key}) : super(key: key);

  @override
  State<DashBoardFirstVisit> createState() => _DashBoardFirstVisitState();
}

class _DashBoardFirstVisitState extends State<DashBoardFirstVisit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Gaur er staur'),
    );
  }
}