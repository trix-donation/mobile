part of 'get_organizations_cubit.dart';

@immutable
sealed class GetOrganizationsState {}

final class GetOrganizationsInitial extends GetOrganizationsState {}

final class GetOrganizationsLoading extends GetOrganizationsState {}

final class GetOrganizationsLoaded extends GetOrganizationsState {
  final List<OrganizationModel> organizations;

  GetOrganizationsLoaded(this.organizations);
}

final class GetOrganizationsError extends GetOrganizationsState {
  final String message;

  GetOrganizationsError(this.message);
}
