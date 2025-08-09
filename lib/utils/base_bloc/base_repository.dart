
import 'dart:async';

import 'package:eimi_buy_or_sell_app/utils/network/base_response.dart';
import 'package:eimi_buy_or_sell_app/utils/network/remote_data_store.dart';

class BaseRepository {
  const BaseRepository();

  Future<BaseResponse> dummyRepo(String request) {
    return RemoteDataStore()
        .executeRequest(REQUEST_TYPE.POST, "");
  }

}
