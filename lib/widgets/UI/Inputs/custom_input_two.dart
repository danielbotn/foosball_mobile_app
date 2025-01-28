import 'package:flutter/material.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/state/user_state.dart';

class CustomInputTwo extends StatefulWidget {
  final UserState userState;
  final String labelText;
  final bool obscureText;
  final bool clearInputText; // Added the clearInputText parameter
  final Function(String value) onChangeInput;
  const CustomInputTwo({
    super.key,
    required this.userState,
    required this.labelText,
    this.obscureText = false,
    this.clearInputText = false, // Default value set to false
    required this.onChangeInput,
  });

  @override
  State<CustomInputTwo> createState() => _CustomInputTwoState();
}

class _CustomInputTwoState extends State<CustomInputTwo> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomInputTwo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clearInputText) {
      _controller.clear(); // Clear the input text if clearInputText is true
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.userState.darkmode
              ? AppColors.white
              : AppColors.surfaceDark,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.surfaceDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.surfaceDark,
          ),
        ),
      ),
      style: TextStyle(
        color:
            widget.userState.darkmode ? AppColors.white : AppColors.surfaceDark,
      ),
      obscureText: widget.obscureText,
      onChanged: (value) {
        widget.onChangeInput(value);
      },
    );
  }
}
