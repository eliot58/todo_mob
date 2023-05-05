// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderState on OrderStateBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'OrderStateBase.isLoading', context: context);

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

  late final _$isBlankAtom =
      Atom(name: 'OrderStateBase.isBlank', context: context);

  @override
  bool get isBlank {
    _$isBlankAtom.reportRead();
    return super.isBlank;
  }

  @override
  set isBlank(bool value) {
    _$isBlankAtom.reportWrite(value, super.isBlank, () {
      super.isBlank = value;
    });
  }

  late final _$isBlankcheckAsyncAction =
      AsyncAction('OrderStateBase.isBlankcheck', context: context);

  @override
  Future<void> isBlankcheck() {
    return _$isBlankcheckAsyncAction.run(() => super.isBlankcheck());
  }

  late final _$getOrderAsyncAction =
      AsyncAction('OrderStateBase.getOrder', context: context);

  @override
  Future<void> getOrder({required int id}) {
    return _$getOrderAsyncAction.run(() => super.getOrder(id: id));
  }

  late final _$createOrderAsyncAction =
      AsyncAction('OrderStateBase.createOrder', context: context);

  @override
  Future<void> createOrder() {
    return _$createOrderAsyncAction.run(() => super.createOrder());
  }

  late final _$searchInQuantitiesAsyncAction =
      AsyncAction('OrderStateBase.searchInQuantities', context: context);

  @override
  Future searchInQuantities(dynamic value) {
    return _$searchInQuantitiesAsyncAction
        .run(() => super.searchInQuantities(value));
  }

  late final _$OrderStateBaseActionController =
      ActionController(name: 'OrderStateBase', context: context);

  @override
  dynamic whereByPrice(dynamic startPrice, dynamic endPrice) {
    final _$actionInfo = _$OrderStateBaseActionController.startAction(
        name: 'OrderStateBase.whereByPrice');
    try {
      return super.whereByPrice(startPrice, endPrice);
    } finally {
      _$OrderStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reverseQuantities() {
    final _$actionInfo = _$OrderStateBaseActionController.startAction(
        name: 'OrderStateBase.reverseQuantities');
    try {
      return super.reverseQuantities();
    } finally {
      _$OrderStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isBlank: ${isBlank}
    ''';
  }
}
