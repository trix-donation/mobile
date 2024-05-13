part of 'active_zbory_cubit.dart';

@immutable
sealed class ActiveZboryState {}

final class ActiveZboryInitial extends ActiveZboryState {}

final class ActiveZboryLoading extends ActiveZboryState {}

final class ActiveZboryLoaded extends ActiveZboryState {
  final ZboryModel zboryModel;

  ActiveZboryLoaded(this.zboryModel);
}

final class ActiveZboryError extends ActiveZboryState {
  final String message;

  ActiveZboryError(this.message);
}
