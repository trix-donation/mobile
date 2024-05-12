import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/features/search/data/models/foundedCollectionsModel.dart';

import '../../data/models/enum_filter_query.dart';

part 'search_collection_state.dart';

class SearchCollectionCubit extends Cubit<SearchCollectionState> {
  SearchCollectionCubit() : super(SearchCollectionInitial());

  Dio dio = GetIt.I<Dio>();

  static const String _endpoint = 'http://3.71.89.121/money_collections/api/';
  static const String _fromNewToOld = '$_endpoint?ordering=-created_at';
  static const String _fromOldToNew = '$_endpoint?ordering=created_at';
  static const String _daysPassed30 = '$_endpoint?param=t';
  static const String _toBiggerGoalAmound = '$_endpoint?ordering=goal_amount';
  static const String _toSmallerGoalAmound = '$_endpoint?ordering=-goal_amount';

  void searchCollections(String query) async {
    emit(SearchCollectionLoading());

    if (query.isEmpty) {
      emit(SearchCollectionLoadedNothingFound());
      return;
    }

    try {
      final response = await dio.get('$_endpoint?search=$query');
      final foundedCollectionsModel = FoundedCollectionsModel.fromJson(response.data);

      if (response.data['count'] == 0) {
        emit(SearchCollectionLoadedNothingFound());
        return;
      }

      emit(SearchCollectionLoadedSuccessful(foundedCollectionsModel));
    } catch (e) {
      emit(SearchCollectionError(e.toString()));
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(SearchCollectionLoadedNothingFound());
      });
    }
  }

  void filterCollections(FilterQuery filterQuery, String? query) async {
    emit(SearchCollectionLoading());
    String finalEndpoint = "";
    switch (filterQuery) {
      case FilterQuery.fromNewToOld:
        finalEndpoint = _fromNewToOld;
        break;
      case FilterQuery.fromOldToNew:
        finalEndpoint = _fromOldToNew;
        break;
      case FilterQuery.daysPassed30:
        finalEndpoint = _daysPassed30;
        break;
      case FilterQuery.toBiggerGoalAmount:
        finalEndpoint = _toBiggerGoalAmound;
        break;
      case FilterQuery.toSmallerGoalAmount:
        finalEndpoint = _toSmallerGoalAmound;
        break;
    }

    if (query != null && query.isNotEmpty) {
      finalEndpoint += '&search=$query';
    }

    try {
      final response = await dio.get(finalEndpoint);

      if (response.data['count'] == 0) {
        emit(SearchCollectionLoadedNothingFound());
        return;
      }
      final foundedCollectionsModel = FoundedCollectionsModel.fromJson(response.data);
      emit(SearchCollectionLoadedSuccessful(foundedCollectionsModel));
    } catch (e) {
      emit(SearchCollectionError(e.toString()));
    }
  }

  Future<FoundedCollectionsModel?> getNextPage(String? next) async {
    if (next == null || next.isEmpty) {
      return null;
    }

    try {
      final response = await dio.get(next);
      return FoundedCollectionsModel.fromJson(response.data);
    } catch (e) {
      throw "Error: $e";
    }
  }
}
