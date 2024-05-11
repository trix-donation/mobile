part of 'registration_cubit.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {}

final class RegistrationFailure extends RegistrationState {
  final String message;

  RegistrationFailure(this.message);
}
