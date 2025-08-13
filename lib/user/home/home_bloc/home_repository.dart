

import 'package:Eimi/user/home/models/category_filter_request.dart';
import 'package:Eimi/utils/network/base_response.dart';
import 'package:Eimi/utils/network/remote_data_store.dart';

class HomeRepository {
  const HomeRepository();

  Future<BaseResponse> categoryFilter(CategoryFilterRequest request) {
    return RemoteDataStore()
        .executeRequest(REQUEST_TYPE.PUT, "api/category/all",data: request.toJson());
  }

}
