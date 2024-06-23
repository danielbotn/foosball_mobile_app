import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/utils/app_color.dart';
import 'package:foosball_mobile_app/utils/helpers.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class SlackSettings extends StatefulWidget {
  final UserState userState;
  const SlackSettings({super.key, required this.userState});

  @override
  State<SlackSettings> createState() => _SlackSettingsState();
}

class _SlackSettingsState extends State<SlackSettings> {
  final TextEditingController _slackWebhookController = TextEditingController();
  late Future<OrganisationResponse?> organisationFuture;
  String _infoText = '';
  String _slackWebhook = '';

  @override
  void initState() {
    super.initState();
    organisationFuture = getOrganisation();
  }

  Future<OrganisationResponse?> getOrganisation() async {
    Organisation api = Organisation();
    var data =
        await api.getOrganisationById(widget.userState.currentOrganisationId);

    if (data != null &&
        data.slackWebhookUrl != null &&
        data.slackWebhookUrl != "") {
      setState(() {
        _slackWebhook = data.slackWebhookUrl!;
        _slackWebhookController.text = data.slackWebhookUrl!;
      });
    }

    return data;
  }

  void _submitSlackWebHook() async {
    Helpers helpers = Helpers();
    Organisation api = Organisation();
    OrganisationResponse? existingData = await organisationFuture;

    if (existingData != null) {
      String updatedSlackWebhook = _slackWebhookController.text;

      // Assuming you have an OrganisationUpdateRequest model that matches your API's expected update request body
      var organisationUpdateRequest = OrganisationResponse(
        id: widget.userState.currentOrganisationId,
        name: existingData.name,
        createdAt: existingData.createdAt,
        organisationCode: existingData.organisationCode,
        organisationType: existingData.organisationType,
        slackWebhookUrl: updatedSlackWebhook,
      );

      var response = await api.updateOrganisation(
          widget.userState.currentOrganisationId, organisationUpdateRequest);

      if (!mounted) return; // Ensure the widget is still mounted

      if (response == true) {
        // success
        FocusScope.of(context).unfocus(); // Close the keyboard
        helpers.showSnackbar(context, "Slack Webhook updated", false);
      } else {
        // failure
        helpers.showSnackbar(context, "failed to update Slack webhook", true);
      }
    } else {
      if (!mounted) return; // Ensure the widget is still mounted
      helpers.showSnackbar(context, "failed to fetch organisation data", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userState.hardcodedStrings.slack,
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
      body: FutureBuilder<OrganisationResponse?>(
        future: organisationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loading(userState: widget.userState));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            return Container(
              color: widget.userState.darkmode
                  ? AppColors.darkModeBackground
                  : AppColors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userState.hardcodedStrings.enterSlackWebhook,
                    style: TextStyle(
                      color: widget.userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _slackWebhookController,
                    decoration: InputDecoration(
                      labelText: widget.userState.hardcodedStrings.slackWebhook,
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
                    obscureText: false,
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitSlackWebHook,
                        style: ElevatedButton.styleFrom(
                          primary: widget.userState.darkmode
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
            );
          }
        },
      ),
    );
  }
}
