import 'package:flutter/material.dart';
import 'package:dano_foosball/api/Organisation.dart';
import 'package:dano_foosball/models/organisation/organisation_response.dart';
import 'package:dano_foosball/state/user_state.dart';
import 'package:dano_foosball/utils/app_color.dart';
import 'package:dano_foosball/utils/helpers.dart';
import 'package:dano_foosball/widgets/UI/Error/ServerError.dart';
import 'package:dano_foosball/widgets/loading.dart';

class TeamsSettings extends StatefulWidget {
  final UserState userState;
  const TeamsSettings({super.key, required this.userState});

  @override
  State<TeamsSettings> createState() => _TeamsSettingsState();
}

class _TeamsSettingsState extends State<TeamsSettings> {
  final TextEditingController _teamsWebhookController = TextEditingController();
  late Future<OrganisationResponse?> organisationFuture;
  String _infoText = '';
  String _teamsWebhook = '';

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
        data.microsoftTeamsWebhookUrl != null &&
        data.microsoftTeamsWebhookUrl != "") {
      setState(() {
        _teamsWebhook = data.microsoftTeamsWebhookUrl!;
        _teamsWebhookController.text = data.microsoftTeamsWebhookUrl!;
      });
    }

    return data;
  }

  void _submitTeamsWebHook() async {
    Helpers helpers = Helpers();
    Organisation api = Organisation();
    OrganisationResponse? existingData = await organisationFuture;

    if (existingData != null) {
      String updatedTeamsWebhook = _teamsWebhookController.text;

      var organisationUpdateRequest = OrganisationResponse(
          id: widget.userState.currentOrganisationId,
          name: existingData.name,
          createdAt: existingData.createdAt,
          organisationCode: existingData.organisationCode,
          organisationType: existingData.organisationType,
          slackWebhookUrl: existingData.slackWebhookUrl,
          discordWebhookUrl: existingData.discordWebhookUrl,
          microsoftTeamsWebhookUrl: updatedTeamsWebhook);

      var response = await api.updateOrganisation(
          widget.userState.currentOrganisationId,
          organisationUpdateRequest,
          false,
          true);

      if (!mounted) return;

      if (response == true) {
        FocusScope.of(context).unfocus();
        helpers.showSnackbar(context,
            widget.userState.hardcodedStrings.teamsWebhookUpdated, false);
      } else {
        helpers.showSnackbar(
            context, widget.userState.hardcodedStrings.teamsWebhookError, true);
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
        title: Text("Teams",
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
                    widget.userState.hardcodedStrings.enterTeamsWebhook,
                    style: TextStyle(
                      color: widget.userState.darkmode
                          ? AppColors.white
                          : AppColors.textBlack,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _teamsWebhookController,
                    decoration: InputDecoration(
                      labelText: widget.userState.hardcodedStrings.teamsWebhook,
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
                        onPressed: _submitTeamsWebHook,
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
