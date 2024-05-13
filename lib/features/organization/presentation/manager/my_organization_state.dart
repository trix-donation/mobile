part of 'my_organization_cubit.dart';

@immutable
sealed class MyOrganizationState {}

final class MyOrganizationInitial extends MyOrganizationState {}

final class MyOrganizationLoading extends MyOrganizationState {}

final class MyOrganizationLoaded extends MyOrganizationState {
  final MyOrganizationModel myOrganizationModel;

  MyOrganizationLoaded(this.myOrganizationModel);
}

final class MyOrganizationError extends MyOrganizationState {
  final String message;

  MyOrganizationError(this.message);
}

final class MyOrganizationNotCreated extends MyOrganizationState {}

final class MyOrganizationRequestCreateSend extends MyOrganizationState {
  final String message;

  MyOrganizationRequestCreateSend(this.message);
}
