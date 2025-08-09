// To parse this JSON data, do
//
//     final fieldConfig = fieldConfigFromJson(jsonString);

import 'dart:convert';

FieldConfig fieldConfigFromJson(String str) => FieldConfig.fromJson(json.decode(str));

String fieldConfigToJson(FieldConfig data) => json.encode(data.toJson());

class FieldConfig {
  final Map<String, String>? category;
  final Map<String, String>? subCategory;
  String? key;
  String? label;
  String? type;
  bool? required;
  bool? active;
  List<String>? options;
  int? sortOrder;

  FieldConfig({
    this.category,
    this.subCategory,
    this.key,
    this.label,
    this.type,
    this.required,
    this.active,
    this.options,
    this.sortOrder,
  });

  factory FieldConfig.fromJson(Map<String, dynamic> json) => FieldConfig(
    category: json["category"] != null
        ? Map<String, String>.from(json["category"])
        : null,
    subCategory: json["subCategory"] != null
        ? Map<String, String>.from(json["subCategory"])
        : null,
    label: json["label"],
    key: json["key"]!=null?json["key"]:null,
    type: json["type"],
    required: json["required"],
    active: json["active"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "subCategory": subCategory,
    "key": key,
    "label": label,
    "type": type,
    "required": required,
    "active": active,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "sortOrder": sortOrder,
  };
}
