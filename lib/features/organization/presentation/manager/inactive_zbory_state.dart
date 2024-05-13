part of 'inactive_zbory_cubit.dart';

@immutable
sealed class InactiveZboryState {}

final class InactiveZboryInitial extends InactiveZboryState {}

final class InactiveZboryLoading extends InactiveZboryState {}

final class InactiveZboryLoaded extends InactiveZboryState {
  final ZboryModel zboryModel;

  InactiveZboryLoaded(this.zboryModel);
}

final class InactiveZboryError extends InactiveZboryState {
  final String message;

  InactiveZboryError(this.message);
}
