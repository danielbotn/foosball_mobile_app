import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';

class TableCellStandings extends StatelessWidget {
  final UserState userState;
  final String text;
  const TableCellStandings(
      {super.key, required this.userState, required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
