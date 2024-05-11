import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import 'GetCollectionsModel.dart';

part 'get_collections_state.dart';

class GetCollectionsCubit extends Cubit<GetCollectionsState> {
  GetCollectionsCubit() : super(GetCollectionsInitial());

  Dio dio = GetIt.I<Dio>();

  static const String _endpoint = 'http://3.71.89.121/money_collections/api/';

  GetCollectionsModel? getCollectionModel;

  void getCollectionsFromNewToOld() async {
    emit(GetCollectionsLoading());
    try {
      final response = await dio.get('$_endpoint?ordering=-created_at');
      getCollectionModel = GetCollectionsModel.fromJson(response.data);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(GetCollectionsLoadedSuccessful(getCollectionModel!));
    } catch (e) {
      emit(GetCollectionsError(e.toString()));
    }
  }

  Future<GetCollectionsModel?> getCollectionNextPage(String next) async {
    try {
      final response = await dio.get(next);
      getCollectionModel = GetCollectionsModel.fromJson(response.data);
    } catch (e) {
      throw "Error: $e";
    }

    return getCollectionModel;
  }

  void addOtherCollections(GetCollectionsModel getCollectionsModel) {
    getCollectionModel!.results.addAll(getCollectionsModel.results);
    emit(GetCollectionsLoadedSuccessful(getCollectionModel!));
  }
}
