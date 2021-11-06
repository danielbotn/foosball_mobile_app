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
  UserInfoGlobal userInfoGlobal = new UserInfoGlobal(
      userId: 0,
      firstName: "",
      lastName: "",
      email: "",
      currentOrganisationId: 0);

  @action
  void setUserInfoGlobalObject(int userId, String firstName, String lastName,
      String email, int currrentOrganisationId) {
      UserInfoGlobal tmp = new UserInfoGlobal(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          email: email,
          currentOrganisationId: currentOrganisationId);
          
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
}
