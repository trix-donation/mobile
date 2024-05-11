part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordNeedVerifyEmail extends ForgotPasswordState {}

final class ForgotPasswordEmailVerified extends ForgotPasswordState {}

final class ForgotPasswordEmailVerifiedFailed extends ForgotPasswordState {
  final String message;

  ForgotPasswordEmailVerifiedFailed(this.message);
}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailure(this.message);
}
