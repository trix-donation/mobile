import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit() : super(EmailVerificationInitial());

  Dio dio = GetIt.I<Dio>();

  static const String emailVerificationUrl = 'http://3.71.89.121/users/api/email_verify/';

  void sendEmail(String email) async {
    emit(EmailVerificationLoading());

    try {
      final response = await dio.post(emailVerificationUrl, data: {'email': email});

      if (response.statusCode != 200) {
        emit(EmailVerificationError("Не вдалось відправити листа. Спробуйте пізніше."));
      }

      if (response.statusCode == 200) {
        emit(EmailVerificationSended('Лист відправлено успішно'));
      }
    } on DioException catch (e) {
      emit(EmailVerificationError("Не вдалось відправити листа. Спробуйте пізніше."));
    }
  }

  static const String emailVerificationCodeUrl = "http://3.71.89.121/users/api/code_validate/";

  void verificate(String email, String code) async {
    emit(EmailVerificationLoading());

    await Future.delayed(const Duration(seconds: 1));

    final response = await dio
        .post(emailVerificationCodeUrl, data: {'email': email, 'code': code}).then((response) {
      if (response.statusCode != 200) {
        emit(EmailVerificationCodeError("Не вдалось підтвердити email. Спробуйте пізніше."));
      }

      if (response.statusCode == 200) {
        if (response.data['valid']) {
          emit(EmailVerificationCodeVerified('Email підтверджено успішно'));
        } else {
          emit(EmailVerificationCodeError("Не вдалось підтвердити email. Спробуйте пізніше."));
        }
      }
    }).catchError((e) {
      emit(EmailVerificationCodeError("Не вдалось підтвердити email. Спробуйте пізніше."));
    });
  }
}
