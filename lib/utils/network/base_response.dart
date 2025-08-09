

class BaseResponse {
  int? status;
  String? statusStr;
  String? error;
  List<dynamic>? errors;
  String? messageCode;
  Map<String, dynamic>? data;
  dynamic serverResponse;
  List<dynamic>? listData = [];
  String? dataString;
  String? message;
  List<dynamic>? messageList;
  int? dataInteger;
  double? dataDouble;
  bool? dataBoolean;
  bool? success;

  static BaseResponse fromJson(Map<String, dynamic> json) {
    BaseResponse response = BaseResponse();
    if(json['status'] != null && json['status'] is String){
      response.statusStr =  json['status']==null?null:json['status'] as String;
    }else{
      response.status =  json['status']==null?0:json['status'] as int;
    }
    response.error =  json['error']==null?null:json['error'] as String;
    response.errors =  json['errors']==null?null:json['errors'] as List<dynamic>;
    response.message =  json['message']==null?null:json['message'] as String;
    response.messageCode =  json['message_code']==null?null:json['message_code'] as String;
    response.success =  json['success']==null?null:json['success'] as bool;

    if (json['data'] is String){
      response.dataString = json['data'] as String;
    } else if (json['data'] is Map<String, dynamic>) {
      response.data = json['data'] as Map<String, dynamic>;
    } else if (json['data'] is List<dynamic>) {
      response.listData = json['data'] as List<dynamic>;
    } else if (json['data'] is bool) {
      response.dataBoolean = json['data'] as bool;
    } else if (json['data'] is int) {
      response.dataInteger = json['data'] as int;
    }else if (json['data'] is double) {
      response.dataDouble = json['data'] as double;
    } else if (json['detail'] is String){
      response.dataString = json['detail'] as String;
    } else if (json['result'] is Map<String, dynamic>) {
      response.data = json['result'] as Map<String, dynamic>;
    } else if (json['result'] is List<dynamic>) {
      response.listData = json['result'] as List<dynamic>;
    } else if (json['message'] is List<dynamic>) {
      response.messageList = json['message'] as List<dynamic>;
    }else if (json['result'] is bool) {
      response.dataBoolean = json['result'] as bool;
    }else if (json['valid'] is bool) {
      response.dataBoolean = json['valid'] as bool;
    }
    else if (json['result'] is int) {
      response.dataInteger = json['result'] as int;
    }else if (json['result'] is double) {
      response.dataDouble = json['result'] as double;
    }  else {
      response.serverResponse = json;
    }
    return response;
  }

  @override
  String toString() {
    return 'BaseResponse{status: $status, error: $error, errors: $errors, messageCode: $messageCode, data: $data, serverResponse: $serverResponse, listData: $listData, dataString: $dataString, message: $message, dataInteger: $dataInteger, dataDouble: $dataDouble, dataBoolean: $dataBoolean, success: $success}';
  }
}
