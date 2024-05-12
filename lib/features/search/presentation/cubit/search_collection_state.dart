part of 'search_collection_cubit.dart';

@immutable
sealed class SearchCollectionState {}

final class SearchCollectionInitial extends SearchCollectionState {}

final class SearchCollectionLoading extends SearchCollectionState {}

final class SearchCollectionLoadedSuccessful extends SearchCollectionState {
  final FoundedCollectionsModel foundedCollectionsModel;

  SearchCollectionLoadedSuccessful(this.foundedCollectionsModel);
}

final class SearchCollectionLoadedNothingFound extends SearchCollectionState {}

final class SearchCollectionError extends SearchCollectionState {
  final String message;

  SearchCollectionError(this.message);
}
