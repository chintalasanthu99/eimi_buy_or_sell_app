import 'package:dio/dio.dart';
import 'package:eimi_buy_or_sell_app/auth/auth_bloc/auth_event.dart';
import 'package:eimi_buy_or_sell_app/auth/auth_bloc/auth_repository.dart';
import 'package:eimi_buy_or_sell_app/user/models/user_model.dart';
import 'package:eimi_buy_or_sell_app/utils/AppDataHelper.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/network/DataModule.dart';
import 'package:eimi_buy_or_sell_app/utils/network/base_response.dart';
import 'package:eimi_buy_or_sell_app/utils/shared_pref/shared_preference_constants.dart';
import 'package:eimi_buy_or_sell_app/utils/shared_pref/shared_preference_helper.dart';
import 'package:eimi_buy_or_sell_app/vendor/models/vendor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<BaseEvent, BaseState> {
  final AuthRepository _repository = AuthRepository();

  AuthBloc() : super(Init()) {
    on<LogInEvent>(_login);
    on<VendorLogInEvent>(_vendorLogin);
  }

  Future<void> _login(LogInEvent event,
      Emitter<BaseState> emit) async {
    emit(Loading());
    try {
      BaseResponse baseResponse = await _repository.login(event.request);
      if (baseResponse.error == null) {

        if(baseResponse.status!=null && (baseResponse.status == 200 || baseResponse.status == 201)){
          User response = User.fromJson(baseResponse.data!);
          saveUserDetails(response);
          emit(DataLoaded(event: "LogInEvent",data: response));
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

  Future<void> _vendorLogin(VendorLogInEvent event,
      Emitter<BaseState> emit) async {
    emit(Loading());
    try {
      BaseResponse baseResponse = await _repository.vendorLogin(event.request);
      if (baseResponse.error == null) {

        if(baseResponse.status!=null && (baseResponse.status == 200 || baseResponse.status == 201)){
          VendorModel response = VendorModel.fromJson(baseResponse.data!);
          saveVendorDetails(response);
          emit(DataLoaded(event: "VendorLogInEvent",data: response));
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


  Future<void> saveUserDetails(User response) async {
    await DataModule().init();
    await SharedPreferenceHelper.saveString(Preferences.accessToken, response.token??"");
    await SharedPreferenceHelper.saveString(Preferences.refreshToken, response.refreshToken??"");
    // await SharedPreferenceHelper.saveString(Preferences.email, response.contactDetails!=null && response.contactDetails?.email != null ? response.contactDetails?.email! : "");
    await SharedPreferenceHelper.saveString(Preferences.user_name, response.username??"");
    await SharedPreferenceHelper.saveString(Preferences.profileImage, response.profileImage??"");
    // await SharedPreferenceHelper.saveString(Preferences.mobile,  response.contactDetails!=null && response.contactDetails?.mobile != null ? response.contactDetails?.mobile : "");
    await SharedPreferenceHelper.saveString(Preferences.gender, response.gender != null ? response.gender! : "");
    // await SharedPreferenceHelper.saveInt(Preferences.app_user_id, response.id != null ? response.id! : 0);
    // await SharedPreferenceHelper.saveBool(Preferences.isKycVerified, response.isKycVerified!);
    await SharedPreferenceHelper.saveString(Preferences.role, response.role??"");
    await SharedPreferenceHelper.saveBool(Preferences.isLoggedIn, true);
    AppDataHelper.init();
    // AppDataHelper.mobile = response.phoneNumber??"";
    // AppDataHelper.email = response.email??"";
    AppDataHelper.userName = response.username??"";
    AppDataHelper.profileImage = response.profileImage??"";
    AppDataHelper.accessToken = response.token??"";
    AppDataHelper.refreshToken = response.refreshToken??"";
    // AppDataHelper.userResponse = response;
    AppDataHelper.isLoggedIn = true;
    // await syncData();
  }

  Future<void> saveVendorDetails(VendorModel response) async {
    await DataModule().init();
    await SharedPreferenceHelper.saveString(Preferences.accessToken, response.token??"");
    await SharedPreferenceHelper.saveString(Preferences.refreshToken, response.refreshToken??"");
    // await SharedPreferenceHelper.saveString(Preferences.email, response.contactDetails!=null && response.contactDetails?.email != null ? response.contactDetails?.email! : "");
    await SharedPreferenceHelper.saveString(Preferences.user_name, response.name??"");
    await SharedPreferenceHelper.saveString(Preferences.profileImage, response.profileImage??"");
    // await SharedPreferenceHelper.saveString(Preferences.mobile,  response.contactDetails!=null && response.contactDetails?.mobile != null ? response.contactDetails?.mobile : "");
    await SharedPreferenceHelper.saveString(Preferences.gender, response.gender != null ? response.gender! : "");
    // await SharedPreferenceHelper.saveInt(Preferences.app_user_id, response.id != null ? response.id! : 0);
    await SharedPreferenceHelper.saveString(Preferences.role, response.role??"");
    await SharedPreferenceHelper.saveBool(Preferences.isLoggedIn, true);
    AppDataHelper.init();
    // AppDataHelper.mobile = response.phoneNumber??"";
    // AppDataHelper.email = response.email??"";
    AppDataHelper.userName = response.name??"";
    AppDataHelper.profileImage = response.profileImage??"";
    AppDataHelper.accessToken = response.token??"";
    AppDataHelper.refreshToken = response.refreshToken??"";
    // AppDataHelper.userResponse = response;
    AppDataHelper.isLoggedIn = true;
    // await syncData();
  }
}