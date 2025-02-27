import 'dart:convert';

import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/category.dart';

List<TransactionModel> transactionFromJson(String str) => List<TransactionModel>.from(
      json.decode(str).map(
            (x) => TransactionModel.fromJson(x),
          ),
    );

String transactionToJson(List<TransactionModel> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class TransactionModel {
  String? id, title;
  int? amount;
  DateTime? date;
  TransactionType? type;
  CategoryModel? category;

  TransactionModel({
    this.id,
    this.title,
    this.amount,
    this.date,
    this.type,
    this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        type: json["type"] == TransactionType.expense.type ? TransactionType.expense : TransactionType.income,
        category: CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date?.toIso8601String(),
        "type": type == TransactionType.expense ? TransactionType.expense.type : TransactionType.income.type,
        "category": category?.toJson(),
      };
}
