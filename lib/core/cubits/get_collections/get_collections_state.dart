part of 'get_collections_cubit.dart';

@immutable
sealed class GetCollectionsState {}

final class GetCollectionsInitial extends GetCollectionsState {}

final class GetCollectionsLoading extends GetCollectionsState {}

final class GetCollectionsLoadedSuccessful extends GetCollectionsState {
  final GetCollectionsModel getCollectionModel;

  GetCollectionsLoadedSuccessful(this.getCollectionModel);
}

final class GetCollectionsError extends GetCollectionsState {
  final String error;

  GetCollectionsError(this.error);
}
