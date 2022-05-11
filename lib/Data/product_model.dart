// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
import 'dart:convert';

List<ProductModel> productFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.createdAt,
    required this.name,
    required this.imagen,
    required this.description,
    required this.unitPrice,
    required this.quantity,
    required this.category,
    required this.url,
    required this.id,
  });

  final DateTime? createdAt;
  final String name;
  final String imagen;
  final String description;
  final int unitPrice;
  final int quantity;
  final String category;
  final String url;
  final String id;

  ProductModel copyWith({
    DateTime? createdAt,
    String? name,
    String? imagen,
    String? description,
    int? unitPrice,
    int? quantity,
    String? category,
    String? url,
    String? id,
  }) =>
      ProductModel(
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        imagen: imagen ?? this.imagen,
        description: description ?? this.description,
        unitPrice: unitPrice ?? this.unitPrice,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        url: url ?? this.url,
        id: id ?? this.id,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        name: json["name"],
        imagen: json["imagen"],
        description: json["description"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        category: json["category"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "name": name,
        "imagen": imagen,
        "description": description,
        "unit_price": unitPrice,
        "quantity": quantity,
        "category": category,
        "url": url,
        "id": id,
      };
}
