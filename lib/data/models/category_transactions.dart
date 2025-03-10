// To parse this JSON data, do
//
//     final categoryTransactionsModel = categoryTransactionsModelFromJson(jsonString);

import 'dart:convert';

List<CategoryTransactionsModel> categoryTransactionsFromMap(List<Map<String, dynamic>> transactionMaps) {
  return List<CategoryTransactionsModel>.from(
    transactionMaps.map((map) => CategoryTransactionsModel.fromJson(map)), // Corrigido!
  );
}

List<CategoryTransactionsModel> categoryTransactionsModelFromJson(String str) =>
    List<CategoryTransactionsModel>.from(json.decode(str).map((x) => CategoryTransactionsModel.fromJson(x)));

class CategoryTransactionsModel {
  int? id;
  String? name;
  double? totalAmount;

  CategoryTransactionsModel({
    this.id,
    this.name,
    this.totalAmount,
  });

  factory CategoryTransactionsModel.fromJson(Map<String, dynamic> json) => CategoryTransactionsModel(
        id: json["id"],
        name: json["name"],
        totalAmount: json["totalAmount"],
      );
}
