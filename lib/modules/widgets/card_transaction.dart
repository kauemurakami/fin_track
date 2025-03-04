import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/utils/functions/format_date.dart';
import 'package:flutter/material.dart';

class CardTransactionWidget extends StatelessWidget {
  const CardTransactionWidget({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${transaction.title}',
                  style: TextTheme.of(context).titleMedium,
                ),
                Text(
                  formatDate(transaction.date!),
                  style: TextTheme.of(context).labelSmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4.0,
                  children: [
                    transaction.type == TransactionType.expense
                        ? Icon(Icons.trending_down, color: Colors.red, size: 20.0)
                        : Icon(Icons.trending_up, color: Colors.green, size: 20.0),
                    Text(transaction.amount!.toStringAsFixed(2)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color:
                        transaction.type == TransactionType.income ? Colors.green.shade100 : Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    '${transaction.type == TransactionType.income ? 'Income' : transaction.category?.name}',
                    style: TextTheme.of(context).labelMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
