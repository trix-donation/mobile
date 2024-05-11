import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial()) {
    emit(ForgotPasswordNeedVerifyEmail());
  }

  final Dio _dio = GetIt.I<Dio>();

  static const String _forgotPasswordEndpoint = 'http://3.71.89.121/users/api/password_reset/';

  void forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await _dio.post(_forgotPasswordEndpoint, data: {'email': email});
      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccess());
      }
    } on DioException catch (e) {
      emit(ForgotPasswordFailure(e.response?.data['message']));
    }
  }

  static const _changePasswordEndpoint = 'http://3.71.89.121/users/api/password_set/';

  void changeForgotPassword(String email, String password) async {
    emit(ForgotPasswordLoading());
    try {
      final response =
          await _dio.post(_changePasswordEndpoint, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccess());
      }
    } on DioException catch (e) {
      emit(ForgotPasswordFailure(e.response?.data['message']));
    }
  }

  static const String emailVerificationCodeUrl = "http://3.71.89.121/users/api/code_validate/";

  void verifyEmail(String email, String code) async {
    emit(ForgotPasswordLoading());

    await Future.delayed(const Duration(seconds: 1));

    final response = await _dio
        .post(emailVerificationCodeUrl, data: {'email': email, 'code': code}).then((response) {
      if (response.statusCode != 200) {
        emit(ForgotPasswordEmailVerifiedFailed(
            "Не вдалось підтвердити email. Спробуйте повторити запит."));
      }

      if (response.statusCode == 200) {
        if (response.data['valid']) {
          emit(ForgotPasswordEmailVerified());
        } else {
          emit(ForgotPasswordEmailVerifiedFailed(
              "Не вдалось підтвердити email. Спробуйте пізніше."));
        }
      }
    }).catchError((e) {
      emit(ForgotPasswordEmailVerifiedFailed(
          "Не вдалось підтвердити email. Спробуйте повторити запит."));
    });
  }
}
