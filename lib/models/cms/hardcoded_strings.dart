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
  // fixt below
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

  HardcodedStrings(
      {required this.matches,
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
      required this.leagueName});

  factory HardcodedStrings.fromJson(Map<String, dynamic> item) =>
      _$HardcodedStringsFromJson(item);

  Map<String, dynamic> toJson(item) => _$HardcodedStringsToJson(item);
}
