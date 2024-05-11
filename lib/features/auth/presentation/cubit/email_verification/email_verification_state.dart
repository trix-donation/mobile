part of 'email_verification_cubit.dart';

@immutable
sealed class EmailVerificationState {}

final class EmailVerificationInitial extends EmailVerificationState {}

final class EmailVerificationLoading extends EmailVerificationState {}

final class EmailVerificationSended extends EmailVerificationState {
  final String message;

  EmailVerificationSended(this.message);
}

final class EmailVerificationError extends EmailVerificationState {
  final String message;

  EmailVerificationError(this.message);
}

final class EmailVerificationCodeVerified extends EmailVerificationState {
  final String message;

  EmailVerificationCodeVerified(this.message);
}

final class EmailVerificationCodeError extends EmailVerificationState {
  final String message;

  EmailVerificationCodeError(this.message);
}
