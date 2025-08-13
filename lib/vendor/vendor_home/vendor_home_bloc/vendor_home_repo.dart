
import 'dart:async';

import 'package:Eimi/utils/network/base_response.dart';
import 'package:Eimi/utils/network/remote_data_store.dart';

class VendorHomeRepository {
  const VendorHomeRepository();

  Future<BaseResponse> dummyRepo(String request) {
    return RemoteDataStore()
        .executeRequest(REQUEST_TYPE.POST, "");
  }

}
