

import 'package:eimi_buy_or_sell_app/auth/auth_bloc/auth_event.dart';
import 'package:eimi_buy_or_sell_app/auth/modles/login_request.dart';
import 'package:eimi_buy_or_sell_app/utils/network/base_response.dart';
import 'package:eimi_buy_or_sell_app/utils/network/remote_data_store.dart';

class AuthRepository {
  const AuthRepository();

  Future<BaseResponse> login(LogInRequest request) {
    return RemoteDataStore()
        .executeRequest(REQUEST_TYPE.POST, "api/auth/user/login",data: request.toJson());
  }

  Future<BaseResponse> vendorLogin(LogInRequest request) {
    return RemoteDataStore()
        .executeRequest(REQUEST_TYPE.POST, "api/auth/vendor/login",data: request.toJson());
  }

}
