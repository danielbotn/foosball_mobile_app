// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserState on _UserState, Store {
  final _$userIdAtom = Atom(name: '_UserState.userId');

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

  final _$currentOrganisationIdAtom =
      Atom(name: '_UserState.currentOrganisationId');

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

  final _$tokenAtom = Atom(name: '_UserState.token');

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

  final _$_UserStateActionController = ActionController(name: '_UserState');

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
  String toString() {
    return '''
userId: ${userId},
currentOrganisationId: ${currentOrganisationId},
token: ${token}
    ''';
  }
}
