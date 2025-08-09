import 'dart:convert';

ProductModel productFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final List<String>? images;
  final String? categoryId;
  final String? categoryName;
  final String? subCategoryId;
  final String? subCategoryName;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? userId;
  final String? userPhone;
  final bool? isNegotiable;
  final String? condition; // Example: "New", "Used"
  final bool? isFeatured;
  final String? status; // Example: "active", "pending", "sold"
  final String? postedAt;
  final String? updatedAt;
  final int? views;
  final int? likes;
  final Map<String, dynamic>? attributes;

  ProductModel({
     this.id,
     this.title,
     this.description,
     this.price,
     this.images,
     this.categoryId,
     this.categoryName,
     this.subCategoryId,
     this.subCategoryName,
     this.location,
     this.latitude,
     this.longitude,
     this.userId,
     this.userPhone,
     this.isNegotiable,
     this.condition,
     this.isFeatured,
     this.status,
     this.postedAt,
     this.updatedAt,
     this.views,
     this.likes,
     this.attributes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? '',
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    price: (json["price"] ?? 0).toDouble(),
    images: List<String>.from(json["images"] ?? []),
    categoryId: json["categoryId"] ?? '',
    categoryName: json["categoryName"] ?? '',
    subCategoryName: json["subCategoryName"] ?? '',
    subCategoryId: json["subCategoryId"] ?? '',
    location: json["location"] ?? '',
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    userId: json["userId"] ?? '',
    userPhone: json["userPhone"] ?? '',
    isNegotiable: json["isNegotiable"] ?? false,
    condition: json["condition"] ?? 'Unknown',
    isFeatured: json["isFeatured"] ?? false,
    status: json["status"] ?? 'active',
    postedAt: json["postedAt"] ,
    updatedAt: json["updatedAt"],
    views: json["views"] ?? 0,
    likes: json["likes"] ?? 0,
    attributes: json["attributes"] ?? {},
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "images": images,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "subCategoryName": subCategoryName,
    "subCategoryId": subCategoryId,
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
    "userId": userId,
    "userPhone": userPhone,
    "isNegotiable": isNegotiable,
    "condition": condition,
    "isFeatured": isFeatured,
    "status": status,
    "postedAt": postedAt,
    "updatedAt": updatedAt,
    "views": views,
    "likes": likes,
    "attributes": attributes,
  };
}
