import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));
String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  final String? id;
  final String? title;
  final String? image;
  final String? description;
  final bool isFeatured;
  final int sortOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? parentId;
  // final String? categoryId;
  // final String? categoryName;
  final Map<String, String>? category;
  final bool isActive;
  final Map<String, String>? translations;

  SubCategory({
    this.id,
    this.title,
    this.image,
    this.description,
    this.isFeatured = false,
    this.sortOrder = 0,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.category,
    // this.categoryName,
    this.isActive = true,
    this.translations,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    image: json["image"],
    description: json["description"],
    isFeatured: json["isFeatured"] ?? false,
    sortOrder: json["sortOrder"] ?? 0,
    createdAt: json["createdAt"] ,
    updatedAt: json["updatedAt"],
    parentId: json["parentId"],
    // categoryId: json["categoryId"],
    // categoryName: json["categoryName"],
    category: json["category"] != null
        ? Map<String, String>.from(json["category"])
        : null,
    isActive: json["isActive"] ?? true,
    translations: json["translations"] != null
        ? Map<String, String>.from(json["translations"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "isFeatured": isFeatured,
    "sortOrder": sortOrder,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "parentId": parentId,
    "category": category,
    // "categoryName": categoryName,
    "isActive": isActive,
    "translations": translations,
  };
}
