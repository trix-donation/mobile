import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/features/detailed_card_page/data/models/get_selected_collection_model.dart';

part 'get_selected_collection_state.dart';

class GetSelectedCollectionCubit extends Cubit<GetSelectedCollectionState> {
  GetSelectedCollectionCubit() : super(GetSelectedCollectionInitial());

  Dio dio = GetIt.I<Dio>();

  static const String endpoint = 'http://3.71.89.121/money_collections/api';

  void loadInformation(collectionId) async {
    emit(GetSelectedCollectionLoading());

    GetSelectedCollectionModel collection;

    try {
      final response = await dio.get('$endpoint/$collectionId/');
      collection = GetSelectedCollectionModel.fromJson(response.data);
      emit(GetSelectedCollectionLoaded(collection));
    } on DioException catch (e) {
      emit(GetSelectedCollectionError(e.response?.data['detail'] ?? 'Помилка отримання даних'));
    }
  }
}
