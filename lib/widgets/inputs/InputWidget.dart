import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';

class InputWidget extends StatefulWidget {
  final UserState userState;
  final Function(String value) onChangeInput;
  final bool clearInputText;
  final String hintText;

  const InputWidget({
    Key? key,
    required this.userState,
    required this.onChangeInput,
    required this.clearInputText,
    required this.hintText,
  }) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _inputController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void didUpdateWidget(InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clearInputText) {
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color:
            widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
        fontSize: 16.0,
      ),
      focusNode: focusNode,
      controller: _inputController,
      onChanged: (String value) {
        widget.onChangeInput(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.userState.darkmode
            ? AppColors.darkModeLighterBackground
            : AppColors.lightGrey,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color:
              widget.userState.darkmode ? AppColors.grey2 : AppColors.textGrey,
          fontSize: 14.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.leagueDarkModeColorTwo
                : AppColors.lightGreyDarkMode,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.buttonsLightTheme,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _inputController.clear();
          },
          icon: Icon(
            Icons.clear,
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.textGrey,
          ),
        ),
      ),
    );
  }
}
