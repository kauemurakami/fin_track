import 'dart:convert';

import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/category.dart';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(
      json.decode(str).map(
            (x) => Transaction.fromJson(x),
          ),
    );

String transactionToJson(List<Transaction> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class Transaction {
  String? id, title;
  int? amount;
  DateTime? date;
  TransactionType? type;
  Category? category;

  Transaction({
    this.id,
    this.title,
    this.amount,
    this.date,
    this.type,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        type: json["type"] == TransactionType.expense.type ? TransactionType.expense : TransactionType.income,
        category: Category.fromJson(json["category"]),
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
