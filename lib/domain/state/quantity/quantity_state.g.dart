// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantity_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuantityState on QuantityStateBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'QuantityStateBase.isLoading', context: context);

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

  late final _$getOrderAsyncAction =
      AsyncAction('QuantityStateBase.getOrder', context: context);

  @override
  Future<void> getOrder({required int id}) {
    return _$getOrderAsyncAction.run(() => super.getOrder(id: id));
  }

  late final _$createQuantityAsyncAction =
      AsyncAction('QuantityStateBase.createQuantity', context: context);

  @override
  Future<void> createQuantity() {
    return _$createQuantityAsyncAction.run(() => super.createQuantity());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}