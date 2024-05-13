import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/models/PersonalProfileModel.dart';

part 'personal_profile_state.dart';

class PersonalProfileCubit extends Cubit<PersonalProfileState> {
  PersonalProfileCubit() : super(PersonalProfileInitial());

  Dio dio = GetIt.I();

  final String _endpoint = "http://3.71.89.121/users/api/profile/";

  Future<void> getPersonalProfile() async {
    emit(PersonalProfileLoading());
    try {
      final response = await dio.get(_endpoint);
      final personalProfile = PersonalProfileModel.fromJson(response.data);
      emit(PersonalProfileLoaded(personalProfile));
    } on DioException catch (e) {
      emit(PersonalProfileError(e.response?.data['message'] ?? e.message));
    }
  }

  final String _putEndpoint = "http://3.71.89.121/users/api/edit/";

  void updatePersonalProfile(
      {required String name,
      required String surname,
      required PersonalProfileModel personalProfileModel}) {
    dio.put(_putEndpoint, data: {"name": name, "surname": surname}).then((response) {
      emit(PersonalProfileUpdated(personalProfileModel));
    }).catchError((e) {
      emit(PersonalProfileError(e.response?.data['message'] ?? e.message));
    });
  }

  void updatePersonalProfileImage(
      {required File file, required PersonalProfileModel personalProfileModel}) async {
    final FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(file.path),
    });

    dio.put(_putEndpoint, data: formData).then((response) {
      emit(PersonalProfileUpdated(personalProfileModel));
    }).catchError((e) {
      emit(PersonalProfileError(e.response?.data['message'] ?? e.message));
    });
  }
}
