part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingNeeded extends OnBoardingState {}

final class OnBoardingNotNeeded extends OnBoardingState {}
