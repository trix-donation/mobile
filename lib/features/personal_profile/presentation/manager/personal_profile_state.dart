part of 'personal_profile_cubit.dart';

@immutable
sealed class PersonalProfileState {}

final class PersonalProfileInitial extends PersonalProfileState {}

final class PersonalProfileLoading extends PersonalProfileState {}

final class PersonalProfileLoaded extends PersonalProfileState {
  final PersonalProfileModel personalProfileModel;

  PersonalProfileLoaded(this.personalProfileModel);
}

final class PersonalProfileUpdated extends PersonalProfileState {
  final PersonalProfileModel personalProfileModel;

  PersonalProfileUpdated(this.personalProfileModel);
}

final class PersonalProfileError extends PersonalProfileState {
  final String message;

  PersonalProfileError(this.message);
}
