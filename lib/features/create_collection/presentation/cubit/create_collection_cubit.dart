import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:trix_donation/features/spilnota/presentation/cubit/users_organizations_cubit.dart';

part 'create_collection_state.dart';

class CreateCollectionCubit extends Cubit<CreateCollectionState> {
  CreateCollectionCubit() : super(CreateCollectionInitial());

  Dio dio = GetIt.I();

  final String _endpoint = 'http://3.71.89.121/money_collections/api/organizations';

  final String _endOfEndpoint = 'money_collections/';

  void createCollection({
    required File image,
    required String goal_title,
    required String description,
    required String goal_amount,
    required String monobank_jar_link,
    required String monobank_jar_number,
    String? paypal_email,
    String? bitcoin_wallet_address,
    String? ethereum_wallet_address,
    String? usdt_wallet_address,
  }) async {
    emit(CreateCollectionLoading());

    UsersOrganizationsCubit usersOrganizationsCubit = UsersOrganizationsCubit();
    int? organizationID = await usersOrganizationsCubit.getOganizationId();

    if (organizationID == null) {
      emit(CreateCollectionError('Помилка'));
      return;
    }

    FormData dataForm = FormData.fromMap({
      'preview': await MultipartFile.fromFile(image.path),
      'goal_title': goal_title,
      'description': description,
      'goal_amount': int.parse(goal_amount),
      'requisites.monobank_jar_link': monobank_jar_link,
      'requisites.monobank_jar_number': monobank_jar_number,
    });

    if (paypal_email != null) {
      dataForm.fields.add(MapEntry('requisites.paypal_email', paypal_email));
    }

    if (bitcoin_wallet_address != null) {
      dataForm.fields.add(MapEntry('requisites.bitcoin_wallet_address', bitcoin_wallet_address));
    }

    if (ethereum_wallet_address != null) {
      dataForm.fields.add(MapEntry('requisites.ethereum_wallet_address', ethereum_wallet_address));
    }

    if (usdt_wallet_address != null) {
      dataForm.fields.add(MapEntry('requisites.usdt_wallet_address', usdt_wallet_address));
    }

    try {
      final response = await dio.post(
        "$_endpoint/$organizationID/$_endOfEndpoint",
        data: dataForm,
      );
      if (response.statusCode == 201) {
        emit(CreateCollectionCreated());
      }
    } on DioException catch (e) {
      emit(CreateCollectionError(e.response?.data['message'] ?? 'Помилка'));
    }
  }
}
