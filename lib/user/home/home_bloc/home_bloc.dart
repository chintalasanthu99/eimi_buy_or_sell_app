import 'package:dio/dio.dart';
import 'package:Eimi/user/home/home_bloc/home_event.dart';
import 'package:Eimi/user/home/home_bloc/home_repository.dart';
import 'package:Eimi/user/home/models/category_list_response.dart';
import 'package:Eimi/utils/base_bloc/base_state.dart';
import 'package:Eimi/utils/network/base_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserHomeBloc extends Bloc<BaseEvent, BaseState> {
  final HomeRepository _repository = HomeRepository();

  UserHomeBloc() : super(Init()) {
    on<CategoryFilterEvent>(_categoryFilter);
  }

  Future<void> _categoryFilter(CategoryFilterEvent event,
      Emitter<BaseState> emit) async {
    emit(Loading());
    try {
      BaseResponse baseResponse = await _repository.categoryFilter(event.request);
      if (baseResponse.error == null) {
        if(baseResponse.status!=null && (baseResponse.status == 200 || baseResponse.status == 201)){
          List<CategoryListResponse> response = baseResponse.listData!.map((i) => CategoryListResponse.fromJson(i)).toList();
          emit(DataLoaded(event: "CategoryFilterEvent",data: response));
        }else{
          emit(BaseError(baseResponse.error!));
        }
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