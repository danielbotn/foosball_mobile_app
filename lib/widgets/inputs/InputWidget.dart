// InputWidget.dart
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
    if (widget.clearInputText == true) {
      _inputController.text = "";
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color:
            widget.userState.darkmode ? AppColors.white : AppColors.textBlack,
      ),
      focusNode: focusNode,
      controller: _inputController,
      onChanged: (String value) {
        widget.onChangeInput(value);
      },
      decoration: InputDecoration(
        labelText: widget.hintText,
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
