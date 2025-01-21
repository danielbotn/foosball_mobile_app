import 'package:dano_foosball/main.dart';
import 'package:dano_foosball/widgets/UI/Buttons/Button.dart';
import 'package:dano_foosball/widgets/extended_Text.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/AuthApi.dart';
import 'package:dano_foosball/models/auth/update_password_request.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/widgets/inputs/InputWidget.dart';

class ChangePassword extends StatefulWidget {
  final UserState userState;
  const ChangePassword({super.key, required this.userState});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  bool _isVerificationCodeFieldVisible = false;
  String _infoText = '';

  void _submitPassword() async {
    String newPassword = _passwordController.text;
    String confirmPassword = _passwordController.text;
    String verificationCode = _verificationCodeController.text;

    UpdatePasswordRequest request = UpdatePasswordRequest(
      password: newPassword,
      confirmPassword: confirmPassword,
      verificationCode: verificationCode,
    );

    AuthApi authApi = AuthApi();
    var response = await authApi.updatePassword(request);

    if (response?.emailSent == true &&
        response?.verificationCodeCreated == true) {
      setState(() {
        _isVerificationCodeFieldVisible = true;
        _infoText =
            '${widget.userState.hardcodedStrings.pleaseCheckYourInbox} ${widget.userState.userInfoGlobal.email}';
      });
    }

    if (response?.passwordUpdated == true) {
      setState(() {
        _passwordController.clear();
        FocusScope.of(context).unfocus();
        _isVerificationCodeFieldVisible = false;
        _infoText =
            widget.userState.hardcodedStrings.passwordSuccessfullyChanged;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ExtendedText(
          text: widget.userState.hardcodedStrings.changePassword,
          userState: userState,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: widget.userState.darkmode
            ? const IconThemeData(color: AppColors.white)
            : IconThemeData(color: Colors.grey[700]),
        backgroundColor: widget.userState.darkmode
            ? AppColors.darkModeBackground
            : AppColors.white,
      ),
      body: Container(
        color: widget.userState.darkmode
            ? AppColors.darkModeBackground
            : AppColors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userState.hardcodedStrings.enterNewPassword,
              style: TextStyle(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textBlack,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            InputWidget(
              userState: widget.userState,
              onChangeInput: (value) => _passwordController.text = value,
              clearInputText: true,
              hintText: widget.userState.hardcodedStrings.newPassword,
            ),
            const SizedBox(height: 16.0),
            if (_infoText.isNotEmpty)
              Text(
                _infoText,
                style: TextStyle(
                  color: widget.userState.darkmode
                      ? AppColors.white
                      : AppColors.textBlack,
                ),
              ),
            if (_isVerificationCodeFieldVisible) ...[
              const SizedBox(height: 16.0),
              InputWidget(
                userState: widget.userState,
                onChangeInput: (value) =>
                    _verificationCodeController.text = value,
                clearInputText: true,
                hintText: widget
                    .userState.hardcodedStrings.pleaseEnterVerificationCode,
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Button(
                onClick: _submitPassword,
                text: _isVerificationCodeFieldVisible == false
                    ? widget.userState.hardcodedStrings.submitPasswordButtonText
                    : widget.userState.hardcodedStrings
                        .submitVerificationButtonText,
                userState: userState,
                paddingBottom: 10,
                paddingLeft: 10,
                paddingRight: 10,
                paddingTop: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
