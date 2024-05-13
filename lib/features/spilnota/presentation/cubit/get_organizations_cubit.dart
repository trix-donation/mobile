import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/features/spilnota/data/models/organization_model.dart';

part 'get_organizations_state.dart';

class GetOrganizationsCubit extends Cubit<GetOrganizationsState> {
  GetOrganizationsCubit() : super(GetOrganizationsInitial());

  Dio dio = GetIt.I();

  String _endpoint = "http://3.71.89.121/organizations/api/organizations";

  void getOrganizations() async {
    emit(GetOrganizationsLoading());
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await dio.get(_endpoint);
      List<OrganizationModel> organizations =
          (response.data as List).map((e) => OrganizationModel.fromJson(e)).toList();
      emit(GetOrganizationsLoaded(organizations));
    } on DioException catch (e) {
      emit(GetOrganizationsError(
          e.response?.data['message'] ?? 'Помилка спробуйте пізніше ще раз.'));
    }
  }
}
