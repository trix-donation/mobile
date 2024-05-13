import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/models/users_organizations_model.dart';

part 'users_organizations_state.dart';

class UsersOrganizationsCubit extends Cubit<UsersOrganizationsState> {
  UsersOrganizationsCubit() : super(UsersOrganizationsInitial());

  Dio dio = GetIt.I();

  final String _endpoint = 'http://3.71.89.121/users/api/organizations/';

  UsersOrganizationsModel? usersOrganizationsModel;

  void initData() async {
    emit(UsersOrganizationsLoading());

    try {
      final response = await dio.get(_endpoint);
      if (response.statusCode == 200) {
        final usersOrganizationsModel = UsersOrganizationsModel.fromJson(response.data);
        this.usersOrganizationsModel = usersOrganizationsModel;
        emit(UsersOrganizationsLoaded(usersOrganizationsModel));
        return;
      }
    } on DioException catch (e) {
      emit(UsersOrganizationsError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
