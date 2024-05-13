part of 'create_collection_cubit.dart';

@immutable
sealed class CreateCollectionState {}

final class CreateCollectionInitial extends CreateCollectionState {}

final class CreateCollectionLoading extends CreateCollectionState {}

final class CreateCollectionCreated extends CreateCollectionState {}

final class CreateCollectionError extends CreateCollectionState {
  final String message;

  CreateCollectionError(this.message);
}
