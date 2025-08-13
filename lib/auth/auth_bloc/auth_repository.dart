

import 'package:Eimi/auth/auth_bloc/auth_event.dart';
import 'package:Eimi/auth/modles/login_request.dart';
import 'package:Eimi/utils/network/base_response.dart';
import 'package:Eimi/utils/network/remote_data_store.dart';

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
