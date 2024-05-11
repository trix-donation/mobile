part of 'auth_check_cubit.dart';

@immutable
sealed class AuthCheckState {}

final class AuthCheckInitial extends AuthCheckState {}

final class AuthCheckChecking extends AuthCheckState {}

final class AuthCheckAuthorized extends AuthCheckState {}

final class AuthCheckUnauthorized extends AuthCheckState {}
