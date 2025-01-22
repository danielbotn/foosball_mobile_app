import 'package:dano_foosball/widgets/UI/Inputs/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/loading.dart';

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

      var organisationUpdateRequest = OrganisationResponse(
          id: widget.userState.currentOrganisationId,
          name: existingData.name,
          createdAt: existingData.createdAt,
          organisationCode: existingData.organisationCode,
          organisationType: existingData.organisationType,
          slackWebhookUrl: updatedSlackWebhook,
          discordWebhookUrl: existingData.discordWebhookUrl,
          microsoftTeamsWebhookUrl: existingData.microsoftTeamsWebhookUrl);

      var response = await api.updateOrganisation(
          widget.userState.currentOrganisationId,
          organisationUpdateRequest,
          false,
          false);

      if (!mounted) return;

      if (response == true) {
        FocusScope.of(context).unfocus();
        helpers.showSnackbar(context,
            widget.userState.hardcodedStrings.slackWebhookUpdated, false);
      } else {
        helpers.showSnackbar(
            context, widget.userState.hardcodedStrings.slackWebhookError, true);
      }
    } else {
      if (!mounted) return;
      helpers.showSnackbar(
          context, widget.userState.hardcodedStrings.unknownError, false);
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
            return ServerError(userState: widget.userState);
          } else if (!snapshot.hasData) {
            return Center(
                child: Text(widget.userState.hardcodedStrings.noData));
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
                  CustomInput(
                    controller: _slackWebhookController,
                    labelText: widget.userState.hardcodedStrings.slackWebhook,
                    userState: widget.userState,
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
            );
          }
        },
      ),
    );
  }
}
