import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';

class SnackBarFlash extends StatelessWidget {
  final UserState userState;
  final bool isError;
  final String message;
  const SnackBarFlash(
      {super.key,
      required this.isError,
      required this.userState,
      required this.message});

  @override
  Widget build(BuildContext context) {
    if (isError == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              width: 200,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.teal,
              behavior: SnackBarBehavior.floating,
              width: 200,
            ),
          );
        }
      });
    }

    return Container(); // You can return an empty container or any other widget here
  }
}
