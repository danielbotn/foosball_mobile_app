import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'new_game_state.g.dart';

// This is the class used by rest of your codebase
class NewGameState = _NewGameState with _$NewGameState;

// The store-class
abstract class _NewGameState with Store {
  // true equals 2 players, false equals 4 players
  @observable
  bool twoOrFourPlayers = true;

  @observable
  ObservableList<UserResponse> playersTeamOne = ObservableList<UserResponse>();

  @observable
  ObservableList<UserResponse> playersTeamTwo = ObservableList<UserResponse>();

  @observable
  ObservableList<bool> checkedPlayers = ObservableList<bool>();

  @action
  void setTwoOrFourPlayers(bool value) {
    twoOrFourPlayers = value;
  }

  @action
  void addPlayerToTeamOne(UserResponse user) {
    playersTeamOne.add(user);
  }

  @action
  void addPlayerToTeamTwo(UserResponse user) {
    playersTeamTwo.add(user);
  }

  @action
  void removePlayerFromTeamOne(UserResponse user) {
    playersTeamOne.remove(user);
  }

  @action
  void removePlayerFromTeamTwo(UserResponse user) {
    playersTeamTwo.remove(user);
  }

  @action
  void clearState() {
    playersTeamOne.clear();
    playersTeamTwo.clear();
  }

  @action
  void setAllCheckedPlayers(List<bool> checkedPlayers) {
    this.checkedPlayers.clear();
    this.checkedPlayers.addAll(checkedPlayers);
  }

  @action
  void setCheckedPlayer(int index, bool value) {
    this.checkedPlayers[index] = value;
  }

  // initalize checkedPlayers
  @action
  void initializeCheckedPlayers(int length) {
    checkedPlayers.clear();
    for (int i = 0; i < length; i++) {
      checkedPlayers.add(false);
    }
  }

  // clear checkedPlayers
  @action
  void setAllCheckedPlayersToFalse(int length) {
     for (int i = 0; i < length; i++) {
      checkedPlayers[i] = false;
    }
  }

}
