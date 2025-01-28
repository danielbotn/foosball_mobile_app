import 'package:flutter/material.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/state/user_state.dart';

class CustomInput extends StatelessWidget {
  final UserState userState;
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const CustomInput({
    super.key,
    required this.userState,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: userState.darkmode ? AppColors.white : AppColors.surfaceDark,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: userState.darkmode ? AppColors.white : AppColors.surfaceDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: userState.darkmode ? AppColors.white : AppColors.surfaceDark,
          ),
        ),
      ),
      style: TextStyle(
        color: userState.darkmode ? AppColors.white : AppColors.surfaceDark,
      ),
      obscureText: obscureText,
    );
  }
}
