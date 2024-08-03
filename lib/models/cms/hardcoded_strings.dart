import 'package:json_annotation/json_annotation.dart';

part 'hardcoded_strings.g.dart';

@JsonSerializable()
class HardcodedStrings {
  final String matches;
  final String newGame;
  final String quickActions;
  final String lastTenMatches;
  final String statistics;
  final String history;
  final String leagues;
  final String pricing;
  final String settings;
  final String about;
  final String logout;
  final String language;
  final String darkTheme;
  final String lightTheme;
  final String changePassword;
  final String enableNotifications;
  final String common;
  final String security;
  final String won;
  final String lost;
  final String scored;
  final String recieved;
  final String goals;
  final String user;
  final String username;
  final String organisation;
  final String personalInformation;
  final String integration;
  final String slack;
  final String discord;
  final String matchDetails;
  final String totalPlayingTime;
  final String newMatch;
  final String rematch;
  final String twoPlayers;
  final String fourPlayers;
  final String choosePlayers;
  final String match;
  final String startGame;
  final String chooseTeammate;
  final String chooseOpponent;
  final String chooseOpponents;
  final String matchReport;
  final String game;
  final String resume;
  final String pause;
  final String close;
  final String yes;
  final String no;
  final String cancel;
  final String areYouSureAlert;
  final String currentOrganisation;
  final String organisations;
  final String players;
  final String newOrganisation;
  final String addPlayers;
  final String nameOfNewOrganisation;
  final String create;
  final String newOrganisationSuccessMessage;
  final String newOrganisationErrorMessage;
  final String organisationSettings;
  final String createNewOrganisation;
  final String joinExistingOrganisation;
  final String managePlayers;
  final String changeOrganisation;
  final String information;
  final String organisationCode;
  final String letOtherPlayersJoinYourOrganisation;
  final String joinOrganisation;
  final String scanQrCode;
  final String success;
  final String failure;
  final String obsFailure;
  final String cameraPermissionWasDenied;
  final String unknownError;
  final String youPressedTheBackButton;
  final String joinOrganisationInfo;
  final String joinOrganisationInfo2;
  final String actions;
  final String joinExistingOrganisationWithQrCode;
  final String organisationCardInfo;
  final String managePlayer;
  final String admin;
  final String deleteUser;
  final String active;
  final String inactive;
  final String changeOrganisationAlertText;
  final String deleteThisMatch;
  final String deleteMatchAreYouSure;
  final String createGroupPlayer;
  final String groupPlayerInfoText;
  final String groupPlayerCreateFailure;
  final String groupPlayerCreateSuccess;
  final String firstName;
  final String lastName;
  final String league;
  final String createNewLeague;
  final String createLeague;
  final String leagueName;
  final String standings;
  final String fixtures;
  final String notStarted;
  final String welcomeTextBody;
  final String welcomeTextButton;
  final String welcomeTextHeadline;
  final String noUsersExists;
  final String noData;
  final String noOrganisation;
  final String pleaseCheckYourInbox;
  final String passwordSuccessfullyChanged;
  final String enterNewPassword;
  final String newPassword;
  final String pleaseEnterVerificationCode;
  final String submitPasswordButtonText;
  final String submitVerificationButtonText;
  final String enterSlackWebhook;
  final String slackWebhook;
  final String save;
  final String createTeam;
  final String teamName;
  final String errorCouldNotCreateTeam;
  final String addTeam;
  final String selectedPlayers;
  final String startLeague;
  final String totalTeamsInLeague;
  final String partOfLeagueToStartIt;
  final String startLeagueError;
  final String enterDiscordWebhook;
  final String discordWebhook;
  final String discordWebhookError;
  final String discordWebhookUpdated;
  final String enterTeamsWebhook;
  final String teamsWebhook;
  final String teamsWebhookError;
  final String teamsWebhookUpdated;
  final String slackWebhookError;
  final String slackWebhookUpdated;

  HardcodedStrings({
    required this.matches,
    required this.newGame,
    required this.quickActions,
    required this.lastTenMatches,
    required this.statistics,
    required this.history,
    required this.leagues,
    required this.pricing,
    required this.settings,
    required this.about,
    required this.logout,
    required this.language,
    required this.darkTheme,
    required this.lightTheme,
    required this.changePassword,
    required this.enableNotifications,
    required this.common,
    required this.security,
    required this.won,
    required this.lost,
    required this.scored,
    required this.recieved,
    required this.goals,
    required this.user,
    required this.username,
    required this.organisation,
    required this.personalInformation,
    required this.integration,
    required this.slack,
    required this.discord,
    required this.matchDetails,
    required this.totalPlayingTime,
    required this.newMatch,
    required this.rematch,
    required this.twoPlayers,
    required this.fourPlayers,
    required this.choosePlayers,
    required this.match,
    required this.startGame,
    required this.chooseTeammate,
    required this.chooseOpponent,
    required this.chooseOpponents,
    required this.matchReport,
    required this.game,
    required this.resume,
    required this.pause,
    required this.close,
    required this.yes,
    required this.no,
    required this.cancel,
    required this.areYouSureAlert,
    required this.currentOrganisation,
    required this.organisations,
    required this.players,
    required this.newOrganisation,
    required this.addPlayers,
    required this.nameOfNewOrganisation,
    required this.create,
    required this.newOrganisationErrorMessage,
    required this.newOrganisationSuccessMessage,
    required this.organisationSettings,
    required this.createNewOrganisation,
    required this.joinExistingOrganisation,
    required this.managePlayers,
    required this.changeOrganisation,
    required this.information,
    required this.organisationCode,
    required this.letOtherPlayersJoinYourOrganisation,
    required this.joinOrganisation,
    required this.scanQrCode,
    required this.success,
    required this.failure,
    required this.obsFailure,
    required this.cameraPermissionWasDenied,
    required this.unknownError,
    required this.youPressedTheBackButton,
    required this.joinOrganisationInfo,
    required this.joinOrganisationInfo2,
    required this.actions,
    required this.joinExistingOrganisationWithQrCode,
    required this.organisationCardInfo,
    required this.managePlayer,
    required this.admin,
    required this.deleteUser,
    required this.active,
    required this.inactive,
    required this.changeOrganisationAlertText,
    required this.deleteThisMatch,
    required this.deleteMatchAreYouSure,
    required this.createGroupPlayer,
    required this.groupPlayerInfoText,
    required this.groupPlayerCreateFailure,
    required this.groupPlayerCreateSuccess,
    required this.firstName,
    required this.lastName,
    required this.league,
    required this.createNewLeague,
    required this.createLeague,
    required this.leagueName,
    required this.standings,
    required this.fixtures,
    required this.notStarted,
    required this.welcomeTextBody,
    required this.welcomeTextButton,
    required this.welcomeTextHeadline,
    required this.noUsersExists,
    required this.noData,
    required this.noOrganisation,
    required this.pleaseCheckYourInbox,
    required this.passwordSuccessfullyChanged,
    required this.enterNewPassword,
    required this.newPassword,
    required this.pleaseEnterVerificationCode,
    required this.submitPasswordButtonText,
    required this.submitVerificationButtonText,
    required this.enterSlackWebhook,
    required this.slackWebhook,
    required this.save,
    required this.createTeam,
    required this.teamName,
    required this.errorCouldNotCreateTeam,
    required this.addTeam,
    required this.selectedPlayers,
    required this.startLeague,
    required this.totalTeamsInLeague,
    required this.partOfLeagueToStartIt,
    required this.startLeagueError,
    required this.enterDiscordWebhook,
    required this.discordWebhook,
    required this.discordWebhookError,
    required this.discordWebhookUpdated,
    required this.enterTeamsWebhook,
    required this.teamsWebhook,
    required this.teamsWebhookError,
    required this.teamsWebhookUpdated,
    required this.slackWebhookError,
    required this.slackWebhookUpdated,
  });

  factory HardcodedStrings.fromJson(Map<String, dynamic> item) =>
      _$HardcodedStringsFromJson(item);

  Map<String, dynamic> toJson() => _$HardcodedStringsToJson(this);
}
