// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersState on OrdersStateBase, Store {
  late final _$ordersAtom =
      Atom(name: 'OrdersStateBase.orders', context: context);

  @override
  List<dynamic> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(List<dynamic> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'OrdersStateBase.isLoading', context: context);

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

  late final _$getOrdersAsyncAction =
      AsyncAction('OrdersStateBase.getOrders', context: context);

  @override
  Future<void> getOrders() {
    return _$getOrdersAsyncAction.run(() => super.getOrders());
  }

  late final _$deleteOrderAsyncAction =
      AsyncAction('OrdersStateBase.deleteOrder', context: context);

  @override
  Future<void> deleteOrder(dynamic index) {
    return _$deleteOrderAsyncAction.run(() => super.deleteOrder(index));
  }

  late final _$searchInOrdersAsyncAction =
      AsyncAction('OrdersStateBase.searchInOrders', context: context);

  @override
  Future searchInOrders(dynamic value) {
    return _$searchInOrdersAsyncAction.run(() => super.searchInOrders(value));
  }

  late final _$OrdersStateBaseActionController =
      ActionController(name: 'OrdersStateBase', context: context);

  @override
  dynamic whereByPrice(dynamic startPrice, dynamic endPrice) {
    final _$actionInfo = _$OrdersStateBaseActionController.startAction(
        name: 'OrdersStateBase.whereByPrice');
    try {
      return super.whereByPrice(startPrice, endPrice);
    } finally {
      _$OrdersStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reverseOrders() {
    final _$actionInfo = _$OrdersStateBaseActionController.startAction(
        name: 'OrdersStateBase.reverseOrders');
    try {
      return super.reverseOrders();
    } finally {
      _$OrdersStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders},
isLoading: ${isLoading}
    ''';
  }
}
