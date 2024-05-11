import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  Dio dio = GetIt.I<Dio>();

  static const String _registerURL = 'http://3.71.89.121/users/api/create/';

  void register(String email, String password) async {
    emit(RegistrationLoading());

    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await dio.post(_registerURL, data: {'email': email, 'password': password});

      if (response.statusCode != 201) {
        emit(RegistrationFailure('Реєстрація не вдалась. Можливо вже є користувач з таким email.'));
        return;
      }

      if (response.statusCode == 201) {
        emit(RegistrationSuccess());
      }
    } on DioException catch (e) {
      emit(RegistrationFailure(
          "Користувач з таким email вже існує або щось пішло не так. Спробуйте ще раз."));
    }
  }
}
