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

  Future<int?> getOganizationId() async {
    emit(UsersOrganizationsLoading());

    try {
      final response = await dio.get(_endpoint);
      if (response.statusCode == 200) {
        final organization_id = response.data[0]['organization_id'];
        // this.usersOrganizationsModel = usersOrganizationsModel;
        // emit(UsersOrganizationsLoaded(usersOrganizationsModel));
        return organization_id;
      }
    } on DioException catch (e) {
      emit(UsersOrganizationsError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
