import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/core/token_storage.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  AuthCheckCubit() : super(AuthCheckInitial());

  void checkTokens() async {
    emit(AuthCheckChecking());

    await GetIt.I<TokenStorage>().checkAccessToken();

    if (GetIt.I<TokenStorage>().isAuthorized) {
      emit(AuthCheckAuthorized());
    } else {
      emit(AuthCheckUnauthorized());
    }
  }
}
