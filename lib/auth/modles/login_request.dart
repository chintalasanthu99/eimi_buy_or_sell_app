
import 'dart:convert';

LogInRequest logInRequestFromJson(String str) => LogInRequest.fromJson(json.decode(str));

String logInRequestToJson(LogInRequest data) => json.encode(data.toJson());

class LogInRequest {
  String? name;
  String? password;
  String? countryCode;
  String? mobile;
  String? email;
  String? businessName;
  DeviceInfo? deviceInfo;

  LogInRequest({
    this.name,
    this.password,
    this.countryCode,
    this.mobile,
    this.email,
    this.businessName,
    this.deviceInfo,
  });

  factory LogInRequest.fromJson(Map<String, dynamic> json) => LogInRequest(
    name: json["name"],
    password: json["password"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    email: json["email"],
    businessName: json["businessName"],
    deviceInfo: json["deviceInfo"] == null ? null : DeviceInfo.fromJson(json["deviceInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "countryCode": countryCode,
    "mobile": mobile,
    "email": email,
    "businessName": businessName,
    "deviceInfo": deviceInfo?.toJson(),
  };
}

class DeviceInfo {
  String? deviceId;
  String? firebaseToken;
  String? os;
  String? osVersion;
  String? model;
  String? brand;
  int? widthPixels;
  int? heightPixels;

  DeviceInfo({
    this.deviceId,
    this.firebaseToken,
    this.os,
    this.osVersion,
    this.model,
    this.brand,
    this.widthPixels,
    this.heightPixels,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    deviceId: json["deviceId"],
    firebaseToken: json["firebaseToken"],
    os: json["os"],
    osVersion: json["osVersion"],
    model: json["model"],
    brand: json["brand"],
    widthPixels: json["widthPixels"],
    heightPixels: json["heightPixels"],
  );

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "firebaseToken": firebaseToken,
    "os": os,
    "osVersion": osVersion,
    "model": model,
    "brand": brand,
    "widthPixels": widthPixels,
    "heightPixels": heightPixels,
  };
}
