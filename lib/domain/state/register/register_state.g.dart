// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterState on RegisterStateBase, Store {
  late final _$registerDataAtom =
      Atom(name: 'RegisterStateBase.registerData', context: context);

  @override
  bool? get registerData {
    _$registerDataAtom.reportRead();
    return super.registerData;
  }

  @override
  set registerData(bool? value) {
    _$registerDataAtom.reportWrite(value, super.registerData, () {
      super.registerData = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'RegisterStateBase.isLoading', context: context);

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

  late final _$uservalidatorAtom =
      Atom(name: 'RegisterStateBase.uservalidator', context: context);

  @override
  String? get uservalidator {
    _$uservalidatorAtom.reportRead();
    return super.uservalidator;
  }

  @override
  set uservalidator(String? value) {
    _$uservalidatorAtom.reportWrite(value, super.uservalidator, () {
      super.uservalidator = value;
    });
  }

  late final _$phonevalidatorAtom =
      Atom(name: 'RegisterStateBase.phonevalidator', context: context);

  @override
  String? get phonevalidator {
    _$phonevalidatorAtom.reportRead();
    return super.phonevalidator;
  }

  @override
  set phonevalidator(String? value) {
    _$phonevalidatorAtom.reportWrite(value, super.phonevalidator, () {
      super.phonevalidator = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('RegisterStateBase.register', context: context);

  @override
  Future<void> register(
      {required String email,
      required String phone,
      required String spec,
      required String fullName}) {
    return _$registerAsyncAction.run(() => super
        .register(email: email, phone: phone, spec: spec, fullName: fullName));
  }

  @override
  String toString() {
    return '''
registerData: ${registerData},
isLoading: ${isLoading},
uservalidator: ${uservalidator},
phonevalidator: ${phonevalidator}
    ''';
  }
}
