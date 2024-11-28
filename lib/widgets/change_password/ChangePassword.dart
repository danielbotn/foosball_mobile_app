import 'package:flutter/material.dart';
import 'package:dano_foosball/api/AuthApi.dart';
import 'package:dano_foosball/models/auth/update_password_request.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';

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
    // Assuming you have fields to capture the new password, confirm password, and verification code
    String newPassword = _passwordController.text;
    String confirmPassword = _passwordController.text;
    String verificationCode = _verificationCodeController.text;

    // Create an instance of UpdatePasswordRequest
    UpdatePasswordRequest request = UpdatePasswordRequest(
      password: newPassword,
      confirmPassword: confirmPassword,
      verificationCode: verificationCode,
    );

    AuthApi authApi = AuthApi();
    // Assuming updatePassword method is implemented correctly in AuthApi
    var response = await authApi.updatePassword(request);

    if (response?.emailSent == true &&
        response?.verificationCodeCreated == true) {
      // Update the UI state based on the response
      setState(() {
        _isVerificationCodeFieldVisible = true;
        _infoText =
            '${widget.userState.hardcodedStrings.pleaseCheckYourInbox} ${widget.userState.userInfoGlobal.email}';
      });
    }

    if (response?.passwordUpdated == true) {
      setState(() {
        // Clear the password controller and unfocus the input field
        _passwordController.text = "";
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
        title: Text(widget.userState.hardcodedStrings.changePassword,
            style: TextStyle(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textBlack)),
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
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: widget.userState.hardcodedStrings.newPassword,
                labelStyle: TextStyle(
                  color: widget.userState.darkmode
                      ? AppColors.white
                      : AppColors.textBlack,
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
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.textBlack,
              ),
              obscureText: true,
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
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: widget
                      .userState.hardcodedStrings.pleaseEnterVerificationCode,
                  labelStyle: TextStyle(
                    color: widget.userState.darkmode
                        ? AppColors.white
                        : AppColors.textBlack,
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
                  color: widget.userState.darkmode
                      ? AppColors.white
                      : AppColors.textBlack,
                ),
              ),
            ],
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.userState.darkmode
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    _isVerificationCodeFieldVisible == false
                        ? widget
                            .userState.hardcodedStrings.submitPasswordButtonText
                        : widget.userState.hardcodedStrings
                            .submitVerificationButtonText,
                    style: TextStyle(
                      color: widget.userState.darkmode
                          ? AppColors.white
                          : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
