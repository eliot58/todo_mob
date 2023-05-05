// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'works_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorksState on WorksStateBase, Store {
  late final _$worksAtom = Atom(name: 'WorksStateBase.works', context: context);

  @override
  List<dynamic> get works {
    _$worksAtom.reportRead();
    return super.works;
  }

  @override
  set works(List<dynamic> value) {
    _$worksAtom.reportWrite(value, super.works, () {
      super.works = value;
    });
  }

  late final _$quantitiesAtom =
      Atom(name: 'WorksStateBase.quantities', context: context);

  @override
  List<dynamic> get quantities {
    _$quantitiesAtom.reportRead();
    return super.quantities;
  }

  @override
  set quantities(List<dynamic> value) {
    _$quantitiesAtom.reportWrite(value, super.quantities, () {
      super.quantities = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'WorksStateBase.isLoading', context: context);

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

  late final _$getWorksAsyncAction =
      AsyncAction('WorksStateBase.getWorks', context: context);

  @override
  Future<void> getWorks() {
    return _$getWorksAsyncAction.run(() => super.getWorks());
  }

  late final _$getWorksAndQuantitiesAsyncAction =
      AsyncAction('WorksStateBase.getWorksAndQuantities', context: context);

  @override
  Future<void> getWorksAndQuantities() {
    return _$getWorksAndQuantitiesAsyncAction
        .run(() => super.getWorksAndQuantities());
  }

  @override
  String toString() {
    return '''
works: ${works},
quantities: ${quantities},
isLoading: ${isLoading}
    ''';
  }
}
