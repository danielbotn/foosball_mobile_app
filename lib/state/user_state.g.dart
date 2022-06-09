// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserState on _UserState, Store {
  late final _$userIdAtom = Atom(name: '_UserState.userId', context: context);

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$currentOrganisationIdAtom =
      Atom(name: '_UserState.currentOrganisationId', context: context);

  @override
  int get currentOrganisationId {
    _$currentOrganisationIdAtom.reportRead();
    return super.currentOrganisationId;
  }

  @override
  set currentOrganisationId(int value) {
    _$currentOrganisationIdAtom.reportWrite(value, super.currentOrganisationId,
        () {
      super.currentOrganisationId = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_UserState.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$languageAtom =
      Atom(name: '_UserState.language', context: context);

  @override
  String get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(String value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  late final _$userInfoGlobalAtom =
      Atom(name: '_UserState.userInfoGlobal', context: context);

  @override
  UserInfoGlobal get userInfoGlobal {
    _$userInfoGlobalAtom.reportRead();
    return super.userInfoGlobal;
  }

  @override
  set userInfoGlobal(UserInfoGlobal value) {
    _$userInfoGlobalAtom.reportWrite(value, super.userInfoGlobal, () {
      super.userInfoGlobal = value;
    });
  }

  late final _$hardcodedStringsAtom =
      Atom(name: '_UserState.hardcodedStrings', context: context);

  @override
  HardcodedStrings get hardcodedStrings {
    _$hardcodedStringsAtom.reportRead();
    return super.hardcodedStrings;
  }

  @override
  set hardcodedStrings(HardcodedStrings value) {
    _$hardcodedStringsAtom.reportWrite(value, super.hardcodedStrings, () {
      super.hardcodedStrings = value;
    });
  }

  late final _$darkmodeAtom =
      Atom(name: '_UserState.darkmode', context: context);

  @override
  bool get darkmode {
    _$darkmodeAtom.reportRead();
    return super.darkmode;
  }

  @override
  set darkmode(bool value) {
    _$darkmodeAtom.reportWrite(value, super.darkmode, () {
      super.darkmode = value;
    });
  }

  late final _$_UserStateActionController =
      ActionController(name: '_UserState', context: context);

  @override
  void setUserInfoGlobalObject(
      int userId,
      String firstName,
      String lastName,
      String email,
      int currrentOrganisationId,
      String currentOrganisationName) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setUserInfoGlobalObject');
    try {
      return super.setUserInfoGlobalObject(userId, firstName, lastName, email,
          currrentOrganisationId, currentOrganisationName);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserId(int pUserId) {
    final _$actionInfo =
        _$_UserStateActionController.startAction(name: '_UserState.setUserId');
    try {
      return super.setUserId(pUserId);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentOrganisationId(int pcurrentOrganisationId) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setCurrentOrganisationId');
    try {
      return super.setCurrentOrganisationId(pcurrentOrganisationId);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToken(String pToken) {
    final _$actionInfo =
        _$_UserStateActionController.startAction(name: '_UserState.setToken');
    try {
      return super.setToken(pToken);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHardcodedStrings(HardcodedStrings pHardcodedStrings) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setHardcodedStrings');
    try {
      return super.setHardcodedStrings(pHardcodedStrings);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDarkmode(bool pDarkmode) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setDarkmode');
    try {
      return super.setDarkmode(pDarkmode);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLanguage(String pLanguage) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setLanguage');
    try {
      return super.setLanguage(pLanguage);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userId: ${userId},
currentOrganisationId: ${currentOrganisationId},
token: ${token},
language: ${language},
userInfoGlobal: ${userInfoGlobal},
hardcodedStrings: ${hardcodedStrings},
darkmode: ${darkmode}
    ''';
  }
}
