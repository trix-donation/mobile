part of 'get_selected_collection_cubit.dart';

@immutable
sealed class GetSelectedCollectionState {}

final class GetSelectedCollectionInitial extends GetSelectedCollectionState {}

final class GetSelectedCollectionLoading extends GetSelectedCollectionState {}

final class GetSelectedCollectionLoaded extends GetSelectedCollectionState {
  final GetSelectedCollectionModel collection;

  GetSelectedCollectionLoaded(this.collection);
}

final class GetSelectedCollectionError extends GetSelectedCollectionState {
  final String message;

  GetSelectedCollectionError(this.message);
}
