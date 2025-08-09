import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  final String? id;
  final String? title;
  final String? image;
  final String? description;
  final bool isFeatured;
  final int sortOrder;
  final String? createdAt;
  final String? updatedAt;
  final String? parentId;
  final bool isActive;
  final Map<String, String>? translations;

  Category({
    this.id,
    this.title,
    this.image,
    this.description,
    this.isFeatured = false,
    this.sortOrder = 0,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.isActive = true,
    this.translations,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    image: json["image"],
    description: json["description"],
    isFeatured: json["isFeatured"] ?? false,
    sortOrder: json["sortOrder"] ?? 0,
    createdAt:
    json["createdAt"],
    updatedAt:
    json["updatedAt"],
    parentId: json["parentId"],
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
    "isActive": isActive,
    "translations": translations,
  };
}
