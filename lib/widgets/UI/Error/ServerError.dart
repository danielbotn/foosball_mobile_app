import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';

class ServerError extends StatefulWidget {
  final UserState userState;
  const ServerError({super.key, required this.userState});

  @override
  State<ServerError> createState() => _ServerErrorState();
}

class _ServerErrorState extends State<ServerError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.userState.darkmode ? Colors.black : Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: widget.userState.darkmode ? Colors.white : Colors.black,
                size: 80.0,
              ),
              const SizedBox(height: 20),
              ExtendedText(
                text: 'There is a server error. We apologize.',
                userState: widget.userState,
                fontSize: 18.0,
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
