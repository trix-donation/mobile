part of 'users_organizations_cubit.dart';

@immutable
sealed class UsersOrganizationsState {}

final class UsersOrganizationsInitial extends UsersOrganizationsState {}

final class UsersOrganizationsLoading extends UsersOrganizationsState {}

final class UsersOrganizationsLoaded extends UsersOrganizationsState {
  final UsersOrganizationsModel usersOrganizations;

  UsersOrganizationsLoaded(this.usersOrganizations);
}

final class UsersOrganizationsError extends UsersOrganizationsState {
  final String message;

  UsersOrganizationsError(this.message);
}
