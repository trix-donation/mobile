import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/core/storage/first_time_enter_storage.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  void checkOnBoarding() {
    if (FirstTimeEnterStorage.isFirstTimeEnter) {
      emit(OnBoardingNeeded());
    } else {
      emit(OnBoardingNotNeeded());
    }
  }
}
