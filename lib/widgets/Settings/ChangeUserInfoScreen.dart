import 'package:flutter/material.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';

class ChangeUserInfoScreen extends StatefulWidget {
  final UserState userState;

  const ChangeUserInfoScreen({super.key, required this.userState});

  @override
  State<ChangeUserInfoScreen> createState() => _ChangeUserInfoScreenState();
}

class _ChangeUserInfoScreenState extends State<ChangeUserInfoScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _infoText = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    // Assuming user info is accessible via `widget.userState`
    setState(() {
      _firstNameController.text =
          widget.userState.userInfoGlobal.firstName ?? '';
      _lastNameController.text = widget.userState.userInfoGlobal.lastName ?? '';
    });
  }

  Future<void> _submitUserInfo() async {
    Helpers helpers = Helpers();

    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      setState(() {
        _infoText = "Please fill out all fields";
      });
      return;
    }

    // Call API to update user info
    bool isSuccess = await _updateUserInfo(firstName, lastName);

    if (!mounted) return; // Ensure the widget is still mounted

    if (isSuccess) {
      FocusScope.of(context).unfocus(); // Close the keyboard
      helpers.showSnackbar(
        context,
        "Successfully updated user information",
        false,
      );
      Navigator.pop(context); // Go back to the previous screen
    } else {
      helpers.showSnackbar(
        context,
        "could not update user information",
        true,
      );
    }
  }

  Future<bool> _updateUserInfo(String firstName, String lastName) async {
    // Mock API call - replace with actual implementation
    await Future.delayed(const Duration(seconds: 2));
    return true; // Return true if the update is successful, false otherwise
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change user info",
          style: TextStyle(
            color: widget.userState.darkmode
                ? AppColors.white
                : AppColors.surfaceDark,
          ),
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
              "Enter first name",
              style: TextStyle(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.surfaceDark,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _firstNameController,
              labelText: widget.userState.hardcodedStrings.firstName,
            ),
            const SizedBox(height: 16.0),
            Text(
              "Enter last name",
              style: TextStyle(
                color: widget.userState.darkmode
                    ? AppColors.white
                    : AppColors.surfaceDark,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _lastNameController,
              labelText: widget.userState.hardcodedStrings.lastName,
            ),
            const SizedBox(height: 16.0),
            if (_infoText.isNotEmpty)
              Text(
                _infoText,
                style: TextStyle(
                  color: widget.userState.darkmode
                      ? AppColors.white
                      : AppColors.surfaceDark,
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitUserInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.userState.darkmode
                        ? AppColors.darkModeButtonColor
                        : AppColors.buttonsLightTheme,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    widget.userState.hardcodedStrings.save,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
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
    );
  }
}
