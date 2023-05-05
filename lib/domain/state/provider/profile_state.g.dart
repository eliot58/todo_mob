// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on ProfileStateBase, Store {
  late final _$logopathAtom =
      Atom(name: 'ProfileStateBase.logopath', context: context);

  @override
  List<PlatformFile>? get logopath {
    _$logopathAtom.reportRead();
    return super.logopath;
  }

  @override
  set logopath(List<PlatformFile>? value) {
    _$logopathAtom.reportWrite(value, super.logopath, () {
      super.logopath = value;
    });
  }

  late final _$isPickedAtom =
      Atom(name: 'ProfileStateBase.isPicked', context: context);

  @override
  bool get isPicked {
    _$isPickedAtom.reportRead();
    return super.isPicked;
  }

  @override
  set isPicked(bool value) {
    _$isPickedAtom.reportWrite(value, super.isPicked, () {
      super.isPicked = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ProfileStateBase.isLoading', context: context);

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

  late final _$getProfileAsyncAction =
      AsyncAction('ProfileStateBase.getProfile', context: context);

  @override
  Future<void> getProfile() {
    return _$getProfileAsyncAction.run(() => super.getProfile());
  }

  late final _$pickImgAsyncAction =
      AsyncAction('ProfileStateBase.pickImg', context: context);

  @override
  Future pickImg() {
    return _$pickImgAsyncAction.run(() => super.pickImg());
  }

  @override
  String toString() {
    return '''
logopath: ${logopath},
isPicked: ${isPicked},
isLoading: ${isLoading}
    ''';
  }
}
