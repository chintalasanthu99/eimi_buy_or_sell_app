
import 'dart:convert';

import 'package:eimi_buy_or_sell_app/utils/common_models/contact_details.dart';

VendorModel vendorModelFromJson(String str) => VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  String? id;
  String? name;
  String? profileImage;
  String? gender;
  String? dateOfBirth;
  ContactDetails? contactDetails;
  dynamic addressDetails;
  String? businessName;
  String? role;
  dynamic deviceInfos;
  String? status;
  int? totalProducts;
  int? approvedProducts;
  int? rejectedProducts;
  String? token;
  String? refreshToken;
  String? createdTimeStamp;
  String? updatedTimeStamp;

  VendorModel({
    this.id,
    this.name,
    this.profileImage,
    this.gender,
    this.dateOfBirth,
    this.contactDetails,
    this.addressDetails,
    this.businessName,
    this.role,
    this.deviceInfos,
    this.status,
    this.totalProducts,
    this.approvedProducts,
    this.rejectedProducts,
    this.token,
    this.refreshToken,
    this.createdTimeStamp,
    this.updatedTimeStamp,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    id: json["id"],
    name: json["name"],
    profileImage: json["profileImage"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    contactDetails: json["contactDetails"] == null ? null : ContactDetails.fromJson(json["contactDetails"]),
    addressDetails: json["addressDetails"],
    businessName: json["businessName"],
    role: json["role"],
    deviceInfos: json["deviceInfos"],
    status: json["status"],
    totalProducts: json["totalProducts"],
    approvedProducts: json["approvedProducts"],
    rejectedProducts: json["rejectedProducts"],
    token: json["token"],
    refreshToken: json["refreshToken"],
    createdTimeStamp: json["createdTimeStamp"],
    updatedTimeStamp: json["updatedTimeStamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profileImage": profileImage,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "contactDetails": contactDetails?.toJson(),
    "addressDetails": addressDetails,
    "businessName": businessName,
    "role": role,
    "deviceInfos": deviceInfos,
    "status": status,
    "totalProducts": totalProducts,
    "approvedProducts": approvedProducts,
    "rejectedProducts": rejectedProducts,
    "token": token,
    "refreshToken": refreshToken,
    "createdTimeStamp": createdTimeStamp,
    "updatedTimeStamp": updatedTimeStamp,
  };
}

