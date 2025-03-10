import 'package:dano_foosball/models/cms/hardcoded_strings.dart';
import 'package:dano_foosball/models/user/user_info_global.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'user_state.g.dart';

// This is the class used by rest of your codebase
class UserState = _UserState with _$UserState;

// The store-class
abstract class _UserState with Store {
  @observable
  int userId = 0;

  @observable
  int currentOrganisationId = 0;

  @observable
  String token = "";

  @observable
  String language = "";

  @observable
  UserInfoGlobal userInfoGlobal = UserInfoGlobal(
    userId: 0,
    firstName: "",
    lastName: "",
    email: "",
    currentOrganisationId: 0,
    currentOrganisationName: "",
  );

  @observable
  HardcodedStrings hardcodedStrings = HardcodedStrings(
      matches: "",
      newGame: "",
      quickActions: "",
      lastTenMatches: "",
      statistics: "",
      history: "",
      leagues: "",
      pricing: "",
      settings: "",
      about: "",
      logout: "",
      language: "",
      darkTheme: "",
      lightTheme: "",
      changePassword: "",
      enableNotifications: "",
      common: "",
      security: "",
      won: "",
      lost: "",
      scored: "",
      recieved: "",
      goals: "",
      user: "",
      username: "",
      organisation: "",
      personalInformation: "",
      integration: "",
      slack: "",
      discord: "",
      matchDetails: "",
      totalPlayingTime: "",
      newMatch: "",
      rematch: "",
      twoPlayers: "",
      fourPlayers: "",
      choosePlayers: "",
      match: "",
      startGame: "",
      chooseTeammate: "",
      chooseOpponent: "",
      chooseOpponents: "",
      matchReport: "",
      game: "",
      resume: "",
      pause: "",
      close: "",
      yes: "",
      no: "",
      cancel: "",
      areYouSureAlert: "",
      currentOrganisation: "",
      organisations: "",
      players: "",
      newOrganisation: "",
      addPlayers: "",
      nameOfNewOrganisation: "",
      create: "",
      newOrganisationErrorMessage: "",
      newOrganisationSuccessMessage: "",
      joinExistingOrganisation: "",
      managePlayers: "",
      changeOrganisation: "",
      information: "",
      organisationCode: "",
      letOtherPlayersJoinYourOrganisation: "",
      joinOrganisation: "",
      scanQrCode: "",
      success: "",
      failure: "",
      obsFailure: "",
      cameraPermissionWasDenied: "",
      unknownError: "",
      youPressedTheBackButton: "",
      joinOrganisationInfo: "",
      joinOrganisationInfo2: "",
      actions: "",
      joinExistingOrganisationWithQrCode: "",
      organisationCardInfo: "",
      createNewOrganisation: "",
      organisationSettings: "",
      managePlayer: "",
      admin: "",
      deleteUser: "",
      active: "",
      inactive: "",
      changeOrganisationAlertText: "",
      deleteThisMatch: "",
      deleteMatchAreYouSure: "",
      createGroupPlayer: "",
      groupPlayerInfoText: "",
      groupPlayerCreateFailure: "",
      groupPlayerCreateSuccess: "",
      firstName: "",
      lastName: "",
      league: "",
      createNewLeague: "",
      createLeague: "",
      leagueName: "",
      standings: "",
      fixtures: "",
      notStarted: "",
      welcomeTextBody: "",
      welcomeTextButton: "",
      welcomeTextHeadline: "",
      noUsersExists: "",
      noData: "",
      noOrganisation: "",
      pleaseCheckYourInbox: "",
      passwordSuccessfullyChanged: "",
      enterNewPassword: "",
      newPassword: "",
      pleaseEnterVerificationCode: "",
      submitPasswordButtonText: "",
      submitVerificationButtonText: "",
      enterSlackWebhook: "",
      slackWebhook: "",
      save: "",
      createTeam: "",
      addTeam: "",
      errorCouldNotCreateTeam: "",
      teamName: "",
      selectedPlayers: "",
      startLeague: "",
      totalTeamsInLeague: "",
      partOfLeagueToStartIt: "",
      startLeagueError: "",
      // New properties
      enterDiscordWebhook: "",
      discordWebhook: "",
      discordWebhookError: "",
      discordWebhookUpdated: "",
      enterTeamsWebhook: "",
      teamsWebhook: "",
      teamsWebhookError: "",
      teamsWebhookUpdated: "",
      slackWebhookError: "",
      slackWebhookUpdated: "",
      finished: "",
      ongoing: "",
      doubleLeague: "",
      singleLeague: "",
      delete: "",
      edit: "",
      deleteLeague: "",
      deleteLeagueAreYouSure: "",
      allFixtures: "",
      myFixtures: "",
      matchPaused: "",
      pleaseFillOutAllFields: "",
      successfullyUpdatedUserInformation: "",
      changeUserInfo: "",
      enterFirstName: "",
      enterLastName: "",
      couldNotUpdateUserInformation: "");

  @observable
  bool darkmode = false;

  @action
  void setUserInfoGlobalObject(
      int userId,
      String firstName,
      String lastName,
      String email,
      int currentOrganisationId,
      String currentOrganisationName,
      String? photoUrl) {
    UserInfoGlobal tmp = UserInfoGlobal(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      currentOrganisationId: currentOrganisationId,
      currentOrganisationName: currentOrganisationName,
      photoUrl: photoUrl, // Pass photoUrl (can be null)
    );

    userInfoGlobal = tmp;
  }

  @action
  void setUserId(int pUserId) {
    userId = pUserId;
  }

  @action
  void setCurrentOrganisationId(int pcurrentOrganisationId) {
    currentOrganisationId = pcurrentOrganisationId;
  }

  @action
  void setToken(String pToken) {
    token = pToken;
  }

  @action
  void setHardcodedStrings(HardcodedStrings pHardcodedStrings) {
    hardcodedStrings = pHardcodedStrings;
  }

  @action
  void setDarkmode(bool pDarkmode) {
    darkmode = pDarkmode;
  }

  @action
  void setLanguage(String pLanguage) {
    language = pLanguage;
  }
}
