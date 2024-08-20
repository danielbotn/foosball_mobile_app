import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

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
        child: ExtendedText(
          text: text,
          userState: userState,
          fontSize: 14,
        ),
      ),
    );
  }
}
