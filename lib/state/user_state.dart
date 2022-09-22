import 'package:foosball_mobile_app/models/cms/hardcoded_strings.dart';
import 'package:foosball_mobile_app/models/user/user_info_global.dart';
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
      currentOrganisation: "");

  @observable
  bool darkmode = false;

  @action
  void setUserInfoGlobalObject(
      int userId,
      String firstName,
      String lastName,
      String email,
      int currrentOrganisationId,
      String currentOrganisationName) {
    UserInfoGlobal tmp = UserInfoGlobal(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        currentOrganisationId: currentOrganisationId,
        currentOrganisationName: currentOrganisationName);

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
