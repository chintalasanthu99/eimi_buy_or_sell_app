// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) => CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) => json.encode(data.toJson());

class CategoryListResponse {
  String? id;
  String? title;
  dynamic image;
  String? description;
  int? sortOrder;
  DateTime? createdTimeStamp;
  DateTime? updatedTimeStamp;
  dynamic parentId;
  bool? active;
  dynamic createdBy;
  Translations? translations;
  bool? featured;

  CategoryListResponse({
    this.id,
    this.title,
    this.image,
    this.description,
    this.sortOrder,
    this.createdTimeStamp,
    this.updatedTimeStamp,
    this.parentId,
    this.active,
    this.createdBy,
    this.translations,
    this.featured,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) => CategoryListResponse(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    sortOrder: json["sortOrder"],
    createdTimeStamp: json["createdTimeStamp"] == null ? null : DateTime.parse(json["createdTimeStamp"]),
    updatedTimeStamp: json["updatedTimeStamp"] == null ? null : DateTime.parse(json["updatedTimeStamp"]),
    parentId: json["parentId"],
    active: json["active"],
    createdBy: json["createdBy"],
    translations: json["translations"] == null ? null : Translations.fromJson(json["translations"]),
    featured: json["featured"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "sortOrder": sortOrder,
    "createdTimeStamp": createdTimeStamp?.toIso8601String(),
    "updatedTimeStamp": updatedTimeStamp?.toIso8601String(),
    "parentId": parentId,
    "active": active,
    "createdBy": createdBy,
    "translations": translations?.toJson(),
    "featured": featured,
  };
}

class Translations {
  String? en;
  String? hi;

  Translations({
    this.en,
    this.hi,
  });

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
    en: json["en"],
    hi: json["hi"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "hi": hi,
  };
}
