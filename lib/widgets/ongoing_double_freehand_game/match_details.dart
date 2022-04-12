import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/models/other/freehandDoubleMatchDetailObject.dart';

class MatchDetails extends StatefulWidget {
  final FreehandDoubleMatchDetailObject data;
  MatchDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}