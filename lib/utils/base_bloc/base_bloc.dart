
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eimi_buy_or_sell_app/utils/network/base_response.dart';
import 'package:flutter/foundation.dart';
import 'base_state.dart';
import 'base_event.dart';
import 'base_repository.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final BaseRepository _repository = BaseRepository();

  BaseBloc() : super(Init()) {
    on<BaseApiCall>(_BaseApiCallMethod);
  }

  Future<void> _BaseApiCallMethod(BaseApiCall event,
      Emitter<BaseState> emit) async {
    emit(Loading());
    try {
      BaseResponse baseResponse = await _repository.dummyRepo(event.request);
      print("RESP:: ${baseResponse.toString()}");
      if (baseResponse.error == null) {

        // emit(DataLoaded(event: "SignIn",data: tokenRequestModel.token));
      } else {
        emit(BaseError(baseResponse.error!));
      }
    } catch (error, stack) {
      if (error is DioException) {
        if (kDebugMode) {
          print(stack);
        }
        emit(BaseError("Something went wrong,Please try again later"));
      } else {
        if (kDebugMode) {
          print(error.toString());
        }
        if (kDebugMode) {
          print(stack);
        }
        emit(BaseError(error.toString()));
      }
    }
  }
}
