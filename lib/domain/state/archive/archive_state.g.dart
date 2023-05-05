// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ArchiveState on ArchiveStateBase, Store {
  late final _$archivesAtom =
      Atom(name: 'ArchiveStateBase.archives', context: context);

  @override
  List<dynamic> get archives {
    _$archivesAtom.reportRead();
    return super.archives;
  }

  @override
  set archives(List<dynamic> value) {
    _$archivesAtom.reportWrite(value, super.archives, () {
      super.archives = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ArchiveStateBase.isLoading', context: context);

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

  late final _$getArchivesAsyncAction =
      AsyncAction('ArchiveStateBase.getArchives', context: context);

  @override
  Future<void> getArchives() {
    return _$getArchivesAsyncAction.run(() => super.getArchives());
  }

  late final _$sendReviewAsyncAction =
      AsyncAction('ArchiveStateBase.sendReview', context: context);

  @override
  Future<void> sendReview({required int id}) {
    return _$sendReviewAsyncAction.run(() => super.sendReview(id: id));
  }

  @override
  String toString() {
    return '''
archives: ${archives},
isLoading: ${isLoading}
    ''';
  }
}
