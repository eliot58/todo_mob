// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginState on LoginStateBase, Store {
  late final _$loginDataAtom =
      Atom(name: 'LoginStateBase.loginData', context: context);

  @override
  dynamic get loginData {
    _$loginDataAtom.reportRead();
    return super.loginData;
  }

  @override
  set loginData(dynamic value) {
    _$loginDataAtom.reportWrite(value, super.loginData, () {
      super.loginData = value;
    });
  }

  late final _$rememberAtom =
      Atom(name: 'LoginStateBase.remember', context: context);

  @override
  bool get remember {
    _$rememberAtom.reportRead();
    return super.remember;
  }

  @override
  set remember(bool value) {
    _$rememberAtom.reportWrite(value, super.remember, () {
      super.remember = value;
    });
  }

  late final _$passwordObscureAtom =
      Atom(name: 'LoginStateBase.passwordObscure', context: context);

  @override
  bool get passwordObscure {
    _$passwordObscureAtom.reportRead();
    return super.passwordObscure;
  }

  @override
  set passwordObscure(bool value) {
    _$passwordObscureAtom.reportWrite(value, super.passwordObscure, () {
      super.passwordObscure = value;
    });
  }

  late final _$passwordvalidatorAtom =
      Atom(name: 'LoginStateBase.passwordvalidator', context: context);

  @override
  String? get passwordvalidator {
    _$passwordvalidatorAtom.reportRead();
    return super.passwordvalidator;
  }

  @override
  set passwordvalidator(String? value) {
    _$passwordvalidatorAtom.reportWrite(value, super.passwordvalidator, () {
      super.passwordvalidator = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'LoginStateBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginStateBase.login', context: context);

  @override
  Future<void> login({required String email, required String password}) {
    return _$loginAsyncAction
        .run(() => super.login(email: email, password: password));
  }

  late final _$LoginStateBaseActionController =
      ActionController(name: 'LoginStateBase', context: context);

  @override
  dynamic obscureChange() {
    final _$actionInfo = _$LoginStateBaseActionController.startAction(
        name: 'LoginStateBase.obscureChange');
    try {
      return super.obscureChange();
    } finally {
      _$LoginStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginData: ${loginData},
remember: ${remember},
passwordObscure: ${passwordObscure},
passwordvalidator: ${passwordvalidator},
isLoading: ${isLoading}
    ''';
  }
}
