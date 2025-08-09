// To parse this JSON data, do
//
//     final categoryFilterRequest = categoryFilterRequestFromJson(jsonString);

import 'dart:convert';

CategoryFilterRequest categoryFilterRequestFromJson(String str) => CategoryFilterRequest.fromJson(json.decode(str));

String categoryFilterRequestToJson(CategoryFilterRequest data) => json.encode(data.toJson());

class CategoryFilterRequest {
  String? searchText;
  int? page;
  int? size;
  String? sortBy;
  String? sortOrder;
  bool? isActive;
  String? startDate;
  String? endDate;
  List<String>? categoryIds;

  CategoryFilterRequest({
    this.searchText,
    this.page,
    this.size,
    this.sortBy,
    this.sortOrder,
    this.isActive,
    this.startDate,
    this.endDate,
    this.categoryIds,
  });

  factory CategoryFilterRequest.fromJson(Map<String, dynamic> json) => CategoryFilterRequest(
    searchText: json["searchText"],
    page: json["page"],
    size: json["size"],
    sortBy: json["sortBy"],
    sortOrder: json["sortOrder"],
    isActive: json["isActive"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    categoryIds: json["categoryIds"] == null ? [] : List<String>.from(json["categoryIds"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "searchText": searchText,
    "page": page,
    "size": size,
    "sortBy": sortBy,
    "sortOrder": sortOrder,
    "isActive": isActive,
    "startDate": startDate,
    "endDate": endDate,
    "categoryIds": categoryIds == null ? [] : List<dynamic>.from(categoryIds!.map((x) => x)),
  };
}
