import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/features/spilnota/presentation/cubit/users_organizations_cubit.dart';

import '../../data/models/zboryModel.dart';

part 'inactive_zbory_state.dart';

class InactiveZboryCubit extends Cubit<InactiveZboryState> {
  InactiveZboryCubit() : super(InactiveZboryInitial());

  Dio dio = GetIt.I();

  String _endpoint = 'http://3.71.89.121/money_collections/api/organizations';

  String _endOfEndpoint = 'collections/?active=f';

  void getInactveZbory() async {
    emit(InactiveZboryLoading());

    UsersOrganizationsCubit usersOrganizationsCubit = UsersOrganizationsCubit();
    int? organizationId = await usersOrganizationsCubit.getOganizationId();

    if (organizationId == null) {
      emit(InactiveZboryError('Помилка'));
      return;
    }

    try {
      final response = await dio.get("$_endpoint/$organizationId/$_endOfEndpoint");
      if (response.statusCode == 200) {
        final zboryModel = ZboryModel.fromJson(response.data);
        emit(InactiveZboryLoaded(zboryModel));
        return;
      }
    } on DioException catch (e) {
      emit(InactiveZboryError(e.response?.data['message'] ?? 'Помилка'));
    }
  }

  void getInactveZboryByOrganizationId(int organizationId) async {
    emit(InactiveZboryLoading());

    try {
      final response = await dio.get("$_endpoint/$organizationId/$_endOfEndpoint");
      if (response.statusCode == 200) {
        final zboryModel = ZboryModel.fromJson(response.data);
        emit(InactiveZboryLoaded(zboryModel));
        return;
      }
    } on DioException catch (e) {
      emit(InactiveZboryError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
