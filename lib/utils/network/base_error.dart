class RestError {
  String? error;
  int? error_code;
  String? error_description;

  static RestError fromJson(Map<String, dynamic> json) {
    RestError response = RestError();
    response.error = json['error'];
    response.error_code = json['error_code'] as int;
    response.error_description = json['error_description'];
    return response;
  }
}
