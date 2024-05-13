import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/models/MyOrganizationModel.dart';

part 'my_organization_state.dart';

class MyOrganizationCubit extends Cubit<MyOrganizationState> {
  MyOrganizationCubit() : super(MyOrganizationInitial());

  Dio dio = GetIt.I();

  String _endpoint = 'http://3.71.89.121/organizations/api/organizations/edit/';
  String _createOrganisationEndpoint = 'http://3.71.89.121/organizations/api/request/create/';

  void initData() async {
    emit(MyOrganizationLoading());

    try {
      final response = await dio.get(_endpoint);
      if (response.statusCode == 200) {
        final myOrganizationModel = MyOrganizationModel.fromJson(response.data);

        if (myOrganizationModel.name == "") {
          emit(MyOrganizationNotCreated());
          return;
        }

        emit(MyOrganizationLoaded(myOrganizationModel));
        return;
      }
    } on DioException catch (e) {
      emit(MyOrganizationError(e.response?.data['message'] ?? 'Помилка'));
    }
  }

  void createOrganization(
      {required String name,
      required String user_details,
      String? instagram_url,
      String? twitter_url,
      String? facebook_url,
      String? custom_url,
      File? image,
      bool? foundation,
      int? EGRPOU_code}) async {
    final formData = FormData.fromMap({
      'name': name,
      'user_details': user_details,
    });

    if (instagram_url != null) {
      formData.fields.add(MapEntry('instagram_url', instagram_url));
    }
    if (twitter_url != null) {
      formData.fields.add(MapEntry('twitter_url', twitter_url));
    }
    if (facebook_url != null) {
      formData.fields.add(MapEntry('facebook_url', facebook_url));
    }
    if (custom_url != null) {
      formData.fields.add(MapEntry('custom_url', custom_url));
    }
    if (image != null) {
      formData.files.add(MapEntry('image', await MultipartFile.fromFile(image.path)));
    }
    if (foundation != null) {
      formData.fields.add(MapEntry('foundation', foundation.toString()));
    }
    if (EGRPOU_code != null) {
      formData.fields.add(MapEntry('EGRPOU_code', EGRPOU_code.toString()));
    }

    emit(MyOrganizationLoading());

    try {
      final response = await dio.post(_createOrganisationEndpoint, data: formData);
      if (response.statusCode == 200) {
        final myOrganizationModel = MyOrganizationModel.fromJson(response.data);
        emit(MyOrganizationLoaded(myOrganizationModel));
        return;
      }

      if (response.statusCode == 201) {
        emit(MyOrganizationRequestCreateSend(response.data['detail']));
        return;
      }
    } on DioException catch (e) {
      emit(MyOrganizationError(e.response?.data['message'] ?? 'Помилка'));
    }
  }

  String _someOrganizationEndpoint = 'http://3.71.89.121/organizations/api/organizations';

  void getSomeOrganization(int id) async {
    emit(MyOrganizationLoading());

    try {
      final response = await dio.get('$_someOrganizationEndpoint/$id/');
      if (response.statusCode == 200) {
        final myOrganizationModel = MyOrganizationModel.fromJson(response.data);
        emit(MyOrganizationLoaded(myOrganizationModel));
        return;
      }
    } on DioException catch (e) {
      emit(MyOrganizationError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
