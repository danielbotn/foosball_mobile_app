// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_game_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewGameState on _NewGameState, Store {
  late final _$twoOrFourPlayersAtom =
      Atom(name: '_NewGameState.twoOrFourPlayers', context: context);

  @override
  bool get twoOrFourPlayers {
    _$twoOrFourPlayersAtom.reportRead();
    return super.twoOrFourPlayers;
  }

  @override
  set twoOrFourPlayers(bool value) {
    _$twoOrFourPlayersAtom.reportWrite(value, super.twoOrFourPlayers, () {
      super.twoOrFourPlayers = value;
    });
  }

  late final _$playersTeamOneAtom =
      Atom(name: '_NewGameState.playersTeamOne', context: context);

  @override
  ObservableList<UserResponse> get playersTeamOne {
    _$playersTeamOneAtom.reportRead();
    return super.playersTeamOne;
  }

  @override
  set playersTeamOne(ObservableList<UserResponse> value) {
    _$playersTeamOneAtom.reportWrite(value, super.playersTeamOne, () {
      super.playersTeamOne = value;
    });
  }

  late final _$playersTeamTwoAtom =
      Atom(name: '_NewGameState.playersTeamTwo', context: context);

  @override
  ObservableList<UserResponse> get playersTeamTwo {
    _$playersTeamTwoAtom.reportRead();
    return super.playersTeamTwo;
  }

  @override
  set playersTeamTwo(ObservableList<UserResponse> value) {
    _$playersTeamTwoAtom.reportWrite(value, super.playersTeamTwo, () {
      super.playersTeamTwo = value;
    });
  }

  late final _$checkedPlayersAtom =
      Atom(name: '_NewGameState.checkedPlayers', context: context);

  @override
  ObservableList<Tuple2<int, bool>> get checkedPlayers {
    _$checkedPlayersAtom.reportRead();
    return super.checkedPlayers;
  }

  @override
  set checkedPlayers(ObservableList<Tuple2<int, bool>> value) {
    _$checkedPlayersAtom.reportWrite(value, super.checkedPlayers, () {
      super.checkedPlayers = value;
    });
  }

  late final _$_NewGameStateActionController =
      ActionController(name: '_NewGameState', context: context);

  @override
  void setTwoOrFourPlayers(bool value) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.setTwoOrFourPlayers');
    try {
      return super.setTwoOrFourPlayers(value);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPlayerToTeamOne(UserResponse user) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.addPlayerToTeamOne');
    try {
      return super.addPlayerToTeamOne(user);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPlayerToTeamTwo(UserResponse user) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.addPlayerToTeamTwo');
    try {
      return super.addPlayerToTeamTwo(user);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePlayerFromTeamOne(UserResponse user) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.removePlayerFromTeamOne');
    try {
      return super.removePlayerFromTeamOne(user);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePlayerFromTeamTwo(UserResponse user) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.removePlayerFromTeamTwo');
    try {
      return super.removePlayerFromTeamTwo(user);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearState(int userId) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.clearState');
    try {
      return super.clearState(userId);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllCheckedPlayers(List<Tuple2<int, bool>> checkedPlayersTuple) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.setAllCheckedPlayers');
    try {
      return super.setAllCheckedPlayers(checkedPlayersTuple);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCheckedPlayer(int index, bool value, int userId) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.setCheckedPlayer');
    try {
      return super.setCheckedPlayer(index, value, userId);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeCheckedPlayers(List<UserResponse> players) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.initializeCheckedPlayers');
    try {
      return super.initializeCheckedPlayers(players);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllCheckedPlayersToFalse(int userId) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.setAllCheckedPlayersToFalse');
    try {
      return super.setAllCheckedPlayersToFalse(userId);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckedPlayerToFalseFromUser(UserResponse user) {
    final _$actionInfo = _$_NewGameStateActionController.startAction(
        name: '_NewGameState.setCheckedPlayerToFalseFromUser');
    try {
      return super.setCheckedPlayerToFalseFromUser(user);
    } finally {
      _$_NewGameStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
twoOrFourPlayers: ${twoOrFourPlayers},
playersTeamOne: ${playersTeamOne},
playersTeamTwo: ${playersTeamTwo},
checkedPlayers: ${checkedPlayers}
    ''';
  }
}
