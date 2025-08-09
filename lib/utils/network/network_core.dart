import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eimi_buy_or_sell_app/utils/AppDataHelper.dart';
import 'package:eimi_buy_or_sell_app/utils/app_log.dart';
import 'package:eimi_buy_or_sell_app/utils/app_strings.dart';
import 'package:eimi_buy_or_sell_app/utils/flavour_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../shared_pref/shared_preference_constants.dart';
import '../shared_pref/shared_preference_helper.dart';
import 'base_response.dart';


class NetworkCommon {
  static final NetworkCommon _singleton = NetworkCommon._internal();
  factory NetworkCommon() {
    return _singleton;
  }

  NetworkCommon._internal();
  final JsonDecoder _decoder = JsonDecoder();


    Future<BaseResponse> executeRequest(String method, String url,
      {data, Map<String, dynamic>? queryParameters, Map<String, String>? headers,String? moduleName}) async {

      headers ??= {};
    String? accessToken = await SharedPreferenceHelper.getString(Preferences.accessToken);
    if(accessToken != null) {

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';


    }
      String baseUrl=FlavorConfig.instance.appName=="Dev"?AppStrings.devURL:AppStrings.prodURL;
      _dio.options.baseUrl = baseUrl;

    try {
      final options = Options(
        method: method,
        headers: _dio.options.headers,
      );
      Response response = await _dio.request(
          url, queryParameters: queryParameters, data: data, options: options);
      var results = _decodeResp(response);
      if (kDebugMode) {
        print("HELLO: ${results.toString()} ");
      }
      if(results is List<dynamic>){
        Map<String,dynamic> res = {};
        res.putIfAbsent("data", () => results);
        res.putIfAbsent('status', () => response.statusCode);
        results = res;
      }
      if(results is Map<String,dynamic>){
        results.putIfAbsent('status', () => response.statusCode);
      }
      BaseResponse baseResponse = BaseResponse.fromJson(results);
      baseResponse.status = response.statusCode;
      return baseResponse;
    } catch (error) {
      return await handleError(error);
    }
  }

    dynamic _decodeResp(d) {
    var response = d as Response;
    final statusCode = response.statusCode;
    final dynamic jsonBody = response.data;
    if (statusCode! >= 500 || jsonBody == null) {
      return null;
    }
    if (jsonBody is String) {
      return _decoder.convert(jsonBody);
    } else {
      return jsonBody;
    }
  }

  final BaseOptions baseOptions = BaseOptions(
      connectTimeout: Duration(milliseconds: 60000),
      receiveTimeout: Duration(milliseconds: 60000),
      baseUrl:FlavorConfig.instance.baseUrl,
      validateStatus: (code) {
        return code! < 500 && code != 401 && code != 403 && code != 503;
      }
  );

  Dio get _dio {
    Dio dio = Dio();
    dio.options = baseOptions;
    dio.interceptors..add(InterceptorsWrapper(
        onRequest: (options, handler)  {
          _preRequest(options, handler);
        },
        onResponse: (response, handler) {
          _responseReceived(response, handler);
        },
        onError:(error, handler) {
          _errorReceived(error, handler);
        }
    ))..add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }


  void _preRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if(options.queryParameters!=null && options.queryParameters.isNotEmpty){
      AppLog.d("Pre request:${options.method} : ${options.baseUrl}${options.path}${options.queryParameters}");
    } else {
      AppLog.d("Pre request:${options.method} : ${options.baseUrl}${options.path}");
    }

    AppLog.d("Pre request:${JsonEncoder().convert(options.data).replaceAll("\\", "")}");
    AppLog.d("OPTIONS header:${options.headers.toString()}");

    return handler.next(options);
  }

  void _responseReceived(Response response, ResponseInterceptorHandler handler) {
    AppLog.d("Response From: ${response.statusCode} : ${response.requestOptions.method} : "
        "${response.requestOptions.baseUrl}${response.requestOptions.path}");
    AppLog.d("Response :${response.toString()}");

    handler.next(response);
  }

  void _errorReceived(DioException error, ErrorInterceptorHandler handler) {
    AppLog.d("Response :${error.toString()}");
    if(error.response!.statusCode==401){

      refreshToken().then((value) async {
        String? accessToken = await SharedPreferenceHelper.getString(Preferences.accessToken);
        var jRequestOptions = error.requestOptions;
        jRequestOptions.headers.remove("Authorization");
        jRequestOptions.headers.putIfAbsent("Authorization", () => "Bearer $accessToken");
        final options = Options(
          method: jRequestOptions.method,
          headers: jRequestOptions.headers,
        );

      });
    }
    return  handler.next(error);
  }

  Future<String?> refreshToken() async {
    const url = 'api/v1/token/refresh/';
    var headers = {'Content-Type': 'application/json'};
    String? refreshToken = await SharedPreferenceHelper.getString(Preferences.refreshToken);
    final response = await _dio.post(
        url, data: {
      "refresh":refreshToken
    },
        options: Options(headers:headers)
    );
    if (response.statusCode == 200) {
      String newToken = response.data["access"];
      SharedPreferenceHelper.saveString(Preferences.accessToken, newToken);
      AppDataHelper.accessToken = newToken;
      return newToken;
    }
    return null;
  }

  Future<BaseResponse> handleError(error) async {
    if (error is DioException) {
      if(error.response == null) {
        BaseResponse baseResponse = BaseResponse();
        baseResponse.error = "Please check your internet connectivity";
        return baseResponse;
      }
      debugPrint("ERROROROR: ${error.response.toString()}");
      if (error.response!.statusCode == 401) {
        String? token = await refreshToken();
        var jRequestOptions = error.requestOptions;
        jRequestOptions.headers.remove("Authorization");
        jRequestOptions.headers.putIfAbsent(
            "Authorization", () => "Bearer $token" );
        final options = Options(
          method: jRequestOptions.method,
          headers: jRequestOptions.headers,
        );
        Response response = await _dio.request(
            error.requestOptions.path, options: options,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
        var results = _decodeResp(response);
        if(results is List<dynamic>){
          Map<String,dynamic> res = {};
          res.putIfAbsent("data", () => results);
          results = res;
        }

        return BaseResponse.fromJson(results);

      } else if(error.response!.statusCode == 503){
        var response = error.response as Response;
        final statusCode = response.statusCode;
        final dynamic jsonBody = response.data;
        if (jsonBody is String) {
          return BaseResponse.fromJson(_decoder.convert(jsonBody));
        } else {
          return BaseResponse.fromJson(jsonBody);
        }
      } else {
        BaseResponse baseResponse = BaseResponse();
        baseResponse.error="Something went wrong, Please try again later";
        return baseResponse;
      }
    } else {
      throw error;
    }
  }
}
