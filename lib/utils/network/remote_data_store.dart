import 'package:flutter/foundation.dart';

import 'base_response.dart';
import 'network_core.dart';
enum REQUEST_TYPE { POST, GET, PUT, DELETE,PATCH }

class RemoteDataStore {
  NetworkCommon networkCommon = new NetworkCommon();

  static final RemoteDataStore _singleton = new RemoteDataStore._internal();

  factory RemoteDataStore() {
    return _singleton;
  }

  RemoteDataStore._internal();

  Future<BaseResponse> executeRequest<T>(REQUEST_TYPE request_type, String url,
      {data, Map<String, dynamic>? queryParameters, bool isTrack = false,String? moduleName}) async {
    try {
      if (request_type == REQUEST_TYPE.POST) {
        return await networkCommon.executeRequest("POST",url, queryParameters: queryParameters, data: data,moduleName: moduleName);
      } else if (request_type == REQUEST_TYPE.GET) {
        return await networkCommon.executeRequest("GET",url, queryParameters: queryParameters, data: data,moduleName: moduleName);
      } else if (request_type == REQUEST_TYPE.PUT) {
        return await networkCommon.executeRequest("PUT",url, queryParameters: queryParameters, data: data,moduleName: moduleName);
      } else if (request_type == REQUEST_TYPE.PATCH) {
        return await networkCommon.executeRequest("PATCH",url, queryParameters: queryParameters, data: data,moduleName: moduleName);
      } else if (request_type == REQUEST_TYPE.DELETE) {
        return await networkCommon.executeRequest("DELETE",url, queryParameters: queryParameters, data: data,moduleName: moduleName);
      } else {
        throw Exception("Invalid Type");
      }
    } catch (error, stack) {
      if (kDebugMode) {
        print (error);
      }
      if (kDebugMode) {
        print (stack);
      }
      rethrow;
    }
  }
}