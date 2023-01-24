import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';

class InputWidget extends StatefulWidget {
  final UserState userState;
  final Function(String value) onChangeInput;
  final bool clearInputText;
  const InputWidget(
      {Key? key,
      required this.userState,
      required this.onChangeInput,
      required this.clearInputText})
      : super(key: key);

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
              widget.userState.darkmode ? AppColors.white : AppColors.textGrey),
      focusNode: focusNode,
      controller: _inputController,
      onChanged: (String value) {
        widget.onChangeInput(value);
      },
      decoration: InputDecoration(
          hintStyle: TextStyle(
              color: widget.userState.darkmode
                  ? AppColors.white
                  : AppColors.textGrey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textGrey,
                width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textGrey,
                width: 1.0),
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
              )),
          hintText: widget.userState.hardcodedStrings.lastName),
    );
  }
}
