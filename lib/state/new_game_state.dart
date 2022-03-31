import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:mobx/mobx.dart';
import 'package:tuple/tuple.dart';

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
  ObservableList<Tuple2<int, bool>> checkedPlayers = ObservableList<Tuple2<int, bool>>();

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
    if (playersTeamOne.length > 0) {
      for (int i = 1; i < playersTeamOne.length; i++) {
        playersTeamOne.removeAt(i);
      }
    }
    if (playersTeamTwo.length > 0) {
      playersTeamTwo.clear();
    }
  }

  @action
  void setAllCheckedPlayers(List<Tuple2<int, bool>> checkedPlayersTuple) {
    this.checkedPlayers.clear();
    this.checkedPlayers.addAll(checkedPlayersTuple);
  }

  @action
  setCheckedPlayer(int index, bool value, int userId) {
    checkedPlayers[index] = Tuple2(userId, value);
  }

  @action
  void initializeCheckedPlayers(List<UserResponse> players) {
    checkedPlayers.clear();
    for (int i = 0; i < players.length; i++) {
      checkedPlayers.add(Tuple2(players[i].id, false));
    }
  }

  @action
  void setAllCheckedPlayersToFalse() {
    for (int i = 0; i < checkedPlayers.length; i++) {
      checkedPlayers[i] = Tuple2(checkedPlayers[i].item1, false);
    }
  }

  @action
  void setCheckedPlayerToFalseFromUser(UserResponse user) {
    for (int i = 0; i < checkedPlayers.length; i++) {
      if (checkedPlayers[i].item1 == user.id) {
        checkedPlayers[i] = Tuple2(checkedPlayers[i].item1, false);
      }
    }
  }

}
