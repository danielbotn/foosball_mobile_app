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