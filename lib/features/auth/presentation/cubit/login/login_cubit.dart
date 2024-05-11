import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/core/storage/token_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Dio dio = GetIt.I<Dio>();

  static const String loginEndpoint = 'http://3.71.89.121/users/api/login/';

  void login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final response = await dio.post(loginEndpoint, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        GetIt.I<TokenStorage>().setAccessToken(accessToken);
        GetIt.I<TokenStorage>().setRefreshToken(refreshToken);

        Future.delayed(const Duration(seconds: 1), () {
          emit(LoginSuccess());
        });
        return;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(LoginFailure(e.response?.data['detail']));
      }

      if (e.response?.statusCode == 409) {
        emit(LoginNeedActivateEmail(email, e.response?.data['detail']));
      }
    }
  }
}
