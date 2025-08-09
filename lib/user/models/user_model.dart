// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:eimi_buy_or_sell_app/utils/common_models/contact_details.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? username;
  String? profileImage;
  String? gender;
  String? dateOfBirth;
  ContactDetails? contactDetails;
  dynamic addressDetails;
  dynamic deviceInfos;
  String? role;
  String? status;
  String? lostActiveTime;
  int? reviewsCount;
  int? favoritesCount;
  int? totalBooking;
  int? completedBooking;
  String? token;
  String? refreshToken;
  String? createdTimeStamp;
  String? updatedTimeStamp;

  User({
    this.id,
    this.username,
    this.profileImage,
    this.gender,
    this.dateOfBirth,
    this.contactDetails,
    this.addressDetails,
    this.deviceInfos,
    this.role,
    this.status,
    this.lostActiveTime,
    this.reviewsCount,
    this.favoritesCount,
    this.totalBooking,
    this.completedBooking,
    this.token,
    this.refreshToken,
    this.createdTimeStamp,
    this.updatedTimeStamp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    profileImage: json["profileImage"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"],
    contactDetails: json["contactDetails"] == null ? null : ContactDetails.fromJson(json["contactDetails"]),
    addressDetails: json["addressDetails"],
    deviceInfos: json["deviceInfos"],
    role: json["role"],
    status: json["status"],
    lostActiveTime: json["lostActiveTime"],
    reviewsCount: json["reviewsCount"],
    favoritesCount: json["favoritesCount"],
    totalBooking: json["totalBooking"],
    completedBooking: json["completedBooking"],
    token: json["token"],
    refreshToken: json["refreshToken"],
    createdTimeStamp: json["createdTimeStamp"],
    updatedTimeStamp: json["updatedTimeStamp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "profileImage": profileImage,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "contactDetails": contactDetails?.toJson(),
    "addressDetails": addressDetails,
    "deviceInfos": deviceInfos,
    "role": role,
    "status": status,
    "lostActiveTime": lostActiveTime,
    "reviewsCount": reviewsCount,
    "favoritesCount": favoritesCount,
    "totalBooking": totalBooking,
    "completedBooking": completedBooking,
    "token": token,
    "refreshToken": refreshToken,
    "createdTimeStamp": createdTimeStamp,
    "updatedTimeStamp": updatedTimeStamp,
  };
}


