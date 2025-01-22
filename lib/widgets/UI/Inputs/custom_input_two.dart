import 'package:flutter/material.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/state/user_state.dart';

class CustomInputTwo extends StatefulWidget {
  final UserState userState;
  final String labelText;
  final bool obscureText;
  final Function(String value)
      onChangeInput; // Added the onChangeInput parameter

  const CustomInputTwo({
    super.key,
    required this.userState,
    required this.labelText,
    this.obscureText = false,
    required this.onChangeInput, // Added onChangeInput to constructor
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
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color:
              widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textBlack,
          ),
        ),
      ),
      style: TextStyle(
        color:
            widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
      ),
      obscureText: widget.obscureText,
      onChanged: (value) {
        widget.onChangeInput(value); // Calling the onChangeInput function
      },
    );
  }
}
