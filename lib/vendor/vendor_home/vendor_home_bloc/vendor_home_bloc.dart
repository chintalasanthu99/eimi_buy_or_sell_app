
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_event.dart' hide BaseEvent;
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/network/base_response.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_event.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_repo.dart';
import 'package:flutter/foundation.dart';
import '../../../user/home/home_bloc/home_event.dart';

class VendorHomeBloc extends Bloc<VendorHomeEvent, BaseState> {
  final VendorHomeRepository _repository = VendorHomeRepository();

  VendorHomeBloc() : super(Init()) {
    on<VendorStatsEvent>(_BaseApiCallMethod);
  }

  Future<void> _BaseApiCallMethod(VendorStatsEvent event,
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
