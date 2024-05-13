import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/models/zboryModel.dart';

part 'active_zbory_state.dart';

class ActiveZboryCubit extends Cubit<ActiveZboryState> {
  ActiveZboryCubit() : super(ActiveZboryInitial());

  Dio dio = GetIt.I();

  String _endpoint =
      'http://3.71.89.121/money_collections/api/organizations/16/collections/?active=t';

  void getActveZbory() async {
    emit(ActiveZboryLoading());

    try {
      final response = await dio.get(_endpoint);
      if (response.statusCode == 200) {
        final zboryModel = ZboryModel.fromJson(response.data);
        emit(ActiveZboryLoaded(zboryModel));
        return;
      }
    } on DioException catch (e) {
      emit(ActiveZboryError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
